include("./prepare_data.jl")
include("./regression_model_glm.jl")

normalized_data = run_load_normalize("C:\\Users\\andrewb\\Documents\\DSets\\russia_losses_equipment.csv")

regression_model = apply_regression(
    normalized_data[!,"standardized_apc_losses"], 
normalized_data[!,"standardized_aircraft_losses"],
true)


#println(summary(regression_model))

#println(coef(regression_model))

#println(stderror(regression_model))