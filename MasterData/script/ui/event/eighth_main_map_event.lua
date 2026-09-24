local var_0_0 = {}
local var_0_1 = gameconfig.ship_pve_active_config
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onPointerDown_bg(arg_2_0)
		return
	end

	function arg_1_0.__onPointerUp_bg(arg_3_0)
		return
	end

	function arg_1_0.__onPointerClick_bg(arg_4_0)
		return
	end

	function arg_1_0:__onClick_return_btn()
		var_0_2:destroyInstance("eighth_main_map")

		local var_5_0 = {
			id = self._active_id
		}

		var_5_0.start_time = 0
		var_5_0.end_time = 1

		var_0_3:req_ActivityDurationReq(var_5_0)

		local var_5_1 = var_0_2:getInstance("home")

		if var_5_1 then
			var_5_1:show()
		else
			var_5_1 = var_0_2:createInstance("home")

			var_5_1:show()
		end

		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.back))
		var_5_1:into_home_bgm()
	end

	function arg_1_0.__onBeginDrag_bg(arg_6_0)
		return
	end

	function arg_1_0.__onDrag_bg(arg_7_0)
		return
	end

	function arg_1_0.__onEndDrag_bg(arg_8_0)
		return
	end

	function arg_1_0:__onClick_plot_btn()
		var_0_2:createInstance("cinema_story_node"):show(var_0_1.find_object_by_id(var_0_4.pve_active_eighth_id).movie_group_id, true)
		self:_play_into_se()
	end

	function arg_1_0:__onClick_support_btn()
		var_0_2:createInstance("eighth_support_layer"):show()
		self:setVisible(false)
		self:_play_into_se()
	end

	function arg_1_0.__onClick_bg_btn_root_eighth_map_point_item_1_mask_img_idx_btn(arg_11_0)
		return
	end

	function arg_1_0.__onClick_bg_btn_root_eighth_map_point_item_2_mask_img_idx_btn(arg_12_0)
		return
	end

	function arg_1_0.__onClick_bg_btn_root_eighth_map_point_item_3_mask_img_idx_btn(arg_13_0)
		return
	end

	function arg_1_0.__onClick_bg_btn_root_eighth_map_point_item_4_mask_img_idx_btn(arg_14_0)
		return
	end

	function arg_1_0.__onClick_bg_btn_root_eighth_map_point_item_5_mask_img_idx_btn(arg_15_0)
		return
	end

	function arg_1_0.__onClick_bg_btn_root_eighth_map_point_item_6_mask_img_idx_btn(arg_16_0)
		return
	end

	function arg_1_0:__onClick_desc_btn()
		self._page_move = 1

		self:__set_instructions_info(self._page_move)
		self._control.instructions:SetActive(true)
		self:_play_into_se()
	end

	function arg_1_0:__onClick_instructions_instructions_close()
		self._control.instructions:SetActive(false)
		var_0_3:req_EighthGuideReq()
		self:_play_into_se()
	end

	function arg_1_0:__onClick_instructions_prev()
		self:__set_instructions_info(self._page_move - 1)

		self._page_move = self._page_move - 1

		self:_play_into_se()
	end

	function arg_1_0:__onClick_instructions_next()
		self:__set_instructions_info(self._page_move + 1)

		self._page_move = self._page_move + 1

		self:_play_into_se()
	end

	function arg_1_0:__onClick_difficulty_mode_btn()
		self:_change_difficulty_type()
		self:_play_into_se()
	end

	function arg_1_0:__onClick_left_img()
		self:__check_map_position(false)
		self:_play_into_se()
	end

	function arg_1_0:__onClick_right_img()
		self:__check_map_position(true)
		self:_play_into_se()
	end

	function arg_1_0:__onClick_msg_panel_finish_special_mission_btn()
		self._control.msg_panel:SetActive(false)
	end
end

function var_0_0.extend_obj(arg_25_0)
	return
end

return var_0_0
