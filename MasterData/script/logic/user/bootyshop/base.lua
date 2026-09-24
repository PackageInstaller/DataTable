local var_0_0 = {}

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.reset_bootyshop_data(arg_2_0)
		arg_2_0._spoils_data = {}
		arg_2_0._ban_data = {}
	end

	function arg_1_0:find_spoils_by_id(arg_3_1)
		return self:__spoils__find_by_id(arg_3_1)
	end

	function arg_1_0:get_spoils_list()
		return self._spoils_data
	end

	function arg_1_0:__spoils__update_spoils_info(arg_5_1)
		self._spoils_data[arg_5_1.id] = arg_5_1
	end

	function arg_1_0:__spoils__add_spoils_info(arg_6_1)
		self._spoils_data[arg_6_1.id] = arg_6_1
	end

	function arg_1_0:__spoils__remove_spoils_info(arg_7_1)
		self._spoils_data[arg_7_1.id] = nil
	end
end

function var_0_0.extend_obj(arg_8_0)
	arg_8_0._spoils_data = {}
	arg_8_0._ban_data = {}
end

return var_0_0
