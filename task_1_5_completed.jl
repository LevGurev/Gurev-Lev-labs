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

function diaph_solve(a::Int, b::Int, c::Int)
    g,x0,y0=gcdx_(a::Int,b::Int)
    if c%g!=0
        return "nothing"
    end
    first_root=x0*(c/g)
    second_root=y0*(c/g)
    return first_root, second_root
end

struct Residue{T,M}
    a::T where{T<:Int64}
    Residue{T,M}(a) where{T<:Int64,M} = new(mod(a,M))
end

function inverse(a::Residue{T,M}) where{T<:Int64,M}
    if (gcd(a.a),M)!=1
        return nothing
    else
        f,s,d=gcdx_(a.a,M)
        return Residue{T,M}(s)
    end
end

Base. +(a::Residue{T,M}, b::Residue{T,M}) where {T<:Int64, M} = Z{T,M}(a.a+b.a)
Base. -(a::Residue{T,M}, b::Residue{T,M}) where {T<:Int64, M} = Z{T,M}(a.a-b.a)
Base. *(a::Residue{T,M}, b::Residue{T,M}) where {T<:Int64, M} = Z{T,M}(a.a*b.a)
Base. -(a::Residue{T,M}) where {T<:Int64, M} = Z{T,M}(-a.a)
Base. display(a::Residue{T,M}) where{T<:Int64,M} = println(a.a)

a = Residue{Int64, 3}(112)
print(a)


