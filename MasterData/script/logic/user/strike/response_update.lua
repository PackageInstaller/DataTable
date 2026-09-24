local var_0_0 = {}
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:SolidMapInfoUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
			self:__strike_map_info__action(iter_2_1.info, iter_2_1.action)
		end
	end

	function arg_1_0:SolidAwardInfoUpdate(arg_3_1)
		for iter_3_0, iter_3_1 in pairs(arg_3_1.updates) do
			self:__strike_award_info__action(iter_3_1.id, iter_3_1.action)
		end
	end

	function arg_1_0:SolidTeamInfoUpdate(arg_4_1)
		self:set_strike_team_data(arg_4_1)
	end

	function arg_1_0:SolidInfoUpdate(arg_5_1)
		if arg_5_1 and arg_5_1.info and next(arg_5_1.info) then
			for iter_5_0, iter_5_1 in pairs(arg_5_1.info) do
				self._strike_info_data[iter_5_0] = iter_5_1
			end
		else
			self._strike_info_data = arg_5_1.info
		end

		self:set_strike_point_info(self._strike_info_data)
	end

	function arg_1_0:SolidExtendBuffUpdate(arg_6_1)
		if arg_6_1 and next(arg_6_1) then
			self:set_whole_buff_number(arg_6_1.num)
			self:set_whole_buff_state(arg_6_1.extend_buff == 1)
		else
			self:set_whole_buff_number(0)
			self:set_whole_buff_state(false)
		end
	end

	function arg_1_0:SolidMaxScoreUpdate(arg_7_1)
		if arg_7_1 then
			self:set_solid_server_honor_list(arg_7_1)
		end
	end

	function arg_1_0:__strike_map_info__action(arg_8_1, arg_8_2)
		if arg_8_2 == var_0_2.update_modify then
			self:__strike_map_info__update(arg_8_1)
		elseif arg_8_2 == var_0_2.update_add then
			self:__strike_map_info__add(arg_8_1)
		elseif arg_8_2 == var_0_2.update_remove then
			self:__strike_map_info__remove(arg_8_1)
		end
	end

	function arg_1_0:__strike_award_info__action(arg_9_1, arg_9_2)
		if arg_9_2 == var_0_2.update_modify then
			self:__strike_award_info__update(arg_9_1)
		elseif arg_9_2 == var_0_2.update_add then
			self:__strike_award_info__add(arg_9_1)
		elseif arg_9_2 == var_0_2.update_remove then
			self:__strike_award_info__remove(arg_9_1)
		end
	end
end

function var_0_0.extend_obj(arg_10_0)
	return
end

return var_0_0
