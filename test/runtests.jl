using Test, RanDAGen
const dir = joinpath(dirname(pathof(RanDAGen)), "..", "test")


@testset "RanDAGen" begin
    for f in ["DAG.jl",]
        file = joinpath(dir, f)
        println("Running $file tests...")
        if isfile(file)
            include(file)
        else
            @show readdir(dirname(file))
        end
    end
end
