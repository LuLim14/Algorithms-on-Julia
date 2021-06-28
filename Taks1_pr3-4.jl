function find_all_max(a)
    maxx = 0
    for i in 1:length(a)
        if a[i] > maxx
            maxx = a[i]
        end
    end
    res = Vector{Int}(undef, 0)
    j = 1
    for i in 1 : length(a)
        if a[i] == maxx
            push!(res, i)
        end
    end
    return res
end
