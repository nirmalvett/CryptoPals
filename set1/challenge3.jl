#=

The hex encoded string:

1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736
... has been XOR'd against a single character. Find the key, decrypt the message.

=#
include("challenge2.jl")


#=

Counts amount of characters from set "ETAOIN SHRDLU" in the given string

=#
function english_common_character_count(line::String)
    # try/catch for Base.InvalidCharError which sometimes occurs when lowercasing non-english characters
    try
        line = lowercase(line)
    catch exception
        return 0
    end

    amount = 0
    for character in "etaoin shrdlu"
        amount += count(c -> c == character, line)
    end
    return amount
end

hex = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"
xor_key = zeros(UInt8, length(hex2bytes(hex)))

best_match = ""
best_match_amount = 0
for i in 0:128
    global best_match
    global best_match_amount
    fill!(xor_key, convert(UInt8, i))
    line = String(xor_hex_strings(hex, bytes2hex(xor_key), true))
    amount = english_common_character_count(line)
    if(amount > best_match_amount)
        best_match_amount = amount
        best_match = line
    end
end

println(best_match)
