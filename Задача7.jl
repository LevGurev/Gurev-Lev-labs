# № 1 Генерация всех размещений с повторениями из n элементов {1,2,...,n} по k
function next_repit_placement!(p::Vector{T}, n::T) where T<:Integer
    i = findlast(x->(x < n), p) # используется встроенная функция высшего порядка
    # i - это последний(первый с конца) индекс: x[i] < n, или - nothing, если такого индекса нет (p == [n,n,...,n])
    isnothing(i) && (return nothing)
    p[i] += 1
    p[i+1:end] .= 1 # - устанавливаются минимально-возможные значения
    return p
end
 
println("Генерация всех размещений с повторениями из n элементов {1,2,...,n} по k")
println(next_repit_placement!([1, 1, 1], 3))

# ----------------Тест----------------
"""
n = 2; k = 3
p = ones(Int,k)
println(p)
while !isnothing(p)
    p = next_repit_placement!(p,n)
    println(p)
end
"""
# ------------------------------------

# № 2 Генерация вcех перестановок 1,2,...,n
function next_permute!(p::AbstractVector)
    n = length(p)
    k = 0 # firstindex(p) - 1
    for i in reverse(1:n - 1) # reverse(firstindex(p):lastindex(p) - 1)
        if p[i] < p[i + 1]
            k = i
            break
        end
    end
    k == firstindex(p) - 1 && return nothing # p[begin] > p[begin + 1] > ... > p[end]
 
    #утв: p[k] < p[k + 1] > p[k + 2] > ... > p[end]
    i = k + 1
    while i < n && p[i + 1] > p[k] # i < lastindex(p) && p[i + 1] > p[k]
        i += 1
    end
    #утв: p[i] - наименьшее из p[k + 1:end], большее p[k]
    p[k], p[i] = p[i], p[k]
    #утв: по-прежнему p[k + 1]>...>p[end]
    reverse!(@view p[k + 1:end])
    return p
end
 
println("Генерация всех размещений с повторениями из n элементов {1,2,...,n} по k")
println(next_permute!([1, 3, 4, 2]))
 
# ----------------Тест----------------
"""
p=[1,2,3,4]
println(p)
while !isnothing(p)
    p = next_permute!(p)
    println(p)
end
"""
# ------------------------------------

# № 3 Генерация всех всех подмножеств n-элементного множества {1,2,...,n}
println("Генерация всех всех подмножеств n-элементного множества {1,2,...,n} 1 способ")
 
# № 3.1 Первый способ - на основе генерации двоичных кодов чисел 0, 1, ..., 2^n-1
 
indicator(i::Integer, n::Integer) = reverse(digits(Bool, i; base=2, pad=n))
 
println("1 способ")
println(indicator(12, 5))
 
# № 3.2 Второй способ - на основе непосредственной генерации последовательности индикаторов в лексикографическом порядке
 
function next_indicator!(indicator::AbstractVector{Bool})
    i = findlast(x->(x==0), indicator)
    isnothing(i) && return nothing
    indicator[i] = 1
    indicator[i+1:end] .= 0
    return indicator 
end
 
println("2 способ")
println(next_indicator!(indicator(12, 5)))
 
# ----------------Тест----------------
"""
n=5; A=1:n
indicator = zeros(Bool, n)
println(indicator)
while !isnothing(indicator)
    A[findall(indicator)] |> println
    indicator = next_indicator!(indicator)
    println(indicator)
end
"""
# ------------------------------------
 
# № 4 Генерация всех k-элементных подмножеств n-элементного множества {1, 2, ..., n}
 
function next_indicator!(indicator::AbstractVector{Bool}, k)
    # в indicator - ровно k единц, остальные - нули, но это не проверяется! (фактически k - не используется)
    i = lastindex(indicator)
    while indicator[i] == 0
        i -= 1
    end
    #УТВ: indic[i] == 1 и все справа - нули(считаем единицы)
    m = 0 
    while i >= firstindex(indicator) && indicator[i] == 1 
        m += 1
        i -= 1
    end
    if i < firstindex(indicator)
        return nothing
    end
    #УТВ: indicator[i] == 0 и справа m > 0 единиц, причем indicator[i + 1] == 1
    indicator[i] = 1
    indicator[i + 1:end] .= 0
    indicator[lastindex(indicator) - m + 2:end] .= 1
    return indicator 
end
 
println("Генерация всех k-элементных подмножеств n-элементного множества {1, 2, ..., n}")
n = 6
k = 3
a = 1:6
println(a[findall(next_indicator!([zeros(Bool, n-k); ones(Bool, k)], k))])
 
# ----------------Тест----------------
"""
n=6; k=3; A=1:n
indicator = [zeros(Bool,n-k); ones(Bool,k)]
A[findall(indicator)] |> println
for !isnothing(indicator)
    indicator = next_indicator!(indicator, k)
    A[findall(indicator)] |> println
end
"""
# ------------------------------------
 
# № 5 Генерация всех разбиений натурального числа на положительные слагаемые
 
function next_split!(s ::AbstractVector{Int64}, k)
    k == 1 && return (nothing, 0)
    i = k-1 # - это потому что s[k] увеличивать нельзя
    while i > 1 && s[i-1]>=s[i]
        i -= 1
    end
    #УТВ: i == 1 или i - это наименьший индекс: s[i-1] > s[i] и i < k
    s[i] += 1
    #Теперь требуется s[i+1]... - уменьшить минимально-возможным способом (в лексикографическом смысле) 
    r = sum(@view(s[i+1:k]))
    k = i+r-1 # - это с учетом s[i] += 1
    s[(i+1):(length(s)-k)] .= 1
    return s, k
end
 
println("Генерация всех разбиений натурального числа на положительные слагаемые")
println(next_split!(ones(Int64, 5), 5))
 
# ----------------Тест----------------
"""
n=5; s=ones(Int, n); k=n
println(s)
while !isnothing(s)
    println(s[1:k])
    s, k = next_split!(s, k)
    println(s)
end
"""
# ------------------------------------
 
# № 6 Специальные пользовательские типы и итераторы для генерации рассматриваемых комбинаторных объектов
# next_rep_plasement(c::Vector, n) - для генерации размещений с повторениями
# next_permute(p::AbstractVector) - для генерации перестановок
# next_indicator(indicator::AbstractVector{Bool}) - для генерации всех подмножеств
# next_indicator(indicator::AbstractVector{Bool}, k) - для генерации k-элементных подмножеств
# next_split(s::AbstractVector{Integer}, k) - для генерации разбиений
 
# Абстрактный пользовательский тип для генерации комбинаторных объектов
abstract type AbstractCombinObject
    # value::Vector{Int} - это поле предполагается у всех конкретных типов, наследующих от данного типа
end


Base.iterate(obj::AbstractCombinObject) = (get(obj), nothing)
Base.iterate(obj::AbstractCombinObject, state) = (isnothing(next!(obj)) ? nothing : (get(obj), nothing))
 
 
# № 6.1 Размещения с повторениями
struct RepitPlacement{N,K} <: AbstractCombinObject
    value::Vector{Int}
    #генерирует следующее размещение с повторениями для числа N
    RepitPlacement{N,K}() where {N, K} = new(ones(Int, K))
end
 
Base.get(p::RepitPlacement) = p.value
next!(p::RepitPlacement{N,K}) where {N, K} = next_repit_placement!(p.value, N)


println("Размещения с повторениями")
for a in RepitPlacement{2,3}() 
    println(a)
end

 
# № 6.2 структура для представления перестановок
struct Permute{N} <: AbstractCombinObject
    value::Vector{Int}
    Permute{N}() where N = new(collect(1:N))
end
 
Base.get(obj::Permute) = obj.value
next!(permute::Permute) = next_permute!(permute.value)
 

println("Перестановки")
for p in Permute{4}()
    println(p)
end

 
# № 6.3 Все подмножества N-элементного множества
struct Subsets{N} <: AbstractCombinObject
    indicator::Vector{Bool}
    Subsets{N}() where N = new(zeros(Bool, N))
end
 
Base.get(sub::Subsets) = sub.indicator
next!(sub::Subsets) = next_indicator!(sub.indicator) 
 

println("Все подмножества N-элементного множества")
for sub in Subsets{4}()
    println(sub)
end

 
# № 6.4 k-элементные подмоножества n-элементного множества
struct KSubsets{M,K} <: AbstractCombinObject
    indicator::Vector{Bool}
    KSubsets{M, K}() where{M, K} = new([zeros(Bool, length(M)-K); ones(Bool, K)])
end
 
Base.get(sub::KSubsets) = sub.indicator
next!(sub::KSubsets{M, K}) where{M, K} = next_indicator!(sub.indicator, K) 
 
for sub in KSubsets{1:6, 3}()
    sub |> println
end
 
# № 6.5 Разбиения
mutable struct NSplit{N} <: AbstractCombinObject
    value::Vector{Int}
    num_terms::Int # число слагаемых (это число мы обозначали - k)
    NSplit{N}() where N = new(vec(ones(Int, N)), N)
end
 
Base.get(nsplit::NSplit) = nsplit.value[begin:nsplit.num_terms]
function next!(nsplit::NSplit)
    a, b = next_split!(nsplit.value, nsplit.num_terms)
    if isnothing(a) return nothing end
    nsplit.value, nsplit.num_terms = a, b
    get(nsplit)
end
 
println("Разбиения")
for s in NSplit{5}()
    println(s)
end
 
# № 7 Функция проверки является ли заданный граф связным.
 
# Алгоритм обхода или поиска графовых структур данных
 
#Поиск в глубину
# Граф в виде ассоциативного массива, где ключи представляют вершины графа, а значения - списки смежных вершин

function dfs(graph::AbstractDict, start::T) where T <: Integer
    stack = [start]
    push!(stack, start)
    visited = falses(length(graph))
    visited[start] = true
    while !isempty(stack)
        v = pop!(stack)
        #graph[v] представляет список смежных вершин для вершины v.
        for u in graph[v] 
            if !visited[u]
                visited[u] = true
                push!(stack, u)
            end
        end
    end
    return visited
end



#Поиск в ширину
function bfs(graph::Dict{T, Vector{T}}, start::T) where T<:Integer
    queue = Queue{T}()
    enqueue!(queue, start)
    visited = falses(length(graph))
    visited[start] = true
    while !isempty(queue)
        v = dequeue!(queue)
        for u in graph[v] 
            visited[u] = (!visited[u] ? (enqueue!(queue, u); true) : true)
        end
    end
    return visited
end
#-----------------------------------------------------------------

graph1 = Dict{Int64, Vector{Int64}}([(1, [3]), (2, [4]), (3, [1]), (4, [2, 5]), (5, [4])])
graph2 = Dict{Int64, Vector{Int64}}([(1, [2, 3]), (2, [1, 4]), (3, [1]), (4, [2, 5]), (5, [4])])
graph3 = Dict{Int64, Vector{Int64}}([(1, [2, 3]), (2, [1, 4]), (3, [1, 6]), (4, [2, 5]), (5, [4, 6]), (6, [3, 5])])
graph4 = Dict{Int64, Vector{Int64}}([(1, [2, 3]), (2, [1, 3, 4]), (3, [1, 2]), (4, [2, 5]), (5, [4])])
println(dfs(graph2, 1))

# Функция проверки графа на связность
function is_connected_graph(graph::AbstractDict) :: Bool
    res = dfs(graph, 1)
    return all(res)
end
println(is_connected_graph(graph1))


# № 8 Функция поиска компонент связности графа.
# Граф в виде ассоциативного массива, где ключи представляют вершины графа, а значения - списки смежных вершин.
function find_connectivity_components(graph::AbstractDict, len = length(graph))
    mark = ones(Bool, len)
    #будет содержать все компоненты связности
    ans = []
    for i in 1:len
        if mark[i]
            t = dfs(graph, i)
            push!(ans, t)
            mark[findall(t)] .= false
        else
            push!(ans, Bool[0])
        end
    end    
    return ans
end
 
println(find_connectivity_components(graph1))
 
# № 9 Функция проверки является ли заданный граф двудольным.
#Граф считается двудольным, если его вершины можно разделить на две группы таким образом, 
#что все ребра графа соединяют вершины из разных групп.
function  isDual(graph::AbstractDict, len = length(graph)) :: Bool
    color = fill(-1, len)
    queue = []
    for i in 1:len
        if color[i] != -1 
            continue
        end
        color[i] = 0
        push!(queue, i)
        while !isempty(queue)
            v = popfirst!(queue)
            if !isnothing(findfirst(isequal(color[v]), color[graph[v]]))
                return false 
            end
            found = graph[v][findall(isequal(-1), color[graph[v]])]
            color[found] .= (color[v] + 1) % 2
            append!(queue, found)
        end
    end
    return true
end

println(isDual(graph1))
println(isDual(graph2))
println(isDual(graph3))
println(isDual(graph4))