function binpow(a::Float64, n::Float64)
    if (n==0)
        return 1
    end
    if (n%2==1)
        return binpow(a,n-1)*a
    else
        b=binpow(a,n/2)
        return b*b
    end
end


function non_rec_binpow(a::Int64, n::Int64)
    res=1                                   
    while n>0                               
        if n%2!=0                           
            res*=a                          
        end 
        a*=a                                
        n=div(n,2)                          
    end
    return res                  
end



println(non_rec_binpow(2,5))