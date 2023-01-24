using Pkg
Pkg.activate(".")

using Interpolations, PyPlot, Distributions

let 

    X = collect(1:0.25:10)

    ou(x,y; r = 1) = exp(- abs(x-y) / r^2)

    rbf(x,y; r = 1) = exp(-(x-y)^2 / r^2)

    whitenoise(x,y;r = 0) = x==y


    k = whitenoise

    calculatecov(X; r = 1) = [k(x,y; r = r) for x in X, y in X]
    

    gp = MvNormal(zeros(length(X)), calculatecov(X))

    figure(1); cla(); ylim(-2.5, 2.5)

    plot(X, rand(gp), "-o")
    

end