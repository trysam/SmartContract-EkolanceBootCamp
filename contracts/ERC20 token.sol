// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.9;

/*
The purose of this contract is to: 
 - allow admin to create a fungible token in certain quantity (named Total Supply) and 
 - provide functionality that
        1. allow the owner to transfer token tp any user,  
        2. allow the owner to approve token limit that a user can spend out of owner's account
        3. allow user to transfer token upto to the limit approved by the owner 
        4. allow admin to burn some or  total supply of the token
        5. allow user to burn token upto to the limit approved by the owner
        6. aloow admin to increase the quantity of token in supply
         alllownce  some quantity of the token (name allowance)  to be used by user
 

 Note: ERC20 and ERC20Burnable extension from openzapplin alrady contain functions 
 to achieve items 1 to 5 of the scope. To achieve item 6, a function named "increaseTotalSupply" 
 defined in this contract

*/

// import ERC20 standard contract and ERC20Burnable extension from openzappelin
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

// make MyToken contract to inherit ERC20 contract from openzappelin
contract MyToken is ERC20, ERC20Burnable{

address private admin; 

// call ERC20 contructor and _mint funtion at the deployment of the contract
constructor(string memory _tokenName, string memory _tokenSymbol, uint tokenAmount)ERC20( 
    _tokenName, _tokenSymbol){
    _mint(msg.sender,tokenAmount);
    admin = msg.sender;
}

//mofifier function to ensure that only the admin can perform an operation
modifier onlyAdmim(){
    require(msg.sender == admin,"This operation is restricted to only the Admin");

    _;
}

//only the admin can imcreament to total supply of the token 
function increaseTotalSupply(uint incrementAmount) public onlyAdmim {
    require(incrementAmount > 0, "Amount must be greater than Zero");
     _mint(msg.sender, incrementAmount);
}


}

