#1
# Объявление функции gcd_ для вычисления наибольшего общего делителя (НОД).
# Функция принимает два аргумента a и b, оба являются целыми числами.
function gcd_(a::Int, b::Int)
    while !iszero(b)
        a, b = b, rem(a, b)
    end
    # Возвращаем абсолютное значение a, что является НОДом a и b.
    return abs(a)
end
function main()
    # Выводим результат вызова функции gcd_ с аргументами 4 и 12.
    # Это выведет НОД(4, 12) в консоль.
    print(gcd_(4, 12))
end
main()

#2
function main(a::Int, b::Int)
    # Вызываем функцию gcdx_ с аргументами a и b, но не сохраняем её результат.
    # Поэтому эта функция не вернет ничего, и мы не увидим результат.
    gcdx_(a, b)
end

# Объявление функции gcdx_, которая используется для вычисления НОД с расширенным алгоритмом Евклида.
function gcdx_(a::Int, b::Int)
    u, v = one(Int), zero(Int)
    u_, v_ = v, u

    # ИНВАРИАНТ: НОД(a, b) = НОД(a0, b0) && a = u * a0 + v * b0 && b = u_ * a0 + v_ * b0

    while !iszero(b)
        k, r = divrem(a, b)
        a, b = b, r  # r = a - k * b
        u, u_ = u_, u - k * u_
        v, v_ = v_, v - k * v_
    end

    # Если a отрицательное, меняем его знак, а также знаки u и v, чтобы учесть это в инварианте.
    if isnegative(a)
        a, u, v = -a, -u, -v
    end

    # Возвращаем тройку значений: a, u и v.
    return a, u, v
end

# Вызываем функцию main с аргументами 5 и 12 и выводим результат в консоль.
print(main(5, 12))

#3

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

#4
# Объявление функции diaph_solve, которая решает диофантово уравнение ax + by = c,
# где a, b и c - целые числа.
function diaph_solve(a::Int, b::Int, c::Int)
    # Вызываем функцию gcdx_ для вычисления НОД(a, b) и коэффициентов x0 и y0.
    g, x0, y0 = gcdx_(a::Int, b::Int)
    
    # Проверяем, делится ли c на НОД(a, b) без остатка.
    if c % g != 0
        return nothing  # Если не делится, возвращаем `nothing`.
    end
    
    # Вычисляем первый и второй корни (решения) уравнения.
    first_root = x0 * (c / g)
    second_root = y0 * (c / g)
    
    # Возвращаем корни как результат.
    return first_root, second_root
end

# Объявление функции gcdx_, которая используется для вычисления НОД(a, b) и коэффициентов x0 и y0.
# Реализация расширенного алгоритма Евклида для этой цели.
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

    # Возвращаем НОД(a, b) и коэффициенты x0 и y0.
    return a, u, v
end

# Вызываем функцию diaph_solve с аргументами 4, 6 и 8 и выводим результат.
print(diaph_solve(4, 6, 8))

#5
# Объявление функции gcdx_, которая используется для вычисления НОД(a, b) и коэффициентов x и y.
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

    # Возвращаем НОД(a, b) и коэффициенты x и y.
    return a, u, v
end

# Объявление функции diaph_solve, которая решает диофантово уравнение ax + by = c,
# где a, b и c - целые числа.
function diaph_solve(a::Int, b::Int, c::Int)
    g, x0, y0 = gcdx_(a::Int, b::Int)
    
    # Проверяем, делится ли c на НОД(a, b) без остатка.
    if c % g != 0
        return "nothing"  # Если не делится, возвращаем строку "nothing".
    end
    
    # Вычисляем первый и второй корни (решения) уравнения.
    first_root = x0 * (c / g)
    second_root = y0 * (c / g)
    
    # Возвращаем корни как результат.
    return first_root, second_root
end

# Объявление пользовательской структуры Residue для арифметики по модулю.
# Эта структура хранит значение a и модуль M.
struct Residue{T, M}
    a::T where {T<:Int64}
    
    # Конструктор структуры, гарантирующий, что a находится в пределах модуля M.
    Residue{T, M}(a) where {T<:Int64, M} = new(mod(a, M))
end

# Функция inverse(a) для вычисления обратного элемента a по модулю M.
# Возвращается обратный элемент a или `nothing`, если НОД(a, M) != 1.
function inverse(a::Residue{T, M}) where {T<:Int64, M}
    if gcd(a.a, M) != 1
        return nothing
    else
        # Используем функцию gcdx_ для вычисления обратного элемента.
        f, s, d = gcdx_(a.a, M)
        return Residue{T, M}(s)
    end
end

# Перегрузка операторов +, -, *, и - для структуры Residue.
# Операции выполняются по модулю M.
Base.+(a::Residue{T, M}, b::Residue{T, M}) where {T<:Int64, M} = Residue{T, M}(a.a + b.a)
Base.-(a::Residue{T, M}, b::Residue{T, M}) where {T<:Int64, M} = Residue{T, M}(a.a - b.a)
Base.*(a::Residue{T, M}, b::Residue{T, M}) where {T<:Int64, M} = Residue{T, M}(a.a * b.a)
Base.-(a::Residue{T, M}) where {T<:Int64, M} = Residue{T, M}(-a.a)
Base.display(a::Residue{T, M}) where {T<:Int64, M} = println(a.a)

# Создаем объект Residue и выводим его значение.
a = Residue{Int64, 3}(112)
print(a)

#6
# Объявление структуры Polynomial для представления многочленов.
struct Polynomial{T<:Number}
    coeffs::Vector{T}
end

# Перегрузка оператора + для сложения многочленов p и q.
# Результат - новый многочлен.
function Base. +(p::Polynomial{T}, q::Polynomial{T}) where {T<:Number}
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

# Перегрузка оператора - для вычитания многочленов p и q.
# Результат - новый многочлен.
function Base. -(p::Polynomial{T}, q::Polynomial{T}) where {T<:Number}
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

# Перегрузка оператора - для унарного минуса многочлена.
# Результат - новый многочлен с коэффициентами, противоположными коэффициентам исходного многочлена.
function Base. -(p::Polynomial{T}) where {T<:Number}
    return Polynomial(-p.coeffs)
end

# Перегрузка оператора * для умножения многочленов p и q.
# Результат - новый многочлен.
function Base. *(p::Polynomial{T}, q::Polynomial{T}) where {T<:Number}
    n, m = length(p.coeffs), length(q.coeffs)
    coeffs = Vector{T}(undef, n + m - 1)
    for i in 1:n
        for j in 1:m
            coeffs[i+j-1] += p.coeffs[i] * q.coeffs[j]
        end
    end
    return Polynomial(coeffs)
end

# Перегрузка оператора / для деления многочленов p и q.
# Результат - новый многочлен. Если степень p меньше степени q, результат - многочлен [0].
function Base. /(p::Polynomial{T}, q::Polynomial{T}) where {T<:Number}
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

# Перегрузка функции display для вывода многочлена в человеко-читаемом виде.
function Base.display(io::IO, p::Polynomial{T}) where {T<:Number}
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

# Создание многочленов и выполнение операций над ними.
p = Polynomial([1, 2, 3])
println(p)

q = Polynomial([4, 5, 6])
println(q)

println(q + p)
println(q - p)
println(q * p)
println(q / p)
