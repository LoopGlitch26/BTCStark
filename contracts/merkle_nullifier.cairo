%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

@storage_var
func root() -> (res : felt) {
}

@storage_var
func used_nullifier(key : felt) -> (res : felt) {
}

@external
func store_root{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    new_root : felt
) -> () {
    root.write(new_root);
    return ();
}

@view
func get_root{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (res : felt) {
    let (r) = root.read();
    return (r,);
}

@external
func use_nullifier{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    nullifier : felt
) -> (ok : felt) {
    let (v) = used_nullifier.read(nullifier);
    if v != 0 {
        return (0,);
    }
    used_nullifier.write(nullifier, 1);
    return (1,);
}

@view
func is_nullifier_used{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    nullifier : felt
) -> (res : felt) {
    let (v) = used_nullifier.read(nullifier);
    return (v,);
}
