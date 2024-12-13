
# Part 1

re = r"mul\((\d+),(\d+)\)"

function count_mul(s::String)
    sum([prod(parse.(Int64,match.captures)) for match in eachmatch(re, s)])
end

open("3/input.txt", "r") do file
    println(sum([count_mul(line) for line in readlines(file)]))
end


re2 = r"(^|do\(\))(.*?)(don't\(\)|$)"
file = open("3/input.txt", "r")

lines = readlines(file)
non_corrupted = [match for line in lines for match in eachmatch(re2, "do()" * line * "don't()")]

count_mul(non_corrupted)

# println(lines[1])

# parts = []

# for l in lines
#     do_range = UnitRange{Int64}(1,1)
#     while !isnothing(do_range)
#         dont_range = findnext("don't()", l, do_range.start)
#         if isnothing(dont_range)
#             push!(parts, count_mul(l[do_range.stop:end]))
#             break
#         end
#         push!(parts, count_mul(l[do_range.stop:dont_range.start]))
#         do_range = findnext(r"do()", l, dont_range.stop)
#     end
# end

# sum(parts)

# for s in split(lines[1], "do()")
#     for p in split(s, "don't()")
#         println(p, "don't()")
#     end
#     println("do()")
# end

# sum(count_mul.([join(split(s, "don't()")[1:end-1]) for line in lines for s in split(line, "do()") ]))


