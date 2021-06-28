function counting_sort(v::Array)
    cnt = zeros(10^5)
    for i in 1:length(v)
        cnt[v[i]] += 1
    end
    j = 1
    for i in 1:length(cnt)
        for r in 1:cnt[i]
            v[j] = i
            j += 1
        end
    end
    return v
end

function insert_sort(v::Array)
    for i in 2:length(v)
        t = i
        while (t > 1 && v[t] < v[t - 1])
            v[t - 1], v[t] = v[t], v[t - 1]
            t -= 1
        end
    end
    return v
end


function bubble_sort_by_sum(M::Matrix)
    n = size(M)
    sum_col = fill(0, n[2])
    for j in 1:n[2]
        for i in 1:n[1]
            sum_col[j] += M[i, j]
        end
    end
    for i in 1:n[2]
        for j in 1:n[2] - 1
            if (sum_col[j] > sum_col[j + 1])
                M[:, j], M[:, j + 1] = M[:, j + 1], M[:, j]
                sum_col[j], sum_col[j + 1] = sum_col[j + 1], sum_col[j]
            end
        end
    end
    return M
end

function bubble_sort_by_zeros(M::Matrix)
    n = size(M)
    cnt_col = fill(0, n[2])
    for j in 1:n[2]
        for i in 1:n[1]
            if (M[i, j] == 0)
                cnt_col[j] += 1
            end
        end
    end
    for i in 1:n[2]
        for j in 1:n[2] - 1
            if (cnt_col[j] > cnt_col[j + 1])
                M[:, j], M[:, j + 1] = M[:, j + 1], M[:, j]
                cnt_col[j], cnt_col[j + 1] = cnt_col[j + 1], cnt_col[j]
            end
        end
    end
    return M
end