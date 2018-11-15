#= S2C9

Implement PKCS#7 padding
A block cipher transforms a fixed-sized block (usually 8 or 16 bytes) of plaintext into ciphertext. But we almost never want to transform a single block; we encrypt irregularly-sized messages.

One way we account for irregularly-sized messages is by padding, creating a plaintext that is an even multiple of the blocksize. The most popular padding scheme is called PKCS#7.

So: pad any block to a specific block length, by appending the number of bytes of padding to the end of the block. For instance,

"YELLOW SUBMARINE"
... padded to 20 bytes would be:

"YELLOW SUBMARINE\x04\x04\x04\x04"

=#


"""
Pads the given array to meet the size specified.
Padded using the pkcs#7 format.
"""
function pkcs_pad(bytes::Array{UInt8}, toSize::Int)
    len = length(bytes)
    if len > toSize
        throw(ArgumentError("Array size greater than pad length"))
    end

    for i in len:toSize-1
        push!(bytes, toSize - len)
    end

    return bytes
end

function main()
    println(pkcs_pad(Array{UInt8}("YELLOW SUBMARINE"), 20))
end

# main()
