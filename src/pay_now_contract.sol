// SPDX-License_Identifier: MIT
pragma solidity ^0.8.13;

contract BookStore {
    // Contains global store data
    uint256 taxfee;
    address immutable taxAccount;
    uint8 totalSupply = 0;

    // specifies book information
    struct BookStruct {
        uint8 id;
        address seller;
        string title;
        string desc;
        string author;
        uint256 cost;
        uint256 ts;
    }

    //associates books with sellers and buyers
    BookStruct[] books;
    mapping(address => BookStruct[]) bookOf;
    mapping (uint8 => address) sellerOf;
    mapping(uint8 => bool) bookExist;

    // Logs out sales record
    event Sale(
        uint8 id,
        address indexed buyer,
        address indexed seller,
        uint256 cost,
        uint256 ts
    );

    //Logs out created book record
    event Created(
        uint8 id,
        address indexed seller,
        uint256 ts
    );

    //initialize book creation
    function createBook(
        string memory title,
        string memory desc,
        string memory author,
        uint256 cost
    ) public returns (bool) {
        require(bytes(title).length > 0, "title empty");
        require(bytes(desc).length > 0, "desc empty");
        require(bytes(author).length > 0, "author empty");
        require(cost > 0 ether, "price cannot be zero");

        books.push(
            BookStruct(
                totalSupply++,
                msg.sender,
                title,
                desc,
                author,
                cost,
                block.timestamp
            )
        );

        //records book selling detail
        sellerOf[totalSupply] = msg.sender;
        bookExist[totalSupply] = true;

        emit Created(totalSupply, msg.sender , block.timestamp);
        return true;
    
    }

    function payForBook(uint8 id)
        public payable returns (bool) {
            require(bookExist[id], "boook does not exist");
            require(msg.value >= books[id - 1].cost, "ethers too small");
            
            //computes payment data
            address seller = sellerOf[id];
            uint256 tax = (msg.value / 100) * taxfee;
            uint256 payment = msg.value - tax;

            // bills buyer on book sale;
            payTo(seller, payment);
            payTo(taxAccount, tax);

            //give book to buyer
            bookOf[msg.sender].push(books[id - 1]);

            emit Sale(id, msg.sender, seller, payment, block.timestamp);
            return true;
    }

    //method1 the transfer function
    function transferTo(
        address to,
        uint256 amount
    ) internal returns (bool) {
        payable(to).transfer(amount);
        return true;
    }

    //method2 the send function
    function sendTo(
        address to,
        uint256 amount
    ) internal returns (bool) {
        require(payable(to).send(amount), "payment failed");
        return true;
    }

    //method3 the call function
    function payTo(
        address to,
        uint256 amount
    ) internal returns (bool) {
        (bool success, ) = payable(to).call{value: amount}("");
        return true;
    }

    //return books of buyer
    function myBooks(address buyer) 
        external view returns (BookStruct[] memory) {
            return bookOf[buyer];
        }

    //return books in store
    function getBooks()
        external view returns (BookStruct[] memory)
    {
        return books;
    }

    //returns a specific book by id
    function getBook(uint8 id)
        external view returns (BookStruct[] memory)
    {
        return books[id - 1];
    }
    
}