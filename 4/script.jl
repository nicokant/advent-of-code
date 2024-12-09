import Pkg;
Pkg.add("CSV");

using CSV, LinearAlgebra


file = "4/input.txt"

function xmas_occurrences(str::String)
    # IMPORTANT: do not consume the string, otherwise it won't find overlapping strings like XMASAMX
    re = r"(?=(XMAS|SAMX))"
    length(collect(eachmatch(re, str)))
end

f = open(file)
rows = [split(l, "") for l in readlines(f)]
matrix = mapreduce(permutedims, vcat, rows)

reversed_matrix = reverse(matrix, dims=2)
r_count, c_count= size(matrix)

sum([
    xmas_occurrences.(join.(eachrow(matrix)));
    xmas_occurrences.(join.(eachcol(matrix)));
    xmas_occurrences.([join(diag(matrix, i)) for i in range(-r_count, r_count)]);
    xmas_occurrences.([join(diag(reversed_matrix, i)) for i in range(-r_count, r_count)])
])

close(f)
