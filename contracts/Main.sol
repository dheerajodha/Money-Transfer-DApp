pragma solidity ^0.5.12;

contract Bank {
    struct Transaction {
        address fromAddress;
        address toAddress;
        uint amount;
    }
 
 Transaction[] transactions;
 
 constructor() public {
    /* Creates an initial transaction from a dummy address to the address of account which deployed this contract. */
    address dummyAddress = "0x87346874638747834683";
    Transaction memory transaction = Transaction(dummyAddress, msg.sender, 50);
    transactions.push(transaction);
 }


function transferMoney(address _fromAddress, address _toAddress, uint _withdrawAmount) public {
    
    require(_fromAddress == msg.sender, "Please transfer money from your account, not from somebody else's account.");
    require(balance(_fromAddress) >= _withdrawAmount);
    Transaction memory transaction = Transaction(_fromAddress, _toAddress, _withdrawAmount);
    transactions.push(transaction);
 }
 
 
 function balance(address _accountAddress) public view returns (uint) {
    uint balanceIn = 0;
    uint balanceOut = 0;
    
    require(_accountAddress == msg.sender, "Please don't try to check balance of somebody else's account.");
    for (uint i = 0; i < transactions.length; i++) {
        if (transactions[i].toAddress == _accountAddress) {
            balanceIn += transactions[i].amount;
        }
        if (transactions[i].fromAddress == _accountAddress) {
            balanceOut += transactions[i].amount;
        }   
    }
    return balanceIn - balanceOut;
 }
 
 function() external {
    revert();
 }
}
