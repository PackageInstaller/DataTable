local var_0_0 = {}
local var_0_1 = lx

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_1.ldb = arg_1_1(arg_1_0 .. ".lxdebug")

	var_0_1.ldb.reset_dump()
end

return var_0_0
