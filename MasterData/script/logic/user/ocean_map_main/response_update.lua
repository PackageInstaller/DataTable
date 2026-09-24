local var_0_0 = {}
local var_0_1 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:OceanMapInfoUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
			self:__ocean_map_action(iter_2_1.info.id, iter_2_1.action, iter_2_1.info)
		end
	end

	function arg_1_0:__ocean_map_action(arg_3_1, arg_3_2, arg_3_3)
		if arg_3_2 == var_0_1.update_modify then
			self:__ocean_map_update_task_info(arg_3_1, arg_3_3)
		elseif arg_3_2 == var_0_1.update_add then
			self:__ocean_map_add_task_info(arg_3_1, arg_3_3)
		elseif arg_3_2 == var_0_1.update_remove then
			self:__ocean_map_remove_task_info(arg_3_1, arg_3_3)
		end
	end

	function arg_1_0:OceanTeamInfoUpdate(arg_4_1)
		self:set_ocean_team_data(arg_4_1)
	end

	function arg_1_0:__ocean_team_action(arg_5_1, arg_5_2)
		if arg_5_1 == var_0_1.update_modify then
			self:__ocean_team_update_task_info(arg_5_2)
		elseif arg_5_1 == var_0_1.update_add then
			self:__ocean_team_add_task_info(arg_5_2)
		elseif arg_5_1 == var_0_1.update_remove then
			self:__ocean_team_remove_task_info(arg_5_2)
		end
	end

	function arg_1_0:OceanBuffInfoUpdate(arg_6_1)
		for iter_6_0, iter_6_1 in pairs(arg_6_1.updates) do
			self:__ocean_map_buff_action(iter_6_1.action, iter_6_1.info)
			self:set_ocean_map_buff_list(iter_6_1.info.id)
		end
	end

	function arg_1_0:OceanInfoUpdate(arg_7_1)
		self:set_ocean_shop_data(arg_7_1.info)
	end

	function arg_1_0:__ocean_map_buff_action(arg_8_1, arg_8_2)
		if arg_8_1 == var_0_1.update_modify then
			self:__ocean_map_buff_update_task_info(arg_8_2)
		elseif arg_8_1 == var_0_1.update_add then
			self:__ocean_map_buff_add_task_info(arg_8_2)
		elseif arg_8_1 == var_0_1.update_remove then
			self:__ocean_map_buff_remove_task_info(arg_8_2)
		end
	end
end

function var_0_0.extend_obj(arg_9_0)
	return
end

return var_0_0
