#= S1C3

The hex encoded string:

1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736
... has been XOR'd against a single character. Find the key, decrypt the message.

=#
include("challenge2.jl")


"""
Counts amount of characters from set "ETAOIN SHRDLU" in the given string (ascii/utf8)
"""
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

"""
Finds best match single character xor to match the given line with the
most commonly used letters in the english language.
Returns a tuple of (match string, amount of matches, match key)
"""
function best_match_english(hex, min=0::Int, max=128::Int)
    if isa(hex, String)
        hex = hex2bytes(hex)
    end
    xor_key = zeros(UInt8, length(hex))
    # Tuple of (string, amount, key)
    best_match = ("", 0, 0)
    for i in min:max
        fill!(xor_key, convert(UInt8, i))
        line = String(xor_hex_strings(hex, xor_key, true))
        amount = english_common_character_count(line)
        # Compare amount of matches to the current best amount of matches and take best
        if amount > best_match[2]
            best_match = (line, amount, i)
        end
    end

    return best_match
end

function main()
    hex = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"
    best_match = best_match_english(hex)
    println(best_match[1])
end

# main()
