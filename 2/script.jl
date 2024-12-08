import Pkg;
Pkg.add("CSV");
Pkg.add("DataFrames");
Pkg.add("DataStructures");

using CSV, DataFrames, DataStructures

# Read input file

file = "2/input.txt"
data = CSV.read(file, DataFrame; header=false, delim=' ')


function is_safe(vec::Vector{Int64})
    diffs = [e - vec[index + 1] for (index, e) in enumerate(vec[1:end-1])]
    return !(minimum(diffs) < 0 < maximum(diffs)) && all((n  ->  0 < abs(n) < 4).(diffs))
end

# Part 1
safe = Vector()
for row in eachrow(data)
    cleaned_row = collect(skipmissing(row))
    if is_safe(cleaned_row)
        push!(safe, cleaned_row)
    end
end
length(safe)


# Part 2
# Tolerate one error

safe = Vector()
for row in eachrow(data)
    cleaned_row = collect(skipmissing(row))
    if any([
        is_safe(
            vcat(cleaned_row[1:i-1], cleaned_row[i+1:end])
        ) for (i, e) in enumerate(cleaned_row)])
        push!(safe, cleaned_row)
    end
end
length(safe)
