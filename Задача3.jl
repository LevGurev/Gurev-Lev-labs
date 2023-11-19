#1
 # является ли заданное число простым
function isprime(n::IntType) where IntType <: Integer 
    for d in 2:IntType(ceil(sqrt(n)))
        if n % d == 0
            return false
        end
    end
    return true
end

println(isprime(8))

#2
# Функция eratosphenes_sieve выполняет алгоритм Решето Эратосфена для поиска простых чисел в диапазоне от 2 до n.
function eratosphenes_sieve(n::Integer)
    # Создание массива prime_indexes, где каждый элемент отображает, является ли число с данным индексом простым (true) или нет (false).
    prime_indexes = ones(Bool, n)
    prime_indexes[begin] = false  # 0 и 1 не считаются простыми числами.
    
    i = 2
    prime_indexes[i^2:i:n] .= false  # Отмечаем кратные 2 как непростые.
    
    i = 3
    while i <= n
        prime_indexes[i^2:2i:n] .= false  # Отмечаем кратные простому числу i как непростые.
        
        i += 1
        while i <= n && prime_indexes[i] == false
            i += 1
        end
    end
    
    # Возвращаем индексы, соответствующие простым числам в диапазоне от 2 до n.
    return findall(prime_indexes)
end

#3
Skip to content
LevGurev
/
Gurev-Lev-labs

Type / to search

Code
Issues
Pull requests
Actions
Projects
Wiki
Security
Insights
Settings
BreadcrumbsGurev-Lev-labs
/Задача3.3.jl
Go to file
t
Latest commit
LevGurev
LevGurev
Update Задача3.3.jl
0a02b84
 · 
last month
History
File metadata and controls

Code

Blame
22 lines (21 loc) · 748 Bytes
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
Gurev-Lev-labs/Задача3.3.jl at main · LevGurev/Gurev-Lev-labs  

#4
# Функция meanstd для вычисления среднего значения и стандартного отклонения элементов массива aaa.
function meanstd(aaa)
    T = eltype(aaa)  # Определение типа элементов в массиве aaa.
    n = 0
    s_first = zero(T)  # Инициализация переменной для суммы элементов.
    s_second = zero(T)  # Инициализация переменной для суммы квадратов элементов.

    # Проходим по элементам массива и вычисляем сумму и сумму квадратов элементов.
    for a in aaa
        n += 1
        s_first += a
        s_second += a * a
    end

    mean = s_first / n  # Вычисляем среднее значение.
    
    # Вычисляем стандартное отклонение, используя формулу: sqrt(s2 - mean^2), где s2 - среднее квадратов элементов.
    std_deviation = sqrt(s_second / n - mean * mean)
    
    return mean, std_deviation  # Возвращаем среднее значение и стандартное отклонение.
end

