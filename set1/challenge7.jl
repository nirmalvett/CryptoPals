#= S1C7

The Base64-encoded content in challenge7.txt has been encrypted via AES-128 in ECB mode under the key

"YELLOW SUBMARINE".
(case-sensitive, without the quotes; exactly 16 characters; I like "YELLOW SUBMARINE" because it's exactly 16 bytes long, and now you do too).

Decrypt it. You know the key, after all.

=#
import Pkg
Pkg.add("Nettle")
using Nettle


function main()
    challenge7 = open("./set1/challenge7.txt") do file
        read(file, String)
    end

    challenge7 = base64decode(replace(challenge7, "\n" => ""))
    println(String(decrypt("AES128", "YELLOW SUBMARINE", challenge7)))
end

# main()
