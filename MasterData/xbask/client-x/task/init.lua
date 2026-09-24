local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = table.insert

function var_0_0.init(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in pairs({
		"task_event"
	}) do
		var_0_1.add_to_lx(iter_1_1, arg_1_1(arg_1_0 .. "." .. iter_1_1))
	end

	local var_1_0 = {}

	if lx_core_x.is_starter() then
		var_0_2(var_1_0, "task_manager")
	else
		var_0_2(var_1_0, "task")
	end

	for iter_1_2, iter_1_3 in pairs(var_1_0) do
		var_0_1.register_instance(iter_1_3, arg_1_1(arg_1_0 .. "." .. iter_1_3))
	end
end

return var_0_0
