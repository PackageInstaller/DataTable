local var_0_0 = {}
local var_0_1 = type
local var_0_2 = loadfile
local var_0_3 = require
local var_0_4 = setfenv
local var_0_5 = setmetatable
local var_0_6 = tostring
local var_0_7 = string.format
local var_0_8 = string.find
local var_0_9 = string.gsub
local var_0_10 = table.insert
local var_0_13 = debug.traceback
local var_0_14
local var_0_15 = _G.__core_x_instance__.hot_update

local function var_0_17(arg_1_0)
	if var_0_8(arg_1_0, "%*") or var_0_8(arg_1_0, "^%.") or var_0_8(arg_1_0, "%.$") then
		lx.error(var_0_7("package name failed!, package name:%s", arg_1_0))
	end
end

local function var_0_18(arg_2_0, arg_2_1)
	var_0_17(arg_2_0)

	return var_0_3(arg_2_1 .. var_0_9(arg_2_0, "%.", "/"))
end

local function var_0_19(arg_3_0, arg_3_1, arg_3_2)
	var_0_17(arg_3_0)

	if var_0_1(arg_3_2) ~= "table" then
		lx.error(var_0_7("env table failed, env table:%s", var_0_6(arg_3_2)))
	end

	local var_3_0 = arg_3_1 .. var_0_9(arg_3_0, "%.", "/") .. ".lua"
	local var_3_1 = var_0_2(var_3_0)

	if var_0_1(var_3_1) ~= "function" then
		lx.error(var_0_7("not find file, path:%s", var_3_0))
	end

	return var_0_4(var_3_1, (var_0_5({}, arg_3_2)))()
end

local function var_0_20(arg_4_0)
	return var_0_18(arg_4_0, var_0_14)
end

local function var_0_21()
	function lx.error(arg_6_0)
		_G.error(var_0_13(arg_6_0, 2), 2)
	end

	function lx.warning(arg_7_0)
		print(var_0_13(var_0_7("[warning] %s", arg_7_0), 2))
	end

	function lx.is_first_start()
		return not var_0_15.is_hot_update
	end

	function lx.is_hot_update()
		return var_0_15.is_hot_update
	end

	function lx.add_do_hot_update_prefix(arg_10_0)
		for iter_10_0, iter_10_1 in pairs(var_0_15.hot_do_prefix) do
			if iter_10_1 == arg_10_0 then
				return
			end
		end

		var_0_10(var_0_15.hot_do_prefix, arg_10_0)
	end

	function lx.__real_hot_update_all(arg_11_0)
		local var_11_0 = {}

		for iter_11_0, iter_11_1 in pairs(package.loaded) do
			var_11_0[iter_11_0] = iter_11_1
		end

		for iter_11_2, iter_11_3 in pairs(var_11_0) do
			if var_0_8(iter_11_2, "^" .. arg_11_0) then
				package.loaded[iter_11_2] = nil
				_G[iter_11_2] = nil
			end
		end
	end

	function lx.hotUpdateAll()
		for iter_12_0, iter_12_1 in pairs(var_0_15.hot_do_prefix) do
			lx.__real_hot_update_all(iter_12_1)
		end

		local var_12_0 = "\n"

		if lx_node_x.reload_all_data_packet then
			var_12_0 = string.format("%s\treload data error num:%d\n", var_12_0, (lx_node_x.reload_all_data_packet()))
			var_12_0 = string.format("%s\treload script error num:%d\n", var_12_0, (lx_node_x.reload_all_script_packet()))
		end

		if not lx_core_x.restart() then
			return var_12_0 .. "\tcore restart failed.\n"
		end

		lx.event_manager:eventOnHotUpdate()
		lx.on_hot_update()

		return var_12_0 .. "\thotupdate all succeed.\n"
	end

	function lx_core_x.get_log_root_dir()
		return lx_node_x.get_log_dir()
	end
end

local function var_0_22(arg_14_0, arg_14_1)
	_G.__core_x_instance__.path = arg_14_1
	var_0_14 = arg_14_1

	if _G.lx then
		var_0_15.is_hot_update = true
	else
		_G.lx = {}
		_G.lx_core_x = _G["core-x"]
		_G["core-x"] = nil

		var_0_21()
	end

	lx.import = var_0_18
	lx.env_import = var_0_19

	var_0_20(arg_14_0 .. ".core.core_x_extend")
	var_0_20(arg_14_0 .. ".core.lua_all_compat")

	lx.bind_class_extend_module = var_0_20(arg_14_0 .. ".core.class_extend")

	lx:bind_class_extend_module(_G.__core_x_instance__)
	lx.reset_class_extend()

	local var_14_0 = var_0_20(arg_14_0 .. ".core.class")

	var_14_0.reset_class_method()
	var_14_0.reset_define_class_check_repeat()
	var_14_0.reset_class()

	lx.define_class = var_14_0.define_class
	lx.class = var_14_0.class
	lx.add_to_lx = var_14_0.add_to_lx
	lx.register_instance = var_14_0.register_instance
	lx.reset_instance = var_14_0.reset_instance
end

function var_0_0.init(arg_15_0, arg_15_1)
	var_0_22(arg_15_0, arg_15_1)

	for iter_15_0, iter_15_1 in pairs({
		"event",
		"log",
		"ldb",
		"base",
		"time",
		"util_func",
		"http",
		"profiler",
		"security"
	}) do
		var_0_20(arg_15_0 .. "." .. iter_15_1 .. ".init").init(arg_15_0 .. "." .. iter_15_1, var_0_20)
	end

	lx.extend_complete()
	lx_core_x.set_init_flag(true)

	return true
end

return var_0_0
