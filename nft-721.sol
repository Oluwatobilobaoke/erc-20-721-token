// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// We first import some OpenZeppelin Contracts.
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// We need to import the helper functions from the contract that we copy/pasted.
import {Base64} from "./Base64.sol";

// We inherit the contract we imported. This means we'll have access
// to the inherited contract's methods.
contract YNFT is ERC721URIStorage {
    // Magic given to us by OpenZeppelin to help us keep track of tokenIds.
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // We need to pass the name of our NFTs token and it's symbol.
    constructor() ERC721("YDMNFT", "YNFT") {
        console.log("My First  NFT Contract, Lovely!!! ");
    }

    // A function our user will hit to get their NFT.
    function createYNFT(string memory name, string memory image) public {
        // Get the current tokenId, this starts at 0.
        uint256 newItemId = _tokenIds.current();

        // Get all the JSON metadata in place and base64 encode it.
        string memory json = Base64.encode(
            string(
                abi.encodePacked(
                    '{"name": "',
                    name,
                    " - #YNFT ",
                    Strings.toString(newItemId),
                    '", "description": "A piece of YDM NFT!", "image": "',
                    image,
                    '"}'
                )
            )
        );

        // Just like before, we prepend data:application/json;base64, to our data.
        string memory derivedTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        _safeMint(msg.sender, newItemId);

        // Update your URI!!!
        _setTokenURI(newItemId, derivedTokenUri);

        _tokenIds.increment();
    }
}
