
using TimeSeries
using DataFrames,Plots
using Statistics


function  moving_avg2(X::Vector, num_f_ell::Int)
    back_delta = div(num_f_ell,2)
    forward_delta =  isodd(num_f_ell) ? div(num_f_ell,2) : div(num_f_ell,2)-1
    len_comp = length(X)
    y=similar(X)
    y= Float64.(y)
    for n = 1:len_comp
        lo= max(1,n)
        hi = min(len_comp, n ) #n+forward_delta
        
        if n !=len_comp
            y[n] = mean(X[lo:hi])
        else
            y[n] = 0
        end

    end
    return y    
end

function moving_average(X::Vector, over:: Int)
    results =  similar(X[over:end-over])
    results = Float64.(results)
    println(results)
    println(results[1])

    

    for n = 1:length(results)
        lo = n
        hi = over+n#min(over,n+over)
        
        #println(lo)
        #println(hi)
        #println(X[lo:hi])
        results[n] = mean(X[lo:hi])
    end
    return results
end

function  per_day(X::Vector)
    
    per_day= similar(X)
    for p = 1:length(X)
        #println(p)
        if p == 1
            per_day[p] = 0
        elseif p != length(X)
            per_day[p] = X[p] - X[p-1]
        else
            per_day[p] = 0
        end
    end
    return per_day
    
end


