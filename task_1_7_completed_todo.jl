function gcdx(a::Int, b::Int)
    u, v = one(Int), zero(Int)
    u_, v_ = v, u
    while !iszero(b)
        r, k = rem(a, b), div(a, b)
        a, b = b, r
        u, u_ = u_, u - k * u_
        v, v_ = v_, v - k * v_
    end
    if a < 0
        a, u, v = -a, -u, -v
    end
    return a, u, v
end

function diaph_solve(a::Int, b::Int, c::Int)
    g, x0, y0 = gcdx(a, b)
    if c % g != 0
        return "nothing"
    end
    first_root = x0 * (c / g)
    second_root = y0 * (c / g)
    return first_root, second_root
end

struct Residue{T,M}
    a::T where{T<:Int64}
    Residue{T,M}(a) where{T<:Int64,M} = new(mod(a,M))
end

function inverse(a::Residue{T,M}) where{T<:Int64,M}
    if gcd(a.a,M) != 1
        return nothing
    else
        f,s,d = gcdx(a.a,M)
        return Residue{T,M}(s)
    end
end

Base. +(a::Residue{T,M}, b::Residue{T,M}) where {T<:Int64, M} = Residue{T,M}(a.a + b.a)
Base. -(a::Residue{T,M}, b::Residue{T,M}) where {T<:Int64, M} = Residue{T,M}(a.a - b.a)
Base. *(a::Residue{T,M}, b::Residue{T,M}) where {T<:Int64, M} = Residue{T,M}(a.a * b.a)
Base. -(a::Residue{T,M}) where {T<:Int64, M} = Residue{T,M}(-a.a)
Base. display(a::Residue{T,M}) where {T<:Int64, M} = println(a.a)

a = Residue{Int64, 3}(111)
b = Residue{Int64, 3}(112)
println(a+b)


struct Polynomial{T<:Integer}
    coeffs::Vector{T}
end

function Base. +(p::Polynomial{T}, q::Polynomial{T})where {T<:Integer}
    n, m = length(p.coeffs), length(q.coeffs)
    if n < m
        p, q = q, p
        n, m = m, n
    end
    coeffs = Vector{T}(undef, n)
    for i in 1:m
        coeffs[i] = p.coeffs[i] + q.coeffs[i]
    end
    for i in (m+1):n
        coeffs[i] = p.coeffs[i]
    end
    return Polynomial(coeffs)
end

function Base. -(p::Polynomial{T}, q::Polynomial{T})where {T<:Integer}
    n, m = length(p.coeffs), length(q.coeffs)
    if n < m
        p, q = q, p
        n, m = m, n
    end
    coeffs = Vector{T}(undef, n)
    for i in 1:m
        coeffs[i] = p.coeffs[i] - q.coeffs[i]
    end
    for i in (m+1):n
        coeffs[i] = p.coeffs[i]
    end
    return Polynomial(coeffs)
end

function Base. -(p::Polynomial{T})where {T<:Integer}
    return Polynomial(-p.coeffs)
end

function Base. *(p::Polynomial{T}, q::Polynomial{T})where {T<:Integer}
    n, m = length(p.coeffs), length(q.coeffs)
    coeffs = Vector{T}(undef, n+m-1)
    for i in 1:n
        for j in 1:m
            coeffs[i+j-1] += p.coeffs[i] * q.coeffs[j]
        end
    end
    return Polynomial(coeffs)
end

function Base. /(p::Polynomial{T}, q::Polynomial{T})where {T<:Integer}
    n, m = length(p.coeffs), length(q.coeffs)
    if n < m
        return Polynomial([0])
    end
    coeffs = copy(p.coeffs)
    for i in (n-m+1):-1:1
        c = coeffs[i+m-1] / q.coeffs[m]
        for j in 1:m
            coeffs[i+j-1] -= c * q.coeffs[j]
        end
        coeffs[i+m-1] = c
    end
    return Polynomial(coeffs[1:(n-m+1)])
end

function Base. display(io::IO, p::Polynomial{T}) where {T<:Integer}
    n = length(p.coeffs)
    if n == 0
        print(io, "0")
        return
    end
    if n == 1
        print(io, p.coeffs[1])
        return
    end
    if p.coeffs[n] != 1
        print(io, p.coeffs[n])
    end
    print(io, "x^", n-1)
    for i in (n-2):-1:2
        if p.coeffs[i+1] == 0
            continue
        elseif p.coeffs[i+1] > 0
            print(io, " + ")
        else
            print(io, " - ")
        end
        if abs(p.coeffs[i+1]) != 1
            print(io, abs(p.coeffs[i+1]))
        end
        print(io, "x^", i)
    end
    if p.coeffs[2] == 0
        if p.coeffs[1] != 0
            if p.coeffs[1] > 0
                print(io, " + ", p.coeffs[1])
            else
                print(io, " - ", -p.coeffs[1])
            end
        end
    else
        if p.coeffs[2] > 0
            print(io, " + ")
        else
            print(io, " - ")
        end
        if abs(p.coeffs[2]) != 1
            print(io, abs(p.coeffs[2]))
        end
        print(io, "x")
        if p.coeffs[1] != 0
            if p.coeffs[1] > 0
                print(io, " + ", p.coeffs[1])
            else
                print(io, " - ", -p.coeffs[1])
            end
        end
    end
end


function Base. display(io::IO, p::Polynomial{T}) where{T<:Integer}
    n = length(p.coeffs)
    if n == 0
        print(io, "0")
        return
    end
    if n == 1
        print(io, p.coeffs[1])
        return
    end
    if p.coeffs[n] != 1
        print(io, p.coeffs[n])
    end
    print(io, "x^", n-1)
    for i in (n-2):-1:0
        if p.coeffs[i+1] == 0
            continue
        elseif p.coeffs[i+1] > 0
            print(io, " + ")
        else
            print(io, " - ")
        end
        if abs(p.coeffs[i+1]) != 1 || i == 0
            print(io, abs(p.coeffs[i+1]))
        end
        if i > 0
            print(io, "x^", i)
        end
    end
end

p = Polynomial([1, 2, 3])
println(p)
q = Polynomial([4, 5, 6])
println(q)
println(q+p)
println(q*p)
println(q/p)




Base. +(p::Polynomial{Residue{M}}, q::Polynomial{T}) where {T,M} = begin
    result = PolyMod()
    for i in 0:max(degree(p), degree(q))
        result[i+1] = p[i+1] + Mod(q[i+1])
    end
    result
end

Base. -(p::Polynomial{Residue{M}}, q::Polynomial{T}) where {T,M} = begin
    result = PolyMod()
    for i in 0:max(degree(p), degree(q))
        result[i+1] = p[i+1] - Mod(q[i+1])
    end
    result
end

Base. *(p::Polynomial{Residue{M}}, q::Polynomial{T}) where {T,M} = begin
    result = PolyMod(zero(T), p.degree() + q.degree())
    for i in 0:p.degree()
        for j in 0:q.degree()
            result[i+j+1] += p[i+1] * Mod(q[j+1])
        end
    end
    result
end