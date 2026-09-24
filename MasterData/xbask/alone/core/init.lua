local var_0_0 = {}
local var_0_1 = lx.import
local var_0_2

local function var_0_3(arg_1_0, arg_1_1)
	arg_1_1 = arg_1_1 or var_0_2

	return var_0_1(arg_1_0, arg_1_1)
end

function var_0_0.init(arg_2_0, arg_2_1)
	_G.__core_x_instance__.other_module[arg_2_0] = _G.__core_x_instance__.other_module[arg_2_0] or {}
	_G.__core_x_instance__.other_module[arg_2_0].path = arg_2_1
	var_0_2 = arg_2_1

	local var_2_0 = {
		"app"
	}

	if lx_core_x.is_starter() then
		local var_2_1 = {
			"time",
			"network",
			"loader",
			"platform"
		}

		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			table.insert(var_2_1, iter_2_1)
		end

		var_2_0 = var_2_1
	end

	for iter_2_2, iter_2_3 in pairs(var_2_0) do
		var_0_3(arg_2_0 .. "." .. iter_2_3 .. ".init").init(arg_2_0 .. "." .. iter_2_3, var_0_3)
	end

	return true
end

return var_0_0
