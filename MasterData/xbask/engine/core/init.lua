local var_0_0 = {}
local var_0_1 = lx.import
local var_0_2

local function var_0_3(arg_1_0, arg_1_1)
	arg_1_1 = arg_1_1 or var_0_2

	return var_0_1(arg_1_0, arg_1_1)
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	_G.__core_x_instance__.other_module[arg_2_0] = _G.__core_x_instance__.other_module[arg_2_0] or {}
	_G.__core_x_instance__.other_module[arg_2_0].path = arg_2_1
	var_0_2 = arg_2_1

	for iter_2_0, iter_2_1 in pairs({
		arg_2_2,
		"instance"
	}) do
		var_0_3(arg_2_0 .. "." .. iter_2_1 .. ".init").init(arg_2_0 .. "." .. iter_2_1, var_0_3)
	end

	lx.extend_complete()

	return true
end

return var_0_0
