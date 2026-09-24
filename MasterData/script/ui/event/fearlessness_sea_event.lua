local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = DG.Tweening.DOTween
local var_0_3 = gameenum.common_type
local var_0_5 = gamecore.user
local var_0_6 = gamecore.Language
local var_0_7 = gameconfig.ship_pve_active_config
local var_0_8 = gameconfig.ship_rule_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg_back_btn()
		var_0_5:set_goto_fear_sea(false)
		var_0_5:set_save_now_fear(false)
		self:setVisible(false)
		self:__destroy_pool()
		self:__destroy_seq()
		self:__kill_all_tween()
		var_0_1:destroyInstance("fearlessness_sea")
		var_0_1:destroyInstance("suppress_msg")

		local var_2_0 = var_0_1:createInstance("home")

		var_2_0:show()
		var_2_0:into_home_bgm()
	end

	function arg_1_0:__onClick_map_preview_map_bg_close_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))

		local var_3_0 = var_0_1:getInstance("suppress_msg")

		if var_3_0 then
			var_3_0:setVisible(false)
		end

		self:autoKillDOTween(var_0_2.Sequence()):Append(self._control.map_preview.map_bg.transform:DOScale(0, 0.3):SetEase(DG.Tweening.Ease.InExpo):OnComplete(function()
			self._control.map_preview.map_bg.transform:DOScale(1, 0)

			self._control.obj_pool_root.canvasGroup.interactable = true

			self:__hide_all_mini_map_fragment_to_pool()
			self._control.map_preview:SetActive(false)
			self._control.back_image:SetActive(false)
		end))

		for iter_3_0 = 1, self._control.map_preview.map_bg.map_panel.map_node_root.transform.childCount do
			self:destroyChildren("map_node_obj")
			self:destroyChildren("map_line_obj")
			self:destroyChildren("fearlessness_sea_letter_obj")
		end

		self:__set_big_arrow_position((self:__check_pass_num()))
	end

	function arg_1_0:__onClick_map_preview_map_bg_confirm_btn()
		self._alreay_init = false

		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))

		self._control.obj_pool_root.canvasGroup.interactable = true

		self:__hide_all_mini_map_fragment_to_pool()
		self._control.map_preview:SetActive(false)
		self._control.back_image:SetActive(false)
		self:setVisible(false)
		var_0_1:destroyInstance("fearlessness_sea")
		var_0_1:createInstance("fight_prepare"):show({
			fight_prepare_type = var_0_3.fight_type.fearlessness_sea,
			go_to_map_id = self._curr_tmp_map_data.id,
			support_id = self._curr_tmp_map_data.support_id,
			init_chapter_index = self._curr_tmp_map_data.pve_id,
			init_map_index = self._curr_tmp_map_data.id - self._curr_tmp_map_data.pve_id * 100,
			fight_type = var_0_3.fight_type.fearlessness_sea
		})
	end

	function arg_1_0.__onClick_mask_Button(arg_6_0)
		return
	end

	function arg_1_0:__onClick_mask_Button_2()
		if self._has_show_task == nil then
			self._has_show_task = false
		end

		self._has_show_task = not self._has_show_task

		self:__show_special_task(self._has_show_task)
	end

	function arg_1_0:__onClick_special_task_panel_special_task_bg_task_close_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
		self:__show_special_task(false)
	end

	function arg_1_0:__onClick_bg_mode_panel_normal_image()
		var_0_5:set_now_common_panel_state(1)
		self:__change_hard_map(false)
		var_0_5:set_save_now_fear(false)
	end

	function arg_1_0:__onClick_bg_mode_panel_hard_image()
		var_0_5:set_now_common_panel_state(2)
		self:__change_hard_map(true)
		var_0_5:set_save_now_fear(true)
	end

	function arg_1_0:__onClick_map_preview_map_bg_reward_panel_reward_icon()
		self:__show_award_detail()
	end

	function arg_1_0:__onClick_equip_mask()
		self:__show_equip_mask(false)
	end

	function arg_1_0:__onClick_bg_info_icon_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))
		var_0_5:req_NinthMaxScoreLevelPassReq()
		self:setVisible(false)

		local var_13_0 = var_0_1:getInstance("ninth_cia")

		if var_13_0 then
			var_13_0:reset_init()
			var_13_0:show(var_0_3.fight_type.fearlessness_sea)
		else
			var_0_1:createInstance("ninth_cia"):show(var_0_3.fight_type.fearlessness_sea)
		end
	end

	function arg_1_0.__onClick_map_preview_map_bg_random_buff_btn(arg_14_0)
		var_0_1:createInstance("msgbox"):show(var_0_6:getNowLang("ui_random_buff_reset_content"), function()
			var_0_5:req_PushActivityRefreshReq()
		end, function()
			var_0_1:destroyInstance("msgbox")
		end, var_0_6:getNowLang("ui_random_buff_reset_title"), var_0_3.msg_type.tip)
	end

	function arg_1_0:__onClick_bg_story_btn()
		self:_play_into_se()

		local var_17_0 = var_0_8.find_object_by_id(var_0_3.pve_init_active_id.fearlessness_event).content

		if var_17_0 and next(var_17_0) then
			var_0_1:createInstance("cinema_story_node"):show(var_0_7.find_object_by_id(var_17_0.activeId).movie_group_id, true)
		end
	end

	function arg_1_0:__onClick_bg_btns_explain_talk_btn()
		self:__tween_score_guide_ainimation_2(true)
	end

	function arg_1_0:__onClick_bg_btns_story_btn()
		self:_play_into_se()

		local var_19_0 = var_0_8.find_object_by_id(var_0_3.pve_init_active_id.fearlessness_event).content

		if var_19_0 and next(var_19_0) then
			var_0_1:createInstance("cinema_story_node"):show(var_0_7.find_object_by_id(var_19_0.activeId).movie_group_id, true)
		end
	end

	function arg_1_0:__onClick_bg_btns_special_task_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))
		self:__show_special_task(true)
	end

	function arg_1_0:__onClick_push_guide_tip_layer_close()
		self:__tween_score_guide_ainimation_2(false)
	end

	function arg_1_0:__onClick_map_preview_map_bg_drop_available()
		local var_22_0 = var_0_1:getInstance("ship_available")
		local var_22_1 = gameconfig.drop_available_config.find_object_by_pve_id(self._now_little_map_id)

		if var_22_0 then
			var_22_0:show(var_0_3.go_to_ship_available.main_go, var_22_1)
		else
			var_0_1:createInstance("ship_available"):show(var_0_3.go_to_ship_available.main_go, var_22_1)
		end
	end

	function arg_1_0:__onClick_bg_btns_honor_btn()
		var_0_5:req_NinthMaxScoreLevelPassReq()
		self:setVisible(false)

		local var_23_0 = var_0_1:getInstance("ninth_honor_list")

		if var_23_0 then
			var_23_0:show(var_0_3.pve_active_type.normal)
		else
			var_0_1:createInstance("ninth_honor_list"):show(var_0_3.pve_active_type.normal)
		end
	end
end

function var_0_0.extend_obj(arg_24_0)
	return
end

return var_0_0
