// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;



import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

import "@openzeppelin/contracts/security/Pausable.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";

import "@openzeppelin/contracts/utils/Counters.sol";

import "@openzeppelin/contracts/utils/Strings.sol";



contract Nft is ERC721, ERC721Enumerable, ERC721URIStorage, Pausable, Ownable, ERC721Burnable {

    using Counters for Counters.Counter;



    Counters.Counter private _tokenIdCounter;



    constructor() ERC721("Ehsan", "EHS") {}



    function _baseURI() internal pure override returns (string memory) {

        return "{put folder of ipfs}";

    }



    function pause() public onlyOwner {

        _pause();

    }



    function unpause() public onlyOwner {

        _unpause();

    }



    function safeMint(address to) public onlyOwner {

        _tokenIdCounter.increment();

        _safeMint(to, _tokenIdCounter.current());

    }

     function tokenURI(uint256 tokenId) public view  override(ERC721,ERC721URIStorage) returns (string memory) {

        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");



        string memory baseURI = _baseURI();

        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, Strings.toString(tokenId),".png")) : "";

    }



    function _beforeTokenTransfer(address from, address to, uint256 tokenId)

        internal

        whenNotPaused

        override(ERC721, ERC721Enumerable)

    {

        super._beforeTokenTransfer(from, to, tokenId);

    }



    // The following functions are overrides required by Solidity.



    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {

        super._burn(tokenId);

    }



 



    function supportsInterface(bytes4 interfaceId)

        public

        view

        override(ERC721, ERC721Enumerable)

        returns (bool)

    {

        return super.supportsInterface(interfaceId);

    }

}