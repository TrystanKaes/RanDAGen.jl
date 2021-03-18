# SimLynx/src/statistics.jl
# Licensed under the MIT License. See LICENSE.md file in the project root for
# full license information.


# Thanks to SimLynx.jl for some of this code.

abstract type Stats{T<:Real} end

"""
    AccumulatedStats{T<:Real} <: Stats{T}

    AccumulatedStats()
    AccumulatedStats(value::T)

Collection of statistics to describe the DAG.

# Fields
- `min::T` - the minimum for an array of values
- `max::T` - the maximum for an array of values
- `n::Float64` - the weighted number of an array of values
- `sum::Float64` - the weighted sum for an array of values
- `sum_squares::Float64` - the weighted sum of squares for an array of values
"""
mutable struct Statistics{T<:Real} <: Stats{T}
    min::T
    max::T
    n::Float64
    sum::Float64
    sum_squares::Float64
    Statistics{T}() where {T<:Real} =
        new(zero(T), zero(T), 0.0, 0.0, 0.0)
        Statistics{T}(value::T) where {T<:Real} =
        new(value, value, 0.0, 0.0, 0.0)
end


# Stats Operations
mean(stats::Stats) = stats.sum / stats.n
mean_square(stats::Stats) = stats.sum_squares / stats.n
variance(stats::Stats) = mean_square(stats) - mean(stats)^2
stddev(stats::Stats) = sqrt(variance(stats))

"Overloaded statistics properties for mean, variance, and stddev."
function Base.getproperty(stats::Stats, name::Symbol)
    if name === :mean
        return mean(stats)
    elseif name === :variance
        return variance(stats)
    elseif name === :stddev
        return stddev(stats)
   else # fallback to getfield
       return getfield(stats, name)
   end
end

"""
Print the statistics with optional format, title, and output stream
"""
function print_stats(stats::Stats;
                     format="%f",
                     title="Statistics",
                     output=stdout)
    println(output, title)
    println(output, "     min = $(stats.min)")
    println(output, "     max = $(stats.max)")
    println(output, "       n = $(stats.n)")
    println(output, "    mean = $(stats.mean)")
    println(output, "variance = $(stats.variance)")
    println(output, "  stddev = $(stats.stddev)")
    flush(output)
end
