
# Part 1

re = r"mul\((\d+),(\d+)\)"

open("3/input.txt", "r") do file
    println(sum([sum([prod(parse.(Int64,match.captures)) for match in eachmatch(re, line)]) for line in readlines(file)]))
end


