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
