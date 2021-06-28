#Task1

function Taylor_cos(n, x)
    fact = 1
    s = 1
    for i in 1:n
        fact *= i
        if (i % 2 == 0)
            s += (((-1) ^ ((i / 2) % 2)) * (x ^ i)) / fact
        end
    end
    return s
end

#Task2

function taylor_cos2(x, ε)
    fact = 1
    a = 1
    i = 1
    s = 1
    while(abs(a) > ε)
        fact *= i
        if (i % 2 == 0)
            a = (((-1) ^ ((i / 2) % 2)) * (x ^ i)) / fact
            s += a
        end
    i += 1
    end
    return s
end

#Task3

function build_cos_plots()
    f1(x) = 1 - (x ^ 2) / 2 #f1, f2, f3...

    f2(x) = f1(x) + (x ^ 4) / factorial(4)
    f3(x) = f2(x) - (x ^ 6) / factorial(6) + (x ^ 8) / factorial(8)
    f4(x) = f3(x) - (x ^ 10)/factorial(10) + (x ^ 12) / factorial(12) - (x ^ 14) / factorial(14) + (x ^ 16) / factorial(16)
    
    pl = plot(f1) 
    plot!(f2)
    plot!(f3)
    plot!(f4)
end


#Task5

function Bessel(m, x)
    i = 1
    s = 1 / factorial(m)
    t = 1
    while(abs(t) > ε)
        t *= ((-1) / (i * (i + m))) * (x / 2) * (x / 2)
        s += t
        i += 1
    end
    s *= (x / 2) ^ m
    return s
end


#Task6

function lin_solve(A, a)

    for i in length(A):-1:1
        for j in 1:i - 1
            a[j] -= (A[j][i] / A[i][i]) * a[i]
            A[j][i] = 0
        end
    end

    for i in 1:length(A)
        println("x", i, " = ", a[i] / A[i][i])
    end
end

#Task7

function conv(A)
    for i in 1:length(A)
        for j in length(A):-1:i + 1
            A[j,:] -= (A[j][i] / A[i][i]) * A[i,:]
        end
    end
    return A
end

#Task8

function issing_conv(A)
    for i in 1:length(A)
        for j in length(A):-1:i + 1
            if (A[i][i] != 0)
                A[j,:] -= (A[j][i] / A[i][i]) * A[i,:]
            elseif (A[j][i] != 0)
                temp = A[j,:]
                A[j,:] = A[i,:]
                A[i,:] = A[j,:]
            else

                return true
            end
            if A[j,:] == zeros(length(A))
                return true
            end
        end
    end
    return false
end

function det_(A)
    B = copy(A)

    if issing_conv(B) == true
        return 0
    else
        d = B[1][1]
        for i in 2:length(B)
            d *= B[i][i]
        end
        return d
    end
end

#Task10

function rang(A)
    tmp = copy(A)
    rang = length(tmp)
    while (rang != 1 && det_(tmp) == 0)
        rang -= 1
        tmp = tmp[1:rang]
    end
    return rang
end

#Task11

function G(A)
    
    B = copy(A)
    if (length(B) == rang(B))
        return zeros(length(B))
    else
        B = copy(A)
        cur = [[]]
        t = []
        C = []
        for i in 1:length(B)
            push!(t, A[i][length(B[1])])
            for j in 1:(length(B[1]) - 1)
                push!(cur[1], B[i][j])
            end
            C = append!(C, cur)
            cur = [[]]
        end
        lin_solve(C,t)
    end
end

#Task12

function solve(A)
    b = []
    B = copy(A)
    cur = [[]]
    C = []
    for i in 1:length(B)
        push!(b, A[i][length(B[1])])
        for j in 1:(length(B[1]) - 1)
            push!(cur[1], B[i][j])
        end
        C = append!(C, cur)
        cur = [[]]
    end

    lin_solve(C, b)
    for i in 1:length(B)
        if (C[i] == zeros(length(C[1])) && b[i] != 0)
            return nothing
        end
    end
end