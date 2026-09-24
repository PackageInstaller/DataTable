local var_0_0 = {}
local var_0_1 = table.insert
local var_0_3 = gamecore.util_func
local var_0_4 = gameconfig.guide_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:get_guide_info()
		return self._guide_data
	end

	function arg_1_0:get_guide_state()
		return self:__get_config_max_group() > #self._guide_data
	end

	function arg_1_0.reset_guide_state(arg_4_0)
		arg_4_0._guide_data = {}
	end

	function arg_1_0:__guide__add_info(arg_5_1)
		if not var_0_3.get_curr_exist_state(self._guide_data, arg_5_1) then
			var_0_1(self._guide_data, arg_5_1)
		end
	end

	function arg_1_0:__guide__update_info(arg_6_1)
		local var_6_0 = 0

		for iter_6_0, iter_6_1 in pairs(self._guide_data) do
			if iter_6_1 == arg_6_1 then
				var_6_0 = iter_6_0
			end
		end

		if var_6_0 == 0 then
			var_0_1(self._guide_data, arg_6_1)
		else
			self._guide_data[var_6_0] = arg_6_1
		end
	end

	function arg_1_0.__guide__remove_info(arg_7_0, arg_7_1)
		return
	end

	function arg_1_0.__get_config_max_group(arg_8_0)
		local var_8_0, var_8_1 = var_0_4:get_sequence()
		local var_8_2 = 0

		for iter_8_0, iter_8_1 in pairs(var_8_0) do
			if var_8_2 < iter_8_1.group then
				var_8_2 = iter_8_1.group
			end
		end

		return var_8_2
	end
end

function var_0_0.extend_obj(arg_9_0)
	arg_9_0._guide_data = {}
end

return var_0_0
