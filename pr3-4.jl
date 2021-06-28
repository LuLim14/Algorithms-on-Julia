#Task 2
function bubble_sort2(v::Array)
    right_idx_it = 1
    right_idx = 1
    is_sorted = true
    for i in 1:(length(v) - 1)
        for j in right_idx_it:(length(v) - 1)
            if (v[j] > v[j + 1])
                is_sorted = false
                v[j], v[j + 1] = v[j + 1], v[j]
            elseif (v[j] <= v[j + 1] && is_sorted)
                right_idx =+ 1
            end
        end
        right_idx_it = right_idx
        is_sorted = true
    end
    return v
end

#Task3

function shaker_sort(v::Array)
    left = firstindex(v)
    right = lastindex(v)
    while left < right
        for i in right:-1:left + 1
            if (v[i - 1] > v[i])
                v[i - 1], v[i] = v[i], v[i - 1]
            end
        end
        left = +1
        for i in left + 1:right
            if (v[i - 1] > v[i])
                v[i - 1], v[i] = v[i], v[i - 1]
            end
        end
        right -= 1
    end
    return v
end

#Task5

function slice(V::Vector{T}, p::Vector{Int})::Vector{T} where T
    return V[p]
end

#Task4

function shellsort(a)
    generator = (length(a) ÷ 2^i for i in 1:Int(floor(log2(length(a))))) 
    for i in generator
        for j in firstindex(a):i - 1
            insertsort!(@view a[j:i:end]) 
        end
    end

    return a
end

#Task6

function permute(A::Vector{T}, permut::Vector{Int})::Vector{T} where T
    return slice(A, permut);
end

#Task9

reverse(v) = v[end:-1:begin]

#Task10

function cyclshift(av::AbstractVector, t::Int) 
    reverse(av)
    reverse(@view av[begin:begin + t])
    reverse(@view av[begin + t + 1:end])
end

#Task11

function transpose_w_array(M::Matrix{T})::Matrix{T} where T
    MM = Matrix{T}(undef, size(M, 2), size(M, 1))
    for i in 1:size(M, 1)
        for j in 1:size(M, 2)
            MM[j, i] = M[i, j]
        end
    end
    return MM
end

#Task12

function transpose(M::Matrix{T})::Matrix{T} where T
    for i in 1:size(M, 1)
        for j in 1:i
            tmp = M[i, j]
            M[i,j] = M[j,i]
            M[j,i] = tmp
        end
    end
    return M
end