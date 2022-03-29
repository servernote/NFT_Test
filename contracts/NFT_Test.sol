// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "openzeppelin-solidity/contracts/token/ERC721/ERC721.sol";
import "openzeppelin-solidity/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "openzeppelin-solidity/contracts/utils/Counters.sol";

contract NFT_Test is ERC721URIStorage {

	using Strings for uint256;
	using Counters for Counters.Counter;
	Counters.Counter private _counter;
	uint private _selling_price = 0.01 ether; // 販売価格
	uint private _purchase_price = 0.005 ether; //買取価格

	constructor () ERC721 ("NFT_Test", "NFT_TEST") {}

	//msg = https://web3js.readthedocs.io/en/v1.7.1/web3-eth.html#sendtransaction
	function mint () public payable returns (uint256) { 
		require(msg.value == _selling_price); //金銭受領確認

		_counter.increment();
		uint256 tokenId = _counter.current();

		_mint(msg.sender, tokenId);
		_setTokenURI(tokenId, string(abi.encodePacked("https://raw.githubusercontent.com/servernote/NFT_Test/master/contents/nft_test_token_", tokenId.toString(), ".json")));

		return tokenId;
	}

	function burn (uint256 tokenId) public {
		require(ownerOf(tokenId) == msg.sender); //所有者か確認

		//NULL Address https://etherscan.io/address/0x000000000000000000000000000000000000dead
		_transfer(msg.sender, 0x000000000000000000000000000000000000dEaD, tokenId);

		address payable receiver = payable(msg.sender);
		receiver.transfer(_purchase_price); //買取処理
	}
}
