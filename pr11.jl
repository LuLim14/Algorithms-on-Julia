module Vector2Ds

        using LinearAlgebra 
        export Vector2D, xdot, sin, cos

        Vector2D{T <: Real} = Tuple{T, T}
        Base. cos(a::Vector2D, b::Vector2D) = dot(a, b) / norm(a) / norm(b)
        xdot(a::Vector2D, b::Vector2D) = a[1] * b[2] - a[2] * b[1] #vect_prod
        Base. sin(a::Vector2D, b::Vector2D) = xdot(a, b) / norm(a) / norm(b)
end

using .Vector2Ds
using Plots

#Task1

rand_points(random::Function, num::Int) = [(random(), random()) for i in 1:num]

#Task3

function p_segments(segments::Vector{Tuple{Vector2D{T}, Vector2D{T}}}; keywords...) where T <: Real
    p = plot(; keywords...)
    for sg in segments
        plot!(collect(sg); keywords...)
    end
    return p
end

#Task5

function p_ft_segments(segments::Vector{Tuple{Vector2D{T}, Vector2D{T}}}, vect::Vector2D{T}; keywords...) where T <: Real
    p = plot(; keywords...)
    for sg in segments
        plot!(collect(sg); keywords...)
    end
    return p
end

#Task6

function pl_hexagon(V::Array ,hexagon::Vector{Vector2D{T}}) where T
    p = plot(hexagon, linecol =: green, marker =: circle, marker_sz =: 3, markercol =: green)
    plot!([(hexagon[length(hexagon)][1],hexagon[length(hexagon)][2]), (hexagon[1][1],hexagon[1][2])],  linecol =: green, marker =: circle, markersz =: 3, markercol =: green)
    for i in 1:length(t)
        for j in 1:length(V)
            if (t[i][1] * V[j % length(V)] - t[i][])
                plot!([(V[:,1][1],  V[:,1][2])]; marker =: circle, markersz =: 10, markercol =: green,)
            end
        end
    end
end

#Task7

function conv(vect::Vector{Vector2D{T}}) where T
    for i in 1:length(vect)
        if ((vect[i % length(vect) + 1][1] - vect[i][1]) * (vect[(i % length(vect) + 1) % length(vect) + 1][2] -
            vect[i % length(vect) + 1][2])-(vect[(i % length(vect) + 1) % length(vect) + 1][1] - vect[i % length(vect) + 1][1]) * (vect[i % length(vect) + 1][2]-vect[i][2]) < 0)
            return false
        end
    end
    
    return true
end