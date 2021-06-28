

import Base.merge

function merge(V1::Vector{T}, V2::Vector{T})::Vector{T} where T
    i, j = 1, 1
    v = Array{Int}(undef, length(V1) + length(V2))
    for k in 1:(length(V1) + length(V2))
        if (i != ength(V1) + 1 && (j == length(V2)+1 || V1[i] < V2[j]))
            v[k] = V1[i]
            i += 1
        elseif (j != length(V2) + 1)
            v[k] = V2[j]
            j += 1
        end
    end
    return v
end

#Task1

function mergesort(v)
    if (length(v) > 1)
        v1 = mergesort(@view v[1:div(length(v), 2)]) 
        v2 = mergesort(@view v[div(length(v), 2) + 1:length(v)])
        return merge(v1, v2)
    else
        return copy(v)
    end
end

#Task2

function mergesort2(v)
    i = 1
    k = 1
    while (2 * k < length(v))
        if (i >= length(v))
            i = 1
            k *= 2
        end
        el_r = i + 2k - 1
        if (i + 2k - 1 > length(v))
            el_r = length(v)
        end
        b = merge(v[i:i + k - 1], v[i + k:el_r])
        v[i:el_r] = b
        i += 2 * k
    end
    return v
end

#Task4

function quicksort(v)
    if isempty(v)
        return v
    end
    v, l, r = partsort!(v, v[begin])
    quicksort(v[begin:l])
    quicksort(v[r + 1:end])
    return v
end

function quicksort2(v)
    if isempty(v)
        return v
    end
    v, i = partsort2!(v, v[begin])
    quicksort!(v[begin:i])
    quicksort!(v[i:end])
    return v
end