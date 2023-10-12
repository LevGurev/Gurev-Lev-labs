 # является ли заданное число простым
function isprime(n::IntType) where IntType <: Integer 
    for d in 2:IntType(ceil(sqrt(n)))
        if n % d == 0
            return false
        end
    end
    return true
end

println(isprime(8))
