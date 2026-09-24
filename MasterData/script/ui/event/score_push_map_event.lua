local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type
local var_0_5 = DG.Tweening.DOTween
local var_0_6 = lx.UserData
local var_0_9 = gameconfig.ship_rule_config
local var_0_10 = string.sub
local var_0_11 = gamecore.prompt

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onClick_bg_middle_menu_remake_content_left(arg_2_0)
		return
	end

	function arg_1_0.__onClick_bg_middle_menu_remake_content_left_ship_bg_btn(arg_3_0)
		return
	end

	function arg_1_0:__onClick_main_top_return()
		var_0_3:set_to_score(false)

		self.__btn_state = 1

		self:setVisible(false)
		self:__destroy_pool()
		self:__destroy_seq()
		self:__onReset()
		self:__kill_all_tween()
		var_0_2:destroyInstance("score_push_map")

		if var_0_2:getInstance("answer_award") then
			var_0_2:destroyInstance("answer_award")
		end

		local var_4_0 = var_0_2:createInstance("home")

		if not var_4_0 then
			return
		end

		var_4_0:show()
		var_4_0:into_home_bgm()
	end

	function arg_1_0:__onClick_main_top_btns_replay_btn()
		self:__play_video(var_0_4.video_path.ocean_main_map)
	end

	function arg_1_0.__onClick_main_top_btns_story_btn(arg_6_0)
		var_0_2:createInstance("cinema_story_node"):show(1002, true)
	end

	function arg_1_0.__onClick_main_top_btns_explain_btn(arg_7_0)
		return
	end

	function arg_1_0:__onClick_main_top_btns_show_btn()
		if self.__btn_state == 1 then
			self._control.main.top.btns.show_btn.image.sprite = self:loadSprite(var_0_4.forth_show_button.state2)
			self.__btn_state = 2
		elseif self.__btn_state == 2 then
			self._control.main.top.btns.show_btn.image.sprite = self:loadSprite(var_0_4.forth_show_button.state1)
			self.__btn_state = 1
		end

		self._control.main.middle.map_name1.gameObject:SetActive(self.__btn_state == 1)
		self._control.main.middle.map_score.gameObject:SetActive(self.__btn_state == 2)
	end

	function arg_1_0:__onClick_main_top_btns_answer_entrance_btn()
		local var_9_0 = var_0_9.find_object_by_id(var_0_4.gotofight_active.score_activity).content

		if #var_0_3:get_score_question_team() <= 0 and var_9_0.startTime and var_9_0.endTime and lx.ServerTime:getUtcTime() > var_9_0.endTime then
			var_0_11:show(var_0_1:getNowLang("ui_notopen"))

			return
		end

		self:setVisible(false)

		local var_9_1 = var_0_2:createInstance("score_push")

		if var_9_1 then
			var_9_1:show()
		end
	end

	function arg_1_0:__onClick_main_top_btns_integral_task_btn()
		self:setVisible(false)

		local var_10_0 = var_0_2:createInstance("answer_award")

		if var_10_0 then
			var_10_0:show()
		end
	end

	function arg_1_0:__onClick_main_top_btns_explain_talk_btn()
		self:__tween_score_guide_ainimation_2(true)
	end

	function arg_1_0:__onClick_main_bottom_hard_btn()
		self:__switch_map_state()
	end

	function arg_1_0:__onClick_main_bottom_normal_btn()
		self:__switch_map_state()
	end

	function arg_1_0:__switch_map_state()
		self:__destroy_pool()
		var_0_2:destroyInstance("ocean_map_line_obj")
		self:__init_data()
		self:__init_active()

		local var_14_0

		if self.__now_state == 1 then
			var_14_0 = self._big_hard_map_data
			self.__now_state = 2
		else
			var_14_0 = self._big_normal_map_data
			self.__now_state = 1
		end

		self:__init_position(var_14_0)
		self:__normal_or_hard()
		self:__show_next_map()
		self:__preload_map_fragment()
	end

	function arg_1_0:__onClick_main_bottom_cia_btn()
		local var_15_0 = var_0_9.find_object_by_id(var_0_4.gotofight_active.score_activity).content

		if var_15_0.startTime and var_15_0.endTime and lx.ServerTime:getUtcTime() > var_15_0.endTime then
			var_0_11:show(var_0_1:getNowLang("ui_notopen"))

			return
		end

		self:setVisible(false)
		var_0_2:createInstance("score_cia"):show()
	end

	function arg_1_0:string_to_utc_time(arg_16_1)
		if not arg_16_1 then
			return 0
		end

		return os.time(self:string_to_tm(arg_16_1))
	end

	function arg_1_0.string_to_tm(arg_17_0, arg_17_1)
		local var_17_0, var_17_1, var_17_2 = var_0_10(arg_17_1, 9, 10)

		return (os.date("*t", os.time({
			year = tonumber((var_0_10(arg_17_1, 1, 4))),
			month = tonumber((var_0_10(arg_17_1, 5, 6))),
			day = tonumber((var_0_10(arg_17_1, 7, 8))),
			hour = tonumber(var_17_0),
			min = tonumber(var_17_1),
			sec = tonumber(var_17_2)
		})))
	end

	function arg_1_0:__onClick_score_guide_tip_layer_close()
		self:__tween_score_guide_ainimation_2(false)
	end

	function arg_1_0:__onClick_score_map_detail_main_right_point_bg_point_icon()
		self:__switch_enter_point(1)
	end

	function arg_1_0:__switch_enter_point(arg_20_1)
		local var_20_0 = self.__now_state == 1 and self._big_normal_map_data[self._btn_index].init_nodes or self._big_hard_map_data[self._btn_index].init_nodes

		table.sort(var_20_0)

		if #var_20_0 < 2 then
			self._control.score_map_detail.main.map_panel.map_node_root:SetActive(true)

			return
		end

		local var_20_2
		local var_20_3

		if arg_20_1 == 1 then
			var_20_2 = var_0_4.score_bg_path.active
			var_20_3 = var_0_4.score_bg_path.unselected

			var_0_3:set_current_score_map_start_point(var_20_0[1])
		else
			var_20_2 = var_0_4.score_bg_path.unselected
			var_20_3 = var_0_4.score_bg_path.active

			if var_20_0[2] then
				var_0_3:set_current_score_map_start_point(var_20_0[2])
			end
		end

		self._control.score_map_detail.main.map_panel.map_node_root:SetActive(arg_20_1 == 1)
		self._control.score_map_detail.main.map_panel.map_node_root_1:SetActive(arg_20_1 ~= 1)

		self._control.score_map_detail.main.right.point_bg.point_icon.image.sprite = self:loadSprite(var_20_2)
		self._control.score_map_detail.main.right.point_bg.point_bg_2.image.sprite = self:loadSprite(var_20_3)
	end

	function arg_1_0:__onClick_score_map_detail_main_bottom_fight_prepare_btn()
		self:setVisible(false)
		var_0_3:reset_score_push_info_pass()
		var_0_2:createInstance("fight_prepare"):show({
			score_active_config = self._active_config,
			fight_prepare_type = var_0_4.fight_type.score_attack,
			go_to_map_id = self.map_fight_prepare_id,
			fight_type = var_0_4.fight_type.score_attack
		})
		var_0_6:setKeyData(self.map_fight_prepare_id, tostring((var_0_3:get_current_score_map_start_point())))
	end

	function arg_1_0:__onClick_score_map_detail_main_close_btn()
		self._control.main.middle.btns:SetActive(false)
		self:autoKillDOTween(var_0_5.Sequence()):Append(self._control.score_map_detail.main.transform:DOScale(0, 0.3):SetEase(DG.Tweening.Ease.InExpo):OnComplete(function()
			self._control.score_map_detail.main.transform:DOScale(1, 0)
			self:__hide_all_mini_map_fragment_to_pool()
			self._control.score_map_detail:SetActive(false)
			self:__destroy_seq("detail_close")
			self:__destroy_pool()
			self:__show_next_map()

			self._control.score_map_detail.shadow.canvasGroup.alpha = 0

			local var_23_0 = self:autoKillDOTween(var_0_5.Sequence())

			var_23_0:AppendInterval(0.1)
			var_23_0:AppendCallback(function()
				self._control.main.middle.btns:SetActive(true)
			end)
		end))
		self:__show_next_map()
	end

	function arg_1_0:__onClick_equip_mask()
		self:__show_equip_mask(false)
	end

	function arg_1_0:__enter_map_func()
		self._control.score_map_detail.shadow.canvasGroup.alpha = 1

		self._control.score_map_detail:SetActive(true)

		local var_26_0 = self:autoKillDOTween(var_0_5.Sequence())

		var_26_0:Append(self._control.score_map_detail.main.transform:DOScale(0, 0))
		var_26_0:Append(self._control.score_map_detail.main.transform:DOScale(1, 0.3):SetEase(DG.Tweening.Ease.OutBack))

		if self.__now_state == 1 then
			local var_26_3 = {}

			self.map_fight_prepare_id = self._active_config.levels[self._btn_index]

			table.sort(self._big_normal_map_data[self._btn_index].init_nodes)

			for iter_26_0, iter_26_1 in ipairs(self._normal_node_data[self._active_config.levels[self._btn_index]]) do
				if iter_26_1.start_node_id == self._big_normal_map_data[self._btn_index].init_nodes[1] then
					var_26_3[#var_26_3 + 1] = iter_26_1
				end
			end

			self:__init_map_detail_node(var_26_3, self._active_config.levels[self._btn_index], 0)

			if #self._big_normal_map_data[self._btn_index].init_nodes > 1 then
				local var_26_4 = {}

				for iter_26_2, iter_26_3 in ipairs(self._normal_node_data[self._active_config.levels[self._btn_index]]) do
					if iter_26_3.start_node_id == self._big_normal_map_data[self._btn_index].init_nodes[2] then
						var_26_4[#var_26_4 + 1] = iter_26_3
					end
				end

				self:__init_map_detail_node(var_26_4, self._active_config.levels[self._btn_index], 1)
			end

			self:__switch_enter_point(1)
			self:__init_map_detail_content(self._big_normal_map_data, self._btn_index)

			if self._is_unlocked_1 == false and self._is_unlocked_2 == true then
				if self._big_normal_map_data[self._btn_index].init_nodes[2] then
					var_0_3:set_current_score_map_start_point(self._big_normal_map_data[self._btn_index].init_nodes[2])
				else
					var_0_3:set_current_score_map_start_point(self._big_normal_map_data[self._btn_index].init_nodes[1])
				end
			elseif self._is_unlocked_1 == true and self._is_unlocked_2 == true then
				local var_26_5 = self._big_normal_map_data[self._btn_index].init_nodes[1]
				local var_26_6 = var_0_6:getKeyData(self.map_fight_prepare_id)

				if var_26_6 and var_26_6 ~= "" and var_26_6 ~= "0" then
					var_26_5 = var_26_6
				end

				local var_26_7 = tonumber(var_26_5)

				if var_26_7 and var_26_7 % 100 > 1 then
					self:__switch_enter_point(2)
					var_0_3:set_current_score_map_start_point(var_26_7)
				else
					self:__switch_enter_point(1)

					if tonumber(var_26_5) then
						var_0_3:set_current_score_map_start_point(tonumber(var_26_5))
					end
				end
			else
				var_0_3:set_current_score_map_start_point(self._big_normal_map_data[self._btn_index].init_nodes[1])
			end
		else
			local var_26_8 = {}

			self.map_fight_prepare_id = self._active_config.hardLevels[self._btn_index]

			table.sort(self._big_hard_map_data[self._btn_index].init_nodes)

			for iter_26_4, iter_26_5 in ipairs(self._hard_node_data[self._active_config.hardLevels[self._btn_index]]) do
				if iter_26_5.start_node_id == self._big_hard_map_data[self._btn_index].init_nodes[1] then
					var_26_8[#var_26_8 + 1] = iter_26_5
				end
			end

			if #self._big_hard_map_data[self._btn_index].init_nodes > 1 then
				local var_26_9 = {}

				for iter_26_6, iter_26_7 in ipairs(self._hard_node_data[self._active_config.hardLevels[self._btn_index]]) do
					if iter_26_7.start_node_id == self._big_hard_map_data[self._btn_index].init_nodes[2] then
						var_26_9[#var_26_9 + 1] = iter_26_7
					end
				end

				self:__init_map_detail_node(var_26_9, self._active_config.hardLevels[self._btn_index], 1)
			end

			self:__switch_enter_point(1)
			self:__init_map_detail_content(self._big_hard_map_data, self._btn_index)
			var_0_3:set_current_score_map_start_point(self._big_hard_map_data[self._btn_index].init_nodes[1])
			self:__init_map_detail_node(var_26_8, self._active_config.hardLevels[self._btn_index], 0)

			if self._is_unlocked_1 == false and self._is_unlocked_2 == true then
				if self._big_hard_map_data[self._btn_index].init_nodes[2] then
					var_0_3:set_current_score_map_start_point(self._big_hard_map_data[self._btn_index].init_nodes[2])
				end
			elseif self._is_unlocked_1 == true and self._is_unlocked_2 == true then
				local var_26_10 = self._big_hard_map_data[self._btn_index].init_nodes[1]
				local var_26_11 = var_0_6:getKeyData(self.map_fight_prepare_id)

				if var_26_11 and var_26_11 ~= "0" and var_26_11 ~= "" then
					var_26_10 = tonumber(var_26_11)
				end

				local var_26_12 = tonumber(var_26_10)

				if var_26_12 and var_26_12 % 100 > 1 then
					self:__switch_enter_point(2)
					var_0_3:set_current_score_map_start_point(var_26_12)
				elseif tonumber(var_26_10) then
					var_0_3:set_current_score_map_start_point(tonumber(var_26_10))
				end
			else
				var_0_3:set_current_score_map_start_point(self._big_hard_map_data[self._btn_index].init_nodes[1])
			end
		end
	end

	function arg_1_0:__onClick_score_map_detail_main_right_point_bg_point_bg_2()
		self:__switch_enter_point(2)
	end

	function arg_1_0:__onClick_instructions_instructions_close()
		self._control.instructions:SetActive(false)
		var_0_3:req_AnswerRemindReq()
	end

	function arg_1_0:__onClick_instructions_prev()
		self._page_move = self._page_move - 1

		self:__tween_score_guide_ainimation(self._page_move)
	end

	function arg_1_0:__onClick_instructions_next()
		self._page_move = self._page_move + 1

		self:__tween_score_guide_ainimation(self._page_move)
	end

	function arg_1_0:__onClick_main_middle_btns__10201_btn1()
		self._btn_index = 1

		self:__enter_map_func()
		var_0_3:set_now_level_state(self.__now_state)

		if self.map_fight_prepare_id == arg_1_0._have_map_num or self.map_fight_prepare_id == self._active_map_id + self._have_map_num then
			self._control.score_map_detail.main.map_panel.map_node_root:SetActive(true)
			self._control.score_map_detail.main.map_panel.map_node_root:SetActive(true)
			self._control.score_map_detail.main.map_panel.map_node_root_1:SetActive(false)
			self._control.score_map_detail.main.map_panel.map_node_root_1:SetActive(false)
		end

		if self.map_fight_prepare_id == self._active_map_id then
			var_0_3:set_current_score_map_start_point(self.map_fight_prepare_id * 100 + 1)
		end

		if self.map_fight_prepare_id == self._active_map_id + self._have_map_num then
			var_0_3:set_current_score_map_start_point((self._active_map_id + self._have_map_num) * 100 + 1)
		end

		self:show_small_panel()
	end

	function arg_1_0:__onClick_main_middle_btns__10202_btn1()
		self._btn_index = 2

		var_0_3:set_now_level_state(self.__now_state)
		self:__enter_map_func()
		self:show_small_panel()
	end

	function arg_1_0:__onClick_main_middle_btns__10203_btn1()
		self._btn_index = 3

		var_0_3:set_now_level_state(self.__now_state)
		self:__enter_map_func()
		self:show_small_panel()
	end

	function arg_1_0:__onClick_main_middle_btns__10204_btn1()
		self._btn_index = 4

		var_0_3:set_now_level_state(self.__now_state)
		self:__enter_map_func()
		self:show_small_panel()
	end

	function arg_1_0:__onClick_msg_panel_finish_special_mission_task_btn_close()
		self._control.msg_panel.finish_special_mission:SetActive(false)
	end

	function arg_1_0:__onClick_main_middle_btns__10205_btn1()
		self._btn_index = 5

		var_0_3:set_now_level_state(self.__now_state)
		self:__enter_map_func()
		self:show_small_panel()
	end

	function arg_1_0:__onClick_main_middle_btns__10206_btn1()
		self._btn_index = 6

		var_0_3:set_now_level_state(self.__now_state)
		self:__enter_map_func()
		self:show_small_panel()
	end

	function arg_1_0:__onClick_main_top_btns_honor_btn()
		var_0_3:req_AnswerMaxScoreLevelPassReq()
		self:setVisible(false)

		local var_38_0 = var_0_2:getInstance("ninth_honor_list")

		if var_38_0 then
			var_38_0:show(var_0_4.pve_active_type.score_event)
		else
			var_0_2:createInstance("ninth_honor_list"):show(var_0_4.pve_active_type.score_event)
		end
	end

	function arg_1_0:__onClick_score_map_detail_main_drop_available()
		local var_39_0 = var_0_2:getInstance("ship_available")
		local var_39_1 = gameconfig.drop_available_config.find_object_by_pve_id(self.map_fight_prepare_id)

		if var_39_0 then
			var_39_0:show(var_0_4.go_to_ship_available.main_go, var_39_1)
		else
			var_0_2:createInstance("ship_available"):show(var_0_4.go_to_ship_available.main_go, var_39_1)
		end
	end
end

function var_0_0.extend_obj(arg_40_0)
	return
end

return var_0_0
