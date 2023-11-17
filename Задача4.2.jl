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
