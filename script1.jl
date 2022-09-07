using Interpolations, PyPlot, GPCCData

let 

    tobs, yobs, sobs, = GPCCData.readdataset(source="3C120")
    
    figure(1) ; cla(); xlim(0,160)

    plot(tobs[1], yobs[1], "bo", label="continuum")

    plot(tobs[2], yobs[2], "ro", label="emission line")

    legend()

    title("3C120")


    #----------------------------

    f1 = LinearInterpolation(tobs[1], yobs[1])

    f2 = LinearInterpolation(tobs[2], yobs[2])

      
    figure(2) ; cla(); xlim(0,160) 

    r1 = LinRange(minimum(tobs[1]), maximum(tobs[1]), 1000)

    r2 = LinRange(minimum(tobs[2]), maximum(tobs[2]), 1000)

    plot(r1, f1(r1), "b", label="continuum")

    plot(r2, f2(r2), "r", label="emission line")

    legend()

    title("3C120")


    #----------------------------

    overlap = zeros(Float64, 0)
    
    times  = zeros(Float64, 0)

    for t in 0.0:1:100

        figure(3) ; cla(); xlim(0,160)

        plot(r1, f1(r1), "b")

        plot(r2.+t, f2(r2), "r")

        mark1, mark2 = max(r1[1], r2[1]+t), min(r1[end], r2[end]+t)

        tmp = LinRange(mark1, mark2, 1000)

        aux = sum(f1(tmp) .* f2(tmp))

        push!(overlap, aux); push!(times, t)

        figure(4) ; cla()

        plot(times, overlap)

        sleep(0.1)

    end



end