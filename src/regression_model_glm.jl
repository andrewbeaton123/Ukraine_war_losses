using GLM
using Plots, DataFrames,StatsModels,Random
using Logging
include("./train_test_split.jl")


gr()

function check_train_test_results(model,
    df,
    y_test_data)

@info "Starting train test split results "
mt = typeof(model)

y_pred = predict(model,df)

@info y_pred
r2_score = r2(model)#y_test_data,y_pred)#r2_score(y_test_data,y_pred)
@info "The r2 score is $r2_score"
@info "Finished checking train test split "
end 

function apply_regression(x_data::Vector, y_data::Vector, graph_flag::Bool )
    

    df = DataFrame(x = x_data, y= y_data)
    @info "Applying Regression Model - GLM "
    #Apply and return regression model

    train, test = splitdf(df,0.7)
    
    
    model = lm(@formula(y ~ x),train)


    @info "Model created "
    beta = coef(model)

    se = stderror(model)
    
    @info "Extracted beta and standard error "

    check_train_test_results(model,test,test.y)


    if graph_flag
        graph_regression_results(df,beta)
        return model
    end 


    return model 

    
end



function graph_regression_results(df:: DataFrame,
                                model_beta:: AbstractArray)
        @info "starting plotting ... "
        #scatter the input data
        scatter(df.x, df.y, seriestype=:scatter, legend=nothing)
        
        #get the max and min of the x vection
        xfit =  extrema(df.x)

        #take the intercept and add the elementwise multiple 
        # of the gradient and tuple that is x fit
        yfit = model_beta[1].+model_beta[2].* xfit 
        println(xfit)
        println(yfit)
        println(typeof(xfit))
        plot!(collect(xfit),collect(yfit), linewidth=3)
        savefig("linear_regression_output.png")
        @info "Saved plot of linear regression"

end
