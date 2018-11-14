#= S1C2

Write a function that takes two equal-length buffers and produces their XOR combination.

If your function works properly, then when you feed it the string:

1c0111001f010100061a024b53535009181c
... after hex decoding, and when XOR'd against:

686974207468652062756c6c277320657965
... should produce:

746865206b696420646f6e277420706c6179

=#
using Base64


#=

Takes in 2 hex strings and converts/returns the xor'd hex string
Optional parameter retBytes to specify whether to return bytes array
or a hex string (default is hex string)

=#
function xor_hex_strings(hex::String, xor_key::String, retBytes=false::Bool)
    hex = hex2bytes(hex)
    xor_key = hex2bytes(xor_key)

    output = UInt8[]
    for i in 1:length(hex)
        push!(output, xor(hex[i], xor_key[i]))
    end

    if(retBytes)
        return output
    else
        return bytes2hex(output)
    end
end

function main()
    println(xor_hex_strings("1c0111001f010100061a024b53535009181c", "686974207468652062756c6c277320657965"))
end

# main()
