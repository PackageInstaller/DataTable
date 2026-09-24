local var_0_0 = {}
local var_0_1 = lx

function var_0_0.init(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in pairs({
		"bind_object"
	}) do
		var_0_1.add_to_lx(iter_1_1, arg_1_1(arg_1_0 .. "." .. iter_1_1))
	end

	local var_1_0 = {}

	if var_0_1.is_main_thread() then
		table.insert(var_1_0, "monitor_report")
		table.insert(var_1_0, "main")
	else
		table.insert(var_1_0, "task_app")
	end

	for iter_1_2, iter_1_3 in pairs(var_1_0) do
		var_0_1.register_instance(iter_1_3, arg_1_1(arg_1_0 .. "." .. iter_1_3))
	end
end

return var_0_0
