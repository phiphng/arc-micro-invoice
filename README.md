# Micro Invoice

> A smart contract built on [Arc Network](https://arc.network) — the first Modular L1 for DeFi, powered by USDC gas.

![Solidity](https://img.shields.io/badge/Solidity-%5E0.8.20-363636?logo=solidity)
![Foundry](https://img.shields.io/badge/Built%20with-Foundry-FFDB1C?logo=ethereum)
![Arc Network](https://img.shields.io/badge/Chain-Arc%20Testnet-blue)
![License](https://img.shields.io/badge/License-MIT-green)

## Overview

This project implements **Micro Invoice** functionality on Arc Network's testnet. Arc uses USDC as native gas token (6 decimals), providing a stable and predictable fee structure for DeFi applications.

## Architecture

```
+-----------------------------------+
|         Micro Invoice               |
|                                   |
|  +-----------+   +------------+   |
|  |  Access   |   |   Core     |   |
|  |  Control  |---|   Logic    |   |
|  +-----------+   +------------+   |
|         |              |          |
|  +-----------------------------+  |
|  |     USDC (6 decimals)       |  |
|  +-----------------------------+  |
+-----------------------------------+
```

## Contracts

- `src/`

## Quick Start

### Prerequisites
- [Foundry](https://book.getfoundry.sh/getting-started/installation) installed
- Arc testnet USDC for gas ([Faucet](https://faucet.arc.network))

### Build and Test

```bash
# Install dependencies
forge install

# Build contracts
forge build

# Run tests
forge test -vvv

# Deploy to Arc testnet
forge script script/Deploy.s.sol --rpc-url https://rpc.testnet.arc.network --broadcast
```

## Network Config

| Parameter | Value |
|-----------|-------|
| Network   | Arc Testnet |
| Chain ID  | 5042002 |
| RPC       | `https://rpc.testnet.arc.network` |
| Gas Token | USDC (6 decimals) |

## Gas Optimization

- Tight variable packing in storage slots
- Events for off-chain indexing instead of storage where possible
- Custom errors instead of revert strings

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Built with love on [Arc Network](https://arc.network)
