local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = DG.Tweening.DOTween
local var_0_3 = gameenum.common_type
local var_0_5 = gamecore.user
local var_0_7 = gameconfig.ship_pve_active_config
local var_0_8 = gameconfig.ship_rule_config
local var_0_9 = {
	left = 1,
	right = 2
}
local var_0_10 = {
	hard = "hard",
	normal = "normal"
}

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onPointerDown_main_map_root_big_map_bg(arg_2_0)
		return
	end

	function arg_1_0.__onPointerUp_main_map_root_big_map_bg(arg_3_0)
		return
	end

	function arg_1_0.__onPointerClick_main_map_root_big_map_bg(arg_4_0)
		return
	end

	function arg_1_0:__onClick_button_root_return_btn()
		var_0_5:set_to_mix(false)
		var_0_1:destroyInstance("mix_main_map")

		local var_5_0 = var_0_1:getInstance("home")

		if var_5_0 then
			var_5_0:show()
		else
			var_5_0 = var_0_1:createInstance("home")

			var_5_0:show()
		end

		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
		var_5_0:into_home_bgm()
	end

	function arg_1_0:__onClick_button_root_page_left_btn()
		self:__page_btn_switch_map_id_func(var_0_9.left)
		self:__page_btn_switch_angle_func()

		self._cur_rotate_direction = "left"

		self:__get_map_switch_angle_and_id()
	end

	function arg_1_0:__onClick_button_root_page_right_btn()
		self:__page_btn_switch_map_id_func(var_0_9.right)
		self:__page_btn_switch_angle_func()

		self._cur_rotate_direction = "right"

		self:__get_map_switch_angle_and_id()
	end

	function arg_1_0:__onClick_button_root_difficulty_mode_btn()
		if not self._can_mouse_rotate then
			return
		end

		if self._difficulty == var_0_10.normal then
			self._difficulty = var_0_10.hard or var_0_10.normal
		end

		self:__switch_main_map_bg_and_page_btn_func()
		self:__switch_point_and_line_prefab_func()
		self:__switch_difficulty_mode_btn_func(true)
		self:__page_btn_switch_angle_func()
		self:__switch_page_btn_active_state()
		self:__update_point_and_line_prefab_state()
		self:__set_memory_cur_mode()
		self:__update_exploit_bg_btn_show()
		self:__update_cur_transform_rotation()
		self:__show_point_gradually_func()
	end

	function arg_1_0:__onClick_special_task_panel_special_task_bg_task_close_btn()
		self:__show_special_task(false)
	end

	function arg_1_0:__onClick_instructions_prev()
		self:__set_instructions_info(self._page_move - 1)

		self._page_move = self._page_move - 1
	end

	function arg_1_0:__onClick_instructions_next()
		self:__set_instructions_info(self._page_move + 1)

		self._page_move = self._page_move + 1
	end

	function arg_1_0:__onClick_instructions_instructions_close()
		self._control.instructions:SetActive(false)
		var_0_5:req_SeventhGuideReq()
	end

	function arg_1_0:__onClick_button_root_exploit_bg_exploit_btn()
		self:__show_special_task(true)
	end

	function arg_1_0:__onClick_button_root_story_bg_story_btn()
		var_0_1:createInstance("cinema_story_node"):show(var_0_7.find_object_by_id(var_0_8.find_object_by_id(self._active_id).content.activeId).movie_group_id, true)
	end

	function arg_1_0:__onClick_button_root_how_bg_how_btn()
		self._page_move = 1

		self:__set_instructions_info(self._page_move)
		self._control.instructions:SetActive(true)
	end

	function arg_1_0:__onClick_msg_panel_finish_special_mission_btn()
		self._control.msg_panel.finish_special_mission:SetActive(false)
		self._control.msg_panel.finish_special_mission_btn:SetActive(false)

		if self._task_num > 1 then
			self._control.msg_panel.finish_special_mission_btn:SetActive(true)

			local var_16_0 = self._control.msg_panel.finish_special_mission
			local var_16_1 = self:autoKillDOTween(var_0_2.Sequence())

			var_16_1:AppendCallback(function()
				self:set_finish_task(self._task_info, 2, var_16_0)
			end)
			var_16_1:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
			var_16_1:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)

			self._task_num = 0
		end
	end
end

function var_0_0.extend_obj(arg_18_0)
	return
end

return var_0_0
