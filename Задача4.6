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
 
