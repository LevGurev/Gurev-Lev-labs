#1
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

#2
# 2. На база этой функции написать другую функцию, возвращающую n-ый член последовательности Фибоначчи (сложность - O(log n)).

struct Matrix{T}
    a11::T
    a12::T
    a21::T
    a22::T
end

Matrix{T}() where T = Matrix{T}(zero(T), zero(T), zero(T), zero(T))

Base. one(::Type{Matrix{T}}) where T = Matrix{T}(one(T), zero(T), zero(T), one(T))

Base. one(M::Matrix{T}) where T = Matrix{T}(one(T), zero(T), zero(T), one(T))

Base. zero(::Type{Matrix{T}}) where T = Matrix{T}()

function Base. *(M1::Matrix{T}, M2::Matrix{T}) where T
    a11 = M1.a11 * M2.a11 + M1.a12 * M2.a21
    a12 = M1.a11 * M2.a12 + M1.a12 * M2.a22
    a21 = M1.a21 * M2.a11 + M1.a22 * M2.a21
    a22 = M1.a21 * M2.a12 + M1.a22 * M2.a22
    Res = Matrix{T}(a11, a12, a21, a22)
    return Res
end

function fibonachi(n::Int)
    Tmp = Matrix{Int}(1, 1, 1, 0) 
    Tmp = deg(Tmp, n)
    return Tmp.a11    
end

#3
# 3. Функция, вычисляющая с заданной точностью $\log_a x$

function log(a, x, e) # a > 1        
    z = x
    t = 1
    y = 0
    #ИНВАРИАНТ z^t * a^y = x
    while z < 1/a || z > a || t > e 
        if z < 1/a
            z *= a 
            y -= t 
        elseif z > a
            z /= a
            y += t
        elseif t > e
            t /= 2 
            z *= z 
        end
    end
    return y
end

#4
# 4. Функция, реализующая приближенное решение уравнения вида $f(x)=0$ методом деления отрезка пополам

function bisection(f::Function, a, b, epsilon)
    if f(a)*f(b) < 0 && a < b
        f_a = f(a)
        #ИНВАРИАНТ: f_a*f(b) < 0
        while b-a > epsilon
            t = (a+b)/2
            f_t = f(t)
            if f_t == 0
                return t
            elseif f_a*f_t < 0
                b=t
            else
                a, f_a = t, f_t
            end
        end  
        return (a+b)/2
    else
        @warn("Некоректные данные")
    end
end

# 5. Приближенное решение уравнения   $\cos x = x$ методом деления отрезка пополам.

bisection(x->cos(x)-x, 0, 1, 1e-8)

# 6. Функцию, реализующую метод Ньютона приьлиженного решения уравнения вида $f(x)=0$

function newton(r::Function, x, epsilon, num_max = 10)
    dx = -r(x)
    k=0
    while abs(dx) > epsilon && k <= num_max
        x += dx
        dx = -r(x)
        k += 1
    end
    k > num_max && @warn("Требуемая точность не достигнута")
    return x
end

# 7. Методом Ньютона приближеннное решение уравнения $\cos x = x$

f(x) = cos(x) - x

r(x) = -f(x)/(sin(x)+1)

# 8. Методом Ньютона приближеннное значение какого-либо вещественного корня многочлена, заданного своими коэффициенами

p(x) = 6*x^5 - 23*x^4 + 12*x^2 + 86

rp(x) = p(x) / (30*x^4 - 92*x^3 + 24*x)
