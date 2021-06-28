#Task1

function pow(a, n::Integer)
    t, q, p = n, 1, a
    while t > 0
        if (t % 2 == 0)
            t ÷= 2
            p *= p
        else
            t -= 1
            q *= p
        end   
    end
return q
end

#Task3

function log(n::Real, x::Real, ε::Real)
    p, q, y = x, 1, 0
while (p < 1 / n || p > n || q > ε)
    if (p > n)
        y += q
        p /= n
    elseif (p < 1 / n)
        y -= q
        p *= n
    else
        q /= 2
        p *= p
    end
end
return y
end


#Task4

function isprime(n::Int)::Bool
    i = 2
    while (i * i <= n)
        if (n % i == 0)
            return false
        end
        i += 1
    end
    return true
end

#Task5

function Eratosphen(n::Integer)
    p = fill(true, n)
    p[1] = false
    k = 2 
    while  k !== nothing || k < n
        p[2k:k:end] .= false 
        k = findnext(p, k + 1)
    end
    return findall(p)
end

#Task6

function fact(n)
    if (isprime(n))
        return n, 1
    end
    v1 = []
    v2 = []
    i = 2
    k = 0
    n2 = n
    while (i * i <= n && n2 > 1)
        if (isprime(i))
            if (n2 % i == 0)
                push!(v1, i)

                while (n2 % i == 0)
                    n2 /= i
                    k += 1
                end
                push!(v2, k)
                k = 0
            end 
        end
        i += 1
    end
    if (n2 != 1)
        push!(v1, Int(n2))
        push!(v2, 1)
    end
    return v1, v2
end

#Task7

function Euler_func(n)
    if (isprime(n))
        return n - 1
    else
        res = 1
        v, w = fact(n)
        for i in 1:length(v)
            if (w[i] == 1)
                v[i] -= 1
            else
                v[i] = v[i] ^ w[i] - v[i] ^ (w[i] - 1)
            end
            res *= v[i]
        end
        return res
    end
end

#Task8

function gcdex(m::Int, n::Int)
    a, b = m, n
    w_a, v_a = 1, 0
    w_b, v_b = 0, 1
    while b != 0
        k = a ÷ b
        a, b = b, a % b 
        u, v = w_a, v_a
        w_a, v_a = w_b, w_a
        w_b, v_b = u - k * w_b, v - k * v_b
    end
    if w_a < 0
        w_a += n
    end
    return w_a
end

#Task9

function inv(m::Integer, n::Integer)
    if (gcd(m, n) > 1)
        return nothing
    else
        return gcdex(m, n)
    end
end

#Task10

function zero_divisors(a::Integer)
    v = [1]
    for i in 2:a
        if (gcd(a, i) == 1)
                push!(v, i)
        end
    end
    return v
end

#Task11

function nilpotents(a::Integer)
    n = []
    m = 1
    v, nothing = fact(a)
    for i in 1:length(v)
        m *= v[i]
    end
    count_np = Int(a / m)
    for i in 1:count_np - 1
        push!(n, m * i)
    end
    return n
end

#Task12

function order(a, p)
    answ = 0
    phi = p - 1
    for i in 1:(p - 1)
        if ((a ^ i) % p == 1 && phi % i == 0)
            answ = i
            break
        end
    end
    return answ
end

#Task13

function bisection(f::Function, v, w, ε)
    y_v = f(v)
    while w - v > ε
        x_m = (v + w) / 2
        y_m = f(x_m)
        if y_m == 0
            return x_m
        end
        if y_m * y_v > 0 
            v = x_m
        else
            w = x_m
        end
    end
    return (v+w) / 2
end