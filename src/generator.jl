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
- `alpha_range::UnitRange{Float64}`: Defaults to 0.0:0.2
- `regular::Float64`: Defaults to 0.9 | Must be between 0 and 1
- `jump::Int64`: Defaults to 0
- `density::Float64`: Defaults to 0.5
- `max_task::Int64`: Defaults to 100
- `output_stream::IOStream`: Defaults to stdout
"""

function GenerateTasks(max_tasks::Int64;
    communication_ratio::Float64,
    data_range::UnitRange{Int64},
    alpha_range::UnitRange{Float64},
    jump::Int64) begin

    comm = :none
    if 1-rand() < communication_ratio
        comm = :yes
    end

end

function GetTaskPerLevel(fat::Float64, max_tasks::Int64, variation::Float64) begin
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
