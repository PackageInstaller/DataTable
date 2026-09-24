local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = DG.Tweening.DOTween
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.user
local var_0_10 = gameconfig.pve_mix_level_config
local var_0_11 = gameconfig.pve_mix_level_node_config
local var_0_13 = gamecore.Language
local var_0_14 = gamecore.prompt

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_return_btn()
		self._control.top_find_ani.scattering:SetActive(false)
		self._control.player_role.radar:SetActive(false)

		self._control.explore.btn.button.enabled = true

		self:_close_all_find_ani()
		self:__exit_animation()
	end

	function arg_1_0.__onPointerDown_empty_bg(arg_3_0)
		arg_3_0._can_move = true
		arg_3_0._now_move_num = nil
		arg_3_0._now_move_func = nil
		arg_3_0.target_pos_list = {}
		arg_3_0._is_creat_list = false
		arg_3_0._is_move_list = false
	end

	function arg_1_0:__onPointerUp_empty_bg()
		if self._time > 0.3 then
			self._can_move = false
			self._now_move_num = nil
		end
	end

	function arg_1_0.__onPointerClick_empty_bg(arg_5_0)
		return
	end

	function arg_1_0.__onTriggerEnter2D_player_role(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_1.gameObject:GetComponent("Trigger2DEvent")

		if not var_6_0 or not arg_6_1.gameObject:GetComponent("BoxCollider2D") then
			return
		end

		if var_6_0.colliderName == "obstacle" then
			-- block empty
		end
	end

	function arg_1_0.__onTriggerStay2D_player_role(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_1.gameObject:GetComponent("Trigger2DEvent")

		if not var_7_0 or not arg_7_1.gameObject:GetComponent("BoxCollider2D") then
			return
		end

		if var_7_0.colliderName == "obstacle" then
			-- block empty
		end
	end

	function arg_1_0.__onTriggerExit2D_player_role(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_1.gameObject:GetComponent("Trigger2DEvent")

		if not var_8_0 or not arg_8_1.gameObject:GetComponent("BoxCollider2D") then
			return
		end

		if var_8_0.colliderName == "obstacle" then
			-- block empty
		end
	end

	function arg_1_0:__onClick_enemy_info_bg_back_btn()
		self._control.enemy_info_bg:SetActive(false)

		self._now_move_func = nil
		self._now_move_num = nil
	end

	function arg_1_0:__onClick_enemy_info_bg_fight_btn()
		var_0_4:set_into_seven_fight(self._now_face)
		self:_close_all_find_ani()

		local var_10_0 = self:__get_rule_num_by_pos(self._control.player_role.rectTransform.anchoredPosition - self._control.empty_bg.rectTransform.anchoredPosition)

		var_0_4:req_SeventhBigMapMoveReq(self.sea_map_data.id, self.player_now_num)
		var_0_1:createInstance("fight_prepare"):show({
			is_boss = false,
			fight_prepare_type = var_0_3.fight_type.seventh,
			map_data = self.sea_map_data,
			pos_num = self._now_move_num,
			is_encounter = self._is_encounter
		})

		self._now_move_func = nil
		self._now_move_num = nil

		self:__onReset()
		self:setVisible(false)
	end

	function arg_1_0:__onClick_map_preview_map_bg_close_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
		self:autoKillDOTween(var_0_2.Sequence()):Append(self._control.map_preview.map_bg.transform:DOScale(0, 0.3):SetEase(DG.Tweening.Ease.InExpo):OnComplete(function()
			self._now_move_func = nil
			self._now_move_num = nil

			self._control.map_preview.map_bg.transform:DOScale(1, 0)
			self._control.map_preview:SetActive(false)
		end))
	end

	function arg_1_0:__onClick_map_preview_map_bg_confirm_btn()
		var_0_4:set_into_seven_fight(self._now_face)
		self:_close_all_find_ani()

		self._now_move_func = nil
		self._now_move_num = nil

		self:__onReset()
		self:setVisible(false)

		local var_13_0, var_13_1 = var_0_11.get_sequence()
		local var_13_2 = {}

		for iter_13_0, iter_13_1 in pairs(var_13_0) do
			if self.sea_map_data.id == iter_13_1.pve_level_id then
				table.insert(var_13_2, iter_13_1)
			end
		end

		var_0_4:req_SeventhBigMapMoveReq(self.sea_map_data.id, self.player_now_num)
		var_0_1:createInstance("fight_prepare"):show({
			is_boss = true,
			fight_prepare_type = var_0_3.fight_type.seventh,
			map_data = self.sea_map_data,
			go_to_map_id = self.sea_map_data.id,
			map_level_data = var_0_10.find_object_by_id(self.sea_map_data.id),
			map_level_node_data = var_13_2
		})
		var_0_4:reset_seventh_fight_info_pass()
	end

	function arg_1_0:__onClick_map_preview_map_bg_reward_panel_reward_icon()
		self:__show_award_detail()
	end

	function arg_1_0:__onClick_map_preview_map_bg_equip_mask()
		self:__show_equip_mask(false)
	end

	function arg_1_0:__onClick_finish_special_mission_btn()
		self._control.msg_panel.finish_special_mission:SetActive(false)
		self._control.finish_special_mission_btn:SetActive(false)

		local var_16_0 = self._control.msg_panel.finish_special_mission

		if self._task_num > 1 then
			local var_16_1 = self:autoKillDOTween(var_0_2.Sequence())

			self._control.finish_special_mission_btn:SetActive(true)
			var_16_1:AppendCallback(function()
				self:set_finish_task(self._task_info, 2, var_16_0)
			end)
			var_16_1:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
			var_16_1:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
			self._control.finish_special_mission_btn:SetActive(true)

			self._task_num = 0
		end
	end

	function arg_1_0.__onClick_explore(arg_18_0)
		return
	end

	function arg_1_0.__onClick_salvage(arg_19_0)
		return
	end

	function arg_1_0.__onClick_treasure_get_img(arg_20_0)
		return
	end

	function arg_1_0.__onClick_empty_bg_treasure_get_img(arg_21_0)
		return
	end

	function arg_1_0.__onClick_salvage_salvage_btn(arg_22_0)
		return
	end

	function arg_1_0:__onClick_empty_bg_treasure_get_btn()
		var_0_4:req_SeventhTreasureGetAwardReq(self.sea_map_user_data.id)
	end

	function arg_1_0:__onClick_explore_btn()
		if self._into_treasure_area and self._sea_treasure_num ~= 0 then
			var_0_14:show(var_0_13:getNowLang("7th_treasure_2"))

			return
		end

		if self._sea_treasure_num == 0 then
			var_0_14:show(var_0_13:getNowLang("7th_treasure"))

			return
		end

		self._control.explore.btn.button.enabled = false
		self._control.explore.btn.image.sprite = self:loadSprite(var_0_3.seven_ban_find_treasure_img)
		self._find_btn_start = true
		self._find_btn_time = 0

		self:_set_find_ani()
	end
end

function var_0_0.extend_obj(arg_25_0)
	return
end

return var_0_0
