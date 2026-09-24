local var_0_0 = {}
local var_0_1 = gameenum.common_type
local var_0_2 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:BattleInfoUpdate(arg_2_1)
		if next(arg_2_1) and arg_2_1.battle_info then
			self:__map__update_battle_info(arg_2_1.battle_info)
		end
	end

	function arg_1_0:MapInfoUpdate(arg_3_1)
		for iter_3_0, iter_3_1 in pairs(arg_3_1.updates) do
			self:__map__update_map_info(iter_3_1.action, iter_3_1.info)
		end
	end

	function arg_1_0:ExpeditionInfoUpdate(arg_4_1)
		for iter_4_0, iter_4_1 in pairs(arg_4_1.updates) do
			self:__map__expedition_action(iter_4_1.action, iter_4_1.info)
		end
	end

	function arg_1_0:GetMapData()
		return self._map_data.map
	end

	function arg_1_0:GetMapDataById(arg_6_1)
		return self._map_data.map[arg_6_1]
	end

	function arg_1_0:ManeuverInfoUpdate(arg_7_1)
		for iter_7_0, iter_7_1 in pairs(arg_7_1.updates) do
			self:__map__maneuver_action(iter_7_1.action, iter_7_1.info)
		end

		self._refresh_count = arg_7_1.refresh_count

		local var_7_0 = var_0_2:getInstance("gotofight")

		if var_7_0 then
			var_7_0:update_exercise_info()

			if #arg_7_1.updates == 1 then
				var_7_0:update_exercise_item_panel(arg_7_1.updates[1].info)
			end
		end
	end

	function arg_1_0:ManeuverFriendRivalInfoUpdate(arg_8_1)
		for iter_8_0, iter_8_1 in pairs(arg_8_1.updates) do
			self:__maneuver_friend_rival_action(iter_8_1.action, iter_8_1.info)
		end
	end

	function arg_1_0:__map__expedition_action(arg_9_1, arg_9_2)
		if arg_9_1 == var_0_1.update_modify then
			self:__map__update_expedition_info(arg_9_2)
		elseif arg_9_1 == var_0_1.update_add then
			self:__map__add_expedition_info(arg_9_2)
		elseif arg_9_1 == var_0_1.update_remove then
			self:__map__remove_expedition_info(arg_9_2)
		end
	end

	function arg_1_0:__map__maneuver_action(arg_10_1, arg_10_2)
		if arg_10_1 == var_0_1.update_modify then
			self:__map__update_maneuver_info(arg_10_2)
		elseif arg_10_1 == var_0_1.update_add then
			self:__map__add_maneuver_info(arg_10_2)
		elseif arg_10_1 == var_0_1.update_remove then
			self:__map__remove_maneuver_info(arg_10_2)
		end
	end

	function arg_1_0:__maneuver_friend_rival_action(arg_11_1, arg_11_2)
		if arg_11_1 == var_0_1.update_modify then
			self:__maneuver_friend_rival_update(arg_11_2)
		elseif arg_11_1 == var_0_1.update_add then
			self:__maneuver_friend_rival_add(arg_11_2)
		elseif arg_11_1 == var_0_1.update_remove then
			self:__maneuver_friend_rival_remove(arg_11_2)
		end
	end
end

function var_0_0.extend_obj(arg_12_0)
	return
end

return var_0_0
