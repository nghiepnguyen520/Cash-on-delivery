contract Sell{
    address payable public  owner;
    address payable public  buyer;
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
       
   }
    function AddPackage(string memory _name, uint _price) onlyOwner public{
     
       idPackage += 1;
       price = _price;
       Packages[idPackage] = Package(_name, price);
   }
     function ApplyBuy(uint id) public noOwner payable returns(uint){
        buyer = msg.sender;
      Balances[buyer] = address(this).balance;
      require(id == idPackage);
      //require(msg.sender == buyer);
      require(Balances[buyer] == price*1 ether);
      return Balances[buyer];
  }
   function ConfirmToTransferBuyer() public noOwner payable  returns(uint){
      require( msg.sender == buyer);
      buyer.transfer(Balances[buyer]);
  }
  function ErrorSuccess() public payable onlyOwner returns(uint){
      owner.transfer(Balances[buyer]);
  }