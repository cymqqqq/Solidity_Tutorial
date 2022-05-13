// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./ERC721.sol";
import "./ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Adulam is ERC721Enumerable, Ownable {
    using Strings for uint256;
    mapping(string => uint8) public existintURIs;

    uint256 public cost = 0.01 ether;
    uint256 public maxsupply = 100;
    uint256 public supply;
    string public baseURI;

    event Sale(
        uint256 id,
        address indexed from,
        address indexed to,
        uint256 cost,
        string metadataURI,
        uint256 timestamp
    );

    struct SaleStruct {
        uint256 id;
        address from;
        address to;
        uint256 cost;
        string title;
        string desc;
        uint256 timestamp;
    }

    SaleStruct[] minted;

    constructor(
        string memory _name,
        string memory _symbol,
        string memory _baseURL
    ) ERC721(_name, _symbol) {
        supply = totalSupply();
        baseURL = _baseURI;
    }

    function payToMint(string memory title, string memory desc) public payable {
        require(supply <= maxsupply, "all nft has minted");
        require(msg.value > 0 ether, "too low for minting");
        require(msg.sender != owner(), "this not permitted");

        supply += 1;
        string memory URI = concat(Strings.toString(supply + 1));
        existingURIs[URI] = 1;

        sendMoneyTo(owner(), msg.value);

        minted.push(
            SaleStruct(
                supply,
                msg.sender,
                owner(),
                msg.value,
                title,
                desc,
                block.timestamp
            )
        );

        emit Sale(supply,msg.sender, owner(), msg.value, URI, block.timestamp)
    
        _safeMint(msg.sender, supply);
    }

    function getAllNFTs() public view returns (SaleStruct[] memory) {
        return minted;
    }

    function getAnNFT(uint256 tokenId) public view returns (SaleStruct memory) {
        return minuted[tokenId - 1];
    }

    function concat(string memory str) internal view returns (string memory) {
        return string(abi.encodePacked(baseURI, "", str));
    }

    function sendMoneyTo(address to, uint256 amount) internal {
        (bool success, ) = payable(to).call{value: amount}("");
        require(success);
    }
}