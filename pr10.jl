#Task1

function Newton(r::Function, x; ε_x = 1e-8, ε_y = 1e-8, maxiter = 20)
    i = 0
    x_i = x
    while (i <= maxiter && (x_i == x || abs(x_i - x) > ε_x))
        x = x_i 
        x_i = x - r(x) 
        i += 1
        println("x_i = ", x, "; x_i+1 = ", x_i)
    end
    if (i > maxiter)
        return nothing
    else
        return x_i
    end
end


#Task2

Newton(x->(x - cos(x)) / (1 + sin(x)), 0.5)

#Task4

Newton(x->(x - cos(x)) / (1 + sin(x)), 0.5)

#Task6

Newton(x->(x - cos(x), sin(x)), 0.5) 

#Task3

Newton(func::Tuple{Function, Function}, x; ε_x = 1e-8, ε_y = 1e-8, maxiter = 20) = Newton((x->func[1](x) / func[2](x)), x; ε_x, ε_y, maxiter)

#Task5

Newton(func, x; ε_x = 1e-8, ε_y = 1e-8, maxiter = 20) = Newton(x->(y = fucn(x); y[1] / y[2]), x; ε_x, ε_y, maxiter)

#Task7

Newton(coeff::Array{Int}, x; ε_x = 1e-8, ε_y = 1e-8, maxiter = 20) = Newton(x->(y = evaldiffpoly(x, coeff); y[1] / y[2]), x; ε_x, ε_y,  maxiter)

function valid_poly(x, coeff)
    Q = 0
    Q ′= 0
    for a in coeff
        Q′ = Q′ * x + Q
        Q = Q * x + a
    end
    return Q, Q′
end