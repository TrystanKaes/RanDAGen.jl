# RanDAGen/src/graphbits.jl
# Licensed under the MIT License. See LICENSE.md file in the project root for
# full license information.

abstract type AbstractGraph end
abstract type graphbit{T<:UnionAll} end

mutable struct Vertex{T<:Any} <: graphbit{T}
    ID::Int64
    data::T

    edges::Vector{Edges{T}}

    function Vertex{T}(
        ID::Int64=rand(Int64, 1),
        data::T=undef) where {T<:Any}
        return new(ID, data)
    end
end

mutable struct Edge{T<:Any} <: graphbit{T}
    src::Vertex
    data::T
    dest::Vertex

    function Edge{T}(
        src::Vertex=undef,
        data::T=undef,
        dest::Vertex=undef) where {T<:Any}
        return new(src, data, dest)
    end
end


mutable struct Graph{T<:Any} <: AbstractGraph
    vertices::Vector{Vertex{T}}
    edges::Vector{Edge{T}}

    function Graph{T}(
        vertices=Vector{Vertex{T}},
        edges=Vector{Edge{T}},) where {T<:Any}
        return new(vertices, edges)
    end
end

Vertices(graph::Graph) = length(graph.
