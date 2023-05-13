using CSV 
using TimeSeries
using DataFrames,Plots
using Statistics
using StatsBase
include("./maths_functions.jl")
import Pkg; Pkg.add("StatsBase")
#

raw_data = CSV.read("C:\\Users\\andrewb\\Documents\\DSets\\russia_losses_equipment.csv",DataFrame)

names(raw_data)


plot(raw_data[!,"day"],
raw_data[!,"aircraft"],
xlabel="Days",
ylabel="Loss Count",
title = "Russian Losses",
legend = false)

pro_data =  raw_data
typeof(pro_data[!,"aircraft"])
ac_move_avg = moving_avg2(pro_data[!,"aircraft"],15)

apc_lossed_per_day = per_day(pro_data[!,"APC"])
apc_lossed_per_day_average = moving_average(apc_lossed_per_day,21)

ac_losses_per_day = per_day(pro_data[!,"aircraft"])
ac_losses_moving_average = moving_avg2(ac_losses_per_day,2)

hc_losses_per_day = per_day(pro_data[!,"helicopter"])


plot(raw_data[!,"day"],#[21:end-21],
[hc_losses_per_day,ac_losses_per_day],
xlabel="Days",
ylabel="Loss Count",
title = "Russian Losses moving avg",
legend = true)


quantile(apc_lossed_per_day)


length(apc_lossed_per_day)
length(ac_losses_per_day)

cov(hc_losses_per_day,ac_losses_per_day)
cor(hc_losses_per_day,ac_losses_per_day)


ac_norm_losses_per_day = standardize(ZScoreTransform,ac_losses_per_day)
hc_norm_losses_per_day = standardize(ZScoreTransform,hc_losses_per_day)

cov(hc_norm_losses_per_day, ac_norm_losses_per_day)
#time_array = TimeArray(pro_data)
plot(raw_data[!,"day"],
apc_lossed_per_day,
xlabel="Days",
ylabel="Loss Count",
title = "Russian Losses - Air - Tanks",
legend = false)

aircraft_std = std(raw_data[!,"aircraft"])
aircraft_var = var(raw_data[!,"aircraft"])

