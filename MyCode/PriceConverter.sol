// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {

    function getPrice () internal view returns (uint256) {
        //0x694AA1769357215DE4FAC081bf1f309aDC325306
        (, int256 answer,,, )= AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).latestRoundData();
        return uint256(answer * 1e10);
    }


    function getconerstionRate(uint256 ethAmount) internal view returns ( uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUSD = (ethAmount * ethPrice) / 1e18;
        return ethAmount; 
    }

    function getVersion () internal view returns (uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}