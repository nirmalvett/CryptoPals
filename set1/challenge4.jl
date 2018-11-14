#= S1C4

One of the 60-character strings in challenge4.txt has been encrypted by single-character XOR.

Find it.

=#
include("challenge3.jl")

function main()
    challenge4 = open("./set1/challenge4.txt", "r")

    # Tuple of (string, amount, key)
    best_match = ("", 0, 0)
    best_match_line = ""
    for line in eachline(challenge4)
        match = hex_best_match_english(line)
        # Compare amount of matches each line had and take best
        if(match[2] > best_match[2])
            best_match = match
            best_match_line = line
        end
    end

    close(challenge4)

    println(best_match_line)
    println("xor")
    println(best_match[3])
    println("=")
    println(best_match[1])
end

# main()
