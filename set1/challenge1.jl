#= S1C1

The string:

'49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d'
Should produce:

'SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t'
So go ahead and make that happen. You'll need to use this code for the rest of the exercises.

=#
using Base64

#=

Converts hex string to base64 string and returns the base64

=#
function hex2base64(hex)
    io = IOBuffer();
    iob64_encode = Base64EncodePipe(io);
    write(iob64_encode, hex2bytes(hex));
    close(iob64_encode);
    b64 = String(take!(io));
    return b64
end


println(hex2base64("49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"))
