
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
