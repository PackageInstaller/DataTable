local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gameenum.error_type
local var_0_4 = gamecore.prompt
local var_0_6 = gamecore.user
local var_0_9 = gamecore.util_func
local var_0_10 = DG.Tweening.DOTween

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.PushEnterMapResp(arg_2_0, arg_2_1)
		if arg_2_1.result == 0 then
			var_0_1:createInstance("fight_prepare"):enter_map_resp()
		elseif arg_2_1.result == 10 then
			var_0_4:show(var_0_2:getNowLang("hasshipinrepair1"))
		elseif arg_2_1.result ~= 11 then
			var_0_4:show(var_0_3:get_err_msg(arg_2_1.result))
		else
			var_0_4:show(var_0_2:getNowLang("supply_not_enough"))
		end
	end

	function arg_1_0:PushMapMoveResp(arg_3_1)
		self._map_data.map_move = arg_3_1

		if arg_3_1.result == 0 then
			var_0_1:createInstance("fight_info"):__map_move_response(arg_3_1)
		else
			var_0_4:show(var_0_3:get_err_msg(arg_3_1.result))
		end
	end

	function arg_1_0.PushQuitMapResp(arg_4_0, arg_4_1)
		return
	end

	function arg_1_0.PushChooseBuffResp(arg_5_0, arg_5_1)
		if arg_5_1.result == 0 then
			local var_5_0 = var_0_1:getInstance("fight_info")

			var_5_0._control.fearlessness_buff_msgbox:SetActive(false)

			if not var_5_0._team_detail_data or not var_0_9.little_clone(var_5_0._team_detail_data) then
				-- block empty
			end

			if var_5_0._retropulsion_map_id then
				var_5_0:__show_fight_info(var_5_0._retropulsion_map_id)
			else
				local var_5_2 = var_0_1:getInstance("fearlessness_sea")

				if var_5_2 then
					var_5_2:show()

					return
				else
					var_0_1:destroyInstance("fight_info")
					var_0_1:createInstance("fearlessness_sea"):show()
				end
			end
		else
			var_0_4:show(var_0_3:get_err_msg(arg_5_1.result))
		end
	end

	function arg_1_0.PushBuyBuffResp(arg_6_0, arg_6_1)
		if arg_6_1.result == 0 then
			local var_6_0 = var_0_1:getInstance("ninth_cia")

			if var_6_0 then
				var_6_0:__init_panel()
			end
		else
			var_0_4:show(var_0_3:get_err_msg(arg_6_1.result))
		end
	end

	function arg_1_0.PushRemoveBuffResp(arg_7_0, arg_7_1)
		if arg_7_1.result == 0 then
			local var_7_0 = var_0_1:getInstance("push_pve_active_store")

			if var_7_0 then
				var_7_0:update_show_active_panel(true)
				var_7_0:autoKillDOTween(var_0_10.Sequence()):AppendCallback(function()
					var_7_0:set_remove_buff_after_panel()
				end)
				var_0_6:set_disassemble_buff(2)
			end
		end
	end

	function arg_1_0.PushAddBuffResp(arg_9_0, arg_9_1)
		if arg_9_1.result == 0 then
			local var_9_0 = var_0_1:getInstance("push_pve_active_store")

			if var_9_0 then
				var_9_0:update_show_active_panel()
				var_9_0:set_add_buff_after_panel()
			end
		end
	end

	function arg_1_0.PushActivityGetInResp(arg_10_0, arg_10_1)
		return
	end

	function arg_1_0.PushActivityRefreshResp(arg_11_0, arg_11_1)
		if arg_11_1.result == 0 then
			local var_11_0 = var_0_1:getInstance("fearlessness_sea")

			for iter_11_0 = 1, var_11_0._control.map_preview.map_bg.map_panel.map_node_root.transform.childCount do
				var_11_0:destroyChildren("map_node_obj")
				var_11_0:destroyChildren("map_line_obj")
				var_11_0:destroyChildren("fearlessness_sea_letter_obj")
			end

			local var_11_1, var_11_2 = var_0_6:get_map_random_buff_info()

			var_11_0:__set_node_data_by_map(var_11_1, nil, var_11_2)
		end
	end

	function arg_1_0.PushGuideResp(arg_12_0)
		return
	end

	function arg_1_0.PushResetBuffResp(arg_13_0, arg_13_1)
		if arg_13_1.result == 0 then
			local var_13_0 = var_0_1:getInstance("ninth_cia")

			if var_13_0 then
				var_13_0:__init_panel()
				var_0_4:show(var_0_2:getNowLang("ui_4th_buff_reset_tip"))
			end
		end
	end
end

function var_0_0.extend_obj(arg_14_0)
	return
end

return var_0_0
