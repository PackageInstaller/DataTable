local var_0_0 = lx
local var_0_1 = next
local var_0_2 = assert
local var_0_3 = string.format

lx.define_class("event_manager", function(arg_1_0)
	function arg_1_0:addEventObj(arg_2_1)
		var_0_2(arg_2_1:isTheClassType("event_dispatch"))
		var_0_2(not self._event_obj_set[arg_2_1:get_c_point()])

		self._event_obj_set[arg_2_1:get_c_point()] = arg_2_1
	end

	function arg_1_0:removeEventObj(arg_3_1)
		var_0_2(arg_3_1:isTheClassType("event_dispatch"))
		var_0_2(self._event_obj_set[arg_3_1:get_c_point()])

		self._event_obj_set[arg_3_1:get_c_point()] = nil
	end

	function arg_1_0.setIgnoreError(arg_4_0, arg_4_1)
		arg_4_0._ignore_error = arg_4_1
	end

	function arg_1_0:eventOnHotUpdate()
		for iter_5_0, iter_5_1 in pairs(self._event_obj_set) do
			iter_5_1:eventOnHotUpdate()
		end
	end

	function arg_1_0:destroy_instance()
		while true do
			local var_6_0 = var_0_1(self._event_obj_set)

			if not var_6_0 then
				break
			end

			self._event_obj_set[var_6_0] = nil
		end

		self._event_obj_set = {}
	end
end)

return function()
	local var_7_0 = var_0_0.class("event_manager")

	var_7_0._ignore_error = false
	var_7_0._event_obj_set = {}

	local var_7_1 = var_7_0._event_obj_set

	lx_core_x.start(function(arg_8_0, arg_8_1, ...)
		if var_7_1[arg_8_0] then
			var_7_1[arg_8_0]:dispatch(arg_8_1, ...)
		elseif not var_7_0._ignore_error then
			var_0_0.error(var_0_3("unknow event dispatch object. event type:%s", tostring(arg_8_1)))
		end
	end)

	return var_7_0
end
