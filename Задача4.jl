#4

#1
#=
считаем до n-ного заданного члена, term - значение n-ного члена ряда, sum - сумма ряда
=#
function exp_partial_sum(x::Real, n::Int)
    sum = 0.0				
    term = 1.0
    for i in 0:n
        sum += term
        term *= x / (i + 1)
    end
    return sum
end
 
println(exp_partial_sum(5.0, 6))
 

#2 
#=
вычисляем до того момента, пока term не будет влиять на значение y
=#
function exp_with_max_precision(x) ####
    y = 1.0
    term = 1.0
    k = 1
    while y + term != y ######
        term *= x / k
        y += term
        k += 1
    end
    return y
end
 
println(exp_with_max_precision(5.0))
 
#3
#j(x) = (x/2)^j * sum((-1)^k / (k! * (j + k)!) * (x/2)^(2k), k=0:inf)
#j - ord, x - arg
#=
выполняется, пока а влияет на s, переход к следующему члену переходит с помощью увеличения m на 1
=#
using Plots
function bessel(M::Integer, x::Real)
    sqrx = x*x
    a = 1/factorial(M)
    m = 1
    s = 0 
 
    while s + a != s
        s += a
        a = -a * sqrx /(m*(M+m)*4)
        m += 1
    end
 
    return s*(x/2)^M
end
 
values = 0:0.1:20
myPlot = plot()
for m in 0:5
    plot!(myPlot, values, bessel.(m, values))
end
display(myPlot)


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
 

#5

function TransformToSteps!(matrix::AbstractMatrix, epsilon::Real = 1e-7)::AbstractMatrix
	@inbounds for k in range(1:size(matrix, 1))
		absval, Δk = findmax(abs, @view(matrix[k:end,k]))

		(absval <= epsilon) && throw("vyroshd matrix")

		Δk > 1 && swap!(@view(matrix[k,k:end]), @view(matrix[k+Δk-1,k:end]))

		for i in k+1:size(matrix,1)
			t = matrix[i,k]/matrix[k,k]
			@. @views matrix[i,k:end] = matrix[i,k:end] - t * matrix[k,k:end] 
		end
	end	

	return matrix
end

#6

#=
Функция sumprod вычисляет скалярное произведение двух векторов, используя функцию fma, которая выполняет умножение и сложение с одной точностью и округлением. Это позволяет уменьшить ошибки округления при вычислении больших сумм.
Функция ReverseGauss! принимает на вход матрицу коэффициентов matrix и вектор свободных членов vec. Она создает вектор x, который будет содержать решение системы.  Затем выполняется цикл for, который проходит по строкам матрицы A в обратном порядке (от n до 1). 
В каждой итерации вычисляется значение неизвестной x[i] с помощью формулы обратного хода метода Жордана-Гаусса.  Для этого из вектора свободных членов вычитается скалярное произведение соответствующей строки матрицы и уже найденных значений неизвестных,
деленное на диагональный элемент матрицы. 
=#
@inline function sumprod(vec1::AbstractVector{T}, vec2::AbstractVector{T})::T where T
	s = zero(T)
	@inbounds for i in eachindex(vec1)
	s = fma(vec1[i], vec2[i], s) # fma(x, y, z) = x*y = z
	end
	return s
end
 
function ReverseGauss!(matrix::AbstractMatrix{T}, vec::AbstractVector{T})::AbstractVector{T} where T

 
	x = similar(vec)
	N = size(matrix, 1)
 
	for k in 0:N-1

		x[N-k] = (vec[N-k] - sumprod(@view(matrix[N-k,N-k+1:end]), @view(x[N-k+1:end]))) / matrix[N-k,N-k]
	end
 
	return x
end
 
