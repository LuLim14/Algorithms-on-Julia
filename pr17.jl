ConnectList{T} = Vector{Vector{T}}

#Task1

function dfs(start::T, graph::ConnectList{T}) where T
    used = zeros(Bool, length(graph))
    used[start] = 1
    stack  = [start]
    visited = Int64[]
    while !isempty(stack)
        v = pop!(stack)
        push!(visited, v)
        for u in graph[v]
            if used[u] == 0
                push!(stack, u)
                used[u] = 1
            end
        end
    end
    return visited
end

#Task2

function bfs(start::T, graph::ConnectList{T}) where T
    used = zeros(Bool, length(graph))
    used[start] = 1
    q  = [start]
    visited = Int64[]

    while !isempty(q)
        v = popfirst!(q)
        push!(visited, v)
        for u in graph[v]
            if used[u] == 0
                push!(q, u)
                used[u] = 1
            end
        end
    end
    return visited
end

#Task3

function val(graph::ConnectList{T}) where T
    vall = zeros(size(graph, 1))
    for i in 1:size(graph, 1)
        vall[i] = length(graph[i])
    end
    return vall
end

#Task4

function bfs_val(graph::ConnectList{T}) where T
    used = zeros(Int64, length(graph))
    q  = [1]
    used[1] = 1

    while !isempty(q)
        v = popfirst!(q)
        println(v)
        for u in graph[v]
            if used[u] == 0
                push!(q, u)
            end
            used[u] = used[u] + 1
        end
    end
    used[1] -= 1
    return used
end


#Task7

function cnt_comp(graph::ConnectList)
    n = length(graph)
    used = zeros(Bool, length(graph))
    cnt = 0
    for i in 1:n
        if !used[i]
            q = [i]
            used[i] = 1
            while !isempty(q)
                v = popfirst!(q)
                for u in graph[v]
                    if used[u] == 0
                        push!(q, u)
                        used[u] = 1
                    end
                end
            end
            cnt +=1
        end
    end
    return cnt
end

#Task8

function cnt_comp_vert(graph::ConnectList)
    n = length(graph)
    used = zeros(Bool, length(graph))
    vert = []
    for i in 1:n
        if !used[i]
            q  = [i]
            used[i] = 1
            while !isempty(q)
                v = popfirst!(q)
                for u in graph[v]
                    if used[u] == 0
                        push!(q, u)
                        used[u] = 1
                    end
                end
            end
            push!(vert,i)
        end
    end
    return vert
end

#Task10

function min_dist(start::T, finish::T, graph::ConnectList{T}) where T
    n = length(graph)

    d = Array{Array{Int,1}}(undef, n)
    for i in 1:n
        d[i] = []
    end

    q  = [start]
    d[start] = [start]
    while !isempty(q)
        v = popfirst!(q)
        if (v == finish) return d[v] end
        for u in graph[v]
            if d[u] == []
                push!(q, u)
                d[u] = push!(copy(d[v]), u)
            end
        end
    end
end

#Task11

function top_sort(graph::ConnectList)
    n = length(graph)
    ver = []
    used = zeros(Bool, n)
    has_cycle = false

    while count( m->m == 0, used) != 0 && !has_cycle
        has_cycle = true
        for v in setdiff(1:n, ver)
            if count(i->(used[i] == 0), graph[v]) == 0
                push!(ver, v)
                has_cycle = false
                used[v] = 1
            end
        end
    end
    if count(m->m == 0, used) != 0 return nothing end
    return ver
end