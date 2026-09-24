local var_0_0 = {}
local var_0_1 = lx

function var_0_0.init(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in pairs({
		"secretbox"
	}) do
		var_0_1.add_to_lx(iter_1_1, arg_1_1(arg_1_0 .. "." .. iter_1_1))
	end

	for iter_1_2, iter_1_3 in pairs({
		"security"
	}) do
		var_0_1.register_instance(iter_1_3, arg_1_1(arg_1_0 .. "." .. iter_1_3))
	end
end

return var_0_0
