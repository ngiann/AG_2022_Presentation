using Pkg
Pkg.activate(".")

using GLMakie, CairoMakie, GPCC, GPCCData, Printf

function plotfit(delay)

    tobs, yobs, sobs, = GPCCData.readdataset(source="3C120")
    
    fig = GLMakie.Figure(resolution = (2000, 1600), fontsize = 44)

    ax = Axis(fig[1, 1],title=@sprintf("3C120, delay %2.1f",delay), xlabel="days", ylabel="flux")

    # plot(tobs[1], yobs[1], "bo", label="continuum")
    sca1= GLMakie.scatter!(ax, tobs[1], yobs[1], color=:blue, markersize=24, label="continuum")
    sca2= GLMakie.scatter!(ax, tobs[2], yobs[2], color=:red,  markersize=24, label="emission line")
    # plot(tobs[2], yobs[2], "ro", label="emission line")

    # xlabel("days"); ylabel("flux")

    # legend()
    axislegend()
    ylims!(ax, 2.5, 4.5)
    xlims!(ax, 0.0, 142)

    CairoMakie.activate!() ; save("3c120_data.png", fig) ; GLMakie.activate!()

    # title("3C120")

    # savefig("3c120_data.png", transparent = true)
    

    _, pred, _ = gpcc(tobs, yobs, sobs; kernel = GPCC.matern32, delays = [0;delay], iterations = 1000, rhomax = 300)

    t_test = collect(0:0.1:142)
    
    μpred, σpred = pred(t_test)

    colours = [:cyan, :magenta]
    
    for i in 1:2
        
        lines!(ax, t_test, μpred[i], color=colours[i], linewidth=8)
        
        band!(ax, t_test, μpred[i] + 2σpred[i], μpred[i] - 2σpred[i], color=(colours[i], 0.4), transparency = true)
        
    end
    CairoMakie.activate!() ; save(@sprintf("3c120_delay_%2.1f.png",delay), fig) ; GLMakie.activate!()
    display(fig)
    return 

end

# fig = plotaligned(tobs, yobs,σobs, kernel=GPCC.OU, delays=[0;2], rhomax=1200)
# CairoMakie.activate!() ; save("synth_aligned_at_2.0.png", fig) ; GLMakie.activate!()