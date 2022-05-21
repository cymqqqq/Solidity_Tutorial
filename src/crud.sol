// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Blog {
    address public owner;
    uint256 public activePostCounter = 0;
    uint256 public inactivePostCounter = 0;
    uint256 private postCounter = 0;

    mapping(uint256 => address) public delPostOf;
    mapping(uint256 => address) public authorOf;
    mapping(address => uint256) public postsOf;

    enum Deactivated { NO, YES}

    struct PostStruct {
        uint256 postId;
        string title;
        string description;
        address author;
        Deactivated deleted;
        uint256 created;
        uint256 updated;
    } 

    PostStruct[] activePosts;
    PostStruct[] inactivePosts;

    event Action (
        uint256 postId,
        string actionType,
        Deactivated deleted,
        address indexed executor,
        uint256 created
    );

    modifier ownerOnly() {
        require(msg.sender == owner, "owner reserved only");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function createPost(
        string memory title,
        string memory description
    ) external returns (bool) {
        require(bytes(title).length > 0, "title cannot be empty");
        require(bytes(description).length > 0, "description cannot be emptu");

        postCounter++;
        authorOf[postCounter] = msg.sender;
        postsOf[msg.sender] ++;
        activePostCounter++;

        activePosts.push(
            PostStruct(
                postCounter,
                title,
                description,
                msg.sender,
                Deactivated.NO,
                block.timestamp,
                block.timestamp
            )
        );

        emit Action(postCounter, "post created", Deactivated.NO, msg.sender, 
        block.timestamp);

        return true;
    }

    function updatePost(
        uint256 postId,
        string memory title,
        string memory description
    ) external returns (bool) {
        require(authorOf[postId] == msg.sender, "unauthorized entity");
        require(bytes(title).length > 0, "title cannot be empty");
        require(bytes(description).length > 0, "description cannot be empty");

        for (uint i = 0; i < activePosts.length; i++) {
            if(activePosts[i].postId == postId) {
                activePosts[i].title = title;
                activePosts[i].description = description;
                activePosts[i].updated = block.timestamp;
            }
        }

        emit Action(
            postId,
            "post updated",
            Deactivated.NO,
            msg.sender,
            block.timestamp
        );

        return true;
    }

    function showPost(
        uint256 postId
    ) external view returns (PostStruct memory) {
        PostStruct memory post;
        for(uint i = 0; i < activePosts.length; i++) {
            if(activePosts[i].postId == postId) {
                post = activePosts[i];
            }
        }

        return post;
    }

    function getPosts() external view returns (PostStruct[] memory) {
        return activePosts;
    }

    function getDeletedPost() ownerOnly external view returns (PostStruct[] memory) {
        return inactivePosts;
    }

    function deletePost(uint256 postId) external returns (bool) {
        require(authorOf[postId] == msg.sender, "unauthorized entity");

        for(uint i = 0; i < activePosts.length; i++) {
            if(activePosts[i].postId == postId) {
                activePosts[i].deleted = Deactivated.YES;
                activePosts[i].updated = block.timestamp;
                inactivePosts.push(activePost[i]);
                delPostOf[postId] = authorOf[postId];
                delete activePosts[i];
                delete authorOf[postId];
            }
        }

        postsOf[msg.sender]--;
        inactivePostCounter++;
        activePostCounter--;

        emit Action(
            postId,
            "post deleted",
            Deactivated.YES,
            msg.sender,
            block.timestamp
        );

        return true;
    }

    function restoreDeletedPost(
        uint256 postId,
        address author
    ) ownerOnly external returns (bool) {
        require(delPostof[postId] == author, "unauthorized author");

        for(uint i = 0; i < inactivePosts.length; i++) {
            if(inactivePosts[i].postId == postId) 
            {
                inactivePosts[i].deleted = Deactivated.NO;
                inactivePosts[i].updated = block.timestamp;

                activePosts.push(inactivePosts[i]);
                delete inactivePosts[i];
                authorOf[postId] = delPostOf[postId];
                delete delPostOf[postId];
            }
        }

        postsOf[author]++;
        inactivePostCounter--;
        activePostCounter++;

        emit Action(
            postId,
            "post restored",
            Deactivated.NO,
            msg.sender,
            block.timestamp
        );

        return true;
    }
}