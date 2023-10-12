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
