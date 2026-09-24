local var_0_0 = {}
local var_0_1 = require
local var_0_2 = gameconfig
local var_0_3 = gamecore.register_config
local var_0_4 = gamecore.register_config_data
local var_0_5 = lx.jsonfile_decode

var_0_0._readonly = false
var_0_0._lua_root_path = ""
var_0_0._data_root_path = ""
var_0_0._data_type = ""

local function var_0_6(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in pairs(arg_1_0) do
		if type(iter_1_1) == "table" then
			arg_1_0[iter_1_0] = var_0_6(iter_1_1, arg_1_1)
		end
	end

	local var_1_0 = {}

	setmetatable(var_1_0, {
		__index = arg_1_0,
		__newindex = function(arg_2_0, arg_2_1, arg_2_2)
			lx.error(string.format("why change data config? config name:[%s], key:[%s], new value:[%s]", arg_1_1, tostring(arg_2_1), tostring(arg_2_2)))
		end,
		__pairs = function(arg_3_0)
			return pairs(arg_1_0)
		end,
		__ipairs = function(arg_4_0)
			return ipairs(arg_1_0)
		end,
		__len = function(arg_5_0)
			return #arg_1_0
		end
	})

	return var_1_0
end

local function var_0_7(arg_6_0, arg_6_1)
	return var_0_6(arg_6_0, arg_6_1)
end

function var_0_0.get_change_config(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in pairs(arg_7_0) do
		if iter_7_0 == arg_7_1 then
			return iter_7_1
		end
	end

	return false
end

local function var_0_8(arg_8_0, arg_8_1)
	arg_8_1 = arg_8_1 or var_0_0._lua_root_path .. arg_8_0 .. "_config"

	var_0_3(arg_8_0 .. "_config", (var_0_1(arg_8_1)))
end

local function var_0_9(arg_9_0, arg_9_1)
	local var_9_0, var_9_1 = var_0_5(arg_9_1)

	if not var_9_0 or not var_9_1 then
		log.errorlog(string.format("load config data failed, data path:%s", arg_9_1))

		return false
	end

	if var_0_0._readonly then
		var_9_0 = var_0_7(var_9_0, arg_9_0 .. "_config")
	end

	var_0_4(arg_9_0 .. "_config", var_9_0)
	var_0_2[arg_9_0 .. "_config"]._set_data(var_9_0)

	return true
end

function var_0_0.use_readonly()
	var_0_0._readonly = true
end

function var_0_0.set_data_type(arg_11_0)
	assert(type(arg_11_0) == "string" and arg_11_0 ~= "")

	var_0_0._data_type = arg_11_0
end

function var_0_0.set_lua_root_path(arg_12_0)
	assert(type(arg_12_0) == "string" and arg_12_0 ~= "")

	var_0_0._lua_root_path = arg_12_0
end

function var_0_0.set_data_root_path(arg_13_0)
	assert(type(arg_13_0) == "string" and arg_13_0 ~= "")

	var_0_0._data_root_path = arg_13_0
end

function var_0_0.register_all(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0) do
		var_0_8(iter_14_1)
	end
end

function var_0_0.init_one(arg_15_0, arg_15_1)
	return var_0_9(arg_15_0, arg_15_1)
end

function var_0_0.init_all(arg_16_0)
	collectgarbage("stop")

	for iter_16_0, iter_16_1 in pairs(arg_16_0) do
		if not var_0_9(iter_16_1) then
			return false
		end
	end

	collectgarbage("restart")
	collectgarbage("collect")

	return true
end

return var_0_0
