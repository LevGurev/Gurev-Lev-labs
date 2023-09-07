function main(a::Int,b::Int)
    gcdx_(a::Int,b::Int)
end

function gcdx_(a::Int, b::Int)
    u,v=one(Int),zero(Int)
    u_,v_=v,u
    #ÈÍÂÀĞÈÀÍÒ: ÍÎÄ(a,b) = ÍÎÄ(a0,b0) && a = u*a0+v*b0 && b = u_*a0+v_*b0
    while !iszero(b)
        k,r=divrem(a,b)
        a,b=b,r #r=a-kb
        u,u_=u_,u-k*u_
        v,v_=v_,v-k*v_
    end
    if isnegative(a)
        a,u,v=-a,-u,-v
    end
    return a,u,v
end



print(main(5,12))