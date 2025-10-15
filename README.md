# BitShade-Pro

**Private Bitcoin → Starknet (Client Demo)**

BitShade-Pro is a browser-only prototype demonstrating a privacy-preserving BTC → Starknet payments UX.
It implements UTXO-style notes, Merkle commitments, nullifiers, note selection and change, encrypted backups,
and a demo-ready flow for recording. This demo uses a **mock bridge** for speed and safety. We include a
Starknet integration snippet (ArgentX/devnet) so judges can optionally sync Merkle root and nullifiers on-chain.

## Quick start (recommended for judges)

1. Download `bitshade-pro.html`.
2. Open the file in Chrome (Incognito) to run the demo.
3. Follow the on-screen instructions: Deposit → Copy Note → Withdraw → Export Backup (optional).

## Optional: On-chain (devnet) integration

If you want to show on-chain writes with a local devnet:
1. Install and run `starknet-devnet`.
2. Compile & deploy `contracts/merkle_nullifier.cairo`.
3. Update `CONTRACT_ADDRESS` in `bitshade-pro.html` to your deployed contract address.
4. Use the UI buttons _Sync root → Starknet_ and _Mark nullifier on-chain_.

## Files in this repo

- bitshade-pro.html      : single-file demo (open directly)
- contracts/merkle_nullifier.cairo : minimal Cairo1 contract to store root & nullifier mapping
- scripts/deploy_devnet.sh : helper placeholder for deploy
- web/app.js and web/styles.css : optional modular files
- docs/DEVPOST_COPY.md   : Devpost description and video script
- LICENSE : MIT

## Security & Disclaimer

This prototype is for demonstration only. It does NOT move real funds. Do NOT use it with real assets.
For production, move proofs on-chain (Garaga/Noir), integrate Alpen/Glock for trust-minimized bridging, and audit contracts.

