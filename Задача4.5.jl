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
