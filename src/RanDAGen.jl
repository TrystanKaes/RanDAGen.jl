module RanDAGen

"""
Configuration Options

    This package provides the following configuration options for customizing the generated
    DAG's.

Local
- `fatness::Float64`: Defaults to 0.5
- `ccr::Int64`: Defaults to 0
- `data_range::UnitRange{Int64}`: Defaults to 2048:11264
- `alpha_range::UnitRange{Float64}`: Defaults to 0.0:0.2
- `regular::Float64`: Defaults to 0.9 | Must be between 0 and 1
- `jump::Int64`: Defaults to 0
- `density::Float64`: Defaults to 0.5
- `max_task::Int64`: Defaults to 100
- `resources::Int64`: Defaults to 5
- `output_stream::IOStream`: Defaults to stdout
"""


using Distributions

include("statistics.jl")
export Statistics, print_stats

greet() = print("Hello World!")

include("graph.jl")
export AbstractGraph, Graph, Vertices, Edge,  nv, ne, vertices, edges, has_vertex, has_edge, add_edge!, add_node!, delete_edge!, delete_node!

include("task.jl")
export


end # module
