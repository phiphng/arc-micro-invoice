# arc-micro-invoice

Tiny USDC invoice registry for freelancers.

## Arc Network

- Chain ID: `5042002`
- RPC: `https://rpc.testnet.arc.network`
- Explorer: `https://testnet.arcscan.app`
- Gas/payment asset: USDC-style 6 decimals

## What it does

This starter dApp provides a compact Arc smart-contract pattern:

- Create a payment/record intent with payer, receiver, amount, and memo.
- Settle the record by transferring USDC from the payer to receiver.
- Emit clean events for indexers, bots, and dashboards.
- Keep the code minimal for portfolio review and future frontend/agent expansion.

## Project layout

```text
contracts/src/ArcMicroInvoice.sol
contracts/src/MockUSDC.sol
contracts/test/ArcMicroInvoice.t.sol
contracts/foundry.toml
```

## Run tests

```bash
cd contracts
forge test -vv
```

## Next steps

- Add deployment script for Arc testnet.
- Add viem/Next.js dashboard.
- Wire Circle/USDC UX copy and demo screenshots.
