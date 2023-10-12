
function main(a::Int, M::Int)
    invmod_(a, M)
end

# Объявление функции gcdx_, которая используется для вычисления НОД с расширенным алгоритмом Евклида.
# Она возвращает только одно значение - обратное число a по модулю M.
function gcdx_(a::Int, b::Int)
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

    # Возвращаем только обратное число a по модулю M.
    return u
end

# Объявление функции gcd_, которая вычисляет НОД двух целых чисел.
function gcd_(a::Int, b::Int) 
    while !iszero(b)
        a, b = b, rem(a, b)
    end
    return abs(a)
end

# Объявление функции invmod_, которая вычисляет обратное число a по модулю M.
# Если НОД(a, M) не равен 1, функция возвращает `nothing`, иначе возвращает результат gcdx_.
function invmod_(a::Int, M::Int)
    if gcd_(a, M) != 1
        return nothing
    else
        return gcdx_(a, M)
    end
end

# Устанавливаем значения a и M.
a = 3
M = 26

# Выводим результат сравнения main(a, M) с invmod(a, M) и значение main(a, M).
# Результат должен быть `true`, если main(a, M) и invmod(a, M) возвращают одно и то же.
print(main(a, M) == invmod(a, M), ' ', main(a, M))
