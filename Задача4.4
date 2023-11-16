#4
#=
проходим матрицу по строкам в обратном порядке, элементу x[i] присваиваем значение b[i](свободный член) 
Затем происходит вычитание соответствующих элементов из следующих строк матрицы A, умноженных на x[j], 
чтобы получить ступенчатый вид матрицы. В конце каждой итерации делится x[i] на соответствующий элемент матрицы A для получения значения неизвестной.
=#
using LinearAlgebra
function shordan_gauss(A::AbstractMatrix{T}, b::AbstractVector{T})::AbstractVector{T} where T
    @assert size(A, 1) == size(A, 2)
    n = size(A, 1) 
    x = zeros(T, n)
 
    for i in n:-1:1
        x[i] = b[i]
        for j in i+1:n
            x[i] =fma(-x[j] ,A[i,j] , x[i]) 
        end
        x[i] /= A[i,i]
    end
    return x
end
