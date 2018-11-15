#= S1C5

Here is the opening stanza of an important work of the English language:

Burning 'em, if you ain't quick and nimble
I go crazy when I hear a cymbal
Encrypt it, under the key "ICE", using repeating-key XOR.

It should come out to:

0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272
a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f

=#


"""
Takes a string and applies a repeating key xor with the xor key provided
"""
function repeating_key_xor(input, xor_key, retBytes=false::Bool)
    if isa(input, String)
        input = Vector{UInt8}(input)
    end
    if isa(xor_key, String)
        xor_key = Vector{UInt8}(xor_key)
    end

    xor_key_length = length(xor_key)
    output = UInt8[]
    for i in 1:length(input)
        try
            val = ((i - 1) % xor_key_length) + 1
        catch exception
            println(xor_key_length)
        end
        push!(output, xor(input[i], xor_key[((i - 1) % xor_key_length) + 1]))
    end
    if retBytes
        return output
    else
        return String(output)
    end
end

function main()
    input = "Burning 'em, if you ain't quick and nimble I go crazy when I hear a cymbal"
    xor_key = "ICE"
    output = repeating_key_xor(input, xor_key, true)
    println(bytes2hex(output))
end

# main()
