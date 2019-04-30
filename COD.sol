contract Cod{
    address payable public  owner;
    address payable public  shipper;
    address payable public  buyer;
     uint public time = 0 minutes;
     uint public idPackage=0;
    uint public price;
    mapping(uint => Package) public Packages;
    mapping(address => uint) public  Balances;
    
    constructor()public{
        owner = msg.sender;
    }
       modifier noOwner{
       require(msg.sender != owner);
       _;
   }
   modifier onlyOwner{
       require(owner == msg.sender);
       _;
   }
     struct Package{
       string _name;
       uint _price;
       address _buyer;
        uint _time;
   }
    function AddPackage(string memory _name, uint _price, address payable _buyer, uint _time) onlyOwner public{
       idPackage += 1;
       price = _price;
       buyer = _buyer;
       time = _time;
       Packages[idPackage] = Package(_name, price, buyer, time);
   }
   function ApplyDeliver(uint _id) public noOwner payable returns(uint){
               shipper = msg.sender;
      Balances[shipper] = address(this).balance;
      require(_id == idPackage);
      require( Balances[shipper] == price*1 ether);
      return  Balances[shipper];
  }
  function ConfirmSuccess() public noOwner  payable  returns(uint){
        owner.transfer(Balances[shipper]);
  }
  function ErrorSuccess() public payable onlyOwner returns(uint){
          owner.transfer(Balances[shipper]);
  }
   function ConfirmToTransferShipper() public noOwner payable returns(uint){
          shipper.transfer(Balances[shipper]);
  }
  