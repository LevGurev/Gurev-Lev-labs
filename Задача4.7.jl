using LinearAlgebra

function solve_lu(n)
    A = randn(n, n)
    b = randn(n)
    
    @time begin
        luA = lu(A)
        x = luA \ b
    end
    
    return x

end

function gauss(n1)
    A = randn(n1,n1)
    b=randn(n1)
    n = size(A, 1)
    Ab = [A b]
    for k = 1:n-1

        max_row = k
        for i = k+1:n
            if abs(Ab[i,k]) > abs(Ab[max_row,k])
                max_row = i
            end
        end
        Ab[k,:], Ab[max_row,:] = Ab[max_row,:], Ab[k,:]
        

        for i = k+1:n
            factor = Ab[i,k] / Ab[k,k]
            Ab[i,k:end] -= factor * Ab[k,k:end]
        end
    end
    
    x = zeros(Float64, n) 
    for i = n:-1:1
        x[i] = (Ab[i,end] - dot(Ab[i,i+1:end-1], x[i+1:end])) / Ab[i,i]
    end
    
    return x
end



println(@elapsed solve_lu(100))
println(@elapsed gauss(100))