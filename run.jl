using GhpGhx
using JSON

inputs_dict = JSON.parsefile("inputs_base.json")

# Heating and cooling loads
inputs_dict["heating_thermal_load_mmbtu_per_hr"] = ones(8760) * 2
inputs_dict["cooling_thermal_load_ton"] = ones(8760) * 300

# TODO Add PVWatts API call for dry bulb temperature based on lat/long
inputs_dict["ambient_temperature_f"] = ones(8760) * 59.0

# TODO Add ground_k_by_climate_zone lookup functionality from REopt.jl and need lat/long too
inputs_dict["ground_thermal_conductivity_btu_per_hr_ft_f"] = 1.2

@info "Starting GhpGhx" #with timeout of $(timeout) seconds..."
results, inputs_params = GhpGhx.ghp_model(inputs_dict)
# Create a dictionary of the results data needed for REopt
GhpGhx_results = GhpGhx.get_results_for_reopt(results, inputs_params)
@info "GhpGhx model solved" #with status $(results["status"])."