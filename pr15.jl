ConnectList{T} = Vector{Vector{T}}

#Task3

function tree_conv(tree::ConnectList{T}, root::T) where T
    tree_ = copy(tree)
    list = Array{Tree{Int}}(undef, length(tree_))

    for i in 1:length(tree_)
        list[i] = Tree{Int}(i, [])
    end

    list_ = list[root]
    q = [root]
    while (!isempty(q))
        cur = first(q)
        deleteat!(q,firstindex(q))
        q = append!(q, tree_[cur])
        for tree in tree_[cur]
            push!(list[cur].sub, list[tree])
        end
    end
    return list_
end

#Task4

function conv(tree::Tree{T}) where T
    root = 1
    res = []
    for i in 2:tree.index
        push!(res,[])
        root += 1
    end
    q = [tree]

    while (!isempty(q))
        cur = first(q)
        q = append!(q, cur.sub)
        deleteat!(q, firstindex(q))
        for i in cur.sub
            if (cur.index > length(res))
                while (i.index != length(res))
                    push!(res, [])
                end
            end
            push!(res[cur.index], i.index)
        end
    end
    return res
end

#Task1

function conv(tree::ConnectList{T}, root::T) where T

    v = zeros(length(tree))
    q = []

    res = Array{Array{Array{Int,1}}}(undef, length(tree))
    for i in 1:length(tree[root])
        res[tree[root][i]] = [[tree[root][i]]]
        push!(q, tree[root][i])
        v[tree[root][i]] = 1
    end
    while (!isempty(q))
        c = last(q)
        deleteat!(q, lastindex(q))
        if (!isempty(tree[c]))
            res[c]=[[], [c]]
            v[c] = 1
            for j in 1:length(tree[c])
                insert!(res[c][1], 1, tree[c][j])
                push!(q, tree[c][j])
            end
        end
    end

    cnt = 1
    for i in 1:length(tree)
        if (v[i] == 0)
            deleteat!(res, cnt)
        else
            cnt += 1
        end
    end
    push!(res, [[root]])

    return res
end

#Task6

function all_types(type)

    for i in subtypes(type)
        println(i)
        all_types(i)
    end
end

#Task7

function find_(tree::Vector, setv::Set)
    st = 0
    cnt_visited = 0
    function recurstrace(tree, parent = 0)  
        is_st = false

        for subtree in tree[begin:end - 1]
            if cnt_visited < length(setv)
                recurstrace(subtree, tree[end])
            end
        end
        if tree[end] in setv
            cnt_visited += 1

            if cnt_visited == 1
                st = tree[end]
            end                        
        end
        
        if st == tree[end] 
            is_st = true
        end
        if is_st && cnt_visited < length(setv)
            st = parent
        end
    end
    recurstrace(tree)
    return st
end