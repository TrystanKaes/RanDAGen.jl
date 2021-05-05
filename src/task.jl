# RanDAGen/src/task.jl
# Licensed under the MIT License. See LICENSE.md file in the project root for
# full license information.

complexities = [
    :LOG_N, :N, :N_2, :N_LOG_N
]
"""
_Task

Represents Stuff

# Fields
- `ID::Int64`: The unique ID of this Task.
- `complexity::Symbol`: The complexity of this Task (e.g :LOG_N, :N, :N_2)
- `cost::Float`: The cost of this tasks execution
- `data::Int64`: The amount of data this task needs to transfer
- `comm_target::Int64`: Identity of the process that needs to h
- `communication_cost::Float64`: The cost of communicating
- `load::T`: An extra parameter
- `children_count::Int64`: The amount of children tasks this process has
- `children::Array{tasks{T}}`: The children this process has
- `transfers::`:

# Methods
- `val::Type{Any}`: words
"""
mutable struct _Task
    ID::Int
    complexity::Symbol
    work::Float64

    data::Int

    children_count::Int
    children::Array{_Task, 1}
    comm_work::Array{Float64, 1}

    function _Task()
        return new(-1, :null, 0.0, 0, 0.0, Array{_Task,1}(), Array{Float64,1}())
    end
end

# work(task::Task, n::Int64) = (task.work - n) < 0 ? 0 : task.work -= n
# workRemaining(task::Task) = sum(x->x.second, task)
# isDone(task::Task) = task.work.first === 0


mutable struct DAG{T}
    task_count::Int
    tasks_per_level::Array{Int, 1}

    Tasks::Array{Tasks, 1}

    task_graph::Graph{_Task}
end
