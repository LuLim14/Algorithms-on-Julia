function binary_search(value::Int, v::Array)
    left = 0
    right = length(v) + 1
    while right - left > 1
        mid = div(left + right, 2)
        if (v[mid] >= value)
            right = mid
        else
            left = mid
        end
    end
    if (right == length(v) + 1)
        return -1
    end

    if (v[right] == value)
        return right
    else
        return -1
    end
end