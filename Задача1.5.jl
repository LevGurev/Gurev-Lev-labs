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
