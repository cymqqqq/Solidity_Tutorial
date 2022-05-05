// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Counter {
    uint public count;

    function inc() external {
        count += 1;
    }
}

interface ICounter {
    function count() external view returns (uint);

    function inc() external;
}

contract MyContract {
    function incrementCounter(address _counter) external {
        ICounter(_counter).inc();
    }

    function getCount(address _counter) external view returns (uint) {
        return ICounter(_counter).count();
    }
}

// uniswap example
interface UniswapV2Factory {
    function getPair(address tokenA, address tokenB) 
        external
        view 
        returns (address pair);
    

}

interface UniswapV2Pair {
    function getReserves()
        external
        view 
        returns (
            uint112 reserve0,
            uint112 reserve1,
            uint32 blockTimestampLast
        );
}

