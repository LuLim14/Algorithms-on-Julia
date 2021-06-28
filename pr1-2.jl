function bubble_sort(v::Array)
    for i in 1 : length(v)
        for j in 1 : length(v) - 1
            if v[j] > v[j + 1]
               v[j], v[j + 1] = v[j + 1], v[j]
            end
        end
    end
    return v
end

function bubble_sort_perm(v::Array)
    idx = collect(1:length(v))
    for i in 1 : length(v)
        for j in 1 : length(v) - 1
            if v[j] > v[j + 1]
               v[j], v[j + 1] = v[j + 1], v[j]
               idx[j], idx[j + 1] = idx[j + 1], idx[j]
            end
        end
    end
    return idx
end

function bubble_sort_for_lines(v::Matrix)
    for i in size(v, 2)
        bubble_sort(@view v[:, i])
    end
    return v
end

function bubble_sort_for_lines_perm(v::Matrix)
    idx = Matrix{Int}(undef, size(v))
    for i in size(v, 2)
        idx[:, i] = bubble_sort_perm(@view v[:, i])
    end
    return idx
end