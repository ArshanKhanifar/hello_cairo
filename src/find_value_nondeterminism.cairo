%builtins output 

from starkware.cairo.common.math import assert_nn_le
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.serialize import serialize_word


struct KeyValue {
    key: felt,
    value: felt,
}

func add_key_value(key: felt, value: felt, table: KeyValue*) -> KeyValue* {
    assert table.key = key;
    assert table.value = value;
    return table + KeyValue.SIZE;
}

func fill_key_value(keys: felt*, values: felt*, table: KeyValue*, size) {
    let next = add_key_value([keys], [values], table);
    return fill_key_value(keys + 1, values + 1, next, size - 1);
}

func get_value_by_key{range_check_ptr}(
    list: KeyValue*, size, key
) -> (value: felt) {
    alloc_locals;
    local idx;
    %{
        ENTRY_SIZE = ids.KeyValue.SIZE
        KEY_OFFSET = ids.KeyValue.key
        VALUE_OFFSET = ids.KeyValue.value
        for i in range(ids.size):
            addr = ids.list.address_ + ENTRY_SIZE * i + KEY_OFFSET
            if memory[addr] == ids.key:
                ids.idx = i
                break
        else:
            raise Exception(f'Key{ids.key} was not found in the list.')
    
    %}
    let item: KeyValue = list[idx];
    assert item.key = key;
    assert_nn_le(a=idx, b=size - 1);
    return (value=item.value);
}

func main {output_ptr: felt*} ()  {
    alloc_locals;
    let (local dict: KeyValue*) = alloc();

    serialize_word(6969696);
    return ();
}
