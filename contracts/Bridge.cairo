%lang starknet
from starkware.starknet.common.syscalls import get_caller_address
from starkware.cairo.common.uint256 import Uint256

@storage_var
func merkle_registry_addr() -> (res: felt): end
@storage_var
func token_addr() -> (res: felt): end
@storage_var
func relayer() -> (res: felt): end
@storage_var
func nullifier_used(n: felt) -> (res: felt): end

@event
func Minted(to: felt, amount_low: felt, amount_high: felt, nullifier: felt, root: felt): end

@constructor
func constructor{syscall_ptr : felt*}(registry: felt, token: felt, relayer_addr: felt):
    merkle_registry_addr.write(registry)
    token_addr.write(token)
    relayer.write(relayer_addr)
    return ()
end

func only_relayer{syscall_ptr : felt*}():
    let (caller) = get_caller_address()
    let (r) = relayer.read()
    assert caller = r
    return ()
end

@external
func mint_proof{syscall_ptr : felt*}(recipient: felt, amount: Uint256, nullifier: felt, root: felt):
    only_relayer()
    let (used) = nullifier_used.read(nullifier)
    assert used = 0
    nullifier_used.write(nullifier, 1)
    Minted.emit(recipient, amount.low, amount.high, nullifier, root)
    return ()
end
