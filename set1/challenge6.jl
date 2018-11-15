#=

There's a file challenge6.txt. It's been base64'd after being encrypted with repeating-key XOR.

Decrypt it.

=#
using Base64
include("challenge3.jl")
include("challenge5.jl")


"""
Calculating the hamming distance between 2 byte arrays
"""
function hamming_distance(val1, val2)
    if isa(val1, String)
        val1 = Vector{UInt8}(val1)
    end
    if isa(val2, String)
        val2 = Vector{UInt8}(val2)
    end
    if length(val1) != length(val2)
        throw(ArgumentError("To calculate the hamming distance the arrays must be the same length"))
    end

    bitDiff = 0
    for i in 1:length(val1), j in 0:7
        if (val1[i] >> j) & 1 != (val2[i] >> j) & 1
            bitDiff += 1
        end
    end
    return bitDiff
end

"""
Returns the key sizes tried in order of likelihood of it being the key
Eg. output[1] is the most likely key size followed by output[2], output[3], etc.
"""
function most_likely_key_sizes(bytes, min=2::Int, max=40::Int)
    output = []
    for size in min:max
        dist = 0
        iter = 0
        for i in 1:2:trunc(Int, length(bytes)/size) - 1
            iter += 1
            dist += hamming_distance(bytes[((i - 1) * size) + 1: i * size], bytes[(i * size) + 1: (i + 1) * size])
        end
        dist /= (iter * size)
        push!(output, (size, dist))
        # Commented out is the way that was specified on the site, they answer seems to rank lower
        # probability than expected (around rank 6) so using the above way instead (impact on effieciency)
        #=
        dist = hamming_distance(bytes[1:size], bytes[size + 1: 2 * size])
        dist += hamming_distance(bytes[2 * size + 1: 3 * size], bytes[3 * size + 1: 4 * size])
        dist /= 2 * size
        push!(output, (size, dist))
        =#
    end
    output = sort(output, by=x->x[2])
    return [output[i][1] for i = 1:length(output)]
end

"""
Returns an 2d array of bytes, broken up in groups of n. If the amount
of bytes does not cleanly devide by n the remaining bytes are discarded.
"""
function byte_blocks(bytes, n::Int64)
    output = []
    for i in 1:n:length(bytes) - n + 1
        push!(output, bytes[i: (i + n) - 1])
    end
    return output
end

"""
Takes a 2d array and returns another 2d array with all the nth indexes of each
row grouped together. (Transposes a 2d matrix)
Eg. [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]] outputs [[1, 5, 9], [2, 6, 10], [3, 7, 11], [4, 8, 12]]
"""
function array_index_group(array)
    output = []
    for i in 1:length(array[1])
        push!(output, [])
    end

    for i in 1:length(array)
        for j in 1:length(array[i])
            push!(output[j], array[i][j])
        end
    end
    return output
end

function main()
    # Test the hamming_distance method, should be 37
    println(hamming_distance("this is a test", "wokka wokka!!!"))
    challenge6 = open("./set1/challenge6.txt") do file
        read(file, String)
    end

    # Strip new line characters and convert to byte array
    challenge6 = base64decode(replace(challenge6, "\n" => ""))
    # Get list of key sizes ordered in probability of the size being the key
    key_size_prob = most_likely_key_sizes(challenge6)
    # Loop through the top 3 probable key sizes and find the best match key for each sizes
    for i in 1:3
        # Cut the byte array of data into blocks of the size we are attempting and transpose the blocks
        # such that each byte that was xor with a certain character in the repeating xor key are grouped together
        key_grouped_data = array_index_group(byte_blocks(challenge6, key_size_prob[i]))
        key = UInt8[]
        # Find the best match character key for each of the grouped up data arrays
        for j in 1:length(key_grouped_data)
            match = best_match_english(key_grouped_data[j])
            push!(key, match[3])
        end
        println(String(key))
    end
end

# main()
