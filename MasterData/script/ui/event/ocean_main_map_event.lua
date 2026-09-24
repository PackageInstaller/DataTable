local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_5 = gameenum.common_type
local var_0_15 = DG.Tweening.DOTween

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_main_top_return()
		self.__btn_state = 1

		self:setVisible(false)
		self:__destroy_pool()
		self:__destroy_seq()
		self:__kill_all_tween()
		var_0_2:destroyInstance("ocean_main_map")

		local var_2_0 = var_0_2:createInstance("home")

		if not var_2_0 then
			return
		end

		var_2_0:show()
		var_2_0:into_home_bgm()
	end

	function arg_1_0:__onClick_main_top_btns_replay_btn()
		self:__play_video(var_0_5.video_path.ocean_main_map)
	end

	function arg_1_0.__onClick_main_top_btns_story_btn(arg_4_0)
		var_0_2:createInstance("cinema_story_node"):show(1002, true)
	end

	function arg_1_0:__onClick_main_top_btns_explain_btn()
		self:__tween_ocean_guide_ainimation(true)
	end

	function arg_1_0:__onClick_main_top_btns_show_btn()
		if self.__btn_state == 1 then
			self._control.main.top.btns.show_btn.image.sprite = self:loadSprite(var_0_5.forth_show_button.state2)
			self.__btn_state = 2
		elseif self.__btn_state == 2 then
			self._control.main.top.btns.show_btn.image.sprite = self:loadSprite(var_0_5.forth_show_button.state1)
			self.__btn_state = 1
		end

		self._control.main.middle.map_name1.gameObject:SetActive(self.__btn_state == 1)
		self._control.main.middle.map_score.gameObject:SetActive(self.__btn_state == 2)
	end

	function arg_1_0:__onClick_main_bottom_cia_btn()
		self:setVisible(false)
		var_0_2:createInstance("ocean_cia"):show()
	end

	function arg_1_0:__onClick_ocean_guide_tip_layer_close()
		self:__tween_ocean_guide_ainimation(false)
	end

	function arg_1_0:__onClick_ocean_map_detail_main_right_enter_btn()
		self:__switch_enter_point(1)
	end

	function arg_1_0:__onClick_ocean_map_detail_main_bottom_fight_prepare_btn()
		self:setVisible(false)
		var_0_2:createInstance("fight_prepare"):show({
			ocean_active_config = self._active_config,
			fight_prepare_type = var_0_5.fight_type.ocean_attack,
			go_to_map_id = self._big_normal_map_data[1].id,
			fight_type = var_0_5.fight_type.ocean_attack
		})
	end

	function arg_1_0:__onClick_ocean_map_detail_main_close_btn()
		self:autoKillDOTween(var_0_15.Sequence()):Append(self._control.ocean_map_detail.main.transform:DOScale(0, 0.3):SetEase(DG.Tweening.Ease.InExpo):OnComplete(function()
			self._control.ocean_map_detail.main.transform:DOScale(1, 0)
			self:__hide_all_mini_map_fragment_to_pool()
			self._control.ocean_map_detail:SetActive(false)

			self._control.ocean_map_detail.shadow.canvasGroup.alpha = 0
		end))
		self:__switch_enter_point(1)
	end

	function arg_1_0:__onClick_ocean_map_detail_main_right_reward_item_btn()
		self:__show_ocean_award_detail()
	end

	function arg_1_0:__onClick_ocean_map_detail_main_right_enter_btn_2()
		self:__switch_enter_point(2)
	end

	function arg_1_0:__onClick_main_middle_btns_btn1()
		self._btn_index = 1

		self:__enter_map_func()
	end

	function arg_1_0:__onClick_main_middle_btns_btn2()
		self._btn_index = 2

		self:__enter_map_func()
	end

	function arg_1_0:__onClick_main_middle_btns_btn3()
		self._btn_index = 3

		self:__enter_map_func()
	end

	function arg_1_0:__onClick_main_middle_btns_btn4()
		self._btn_index = 4

		self:__enter_map_func()
	end

	function arg_1_0:__onClick_main_middle_btns_btn5()
		self._btn_index = 5

		self:__enter_map_func()
	end

	function arg_1_0:__onClick_main_middle_btns_btn6()
		self._btn_index = 6

		self:__enter_map_func()
	end

	function arg_1_0:__switch_enter_point(arg_21_1)
		local var_21_0 = self.__now_state == 1 and self._big_normal_map_data[self._btn_index].init_nodes or self._big_hard_map_data[self._btn_index].init_nodes

		table.sort(var_21_0)

		if #var_21_0 < 2 then
			return
		end

		local var_21_2
		local var_21_3

		if arg_21_1 == 1 then
			var_21_2 = var_0_5.init_bg_path.active
			var_21_3 = var_0_5.init_bg_path.unselected

			var_0_3:set_current_ocean_map_start_point(var_21_0[1])
		else
			var_21_2 = var_0_5.init_bg_path.unselected
			var_21_3 = var_0_5.init_bg_path.active

			var_0_3:set_current_ocean_map_start_point(var_21_0[2])
		end

		self._control.ocean_map_detail.main.map_panel.map_node_root:SetActive(arg_21_1 == 1)
		self._control.ocean_map_detail.main.map_panel.map_node_root_1:SetActive(arg_21_1 ~= 1)

		self._control.ocean_map_detail.main.right.enter_btn.image.sprite = self:loadSprite(var_21_2)
		self._control.ocean_map_detail.main.right.enter_btn_2.image.sprite = self:loadSprite(var_21_3)

		self._control.ocean_map_detail.main.map_panel.arrow_icon:SetActive(arg_21_1 == 1)
		self._control.ocean_map_detail.main.map_panel.arrow_icon_1:SetActive(arg_21_1 ~= 1)
	end

	function arg_1_0:__enter_map_func()
		self._control.ocean_map_detail.shadow.canvasGroup.alpha = 1

		self._control.ocean_map_detail:SetActive(true)

		local var_22_0 = self:autoKillDOTween(var_0_15.Sequence())

		var_22_0:Append(self._control.ocean_map_detail.main.transform:DOScale(0, 0))
		var_22_0:Append(self._control.ocean_map_detail.main.transform:DOScale(1, 0.3):SetEase(DG.Tweening.Ease.OutBack))

		if self.__now_state == 1 then
			self:__init_map_detail_content(self._big_normal_map_data, self._btn_index)

			local var_22_3 = {}

			table.sort(self._big_normal_map_data[self._btn_index].init_nodes)

			for iter_22_0, iter_22_1 in ipairs(self._normal_node_data[self._active_config.levels[self._btn_index]]) do
				if iter_22_1.start_node_id == self._big_normal_map_data[self._btn_index].init_nodes[1] then
					var_22_3[#var_22_3 + 1] = iter_22_1
				end
			end

			self:__init_map_detail_node(var_22_3, self._active_config.levels[self._btn_index], 0)

			if #self._big_normal_map_data[self._btn_index].init_nodes > 1 then
				local var_22_4 = {}

				for iter_22_2, iter_22_3 in ipairs(self._normal_node_data[self._active_config.levels[self._btn_index]]) do
					if iter_22_3.start_node_id == self._big_normal_map_data[self._btn_index].init_nodes[2] then
						var_22_4[#var_22_4 + 1] = iter_22_3
					end
				end

				self:__init_map_detail_node(var_22_4, self._active_config.levels[self._btn_index], 1)
			end

			self:__switch_enter_point(1)
			var_0_3:set_current_ocean_map_start_point(self._big_normal_map_data[self._btn_index].init_nodes[1])
		else
			self:__init_map_detail_content(self._big_hard_map_data, self._btn_index)

			local var_22_5 = {}

			table.sort(self._big_hard_map_data[self._btn_index].init_nodes)

			for iter_22_4, iter_22_5 in ipairs(self._hard_node_data[self._active_config.hardLevels[self._btn_index]]) do
				if iter_22_5.start_node_id == self._big_hard_map_data[self._btn_index].init_nodes[1] then
					var_22_5[#var_22_5 + 1] = iter_22_5
				end
			end

			self:__init_map_detail_node(var_22_5, self._active_config.hardLevels[self._btn_index], 0)

			if #self._big_hard_map_data[self._btn_index].init_nodes > 1 then
				local var_22_6 = {}

				for iter_22_6, iter_22_7 in ipairs(self._hard_node_data[self._active_config.hardLevels[self._btn_index]]) do
					if iter_22_7.start_node_id == self._big_hard_map_data[self._btn_index].init_nodes[2] then
						var_22_6[#var_22_6 + 1] = iter_22_7
					end
				end

				self:__init_map_detail_node(var_22_6, self._active_config.hardLevels[self._btn_index], 1)
			end

			self:__switch_enter_point(1)
			var_0_3:set_current_ocean_map_start_point(self._big_hard_map_data[self._btn_index].init_nodes[1])
		end
	end

	function arg_1_0:__onClick_main_bottom_hard_btn()
		self:__switch_map_state()
	end

	function arg_1_0:__onClick_main_bottom_normal_btn()
		self:__switch_map_state()
	end

	function arg_1_0:__switch_map_state()
		self:__init_data()
		self:__init_active()

		local var_25_0

		if self.__now_state == 1 then
			var_25_0 = self._big_hard_map_data
			self.__now_state = 2
		else
			var_25_0 = self._big_normal_map_data
			self.__now_state = 1
		end

		self:__init_position(var_25_0)
		self:__normal_or_hard()
		self:__show_next_map()
		self:__destroy_pool()
		self:__preload_map_fragment()
	end

	function arg_1_0:__onClick_equip_mask()
		self:__show_equip_mask(false)
	end

	function arg_1_0.__onClick_main_top_btns_answer_entrance_btn(arg_27_0)
		local var_27_0 = var_0_2:createInstance("answer_award")

		if var_27_0 then
			var_27_0:show()
		end
	end

	function arg_1_0.__onClick_main_top_btns_integral_task_btn(arg_28_0)
		local var_28_0 = var_0_2:createInstance("score_push")

		if var_28_0 then
			var_28_0:show()
		end
	end

	function arg_1_0.__onClick_main_top_btns_explain_talk_btn(arg_29_0)
		return
	end
end

function var_0_0.extend_obj(arg_30_0)
	return
end

return var_0_0
