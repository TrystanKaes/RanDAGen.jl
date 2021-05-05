# RanDAGen/src/generator.jl
# Licensed under the MIT License. See LICENSE.md file in the project root for
# full license information.

"""
Configuration Options

    This package provides the following configuration options for customizing the generated
    DAG's.

Local
- `fatness::Float64`: Controls the width of the graph. Higher == more tasks per level. Defaults to 0.5
- `communication_ratio::Float64`: Controls the amount of communication between processes. Defaults to 0.0
- `data_range::UnitRange{Int64}`: Defaults to 2048:11264
- `regular::Float64`: Defaults to 0.9 | Must be between 0 and 1
- `jump::Int64`: Defaults to 0
- `density::Float64`: Defaults to 0.5
- `max_task::Int64`: Defaults to 100
- `output_stream::IOStream`: Defaults to stdout
"""

function Generate(
    fatness::Float=0.5,
    ccr::Float64=0.0,
    data_range::UnitRange{Int64}=2048:11264,
    regular::Float64=0.9,
    jump::Int64=0,
    density::Float64=0.5,
    max_task::Int64=100)

    DAG = Dag{Task}

    task_list, task_count = GenerateTasks(max_task, fatness, regular, ccr, data_range)
    DAG.task_count = task_count

    task_list = GenerateDependencies(density, jump, task_list)

    task_list = GenerateTransferCost(task_list)

    return task_list


end

function GenerateTransferCost(task_list::Array{Any, 1})
    for i in 2:(length(task_list) - 1)
        for j in 1:length(task_list[i])
            for k in 1:length(task_list[i][j].children)
                cost = (task_list[i][j].data^2)*8
                append!(task_list[i][j].comm_work, cost)
            end
        end
    end
    return task_list
end

function GenerateDependencies(
    density::Float64,
    jump::Int64,
    task_list::Array{Any, 1},
)
    prepend!(task_list, _Task())

    for i in 2:(length(task_list) - 1)
        for task in task_list[i]
            parent_count = min(rand(1:(density * task_list[i-1])), length(task_list[i-1]))

            for j in 1:parent_count
                parent_level = rand(1:(jump + 1))
                parent_level = max(parent_level, 0)
                parent_index = rand(1:length(task_list[i-1]))

                parent = task_list[parent_level][parent_index]

                while length(findall(x -> x.ID == task.ID, parent.children)) > 0
                    parent_index += 1
                end
            end

            if parent_index < length(task_list[i-1])
                push!(task_list[parent_level][parent_index].children, task)
            end
        end
    end
    return task_list
end

function GetTaskPerLevel(fat::Float64, max_tasks::Int64, variation::Float64)
    total_tasks = 0
    levels = Array{Int64,1}()

    _, integral = modf(exp(fat * log(max_tasks)))

    tasks_per_level = floor(Int,integral)

    while total_tasks < max_tasks

        tasks = rand(tasks_per_level-variation*tasks_per_level:tasks_per_level+variation*tasks_per_level)

        if total_tasks + tasks > max_tasks
            tasks = max_tasks - total_tasks
        end

        append!(levels, tasks)

        total_tasks += tasks
    end
    return levels
end
