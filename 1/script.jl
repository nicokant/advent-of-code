import Pkg;
Pkg.add("CSV");
Pkg.add("DataFrames");
Pkg.add("DataStructures");

using CSV, DataFrames, DataStructures

# Read input file

file = "1/input.txt"
data = select(CSV.read(file, DataFrame; header=false), [1, 4])

# Part 1
# Sum of column difference
sum(abs.(data.Column1 - data.Column4))

# Part 2
# Number in column1 * count in Column4
column_counter = counter(data.Column4)
sum([i * column_counter[i] for i in data.Column1])
