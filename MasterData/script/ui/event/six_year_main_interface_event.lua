local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.prompt
local var_0_4 = gamecore.Language
local var_0_8 = gamecore.user
local var_0_10 = gameconfig.ship_config
local var_0_12 = gameconfig.sixth_combat_chapter_config
local var_0_13 = next
local var_0_14 = UnityEngine.Screen
local var_0_15 = gamecore.util_func
local var_0_16 = 0.2

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_main_top_back()
		var_0_8:set_to_six_year(false)

		if self.cd_time_seq then
			self.cd_time_seq:Kill()

			self.cd_time_seq = nil
		end

		self:setVisible(false)
		var_0_1:destroyInstance("six_year_main_interface")

		local var_2_0 = var_0_1:createInstance("home")

		var_2_0:show()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
		var_2_0:into_home_bgm()

		if var_0_1:getInstance("select_member") then
			var_0_1:destroyInstance("select_member")
		end

		if var_0_1:getInstance("activity_select_ship_and_buff") then
			var_0_1:destroyInstance("activity_select_ship_and_buff")
		end

		if var_0_1:getInstance("gotofight") then
			var_0_1:destroyInstance("gotofight")
		end

		if var_0_1:getInstance("adjutant_detail") then
			var_0_1:destroyInstance("adjutant_detail")
		end

		var_0_1:destroyInstance("six_year_main_interface")
	end

	function arg_1_0:__onClick_main_top_shop()
		self:setVisible(false)
		var_0_1:createInstance("combat_shop"):show(var_0_2.combat_shop_enter_type.activity)
	end

	function arg_1_0:__onClick_main_top_explain()
		self._page_move = 1

		self:__set_instructions_info(self._page_move)
		self._control.instructions.gameObject:SetActive(true)
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
	end

	function arg_1_0:__onClick_main_top_plot()
		local var_5_0 = var_0_1:getInstance("ship_available")
		local var_5_1 = var_0_12.find_object_by_id(self.now_map_level)

		if var_5_1 and var_5_1.award_ship then
			if var_5_0 then
				var_5_0:show(var_0_2.go_to_ship_available.sixth_go, var_5_1.award_ship)
			else
				var_0_1:createInstance("ship_available"):show(var_0_2.go_to_ship_available.sixth_go, var_5_1.award_ship)
			end
		end
	end

	function arg_1_0:__onClick_main_right_menu_ready_to_attack()
		local var_6_0 = var_0_8:get_cur_sixth_map()
		local var_6_1 = var_0_8:get_clear_map_info()
		local var_6_2 = var_0_8:find_prev_bigmap(self.now_map_level)
		local var_6_3 = var_0_8:get_sixth_combat_info()
		local var_6_4, var_6_5, var_6_6 = self:__get_sixth_member_count()
		local var_6_7 = var_0_8:get_bigmap_info()
		local var_6_8 = var_0_12.find_object_by_id(self.now_map_level)

		if var_6_8 and #var_6_8.shipton_num > 0 then
			if var_6_4 < var_6_8.shipton_num[1] or var_6_5 < var_6_8.shipton_num[2] or var_6_6 < var_6_8.shipton_num[3] then
				var_0_3:show(var_0_4:getNowLang("type_ship_not_enough"))

				return
			end
		end

		if var_0_15.dict_lenght(var_0_8:get_character_list()) >= var_0_8:get_use_info_data().max_ship then
			var_0_1:createInstance("msgbox"):showthird(nil, function()
				var_0_1:destroyInstance("msgbox")

				local var_7_0 = var_0_1:getInstance("dock")

				if var_7_0 then
					var_7_0:setVisible(true)
					var_7_0:__onToggle_top_layer_toggle_control_disassemble()
				else
					local var_7_1 = var_0_1:createInstance("dock")

					var_7_1:show(true, "disassemble")
					var_7_1:set_enter_type("home")
					var_7_1:_now__play_bgm()
					var_7_1:__select_one("disassemble", true)
				end
			end, function()
				var_0_1:destroyInstance("msgbox")

				local var_8_0 = var_0_1:getInstance("remake")

				if var_0_1:getInstance("six_year_main_interface") then
					var_0_1:destroyInstance("six_year_main_interface")
				end

				local var_8_1 = var_0_1:getInstance("home")

				if var_8_1 then
					var_8_1:_bgm_play()
				end

				if var_8_0 then
					var_8_0:setVisible(true)
				else
					local var_8_2 = var_0_1:createInstance("remake")

					var_8_2:set_enter_type("home")
					var_8_2:show(true)
				end
			end, function()
				var_0_1:destroyInstance("msgbox")

				local var_9_0 = var_0_1:getInstance("home")

				if var_9_0 then
					var_9_0:_bgm_play()
				end

				local var_9_1 = var_0_1:getInstance("mall_shop")

				if var_9_1 then
					var_9_1:setVisible(true)
					var_9_1:__onToggle_top_layer_top_btn_btnthree()
				else
					var_0_1:createInstance("mall_shop"):show(var_0_2.mall_layer_type.layer_func, var_0_2.mall_enter_type.enter_home)
				end
			end, "", var_0_2.msg_type.ship_full, nil, true)

			return
		end

		if var_6_3.ship_total ~= 0 and var_6_2.state ~= 2 and var_6_3.big_id ~= 0 and var_6_3.big_id ~= self.now_map_level then
			var_0_3:show(var_0_4:getNowLang("other_map_fighting"))

			return
		end

		if var_6_2.state == 2 then
			local var_6_9 = var_0_1:getInstance("msgbox")

			local function var_6_10()
				if var_6_9 then
					var_6_9:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
					var_0_8:req_SixthResetBigMapReq(self.now_map_level)
				else
					var_6_9 = var_0_1:createInstance("msgbox")

					var_6_9:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
					var_0_8:req_SixthResetBigMapReq(self.now_map_level)
				end
			end

			local function var_6_11()
				if var_6_9 then
					var_6_9:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
				end
			end

			if var_6_9 then
				var_6_9:show(var_0_4:getNowLang("ready_reset"), var_6_10, var_6_11, var_0_4:getNowLang("reset_chapter"), var_0_2.msg_type.tip, nil)
			else
				var_6_9 = var_0_1:createInstance("msgbox")

				var_6_9:show(var_0_4:getNowLang("ready_reset"), var_6_10, var_6_11, var_0_4:getNowLang("reset_chapter"), var_0_2.msg_type.tip, nil)
			end
		elseif var_6_3.id and var_6_3.id ~= 0 and var_6_3.point ~= 0 then
			self:setVisible(false)
			var_0_1:createInstance("sixth_map_node"):show({
				id = var_6_3.id
			})
		elseif var_6_3.big_id and var_6_3.ship_total and #var_6_3.ship_total ~= 0 and var_6_3.big_id == self.now_map_level then
			local var_6_12

			if self._now_index == 1 then
				var_6_12 = 9301 + var_6_2.id % 10000 * 3 - 3
			elseif self._now_index > 1 then
				var_6_12 = 9301 + var_6_2.id % 10000 * 3
			end

			if #var_6_3.pass_map == 0 then
				var_0_8:req_EnterSixthMapReq(var_6_12)
			else
				var_0_8:req_EnterSixthMapReq(var_6_12 + #var_6_3.pass_map)
			end
		elseif #var_6_3.ship_total == 0 and (var_6_2.state == 1 or var_6_2.state == 3) then
			var_0_8:_set_now_big_map(self.now_map_level)

			local var_6_14

			if self._now_index == 1 then
				var_6_14 = 9301 + var_6_2.id % 10000 * 3 - 3
			elseif self._now_index > 1 then
				var_6_14 = 9301 + var_6_2.id % 10000 * 3
			end

			var_0_1:createInstance("select_member"):show_by_type(var_0_2.enter_select_member_type.six_year_primary, nil, nil, var_6_14)
		else
			var_0_3:show("Wrong now_attack.ship_total")
		end
	end

	function arg_1_0.__get_sixth_member_count(arg_12_0)
		local var_12_0 = 0
		local var_12_1 = 0
		local var_12_2 = 0

		for iter_12_0, iter_12_1 in pairs((var_0_8:get_character_list())) do
			local var_12_3 = var_0_10.find_object_by_cid(iter_12_1.cid)

			if var_12_3.ship_ton == 1 then
				var_12_0 = var_12_0 + 1
			elseif var_12_3.ship_ton == 2 then
				var_12_1 = var_12_1 + 1
			elseif var_12_3.ship_ton == 3 then
				var_12_2 = var_12_2 + 1
			end
		end

		return var_12_0, var_12_1, var_12_2
	end

	function arg_1_0:__onClick_main_right_menu_prev()
		if self.turn_the_page == false then
			self.turn_the_page = true
			self.now_map_level = self.now_map_level - 1

			local var_13_0 = var_0_8:find_prev_bigmap(self.now_map_level)

			self:__set_now_main_interface(self.now_map_level)
			self._control.main.right_menu.prev:SetActive(true)
			self._control.main.right_menu.next:SetActive(true)

			if self.now_map_level == self._first_level_id then
				self._control.main.right_menu.prev:SetActive(false)
			end

			self._control.main.single_map_level_cell_1:SetActive(true)
			self._control.main.single_map_level_cell_3:SetActive(true)

			local var_13_3

			if var_0_14.width / var_0_14.height > 1.9 and var_0_14.width / var_0_14.height < 2.1 then
				local var_13_4 = self._control.main.single_map_level_cell_1.transform:DOLocalMoveX(1360, var_0_16):SetRelative(true)
				local var_13_5 = self._control.main.single_map_level_cell_3.transform:DOLocalMoveX(1360, var_0_16):SetRelative(true)

				var_13_3 = self._control.main.single_map_level_cell_2.transform:DOLocalMoveX(1360, var_0_16):SetRelative(true)
			elseif var_0_14.width / var_0_14.height > 2.16 and var_0_14.width / var_0_14.height < 2.17 then
				local var_13_6 = self._control.main.single_map_level_cell_1.transform:DOLocalMoveX(1420, var_0_16):SetRelative(true)
				local var_13_7 = self._control.main.single_map_level_cell_3.transform:DOLocalMoveX(1420, var_0_16):SetRelative(true)

				var_13_3 = self._control.main.single_map_level_cell_2.transform:DOLocalMoveX(1420, var_0_16):SetRelative(true)
			elseif var_0_14.width / var_0_14.height > 2.2 and var_0_14.width / var_0_14.height < 2.3 then
				local var_13_8 = self._control.main.single_map_level_cell_1.transform:DOLocalMoveX(1460, var_0_16):SetRelative(true)
				local var_13_9 = self._control.main.single_map_level_cell_3.transform:DOLocalMoveX(1460, var_0_16):SetRelative(true)

				var_13_3 = self._control.main.single_map_level_cell_2.transform:DOLocalMoveX(1460, var_0_16):SetRelative(true)
			elseif var_0_14.width / var_0_14.height > 2.14 and var_0_14.width / var_0_14.height < 2.15 then
				local var_13_10 = self._control.main.single_map_level_cell_1.transform:DOLocalMoveX(1459, var_0_16):SetRelative(true)
				local var_13_11 = self._control.main.single_map_level_cell_3.transform:DOLocalMoveX(1459, var_0_16):SetRelative(true)

				var_13_3 = self._control.main.single_map_level_cell_2.transform:DOLocalMoveX(1459, var_0_16):SetRelative(true)
			else
				local var_13_12 = self._control.main.single_map_level_cell_1.transform:DOLocalMoveX(1280, var_0_16):SetRelative(true)
				local var_13_13 = self._control.main.single_map_level_cell_3.transform:DOLocalMoveX(1280, var_0_16):SetRelative(true)

				var_13_3 = self._control.main.single_map_level_cell_2.transform:DOLocalMoveX(1280, var_0_16):SetRelative(true)
			end

			self._control.main.right_menu.return_btn:SetActive(false)

			if self._now_attack.big_id and self._now_attack.big_id ~= 0 and self._now_attack.ship_total and #self._now_attack.ship_total ~= 0 and self._now_attack.big_id == self.now_map_level then
				self._control.main.right_menu.ready_to_attack.text.text.text = var_0_4:getNowLang("challegeon")

				self._control.main.right_menu.return_btn:SetActive(true)
			end

			var_13_3:OnComplete(function()
				self:__set_now_time_data(self.now_map_level)
				self:__set_now_map_data(self.now_map_level)

				self.turn_the_page = false

				self:_now_big_info(var_13_0)
			end)
		end
	end

	function arg_1_0:__onClick_main_right_menu_next()
		if not self._can_move then
			var_0_3:show(var_0_4:getNowLang("six_next_no"))
		elseif self.turn_the_page == false then
			self.turn_the_page = true
			self.now_map_level = self.now_map_level + 1

			local var_15_0 = var_0_8:find_now_bigmap(self.now_map_level)

			self:__set_now_main_interface(self.now_map_level)
			self._control.main.right_menu.prev:SetActive(true)
			self._control.main.right_menu.next:SetActive(true)

			if self.now_map_level == self._first_level_id + 5 then
				self._control.main.right_menu.next:SetActive(false)
			end

			self._control.main.single_map_level_cell_1:SetActive(true)
			self._control.main.single_map_level_cell_3:SetActive(true)

			local var_15_3

			if var_0_14.width / var_0_14.height > 1.9 and var_0_14.width / var_0_14.height < 2.1 then
				local var_15_4 = self._control.main.single_map_level_cell_1.transform:DOLocalMoveX(-1442, var_0_16):SetRelative(true)
				local var_15_5 = self._control.main.single_map_level_cell_3.transform:DOLocalMoveX(-1442, var_0_16):SetRelative(true)

				var_15_3 = self._control.main.single_map_level_cell_2.transform:DOLocalMoveX(-1442, var_0_16):SetRelative(true)
			elseif var_0_14.width / var_0_14.height > 2.16 and var_0_14.width / var_0_14.height < 2.17 then
				local var_15_6 = self._control.main.single_map_level_cell_1.transform:DOLocalMoveX(-1420, var_0_16):SetRelative(true)
				local var_15_7 = self._control.main.single_map_level_cell_3.transform:DOLocalMoveX(-1420, var_0_16):SetRelative(true)

				var_15_3 = self._control.main.single_map_level_cell_2.transform:DOLocalMoveX(-1420, var_0_16):SetRelative(true)
			elseif var_0_14.width / var_0_14.height > 2.22 and var_0_14.width / var_0_14.height < 2.23 then
				local var_15_8 = self._control.main.single_map_level_cell_1.transform:DOLocalMoveX(-1460, var_0_16):SetRelative(true)
				local var_15_9 = self._control.main.single_map_level_cell_3.transform:DOLocalMoveX(-1460, var_0_16):SetRelative(true)

				var_15_3 = self._control.main.single_map_level_cell_2.transform:DOLocalMoveX(-1460, var_0_16):SetRelative(true)
			elseif var_0_14.width / var_0_14.height > 2.14 and var_0_14.width / var_0_14.height < 2.15 then
				local var_15_10 = self._control.main.single_map_level_cell_1.transform:DOLocalMoveX(-1459, var_0_16):SetRelative(true)
				local var_15_11 = self._control.main.single_map_level_cell_3.transform:DOLocalMoveX(-1459, var_0_16):SetRelative(true)

				var_15_3 = self._control.main.single_map_level_cell_2.transform:DOLocalMoveX(-1459, var_0_16):SetRelative(true)
			else
				local var_15_12 = self._control.main.single_map_level_cell_1.transform:DOLocalMoveX(-1280, var_0_16):SetRelative(true)
				local var_15_13 = self._control.main.single_map_level_cell_3.transform:DOLocalMoveX(-1280, var_0_16):SetRelative(true)

				var_15_3 = self._control.main.single_map_level_cell_2.transform:DOLocalMoveX(-1280, var_0_16):SetRelative(true)
			end

			self._control.main.right_menu.return_btn:SetActive(false)

			if self._now_attack.big_id and self._now_attack.big_id ~= 0 and self._now_attack.ship_total and #self._now_attack.ship_total ~= 0 and self._now_attack.big_id == self.now_map_level then
				self._control.main.right_menu.ready_to_attack.text.text.text = var_0_4:getNowLang("challegeon")

				self._control.main.right_menu.return_btn:SetActive(true)
			end

			var_15_3:OnComplete(function()
				self:__set_now_time_data(self.now_map_level)
				self:__set_now_map_data(self.now_map_level)

				self.turn_the_page = false

				self:_now_big_info(var_15_0)
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

	function arg_1_0:__onClick_buy_tickets_main_get_res_exchange_1_btn()
		if 15000 > self._user_data.oil then
			var_0_3:show(var_0_4:getNowLang("errorcode_008"))
		else
			var_0_8:req_sixthBuyTicketReq(1)
		end
	end

	function arg_1_0:__onClick_buy_tickets_main_get_res_exchange_2_btn()
		if 15000 > self._user_data.bullet then
			var_0_3:show(var_0_4:getNowLang("errorcode_008"))
		else
			var_0_8:req_sixthBuyTicketReq(2)
		end
	end

	function arg_1_0:__onClick_buy_tickets_main_get_res_exchange_3_btn()
		if 15000 > self._user_data.fe then
			var_0_3:show(var_0_4:getNowLang("errorcode_008"))
		else
			var_0_8:req_sixthBuyTicketReq(3)
		end
	end

	function arg_1_0:__onClick_buy_tickets_main_get_res_exchange_4_btn()
		if 5000 > self._user_data.al then
			var_0_3:show(var_0_4:getNowLang("errorcode_008"))
		else
			var_0_8:req_sixthBuyTicketReq(4)
		end
	end

	function arg_1_0:__onClick_main_right_menu_tickets_tip_time()
		self:time_countdown()
	end

	function arg_1_0.__onClick_main_single_map_level_cell_1_enemy_group_one_btn(arg_26_0)
		return
	end

	function arg_1_0.__onClick_main_single_map_level_cell_1_enemy_group_two_btn(arg_27_0)
		return
	end

	function arg_1_0.__onClick_main_single_map_level_cell_1_enemy_group_three_btn(arg_28_0)
		return
	end

	function arg_1_0.__onClick_main_single_map_level_cell_1_enemy_group_four_btn(arg_29_0)
		return
	end

	function arg_1_0:__onClick_main_single_map_level_cell_2_enemy_group_one_btn()
		var_0_8:_set_now_big_map(self.now_map_level)
		self:goto_small_map(1, self.now_map_level)
	end

	function arg_1_0:__onClick_main_single_map_level_cell_2_enemy_group_two_btn()
		self:goto_small_map(2, self.now_map_level)
		var_0_8:_set_now_big_map(self.now_map_level)
	end

	function arg_1_0:__onClick_main_single_map_level_cell_2_enemy_group_three_btn()
		self:goto_small_map(3, self.now_map_level)
		var_0_8:_set_now_big_map(self.now_map_level)
	end

	function arg_1_0:__onClick_main_single_map_level_cell_2_enemy_group_four_btn()
		self:__plot_node_enter_event(self.now_map_level)
		var_0_8:_set_now_big_map(self.now_map_level)
	end

	function arg_1_0.__onClick_main_single_map_level_cell_3_enemy_group_one_btn(arg_34_0)
		return
	end

	function arg_1_0.__onClick_main_single_map_level_cell_3_enemy_group_two_btn(arg_35_0)
		return
	end

	function arg_1_0.__onClick_main_single_map_level_cell_3_enemy_group_three_btn(arg_36_0)
		return
	end

	function arg_1_0.__onClick_main_single_map_level_cell_3_enemy_group_four_btn(arg_37_0)
		return
	end

	function arg_1_0.__onClick_main_change_adj(arg_38_0)
		local var_38_0, var_38_1, var_38_2 = var_0_8:get_six_adjutant()
		local var_38_3 = var_0_1:createInstance("adjutant_detail")

		if var_38_3 then
			var_38_3:show(var_38_2)
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
		self.six_info = var_0_8:_get_six_info()
		self._initial_ticket = self.six_info.ticket

		self._control.instructions.gameObject:SetActive(false)
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))

		if var_0_8:get_instructions_guide_state() then
			var_0_2:play_in_out_animation(self._control.msgbox.black.uITweenSequence, true, function()
				self._control.msgbox.gameObject:SetActive(true)
			end)
		end
	end

	function arg_1_0:__onScaleButtonClick_buy_tickets_main_close()
		self:__onClick_buy_tickets_main_close()
	end

	function arg_1_0:__onScaleButtonClick_buy_tickets_main_get_res_exchange_1_btn()
		self:__onClick_buy_tickets_main_get_res_exchange_1_btn()
	end

	function arg_1_0:__onScaleButtonClick_buy_tickets_main_get_res_exchange_2_btn()
		self:__onClick_buy_tickets_main_get_res_exchange_2_btn()
	end

	function arg_1_0:__onScaleButtonClick_buy_tickets_main_get_res_exchange_3_btn()
		self:__onClick_buy_tickets_main_get_res_exchange_3_btn()
	end

	function arg_1_0:__onScaleButtonClick_buy_tickets_main_get_res_exchange_4_btn()
		self:__onClick_buy_tickets_main_get_res_exchange_4_btn()
	end

	function arg_1_0.__onClick_buy_tickets_main_get_res_exchange_1_btn2(arg_48_0)
		var_0_3:show(var_0_4:getNowLang("unable_to_change"))
	end

	function arg_1_0.__onClick_buy_tickets_main_get_res_exchange_2_btn2(arg_49_0)
		var_0_3:show(var_0_4:getNowLang("unable_to_change"))
	end

	function arg_1_0.__onScaleButtonClick_buy_tickets_main_get_res_exchange_3_btn2(arg_50_0)
		var_0_3:show(var_0_4:getNowLang("unable_to_change"))
	end

	function arg_1_0.__onScaleButtonClick_buy_tickets_main_get_res_exchange_4_btn2(arg_51_0)
		var_0_3:show(var_0_4:getNowLang("unable_to_change"))
	end

	function arg_1_0:__onScaleButtonClick_main_right_menu_tickets_add()
		self:__onClick_main_right_menu_tickets_add()
	end

	function arg_1_0.__onScaleButtonClick_user_info_info_framework_info_bg_close_button(arg_53_0)
		return
	end

	function arg_1_0.__onScaleButtonClick_msgbox_main_one(arg_54_0)
		var_0_8:req_SixthCompleteGuideReq()
	end

	function arg_1_0.__onScaleButtonClick_msgbox_main_close(arg_55_0)
		return
	end

	function arg_1_0.__onClick_nsstructions_colse(arg_56_0)
		return
	end

	function arg_1_0.__onClick_nsstructions_prev(arg_57_0)
		return
	end

	function arg_1_0.__onClick_nsstructions_next(arg_58_0)
		return
	end

	function arg_1_0:__onClick_main_right_menu_return_btn()
		if not var_0_13(self._now_map_info.pass_token) then
			local var_59_0 = var_0_1:getInstance("msgbox") or var_0_1:createInstance("msgbox")

			local function var_59_1()
				if var_59_0 then
					var_59_0:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
				end

				var_0_8:req_SixthQuitBigMapReq()
			end

			local function var_59_2()
				if var_59_0 then
					var_59_0:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
				end
			end

			if var_59_0 then
				var_59_0:show(var_0_4:getNowLang("ui_combat_reset_tip"), var_59_1, var_59_2, var_0_4:getNowLang("reset_chapter"), var_0_2.msg_type.tip, nil)
			else
				var_59_0 = var_0_1:createInstance("msgbox")

				var_59_0:show(var_0_4:getNowLang("ui_combat_reset_tip"), var_59_1, var_59_2, var_0_4:getNowLang("reset_chapter"), var_0_2.msg_type.tip, nil)
			end
		elseif var_0_13(self._now_map_info.pass_token) and #self._now_map_info.pass_token > 0 then
			var_0_3:show(var_0_4:getNowLang("ui_combat_not_reset"))
		end
	end
end

function var_0_0.extend_obj(arg_62_0)
	return
end

return var_0_0
