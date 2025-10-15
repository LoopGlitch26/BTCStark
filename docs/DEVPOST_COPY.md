# Devpost Copy - BitShade-Pro

**BitShade-Pro — Private Bitcoin → Starknet Payments**

> Client-side bridge architecture for private, non-custodial BTC deposits and withdrawals on Starknet.
> Built with cryptography, UTXO-style notes, Merkle proofs, and encrypted backups.

**BitShade-Pro** demonstrates how **Bitcoin can flow into Starknet privately** — without wrapped assets, intermediaries, or custodians.
It uses *UTXO-like notes* to represent ownership, *Merkle proofs* for verifiable inclusion, and *nullifiers* to prevent double-spends.
Encrypted backups ensure recoverability while keeping user data off-chain.
Integration points for **Alpen’s Glock verifier** show the path toward a **trust-minimized BTC → Starknet bridge**.

**Step 1 — Launch the App**

* Open the live page: 👉 [https://loopglitch26.github.io/BTCStark/](https://loopglitch26.github.io/BTCStark/)
* Observe BTC and wSTRK balances at the top bar.

**Step 2 — Deposit (Create Private Note)**

* Enter `0.01 BTC` in the *Deposit* field → click **Deposit**.
* Watch:

  * BTC balance decreases
  * wSTRK balance increases
  * Activity log records a **DEPOSIT**
  * “My Notes” now shows your new private note (UTXO)

**Step 3 — Inspect the Merkle Tree**

* Scroll to **Pool Inspector**
* Click any leaf — the visualization highlights your note’s proof path
* Observe *Merkle Root* auto-update → this root can be synced on-chain

**Step 4 — Withdraw (Spend Note)**

* Copy your note → paste in *Withdraw section*
* Destination: `0xDEMO` (Starknet address)
* Click **Withdraw**
* Activity log shows a **WITHDRAW** entry
* “Nullifiers” panel updates — proving the note is spent

**Step 5 — Encrypted Backup**

* Click **Export Encrypted Backup** → choose password → save file
* Reset app → re-import backup to restore your notes and balances
* Demonstrates AES-GCM + PBKDF2 client-side encryption

**Step 6 — On-chain Sync**

* Click **Sync root → Starknet** → Merkle-root publishing
* Click **Check on-chain root** → confirm latest root
* This call would execute via **Starknet.js → MerkleRegistry.cairo**

README.md
