local var_0_0 = type
local var_0_1 = getmetatable
local var_0_2 = setmetatable
local var_0_3 = string.format
local var_0_4 = table.insert
local var_0_5 = tolua
local var_0_6 = _G.__core_x_instance__.define_class_check_repeat
local var_0_7 = _G.__core_x_instance__.all_instance
local var_0_8 = _G.__core_x_instance__.all_class
local var_0_9 = _G.__core_x_instance__.all_method_meta_info
local var_0_10 = _G.__core_x_instance__.virtual_call

local function var_0_11(...)
	var_0_10.obj = nil
	var_0_10.func = nil

	return var_0_10.func(var_0_10.obj, ...)
end

local function var_0_12(arg_2_0, arg_2_1)
	var_0_10.obj = arg_2_0
	var_0_10.func = arg_2_1

	return var_0_11
end

local function var_0_13(arg_3_0, arg_3_1)
	while 1 <= #arg_3_0 do
		arg_3_1.__classname = arg_3_0[1]

		var_0_9[arg_3_0[1]].__index.__method_init_func(arg_3_1)
	end

	arg_3_1.__classname = arg_3_1.__classname
end

local function var_0_14(arg_9_0)
	local var_9_0 = _G
	local var_9_2 = 1

	while var_9_2 < arg_9_0:len() do
		local var_9_4

		var_9_4, var_9_2 = arg_9_0:find("[_%w][_%w]*", var_9_2)

		if not var_9_4 then
			do break end

			var_9_2 = var_9_2 + 1
		end

		var_9_0 = var_9_0[arg_9_0:sub(var_9_4, var_9_2)]
	end

	return var_9_0
end

local function var_0_15(arg_10_0, arg_10_1)
	local var_10_0 = var_0_5.type(arg_10_1)

	if not var_0_14(var_10_0) then
		lx.error(var_0_3("on inherit class, but not find the native base class, " .. "class name:%s, base class name:%s", arg_10_0, var_10_0))
	end

	if var_0_5.getpeer(arg_10_1) then
		lx.error(var_0_3("on inherit class, but the native class already do inherit, why? " .. "class name:%s, native base class name:%s", arg_10_0, var_10_0))
	end

	local var_10_1 = var_0_9[arg_10_0]

	if var_0_9[arg_10_0].__index.__native_classinfo.name then
		if var_0_9[arg_10_0].__index.__native_classinfo.name ~= var_10_0 then
			lx.error(var_0_3("on inherit class, " .. "but now native base class type as the last time not equal! " .. "class name:%s, now native class name:%s, last time native base class name:%s", arg_10_0, var_10_0, var_0_9[arg_10_0].__index.__native_classinfo.name))
		end
	else
		var_10_1.__index.__native_classinfo.name = var_10_0
	end

	local var_10_2 = {}

	var_0_2(var_10_2, var_10_1)
	var_0_5.setpeer(arg_10_1, var_10_2)

	return arg_10_1
end

return {
	define_class = function(arg_4_0, arg_4_1, arg_4_2)
		if var_0_0(arg_4_0) ~= "string" or var_0_0(arg_4_1) ~= "function" then
			lx.error(var_0_3("define class, but parameter error!, class name:%s", arg_4_0))
		end

		local var_4_0 = var_0_9[arg_4_0]
		local var_4_1

		if arg_4_2 then
			if var_0_0(arg_4_2) ~= "string" then
				lx.error(var_0_3("define class, but base class name error, " .. "class name:%s, base class name:%s", arg_4_0, arg_4_2))
			end

			var_4_1 = var_0_9[arg_4_2]

			if not var_0_9[arg_4_2] then
				lx.error(var_0_3("on define new class, but base class not find!, " .. "class name:%s, base class name:%s", arg_4_0, arg_4_2))
			end
		end

		if var_0_6[arg_4_0] then
			lx.error(var_0_3("define class, but this class already define!, " .. "class name:%s", arg_4_0))
		end

		var_0_6[arg_4_0] = true
		var_4_0 = var_4_0 or {
			__index = {}
		}

		local var_4_2 = var_4_0.__index

		var_4_2.__classname = arg_4_0
		var_4_2.__classname_idx = 0
		var_4_2.__native_classinfo = nil
		var_4_2.__method_init_func = arg_4_1
		var_4_2.__inherit_list = {}
		var_4_2.__inherit_info_by_name = {}

		function var_4_0.__index:getClassName()
			return self.__classname
		end

		function var_4_0.__index:getNativeClassName()
			return self.__native_classinfo.name
		end

		function var_4_0.__index:isTheClassType(arg_7_1)
			if var_0_0(arg_7_1) ~= "string" then
				return false
			end

			local var_7_0 = self.__classname_idx

			while var_7_0 > 0 do
				if self.__inherit_list[var_7_0] == arg_7_1 then
					return true
				end

				var_7_0 = var_7_0 - 1
			end

			return false
		end

		function var_4_0.__index:super(arg_8_1, arg_8_2)
			if var_0_0(arg_8_1) ~= "string" or var_0_0(arg_8_2) ~= "string" then
				lx.error(var_0_3("on call virtual function, " .. "but baseclass name or function name error, " .. "base class name:%s, function name:%s", arg_8_1, arg_8_2))
			end

			local var_8_0 = self

			if var_0_0(self) == "userdata" then
				var_8_0 = var_0_5.getpeer(var_8_0)
			end

			local var_8_1 = var_0_1(var_8_0)
			local var_8_2

			if var_8_1.__index.__inherit_info_by_name[arg_8_1] then
				var_8_2 = var_8_1.__index.__inherit_info_by_name[arg_8_1].method[arg_8_2]
			end

			if not var_8_2 and var_8_1.__index.__native_classinfo.name then
				var_0_2(var_8_0, var_8_0)

				var_8_2 = self[arg_8_2]

				var_0_2(var_8_0, var_8_1)
			end

			if not var_8_2 then
				lx.error(var_0_3("on call virtual function, but not find base class function, " .. "base class name:%s, function name:%s, now class name:%s", arg_8_1, arg_8_2, var_8_1.__index.__classname))
			end

			return var_0_12(self, var_8_2)
		end

		var_0_9[arg_4_0] = var_4_0

		if var_4_1 then
			for iter_4_0, iter_4_1 in pairs(var_4_1.__index.__inherit_list) do
				var_4_2.__inherit_list[iter_4_0] = iter_4_1
			end

			for iter_4_2, iter_4_3 in pairs(var_4_1.__index.__inherit_info_by_name) do
				var_4_2.__inherit_info_by_name[iter_4_2] = iter_4_3
			end

			var_0_13(var_4_1.__index.__inherit_list, var_4_2)

			var_4_2.__native_classinfo = var_4_1.__index.__native_classinfo
		else
			var_4_2.__native_classinfo = {}
		end

		var_0_4(var_4_2.__inherit_list, arg_4_0)

		var_4_2.__classname_idx = #var_4_2.__inherit_list

		var_4_2:__method_init_func()

		var_4_2.__inherit_info_by_name[arg_4_0] = {
			idx = var_4_2.__classname_idx,
			method = var_4_2
		}
	end,
	class = function(arg_11_0, arg_11_1)
		local var_11_0
		local var_11_1
		local var_11_2 = var_0_9[arg_11_0]

		if not var_0_9[arg_11_0] then
			lx.error(var_0_3("not find the define class, error! class name:%s", arg_11_0))
		end

		local var_11_3 = var_11_2.__index
		local var_11_4

		if arg_11_1 then
			local var_11_5 = var_0_0(arg_11_1)

			if var_11_5 == "userdata" then
				local var_11_6 = var_0_5.getpeer(arg_11_1)

				if var_11_6 then
					var_11_4 = arg_11_1
					arg_11_1 = var_11_6
				else
					return var_0_15(arg_11_0, arg_11_1)
				end
			elseif var_11_5 == "table" then
				if var_11_3.__classname_idx == 1 then
					lx.error(var_0_3("on inherit class, but class and base class link undefine! " .. "class name:%s", arg_11_0))
				end
			else
				lx.error(var_0_3("on inherit class, but base obj error!"))
			end

			var_11_0 = arg_11_1.__classname
			var_11_1 = var_0_9[arg_11_1.__classname]
		elseif var_11_3.__classname_idx ~= 1 then
			lx.error(var_0_3("on inherit class, need base class obj, but is nil, " .. "class name:%s", arg_11_0))
		end

		if var_11_1 then
			if var_11_3.__inherit_info_by_name[var_11_0] == nil then
				lx.error(var_0_3("on inherit class, but class not inherit from base class, " .. "class name:%s, base class name:%s", arg_11_0, var_11_0))
			end
		end

		arg_11_1 = arg_11_1 or {}
		arg_11_1 = var_0_2(arg_11_1, var_11_2)

		if var_11_4 then
			return var_11_4
		end

		return arg_11_1
	end,
	add_to_lx = function(arg_12_0, arg_12_1)
		if lx[arg_12_0] then
			lx.error(var_0_3("add class module to lx namespace, but is already exist! " .. "class module name:%s", arg_12_0))
		end

		lx[arg_12_0] = arg_12_1
		var_0_8[arg_12_0] = true
	end,
	register_instance = function(arg_13_0, arg_13_1)
		if var_0_0(arg_13_0) ~= "string" or var_0_0(arg_13_1) ~= "function" then
			lx.error(var_0_3("register instance to lx namespace, but param type error."))
		end

		local var_13_0 = lx

		if lx[arg_13_0] then
			return
		end

		local var_13_1 = arg_13_1()

		var_13_0[arg_13_0] = var_13_1
		var_0_7[arg_13_0] = var_13_1
	end,
	reset_class = function()
		local var_14_0 = {}

		for iter_14_0, iter_14_1 in pairs(var_0_8) do
			var_14_0[iter_14_0] = iter_14_1
		end

		for iter_14_2, iter_14_3 in pairs(var_14_0) do
			lx[iter_14_2] = nil
			var_0_8[iter_14_2] = nil
		end
	end,
	reset_define_class_check_repeat = function()
		local var_15_0 = {}

		for iter_15_0, iter_15_1 in pairs(var_0_6) do
			var_15_0[iter_15_0] = iter_15_1
		end

		for iter_15_2, iter_15_3 in pairs(var_15_0) do
			var_0_6[iter_15_2] = nil
		end
	end,
	reset_class_method = function()
		for iter_16_0, iter_16_1 in pairs(var_0_9) do
			local var_16_1 = {}

			for iter_16_2, iter_16_3 in pairs(iter_16_1.__index) do
				var_16_1[iter_16_2] = iter_16_3
			end

			for iter_16_4, iter_16_5 in pairs(var_16_1) do
				iter_16_1.__index[iter_16_4] = nil
			end
		end
	end,
	reset_instance = function()
		for iter_17_0, iter_17_1 in pairs(var_0_7) do
			if iter_17_1.destroy_instance then
				iter_17_1:destroy_instance()
			end
		end
	end
}
