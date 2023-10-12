# Функция quicksort выполняет сортировку массива методом быстрой сортировки (quicksort).
function quicksort(array)
    if length(array) <= 1
        return array
    end
    pivot = array[rand(1:end)]
    left = filter(x -> x < pivot, array)
    middle = filter(x -> x == pivot, array)
    right = filter(x -> x > pivot, array)
    return vcat(quicksort(left), middle, quicksort(right))
end

# Вывод отсортированного массива.
println(quicksort([3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]))

# Функция sortperm выполняет сортировку индексов элементов массива arr в порядке возрастания значений.
function sortperm(arr)
    indices = Array(1:length(arr))
    sort!(indices, by = i -> arr[i])
    return indices
end

# Пример использования sortperm.
arr = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
sorted_indices = sortperm(arr)
println(sorted_indices)
println(arr[sorted_indices])

# Функция bubble_sort! выполняет сортировку массива методом сортировки пузырьком (bubble sort).
function bubble_sort!(arr)
    n = length(arr)
    for i in 1:n-1
        for j in 1:n-i
            if arr[j] > arr[j+1]
                arr[j], arr[j+1] = arr[j+1], arr[j]
            end
        end
    end
    return arr
end

# Функция comb_sort! выполняет сортировку массива методом сортировки расческой (comb sort).
function comb_sort!(a; factor=1.2473309)
    step = length(a)
    while step >= 1
        for i in 1:length(a)-step
            if a[i] > a[i+step]
                a[i], a[i+step] = a[i+step], a[i]
            end
        end
        step = Int(floor(step/factor))
    end
    bubble_sort!(a)
end

# Функция shell_sort выполняет сортировку массива методом сортировки Шелла (shell sort).
function shell_sort(arr)
    n = length(arr)
    gap = div(n, 2)
    while gap > 0
        for i in (gap+1):n
            temp = arr[i]
            j = i
            while j > gap && arr[j-gap] > temp
                arr[j] = arr[j-gap]
                j -= gap
            end
            arr[j] = temp
        end
        gap = div(gap, 2)
    end
    return arr
end

# Функция time_shell_sort измеряет время выполнения сортировки Шелла.
function time_shell_sort(arr)
    return @elapsed shell_sort(arr)
end

# Функция time_insertion_sort измеряет время выполнения сортировки вставкой.
function time_insertion_sort(arr)
    return @elapsed sort(arr)
end

# Функция random_array создает случайный массив длины n.
function random_array(n)
    return rand(n)
end

# Функция time_for_sizes измеряет время выполнения сортировок для разных размеров массивов.
function time_for_sizes(sizes)
    shell_times = []
    insertion_times = []
    for n in sizes
        arr = random_array(n)
        push!(shell_times, time_shell_sort(arr))
        push!(insertion_times, time_insertion_sort(arr))
    end
    return (shell_times, insertion_times)
end

# Задание размеров массивов для измерения времени сортировки.
sizes = [10^i for i in 1:6]

# Измерение времени для сортировки Шелла и сортировки вставкой.
shell_times, insertion_times = time_for_sizes(sizes)

# Вывод результатов измерений.
println("Shell sort times: ", shell_times)
println("Insertion sort times: ", insertion_times)

# Вывод среднего времени выполнения сортировки.
println("Shell sort time mean: ", mean(shell_times))
println("Insertion sort time mean: ", mean(insertion_times)

# Функция merge! выполняет слияние двух массивов в один.
function Base.merge!(a1, a2, a3)::Nothing
    i1, i2, i3 = 1, 1, 1
    @inbounds while i1 <= length(a1) && i2 <= length(a2)
        if a1[i1] < a2[i2]
            a3[i3] = a1[i1]
            i1 += 1
        else
            a3[i3] = a2[i2]
            i2 += 1
        end
        i3 += 1
    end
    if i1 > length(a1)
        a3[i3:end] .= @view(a2[i2:end])
    else
        a3[i3:end] .= @view(a1[i1:end])
    end
    nothing
end

# Функция merge_sort! выполняет сортировку массива методом слияния (merge sort).
function merge_sort!(a)
    b = similar(a)
    N = length(a)
    n = 1
    while n < N
            K = div(N, 2n)
        for k in 0:K-1
            merge!(@view(a[(1:n).+k*2n]), @view(a[(n+1:2n).+k*2n]), @view(b[(1:2n).+k*2n]))
        end
        if N - K*2n > n
            merge!(@view(a[(1:n).+K*2n]), @view(a[K*2n+n+1:end]), @view(b[K*2n+1:end]))
        elseif 0 < N - K*2n <= n
            b[K*2n+1:end] .= @view(a[K*2n+1:end])
        end
        a, b = b, a
        n *= 2
    end
    if isodd(log2(n))
        b .= a
        a = b
    end
    return a
end

# Функция part_sort! выполняет часть сортировки для быстрой сортировки.
function part_sort!(A, b)
    N = length(A)
    K, L, M = 0, 0, N
    @inbounds while L < M
        if A[L+1] == b
            L += 1
        elseif A[L+1] > b
            A[L+1], A[M] = A[M], A[L+1]
            M -= 1
        else
            L += 1
            K += 1
            A[L], A[K] = A[K], A[L]
        end
    end
    return @view(A[1:K]), @view(A[M+1:N])
end

# Функция quick_sort! выполняет быструю сортировку.
function quick_sort!(A)
    length(A) <= 1 && return A
    N = length(A)
    left, right = part_sort!(A, A[rand(1:N)])
    quick_sort!(left)
    quick_sort!(right)
    return A
end

# Функция median вычисляет медиану из элементов массива A.
function median(A::AbstractVector{T} where T<:Integer)
    if length(A) % 2 == 0
        return order_statistics!(A, length(A) / 2)
    else
        return (order_statistics!(A, length(A) / 2) + order_statistics!(A, length(A) / 2 + 1)) / 2
    end
end

using Random

# Создаем случайный массив A.
A = randperm(100000)[1:100000]

# Измеряем время выполнения различных сортировок и выводим результаты.
@showtime bubble_sort!(A)
@showtime comb_sort!(A)
@showtime shell_sort(A)
@showtime merge_sort!(A)
@showtime quick_sort!(A)

# Измеряем время выполнения стандартных сортировок.
@showtime sort(A, alg=InsertionSort)
@showtime sort(A, alg=QuickSort)
@showtime sort(A, alg=MergeSort)

