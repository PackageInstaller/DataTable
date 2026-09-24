local var_0_0 = {}
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:AbyssTeamInfoUpdate(arg_2_1)
		self:set_normal_team_info(arg_2_1.members)
	end

	function arg_1_0:AbyssAbyssTeamInfoUpdate(arg_3_1)
		self:set_abyss_team_info(arg_3_1.members)
	end

	function arg_1_0:AbyssInfoUpdate(arg_4_1)
		self:__set_abyss_info(arg_4_1)
	end

	function arg_1_0:AbyssAwardUpdate(arg_5_1)
		self:__set_user_abyss_award(arg_5_1.updates)
	end

	function arg_1_0:AbyssShipInfoUpdate(arg_6_1)
		for iter_6_0, iter_6_1 in pairs(arg_6_1.updates) do
			self:__abyss_character_action(iter_6_1.info, iter_6_1.action)
		end
	end

	function arg_1_0:AbyssMapInfoUpdate(arg_7_1)
		self:__analyze_abyss_map_info(arg_7_1.updates)
	end

	function arg_1_0:AbyssBattleInfoUpdate(arg_8_1)
		self:set_abyss_team_buff_info(arg_8_1)
		self:sava_abyss_power(arg_8_1)
	end

	function arg_1_0:__abyss_character_action(arg_9_1, arg_9_2)
		if arg_9_2 == var_0_2.update_modify then
			self:__abyss_update_character_info(arg_9_1)
		elseif arg_9_2 == var_0_2.update_add then
			self:__abyss_add_character_info(arg_9_1)
		elseif arg_9_2 == var_0_2.update_remove then
			self:__abyss_remove_character_info(arg_9_1)
		end
	end
end

function var_0_0.extend_obj(arg_10_0)
	return
end

return var_0_0
