local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gameenum.error_type
local var_0_4 = gamecore.prompt
local var_0_5 = gamecore.user
local var_0_7 = gameenum.common_type
local var_0_8 = gamecore.util_func
local var_0_9 = table.insert
local var_0_10 = DG.Tweening.DOTween
local var_0_11 = gameconfig.chat_head_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.MistInfoUpdate(arg_2_0, arg_2_1)
		if arg_2_1.result == 0 then
			return
		end
	end

	function arg_1_0.MistChooseResp(arg_3_0, arg_3_1)
		if arg_3_1.result == 0 then
			local var_3_0 = var_0_5:get_mist_combat_info()
			local var_3_1 = var_0_1:getInstance("nf_map_node")

			if var_3_1 then
				var_3_1._control.left_bg.cur_count.text.text = var_3_0.coin
			else
				var_0_1:createInstance("nf_map_node")._control.left_bg.cur_count.text.text = var_3_0.coin
			end
		else
			var_0_4:show(var_0_3:get_err_msg(arg_3_1.result))
		end
	end

	function arg_1_0:MistBuyTicketResp(arg_4_1)
		local var_4_0 = var_0_1:getInstance("nf_main_interface")

		if arg_4_1.result == 0 then
			var_0_4:show(var_0_2:getNowLang("settingcouponsuccess"))

			var_4_0._control.buy_tickets.main.player_res.times.have.text.text = var_4_0._residue_ticket - 1
			var_4_0._residue_ticket = var_4_0._residue_ticket - 1
			var_4_0._initial_ticket = var_4_0._initial_ticket + 1

			local var_4_1 = var_0_5:get_use_info_data()

			var_4_0._control.main.right_menu.tickets.have_ticket.text.text = var_4_0._initial_ticket
			var_4_0._content[1].number_1.text.text = var_0_8.get_simplify_num(var_4_1.oil)
			var_4_0._content[2].number_1.text.text = var_0_8.get_simplify_num(var_4_1.bullet)
			var_4_0._content[3].number_1.text.text = var_0_8.get_simplify_num(var_4_1.fe)
			var_4_0._content[4].number_1.text.text = var_0_8.get_simplify_num(var_4_1.al)

			if var_4_0._residue_ticket == 0 then
				var_4_0:all_close()
				var_4_0:all_Openbtn2()
			else
				var_4_0:all_closebtn2()
			end

			var_4_0._control.main.right_menu.tickets.have_ticket.text.text = self._mist_info_data.ticket
		else
			var_0_4:show(var_0_3:get_err_msg(arg_4_1.result))
		end
	end

	function arg_1_0.EnterMistBigMapResp(arg_5_0, arg_5_1)
		if arg_5_1.result == 0 then
			local var_5_0 = var_0_1:getInstance("nf_main_interface")

			if var_5_0 then
				var_5_0:__resq_EnterMistBigMapResp(arg_5_1)
			end
		else
			var_0_4:show(var_0_3:get_err_msg(arg_5_1.result))
		end
	end

	function arg_1_0:EnterMistMapResp(arg_6_1)
		if arg_6_1.result == 0 then
			var_0_1:createInstance("nf_map_node")._control.left_bg.cur_count.text.text = self._mist_combat_info.coin

			local var_6_0 = var_0_1:getInstance("nf_map_node")

			if var_6_0 then
				var_6_0:setVisible(false)
			end

			var_0_1:createInstance("nf_map_node"):show({
				id = self._mist_combat_info.id
			})
		else
			var_0_4:show(var_0_3:get_err_msg(arg_6_1.result))
		end
	end

	function arg_1_0.MistRefreshChooseResp(arg_7_0, arg_7_1)
		if arg_7_1.result == 0 then
			local var_7_0 = var_0_1:getInstance("activity_select_ship_and_buff")

			if var_7_0 then
				var_7_0:reset_ship_and_buff_data(arg_7_1.list)
			end
		end
	end

	function arg_1_0.MistTeamSaveResp(arg_8_0, arg_8_1)
		local var_8_0 = var_0_1:getInstance("fight_prepare")

		if var_8_0 then
			var_8_0:refresh_mist_info_list()
		end
	end

	function arg_1_0.MistEnterPointResp(arg_9_0, arg_9_1)
		if arg_9_1.result == 0 then
			-- block empty
		elseif arg_9_1.result == 10 then
			var_0_4:show(var_0_2:getNowLang("hasshipinrepair1"))
		elseif arg_9_1.result ~= 11 then
			var_0_4:show(var_0_3:get_err_msg(arg_9_1.result))
		else
			var_0_4:show(var_0_2:getNowLang("supply_not_enough"))
		end
	end

	function arg_1_0:MistMoveResp(arg_10_1)
		if arg_10_1.result == 0 then
			self:__resp_MistMoveResp(arg_10_1)
		else
			var_0_4:show(var_0_3:get_err_msg(arg_10_1.result))
		end
	end

	function arg_1_0.MistChangeAdjutantResp(arg_11_0, arg_11_1)
		if arg_11_1.result == 0 then
			local var_11_0 = var_0_1:getInstance("adjutant_detail")

			if var_11_0 then
				var_11_0:reset_adjutant_state()
			end

			local var_11_1 = var_0_1:getInstance("nf_main_interface")

			if var_11_1 then
				var_11_1:reset_adjutant_state()
			end
		end
	end

	function arg_1_0.MistBuyAdjutantExpResp(arg_12_0, arg_12_1)
		if arg_12_1.result == 0 then
			local var_12_0 = var_0_1:getInstance("nf_map_node")

			if var_12_0 then
				var_12_0:set_left_panel()
			end
		elseif arg_12_1.result == 14 then
			var_0_4:show(var_0_2:getNowLang("coin_notenough"))
		else
			var_0_4:show(var_0_3:get_err_msg(arg_12_1.result))
		end
	end

	function arg_1_0:MistCompleteMapResp(arg_13_1)
		if arg_13_1.result == 0 then
			if var_0_1:getInstance("nf_map_node") then
				var_0_1:destroyInstance("nf_map_node")
			end

			var_0_1:createInstance("nf_main_interface"):show()
			self:set_mist_pass_id(nil)
		else
			var_0_4:show(var_0_3:get_err_msg(arg_13_1.result))
		end
	end

	function arg_1_0.MistQuitMapResp(arg_14_0, arg_14_1)
		if arg_14_1.result == 0 then
			local var_14_0 = var_0_1:getInstance("nf_map_node")

			if var_14_0 then
				var_14_0:__close_panel()
			end

			var_0_1:createInstance("nf_main_interface"):show()
		else
			var_0_4:show(var_0_3:get_err_msg(arg_14_1.result))
		end
	end

	function arg_1_0.MistQuitBigMapResp(arg_15_0, arg_15_1)
		if arg_15_1.result == 0 then
			local var_15_0 = var_0_1:getInstance("nf_main_interface")

			if var_15_0.now_map_level then
				var_15_0:show(var_15_0.now_map_level)
			end
		else
			var_0_4:show(var_0_3:get_err_msg(arg_15_1.result))
		end
	end

	function arg_1_0.MistUseAdjutantSkillResp(arg_16_0, arg_16_1)
		if arg_16_1.result == 0 then
			var_0_4:show(var_0_2:getNowLang("sixth_skill_use"))

			local var_16_0 = var_0_1:getInstance("nf_map_node")

			if var_16_0 then
				var_16_0:set_skill_info()
			end

			if #arg_16_1.list ~= 0 then
				local var_16_1 = var_0_1:getInstance("activity_select_ship_and_buff") or var_0_1:createInstance("activity_select_ship_and_buff")
				local var_16_2 = var_16_0:autoKillDOTween(var_0_10.Sequence())

				var_16_2:AppendInterval(0.2)
				var_16_2:AppendCallback(function()
					var_16_1._panel.transform:GetComponent("Canvas").sortingOrder = 502
				end)
				var_16_1:show_adjutant_skill_effect(arg_16_1.list)
			end
		else
			var_0_4:show(var_0_3:get_err_msg(arg_16_1.result))
		end
	end

	function arg_1_0.MistGuideResp(arg_18_0, arg_18_1)
		if arg_18_1.result == 0 then
			local var_18_0 = var_0_1:getInstance("nf_main_interface")

			var_18_0.mist_info = var_0_5:get_mist_info()
			var_18_0._control.main.right_menu.tickets.have_ticket.text.text = var_18_0.mist_info.ticket

			var_0_7:play_in_out_animation(var_18_0._control.msgbox.black.uITweenSequence, false, function()
				var_18_0._control.msgbox.gameObject:SetActive(false)
			end)
			var_18_0:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.back))
		else
			var_0_4:show(var_0_3:get_err_msg(arg_18_1.result))
		end
	end

	function arg_1_0.MistResetBigMapResp(arg_20_0, arg_20_1)
		if arg_20_1.result == 0 then
			var_0_4:show(var_0_2:getNowLang("ui_music_reset_tip1"))

			local var_20_0 = var_0_1:createInstance("nf_main_interface")

			var_20_0.mist_info = var_0_5:get_mist_info()
			var_20_0._control.main.right_menu.tickets.have_ticket.text.text = var_20_0.mist_info.ticket

			var_20_0:__set_now_map_data(var_20_0.now_map_level)
		else
			var_0_4:show(var_0_2:getNowLang("not_mist_tickets"))
		end
	end

	function arg_1_0:MistPointCompleteResp(arg_21_1)
		if arg_21_1.result == 0 then
			var_0_1:createInstance("nf_map_node"):show({
				id = self._mist_combat_info.id
			})
		else
			var_0_4:show(var_0_3:get_err_msg(arg_21_1.result))
		end
	end

	function arg_1_0:MistGetAwardResp(arg_22_1)
		if arg_22_1.result == 0 then
			local var_22_0 = {}
			local var_22_1 = var_0_1:createInstance("new_ship_or_equip")

			for iter_22_0 = 1, #arg_22_1.reward do
				if arg_22_1.reward[iter_22_0].type == 1 then
					var_22_1:show(true, {
						count = 1,
						type = 1,
						id = arg_22_1.reward[iter_22_0].id,
						is_new = arg_22_1.reward[iter_22_0].is_new
					}, var_0_7.enter_get_ship_type.combats_shop)
				elseif arg_22_1.reward[iter_22_0].type == 4 then
					local var_22_2 = var_0_5:find_character_by_id(arg_22_1.reward[iter_22_0].id)

					var_22_1:show(true, {
						count = 1,
						type = 4,
						id = arg_22_1.reward[iter_22_0].id,
						is_new = arg_22_1.reward[iter_22_0].is_new
					}, var_0_7.enter_get_ship_type.combats_shop)
				elseif self:__check_award_type(arg_22_1.reward[iter_22_0].id) == "picture" then
					var_0_1:createInstance("reward_tip"):show_by_enter_type(nil, var_0_7.enter_icon_detail_type.picture_panel, nil, arg_22_1.reward[iter_22_0].id)

					break
				elseif self:__check_award_type(arg_22_1.reward[iter_22_0].id) == "icon" then
					var_0_1:createInstance("reward_tip"):show_by_enter_type(var_0_11.find_object_by_cid(arg_22_1.reward[iter_22_0].id).icon, var_0_7.enter_get_ship_type.task_award)
				elseif self:__check_award_type(arg_22_1.reward[iter_22_0].id) == "item" or self:__check_award_type(arg_22_1.reward[iter_22_0].id) == "collection" then
					var_0_9(var_22_0, {
						is_new = false,
						type = 2,
						id = arg_22_1.reward[iter_22_0].id,
						count = arg_22_1.reward[iter_22_0].count
					})
				end
			end

			var_0_1:createInstance("mail_box"):show(var_22_0)
			var_0_1:getInstance("mist_awardbox"):__update_cell()

			local var_22_3 = var_0_1:getInstance("nf_main_interface")

			if var_22_3 then
				var_22_3._control.main.top.shop.point:SetActive((var_22_3:can_get_award()))
			end
		end
	end
end

function var_0_0.extend_obj(arg_23_0)
	arg_23_0._data_id_info = nil
	arg_23_0._sixbigmap_info = {}
	arg_23_0._new_map = nil
	arg_23_0._now_map_num = nil
end

return var_0_0
