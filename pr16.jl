#Task2

function Ford_Bellman(G::AbstractMatrix, s::Integer)
    n = size(G, 1)
    
    d = G[s,:]
    for k in 0:n - 2, j in 1:n, i in 1:n
        if d[j] > d[i] + d[i, j]
            d[j] = d[i] + d[i, j]
        end
    end
    return d
end

#Task4

function Floyd(G::AbstractMatrix)
    n = size(G, 1)
    d = Array{eltype(G),2}(undef, n, n)
    d = G
    for k in 1:n, i in 1:n, j in 1:n
        d[i, j] = min(d[i, j], d[i, k] + d[k, j])
    end
    return d
end

#Task5

function Floyd_next(G::AbstractMatrix)
    n = size(G,1)
    nxt = Array{eltype(G),2}(undef, n, n)
    d = Array{eltype(G),2}(undef, n, n)
    for i in 1:n
        for j in 1:n
            nxt[i, j] = j
        end
    end
    d = G
    for k in 1:n, i in 1:n, j in 1:n
        if d[i, j] > d[i, k] + d[k, j]
            d[i, j] = min(d[i, j], d[i, k] + d[k, j])
            nxt[i, j] = k
        end
    end
    return d,nxt
end

#Task6

function path_Floyd(nxt::AbstractMatrix, i::Integer, j::Integer)
    path= [i]
    in = i
    while (in != j)
        push!(path, nxt[in, j])
        in = nxt[in, j]
    end
    return path
end

#Task7

function Djikstra(G::AbstractMatrix, s::Integer)
    n = size(G, 1)
    d = Int64[]
    used = Bool[]
    for i in 1:n
        push!(used, false)
        push!(d, G[s, i])
    end

    d[s] = 0
    c = 0
    idx = 0
    for i in 1:n
        min = 1e9
        for j in 1:n
            if (!used[j] && d[j] < min)
                min = d[j]
                idx = j
            end
        end
        c = idx
        used[c] = true
        for j in 1:n
            if (!used[j] && d[c] != 1e9  && G[c, j] != 1e9 && d[c] + G[c, j] < d[j])
                d[j] = d[c] + G[c, j]
            end
        end
    end
    return d
end

