import Pkg
Pkg.add("DataStructures")

using DataStructures

rules_file = open("5/rules.txt")
input = open("5/input.txt")

seek(rules_file, 0)
lines = readlines(rules_file)
input_lines = readlines(input)

# Part 1

RULES = DefaultDict{Int64, Set{Int64}}(Set())
for line in lines
    before, after = parse.(Int64, split(line, '|'))
    push!(RULES[after], before)
end

RULES

function follows_rule(vector::Vector{Int64})
    return all(isempty.([setdiff(Set(vector[1:index - 1]), RULES[n]) for (index, n) in enumerate(vector)]))
end


function get_middle(vec::Vector{Int64})
    return vec[trunc(Int64, ceil(length(vec) / 2))]
end

tot = []
for l in input_lines
    v = parse.(Int64, split(l, ','))
    push!(tot, follows_rule(v) ? get_middle(v) : 0)
end

sum(tot)
