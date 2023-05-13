using GLM
using Plots, DataFrames,StatsModels
gr()

function apply_regression(x_data::Vector, y_data::Vector, graph_flag::Bool )
    

    df = DataFrame(x = x_data, y= y_data)
    @info "Applying Regression Model - GLM "
    #Apply and return regression model
    model = lm(@formula(y ~ x),df)

    beta = coef(model)
    se = stderror(model)
    if graph_flag
        
        #scatter the input data
        scatter(df.x, df.y, seriestype=:scatter, legend=nothing)
        
        #get the max and min of the x vection
        xfit =  extrema(x_data)
        #take the intercept and add the elementwise multiple 
        # of the gradient and tuple that is x fit
        yfit = beta[1].+beta[2].* xfit 
        println(xfit)
        println(yfit)
        println(typeof(xfit))
        plot!(collect(xfit),collect(yfit), linewidth=3)
        savefig("linear_regression_output.png")
        @info "Saved plot of linear regression"
    end 


    return model 

    
end

function plot_linear_regression()


end