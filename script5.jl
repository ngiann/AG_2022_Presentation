using Pkg
Pkg.activate(".")

using GLMakie, CairoMakie, GPCC, GPCCData, Printf

function plotdelay(prob, maxdelay)

    maxindex = argmin(abs.(prob[:,1].-maxdelay))
   
    
    fig = GLMakie.Figure(resolution = (2000, 1600), fontsize = 44)

    ax = Axis(fig[1, 1], xlabel="days", ylabel="p(τ|𝒟)")

    lines!(ax, prob[1:maxindex, 1], prob[1:maxindex, 2], linewidth=10)
   
    
    # axislegend()
    ylims!(ax,0.0, 0.21)
    xlims!(ax, 0.0, 142)

    
    
    CairoMakie.activate!() ; save(@sprintf("3c120_delay_prob%2.1f.png",maxdelay), fig) ; GLMakie.activate!()
    display(fig)
    return 

end

# fig = plotaligned(tobs, yobs,σobs, kernel=GPCC.OU, delays=[0;2], rhomax=1200)
# CairoMakie.activate!() ; save("synth_aligned_at_2.0.png", fig) ; GLMakie.activate!()