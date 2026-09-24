local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = type
local var_0_3 = assert
local var_0_4 = string.format

lx.define_class("event_dispatch", function(arg_1_0)
	function arg_1_0:registerEventFunc(arg_2_1, arg_2_2)
		var_0_3(var_0_2(arg_2_2) == "function")

		if self._event_func[arg_2_1] then
			var_0_1.error(var_0_4("this event process function already register. " .. "event type:%s", tostring(arg_2_1)))
		end

		self._event_func[arg_2_1] = arg_2_2
	end

	function arg_1_0:setCoreArg(arg_3_1)
		var_0_3(arg_3_1)
		var_0_3(arg_3_1.reinitEventFunc)
		var_0_3(self._core_arg == nil)

		self._core_arg = arg_3_1
		self._event_func = {}

		self._core_arg:reinitEventFunc()
	end

	function arg_1_0.reinitEventFunc(arg_4_0)
		var_0_1.error("need override this method")
	end

	function arg_1_0:eventOnHotUpdate()
		self._event_func = {}

		self._core_arg:reinitEventFunc()
	end

	function arg_1_0:get_c_point()
		return self._c_point
	end

	function arg_1_0:dispatch(arg_7_1, ...)
		if self._event_func[arg_7_1] then
			self._event_func[arg_7_1](self._core_arg, ...)
		else
			var_0_1.error(var_0_4("unknow event type:%s", tostring(arg_7_1)))
		end
	end
end)

function var_0_0.create(arg_8_0, arg_8_1)
	local var_8_0 = var_0_1.class("event_dispatch")

	var_8_0._c_point = arg_8_1
	var_8_0._core_arg = nil
	var_8_0._event_func = nil

	var_0_1.event_manager:addEventObj(var_8_0)

	return var_8_0
end

return var_0_0
