#= S1C8

In challenge8.txt are a bunch of hex-encoded ciphertexts.

One of them has been encrypted with ECB.

Detect it.

=#
include("challenge6.jl")


"""
Counts the amount of repeated blocks in a 2d array
Eg. [[1, 1, 1], [0, 0, 0], [1, 1, 1]] will return 1 because there
was 1 repetition of the same block
"""
function repeat_count(array::Array)
    count = 0
    for i in 1:length(array)-1, j in i+1:length(array)
        if array[i] == array[j]
            count += 1
        end
    end
    return count
end

function main()
    challenge8 = open("./set1/challenge8.txt")
    # Tuple of most repeated line and amount of repition in the line
    most_repetition = ("", 0)
    for line in eachline(challenge8)
        bytes = byte_blocks(hex2bytes(line), 16)
        repetition = repeat_count(bytes)
        if repetition > most_repetition[2]
            most_repetition = (line, repetition)
        end
    end

    close(challenge8)
    println(most_repetition)
end

# main()
