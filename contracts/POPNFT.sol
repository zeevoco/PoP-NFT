// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

/// @title Zeevo.co Proof of Participation NFT 
/// @author @WolfDeFi
/// @notice Zeevo PoP NFTs are generated from sequences at https://zeevo.co
/// @custom:security-contact Telegram @InMathsWeTrust 

import "OpenZeppelin/openzeppelin-contracts@4.5.0/contracts/token/ERC721/ERC721.sol";
import "OpenZeppelin/openzeppelin-contracts@4.5.0/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "OpenZeppelin/openzeppelin-contracts@4.5.0/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "OpenZeppelin/openzeppelin-contracts@4.5.0/contracts/security/Pausable.sol";
import "OpenZeppelin/openzeppelin-contracts@4.5.0/contracts/access/AccessControl.sol";
import "OpenZeppelin/openzeppelin-contracts@4.5.0/contracts/utils/Counters.sol";


contract POPNFT is ERC721, ERC721Enumerable, ERC721URIStorage, Pausable, AccessControl {
    using Counters for Counters.Counter;
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("Zeevo PoP", "ZPOP") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://";
    }

    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function unpause() public onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    function safeMint(address to, string memory uri) public onlyRole(MINTER_ROLE) {
        _tokenIdCounter.increment();
        uint256 newTokenId = _tokenIdCounter.current();
        _safeMint(to, newTokenId);
        _setTokenURI(newTokenId, uri);
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

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
