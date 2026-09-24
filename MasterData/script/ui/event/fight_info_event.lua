local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameconfig.shop_config
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.prompt
local var_0_9 = gamecore.user
local var_0_14 = UnityEngine.Vector2

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg_info_bg_skip_btn()
		if not self._time_execute_task_list then
			return
		end

		local var_2_0 = self._time_execute_task_list[#self._time_execute_task_list]

		if not self._time_execute_task_list[#self._time_execute_task_list] then
			return
		end

		if var_2_0.can_not_skip then
			return
		end

		if var_2_0.skip_func then
			var_2_0.skip_func()

			var_2_0.skip_func = nil
			var_2_0.execute_func = nil
		else
			var_2_0.execute_time = 0.1
		end
	end

	function arg_1_0:__onClick_bg_info_bg_enemy_info_bg_back_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))

		if self:__back_to_home_view() then
			self:back_to_gotofight()
		end

		self._already_init = false

		self._control.bg.info_bg.enemy_info_bg.bvr_btn.spine_effect:SetActive(false)
		var_0_9:req_BVRAttackChangeReq(false)
	end

	function arg_1_0:__onClick_bg_info_bg_enemy_info_bg_fight_btn()
		self:__toggle_enemy_info(false)

		if not var_0_9:get_bvr_state() then
			self._control.bg.info_bg.enemy_info_bg.fight_btn:SetActive(false)
			self._control.bg.info_bg.enemy_info_bg.back_btn:SetActive(false)
			self._control.bg.info_bg.enemy_info_bg.bvr_btn:SetActive(false)
		else
			self._control.bg.info_bg.enemy_info_bg.fight_btn.button.interactable = true
			self._control.bg.info_bg.enemy_info_bg.back_btn.button.interactable = true
			self._control.bg.info_bg.enemy_info_bg.canvasGroup.interactable = true

			self._control.bg.info_bg.enemy_info_bg.bvr_btn:SetActive(true)
		end

		if self:__ship_count_in_team_check() then
			self:__toggle_select_formation(true)
		else
			self:__select_formation(1)
		end
	end

	function arg_1_0:__onClick_bg_info_bg_select_formation_right_widget_select1()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
		self:__select_formation(1)
	end

	function arg_1_0:__onClick_bg_info_bg_select_formation_right_widget_select2()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
		self:__select_formation(2)
	end

	function arg_1_0:__onClick_bg_info_bg_select_formation_right_widget_select3()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
		self:__select_formation(3)
	end

	function arg_1_0:__onClick_bg_info_bg_select_formation_right_widget_select4()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
		self:__select_formation(4)
	end

	function arg_1_0:__onClick_bg_info_bg_select_formation_right_widget_select5()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
		self:__select_formation(5)
	end

	function arg_1_0:__onClick_mask_frame_continue()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
		self:toggle_continue_tip_box(false)
		self:__show_fight_info(self._start_node_id)
	end

	function arg_1_0:__onClick_mask_frame_quit()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))

		if self:__back_to_home_view() then
			self:back_to_gotofight()
		end
	end

	function arg_1_0.__onClick_mask_frame_battlereport(arg_12_0)
		return
	end

	function arg_1_0.__onClick_mask_frame_buy(arg_13_0)
		local var_13_0 = var_0_2.find_object_by_id(var_0_3.shop_damage_control_cid)

		var_0_1:createInstance("shop_bounced"):show({
			price = var_13_0.price,
			title = var_13_0.title,
			id = var_0_3.shop_damage_control_cid
		}, var_0_3.buy_enter_type.fight_prepare)
	end

	function arg_1_0:__onClick_bg_info_bg_enemy_info_bg_circuity_btn()
		if self._can_send_req then
			self:__change_roundabout_state()
			self:__random_circuity(self._response_data.monster_array)

			if self._random >= 1 and self._random <= self._random_prob then
				self._control.bg.info_bg.enemy_info_bg.canvasGroup.alpha = 0

				var_0_4:show(1, "pveskipsuccess")

				if self._input_map_node ~= 0 then
					self._next_move_node_data = self:__get_node_by_id(self._input_map_node)
					self._input_map_node = 0
				end

				self:__show_fight_info(self._next_move_node_data.id)
				var_0_9:add_cur_buttle_list({
					id = self._next_move_node_data.pve_level_id,
					point = self._next_move_node_data.id
				})
				var_0_9:req_RoundAboutReq(true)
				self:set_send_req_state(false)

				self._control.bg.info_bg.enemy_info_bg.canvasGroup.blocksRaycasts = false
			else
				var_0_4:show(1, "pveskipfail")
				var_0_9:req_RoundAboutReq(false)
				self._control.bg.info_bg.enemy_info_bg.circuity_btn:SetActive(false)
				self:__onClick_bg_info_bg_enemy_info_bg_fight_btn()
			end
		end
	end

	function arg_1_0:__back_to_home_view()
		if var_0_9:get_guide_state() then
			self:setVisible(false)
			var_0_1:destroyInstance("combat_result")

			local var_15_0 = var_0_1:createInstance("home")

			var_15_0:show()
			var_15_0:into_home_bgm()
			var_0_1:destroyInstance("fight_info")

			return false
		end

		return true
	end

	function arg_1_0:__onClick_bg_info_bg_strongattack_string_node1()
		var_0_9:set_strong_buff_list(self._strong_buff_list[1])

		self._control.bg.info_bg.strongattack.canvasGroup.alpha = 0
		self._control.bg.info_bg.strongattack.canvasGroup.blocksRaycasts = false

		self:__toggle_encounter(true, self._response_data)
	end

	function arg_1_0:__onClick_bg_info_bg_strongattack_string_node2()
		var_0_9:set_strong_buff_list(self._strong_buff_list[2])

		self._control.bg.info_bg.strongattack.canvasGroup.alpha = 0
		self._control.bg.info_bg.strongattack.canvasGroup.blocksRaycasts = false

		self:__toggle_encounter(true, self._response_data)
	end

	function arg_1_0:__onClick_bg_info_bg_strongattack_string_node3()
		var_0_9:set_strong_buff_list(self._strong_buff_list[3])

		self._control.bg.info_bg.strongattack.canvasGroup.alpha = 0
		self._control.bg.info_bg.strongattack.canvasGroup.blocksRaycasts = false

		self:__toggle_encounter(true, self._response_data)
	end

	function arg_1_0:__onClick_bg_info_bg_strongattack_string_node4()
		var_0_9:set_strong_buff_list(self._strong_buff_list[4])

		self._control.bg.info_bg.strongattack.canvasGroup.alpha = 0
		self._control.bg.info_bg.strongattack.canvasGroup.blocksRaycasts = false

		self:__toggle_encounter(true, self._response_data)
	end

	function arg_1_0:__onClick_bg_info_bg_strongattack_string_node5()
		var_0_9:set_strong_buff_list(self._strong_buff_list[5])

		self._control.bg.info_bg.strongattack.canvasGroup.alpha = 0
		self._control.bg.info_bg.strongattack.canvasGroup.blocksRaycasts = false

		self:__toggle_encounter(true, self._response_data)
	end

	function arg_1_0:__onClick_return_home_right_layer_return_btn()
		if self:__back_to_home_view() then
			self._control.return_home.left_layer.rectTransform.anchoredPosition = var_0_14(-300, -360)
			self._control.return_home.right_layer.rectTransform.anchoredPosition = var_0_14(300, -360)

			self._control.return_home.right_layer.rectTransform:DOAnchorPos(var_0_14(1000, -360), 0.2):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0):SetAutoKill(true)

			self._control.return_home.left_layer.rectTransform:DOAnchorPos(var_0_14(-1000, -360), 0.2):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0):SetAutoKill(true).onComplete = function()
				self:back_to_gotofight()
			end
		end
	end

	function arg_1_0:__onClick_bg_select_1()
		self:__play_ship_move(self.start_node_by_is_chose, self.next_node_by_is_chose, self.is_story, true)
		self._control.bg.select_node_layer:SetActive(false)
		self._control.bg.select_1:SetActive(false)
	end

	function arg_1_0.__onClick_bg_return_btn(arg_24_0)
		return
	end

	function arg_1_0.__onClick_bg_left_people(arg_25_0)
		return
	end

	function arg_1_0:__onClick_abyss_msgbox_main_select_node_layer_select_1()
		self:__click_select_abyss_buff(1)
	end

	function arg_1_0:__onClick_abyss_msgbox_main_select_node_layer_select_2()
		self:__click_select_abyss_buff(2)
	end

	function arg_1_0:__onClick_abyss_msgbox_main_select_node_layer_select_3()
		self:__click_select_abyss_buff(3)
	end

	function arg_1_0:__onClick_abyss_msgbox_select_msg_btn()
		if self._abyss_select_buff_id then
			var_0_9:req_AbyssChooseBuffReq(self._abyss_select_buff_id)
		end

		self._control.abyss_msgbox.gameObject:SetActive(false)

		for iter_29_0 = #self._abyss_buff_select, 1, -1 do
			if self._abyss_buff_select[iter_29_0].id == self._abyss_select_buff_id then
				table.remove(self._abyss_buff_select, iter_29_0)
			end
		end
	end

	function arg_1_0.__onClick_abyss_combat_buff_store_main_select_node_layer_select_1(arg_30_0)
		return
	end

	function arg_1_0.__onClick_abyss_combat_buff_store_main_select_node_layer_select_2(arg_31_0)
		return
	end

	function arg_1_0.__onClick_abyss_combat_buff_store_main_select_node_layer_select_3(arg_32_0)
		return
	end

	function arg_1_0.__onClick_abyss_combat_buff_store_main_select_node_layer_buff_store_1(arg_33_0)
		return
	end

	function arg_1_0.__onClick_abyss_combat_buff_store_main_select_node_layer_buff_store_2(arg_34_0)
		return
	end

	function arg_1_0.__onClick_abyss_combat_buff_store_main_select_node_layer_buff_store_3(arg_35_0)
		return
	end

	function arg_1_0:__onClick_fearlessness_buff_msgbox_main_select_node_layer_select_buff_1()
		var_0_9:req_PushChooseBuffReq({
			point_id = self._retropulsion_map_id,
			buff_id = self._retropulsion_buff_1.id
		})
	end

	function arg_1_0:__onClick_fearlessness_buff_msgbox_main_select_node_layer_select_buff_2()
		var_0_9:req_PushChooseBuffReq({
			point_id = self._retropulsion_map_id,
			buff_id = self._retropulsion_buff_2.id
		})
	end

	function arg_1_0:__onClick_fearlessness_buff_msgbox_main_select_node_layer_select_buff_3()
		var_0_9:req_PushChooseBuffReq({
			point_id = self._retropulsion_map_id,
			buff_id = self._retropulsion_buff_3.id
		})
	end

	function arg_1_0:__onClick_bg_info_bg_enemy_info_bg_bvr_btn()
		if not self._set_bvr_btn_isOn then
			self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))
			var_0_9:req_BVRAttackChangeReq(true)
			self._control.bg.info_bg.enemy_info_bg.bvr_btn.spine_effect:SetActive(true)
			self:__play_animation(self._control.bg.info_bg.enemy_info_bg.bvr_btn.spine_effect, "icon_effect_230407", true)
			self:__special_situation_run(true)
		else
			self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
			self._control.bg.info_bg.enemy_info_bg.bvr_btn.spine_effect:SetActive(false)
			var_0_9:req_BVRAttackChangeReq(false)
			self:__special_situation_run(false)
		end

		self._set_bvr_btn_isOn = not self._set_bvr_btn_isOn
	end

	function arg_1_0:__onClick_msg_panel_finish_special_mission_btn()
		self._control.msg_panel:SetActive(false)
	end

	function arg_1_0:__onClick_mask_broken_btn()
		self._control.broken_info:SetActive(false)
		self._control.mask.broken_btn:SetActive(false)
	end

	function arg_1_0:__onClick_mask_frame_danger_layer()
		self._control.broken_info:SetActive(true)
		self._control.mask.broken_btn:SetActive(true)
	end
end

function var_0_0.extend_obj(arg_43_0)
	return
end

return var_0_0
