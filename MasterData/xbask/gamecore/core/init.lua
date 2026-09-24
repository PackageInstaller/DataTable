local var_0_0 = {}
local var_0_1 = type
local var_0_2 = assert
local var_0_3 = getmetatable
local var_0_4 = setmetatable
local var_0_5 = string.format
local var_0_6 = table.insert
local var_0_7 = debug.getupvalue
local var_0_8 = debug.setupvalue
local var_0_9 = lx.import
local var_0_10
local var_0_11
local var_0_12
local var_0_13

local function var_0_14(arg_1_0, arg_1_1)
	arg_1_1 = arg_1_1 or var_0_10

	return var_0_9(arg_1_0, arg_1_1)
end

local function var_0_15(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if var_0_1(arg_2_0) == "table" then
		if arg_2_3[arg_2_0] then
			return
		end

		arg_2_3[arg_2_0] = true

		for iter_2_0, iter_2_1 in pairs(arg_2_0) do
			var_0_15(iter_2_1, arg_2_1, arg_2_2, arg_2_3)
		end
	elseif var_0_1(arg_2_0) == "function" then
		while true do
			local var_2_0, var_2_1 = var_0_7(arg_2_0, 1)

			if not var_2_0 then
				break
			end

			if var_2_1 == arg_2_1 then
				var_0_8(arg_2_0, 1, arg_2_2)
			end
		end
	end
end

local function var_0_16(arg_3_0, arg_3_1, arg_3_2)
	var_0_15(arg_3_0, arg_3_1, arg_3_2, {})
end

local function var_0_17(arg_4_0, arg_4_1)
	if gamecore[arg_4_0] then
		lx.error(var_0_5("local_add_to_gamecore, but class module is already exist! " .. "class module name:%s", arg_4_0))
	end

	gamecore[arg_4_0] = arg_4_1
	var_0_11[arg_4_0] = true
	var_0_12[arg_4_0] = true
end

local function var_0_18(arg_5_0, arg_5_1)
	if gamecore[arg_5_0] then
		return
	end

	gamecore[arg_5_0] = arg_5_1()
	var_0_12[arg_5_0] = true
end

local function var_0_19()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(var_0_11) do
		var_6_0[iter_6_0] = iter_6_1
	end

	for iter_6_2, iter_6_3 in pairs(var_6_0) do
		gamecore[iter_6_2] = nil
		var_0_11[iter_6_2] = nil
	end
end

local function var_0_20()
	_G.gameenum = {}
end

local function var_0_21()
	_G.gameconfig = {
		__config_data__ = {}
	}
end

local function var_0_22()
	var_0_2(var_0_13 == nil, "when register, wait register list need is nil!")

	var_0_13 = {
		extend = {},
		module_sequence = {},
		instance = {},
		instance_sequence = {},
		other = {}
	}
end

local function var_0_23(arg_10_0)
	if var_0_1(arg_10_0) ~= "function" then
		lx.error("finish register, but import function error!")
	end

	if var_0_1(var_0_13) ~= "table" then
		lx.error("finish register, but wait register list error!")
	end

	local var_10_0 = gamecore
	local var_10_1 = {}

	for iter_10_0, iter_10_1 in pairs(var_0_13.instance) do
		if var_10_0[iter_10_0] then
			var_10_1[iter_10_0] = true
		else
			var_10_0[iter_10_0] = {}
		end
	end

	for iter_10_2, iter_10_3 in pairs(var_0_13.extend) do
		for iter_10_4, iter_10_5 in pairs(iter_10_3) do
			local var_10_2 = arg_10_0(iter_10_5.path)

			if var_0_1(var_10_2) ~= "table" then
				lx.error(var_0_5("register class extend, but param error, " .. "class extend name:%s, path:%s", iter_10_2, iter_10_5.path))
			end

			for iter_10_6, iter_10_7 in pairs(var_10_2) do
				iter_10_5.m[iter_10_6] = iter_10_7
			end

			gamecore.raw_register_class_extend(iter_10_2, iter_10_5.m)
		end
	end

	for iter_10_8, iter_10_9 in pairs(var_0_13.module_sequence) do
		local var_10_3 = arg_10_0(iter_10_9.path)

		if var_0_1(var_10_3) ~= "table" then
			lx.error(var_0_5("register class module to gamecore namespace, but param type error, " .. "class module name:%s, path:%s", iter_10_9.name, iter_10_9.path))
		end

		local var_10_4 = var_10_0[iter_10_9.name]

		for iter_10_10, iter_10_11 in pairs(var_10_3) do
			var_10_4[iter_10_10] = iter_10_11
		end
	end

	for iter_10_12, iter_10_13 in pairs(var_0_13.instance_sequence) do
		local var_10_5 = arg_10_0(iter_10_13.path)

		if var_0_1(var_10_5) ~= "function" then
			lx.error(var_0_5("register instance to gamecore namespace, but param type error, " .. "instance name:%s, path:%s", iter_10_13.name, iter_10_13.path))
		end

		if not var_10_1[iter_10_13.name] then
			local var_10_6 = var_10_5()

			for iter_10_14, iter_10_15 in pairs(var_10_6) do
				var_10_0[iter_10_13.name][iter_10_14] = iter_10_15
			end

			var_0_4(var_10_0[iter_10_13.name], var_0_3(var_10_6))
			var_0_16(var_10_0[iter_10_13.name], var_10_6, var_10_0[iter_10_13.name])
		end
	end

	var_0_13 = nil

	gamecore.extend_complete()
	gamecore.traceback_auto_skip()
end

local function var_0_24()
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(var_0_13.module_sequence) do
		var_11_0[iter_11_1.name] = true
	end

	for iter_11_2, iter_11_3 in pairs(var_0_13.instance) do
		var_11_0[iter_11_2] = true
	end

	for iter_11_4, iter_11_5 in pairs(var_0_13.other) do
		var_11_0[iter_11_4] = true
	end

	for iter_11_6, iter_11_7 in pairs(var_0_12) do
		var_11_0[iter_11_6] = true
	end

	return var_11_0
end

local function var_0_25(arg_12_0, arg_12_1)
	if var_0_1(var_0_13) ~= "table" then
		lx.error("register class extend, but wait register list error!")
	end

	if var_0_1(arg_12_0) ~= "string" or var_0_1(arg_12_1) ~= "string" then
		lx.error("register class extend, but param type error!")
	end

	local var_12_0 = var_0_13.extend[arg_12_0]

	if not var_0_13.extend[arg_12_0] then
		var_12_0 = {}
		var_0_13.extend[arg_12_0] = var_12_0
	end

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		if iter_12_1.path == arg_12_1 then
			lx.error(var_0_5("register class extend, but class extend path is already exist! " .. "class extend name:%s, path:%s", arg_12_0, arg_12_1))
		end
	end

	var_0_6(var_12_0, {
		path = arg_12_1,
		m = {}
	})
end

local function var_0_26(arg_13_0, arg_13_1)
	if var_0_1(var_0_13) ~= "table" or var_0_1(arg_13_1) ~= "string" then
		lx.error("register class module to gamecore namespace, but wait register list error!")
	end

	if var_0_1(arg_13_0) ~= "string" or var_0_1(arg_13_1) ~= "string" then
		lx.error("register class module to gamecore namespace, but param type error!")
	end

	local var_13_0 = gamecore

	if gamecore[arg_13_0] then
		lx.error(var_0_5("register class module to gamecore namespace, but is already exist! " .. "class module name:%s", arg_13_0))
	end

	var_0_6(var_0_13.module_sequence, {
		name = arg_13_0,
		path = arg_13_1
	})

	var_13_0[arg_13_0] = {}
	var_0_11[arg_13_0] = true
end

local function var_0_27(arg_14_0, arg_14_1)
	if var_0_1(var_0_13) ~= "table" or var_0_1(arg_14_1) ~= "string" then
		lx.error("register instance to gamecore namespace, but wait register list error!")
	end

	if var_0_1(arg_14_0) ~= "string" or var_0_1(arg_14_1) ~= "string" then
		lx.error("register instance to gamecore namespace, but param type error!")
	end

	local var_14_0 = var_0_13.instance

	if var_0_13.instance[arg_14_0] then
		lx.error(var_0_5("register instance to gamecore namespace, but is already exist! " .. "instance name:%s", arg_14_0))
	end

	var_0_6(var_0_13.instance_sequence, {
		name = arg_14_0,
		path = arg_14_1
	})

	var_14_0[arg_14_0] = true
end

local function var_0_28(arg_15_0, arg_15_1)
	if gameenum[arg_15_0] then
		lx.error(var_0_5("register enum module to gameenum namespace, but is already exist! " .. "enum module name:%s", arg_15_0))
	end

	gameenum[arg_15_0] = arg_15_1

	lx.traceback_add_skip_value(arg_15_1)
end

local function var_0_29(arg_16_0, arg_16_1)
	if gameconfig[arg_16_0] then
		lx.error(var_0_5("register config obj to gameconfig namespace, " .. "but is already exist! config obj name:%s", arg_16_0))
	end

	gameconfig[arg_16_0] = arg_16_1

	lx.traceback_add_skip_value(arg_16_1)
end

local function var_0_30(arg_17_0, arg_17_1)
	if gameconfig.__config_data__[arg_17_0] then
		lx.error(var_0_5("register config data to gameconfig __config_data__, " .. "but is already exist! config data name:%s", arg_17_0))
	end

	gameconfig.__config_data__[arg_17_0] = arg_17_1

	lx.traceback_add_skip_value(arg_17_1)
end

local function var_0_31()
	lx.traceback_add_skip_value(_G)

	for iter_18_0, iter_18_1 in pairs(_G) do
		lx.traceback_add_skip_value(iter_18_1)

		if var_0_1(iter_18_1) == "table" then
			for iter_18_2, iter_18_3 in pairs(iter_18_1) do
				lx.traceback_add_skip_value(iter_18_3)
			end
		end
	end
end

local function var_0_32()
	return gamecore
end

local function var_0_33(arg_20_0)
	var_0_13.other[arg_20_0] = true
end

function var_0_0.init(arg_21_0, arg_21_1)
	_G.__core_x_instance__.other_module[arg_21_0] = _G.__core_x_instance__.other_module[arg_21_0] or {
		all_class = {},
		inherent = {}
	}
	_G.__core_x_instance__.other_module[arg_21_0].path = arg_21_1
	var_0_10 = arg_21_1
	var_0_11 = _G.__core_x_instance__.other_module[arg_21_0].all_class
	var_0_12 = _G.__core_x_instance__.other_module[arg_21_0].inherent
	var_0_13 = nil
	_G.gamecore = _G.gamecore or {}

	lx.bind_class_extend_module(gamecore, _G.__core_x_instance__.other_module[arg_21_0])

	if gamecore.raw_register_class_extend == nil then
		gamecore.raw_register_class_extend = gamecore.register_class_extend
	end

	gamecore.reset_class_extend()
	var_0_19()
	var_0_20()
	var_0_21()

	gamecore.start_register = var_0_22
	gamecore.finish_register = var_0_23
	gamecore.get_all_wait_register_name = var_0_24
	gamecore.register_class_extend = var_0_25
	gamecore.register_class_module = var_0_26
	gamecore.register_instance = var_0_27
	gamecore.register_enum = var_0_28
	gamecore.register_config = var_0_29
	gamecore.register_config_data = var_0_30
	gamecore.traceback_auto_skip = var_0_31
	gamecore.self = var_0_32
	gamecore.self_add_wait_register_name = var_0_33
	gamecore.local_add_to_gamecore = var_0_17
	gamecore.local_register_instance = var_0_18

	for iter_21_0, iter_21_1 in pairs({
		"protocol"
	}) do
		var_0_14(arg_21_0 .. "." .. iter_21_1 .. ".init").init(arg_21_0 .. "." .. iter_21_1, var_0_14)
	end

	gamecore.local_add_to_gamecore = nil
	gamecore.local_register_instance = nil

	var_0_31()

	return true
end

return var_0_0
