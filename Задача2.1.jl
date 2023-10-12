# Функция binpow для возведения числа a в степень n с использованием рекурсии.
function binpow(a::Float64, n::Float64)
    if n == 0
        return 1
    end
    if n % 2 == 1
        return binpow(a, n - 1) * a
    else
        b = binpow(a, n / 2)
        return b * b
    end
end

# Функция non_rec_binpow для быстрого возведения числа a в степень n без использования рекурсии.
function non_rec_binpow(a::Int64, n::Int64)
    res = 1
    while n > 0
        if n % 2 != 0
            res *= a
        end
        a *= a
        n = div(n, 2)
    end
    return res
end

# Вывод результата возведения числа 2 в 5-ю степень с использованием быстрого возведения.
println(non_rec_binpow(2, 5))
