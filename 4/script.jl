import Pkg;
Pkg.add("CSV");

using CSV, LinearAlgebra


file = "4/input.txt"

f = open(file)
rows = [split(l, "") for l in readlines(f)]
matrix = mapreduce(permutedims, vcat, rows)
r_count, c_count= size(matrix)

# Part 1

function xmas_occurrences(str::String)
    # IMPORTANT: do not consume the string, otherwise it won't find overlapping strings like XMASAMX
    re = r"(?=(XMAS|SAMX))"
    length(collect(eachmatch(re, str)))
end

reversed_matrix = reverse(matrix, dims=2)

sum([
    xmas_occurrences.(join.(eachrow(matrix)));
    xmas_occurrences.(join.(eachcol(matrix)));
    xmas_occurrences.([join(diag(matrix, i)) for i in range(-r_count, r_count)]);
    xmas_occurrences.([join(diag(reversed_matrix, i)) for i in range(-r_count, r_count)])
])


# Part 2

function is_x_mas(subm::Matrix{SubString{String}})
    (subm[1,1] * subm[2,2] * subm[3,3] in ["MAS", "SAM"])&&(subm[1,3] * subm[2,2] * subm[3,1] in ["MAS", "SAM"])
end

window = 2
sum(is_x_mas.([matrix[x:(x + window), y:(y + window)] for x in range(1, r_count - window) for y in range(1, c_count - window)]))

close(f)
