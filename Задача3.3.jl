# Функция degree(n, p) вычисляет кратность делителя `p` в числе `n`.
function degree(n, p)
    k = 0
    n, r = divrem(n, p)
    while n > 0 && r == 0
        k += 1
        n, r = divrem(n, p)
    end
    return k
end

# Функция factorize(n::IntType) выполняет факторизацию числа `n` на простые множители.
function factorize(n::IntType) where IntType <: Integer
    list = NamedTuple{(:div, :deg), Tuple{IntType, IntType}}[]
    for p in eratosphenes_sieve(Int(ceil(n / 2)))
        k = degree(n, p) # Кратность делителя
        if k > 0
            push!(list, (div=p, deg=k))
        end
    end
    return list
end
