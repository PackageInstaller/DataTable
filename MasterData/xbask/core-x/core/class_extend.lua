local var_0_0 = getmetatable
local var_0_1 = tostring
local var_0_2 = string.format
local var_0_3 = table.insert

local function var_0_4(arg_1_0, arg_1_1)
	if arg_1_0 then
		for iter_1_0, iter_1_1 in pairs(arg_1_0) do
			iter_1_1(arg_1_1)
		end
	end
end

local function var_0_5(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.wait_do
	local var_2_1 = arg_2_1.func

	function arg_2_0.reset_class_extend()
		local var_3_0 = {}

		for iter_3_0, iter_3_1 in pairs(var_2_1.method) do
			var_3_0[iter_3_0] = iter_3_1
		end

		for iter_3_2, iter_3_3 in pairs(var_3_0) do
			var_2_1.method[iter_3_2] = nil
		end

		local var_3_1 = {}

		for iter_3_4, iter_3_5 in pairs(var_2_1.obj) do
			var_3_1[iter_3_4] = iter_3_5
		end

		for iter_3_6, iter_3_7 in pairs(var_3_1) do
			var_2_1.obj[iter_3_6] = nil
		end
	end

	function arg_2_0.register_class_extend(arg_4_0, arg_4_1)
		if type(arg_4_1) ~= "table" or type(arg_4_1.extend_method) ~= "function" or type(arg_4_1.extend_obj) ~= "function" then
			lx.error("on register class extend, but param error!")
		end

		local var_4_2 = var_2_1.method[arg_4_0]

		if not var_2_1.method[arg_4_0] then
			var_4_2 = {}
			var_2_1.method[arg_4_0] = var_4_2
		end

		local var_4_3 = var_2_1.obj[arg_4_0]

		if not var_2_1.obj[arg_4_0] then
			var_4_3 = {}
			var_2_1.obj[arg_4_0] = var_4_3
		end

		for iter_4_0, iter_4_1 in pairs(var_4_2) do
			if iter_4_1 == arg_4_1.extend_method then
				lx.error("on register class extend, but method extend already exist.")
			end
		end

		for iter_4_2, iter_4_3 in pairs(var_4_3) do
			if iter_4_3 == arg_4_1.extend_obj then
				lx.error("on register class extend, but obj extend already exist.")
			end
		end

		var_0_3(var_4_2, arg_4_1.extend_method)
		var_0_3(var_4_3, arg_4_1.extend_obj)
	end

	function arg_2_0:extend_method()
		if var_0_0(self) ~= nil then
			lx.error(var_0_2("on extend class method, why metatable has metatable? class name:%s", var_0_1(self.__classname)))
		end

		if var_2_1.method[self.__classname] then
			var_0_4(var_2_1.method[self.__classname], self)
		else
			var_2_0.method[self.__classname] = self
		end
	end

	function arg_2_0:extend_obj()
		if var_0_0(self) == nil then
			lx.error(var_0_2("on extend class obj, why obj not has metatable? class name:%s", var_0_1(self.__classname)))
		end

		if var_2_1.obj[self.__classname] then
			var_0_4(var_2_1.obj[self.__classname], self)
		else
			local var_6_0 = var_2_0.obj[self.__classname]

			if not var_2_0.obj[self.__classname] then
				var_6_0 = {}
				var_2_0.obj[self.__classname] = var_6_0
			end

			var_6_0[self] = true
		end
	end

	function arg_2_0.extend_complete()
		for iter_7_0, iter_7_1 in pairs(var_2_0.method) do
			if var_2_1.method[iter_7_0] then
				var_0_4(var_2_1.method[iter_7_0], iter_7_1)
			else
				lx.error(var_0_2("class extend complete, " .. "but not find class extend method function, class name:%s", iter_7_0))
			end
		end

		for iter_7_2, iter_7_3 in pairs(var_2_0.obj) do
			if var_2_1.obj[iter_7_2] then
				for iter_7_4, iter_7_5 in pairs(iter_7_3) do
					var_0_4(var_2_1.obj[iter_7_2], iter_7_4)
				end
			else
				lx.error(var_0_2("class extend complete, " .. "but not find class extend object function, class name:%s", iter_7_2))
			end
		end

		var_2_0.method = {}
		var_2_0.obj = {}
	end
end

return function(arg_8_0, arg_8_1)
	if arg_8_1.class_extend then
		return
	end

	arg_8_1.class_extend = {
		wait_do = {
			method = {},
			obj = {}
		},
		func = {
			method = {},
			obj = {}
		}
	}

	var_0_5(arg_8_0, arg_8_1.class_extend)
end
