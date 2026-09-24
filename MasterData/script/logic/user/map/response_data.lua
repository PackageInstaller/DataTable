local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.error_type
local var_0_3 = gamecore.Language
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.user
local var_0_6 = gamecore.prompt
local var_0_8 = gamecore.UserDataManager
local var_0_9 = gameconfig.pve_ninth_level_config
local var_0_10 = gameconfig.map_config
local var_0_11 = gameconfig.pve_active_map_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.EnterMapResp(arg_2_0, arg_2_1)
		if arg_2_1.result == 0 then
			var_0_1:createInstance("fight_prepare"):enter_map_resp()
		elseif arg_2_1.result == 10 then
			var_0_6:show(var_0_3:getNowLang("hasshipinrepair1"))
		elseif arg_2_1.result == 20 then
			var_0_6:show(var_0_3:getNowLang("not_ship"))
		elseif arg_2_1.result ~= 11 then
			var_0_6:show(var_0_2:get_err_msg(arg_2_1.result))
		else
			var_0_6:show(var_0_3:getNowLang("supply_not_enough"))
		end
	end

	function arg_1_0.EnterManeuverResp(arg_3_0, arg_3_1)
		if arg_3_1.result == 0 then
			local var_3_0 = var_0_1:getInstance("fight_prepare")

			if var_3_0 then
				var_3_0:__close_prepare()
			end

			arg_3_0._maneuver_resp_info = arg_3_1

			local var_3_1 = var_0_5:get_battle_type()
			local var_3_2

			if var_3_1 == var_0_4.battle_type.exercise then
				var_3_2 = var_0_4.select_prepare_type.exercise
			elseif var_3_1 == var_0_4.battle_type.friend_exercise then
				var_3_2 = var_0_4.select_prepare_type.friend_exercise
			end

			var_0_1:createInstance("campaign_select"):show(arg_3_1, nil, (var_0_5:get_team_config_data(var_0_4.team_type.normal, (var_0_5:get_cur_click_team_index()))))
		elseif arg_3_1.result == 11 then
			var_0_6:show(var_0_3:getNowLang("pvecampaignshipneedsupply"))
		elseif arg_3_1.result == 10 then
			var_0_6:show(var_0_3:getNowLang("pvecampaignshipinrepair"))
		else
			var_0_6:show(var_0_2:get_err_msg(arg_3_1.result))
		end
	end

	function arg_1_0:MapMoveResp(arg_4_1)
		self._map_data.map_move = arg_4_1

		if arg_4_1.result == 0 then
			var_0_1:createInstance("fight_info"):__map_move_response(arg_4_1)
		else
			var_0_6:show(var_0_2:get_err_msg(arg_4_1.result))
		end
	end

	function arg_1_0.ExpeditionStartResp(arg_5_0, arg_5_1)
		if arg_5_1.result == 0 then
			local var_5_0 = var_0_1:getInstance("fight_prepare")

			if var_5_0 then
				var_5_0:expedition_start_resp(true)
			end
		elseif arg_5_1.result == 10 then
			var_0_6:show(var_0_3:getNowLang("hasshipinrepair"))
		else
			var_0_6:show(var_0_2:get_err_msg(arg_5_1.result))
		end
	end

	function arg_1_0.ExpeditionStopResp(arg_6_0, arg_6_1)
		if arg_6_1.result == 0 then
			-- block empty
		else
			var_0_6:show(var_0_2:get_err_msg(arg_6_1.result))
		end
	end

	function arg_1_0.ExpeditionFinishResp(arg_7_0, arg_7_1)
		if arg_7_1.result == 0 then
			var_0_1:createInstance("fight_result"):show(arg_7_1)

			local var_7_0 = var_0_1:getInstance("gotofight")

			if var_7_0 then
				var_7_0:__update_red_dot()
			end
		else
			var_0_6:show(var_0_2:get_err_msg(arg_7_1.result))
		end
	end

	function arg_1_0.RoundAboutResp(arg_8_0, arg_8_1)
		local var_8_0 = var_0_1:getInstance("fight_info")

		if var_8_0 then
			var_8_0:set_send_req_state(true)
		end
	end

	function arg_1_0.ActiveShellingResp(arg_9_0, arg_9_1)
		return
	end

	function arg_1_0.RefreshRivalResp(arg_10_0)
		return
	end

	function arg_1_0.CompleteNodeHideResp(arg_11_0, arg_11_1)
		return
	end

	function arg_1_0.CompleteNodeMissResp(arg_12_0, arg_12_1)
		return
	end

	function arg_1_0.StationPointResp(arg_13_0, arg_13_1)
		var_0_1:destroyInstance("combat_result")
		var_0_1:destroyInstance("loading")

		if arg_13_1.battle_type == var_0_4.battle_type.seventh then
			local var_13_0 = var_0_1:createInstance("seven_sea_map")

			var_13_0:show((var_0_5:get_now_seven_map_id()))
			var_13_0:show_cover_func(false)
			var_0_8:setDataByID("is_seven_station", var_0_5:get_account_id(), string.sub(arg_13_1.id, 1, 4))
		elseif arg_13_1.battle_type == var_0_4.battle_type.answer then
			local var_13_1 = var_0_1:createInstance("score_push_map")

			var_13_1:show()
			var_13_1:show_score_panel_mix_panel(var_0_5:get_battle_info().id, var_0_5:get_is_cur_score_difficulty_mode())
			var_0_8:setDataByID("is_first_station", var_0_5:get_account_id(), string.sub(arg_13_1.id, 1, 4))
		elseif arg_13_1.battle_type == var_0_4.battle_type.eighth then
			local var_13_2 = var_0_1:createInstance("eighth_sea_map")

			var_13_2:show((var_0_5:get_now_eighth_map_id()))
			var_13_2:show_cover_func(false)
			var_0_8:setDataByID("is_eighth_station", var_0_5:get_account_id(), string.sub(arg_13_1.id, 1, 4))
		elseif arg_13_1.battle_type == var_0_4.battle_type.push then
			var_0_1:createInstance("fearlessness_sea"):show((var_0_5:get_fearlessness_id()))
		elseif arg_13_1.battle_type == var_0_4.battle_type.ninth then
			local var_13_3 = var_0_1:createInstance("ninth_main_map")

			var_13_3:show()

			local var_13_4 = var_0_5:get_battle_info().id

			if var_13_4 == var_13_3._active_config.levels[5] or var_13_4 == var_13_3._active_config.hardLevels[5] and var_0_5:get_is_ninth_boss() then
				if var_0_5:ninth_map_is_pass(var_13_3._active_config.levels[5]) then
					for iter_13_0 = 1, 4 do
						var_13_3:_show_map_panel(var_13_4, iter_13_0, var_13_3._ninth_hard_map_data[5].init_nodes)
					end
				else
					for iter_13_1 = 1, 4 do
						var_13_3:_show_map_panel(var_13_4, iter_13_1, var_13_3._ninth_normal_map_data[5].init_nodes)
					end
				end
			else
				var_13_3:_show_map_panel(var_13_4, 1, var_0_9.find_object_by_id(var_13_4).init_node_id)
			end
		elseif arg_13_1.battle_type == var_0_4.fight_type.gotofight then
			local var_13_5 = var_0_1:createInstance("gotofight")
			local var_13_6 = 1
			local var_13_7 = 1
			local var_13_8 = var_0_5:get_battle_info()
			local var_13_9 = var_13_8 and var_13_8.id

			if var_13_8 and var_13_8.id then
				local var_13_10 = var_0_5:get_new_battle_type() == gameenum.battle_type.fight_type.main and var_0_10.find_object_by_id(var_13_9) or var_0_11.find_object_by_id(var_13_9)

				if var_13_10 then
					var_13_6 = var_13_10.pve_id
					var_13_7 = tonumber(var_13_9) % 100
				end
			end

			if var_13_5 then
				var_0_1:destroyInstance("combat_result")
				var_0_1:destroyInstance("new_ship_or_equip")

				if var_0_1:getInstance("fight_info") then
					var_0_1:destroyInstance("fight_info")
				end

				var_13_5:show({
					is_open_init = true,
					toggle_index = var_0_4.fight_type.gotofight,
					init_chapter_index = var_13_6,
					init_map_index = var_13_7
				}, false)
			end
		end
	end

	function arg_1_0.StationPointExitResp(arg_14_0, arg_14_1)
		local var_14_0 = var_0_1:getInstance("fearlessness_sea")

		if var_14_0 then
			for iter_14_0 = 1, var_14_0._control.map_preview.map_bg.map_panel.map_node_root.transform.childCount do
				var_14_0:destroyChildren("map_node_obj")
				var_14_0:destroyChildren("map_line_obj")
				var_14_0:destroyChildren("fearlessness_sea_letter_obj")
			end

			var_14_0:__set_big_map_position()
			var_14_0:close_map_preview()
		end

		local var_14_1 = var_0_1:getInstance("seven_sea_map")

		if var_14_1 then
			var_14_1:update_map_preview_data()
			var_14_1:close_map_preview()
		end

		local var_14_2 = var_0_1:getInstance("eighth_sea_map")

		if var_14_2 then
			var_14_2:update_map_preview_data()
			var_14_2:close_map_preview()
		end

		local var_14_3 = var_0_1:getInstance("dock_team")

		if var_14_3 then
			var_14_3:refresh_info_list()
			var_14_3._control.bg.middle_menu.cancel_station:SetActive(false)
			var_0_8:setDataByID("is_first_station", var_0_5:get_account_id(), "0")
		end

		local var_14_4 = var_0_1:getInstance("gotofight")

		if var_14_4 then
			var_14_4._curr_set_chapter_index = -1

			var_14_4:__init_gotofight_panel()
		end

		var_0_1:destroyInstance("combat_result")
		var_0_1:destroyInstance("loading")
		var_0_1:destroyInstance("captainroom")
	end
end

function var_0_0.extend_obj(arg_15_0)
	return
end

return var_0_0
