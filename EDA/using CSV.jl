using CSV
using Dates
using DataFrames
import Pkg; Pkg.add("ZScoreTransform")

raw_data = CSV.read("C:\\Users\\andrewb\\Documents\\DSets\\reddit_wsb.csv",DataFrame)
last(raw_data,5)
raw_data
describe(raw_data)
length(raw_data[:,1])
nrow(raw_data)
size(raw_data)

names(raw_data)
raw_data[!,"id"]

#renaming but not in place
raw_data_2 = rename(raw_data, :id => :idstring)

#rename in place 
rename!(raw_data, :url => :url_link)

first(raw_data,1)
first(raw_data_2,1)
last(raw_data,1)


calc_data = raw_data
calc_data[:,"double_score"] = raw_data[:,"score"]*2
calc_data[:,"normal_score"] =  calc_data[:,"score"] / maximum(calc_data[!,"score"]) 

calc_data.date_time = Date.(calc_data.timestamp, dateformat"dd-mm-yyyy")
#Multiply 
maximum(calc_data[!,"score"])

first(calc_data, 1 )


#println(maximum(calc_data[!,"normal_score"]))
#println(minimum(calc_data[!,"normal_score"]))