function meanstd(aaa)
    T = eltype(aaa)
    n = 0; s_first = zero(T); s_second = zero(T)
    for a in aaa
        n += 1; s_first += a; s_second += a*a
    end
    mean = s_first/n
    return mean, sqrt(s_second/n - mean*mean)
end