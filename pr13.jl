abstract type AbstractCombinObject
    #v::Vector{Int} 
end

Base.iterate(object::AbstractCombinObject) = (get(object), nothing)
Base.iterate(object::AbstractCombinObject, state) = 
    if next!(object) == false
        nothing
    else
        (get(object), nothing)
    end
Base.get(object::AbstractCombinObject) = object.value

#Task1

struct RepPlacement{N,K} <: AbstractCombinObject
    value::Vector{Int}
    set::Vector
end

RepPlacement{T}(n::Integer) where T = RepPlacement{T}(ones(Int, T), collect(1:n))
RepPlacement{T}(set::Set) where T = RepPlacement{T}(ones(Int, T), collect(set))
Base.get(plmnt::RepPlacement) = plmnt.set(plmnt.value)

function next!(plmnt::RepPlacement)
    n = length(plmnt.set)
    v = plmnt.value
    i = findlast(item->item < n, v)
    if isnothing(i)
        return false
    end
    v[i] += 1
    v[i+1:end] .= 1
    return true
end

#Task2

struct Permute{N} <: AbstractCombinObject
    value:Vector{Int}
end

Permute{N}() where N = Permute{N}(collect(1:N))
function next(w::Permute{T}) where T
    k = 0
    q = get(w)
    for i in T - 1:-1:1
        if q[i] < q[i + 1]
            k = i
            break
        end
    end
    if (k == 0)
        return false
    end
    i = k + 1
    while i < T && q[i + 1] > q[k]
        i += 1
    end
    q[i], q[k] = q[k], q[i]

    reverse!(@view q[k + 1:end])
    return true
end

#Task4

struct K_Set_Indicat{P,Q} <: AbstractCombinObject
    value::Vector{Bool}
end

K_Set_Indicat{P, Q}() where {P, Q} = SetIndicator{P, Q}([zeros(Bool, P-Q); ones(Bool, Q)])
function next(indicat::K_Set_Indicat)
    idx = lastindex(indicat.value)
    while indicat.value[idx] == 0
        idx -= 1
    end
    t = 0 
    while idx >= firstindex(indicat.indicat) && indicat.indicat[idx] == 1 
        t += 1
        idx -= 1
    end 
    if idx < firstindex(indicat.value)
        return false
    end

    indicat.value[idx] = 1
    indicat.value[idx + 1:idx + t - 1] .= 0
    indicat.value[idx + t:end] .= 1
    return true
end

#Task5

struct Num_Sp{N} <: AbstractCombinObject
    value::Vector{Int}
    num::Int
end

Num_Sp{N}() where N = Num_Sp{N}(collect(1:N), N)
function next(sp::Num_Sp) 
    if sp.num == 1
        false
    end

    nuum = sp.num
    val = sp.value
    i = nuum - 1
    while i > 1 && val[i-1] == val[i]
        i -= 1
    end
    val[i] += 1
    rr = sum(@view val[i + 1:nuum])
    nuum = i + rr - 1
    val[i + 1:nuum] .= 1
    sp.num = nuum
    return true
end


