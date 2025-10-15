%lang starknet
from starkware.starknet.common.syscalls import get_caller_address

@storage_var
func owner() -> (res: felt): end
@storage_var
func root_registered(root: felt) -> (res: felt): end

@event
func RootRegistered(root: felt, publisher: felt): end

@constructor
func constructor{syscall_ptr : felt*}(initial_owner: felt):
    owner.write(initial_owner)
    return ()
end

func only_owner{syscall_ptr : felt*}():
    let (caller) = get_caller_address()
    let (o) = owner.read()
    assert caller = o
    return ()
end

@external
func register_root{syscall_ptr : felt*}(root: felt):
    only_owner()
    root_registered.write(root, 1)
    RootRegistered.emit(root, get_caller_address())
    return ()
end

@external
func revoke_root{syscall_ptr : felt*}(root: felt):
    only_owner()
    root_registered.write(root, 0)
    return ()
end

@view
func is_root_registered{syscall_ptr : felt*}(root: felt) -> (res: felt):
    let (v) = root_registered.read(root)
    return (res=v)
end
