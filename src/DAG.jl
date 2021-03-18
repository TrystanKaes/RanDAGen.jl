# RanDAGen/src/DAG.jl
# Licensed under the MIT License. See LICENSE.md file in the project root for
# full license information.

"""
    DAG{T}

    DAG()

DAG is the graph and a collection of related introspection tools.

# Fields
- `start::Type{T}`: The first node in this graph

# Methods
- `val::Type{Any}`: words
"""
mutable struct DAG{T}

    graph::Graph{T}

    function DAG{T}(
        vertices=Vector{Vertex{T}},
        edges=Vector{Edge{T}},) where {T<:Any}
        return new(vertices, edges)
    end
end
