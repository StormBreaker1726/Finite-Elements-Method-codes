include("L2_Projection.jl")
using Printf
using .L2_P

folder_path = "graficos/"

if !isdir(folder_path)
    mkdir(folder_path)
end
;

subfolder_name = "simulacao_da_projecao_l2"

full_path = joinpath(folder_path, subfolder_name)

if !isdir(full_path)
    mkdir(full_path)
end

elapsed_time = @elapsed begin
    simulation_times = L2_P.simulate_l2(5, full_path)
end

print("Tempo gasto no total da simulação: ")
@printf("%.4e\n", elapsed_time)

for i in 1:size(simulation_times, 1)
    nel = 4^i
    print("for nel = $nel: ")
    println(simulation_times[i, :])
end

