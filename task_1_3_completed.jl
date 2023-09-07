function main(a::Int,M::Int)
    invmod_(a::Int,M::Int)
end


function gcdx_(a::Int, b::Int)
    u,v=one(Int),zero(Int)
    u_,v_=v,u
    while !iszero(b)
        r,k=rem(a,b),div(a,b)
        a,b=b,r
        u,u_=u_,u-k*u_
        v,v_=v_,v-k*v_
    end
    if a<0
        a,u,v=-a,-u,-v
    end
    return u
end

function  gcd_(a::Int,b::Int) 
    while !iszero(b)
        a,b=b,rem(a,b)
    end
    return abs(a)
end

function invmod_(a::Int,M::Int)
    if gcd_(a::Int,M::Int)!=1
        return nothing
    else
        return gcdx_(a::Int,M::Int)
    end
end

a=3
M=26


print(main(a,M)==invmod(a,M),' ', main(a,M))