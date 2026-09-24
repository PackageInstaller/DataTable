local var_0_0 = {}
local var_0_1 = lx

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_1.add_to_lx("_print_r_", arg_1_1(arg_1_0 .. ".print_r"))
	var_0_1.add_to_lx("_check_clear_old_", arg_1_1(arg_1_0 .. ".check_clear_old"))
	arg_1_1(arg_1_0 .. ".log")
	var_0_1._print_r_.reset_dump()
end

return var_0_0
