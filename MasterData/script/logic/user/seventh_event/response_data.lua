local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.error_type
local var_0_3 = gamecore.prompt
local var_0_4 = gamecore.Language
local var_0_5 = gamecore.user
local var_0_6 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.SeventhEnterMapResp(arg_2_0, arg_2_1)
		if arg_2_1.result == 0 then
			var_0_1:createInstance("fight_prepare"):enter_map_resp()
		elseif arg_2_1.result == 10 then
			var_0_3:show(var_0_4:getNowLang("hasshipinrepair1"))
		elseif arg_2_1.result == 147 then
			var_0_3:show(var_0_4:getNowLang("noticeshipisinguard"))
		elseif arg_2_1.result ~= 11 then
			var_0_3:show(var_0_2:get_err_msg(arg_2_1.result))
		else
			var_0_3:show(var_0_4:getNowLang("supply_not_enough"))
		end
	end

	function arg_1_0.SeventhGuideResp(arg_3_0, arg_3_1)
		return
	end

	function arg_1_0.SeventhQuitMapResp(arg_4_0, arg_4_1)
		return
	end

	function arg_1_0:SeventhMapMoveResp(arg_5_1)
		self._map_data.map_move = arg_5_1

		if arg_5_1.result == 0 then
			var_0_1:createInstance("fight_info"):__map_move_response(arg_5_1)
		else
			var_0_3:show(var_0_2:get_err_msg(arg_5_1.result))
		end
	end

	function arg_1_0.SeventhBigMapMoveResp(arg_6_0, arg_6_1)
		return
	end

	function arg_1_0.SeventhEnterEliteResp(arg_7_0, arg_7_1)
		if arg_7_1.result == 0 then
			local var_7_0 = var_0_1:getInstance("fight_prepare")

			if var_7_0 then
				var_7_0:__close_prepare()
			end

			local var_7_1 = var_0_5:get_battle_type()

			var_0_1:createInstance("campaign_select"):show(arg_7_1, var_0_6.select_prepare_type.seventh, (var_0_5:get_team_config_data(var_0_6.team_type.normal, (var_0_5:get_cur_click_team_index()))))
		elseif arg_7_1.result == 11 then
			var_0_3:show(var_0_4:getNowLang("errorcode_135"))
		else
			var_0_3:show(var_0_2:get_err_msg(arg_7_1.result))
		end
	end

	function arg_1_0.SeventhEnterChaseResp(arg_8_0, arg_8_1)
		if arg_8_1.result == 0 then
			local var_8_0 = var_0_1:getInstance("fight_prepare")

			if var_8_0 then
				var_8_0:__close_prepare()
			end

			local var_8_1 = var_0_5:get_battle_type()

			var_0_1:createInstance("campaign_select"):show(arg_8_1, var_0_6.select_prepare_type.seventh, (var_0_5:get_team_config_data(var_0_6.team_type.normal, (var_0_5:get_cur_click_team_index()))))
		elseif arg_8_1.result == 11 then
			var_0_3:show(var_0_4:getNowLang("errorcode_135"))
		else
			var_0_3:show(var_0_2:get_err_msg(arg_8_1.result))
		end
	end

	function arg_1_0:SeventhUpgradeBuffResp(arg_9_1)
		if arg_9_1.result == 0 then
			self:Do_SeventhUpgradeBuffReq_CallBackFunc()

			local var_9_0 = var_0_1:getInstance("mix_battle_plan")

			if var_9_0 then
				var_9_0:update_buff_data()
				var_9_0:update_buff_point()
				var_9_0:update_buff_item_display()
				var_9_0:buff_item_button_invoke()

				if not var_0_5:get_mix_battle_plan_order() then
					var_0_3:show(var_0_4:getNowLang("7th_buff_activation_succeed"))
				elseif var_0_5:get_mix_battle_plan_level() >= 2 then
					var_0_3:show(var_0_4:getNowLang("levelupsuccess"))
				else
					var_0_3:show(var_0_4:getNowLang("7th_buff_activation_succeed"))
				end
			end
		end
	end

	function arg_1_0.SeventhResetBuffResp(arg_10_0, arg_10_1)
		if arg_10_1.result == 0 then
			local var_10_0 = var_0_1:getInstance("mix_battle_plan")

			if var_10_0 then
				var_10_0:reset_record_ship_ton_click_record()
				var_10_0:update_buff_data()
				var_10_0:update_buff_point()
				var_10_0:update_buff_item_display(true)
				var_10_0:auto_select_last_buff_item()
			end
		end
	end

	function arg_1_0.SeventhTreasureGetAwardResp(arg_11_0, arg_11_1)
		if arg_11_1.result == 0 then
			local var_11_0 = var_0_1:getInstance("seven_sea_map")

			if var_11_0 then
				var_11_0:back_find_info(arg_11_1.reward)

				var_11_0._local_no_treasure = false
			else
				local var_11_1 = var_0_1:createInstance("seven_sea_map")

				var_11_1:back_find_info(arg_11_1.reward)

				var_11_1._local_no_treasure = false
			end
		else
			var_0_3:show(var_0_2:get_err_msg(arg_11_1.result))
		end
	end
end

function var_0_0.extend_obj(arg_12_0)
	return
end

return var_0_0
