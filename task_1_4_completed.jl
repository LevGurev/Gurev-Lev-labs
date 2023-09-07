function diaph_solve(a::Int, b::Int, c::Int)
    g,x0,y0=gcdx_(a::Int,b::Int)
    if c%g!=0
        return nothing
    end
    first_root=x0*(c/g)
    second_root=y0*(c/g)
    return first_root, second_root
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
    return a,u,v
end

#u = x0, v = y0

print(diaph_solve(4,6,8))