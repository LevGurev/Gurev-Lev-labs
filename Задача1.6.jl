struct Polynomial{T<:Number}
    coeffs::Vector{T}
end



function Base. +(p::Polynomial{T}, q::Polynomial{T})where {T<:Number}
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

function Base. -(p::Polynomial{T}, q::Polynomial{T})where {T<:Number}
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

function Base. -(p::Polynomial{T})where {T<:Number}
    return Polynomial(-p.coeffs)
end

function Base. *(p::Polynomial{T}, q::Polynomial{T})where {T<:Number}
    n, m = length(p.coeffs), length(q.coeffs)
    coeffs = Vector{T}(undef, n+m-1)
    for i in 1:n
        for j in 1:m
            coeffs[i+j-1] += p.coeffs[i] * q.coeffs[j]
        end
    end
    return Polynomial(coeffs)
end

function Base. /(p::Polynomial{T}, q::Polynomial{T})where {T<:Number}
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

function Base. display(io::IO, p::Polynomial{T}) where {T<:Number}
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


function Base. display(io::IO, p::Polynomial{T}) where{T<:Number}
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