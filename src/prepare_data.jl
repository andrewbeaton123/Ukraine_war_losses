using CSV, DataFrames, Statistics,Logging,StatsBase

function load_data(path:: AbstractString)
    """
    loads csv from path in to df
    """
    return CSV.read(path,DataFrame)

end 


function run_load_normalize(data_path:: AbstractString)
    raw_data = load_data(data_path)

    @info "loaded raw data"
    normalized_results =  DataFrame()

    normalized_results[!,"standardized_apc_losses"] = standardize(ZScoreTransform,float(raw_data[!,"APC"]))
    @info "APC losses standardized"


    normalized_results[!,"standardized_aircraft_losses"] = standardize(ZScoreTransform,float(raw_data[!,"aircraft"]))
    @info "aircraft losses standardized"
    

    
    normalized_results[!,"standardized_helicopter_losses"] = standardize(ZScoreTransform,float(raw_data[!,"helicopter"]))
    @info "helicopter losses standardized"
    
    return normalized_results
end

