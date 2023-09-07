function determinant(Matrix)
    n, m = size(Matrix)
    if n != m
        error("Matrix should be squared")
    end
    

    for t in 1:m-1
        for i in t+1:n
            c = Matrix[i, t] / Matrix[t, t]
            Matrix[i, t] = 0
            for j in t+1:m
                Matrix[i, j] -= c * Matrix[t, j]
            end
        end
    end
    

    det = 1
    for i in 1:n
        if abs(Matrix[i, i]) < eps()
            return 0
        end
        det *= Matrix[i, i]
    end
    
    return det
end

A = [1 2 3; 4 5 6; 7 8 9]
println(determinant(A))

B = [1 2 3; 2 4 6; 3 6 9]
println(determinant(B))