local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gameenum.error_type
local var_0_4 = gamecore.prompt
local var_0_5 = gamecore.user
local var_0_6 = gameconfig.combats_shop_config
local var_0_7 = gameenum.common_type
local var_0_8 = gamecore.util_func
local var_0_9 = table.insert
local var_0_10 = DG.Tweening.DOTween

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.SixthInfoUpdate(arg_2_0, arg_2_1)
		if arg_2_1.result == 0 then
			return
		end
	end

	function arg_1_0.EnterSixthStoryResp(arg_3_0, arg_3_1)
		return
	end

	function arg_1_0.SixthChooseResp(arg_4_0, arg_4_1)
		if arg_4_1.result == 0 then
			local var_4_0 = var_0_5:get_sixth_combat_info()
			local var_4_1 = var_0_1:getInstance("sixth_map_node")

			if var_4_1 then
				var_4_1._control.left_bg.cur_count.text.text = var_4_0.coin
			else
				var_0_1:createInstance("sixth_map_node")._control.left_bg.cur_count.text.text = var_4_0.coin
			end
		else
			var_0_4:show(var_0_3:get_err_msg(arg_4_1.result))
		end
	end

	function arg_1_0.SixthBuyTicketResp(arg_5_0, arg_5_1)
		local var_5_0 = var_0_1:getInstance("six_year_main_interface")

		if arg_5_1.result == 0 then
			var_0_4:show(var_0_2:getNowLang("settingcouponsuccess"))

			var_5_0._control.buy_tickets.main.get_res.times.have.text.text = var_5_0._residue_ticket - 1
			var_5_0._residue_ticket = var_5_0._residue_ticket - 1
			var_5_0._initial_ticket = var_5_0._initial_ticket + 1

			local var_5_1 = var_0_5:get_use_info_data()

			var_5_0._control.main.right_menu.tickets.have_ticket.text.text = var_5_0._initial_ticket
			var_5_0._content[1].number_1.text.text = var_0_8.get_simplify_num(var_5_1.oil)
			var_5_0._content[2].number_1.text.text = var_0_8.get_simplify_num(var_5_1.bullet)
			var_5_0._content[3].number_1.text.text = var_0_8.get_simplify_num(var_5_1.fe)
			var_5_0._content[4].number_1.text.text = var_0_8.get_simplify_num(var_5_1.al)

			if var_5_0._residue_ticket == 0 then
				var_5_0:all_close()
				var_5_0:all_Openbtn2()
			else
				var_5_0:all_closebtn2()
			end
		else
			var_0_4:show(var_0_3:get_err_msg(arg_5_1.result))
		end
	end

	function arg_1_0:EnterSixthMapResp(arg_6_1)
		if arg_6_1.result == 0 then
			var_0_1:createInstance("sixth_map_node")._control.left_bg.cur_count.text.text = self._sixth_combat_info.coin

			local var_6_0 = var_0_1:getInstance("six_year_main_interface")

			if var_6_0 then
				var_6_0:setVisible(false)
			end

			var_0_1:createInstance("sixth_map_node"):show({
				id = self._sixth_combat_info.id
			})
		else
			var_0_4:show(var_0_3:get_err_msg(arg_6_1.result))
		end
	end

	function arg_1_0.SixthRefreshChooseResp(arg_7_0, arg_7_1)
		if arg_7_1.result == 0 then
			local var_7_0 = var_0_1:getInstance("activity_select_ship_and_buff")

			if var_7_0 then
				var_7_0:reset_ship_and_buff_data(arg_7_1.list)
			end
		end
	end

	function arg_1_0.SixthTeamSaveResp(arg_8_0, arg_8_1)
		local var_8_0 = var_0_1:getInstance("fight_prepare")

		if var_8_0 then
			var_8_0:refresh_sixth_info_list()
		end
	end

	function arg_1_0.SixthEnterPointResp(arg_9_0, arg_9_1)
		if arg_9_1.result == 0 then
			local var_9_0 = var_0_1:getInstance("sixth_map_node")

			if var_9_0 then
				var_9_0:__close_panel()
			end

			local var_9_1 = var_0_1:getInstance("fight_prepare")

			if not var_9_1 then
				var_9_1 = var_0_1:createInstance("fight_prepare")

				var_9_1:refresh_sixth_info_list()
			end

			var_9_1:__close_prepare()

			local var_9_2 = {}

			for iter_9_0, iter_9_1 in pairs((var_0_5:get_sixth_prepare_team_detail_data())) do
				if iter_9_1.data then
					table.insert(var_9_2, iter_9_1.data)
				end
			end

			var_0_1:createInstance("campaign_select"):show(arg_9_1, var_0_7.select_prepare_type.sixth_select, var_9_2)

			local var_9_3 = var_0_1:getInstance("sixth_map_node")

			if var_9_3 then
				var_9_3:setVisible(false)
			end
		elseif arg_9_1.result == 10 then
			var_0_4:show(var_0_2:getNowLang("hasshipinrepair1"))
		elseif arg_9_1.result ~= 11 then
			var_0_4:show(var_0_3:get_err_msg(arg_9_1.result))
		else
			var_0_4:show(var_0_2:getNowLang("supply_not_enough"))
		end
	end

	function arg_1_0:SixthMoveResp(arg_10_1)
		if arg_10_1.result == 0 then
			self:__resp_SixthMoveResp(arg_10_1)
		else
			var_0_4:show(var_0_3:get_err_msg(arg_10_1.result))
		end
	end

	function arg_1_0.SixthChangeAdjutantResp(arg_11_0, arg_11_1)
		if arg_11_1.result == 0 then
			local var_11_0 = var_0_1:getInstance("adjutant_detail")

			if var_11_0 then
				var_11_0:reset_adjutant_state()
			end

			local var_11_1 = var_0_1:getInstance("six_year_main_interface")
			local var_11_2 = var_0_1:getInstance("nf_main_interface")

			if var_11_1 then
				var_11_1:reset_adjutant_state()
			end

			if var_11_2 then
				var_11_2:reset_adjutant_state()
			end
		end
	end

	function arg_1_0.SixthBuyAdjutantExpResp(arg_12_0, arg_12_1)
		if arg_12_1.result == 0 then
			local var_12_0 = var_0_1:getInstance("sixth_map_node")

			if var_12_0 then
				var_12_0:set_left_panel()
			end
		elseif arg_12_1.result == 14 then
			var_0_4:show(var_0_2:getNowLang("coin_notenough"))
		else
			var_0_4:show(var_0_3:get_err_msg(arg_12_1.result))
		end
	end

	function arg_1_0:SixthCompleteMapResp(arg_13_1)
		if arg_13_1.result == 0 then
			local var_13_0 = var_0_1:createInstance("six_year_main_interface")
			local var_13_1 = {}
			local var_13_2 = var_0_1:getInstance("sixth_map_node")
			local var_13_3 = var_0_5:get_sixth_combat_info()

			if var_13_2 and self:get_pass_id() then
				var_13_2:_get_other_add_point(self:get_pass_id(), arg_13_1.reward)
			end

			for iter_13_0, iter_13_1 in pairs(arg_13_1.reward) do
				if iter_13_1.type == 4 then
					var_0_9(var_13_1, iter_13_1)
				end
			end

			local var_13_4 = var_0_1:getInstance("msgbox") or var_0_1:createInstance("msgbox")

			var_13_4:showOnes(arg_13_1.reward, function()
				var_13_4:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.back))

				if var_13_2 then
					var_0_1:destroyInstance("sixth_map_node")
				end

				var_13_0:show()

				if #var_13_1 ~= 0 then
					var_0_1:createInstance("new_ship_or_equip"):show(true, var_13_1)
				end

				self:set_pass_id(nil)
			end, nil, var_0_2:getNowLang("logget"), var_0_7.msg_type.rewards)
		else
			var_0_4:show(var_0_3:get_err_msg(arg_13_1.result))
		end
	end

	function arg_1_0.SixthQuitMapResp(arg_15_0, arg_15_1)
		if arg_15_1.result == 0 then
			local var_15_0 = var_0_1:getInstance("sixth_map_node")

			if var_15_0 then
				var_15_0:__close_panel()
			end

			var_0_1:createInstance("six_year_main_interface"):show()
		else
			var_0_4:show(var_0_3:get_err_msg(arg_15_1.result))
		end
	end

	function arg_1_0.SixthQuitBigMapResp(arg_16_0, arg_16_1)
		if arg_16_1.result == 0 then
			local var_16_0 = var_0_1:getInstance("six_year_main_interface")

			if var_16_0.now_map_level then
				var_16_0:show(var_16_0.now_map_level)
			else
				var_16_0:show()
			end
		else
			var_0_4:show(var_0_3:get_err_msg(arg_16_1.result))
		end
	end

	function arg_1_0.SixthUseAdjutantSkillResp(arg_17_0, arg_17_1)
		if arg_17_1.result == 0 then
			var_0_4:show(var_0_2:getNowLang("sixth_skill_use"))

			local var_17_0 = var_0_1:getInstance("sixth_map_node")

			if var_17_0 then
				var_17_0:set_skill_info()
			end

			if #arg_17_1.list ~= 0 then
				local var_17_1 = var_0_1:getInstance("activity_select_ship_and_buff") or var_0_1:createInstance("activity_select_ship_and_buff")
				local var_17_2 = var_17_0:autoKillDOTween(var_0_10.Sequence())

				var_17_2:AppendInterval(0.2)
				var_17_2:AppendCallback(function()
					var_17_1._panel.transform:GetComponent("Canvas").sortingOrder = var_17_0 and var_17_0._panel.transform:GetComponent("Canvas").sortingOrder + 1 or 505
				end)
				var_17_1:show_adjutant_skill_effect(arg_17_1.list)
			end
		end
	end

	function arg_1_0:SixthShopBuyResp(arg_19_1)
		if arg_19_1.result == 0 then
			local var_19_0 = var_0_1:getInstance("combat_shop")

			var_19_0._control.maintop.topmenu.combat.combat_num.text.text = var_0_5:_get_six_info().token
			self._data_id_info = var_0_6.find_object_by_id(arg_19_1.id)

			if self._data_id_info.type == 1 then
				var_0_1:createInstance("new_ship_or_equip"):show(true, {
					count = 1,
					type = 1,
					id = self._data_id_info.award_cid,
					is_new = arg_19_1.reward[1].is_new
				}, var_0_7.enter_get_ship_type.combats_shop)
			elseif self._data_id_info.type == 2 then
				var_0_1:createInstance("new_ship_or_equip"):show(true, {
					count = 1,
					type = 4,
					id = arg_19_1.reward[1].id,
					is_new = arg_19_1.reward[1].is_new
				}, var_0_7.enter_get_ship_type.combats_shop)
			elseif self._data_id_info.type == 3 then
				var_0_1:createInstance("reward_tip"):show(self._data_id_info.award_cid, var_0_7.enter_get_ship_type.combats_shop_clothes)
			elseif self._data_id_info.type == 9 then
				var_0_1:createInstance("reward_tip"):show_by_enter_type(nil, var_0_7.enter_icon_detail_type.picture_panel, nil, self._data_id_info.award_cid)
			else
				var_0_4:show(var_0_2:getNowLang("shopbuysuccess"))
			end

			var_19_0:_update_data()
			var_19_0:__update_cell()
		else
			var_0_1:createInstance("combat_shop"):_update_data()
			var_0_4:show(var_0_3:get_err_msg(arg_19_1.result))
		end
	end

	function arg_1_0:MultiSixthShopBuyResp(arg_20_1)
		if arg_20_1.result == 0 then
			local var_20_0 = var_0_1:getInstance("combat_shop")

			var_20_0._control.maintop.topmenu.combat.combat_num.text.text = var_0_5:_get_six_info().token
			self._data_id_info = var_0_6.find_object_by_id(arg_20_1.id)

			if self._data_id_info.type == 1 then
				var_0_1:createInstance("new_ship_or_equip"):show(true, {
					count = 1,
					type = 1,
					id = self._data_id_info.award_cid,
					is_new = arg_20_1.reward[1].is_new
				}, var_0_7.enter_get_ship_type.combats_shop)
			elseif self._data_id_info.type == 2 then
				var_0_1:createInstance("new_ship_or_equip"):show(true, {
					count = 1,
					type = 4,
					id = arg_20_1.reward[1].id,
					is_new = arg_20_1.reward[1].is_new
				}, var_0_7.enter_get_ship_type.combats_shop)
			elseif self._data_id_info.type == 3 then
				var_0_1:createInstance("reward_tip"):show(self._data_id_info.award_cid, var_0_7.enter_get_ship_type.combats_shop_clothes)
			elseif self._data_id_info.type == 9 then
				var_0_1:createInstance("reward_tip"):show_by_enter_type(nil, var_0_7.enter_icon_detail_type.picture_panel, nil, self._data_id_info.award_cid)
			else
				var_0_4:show(var_0_2:getNowLang("shopbuysuccess"))
			end

			var_20_0:_update_data()
			var_20_0:__update_cell()
		else
			var_0_1:createInstance("combat_shop"):_update_data()
			var_0_4:show(var_0_3:get_err_msg(arg_20_1.result))
		end
	end

	function arg_1_0:SixthInfoUpdate(arg_21_1)
		self:_six_info(arg_21_1.sixth_info)

		var_0_1:getInstance("combat_shop").sixth_info = arg_21_1.sixth_info
	end

	function arg_1_0.SixthGuideResp(arg_22_0, arg_22_1)
		if arg_22_1.result == 0 then
			local var_22_0 = var_0_1:getInstance("six_year_main_interface")

			var_22_0.six_info = var_0_5:_get_six_info()
			var_22_0._control.main.right_menu.tickets.have_ticket.text.text = var_22_0.six_info.ticket

			var_0_7:play_in_out_animation(var_22_0._control.msgbox.black.uITweenSequence, false, function()
				var_22_0._control.msgbox.gameObject:SetActive(false)
			end)
			var_22_0:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.back))
		else
			var_0_4:show(var_0_3:get_err_msg(arg_22_1.result))
		end
	end

	function arg_1_0.SixthResetBigMapResp(arg_24_0, arg_24_1)
		if arg_24_1.result == 0 then
			var_0_4:show(var_0_2:getNowLang("ui_music_reset_tip1"))

			local var_24_0 = var_0_1:createInstance("six_year_main_interface")

			var_24_0._control.main.right_menu.tickets.have_ticket.text.text = var_24_0.six_info.ticket

			var_24_0:__set_now_map_data(var_24_0.now_map_level)
		else
			var_0_4:show(var_0_2:getNowLang("errorcode_338"))
		end
	end

	function arg_1_0.SixthDecisiveBattleBuffResp(arg_25_0, arg_25_1)
		if arg_25_1.result == 0 then
			local var_25_0 = var_0_1:getInstance("sixth_map_node")

			if var_25_0 then
				var_25_0:set_buff_two_info()
				var_25_0:set_back_info()
			end
		else
			var_0_4:show(var_0_3:get_err_msg(arg_25_1.result))
		end
	end
end

function var_0_0.extend_obj(arg_26_0)
	arg_26_0._data_id_info = nil
	arg_26_0._sixbigmap_info = {}
	arg_26_0._new_map = nil
	arg_26_0._now_map_num = nil
end

return var_0_0
