# RanDAGen/src/graphbits.jl
# Licensed under the MIT License. See LICENSE.md file in the project root for
# full license information.

abstract type AbstractGraph end

mutable struct Vertex{T<:Any}
    ID::Int64
    data::T

    neighbors::Vector{Int64}

    function Vertex{T}(
        ID::Int64=rand(Int64, 1),
        data::T=undef) where {T<:Any}
        return new(ID, data)
    end
end

mutable struct Edge{T<:Any}
    src::Int64
    data::T
    dest::Int64

    function Edge{T}(
        src::Int64=-1,
        data::T=undef,
        dest::Int64=nothing) where {T<:Any}
        return new(src, data, dest)
    end
end


mutable struct Graph{T<:Any} <: AbstractGraph

    vertices::Dict{Int64,Vertex{T}}

    edges::Dict{(Int6,Int64),Edge{T}}

    function Graph{T}(
        vertices=Vector{Vertex{T}},
        edges=Vector{Edge{T}}) where {T<:Any}
        return new(vertices, edges)
    end
end

nv(graph::Graph) = length(graph.vertices)
ne(graph::Graph) = length(graph.vertices)

vertices(graph::Graph) = [v for v in values(graph.vertices)]
edges(graph::Graph) = [v for v in values(graph.edges)]

has_vertex(graph::Grap, v::Int64) = haskey(graph.vertices, v)
has_edge(graph::Graph, e::(Int64,Int64)) = haskey(graph.edges, e)

function add_edge!(graph::Graph, edge::Edge) begin
    if has_vertex(graph, edge.src) && has_vertex(graph, edge.dest)

        # Add neighbors
        union!(graph.vertices[edge.src].neighbors, edge.dest)
        union!(graph.vertices[edge.dest].neighbors, edge.src)
        graph.edges[(edge.src,edge.dest)] = edge

        return true
    end
    return false
end

function delete_edge!(graph::Graph, edge::Tuple{Int64,Int64}) begin
    delete!(graph.edges, (edge.first,edge.second))
    delete!(graph.edges, (edge.second,edge.first))
end

function add_node!(graph::Graph, vertex::Vertex) begin
    if !has_vertex(graph, vertex.ID)
        graph.vertices[vertex.ID] = vertex

        for neighbor in vertex.neighbors
            edge = Edge{Nothing}(1,nothing,2)
            add_edge!(graph, edge)
        end

        return true
    end
    return false
end


function add_node!(graph::Graph, vertex::Vertex, edges::Array{Edge}) begin
    if !has_vertex(graph, vertex.ID)
        graph.vertices[vertex.ID] = vertex

        for edge in edges
            add_edge!(graph, edge)
        end

        return true
    end
    return false
end

function delete_node!(graph::Graph, ID::Int64) begin
    if !has_vertex(graph, ID)
        neighborhood = graph.vertices[ID].neighbors

        for neighbor in neighborhood
            delete_edge!(graph.edges, (ID,neighbor.ID))
            filter!(x->ID,graph.vertices[neighbor].neighbors)
        end

        delete!(graph.vertices, ID)

        return true
    end
    return false
end
