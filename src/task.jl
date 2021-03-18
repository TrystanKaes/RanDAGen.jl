# RanDAGen/src/task.jl
# Licensed under the MIT License. See LICENSE.md file in the project root for
# full license information.

"""
Task

Represents Stuff

# Fields
- `ID::Int64`: The unique ID of this Task.
- `work::Pair{Int64,Int64}`: The amount of work to be done on this task. `.first` holds the
state. `.second` holds the unaltered value.
amount of work.
- `communication::Float64`: The cost of communicating
- `data::Int64`: The amount of data this task handles
- `alpha::Float64`: The alpha parameter for Amdahl law calculation
- `complexity::Symbol`: The complexity of this Task (e.g :LOG_N, :N, :N_2)
- `transfer_tags::Int64`: Don't know

# Methods
- `val::Type{Any}`: words
"""
mutable struct Task{T}
    ID::Int64
    work::Pair{Int64,Int64}
    alpha::Float64
    complexity::Symbol
    transfer_tags::Int64
    resource::Symbol

    data::T
end

work(task::Task, n::Int64) = (task.work.first - n) < 0 ? 0 : task.work.first -= n
workRemaining(task::Task) = task.work.second - task.work.first
isDone(task::Task) = task.work.first === 0
