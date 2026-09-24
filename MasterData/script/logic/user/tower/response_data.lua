local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gameenum.error_type
local var_0_4 = gamecore.prompt
local var_0_8 = gamecore.user
local var_0_10 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.TowerGetChipResp(arg_2_0, arg_2_1)
		if arg_2_1.result == 0 then
			local var_2_0 = var_0_1:getInstance("analysis_room")

			if var_2_0 then
				var_2_0:update_card_count()
			end

			var_0_1:createInstance("tactical_machine"):show({
				is_new = true,
				id = arg_2_1.id
			})
		end
	end

	function arg_1_0.TowerGetRewardResp(arg_3_0, arg_3_1)
		if arg_3_1.result == 0 then
			local var_3_0 = var_0_1:createInstance("mail_box")

			var_3_0:setVisible(true)

			local var_3_1 = var_0_1:getInstance("awardbox")

			var_3_0:show_awards_enter_from_other_ways((var_3_1 or nil) and var_3_1:sort_awrd_data(arg_3_1.reward))
			var_0_1:createInstance("climb_tower"):check_if_has_reward_not_receive()
		end
	end

	function arg_1_0.TowerResetLevelResp(arg_4_0, arg_4_1)
		if arg_4_1.result == 0 then
			local var_4_0 = var_0_1:getInstance("climb_tower")

			if var_4_0 then
				var_4_0:reset_event_resp()
			end
		else
			var_0_4:show(var_0_3:get_err_msg(arg_4_1.result))
		end
	end

	function arg_1_0.TowerChipInTransientResp(arg_5_0, arg_5_1)
		local var_5_0 = var_0_1:getInstance("tactical_machine")

		if var_5_0 then
			if var_5_0._is_from_buff_map then
				var_5_0:__close_to_buffmap()
			else
				var_5_0:show()
			end
		end
	end

	function arg_1_0.TowerDecomposeChipResp(arg_6_0, arg_6_1)
		if arg_6_1 then
			local var_6_0 = var_0_1:getInstance("tactical_machine")

			if var_6_0 then
				var_6_0:show()
			end
		end
	end

	function arg_1_0.TowerTransientEquipResp(arg_7_0, arg_7_1)
		if arg_7_1.result then
			local var_7_0 = var_0_1:getInstance("tactical_machine")

			if var_7_0 then
				var_7_0:show()
			end
		end
	end

	function arg_1_0.TowerEquipChipResp(arg_8_0, arg_8_1)
		if arg_8_1.result then
			local var_8_0 = var_0_1:getInstance("tactical_machine")

			if var_8_0 then
				if not var_8_0._is_from_buff_map then
					var_8_0:show()
				else
					var_8_0:__close_to_buffmap()
				end
			end
		end
	end

	function arg_1_0.TowerChipAbandonResp(arg_9_0, arg_9_1)
		if arg_9_1.result == 0 then
			local var_9_0 = var_0_1:getInstance("tactical_machine")

			if var_9_0 then
				var_9_0:show()
			end
		end
	end

	function arg_1_0.TowerBuyChipResp(arg_10_0, arg_10_1)
		if arg_10_1.result == 0 then
			-- block empty
		else
			var_0_4:show(var_0_3:get_err_msg(arg_10_1.result))
		end
	end

	function arg_1_0.EnterTowerResp(arg_11_0, arg_11_1)
		if arg_11_1.result == 0 then
			local var_11_0 = var_0_1:getInstance("fight_prepare")

			if var_11_0 then
				var_11_0:__close_prepare()
			end

			local var_11_1 = var_0_8:get_battle_type()
			local var_11_2 = var_0_1:createInstance("climb_tower")

			if var_11_2 then
				var_11_2:check_if_has_reward_not_receive()
			end

			var_0_1:createInstance("campaign_select"):show(arg_11_1, var_0_10.select_prepare_type.tower_fight, (var_0_8:get_team_config_data(var_0_10.team_type.normal, (var_0_8:get_cur_click_team_index()))))
		elseif arg_11_1.result == 143 then
			var_0_4:show(var_0_2:getNowLang("ui_tower_ship_used"))
		else
			var_0_4:show(var_0_3:get_err_msg(arg_11_1.result))
		end
	end

	function arg_1_0.TowerGetNewResp(arg_12_0, arg_12_1)
		if arg_12_1 and arg_12_1.result == 0 then
			local var_12_0 = var_0_1:getInstance("climb_tower")

			if var_12_0 and arg_12_1.reward then
				var_12_0:show_first_award(arg_12_1.reward)
			end
		end
	end

	function arg_1_0.AnnouncementRefreshResp(arg_13_0, arg_13_1)
		return
	end

	function arg_1_0.AnnouncementUpdate(arg_14_0, arg_14_1)
		var_0_1:createInstance("announcement_rework"):show(arg_14_1)
	end
end

function var_0_0.extend_obj(arg_15_0)
	return
end

return var_0_0
