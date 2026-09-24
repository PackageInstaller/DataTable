local var_0_0 = string.format
local var_0_1 = debug.getlocal
local var_0_2 = debug.traceback

if not _G.__core_x_instance__.traceback then
	_G.__core_x_instance__.traceback = {
		stack_frame = 2,
		skip_name_set = {},
		skip_value_set = {}
	}

	setmetatable(_G.__core_x_instance__.traceback.skip_value_set, {
		__mode = "k"
	})

	lx.raw_xpcall = xpcall
end

local var_0_3 = _G.__core_x_instance__.traceback

function lx.traceback_add_skip_name(arg_1_0)
	var_0_3.skip_name_set[arg_1_0] = true
end

function lx.traceback_remove_skip_name(arg_2_0)
	var_0_3.skip_name_set[arg_2_0] = nil
end

function lx.traceback_clear_skip_name()
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs(var_0_3.skip_name_set) do
		var_3_0[iter_3_0] = iter_3_1
	end

	for iter_3_2, iter_3_3 in pairs(var_3_0) do
		var_0_3.skip_name_set[iter_3_2] = nil
	end
end

function lx.traceback_add_skip_value(arg_4_0)
	var_0_3.skip_value_set[arg_4_0] = true
end

function lx.traceback_remove_skip_value(arg_5_0)
	var_0_3.skip_value_set[arg_5_0] = nil
end

function lx.traceback_clear_skip_value()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(var_0_3.skip_value_set) do
		var_6_0[iter_6_0] = iter_6_1
	end

	for iter_6_2, iter_6_3 in pairs(var_6_0) do
		var_0_3.skip_value_set[iter_6_2] = nil
	end
end

function lx.traceback_set_stack_frame(arg_7_0)
	var_0_3.stack_frame = arg_7_0
end

local function var_0_4(arg_8_0)
	local var_8_0 = {}

	while true do
		local var_8_1, var_8_2 = var_0_1(arg_8_0, 1)

		if not var_8_1 then
			break
		end

		if not var_0_3.skip_value_set[var_8_2] then
			var_8_0[var_8_1] = var_8_2
		end
	end

	var_8_0["(*temporary)"] = nil

	for iter_8_0, iter_8_1 in pairs(var_0_3.skip_name_set) do
		var_8_0[iter_8_0] = nil
	end

	return lx._print_r_.format_value_for_table(var_8_0, "\ncontext", var_0_3.skip_value_set)
end

local function var_0_5(arg_9_0)
	if var_0_3.stack_frame == 2 then
		return var_0_0("%s%s%s\n%s%s", arg_9_0, var_0_4(3), var_0_2("", 2), var_0_4(4), var_0_2("", 3))
	else
		return var_0_0("%s%s%s\n%s%s\n%s%s", arg_9_0, var_0_4(3), var_0_2("", 2), var_0_4(4), var_0_2("", 3), var_0_4(5), var_0_2("", 4))
	end
end

lx.traceback_get_context_variable = var_0_4
lx.traceback = var_0_5

local var_0_6 = lx.raw_xpcall

function lx.xpcall(arg_10_0, arg_10_1, ...)
	return var_0_6(arg_10_0, var_0_5, ...)
end

xpcall = lx.xpcall
