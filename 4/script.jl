import Pkg;
Pkg.add("CSV");
Pkg.add("DataFrames");

using CSV, DataFrames, LinearAlgebra


file = "4/input.txt"

function xmas_occurrences(str::String)
    re = r"(XMAS|SAMX)"
    sum([length(collect(eachmatch(re, s))) for s in str])
end

open(file) do f
    rows = [split(l, "") for l in readlines(f)]
    matrix = mapreduce(permutedims, vcat, rows)

    rows, cols = size(matrix)

    xmas_occurrences(join.(eachrow(matrix))) + xmas_occurrences(join.(eachcol(matrix))) +
    xmas_occurrences([join(diag(matrix, i)) for i in range(1, rows + 1)]) +
    xmas_occurrences([join(diag(reverse(matrix), i)) for i in range(1, rows + 1)])
end


