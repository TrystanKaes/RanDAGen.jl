# RanDAGen/src/task.jl
# Licensed under the MIT License. See LICENSE.md file in the project root for
# full license information.
"""
    Value

This is a really lamely named type but basically this is so that a value can have a changing
state while still knowing what the original value was.

# Fields
- `value <: Real`: The unchanging value.
- `state <: Real`: The state of the value at this moment.

"""
mutable struct Value{T<:Real}
    value::T
    state::T
end

"""
NAME

Represents Stuff

# Fields
- `ID::Int64`: The unique ID of this Task.
- `cost::Float64`: The cost of completing this task
- `communication::Float64`: The cost of communicating
- `data::Int64`: The amount of data this task handles
- `alpha::Float64`: The alpha parameter for Amdahl law calculation
- `complexity::Symbol`: The complexity of this Task (e.g :LOG_N, :N, :N_2)
- `transfer_tags::Int64`: Don't know

# Methods
- `val::Type{Any}`: words
"""
mutable struct Task
    ID::Int64
    cost::Union{Int64, 0}
    data::Int64
    alpha::Float64
    complexity::Symbol
    transfer_tags::Int64
end
