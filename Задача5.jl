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

println(quicksort([3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]))

function sortperm(arr)
    indices = Array(1:length(arr))
    sort!(indices, by = i -> arr[i])
    return indices
end

arr = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
sorted_indices = sortperm(arr)
println(sorted_indices)
println(arr[sorted_indices])

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

using Statistics
using Random


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


function time_shell_sort(arr)
    return @elapsed shell_sort(arr)
end


function time_insertion_sort(arr)
    return @elapsed sort(arr)
end


function random_array(n)
    return rand(n)
end


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

sizes = [10^i for i in 1:6]
shell_times, insertion_times = time_for_sizes(sizes)

println("Shell sort times: ", shell_times)
println("Insertion sort times: ", insertion_times)

println("Shell sort time mean: ", mean(shell_times))
println("Insertion sort time mean: ", mean(insertion_times))

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

function merge_sort!(a)
    b = similar(a) 
    N = length(a)
    n = 1 
    while n < N
        K = div(N,2n) 
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
            L += 1; K += 1
            A[L], A[K] = A[K], A[L]
        end
    end
    return @view(A[1:K]), @view(A[M+1:N])
end

function quick_sort!(A)
    length(A) <= 1 && return A
    N = length(A)
    left, right = part_sort!(A, A[rand(1:N)])
    quick_sort!(left)
    quick_sort!(right)
    return A
end

function median(A::AbstractVector{T} where T<:Integer)
    if length(A)%2==0
        return order_statistics!(A, length(A)/2)
    else
        return (order_statistics!(A, length(A)/2)+order_statistics!(A, length(A)/2+1))/2
    end
end

using Random
 
A = randperm(100000)[1:100000]
 
@showtime bubble_sort!(A)
@showtime comb_sort!(A)
@showtime shell_sort(A)
@showtime merge_sort!(A)
@showtime quick_sort!(A)
 
#= top sorts
bubble_sort(A): 9.740503 seconds (21.70 k allocations: 1.927 MiB, 0.14% compilation time)
insert_sort(A): 1.242766 seconds (7.11 k allocations: 1.119 MiB, 0.82% gc time, 1.25% compilation time)
comb_sort(A): 0.023961 seconds (20.77 k allocations: 1.875 MiB, 68.58% compilation time)
shell_sort(A): 0.108704 seconds (124.69 k allocations: 7.244 MiB, 43.83% compilation time)
merge_sort(A): 0.262546 seconds (831.54 k allocations: 38.854 MiB, 97.07% compilation time)
quick_sort(A): 0.083688 seconds (375.24 k allocations: 18.645 MiB, 14.96% gc time, 89.28% compilation time)
=#
 
@showtime sort(A,alg=InsertionSort)
@showtime sort(A,alg=QuickSort)
@showtime sort(A,alg=MergeSort)
 
#= lib sorts
sort(A, alg = InsertionSort): 1.206621 seconds (63.45 k allocations: 4.079 MiB, 2.13% compilation time)
sort(A, alg = QuickSort): 0.017171 seconds (15.88 k allocations: 1.670 MiB, 73.98% compilation time)
sort(A, alg = MergeSort): 0.051416 seconds (155.36 k allocations: 8.990 MiB, 89.43% compilation time)
=#

