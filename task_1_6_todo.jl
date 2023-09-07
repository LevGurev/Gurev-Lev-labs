struct Polynom{T}
    a::T
end

function Base. +(a::Polynom{T},b::Polynom{T}) where{T<:Vector}
    if length(a.a)>=length(b.a)
        for i in range(1,length(b.a))
            a.a[i]=a.a[i]+b.a[i]
        end
        return a.a
    else
        for i in range(1,length(a.a))
            b.a[i]=a.a[i]+b.a[i]
        end
        return b.a
    end
end

function Base. -(a::Polynom{T},b::Polynom{T}) where{T<:Vector}
    if length(a.a)>=length(b.a)
        for i in range(1,length(b.a))
            a.a[i]=a.a[i]-b.a[i]
        end
        return a.a
    else
        for i in range(1,length(b.a))
            b.a[i]=b.a[i] - 2*b.a[i]
        end

        for j in range(1,length(a.a))
            b.a[j]=b.a[j]+a.a[j]
        end
        return b.a
    end
end

function Base. -(a::Polynom{T}) where{T<:Vector}
    for i in range(length(a.a))
        a.a[i]=-a.a[i]
    end
    return a.a
end

function Base.:/(p1::Polynom{T}, p2::Polynom{T}) where{T<:Vector}
    n = p1.power       
    m = p2.power
    qPow = n - m     
    qCoefficients = zeros(Int64, qDegree + 1)
    for i in 1:qPow+1     
        qCoefficients[i] = 0
    end
    for i in n:-1:m      
        qCoefficients[i - m] = p1.coefficients[i] / p2.coefficients[m]
        for j in 1:m
            p1.coefficients[i - m + j] -= qCoefficients[i - m] * p2.coefficients[j]
        end
    end
    quotient = Polynom(qPow, qCoefficients)  
    finalize(qCoefficients)      
    return quotient
end


G=Polynom{Vector}([1,2,3,4])
F=Polynom{Vector}([1,2,3,4,5])
println(G+F)

K=Polynom{Vector}([1,2,3,4,6])
L=Polynom{Vector}([1,2,3,1,2])
println(K-L)

P1=Polynom{Vector}([1,3,4,5])
P2=Polynom{Vector}([1,4,5,6])
println(P1/P2)

#polyval