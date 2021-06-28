#Task1

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

#Task3

function sort_other_arr2(A::Vector{T}, b::Int64)::Vector{T} where T
    V1 = Vector{Int}(undef, 0)
    V2 = Vector{Int}(undef, 0)
    for a in A
        if (a <= b)
            push!(V1, a)
        else
            push!(V2, a)
        end
    end
    return append!(V1, V2)
end

#Task2

function sort_other(V::Vector{T}, b::Int64)::Vector{T} where T
    m = 1
    res = copy(V)
    for i in 1:length(V)
        if res[i] <= b
            res[m + 1:i], res[m] = res[m:i - 1], res[i]
            if res[m] < b
                m += 1
            end
        end
    end
    return res
end

function sort_other_arr(V::Vector{T},b::Int64)::Vector{T} where T
    V1 = Vector{Int}(undef, 0)
    V2 = Vector{Int}(undef, 0)
    V3 = Vector{Int}(undef, 0)
    for a in V
        if (a < b)
            push!(V1, a)
        elseif (a == b)
            push!(V2, a)
        elseif (a > b)
            push!(V3, a)
        end
    end
    return append!(append!(V1, V2), V3)
end

#Task4

function C(n,k)
    fact = 1
    for i in 1:k
        fact = (fact * (n - i + 1)) / i
    end
    return fact
end

function binomial(n::Int64)
    v = Array{Int}(undef, n)
    for i in 1:n
        v[i] = C(n,i)
    end
    return Poly{Int}(v)
end


