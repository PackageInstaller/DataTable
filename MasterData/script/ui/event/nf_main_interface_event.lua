local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.prompt
local var_0_4 = gamecore.Language
local var_0_8 = gamecore.user
local var_0_11 = next
local var_0_12 = UnityEngine.Screen
local var_0_13 = gamecore.util_func
local var_0_16 = gameconfig.pve_mist_chapter_config
local var_0_17 = 0.2

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_main_top_back()
		var_0_8:set_select_into_nf(false)

		if self.cd_time_seq then
			self.cd_time_seq:Kill()

			self.cd_time_seq = nil
		end

		local var_2_0 = {}

		var_2_0.id = 56
		var_2_0.start_time = 0
		var_2_0.end_time = 1

		var_0_8:req_ActivityDurationReq(var_2_0)
		self:setVisible(false)

		local var_2_1 = var_0_1:createInstance("home")

		var_2_1:show()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
		var_2_1:into_home_bgm()
		var_0_1:destroyInstance("nf_main_interface")
	end

	function arg_1_0:__onClick_main_top_shop()
		var_0_1:createInstance("mist_awardbox"):show(self.nf_info)
	end

	function arg_1_0:__onClick_main_top_explain()
		self._page_move = 1

		self:__set_instructions_info(self._page_move)
		self._control.instructions.gameObject:SetActive(true)
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
	end

	function arg_1_0:__onClick_main_top_plot()
		if self._now_movie_id and self._now_movie_id ~= 0 then
			var_0_1:createInstance("cinema_story_node"):show(self._now_movie_id, true)
		end
	end

	function arg_1_0:__onClick_main_right_menu_ready_to_attack()
		local var_6_0 = var_0_8:get_cur_mist_map()
		local var_6_1 = var_0_8:find_mist_prev_bigmap(self.now_map_level)
		local var_6_2 = var_0_8:get_mist_combat_info()
		local var_6_3 = var_0_8:get_mist_bigmap_info()
		local var_6_5 = var_0_8:get_use_info_data()
		local var_6_6 = var_0_13.dict_lenght(var_0_8:get_character_list())

		if self:_time_end() then
			var_0_3:show(var_0_4:getNowLang("errorcode-9993"))

			return
		end

		if var_6_1.state ~= 2 and var_6_2.big_id ~= 0 and var_6_2.big_id ~= self.now_map_level then
			var_0_3:show(var_0_4:getNowLang("other_map_fighting"))

			return
		end

		if var_6_1.state == 2 then
			local var_6_7 = var_0_1:createInstance("msgbox")

			var_6_7:show(var_0_4:getNowLang("mist_reset"), function()
				var_6_7:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
				var_0_8:req_MistResetBigMapReq(self.now_map_level)
			end, function()
				var_6_7:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
			end, var_0_4:getNowLang("reset_chapter"), var_0_2.msg_type.tip, nil)
		elseif var_6_1.members and #var_6_1.members ~= 0 and var_6_2.ship_total and #var_6_2.ship_total ~= 0 and var_6_2.id ~= 0 then
			self:setVisible(false)
			var_0_1:createInstance("nf_map_node"):show({
				id = var_6_2.id
			})
		elseif var_6_1.state == 1 or var_6_1.state == 3 and var_6_1.id == self.now_map_level then
			if #var_6_1.members == 0 or (var_6_1.state == 3 or var_6_1.pass_token and not var_0_11(var_6_1.pass_token)) and var_6_2.big_id and var_6_2.big_id == 0 then
				var_0_8:req_EnterMistBigMapReq(self.now_map_level, var_0_16.find_object_by_id(self.now_map_level).ships)
			else
				self:__resq_EnterMistBigMapResp()
			end
		else
			var_0_3:show("Wrong now_attack.ship_total")
		end
	end

	function arg_1_0:__onClick_main_right_menu_prev()
		if self.turn_the_page == false then
			self.turn_the_page = true
			self.now_map_level = self.now_map_level - 1

			local var_9_0 = var_0_8:find_mist_prev_bigmap(self.now_map_level)

			self:__set_now_main_interface(self.now_map_level)
			self._control.main.right_menu.prev:SetActive(true)
			self._control.main.right_menu.next:SetActive(true)

			if self.now_map_level == self._first_level_id then
				self._control.main.right_menu.prev:SetActive(false)
			end

			self._control.main.single_map_level_cell_1:SetActive(true)
			self._control.main.single_map_level_cell_3:SetActive(true)

			local var_9_3

			if var_0_12.width / var_0_12.height > 1.9 and var_0_12.width / var_0_12.height < 2.1 then
				local var_9_4 = self._control.main.single_map_level_cell_1.transform:DOLocalMoveX(1360, var_0_17):SetRelative(true)
				local var_9_5 = self._control.main.single_map_level_cell_3.transform:DOLocalMoveX(1360, var_0_17):SetRelative(true)

				var_9_3 = self._control.main.single_map_level_cell_2.transform:DOLocalMoveX(1360, var_0_17):SetRelative(true)
			elseif var_0_12.width / var_0_12.height > 2.16 and var_0_12.width / var_0_12.height < 2.17 then
				local var_9_6 = self._control.main.single_map_level_cell_1.transform:DOLocalMoveX(1420, var_0_17):SetRelative(true)
				local var_9_7 = self._control.main.single_map_level_cell_3.transform:DOLocalMoveX(1420, var_0_17):SetRelative(true)

				var_9_3 = self._control.main.single_map_level_cell_2.transform:DOLocalMoveX(1420, var_0_17):SetRelative(true)
			elseif var_0_12.width / var_0_12.height > 2.2 and var_0_12.width / var_0_12.height < 2.3 then
				local var_9_8 = self._control.main.single_map_level_cell_1.transform:DOLocalMoveX(1460, var_0_17):SetRelative(true)
				local var_9_9 = self._control.main.single_map_level_cell_3.transform:DOLocalMoveX(1460, var_0_17):SetRelative(true)

				var_9_3 = self._control.main.single_map_level_cell_2.transform:DOLocalMoveX(1460, var_0_17):SetRelative(true)
			elseif var_0_12.width / var_0_12.height > 2.14 and var_0_12.width / var_0_12.height < 2.15 then
				local var_9_10 = self._control.main.single_map_level_cell_1.transform:DOLocalMoveX(1459, var_0_17):SetRelative(true)
				local var_9_11 = self._control.main.single_map_level_cell_3.transform:DOLocalMoveX(1459, var_0_17):SetRelative(true)

				var_9_3 = self._control.main.single_map_level_cell_2.transform:DOLocalMoveX(1459, var_0_17):SetRelative(true)
			else
				local var_9_12 = self._control.main.single_map_level_cell_1.transform:DOLocalMoveX(1280, var_0_17):SetRelative(true)
				local var_9_13 = self._control.main.single_map_level_cell_3.transform:DOLocalMoveX(1280, var_0_17):SetRelative(true)

				var_9_3 = self._control.main.single_map_level_cell_2.transform:DOLocalMoveX(1280, var_0_17):SetRelative(true)
			end

			self._control.main.right_menu.return_btn:SetActive(false)
			var_9_3:OnComplete(function()
				self:__set_now_time_data(self.now_map_level)
				self:__set_now_map_data(self.now_map_level)

				self.turn_the_page = false

				self:_now_big_info(var_9_0)
			end)
		end
	end

	function arg_1_0:__onClick_main_right_menu_next()
		if not self._can_move then
			var_0_3:show(var_0_4:getNowLang("six_next_no"))
		elseif self.turn_the_page == false then
			self.turn_the_page = true
			self.now_map_level = self.now_map_level + 1

			local var_11_0 = var_0_8:find_mist_now_bigmap(self.now_map_level)

			self:__set_now_main_interface(self.now_map_level)
			self._control.main.right_menu.prev:SetActive(true)
			self._control.main.right_menu.next:SetActive(true)

			if self.now_map_level == self._last_level_id then
				self._control.main.right_menu.next:SetActive(false)
			end

			self._control.main.single_map_level_cell_1:SetActive(true)
			self._control.main.single_map_level_cell_3:SetActive(true)

			local var_11_3

			if var_0_12.width / var_0_12.height > 1.9 and var_0_12.width / var_0_12.height < 2.1 then
				local var_11_4 = self._control.main.single_map_level_cell_1.transform:DOLocalMoveX(-1442, var_0_17):SetRelative(true)
				local var_11_5 = self._control.main.single_map_level_cell_3.transform:DOLocalMoveX(-1442, var_0_17):SetRelative(true)

				var_11_3 = self._control.main.single_map_level_cell_2.transform:DOLocalMoveX(-1442, var_0_17):SetRelative(true)
			elseif var_0_12.width / var_0_12.height > 2.16 and var_0_12.width / var_0_12.height < 2.17 then
				local var_11_6 = self._control.main.single_map_level_cell_1.transform:DOLocalMoveX(-1420, var_0_17):SetRelative(true)
				local var_11_7 = self._control.main.single_map_level_cell_3.transform:DOLocalMoveX(-1420, var_0_17):SetRelative(true)

				var_11_3 = self._control.main.single_map_level_cell_2.transform:DOLocalMoveX(-1420, var_0_17):SetRelative(true)
			elseif var_0_12.width / var_0_12.height > 2.22 and var_0_12.width / var_0_12.height < 2.23 then
				local var_11_8 = self._control.main.single_map_level_cell_1.transform:DOLocalMoveX(-1460, var_0_17):SetRelative(true)
				local var_11_9 = self._control.main.single_map_level_cell_3.transform:DOLocalMoveX(-1460, var_0_17):SetRelative(true)

				var_11_3 = self._control.main.single_map_level_cell_2.transform:DOLocalMoveX(-1460, var_0_17):SetRelative(true)
			elseif var_0_12.width / var_0_12.height > 2.14 and var_0_12.width / var_0_12.height < 2.15 then
				local var_11_10 = self._control.main.single_map_level_cell_1.transform:DOLocalMoveX(-1459, var_0_17):SetRelative(true)
				local var_11_11 = self._control.main.single_map_level_cell_3.transform:DOLocalMoveX(-1459, var_0_17):SetRelative(true)

				var_11_3 = self._control.main.single_map_level_cell_2.transform:DOLocalMoveX(-1459, var_0_17):SetRelative(true)
			else
				local var_11_12 = self._control.main.single_map_level_cell_1.transform:DOLocalMoveX(-1280, var_0_17):SetRelative(true)
				local var_11_13 = self._control.main.single_map_level_cell_3.transform:DOLocalMoveX(-1280, var_0_17):SetRelative(true)

				var_11_3 = self._control.main.single_map_level_cell_2.transform:DOLocalMoveX(-1280, var_0_17):SetRelative(true)
			end

			self._control.main.right_menu.return_btn:SetActive(false)
			var_11_3:OnComplete(function()
				self:__set_now_time_data(self.now_map_level)
				self:__set_now_map_data(self.now_map_level)

				self.turn_the_page = false

				self:_now_big_info(var_11_0)
			end)
		end
	end

	function arg_1_0:__onClick_main_right_menu_tickets_add()
		self._control.buy_tickets.gameObject:SetActive(true)
		var_0_2:play_in_out_animation(self._control.buy_tickets.black.uITweenSequence, true, function()
			self._control.buy_tickets.main.gameObject:SetActive(true)
		end)
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
	end

	function arg_1_0:__onClick_buy_tickets_main_close()
		var_0_2:play_in_out_animation(self._control.buy_tickets.black.uITweenSequence, false, function()
			self._control.buy_tickets.gameObject:SetActive(false)
		end)
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
	end

	function arg_1_0:__onClick_main_right_menu_tickets_tip_time()
		self:time_countdown()
	end

	function arg_1_0.__onClick_main_single_map_level_cell_1_enemy_group_one_btn(arg_18_0)
		return
	end

	function arg_1_0.__onClick_main_single_map_level_cell_1_enemy_group_two_btn(arg_19_0)
		return
	end

	function arg_1_0.__onClick_main_single_map_level_cell_1_enemy_group_three_btn(arg_20_0)
		return
	end

	function arg_1_0.__onClick_main_single_map_level_cell_1_enemy_group_four_btn(arg_21_0)
		return
	end

	function arg_1_0:__onClick_main_single_map_level_cell_2_enemy_group_one_btn()
		var_0_8:set_mist_now_big_map(self.now_map_level)
		self:goto_small_map(1, self.now_map_level)
	end

	function arg_1_0:__onClick_main_single_map_level_cell_2_enemy_group_two_btn()
		var_0_8:set_mist_now_big_map(self.now_map_level)
		self:goto_small_map(2, self.now_map_level)
	end

	function arg_1_0:__onClick_main_single_map_level_cell_2_enemy_group_three_btn()
		var_0_8:set_mist_now_big_map(self.now_map_level)
		self:goto_small_map(3, self.now_map_level)
	end

	function arg_1_0.__onClick_main_single_map_level_cell_2_enemy_group_four_btn(arg_25_0)
		return
	end

	function arg_1_0.__onClick_main_single_map_level_cell_3_enemy_group_one_btn(arg_26_0)
		return
	end

	function arg_1_0.__onClick_main_single_map_level_cell_3_enemy_group_two_btn(arg_27_0)
		return
	end

	function arg_1_0.__onClick_main_single_map_level_cell_3_enemy_group_three_btn(arg_28_0)
		return
	end

	function arg_1_0.__onClick_main_single_map_level_cell_3_enemy_group_four_btn(arg_29_0)
		return
	end

	function arg_1_0.__onClick_main_change_adj(arg_30_0)
		local var_30_0, var_30_1, var_30_2 = var_0_8:get_mist_adjutant()
		local var_30_3 = var_0_1:createInstance("adjutant_detail")

		if var_30_3 then
			var_30_3:show(var_30_2)
		end
	end

	function arg_1_0:__onClick_instructions_prev()
		self:__set_instructions_info(self._page_move - 1)

		self._page_move = self._page_move - 1
	end

	function arg_1_0:__onClick_instructions_next()
		self:__set_instructions_info(self._page_move + 1)

		self._page_move = self._page_move + 1
	end

	function arg_1_0:__onClick_instructions_colse()
		self._initial_ticket = var_0_8:get_mist_info().ticket

		self._control.instructions.gameObject:SetActive(false)
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))

		if var_0_8:get_instructions_mist_guide_state() then
			var_0_2:play_in_out_animation(self._control.msgbox.black.uITweenSequence, true, function()
				self._control.msgbox.gameObject:SetActive(true)
			end)
		end
	end

	function arg_1_0:__onScaleButtonClick_buy_tickets_main_close()
		self:__onClick_buy_tickets_main_close()
	end

	function arg_1_0:__onScaleButtonClick_main_right_menu_tickets_add()
		self:__onClick_main_right_menu_tickets_add()
	end

	function arg_1_0.__onScaleButtonClick_user_info_info_framework_info_bg_close_button(arg_37_0)
		return
	end

	function arg_1_0:__onScaleButtonClick_msgbox_main_one()
		var_0_8:req_MistGuideReq()
		self._control.msgbox:SetActive(false)
	end

	function arg_1_0.__onScaleButtonClick_msgbox_main_close(arg_39_0)
		return
	end

	function arg_1_0.__onClick_nsstructions_colse(arg_40_0)
		return
	end

	function arg_1_0.__onClick_nsstructions_prev(arg_41_0)
		return
	end

	function arg_1_0.__onClick_nsstructions_next(arg_42_0)
		return
	end

	function arg_1_0:__onClick_main_right_menu_return_btn()
		if self._bigmap_info.state == 2 then
			local var_43_0 = var_0_1:getInstance("msgbox")

			var_43_0:show(var_0_4:getNowLang("ui_combat_reset_tip"), function()
				var_43_0:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
				var_0_8:req_MistResetBigMapReq(self.now_map_level)
			end, function()
				var_43_0:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
			end, var_0_4:getNowLang("reset_chapter"), var_0_2.msg_type.tip, nil)
		elseif var_0_11(self._bigmap_info.pass_token) and #self._bigmap_info.pass_token < 3 then
			var_0_3:show(var_0_4:getNowLang("ui_combat_not_reset"))
		end
	end

	function arg_1_0:__onScaleButtonClick_buy_tickets_main_player_res_exchange_1_btn()
		if 15000 > self._user_data.oil then
			var_0_3:show(var_0_4:getNowLang("errorcode_008"))
		else
			var_0_8:req_MistBuyTicketReq(1)
		end
	end

	function arg_1_0.__onClick_buy_tickets_main_player_res_exchange_1_btn2(arg_47_0)
		var_0_3:show(var_0_4:getNowLang("unable_to_change"))
	end

	function arg_1_0:__onScaleButtonClick_buy_tickets_main_player_res_exchange_2_btn()
		if 15000 > self._user_data.bullet then
			var_0_3:show(var_0_4:getNowLang("errorcode_008"))
		else
			var_0_8:req_MistBuyTicketReq(2)
		end
	end

	function arg_1_0.__onClick_buy_tickets_main_player_res_exchange_2_btn2(arg_49_0)
		var_0_3:show(var_0_4:getNowLang("unable_to_change"))
	end

	function arg_1_0:__onScaleButtonClick_buy_tickets_main_player_res_exchange_3_btn()
		if 15000 > self._user_data.fe then
			var_0_3:show(var_0_4:getNowLang("errorcode_008"))
		else
			var_0_8:req_MistBuyTicketReq(3)
		end
	end

	function arg_1_0.__onScaleButtonClick_buy_tickets_main_player_res_exchange_3_btn2(arg_51_0)
		var_0_3:show(var_0_4:getNowLang("unable_to_change"))
	end

	function arg_1_0:__onScaleButtonClick_buy_tickets_main_player_res_exchange_4_btn()
		if 5000 > self._user_data.al then
			var_0_3:show(var_0_4:getNowLang("errorcode_008"))
		else
			var_0_8:req_MistBuyTicketReq(4)
		end
	end

	function arg_1_0.__onScaleButtonClick_buy_tickets_main_player_res_exchange_4_btn2(arg_53_0)
		var_0_3:show(var_0_4:getNowLang("unable_to_change"))
	end

	function arg_1_0:__onClick_nf_awardbox_awardbox_bg_top_close()
		self._control.nf_awardbox:SetActive(false)
	end

	function arg_1_0.__onClick_nf_awardbox_detail_shadow(arg_55_0)
		return
	end

	function arg_1_0.__onClick_nf_awardbox_award_msgbox_main_confirm(arg_56_0)
		return
	end

	function arg_1_0.__onClick_nf_awardbox_award_msgbox_main_close(arg_57_0)
		return
	end
end

function var_0_0.extend_obj(arg_58_0)
	return
end

return var_0_0
