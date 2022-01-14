pragma solidity ^0.4.17;

contract Lottery{
    address public manager;
    address[] public players;

    function lottery() public{
        manager = msg.sender;
    }

    function enter() public payable{
        require(msg.value > .01 ether);
        players.push(msg.sender);
    }

    function random() private view returns (uint){
        return uint(keccak256(block.difficulty, now, players));
    }

    function pickWinner() public restricted {
        uint index = random() % players.length;
        players[index].transfer(this.balance);
        players = new address[](0);
    }

    modifier restricted(){// Created a modifier which can be mentioned in a function and _ gets replaved by function
            require(msg.sender == manager); // allows only manager to access the function [admin level access]
            _;
    }

    function getPlayers() public view returns(address[]){
        return players;
    }


}
