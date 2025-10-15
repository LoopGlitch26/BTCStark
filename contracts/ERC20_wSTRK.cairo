%lang starknet
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256, uint256_add, uint256_sub
from starkware.starknet.common.syscalls import get_caller_address

@storage_var
func name() -> (res: felt): end
@storage_var
func symbol() -> (res: felt): end
@storage_var
func decimals() -> (res: felt): end
@storage_var
func total_supply() -> (res: Uint256): end
@storage_var
func balance_of(account: felt) -> (res: Uint256): end
@storage_var
func bridge_address() -> (res: felt): end

@constructor
func constructor{syscall_ptr : felt*}(name_: felt, symbol_: felt, decimals_: felt, bridge_: felt):
    name.write(name_)
    symbol.write(symbol_)
    decimals.write(decimals_)
    bridge_address.write(bridge_)
    let zero = Uint256(0,0)
    total_supply.write(zero)
    return ()
end

func only_bridge{syscall_ptr : felt*}():
    let (caller) = get_caller_address()
    let (bridge) = bridge_address.read()
    assert caller = bridge
    return ()
end

@external
func mint{syscall_ptr : felt*}(recipient: felt, amount: Uint256):
    only_bridge()
    let (bal) = balance_of.read(recipient)
    let (new_bal) = uint256_add(bal, amount)
    balance_of.write(recipient, new_bal)
    let (ts) = total_supply.read()
    let (new_ts) = uint256_add(ts, amount)
    total_supply.write(new_ts)
    return ()
end

@external
func burn{syscall_ptr : felt*}(account: felt, amount: Uint256):
    only_bridge()
    let (bal) = balance_of.read(account)
    let (ok, new_bal) = uint256_sub(bal, amount)
    assert ok = 1
    balance_of.write(account, new_bal)
    let (ts) = total_supply.read()
    let (ok2, new_ts) = uint256_sub(ts, amount)
    assert ok2 = 1
    total_supply.write(new_ts)
    return ()
end
