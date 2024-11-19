//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

// Useful for debugging. Remove when deploying to a live network.
import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract KethToken is ERC20, Ownable {
	address public paymentProcessor; // Trusted backend for minting tokens
	string public greeting = "Keth token!!!";

	event PaymentProcessed(
		address indexed user,
		uint256 amountInKES,
		uint256 tokensMinted
	);

	constructor() Ownable(msg.sender) ERC20("KethToken", "KETH") {
		// No initial supply minted
	}

	// Set the payment processor address (can only be done by the contract owner)
	function setPaymentProcessor(address _processor) external onlyOwner {
		paymentProcessor = _processor;
	}

	// Mint tokens based on KES received (only callable by the payment processor)
	function mintTokens(address to, uint256 amountInKES) external {
		require(msg.sender == paymentProcessor, "Not authorized to mint");
		require(amountInKES > 0, "Amount must be greater than zero");

		uint256 tokensToMint = amountInKES * 10 ** decimals(); // Assuming 1 token = 1 KES
		_mint(to, tokensToMint);

		emit PaymentProcessed(to, amountInKES, tokensToMint);
	}
}
