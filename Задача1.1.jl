function  gcd_(a::Int,b::Int) 
    while !iszero(b)
        a,b=b,rem(a,b)
    end
    return abs(a)
end

function main()
    print(gcd_(4,12))
end

main()
