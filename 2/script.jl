import Pkg;
Pkg.add("CSV");
Pkg.add("DataFrames");
Pkg.add("DataStructures");

using CSV, DataFrames, DataStructures

# Read input file

file = "2/input.txt"
data = CSV.read(file, DataFrame; header=false, delim=' ')


# Part 1
safe = Vector()
for row in eachrow(data)
    cleaned_row = collect(skipmissing(row))
    diffs = [e - cleaned_row[index + 1] for (index, e) in enumerate(cleaned_row[1:end-1])]
    if !(minimum(diffs) < 0 < maximum(diffs)) && all((n  ->  0 < abs(n) < 4).(diffs))
        push!(safe, cleaned_row)
    end
end
length(safe)
