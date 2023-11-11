include("mef.jl")
using .MEF

using Printf


# functions.u(x) = sin(pi * x)
# functions.du(x) = pi * cos(pi * x)
# functions.trans_x(t, x1, x2) = t * (x2 - x1) / 2 + (x1 + x2) / 2
# functions.u_correct(t, x1, x2) = pi^2 * sin(pi * trans_x(t, x1, x2))

folder_path = "graficos/"

if !isdir(folder_path)
    mkdir(folder_path)
end

subfolder_name = "simulacao_do_MEF"

full_path = joinpath(folder_path, subfolder_name)

if !isdir(full_path)
    mkdir(full_path)
end

elapsed_time = @elapsed begin
    simulation_times = MEF.mef(5, full_path)
end

print("Tempo gasto no total da simulação: ")
@printf("%.4e\n", elapsed_time)

for i in 1:size(simulation_times, 1)
    nel = 4^i
    print("for nel = $nel: ")
    println(simulation_times[i, :])
end
