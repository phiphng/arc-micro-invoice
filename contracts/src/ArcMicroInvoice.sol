// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20Lite {
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function transfer(address to, uint256 amount) external returns (bool);
}

contract ArcMicroInvoice {
    IERC20Lite public immutable usdc;
    address public owner;
    uint256 public nextId;

    struct Record {
        address payer;
        address receiver;
        uint256 amount;
        string memo;
        bool settled;
    }

    mapping(uint256 => Record) public records;

    event RecordCreated(uint256 indexed id, address indexed payer, address indexed receiver, uint256 amount, string memo);
    event RecordSettled(uint256 indexed id);
    event OwnerChanged(address indexed oldOwner, address indexed newOwner);

    modifier onlyOwner() {
        require(msg.sender == owner, "NOT_OWNER");
        _;
    }

    constructor(address _usdc) {
        require(_usdc != address(0), "USDC_ZERO");
        usdc = IERC20Lite(_usdc);
        owner = msg.sender;
    }

    function createRecord(address receiver, uint256 amount, string calldata memo) external returns (uint256 id) {
        require(receiver != address(0), "RECEIVER_ZERO");
        require(amount > 0, "AMOUNT_ZERO");
        id = ++nextId;
        records[id] = Record(msg.sender, receiver, amount, memo, false);
        emit RecordCreated(id, msg.sender, receiver, amount, memo);
    }

    function pay(uint256 id) external {
        Record storage item = records[id];
        require(item.amount > 0, "MISSING");
        require(!item.settled, "SETTLED");
        item.settled = true;
        require(usdc.transferFrom(msg.sender, item.receiver, item.amount), "USDC_TRANSFER_FAILED");
        emit RecordSettled(id);
    }

    function rescueUSDC(address to, uint256 amount) external onlyOwner {
        require(usdc.transfer(to, amount), "USDC_RESCUE_FAILED");
    }

    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "OWNER_ZERO");
        emit OwnerChanged(owner, newOwner);
        owner = newOwner;
    }
}
