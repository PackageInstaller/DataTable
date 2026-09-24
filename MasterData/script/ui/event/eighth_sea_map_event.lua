local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.UILoader
local var_0_3 = gameenum.common_type
local var_0_5 = gameconfig.pve_eighth_level_config
local var_0_6 = gameconfig.pve_eighth_level_node_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onPointerDown_empty_bg()
		self._can_move = true
		self._now_move_num = nil
		self._now_move_func = nil
		self.target_pos_list = {}
		self._is_creat_list = false
		self._is_move_list = false

		if self._support_info and next(self._support_info) then
			for iter_2_0, iter_2_1 in pairs(self._support_info) do
				if iter_2_1.single_ctrl.enemy_role.gameObject.activeInHierarchy then
					iter_2_1.single_ctrl.support_point.clear_support_btn_2:SetActive(false)
				else
					iter_2_1.single_ctrl.support_point.support_bg_2:SetActive(false)
					iter_2_1.single_ctrl.support_point.set_support_btn:SetActive(false)
					iter_2_1.single_ctrl.support_point.support_btn:SetActive(true)
					iter_2_1.single_ctrl.support_point.support_bg:SetActive(true)
				end
			end
		end
	end

	function arg_1_0.__onPointerUp_empty_bg(arg_3_0)
		return
	end

	function arg_1_0.__onPointerClick_empty_bg(arg_4_0)
		return
	end

	function arg_1_0.__onClick_empty_bg_treasure_get_img(arg_5_0)
		return
	end

	function arg_1_0.__onClick_empty_bg_treasure_get_btn(arg_6_0)
		return
	end

	function arg_1_0.__onTriggerEnter2D_player_role(arg_7_0)
		return
	end

	function arg_1_0.__onTriggerStay2D_player_role(arg_8_0)
		return
	end

	function arg_1_0.__onTriggerExit2D_player_role(arg_9_0)
		return
	end

	function arg_1_0:__onClick_return_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back_two))
		var_0_1:set_eight_monster_hurt_id()
		var_0_1:set_monster_is_move(false)

		self._monster_move = false

		if self._player_pos then
			var_0_1:req_EighthBigMapMoveReq(self.map_id, self._player_pos)
			var_0_3:set_eighth_main_map_is_show(true)
		else
			self:__exit_animation()

			local var_10_0 = var_0_2:getInstance("eighth_main_map")
			local var_10_1 = var_0_1:get_eighth_event_activity_id()

			if var_10_0 then
				var_10_0:show(var_10_1)
			else
				var_0_2:createInstance("eighth_main_map"):show(var_10_1)
			end
		end
	end

	function arg_1_0:__onClick_enemy_info_bg_back_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back_two))
		self._control.enemy_info_bg:SetActive(false)

		self._now_move_func = nil
		self._now_move_num = nil
		self._monster_move = false
	end

	function arg_1_0:__onClick_enemy_info_bg_fight_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back_two))

		local var_12_0 = var_0_2:getInstance("fight_prepare")
		local var_12_1 = {
			is_boss = false,
			fight_prepare_type = var_0_3.fight_type.eighth_attack,
			map_data = self.sea_map_data,
			elite_id = self._now_move_elite_id,
			is_encounter = self._is_encounter
		}

		self._control.cover_2:SetActive(false)
		var_0_1:set_monster_is_move(false)

		if var_12_0 then
			var_12_0:show(var_12_1)
		else
			var_0_2:createInstance("fight_prepare"):show(var_12_1)
		end

		if self._player_pos then
			var_0_1:req_EighthBigMapMoveReq(self.map_id, self._player_pos)
		end

		self:__onReset()
		self:setVisible(false)
	end

	function arg_1_0:__onClick_map_preview_map_bg_close_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back_two))
		self:show_self_cover_func(false)
		self._control.map_preview:SetActive(false)

		self._now_move_func = nil
	end

	function arg_1_0:__onClick_map_preview_map_bg_reward_panel_reward_icon()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back_two))
		self:__show_award_detail()
	end

	function arg_1_0:__onClick_map_preview_map_bg_confirm_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back_two))

		self._now_move_func = nil
		self._now_move_num = nil

		var_0_1:set_monster_is_move(false)

		local var_15_0, var_15_1 = var_0_6.get_sequence()
		local var_15_2 = {}

		for iter_15_0, iter_15_1 in pairs(var_15_0) do
			if self.sea_map_data.id == iter_15_1.pve_level_id then
				table.insert(var_15_2, iter_15_1)
			end
		end

		var_0_1:req_EighthBigMapMoveReq(self.sea_map_data.id, self.player_now_num)
		var_0_2:createInstance("fight_prepare"):show({
			is_boss = true,
			fight_prepare_type = var_0_3.fight_type.eighth_attack,
			map_data = self.sea_map_data,
			go_to_map_id = self.sea_map_data.id,
			map_level_data = var_0_5.find_object_by_id(self.sea_map_data.id),
			map_level_node_data = var_15_2
		})
		self:__exit_animation()
		var_0_1:reset_eighth_fight_info_pass()
	end

	function arg_1_0:__onClick_map_preview_map_bg_equip_mask()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back_two))
		self:__show_equip_mask(false)
	end

	function arg_1_0:__onClick_finish_special_mission_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back_two))
		self._control.msg_panel:SetActive(false)
		self._control.finish_special_mission_btn:SetActive(false)
	end

	function arg_1_0.__onClick_explore(arg_18_0)
		return
	end

	function arg_1_0.__onClick_explore_btn(arg_19_0)
		return
	end

	function arg_1_0:__onClick_enemy_buff_level()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back_two))
		self._control.cover_2:SetActive(true)

		local var_20_0 = var_0_2:getInstance("eighth_enemy_buff")

		if var_20_0 then
			var_20_0:show(self.map_id)
		else
			var_0_2:createInstance("eighth_enemy_buff"):show(self.map_id)
		end
	end
end

function var_0_0.extend_obj(arg_21_0)
	return
end

return var_0_0
