using LinearAlgebra
using Plots

#Task3

function polygon_area(T)
    s = 0
    for p in 1:length(T)
        s += ((T[p >= length(T) ? 1 : p + 1][1]) - T[p][1]) * ((T[p >= length(T) ? 1 : p + 1][2] + T[p][2]) / 2)
    end
    return s
end

#Task4

xdot(u, v) = (u[1] * v[2] - u[2] * v[1])

function polygon_area_by_tr(T)
    s = 0
    for p in 1:length(T)
        s += xdot(T[p], T[p >= length(T) ? 1 : p + 1]) / 2
    end
    return s
end
