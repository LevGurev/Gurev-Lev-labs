function matrix_rank(A)
    m, n = size(A)
    r = 0
    
    for j = 1:n

        i = findfirst(A[:,j] .!= 0)
        if i == nothing

            continue
        end
        

        if i != r+1
            A[[i, r+1],:] = A[[r+1, i],:]
        end
        

        for k = r+2:m
            c = A[k,j] / A[r+1,j]
            A[k,:] -= c * A[r+1,:]
        end
        

        r += 1
        

        if r == m
            break
        end
    end
    
    return r
end

A = [1 2 3; 4 5 6; 7 8 9]
println(matrix_rank(A))

