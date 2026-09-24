local var_0_0 = {}

function var_0_0.init(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in pairs({
		"engine",
		"event"
	}) do
		arg_1_1(arg_1_0 .. "." .. iter_1_1 .. ".init").init(arg_1_0 .. "." .. iter_1_1, arg_1_1)
	end
end

return var_0_0
