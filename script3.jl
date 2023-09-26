using Pkg
Pkg.activate(".")

using Interpolations, PyPlot, GPCCData, Printf

let 

    tobs, yobs, sobs, = GPCCData.readdataset(source="3C120")
    
    figure(1) ; cla(); xlim(0,160)

    plot(tobs[1], yobs[1], "b.", label="continuum")

    plot(tobs[2], yobs[2], "r.", label="emission line")

    xlabel("days"); ylabel("flux")

    legend()

    title("3C120")

    savefig("3c120_data.png", transparent = true)


    #----------------------------

    f1 = LinearInterpolation(tobs[1], yobs[1])

    f2 = LinearInterpolation(tobs[2], yobs[2])

      
    figure(2) ; cla(); xlim(0,160) 

    r1 = LinRange(minimum(tobs[1]), maximum(tobs[1]), 3000)

    r2 = LinRange(minimum(tobs[2]), maximum(tobs[2]), 3000)

    plot(tobs[1], yobs[1], "b.")

    plot(tobs[2], yobs[2], "r.")

    plot(r1, f1(r1), "b", label="continuum")

    plot(r2, f2(r2), "r", label="emission line")

    xlabel("days"); ylabel("flux")

    legend()

    title("3C120")


    #----------------------------

    overlap = zeros(Float64, 0)
    
    times = zeros(Float64, 0)

    for (counter, t) in enumerate(0.0:0.2:140)
        

        # figure(3) ; cla(); xlim(0,160)

        # plot(tobs[1], yobs[1], "b.", label = "continuum")

        # plot(tobs[2].-t, yobs[2], "r.", label = "emission line")

        # plot(r1, f1(r1),    "b")

        # plot(r2.-t, f2(r2), "r")

        # # errorbar(tobs[1], # Original x data points, N values
        # # yobs[1], # Original y data points, N values
        # # yerr=sobs[1], # Plus/minus error ranges, Nx2 values
        # # fmt="bo") # Format

        # # errorbar(tobs[2].-t, # Original x data points, N values
        # # yobs[2], # Original y data points, N values
        # # yerr=sobs[2], # Plus/minus error ranges, Nx2 values
        # # fmt="ro") # Format


        # xlabel("days"); ylabel("flux"); title("3C120")

        # legend(loc=1)

        # savefig(@sprintf("cc_shift_%d.png", counter), transparent = true)



        mark1, mark2 = max(r1[1], r2[1]+t), min(r1[end], r2[end]+t)

        tmp = LinRange(mark1, mark2, 1000)

        aux = sum(f1(tmp) .* f2(tmp))

        push!(overlap, aux); push!(times, t)

        figure(4) ; cla(); xlim(0, 120); ylim(11_800, 13_700)

        plot(times, overlap, "k-")

        xlabel("delay in days"); ylabel("overlap")

        # sleep(0.1)

        savefig(@sprintf("cc_function_%d.png", counter), transparent = true)


        
    end



end