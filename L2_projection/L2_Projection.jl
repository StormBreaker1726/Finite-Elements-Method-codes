module L2_P
    using Plots
    include("SHL.jl")
    using .SHL
    include("F.jl")
    using .F
    include("WE.jl")
    using .WE
    a = -2.0
    b = +2.0
    ;

    function simulate_l2(max_degree, folder_to_save::String)
        error = []
        nell  = []
        xl = []
        n_values = [4^i for i in 1:(max_degree)]
        # print()
        simulation_times = zeros(size(n_values)[1], 4)
        # print(simulation_times)
        # print(n_values)
        line, column = 0, 0
        for nel in n_values
            # fig, axs = plot(layout=(1, 4), size=(800, 200))
            line += 1
            column = 1
            for k in 1:4
                elapsed_time = @elapsed begin
                np = k * nel + 1 # número de nós da malha
                nen = k + 1 # número de nós no elemento
                nint = k + 1 # número de pontos de integração

                h = (b - a)/nel # espaçamento entre os elementos

                xl = zeros(np)
                xl[1] = a
                for i in 2:np
                    xl[i] = xl[i-1] + (h/k)
                end

                # definindo as matrizes globais
                M = zeros(np, np)
                F = zeros(np)
                # montando o problema global
                max_iter = (nel * k - (k - 1))
                for n in 1:max_iter
                    Me = zeros(nen, nen)
                    Fe = zeros(nen)
                    shg = SHL.shl(nen, nint)
                    w = WE.we(nint)
                    for l in 1:nint
                        xx = 0.0
                        for i in 1:nen
                            xx=xx+shg[i,l]*xl[n+i-1]
                        end
                        for j in 1:nen
                            Fe[j] = Fe[j] + F.f(xx)*shg[j,l]*w[l]*h/2.0
                            for i in 1:nen
                                Me[i,j] = Me[i,j] + shg[i,l]*shg[j,l]*w[l]*h/2.0
                            end
                        end
                    end
                    for j in 1:nen
                        F[n+j-1] = F[n+j-1] + Fe[j]
                        for i in 1:nen
                            M[n+i-1,n+j-1] = M[n+i-1,n+j-1] + Me[i,j]
                        end
                    end
                end
                alpha = zeros(np)
                alpha = M\F
                solucao = alpha

                fig = plot(size=(1000, 500))
                plot!(xl, solucao, label="aproximacao L2")  # Continuous line
                plot!(range(a, stop=b, length=100), x -> F.f(x), seriestype=:scatter, label="analitica", ms=2.5)  # Scatter plot
                title!("Grau = $k - nel = $nel")
                plot!(grid=true)  # Enable the grid
                # savefig("grafico_nel$(nel)_grau$(k).png")
                savefig(joinpath(folder_to_save, "grafico_nel_$(nel)_grau$(k).png"))
                # download("grafico_nel$nel_grau$k.png")  # Uncomment if you want to download the file
                # legend!("upper right")
                # display(fig)
                end
                # print("line $line and column $column in iter k = $k \n")
                simulation_times[line, column] += elapsed_time
                column += 1
            end
        end

        return simulation_times
    end
    ;

end #module
