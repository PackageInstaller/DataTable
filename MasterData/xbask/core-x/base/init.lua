local var_0_0 = {}
local var_0_1 = lx

function var_0_0.init(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in pairs({
		"list_base",
		"list",
		"appendlist",
		"dict",
		"vector",
		"map"
	}) do
		var_0_1.add_to_lx(iter_1_1, arg_1_1(arg_1_0 .. "." .. iter_1_1))
	end

	var_0_1._print_r_.dump_skip_name(var_0_1.list:skip_name_list())
	var_0_1._print_r_.dump_skip_name(var_0_1.appendlist:skip_name_list())
	var_0_1._print_r_.dump_hook_class("list")
	var_0_1._print_r_.dump_hook_class("appendlist")
	var_0_1.ldb.dump_skip_name(var_0_1.list:skip_name_list())
	var_0_1.ldb.dump_skip_name(var_0_1.appendlist:skip_name_list())
	var_0_1.ldb.dump_hook_class("list")
	var_0_1.ldb.dump_hook_class("appendlist")
end

return var_0_0
