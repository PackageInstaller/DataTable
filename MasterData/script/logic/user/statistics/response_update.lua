local var_0_0 = {}

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:StatisticsInfoUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.statistics) do
			self:__statistics__action(iter_2_0, iter_2_1)
		end

		for iter_2_2, iter_2_3 in pairs(arg_2_1.statistics) do
			self._user_info_data[iter_2_2] = iter_2_3
		end
	end

	function arg_1_0:__statistics__action(arg_3_1, arg_3_2)
		self:update_player_statistics_data(arg_3_1, arg_3_2)
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
