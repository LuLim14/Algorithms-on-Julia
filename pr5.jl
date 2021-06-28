struct Polynomial{T}
    a::Vector{T}
end

import Base.+
import Base./
import Base.*
import Base.%
import Base.÷


function *(p::Int, q::Polynomial)::Polynomial
    v = copy(q.a)
    for i in 1:length(q.a)
        v[i] *= p
    end
    return Polynomial{Int}(v)
end

function *(p::Polynomial,q::Polynomial)::Polynomial

    v = Array{Int}(undef, length(p.a) + length(q.a) - 1)

    for i in 1:(length(p.a) + length(q.a) - 1)
        v[i] = 0
    end
    for i in 1:(length(p.a) + length(q.a))
        for j in 0:(i - 1)
            if (j + 1 <= length(p.a) && i - j <= length(q.a))
                v[i] += p.a[j + 1] * q.a[i - j]
            end                
        end
    end
    return Polynomial{Int}(v)
end


function +(p::Polynomial, q::Polynomial)::Polynomial
    if (length(p.a) < length(q.a))
        p, q = q, p
    end
    v = copy(p.a) 
    for i in 1:length(q.a)
        v[i]=v[i] + q.a[i]
    end

    return Polynomial{Int}(v)
end


#Task1

function diff_poly_2(x, A)
    Q = 0
    Q′ = 0
    Q′′ = 0
    for a in A
        Q′′ = Q′′ * x + 2*Q′
        Q′ = Q′ * x + Q
        Q = Q * x + a
    end
    return Q′′
end

#Task2

function diff_poly_3(x, A)
    Q = 0
    Q′ = 0
    Q′′ = 0
    Q′′′ = 0
    for a in A
        Q′′′ = Q′′′ * x + 3 * Q′′
        Q′′ = Q′′ * x + 2 * Q′
        Q′ = Q′ * x + Q
        Q = Q * x + a
    end
    return Q′′′
end

#Task3

function diff_poly_k(x, A, k)
    v = zeros(k + 1)
    diff = Polynomial{Int}(v)
    add = 0
    for a in A
        for i in length(diff.a):-1:1 
            if (i != 1)
                diff.a[i] = (i - 1) * diff.a[i - 1] +  diff.a[i] * x
            else
                diff.a[i] = diff.a[i] * x + a
            end
        end
    end
    return diff.a[k + 1]
end

#Task4

function diff(p, x; ord = 1)
    return diff_poly_k(x, p.a, ord)
end

#Task5

function divv(p::AbstractVector, q::AbstractVector)
    c_p = copy(p)

    res = zeros(length(p) - length(q) + 1)
    d = length(p) - length(q) 
    for i in 1:length(q)
        res[i] = c_p[i] / q[1]
        for j in 1:length(q)
            c_p[i + j - 1] = c_p[i + j - 1] - res[i] * q[j]
        end
        c_p[i] = 0
    end
    return res, c_p 
end

#Task6

function ÷(p::Polynomial, q::Polynomial)
    res, no = divv(p.a, q.a)
    return res
end

function %(p::Polynomial, q::Polynomial)
    no, res = divv(p.a, q.a)
    return res
end

#Task7

function diff_poly(p)
    res = zeros(length(p.a) - 1)

    for i in 1:length(res)
        res[i] = (length(p.a) - i) * p.a[i]
    end
    return Polynomial{Real}(res)
end

function intpoly(p)
    res = zeros(length(p.a))


    for i in 1:length(res)
        res[i] = p.a[i] / (length(p.a) - i + 1)
    end
    return Polynomial{Real}(res)
end

#Task8

function cur_st(s_)
    S1 = eltype(s_)(0)
    S2 = eltype(s_)(0)
    C = 0
    D = 0
    st = zeros(length(s_))
    for (n, a) in enumerate(s_)
        S1 += a
        D = S1 / n
        S2 += a ^ 2
        C = S2 / n - D ^ 2
        st[n] = sqrt(C)
    end
    return st
end

#Task9

function sub_sum(s_)
	sum = 0
    el = s_[1]
	max_sum = 0
    for i in 1:length(s_)
	    sum += s_[i]
	    el = min(el, sum - max_sum)

	    max_sum = max(max_sum, sum)
    end
    return max_sum
end

#Task10

function idx_max_sub_sum(s_)
    sum = 0
	max_sum = 0
	max_pos = 0
    
    el = s_[1]
	el_l = 1
	el_r = 1
	
    for i in 1:length(s_)
	    sum += s_[i]
	    c = sum - max_sum
	    if (c > el)
		    el_l = max_pos + 1
		    el_r = i
            el = c
        end
	    if (sum < max_sum)
		    max_sum = sum
		    max_pos = i
        end
    end
    return (el_l, el_r)
end