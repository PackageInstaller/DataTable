local var_0_0 = {}

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:get_user_info()
		return self._user_info_data
	end

	function arg_1_0:get_player_statistics_data()
		return self._statistics_data
	end

	function arg_1_0:get_player_statistics_data_by_type(arg_4_1)
		local var_4_0

		for iter_4_0, iter_4_1 in pairs(self._statistics_data.map_drop_ship_type_to_num) do
			if iter_4_1.type == arg_4_1 then
				var_4_0 = iter_4_1.count
			end
		end

		return var_4_0
	end

	function arg_1_0:update_player_statistics_data(arg_5_1, arg_5_2)
		self._statistics_data[arg_5_1] = arg_5_2
	end
end

function var_0_0.extend_obj(arg_6_0)
	arg_6_0._statistics_data = {}
	arg_6_0.name = nil
	arg_6_0._user_info_data = {}
end

return var_0_0
