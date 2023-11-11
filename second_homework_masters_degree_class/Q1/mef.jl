module MEF
    using Plots
    include("we_pe.jl")
    using .points_and_weights

    include("SHL.jl")
    using .SHL

    include("functions.jl")
    using .functions

    a = 0
    b = +1.5
    ;

    # Função principal da simulação do MEF (argumentos: max_degree -> grau máximo do polinômio que irá gerar o número de elementos; folder_to_save -> diretório no qual serão salvas os gráficos gerados na simulação)
    function mef(max_degree, folder_to_save)
        n_values = [4^i for i in 1:(max_degree)]
        xi = a
        xf = b

        g_a = 0
        g_b = functions.u(xf)

        q_a = functions.du(xi)
        q_b = 0

        kappa_a = 0
        kappa_b = 10^6

        simulation_times = zeros(size(n_values)[1], 4)
        line, column = 0, 0

        for nel in n_values
            line += 1
            column = 1

            p = plot(layout=(2, 2), size=(1000, 1000))

            for k in 1:4
                elapsed_time = @elapsed begin
                    nint = k + 1
                    nen = nint

                    np = nel * k + 1
                    x = LinRange(xi, xf, np)
                    M = zeros(np, np)
                    F = zeros(np)

                    shg = SHL.shl(1, nen, nint)
                    dshg = SHL.shl(2, nen, nint)
                    dshg = reverse(dshg)

                    t = points_and_weights.pe(nint)
                    w = points_and_weights.we(nint)

                    idx = 1

                    h = (x[k + 1] - x[1])

                    for n in 1:(nel)
                        Me = zeros(nint, nint)
                        Fe = zeros(nint)

                        for l in 1:nint
                            for j in 1:nen
                                tt = t[l]
                                ww = w[l]
                                Fe[j] += functions.u_correct(tt, x[idx], x[idx + k]) * shg[j, l] * ww * h / 2

                                for i in 1:nen
                                    Me[i, j] += dshg[i, l] * dshg[j, l] * ww * 2 / h
                                end
                            end
                        end

                        for i in 0:nint - 1
                            F[idx + i] += Fe[i + 1]
                            for j in 0:nint - 1
                                M[idx + i, idx + j] += Me[i + 1, j + 1]
                            end
                        end
                        idx += k
                    end

                    M[1, 1] += kappa_a
                    F[1] += kappa_a * g_a - q_a

                    M[end, end] += kappa_b
                    F[end] += kappa_b * g_b - q_b

                    alphas = M \ F
                end

                simulation_times[line, column] += elapsed_time
                column += 1

                subplot_index = (ceil(Int, k / 2), k % 2 == 0 ? 2 : 1)

                plot!(p[subplot_index...], x, alphas, label="Aproximação MEF grau $k - nel $nel", color="blue")
                plot!(p[subplot_index...], x, alphas, label="Aproximação MEF no ponto", color="black", seriestype=:scatter, ms=2.5)
                plot!(p[subplot_index...], range(a, stop=b, length=100), x -> functions.u(x), seriestype=:scatter, label="Analítica", ms=1.5, color="red", msc=:auto)
                title!(p[subplot_index...], "Grau = $k - nel = $nel")
                plot!(p[subplot_index...], grid=true)
            end

            savefig(p, joinpath(folder_to_save, "grafico_nel_$(nel).png"))
        end

        return simulation_times
    end

end #module
