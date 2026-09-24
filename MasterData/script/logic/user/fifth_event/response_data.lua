local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.error_type
local var_0_3 = gamecore.prompt
local var_0_4 = gamecore.Language
local var_0_5 = gamecore.user
local var_0_6 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.RecreationTeamSaveResp(arg_2_0, arg_2_1)
		if arg_2_1.result == 0 then
			local var_2_0 = var_0_1:getInstance("fight_prepare")

			if var_2_0 then
				var_2_0:refresh_concerto_info_list()
			end
		end
	end

	function arg_1_0:ConcertoEnterMapResp(arg_3_1)
		if arg_3_1.result == 0 then
			self:set_after_battle_flag(self._enter_battle_id)

			self._enter_battle_id = nil

			var_0_1:createInstance("fight_prepare"):enter_map_resp()
		elseif arg_3_1.result == 10 then
			var_0_3:show(var_0_4:getNowLang("hasshipinrepair1"))
		elseif arg_3_1.result ~= 11 then
			var_0_3:show(var_0_2:get_err_msg(arg_3_1.result))
		else
			var_0_3:show(var_0_4:getNowLang("supply_not_enough"))
		end
	end

	function arg_1_0:ConcertoMapMoveResp(arg_4_1)
		self._map_data.map_move = arg_4_1

		if arg_4_1.result == 0 then
			var_0_1:createInstance("fight_info"):__map_move_response(arg_4_1)
		else
			var_0_3:show(var_0_2:get_err_msg(arg_4_1.result))
		end
	end

	function arg_1_0.RecreationEnterMapResp(arg_5_0, arg_5_1)
		if arg_5_1.result == 0 then
			var_0_1:createInstance("fight_prepare"):enter_map_resp()
		elseif arg_5_1.result == 10 then
			var_0_3:show(var_0_4:getNowLang("hasshipinrepair1"))
		elseif arg_5_1.result ~= 11 then
			var_0_3:show(var_0_2:get_err_msg(arg_5_1.result))
		else
			var_0_3:show(var_0_4:getNowLang("supply_not_enough"))
		end
	end

	function arg_1_0:RecreationMoveMapResp(arg_6_1)
		self._map_data.map_move = arg_6_1

		if arg_6_1.result == 0 then
			var_0_1:createInstance("fight_info"):__map_move_response(arg_6_1)
		else
			var_0_3:show(var_0_2:get_err_msg(arg_6_1.result))
		end
	end

	function arg_1_0:ConcertoStationResp(arg_7_1)
		local var_7_0 = var_0_1:createInstance("fifth_event")

		self:set_after_station_flag(self._station_node)

		self._station_node = nil

		if var_7_0 then
			var_0_1:destroyInstance("combat_result")
			var_7_0:show()
		end

		var_0_1:destroyInstance("loading")
	end

	function arg_1_0.ConcertoStationExitResp(arg_8_0, arg_8_1)
		var_0_1:destroyInstance("loading")

		local var_8_0 = var_0_1:getInstance("dock_team")

		if var_8_0 then
			var_8_0:refresh_info_list()
			var_0_5:set_team_station_state(1, var_8_0._current_team_index, false)
			var_8_0._control.bg.middle_menu.cancel_station:SetActive(false)

			return
		end

		local var_8_1 = var_0_1:getInstance("fifth_event")

		if var_8_1 then
			var_8_1:refresh_line_list()
		end

		local var_8_2 = var_0_1:getInstance("fifth_preview_map")

		if var_8_2 then
			var_8_2:show()
		end
	end

	function arg_1_0.ConcertoGetRewardResp(arg_9_0, arg_9_1)
		local var_9_0 = var_0_1:createInstance("fifth_awardbox")

		if arg_9_1.result == 0 then
			local var_9_1 = arg_9_1.rewards

			var_9_0:__award_msgbox_list(arg_9_1.rewards)
			var_9_0:set_close_func(function()
				local var_10_0 = var_0_1:createInstance("new_ship_or_equip")

				for iter_10_0 = 1, #var_9_1 do
					if var_9_1[iter_10_0].type == 1 then
						var_10_0:show(true, {
							count = 1,
							type = 1,
							id = var_9_1[iter_10_0].id,
							is_new = var_9_1[iter_10_0].is_new
						}, var_0_6.enter_get_ship_type.combats_shop)
					end

					if var_9_1[iter_10_0].type == 4 then
						local var_10_1 = var_0_5:find_character_by_id(var_9_1[iter_10_0].id)

						var_10_0:show(true, {
							count = 1,
							type = 4,
							id = var_9_1[iter_10_0].id,
							is_new = var_9_1[iter_10_0].is_new
						}, var_0_6.enter_get_ship_type.combats_shop)
					end
				end
			end)
			var_9_0:__update_award_cell()
		end
	end

	function arg_1_0.RecreationShopBuyResp(arg_11_0, arg_11_1)
		if arg_11_1.result == 0 then
			local var_11_0 = var_0_1:getInstance("fifth_restore_shop")

			if not var_11_0 then
				return
			end

			var_11_0:__buy_succeed_func(arg_11_1.rewards)
		else
			var_0_3:show(var_0_2:get_err_msg(arg_11_1.result))
		end
	end

	function arg_1_0.ConcertoReadResp(arg_12_0, arg_12_1)
		return
	end
end

function var_0_0.extend_obj(arg_13_0)
	return
end

return var_0_0
