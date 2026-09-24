local var_0_0 = {}
local var_0_3 = table.sort
local var_0_4 = gamecore.util_func

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:get_bathroom_style()
		return (self:__get_sort_tb(self._bathroom_data.style_list))
	end

	function arg_1_0.__get_sort_tb(arg_3_0, arg_3_1)
		local var_3_0 = var_0_4.dict_to_array(arg_3_1)

		var_0_3(var_3_0, function(arg_4_0, arg_4_1)
			return arg_4_0 < arg_4_1
		end)

		return var_3_0
	end

	function arg_1_0:reset_bathroom_data()
		self._bathroom_data.style_list = {}
	end

	function arg_1_0:__bathroom_style__update_id(arg_6_1)
		self._bathroom_data.style_list[arg_6_1] = arg_6_1
	end

	function arg_1_0:__bathroom_style__add_id(arg_7_1)
		self._bathroom_data.style_list[arg_7_1] = arg_7_1
	end

	function arg_1_0:__bathroom_style__remove_id(arg_8_1)
		self._bathroom_data.style_list[arg_8_1] = nil
	end
end

function var_0_0.extend_obj(arg_9_0)
	arg_9_0._bathroom_data = {
		style_list = {}
	}
end

return var_0_0
