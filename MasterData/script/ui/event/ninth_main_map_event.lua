local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.prompt
local var_0_3 = gamecore.util_func
local var_0_4 = DG.Tweening.DOTween
local var_0_5 = gamecore.UILoader
local var_0_6 = gameenum.common_type
local var_0_7 = gamecore.Language
local var_0_9 = gameconfig.ship_pve_active_config
local var_0_10 = gameconfig.pve_ninth_level_config
local var_0_11 = gameconfig.ship_rule_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_all_button_desc_btn()
		self._control.push_guide:SetActive(true)
	end

	function arg_1_0.__onClick_all_button_plot_btn(arg_3_0)
		var_0_5:createInstance("cinema_story_node"):show(var_0_9.find_object_by_id(var_0_11.find_object_by_id(var_0_6.pve_init_active_id.ninth_event).content.activeId).movie_group_id, true)
	end

	function arg_1_0.__onClick_all_button_award_btn(arg_4_0)
		local var_4_0 = var_0_5:getInstance("ninth_awardbox")

		if var_4_0 then
			var_4_0:show()
		else
			var_0_5:createInstance("ninth_awardbox"):show()
		end
	end

	function arg_1_0:__onClick_all_button_honor_btn()
		var_0_1:req_NinthMaxScoreLevelPassReq()
		self:setVisible(false)

		local var_5_0 = var_0_5:getInstance("ninth_honor_list")

		if var_5_0 then
			var_5_0:show()
		else
			var_0_5:createInstance("ninth_honor_list"):show()
		end
	end

	function arg_1_0:__onClick_all_button_task_btn()
		var_0_1:req_NinthMaxScoreLevelPassReq()
		self:setVisible(false)

		local var_6_0 = var_0_5:getInstance("ninth_task")

		if var_6_0 then
			var_6_0:show()
		else
			var_0_5:createInstance("ninth_task"):show()
		end
	end

	function arg_1_0:__onClick_all_button_buff_btn()
		self:setVisible(false)

		local var_7_0 = var_0_5:getInstance("ninth_cia")

		if var_7_0 then
			var_7_0:reset_init()
			var_7_0:show()
		else
			var_0_5:createInstance("ninth_cia"):show()
		end
	end

	function arg_1_0:__onClick_return_btn()
		self:setVisible(false)

		local var_8_0 = {
			id = self._active_id
		}

		var_8_0.start_time = 0
		var_8_0.end_time = 1

		var_0_1:req_ActivityDurationReq(var_8_0)
		var_0_5:destroyInstance("ninth_main_map")

		local var_8_1 = var_0_5:getInstance("home")

		if var_8_1 then
			var_8_1:show()
		else
			var_0_5:createInstance("home"):show()
		end
	end

	function arg_1_0:__onClick_msg_panel_finish_special_mission_btn()
		self._control.msg_panel.finish_special_mission:SetActive(true)

		local var_9_0 = self:autoKillDOTween(var_0_4.Sequence())

		var_9_0:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(1, 0))
		var_9_0:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(0, 0.5))

		if #self._show_task_list > 1 then
			table.remove(self._show_task_list, 1)
			self:show_task_panel_info(self._show_task_list[1], 1)
		elseif #self._show_server_task_list > 1 then
			if not self._is_next_task then
				table.remove(self._show_server_task_list, 1)
				self:show_task_panel_info(self._show_server_task_list[1], 2)
			else
				self:show_task_panel_info(self._show_server_task_list[1], 2)

				self._is_next_task = false
			end
		else
			self._control.msg_panel.finish_special_mission_btn:SetActive(false)
		end
	end

	function arg_1_0:__onClick_push_guide_tip_layer_close()
		self._control.push_guide:SetActive(false)
		self:show_ninth_task_and_server_task()
	end

	function arg_1_0.__onClick_bg_boss_info_btn(arg_11_0)
		return
	end

	function arg_1_0:__onClick_map_preview_map_bg_close_btn()
		self._control.map_preview:SetActive(false)
		self._control.mask_image_bg:SetActive(false)
		self:__hide_all_mini_map_fragment_to_pool()
		self:__destroy_pool()
		self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.back))
	end

	function arg_1_0.__onClick_map_preview_map_bg_reward_panel_reward_icon(arg_13_0)
		return
	end

	function arg_1_0:__onClick_map_preview_map_bg_confirm_btn()
		local var_14_0 = var_0_5:getInstance("fight_prepare")

		self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.begin_to_fight))
		var_0_1:reset_ninth_push_info_pass()

		if self._is_hard then
			self:all_pass_hard_map_list()
		else
			self:all_pass_easy_map_list()
		end

		local var_14_1 = {
			ninth_active_config = self._active_config,
			fight_prepare_type = var_0_6.fight_type.ninth_attack,
			go_to_map_id = self.map_fight_id
		}

		for iter_14_0, iter_14_1 in pairs((var_0_1:get_ninth_map_data())) do
			if iter_14_1.id == self.map_fight_id then
				var_0_1:set_ninth_boss_hp_info(iter_14_1.hp)
			end
		end

		self:setVisible(false)

		if var_14_0 then
			var_14_0:show(var_14_1)
		else
			var_0_5:createInstance("fight_prepare"):show(var_14_1)
		end
	end

	function arg_1_0:__onClick_bg_btn_root_ninth_map_point_item_1_mask_img_idx_btn()
		self:_show_small_monster_map(1, (var_0_1:ninth_map_is_pass(self._active_config.levels[1])))
		self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.open))
	end

	function arg_1_0:__onClick_bg_btn_root_ninth_map_point_item_2_mask_img_idx_btn()
		self:_show_small_monster_map(2, (var_0_1:ninth_map_is_pass(self._active_config.levels[2])))
		self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.open))
	end

	function arg_1_0:__onClick_bg_btn_root_ninth_map_point_item_3_mask_img_idx_btn()
		self:_show_small_monster_map(3, (var_0_1:ninth_map_is_pass(self._active_config.levels[3])))
		self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.open))
	end

	function arg_1_0:__onClick_bg_btn_root_ninth_map_point_item_4_mask_img_idx_btn()
		self:_show_small_monster_map(4, (var_0_1:ninth_map_is_pass(self._active_config.levels[4])))
		self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.open))
	end

	function arg_1_0:__onClick_bg_btn_root_ninth_map_point_item_5_mask_img_idx_btn()
		self:_show_small_monster_map(5, (var_0_1:ninth_map_is_pass(self._active_config.levels[5])))
		self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.open))
	end

	function arg_1_0:_show_small_monster_map(arg_20_1, arg_20_2)
		local var_20_2 = self._active_config.levels[arg_20_1]

		if arg_20_2 then
			var_20_2 = self._active_config.hardLevels[arg_20_1]

			var_0_1:set_now_level_state(true)
		elseif not arg_20_2 then
			var_0_1:set_now_level_state(false)
		end

		if not arg_20_2 and arg_20_1 == 5 then
			var_0_1:set_is_ninth_boss(true)

			for iter_20_0 = 1, 4 do
				self:_show_map_panel(var_20_2, iter_20_0, self._ninth_normal_map_data[arg_20_1].init_nodes)
			end

			var_0_1:set_now_level_state(false)
		elseif arg_20_2 and arg_20_1 == 5 then
			if var_0_1:ninth_map_is_pass(self._active_config.hardLevels[1]) or var_0_1:ninth_map_is_pass(self._active_config.hardLevels[2]) or var_0_1:ninth_map_is_pass(self._active_config.hardLevels[3]) or var_0_1:ninth_map_is_pass(self._active_config.hardLevels[4]) then
				var_0_1:set_is_ninth_boss(true)

				for iter_20_1 = 1, 4 do
					self:_show_map_panel(var_20_2, iter_20_1, self._ninth_hard_map_data[arg_20_1].init_nodes)
				end

				var_0_1:set_now_level_state(true)
			else
				var_0_2:show(var_0_7:getNowLang("ninth_not_pass"))
			end
		elseif not arg_20_2 then
			var_0_1:set_is_ninth_boss(false)
			var_0_1:set_ninth_map_start_point(self._ninth_normal_map_data[arg_20_1].init_node_id)
			self:_show_map_panel(var_20_2, 1, self._ninth_normal_map_data[arg_20_1].init_node_id)
		else
			var_0_1:set_is_ninth_boss(false)
			var_0_1:set_ninth_map_start_point(self._ninth_hard_map_data[arg_20_1].init_node_id)
			self:_show_map_panel(var_20_2, 1, self._ninth_hard_map_data[arg_20_1].init_node_id)
		end
	end

	function arg_1_0:_common_boss_panel_show()
		local var_21_0, var_21_1, var_21_2, var_21_3 = self:show_pass_list()
		local var_21_4 = var_0_1:get_ninth_active_common_num()

		if var_21_4 and next(var_21_4) then
			local var_21_5 = var_21_4.stage

			if var_21_4.is_hard then
				local var_21_6

				for iter_21_0 = 1, 4 do
					if iter_21_0 == var_21_5 then
						var_21_6 = self._ninth_hard_map_data[5].init_nodes[iter_21_0]
					end
				end

				var_0_1:set_ninth_map_start_point(var_21_6)
			else
				local var_21_7

				for iter_21_1 = 1, 4 do
					if iter_21_1 == var_21_5 then
						var_21_7 = self._ninth_normal_map_data[5].init_nodes[iter_21_1]
					end
				end

				var_0_1:set_ninth_map_start_point(var_21_7)
			end

			for iter_21_2 = 1, 4 do
				self._boss_select_map_list[iter_21_2]:SetActive(false)
			end

			self._boss_select_map_list[var_21_5]:SetActive(true)

			if var_21_5 == 1 then
				self:_set_small_panel_img_1(var_21_0, var_21_1, var_21_2, var_21_3)
			elseif var_21_5 == 2 then
				self:_set_small_panel_img_2(var_21_0, var_21_1, var_21_2, var_21_3)
			elseif var_21_5 == 3 then
				self:_set_small_panel_img_3(var_21_0, var_21_1, var_21_2, var_21_3)
			elseif var_21_5 == 4 then
				self:_set_small_panel_img_4(var_21_0, var_21_1, var_21_2, var_21_3)
			end

			for iter_21_3 = 1, 4 do
				if iter_21_3 == var_21_5 then
					self._boss_map_list[iter_21_3]:SetActive(true)
				else
					self._boss_map_list[iter_21_3]:SetActive(false)
				end
			end

			self:show_small_boss_panel_map(var_21_5)

			return
		end

		if var_21_0 then
			self._boss_select_map_list[1]:SetActive(true)
			self._boss_select_map_list[2]:SetActive(false)
			self._boss_select_map_list[3]:SetActive(false)
			self._boss_select_map_list[4]:SetActive(false)

			if var_0_1:ninth_map_is_pass(self._active_config.levels[5]) then
				var_0_1:set_ninth_map_start_point(self._ninth_hard_map_data[5].init_nodes[1])
				var_0_1:set_ninth_active_common_num({
					is_hard = true,
					stage = 1
				})
			else
				var_0_1:set_ninth_map_start_point(self._ninth_normal_map_data[5].init_nodes[1])
				var_0_1:set_ninth_active_common_num({
					is_hard = false,
					stage = 1
				})
			end

			for iter_21_4 = 1, 4 do
				self._boss_select_map_list[iter_21_4].boss_1.com_img:SetActive(false)
			end

			self._boss_map_list[1]:SetActive(true)
			self._boss_map_list[2]:SetActive(false)
			self._boss_map_list[3]:SetActive(false)
			self._boss_map_list[4]:SetActive(false)
			self._boss_select_map_list[1].boss_1.com_img:SetActive(true)
			self:_set_small_panel_img_1(var_21_0, var_21_1, var_21_2, var_21_3)
			self:show_small_boss_panel_map(1)
		elseif var_21_1 then
			self._boss_select_map_list[1]:SetActive(false)
			self._boss_select_map_list[2]:SetActive(true)
			self._boss_select_map_list[3]:SetActive(false)
			self._boss_select_map_list[4]:SetActive(false)

			if var_0_1:ninth_map_is_pass(self._active_config.levels[5]) then
				var_0_1:set_ninth_map_start_point(self._ninth_hard_map_data[5].init_nodes[2])
				var_0_1:set_ninth_active_common_num({
					is_hard = true,
					stage = 2
				})
			else
				var_0_1:set_ninth_map_start_point(self._ninth_normal_map_data[5].init_nodes[2])
				var_0_1:set_ninth_active_common_num({
					is_hard = false,
					stage = 2
				})
			end

			for iter_21_5 = 1, 4 do
				self._boss_select_map_list[iter_21_5].boss_2.com_img:SetActive(false)
			end

			self._boss_map_list[1]:SetActive(false)
			self._boss_map_list[2]:SetActive(true)
			self._boss_map_list[3]:SetActive(false)
			self._boss_map_list[4]:SetActive(false)
			self._boss_select_map_list[2].boss_2.com_img:SetActive(true)
			self:_set_small_panel_img_2(var_21_0, var_21_1, var_21_2, var_21_3)
			self:show_small_boss_panel_map(2)
		elseif var_21_2 then
			self._boss_select_map_list[1]:SetActive(false)
			self._boss_select_map_list[2]:SetActive(false)
			self._boss_select_map_list[3]:SetActive(true)
			self._boss_select_map_list[4]:SetActive(false)

			if var_0_1:ninth_map_is_pass(self._active_config.levels[5]) then
				var_0_1:set_ninth_map_start_point(self._ninth_hard_map_data[5].init_nodes[3])
				var_0_1:set_ninth_active_common_num({
					is_hard = true,
					stage = 3
				})
			else
				var_0_1:set_ninth_map_start_point(self._ninth_normal_map_data[5].init_nodes[3])
				var_0_1:set_ninth_active_common_num({
					is_hard = false,
					stage = 3
				})
			end

			for iter_21_6 = 1, 4 do
				self._boss_select_map_list[iter_21_6].boss_3.com_img:SetActive(false)
			end

			self._boss_map_list[1]:SetActive(false)
			self._boss_map_list[2]:SetActive(false)
			self._boss_map_list[3]:SetActive(true)
			self._boss_map_list[4]:SetActive(false)
			self._boss_select_map_list[3].boss_3.com_img:SetActive(true)
			self:_set_small_panel_img_3(var_21_0, var_21_1, var_21_2, var_21_3)
			self:show_small_boss_panel_map(3)
		elseif var_21_3 then
			self._boss_select_map_list[1]:SetActive(false)
			self._boss_select_map_list[2]:SetActive(false)
			self._boss_select_map_list[3]:SetActive(false)
			self._boss_select_map_list[4]:SetActive(true)

			if var_0_1:ninth_map_is_pass(self._active_config.levels[5]) then
				var_0_1:set_ninth_map_start_point(self._ninth_hard_map_data[5].init_nodes[4])
				var_0_1:set_ninth_active_common_num({
					is_hard = true,
					stage = 4
				})
			else
				var_0_1:set_ninth_map_start_point(self._ninth_normal_map_data[5].init_nodes[4])
				var_0_1:set_ninth_active_common_num({
					is_hard = false,
					stage = 4
				})
			end

			for iter_21_7 = 1, 4 do
				self._boss_select_map_list[iter_21_7].boss_4.com_img:SetActive(false)
			end

			self._boss_map_list[1]:SetActive(false)
			self._boss_map_list[2]:SetActive(false)
			self._boss_map_list[3]:SetActive(false)
			self._boss_map_list[4]:SetActive(true)
			self._boss_select_map_list[4].boss_4.com_img:SetActive(true)
			self:_set_small_panel_img_4(var_21_0, var_21_1, var_21_2, var_21_3)
			self:show_small_boss_panel_map(4)
		end
	end

	function arg_1_0:_set_small_panel_img_1(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
		if arg_22_2 then
			for iter_22_0 = 1, 4 do
				self._boss_select_map_list[iter_22_0].boss_2.com_img:SetActive(false)
			end
		else
			for iter_22_1 = 1, 4 do
				self._boss_select_map_list[iter_22_1].boss_2.com_img:SetActive(true)

				self._boss_select_map_list[iter_22_1].boss_2.image.material = self:loadMaterial(var_0_6.common_icon.furniture_gray_material)
			end
		end

		if arg_22_3 then
			for iter_22_2 = 1, 4 do
				self._boss_select_map_list[iter_22_2].boss_3.com_img:SetActive(false)
			end
		else
			for iter_22_3 = 1, 4 do
				self._boss_select_map_list[iter_22_3].boss_3.com_img:SetActive(true)

				self._boss_select_map_list[iter_22_3].boss_3.image.material = self:loadMaterial(var_0_6.common_icon.furniture_gray_material)
			end
		end

		if arg_22_4 then
			for iter_22_4 = 1, 4 do
				self._boss_select_map_list[iter_22_4].boss_4.com_img:SetActive(false)
			end
		else
			for iter_22_5 = 1, 4 do
				self._boss_select_map_list[iter_22_5].boss_4.com_img:SetActive(true)

				self._boss_select_map_list[iter_22_5].boss_4.image.material = self:loadMaterial(var_0_6.common_icon.furniture_gray_material)
			end
		end
	end

	function arg_1_0:_set_small_panel_img_2(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
		if arg_23_1 then
			for iter_23_0 = 1, 4 do
				self._boss_select_map_list[iter_23_0].boss_1.com_img:SetActive(false)
			end
		else
			for iter_23_1 = 1, 4 do
				self._boss_select_map_list[iter_23_1].boss_1.com_img:SetActive(true)

				self._boss_select_map_list[iter_23_1].boss_1.image.material = self:loadMaterial(var_0_6.common_icon.furniture_gray_material)
			end
		end

		if arg_23_3 then
			for iter_23_2 = 1, 4 do
				self._boss_select_map_list[iter_23_2].boss_3.com_img:SetActive(false)
			end
		else
			for iter_23_3 = 1, 4 do
				self._boss_select_map_list[iter_23_3].boss_3.com_img:SetActive(true)

				self._boss_select_map_list[iter_23_3].boss_3.image.material = self:loadMaterial(var_0_6.common_icon.furniture_gray_material)
			end
		end

		if arg_23_4 then
			for iter_23_4 = 1, 4 do
				self._boss_select_map_list[iter_23_4].boss_4.com_img:SetActive(false)
			end
		else
			for iter_23_5 = 1, 4 do
				self._boss_select_map_list[iter_23_5].boss_4.com_img:SetActive(true)

				self._boss_select_map_list[iter_23_5].boss_4.image.material = self:loadMaterial(var_0_6.common_icon.furniture_gray_material)
			end
		end
	end

	function arg_1_0:_set_small_panel_img_3(arg_24_1, arg_24_2, arg_24_3, arg_24_4)
		if arg_24_1 then
			for iter_24_0 = 1, 4 do
				self._boss_select_map_list[iter_24_0].boss_1.com_img:SetActive(false)
			end
		else
			for iter_24_1 = 1, 4 do
				self._boss_select_map_list[iter_24_1].boss_1.com_img:SetActive(true)

				self._boss_select_map_list[iter_24_1].boss_1.image.material = self:loadMaterial(var_0_6.common_icon.furniture_gray_material)
			end
		end

		if arg_24_2 then
			for iter_24_2 = 1, 4 do
				self._boss_select_map_list[iter_24_2].boss_2.com_img:SetActive(false)
			end
		else
			for iter_24_3 = 1, 4 do
				self._boss_select_map_list[iter_24_3].boss_2.com_img:SetActive(true)

				self._boss_select_map_list[iter_24_3].boss_2.image.material = self:loadMaterial(var_0_6.common_icon.furniture_gray_material)
			end
		end

		if arg_24_4 then
			for iter_24_4 = 1, 4 do
				self._boss_select_map_list[iter_24_4].boss_4.com_img:SetActive(false)
			end
		else
			for iter_24_5 = 1, 4 do
				self._boss_select_map_list[iter_24_5].boss_4.com_img:SetActive(true)

				self._boss_select_map_list[iter_24_5].boss_4.image.material = self:loadMaterial(var_0_6.common_icon.furniture_gray_material)
			end
		end
	end

	function arg_1_0:_set_small_panel_img_4(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
		if arg_25_1 then
			for iter_25_0 = 1, 4 do
				self._boss_select_map_list[iter_25_0].boss_1.com_img:SetActive(false)
			end
		else
			for iter_25_1 = 1, 4 do
				self._boss_select_map_list[iter_25_1].boss_1.com_img:SetActive(true)

				self._boss_select_map_list[iter_25_1].boss_1.image.material = self:loadMaterial(var_0_6.common_icon.furniture_gray_material)
			end
		end

		if arg_25_2 then
			for iter_25_2 = 1, 4 do
				self._boss_select_map_list[iter_25_2].boss_2.com_img:SetActive(false)
			end
		else
			for iter_25_3 = 1, 4 do
				self._boss_select_map_list[iter_25_3].boss_2.com_img:SetActive(true)

				self._boss_select_map_list[iter_25_3].boss_2.image.material = self:loadMaterial(var_0_6.common_icon.furniture_gray_material)
			end
		end

		if arg_25_3 then
			for iter_25_4 = 1, 4 do
				self._boss_select_map_list[iter_25_4].boss_3.com_img:SetActive(false)
			end
		else
			for iter_25_5 = 1, 4 do
				self._boss_select_map_list[iter_25_5].boss_3.com_img:SetActive(true)

				self._boss_select_map_list[iter_25_5].boss_3.image.material = self:loadMaterial(var_0_6.common_icon.furniture_gray_material)
			end
		end
	end

	function arg_1_0._set_toggle_btn(arg_26_0, arg_26_1, arg_26_2)
		return
	end

	function arg_1_0:__onClick_map_preview_map_bg_lock_bg_lock_icon()
		if self._map_debuff and next(self._map_debuff) then
			self._control.map_preview.map_bg.info_bg:SetActive(true)

			self._control.map_preview.map_bg.info_bg.buff_name.text.text = self._map_debuff.title
			self._control.map_preview.map_bg.info_bg.info_text.text.text = var_0_3.convert_rich_text(self._map_debuff.desc2)
		end
	end

	function arg_1_0:__onClick_map_preview_map_boss_bg_close_btn()
		self._control.map_preview:SetActive(false)
		self._control.mask_image_bg:SetActive(false)
		self:__hide_all_mini_map_fragment_to_pool()
		self:__destroy_pool()
		self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.back))
	end

	function arg_1_0.__onClick_map_preview_map_boss_bg_point_bg_point_icon_1(arg_29_0)
		return
	end

	function arg_1_0.__onClick_map_preview_map_boss_bg_point_bg_point_icon_2(arg_30_0)
		return
	end

	function arg_1_0.__onClick_map_preview_map_boss_bg_point_bg_point_icon_3(arg_31_0)
		return
	end

	function arg_1_0.__onClick_map_preview_map_boss_bg_point_bg_point_icon_4(arg_32_0)
		return
	end

	function arg_1_0:__onToggle_map_preview_map_boss_bg_func_toggle_toggle1()
		self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.task_goto))

		if var_0_1:ninth_map_is_pass(self._active_config.levels[5]) then
			if var_0_1:ninth_map_is_pass(self._ninth_hard_map_data[1].map_id) then
				var_0_1:set_ninth_map_start_point(self._ninth_hard_map_data[5].init_nodes[1])
				self:show_boss_toggle_panel(true, 1)
				self._boss_select_map_list[1].boss_1.com_img:SetActive(true)
				self._boss_select_map_list[1].boss_2.com_img:SetActive(false)
				self._boss_select_map_list[1].boss_3.com_img:SetActive(false)
				self._boss_select_map_list[1].boss_4.com_img:SetActive(false)
				var_0_1:set_ninth_active_common_num({
					is_hard = true,
					stage = 1
				})

				local var_33_1, var_33_2, var_33_3, var_33_4 = self:show_pass_list()

				self:_set_small_panel_img_1(var_33_1, var_33_2, var_33_3, var_33_4)
				self:show_small_boss_panel_map(1)
			else
				local var_33_5 = var_0_10.find_object_by_id(self._ninth_hard_map_data[5].map_id)

				if var_33_5 and next(var_33_5) then
					var_0_2:show(var_33_5.nodes_desc[1])
				end
			end
		elseif var_0_1:ninth_map_is_pass(self._ninth_normal_map_data[1].map_id) then
			var_0_1:set_ninth_map_start_point(self._ninth_normal_map_data[5].init_nodes[1])
			self:show_boss_toggle_panel(true, 1)
			self._boss_select_map_list[1].boss_1.com_img:SetActive(true)
			self._boss_select_map_list[1].boss_2.com_img:SetActive(false)
			self._boss_select_map_list[1].boss_3.com_img:SetActive(false)
			self._boss_select_map_list[1].boss_4.com_img:SetActive(false)
			var_0_1:set_ninth_active_common_num({
				is_hard = false,
				stage = 1
			})

			local var_33_7, var_33_8, var_33_9, var_33_10 = self:show_pass_list()

			self:_set_small_panel_img_1(var_33_7, var_33_8, var_33_9, var_33_10)
			self:show_small_boss_panel_map(1)
		else
			local var_33_11 = var_0_10.find_object_by_id(self._ninth_normal_map_data[5].map_id)

			if var_33_11 and next(var_33_11) then
				var_0_2:show(var_33_11.nodes_desc[1])
			end
		end
	end

	function arg_1_0:__onToggle_map_preview_map_boss_bg_func_toggle_toggle2()
		self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.task_goto))

		if var_0_1:ninth_map_is_pass(self._active_config.levels[5]) then
			if var_0_1:ninth_map_is_pass(self._ninth_hard_map_data[2].map_id) then
				var_0_1:set_ninth_map_start_point(self._ninth_hard_map_data[5].init_nodes[2])
				self:show_boss_toggle_panel(true, 2)
				self._boss_select_map_list[2].boss_1.com_img:SetActive(false)
				self._boss_select_map_list[2].boss_2.com_img:SetActive(true)
				self._boss_select_map_list[2].boss_3.com_img:SetActive(false)
				self._boss_select_map_list[2].boss_4.com_img:SetActive(false)
				var_0_1:set_ninth_active_common_num({
					is_hard = true,
					stage = 2
				})

				local var_34_1, var_34_2, var_34_3, var_34_4 = self:show_pass_list()

				self:_set_small_panel_img_2(var_34_1, var_34_2, var_34_3, var_34_4)
				self:show_small_boss_panel_map(2)
			else
				local var_34_5 = var_0_10.find_object_by_id(self._ninth_hard_map_data[5].map_id)

				if var_34_5 and next(var_34_5) then
					var_0_2:show(var_34_5.nodes_desc[2])
				end
			end
		elseif var_0_1:ninth_map_is_pass(self._ninth_normal_map_data[2].map_id) then
			var_0_1:set_ninth_map_start_point(self._ninth_normal_map_data[5].init_nodes[2])
			self:show_boss_toggle_panel(true, 2)
			self._boss_select_map_list[2].boss_1.com_img:SetActive(false)
			self._boss_select_map_list[2].boss_2.com_img:SetActive(true)
			self._boss_select_map_list[2].boss_3.com_img:SetActive(false)
			self._boss_select_map_list[2].boss_4.com_img:SetActive(false)
			var_0_1:set_ninth_active_common_num({
				is_hard = false,
				stage = 2
			})

			local var_34_7, var_34_8, var_34_9, var_34_10 = self:show_pass_list()

			self:_set_small_panel_img_2(var_34_7, var_34_8, var_34_9, var_34_10)
			self:show_small_boss_panel_map(2)
		else
			local var_34_11 = var_0_10.find_object_by_id(self._ninth_normal_map_data[5].map_id)

			if var_34_11 and next(var_34_11) then
				var_0_2:show(var_34_11.nodes_desc[2])
			end
		end
	end

	function arg_1_0:__onToggle_map_preview_map_boss_bg_func_toggle_toggle3()
		self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.task_goto))

		if var_0_1:ninth_map_is_pass(self._active_config.levels[5]) then
			if var_0_1:ninth_map_is_pass(self._ninth_hard_map_data[3].map_id) then
				var_0_1:set_ninth_map_start_point(self._ninth_hard_map_data[5].init_nodes[3])
				self:show_boss_toggle_panel(true, 3)
				self._boss_select_map_list[3].boss_1.com_img:SetActive(false)
				self._boss_select_map_list[3].boss_2.com_img:SetActive(false)
				self._boss_select_map_list[3].boss_3.com_img:SetActive(true)
				self._boss_select_map_list[3].boss_4.com_img:SetActive(false)
				var_0_1:set_ninth_active_common_num({
					is_hard = true,
					stage = 3
				})

				local var_35_1, var_35_2, var_35_3, var_35_4 = self:show_pass_list()

				self:_set_small_panel_img_3(var_35_1, var_35_2, var_35_3, var_35_4)
				self:show_small_boss_panel_map(3)
			else
				local var_35_5 = var_0_10.find_object_by_id(self._ninth_hard_map_data[5].map_id)

				if var_35_5 and next(var_35_5) then
					var_0_2:show(var_35_5.nodes_desc[3])
				end
			end
		elseif var_0_1:ninth_map_is_pass(self._ninth_normal_map_data[3].map_id) then
			var_0_1:set_ninth_map_start_point(self._ninth_normal_map_data[5].init_nodes[3])
			self:show_boss_toggle_panel(true, 3)
			self._boss_select_map_list[3].boss_1.com_img:SetActive(false)
			self._boss_select_map_list[3].boss_2.com_img:SetActive(false)
			self._boss_select_map_list[3].boss_3.com_img:SetActive(true)
			self._boss_select_map_list[3].boss_4.com_img:SetActive(false)
			var_0_1:set_ninth_active_common_num({
				is_hard = false,
				stage = 3
			})

			local var_35_7, var_35_8, var_35_9, var_35_10 = self:show_pass_list()

			self:_set_small_panel_img_3(var_35_7, var_35_8, var_35_9, var_35_10)
			self:show_small_boss_panel_map(3)
		else
			local var_35_11 = var_0_10.find_object_by_id(self._ninth_normal_map_data[5].map_id)

			if var_35_11 and next(var_35_11) then
				var_0_2:show(var_35_11.nodes_desc[3])
			end
		end
	end

	function arg_1_0:__onToggle_map_preview_map_boss_bg_func_toggle_toggle4()
		self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.task_goto))

		if var_0_1:ninth_map_is_pass(self._active_config.levels[5]) then
			if var_0_1:ninth_map_is_pass(self._ninth_hard_map_data[4].map_id) then
				var_0_1:set_ninth_map_start_point(self._ninth_hard_map_data[5].init_nodes[4])
				self:show_boss_toggle_panel(true, 4)
				self._boss_select_map_list[4].boss_1.com_img:SetActive(false)
				self._boss_select_map_list[4].boss_2.com_img:SetActive(false)
				self._boss_select_map_list[4].boss_3.com_img:SetActive(false)
				self._boss_select_map_list[4].boss_4.com_img:SetActive(true)
				var_0_1:set_ninth_active_common_num({
					is_hard = true,
					stage = 4
				})

				local var_36_1 = var_0_1:ninth_map_is_pass(self._active_config.levels[5])
				local var_36_2, var_36_3, var_36_4, var_36_5 = self:show_pass_list()

				self:_set_small_panel_img_4(var_36_2, var_36_3, var_36_4, var_36_5)
				self:show_small_boss_panel_map(4)
			else
				local var_36_6 = var_0_10.find_object_by_id(self._ninth_hard_map_data[5].map_id)

				if var_36_6 and next(var_36_6) then
					var_0_2:show(var_36_6.nodes_desc[4])
				end
			end
		elseif var_0_1:ninth_map_is_pass(self._ninth_normal_map_data[4].map_id) then
			var_0_1:set_ninth_map_start_point(self._ninth_normal_map_data[5].init_nodes[4])
			self:show_boss_toggle_panel(true, 4)
			self._boss_select_map_list[4].boss_1.com_img:SetActive(false)
			self._boss_select_map_list[4].boss_2.com_img:SetActive(false)
			self._boss_select_map_list[4].boss_3.com_img:SetActive(false)
			self._boss_select_map_list[4].boss_4.com_img:SetActive(true)
			var_0_1:set_ninth_active_common_num({
				is_hard = false,
				stage = 4
			})

			local var_36_8, var_36_9, var_36_10, var_36_11 = self:show_pass_list()

			self:_set_small_panel_img_4(var_36_8, var_36_9, var_36_10, var_36_11)
			self:show_small_boss_panel_map(4)
		else
			local var_36_12 = var_0_10.find_object_by_id(self._ninth_normal_map_data[5].map_id)

			if var_36_12 and next(var_36_12) then
				var_0_2:show(var_36_12.nodes_desc[4])
			end
		end
	end

	function arg_1_0:show_pass_list()
		local var_37_0
		local var_37_1
		local var_37_2
		local var_37_3

		if not var_0_1:ninth_map_is_pass(self._active_config.levels[5]) then
			var_37_0 = var_0_1:ninth_map_is_pass(self._active_config.levels[1])
			var_37_1 = var_0_1:ninth_map_is_pass(self._active_config.levels[2])
			var_37_2 = var_0_1:ninth_map_is_pass(self._active_config.levels[3])
			var_37_3 = var_0_1:ninth_map_is_pass(self._active_config.levels[4])
		else
			var_37_0 = var_0_1:ninth_map_is_pass(self._active_config.hardLevels[1])
			var_37_1 = var_0_1:ninth_map_is_pass(self._active_config.hardLevels[2])
			var_37_2 = var_0_1:ninth_map_is_pass(self._active_config.hardLevels[3])
			var_37_3 = var_0_1:ninth_map_is_pass(self._active_config.hardLevels[4])
		end

		return var_37_0, var_37_1, var_37_2, var_37_3
	end

	function arg_1_0:_is_pass_normal()
		local var_38_0 = {}

		if self._ninth_normal_map_data and next(self._ninth_normal_map_data) then
			for iter_38_0, iter_38_1 in ipairs(self._ninth_normal_map_data) do
				if var_0_1:ninth_map_is_pass(iter_38_1.id) then
					table.insert(var_38_0, iter_38_1)
				end
			end
		end

		return var_38_0
	end

	function arg_1_0:show_boss_toggle_panel(arg_39_1, arg_39_2)
		for iter_39_0, iter_39_1 in pairs(self._boss_map_list) do
			if iter_39_0 == arg_39_2 then
				self._boss_map_list[iter_39_0]:SetActive(arg_39_1)
			else
				self._boss_map_list[iter_39_0]:SetActive(not arg_39_1)
			end
		end

		for iter_39_2, iter_39_3 in ipairs(self._boss_select_map_list) do
			if iter_39_2 == arg_39_2 then
				self._boss_select_map_list[iter_39_2]:SetActive(arg_39_1)
			else
				self._boss_select_map_list[iter_39_2]:SetActive(not arg_39_1)
			end
		end
	end

	function arg_1_0:__onClick_map_preview_map_boss_bg_confirm_btn()
		local var_40_0 = var_0_5:getInstance("fight_prepare")

		self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.begin_to_fight))
		var_0_1:reset_ninth_push_info_pass()

		if self._is_hard then
			self:all_pass_hard_map_list()
		else
			self:all_pass_easy_map_list()
		end

		local var_40_1 = {
			ninth_active_config = self._active_config,
			fight_prepare_type = var_0_6.fight_type.ninth_attack,
			go_to_map_id = self.map_fight_id
		}

		for iter_40_0, iter_40_1 in pairs((var_0_1:get_ninth_map_data())) do
			if iter_40_1.id == self.map_fight_id then
				var_0_1:set_ninth_boss_hp_info(iter_40_1.hp)
			end
		end

		self:setVisible(false)

		if var_40_0 then
			var_40_0:show(var_40_1)
		else
			var_0_5:createInstance("fight_prepare"):show(var_40_1)
		end

		var_0_1:set_ninth_fight_cam(self.map_fight_id, nil, nil)
	end

	function arg_1_0:__onClick_buff_btn()
		self:setVisible(false)

		local var_41_0 = var_0_5:getInstance("ninth_cia")

		if var_41_0 then
			var_41_0:reset_init()
			var_41_0:show()
		else
			var_0_5:createInstance("ninth_cia"):show()
		end
	end

	function arg_1_0:__onClick_map_preview_map_boss_bg_lock_bg_lock_icon()
		if self._map_debuff and next(self._map_debuff) then
			self._control.map_preview.map_boss_bg.info_bg:SetActive(true)

			self._control.map_preview.map_boss_bg.info_bg.buff_name.text.text = self._map_debuff.title
			self._control.map_preview.map_boss_bg.info_bg.info_text.text.text = var_0_3.convert_rich_text(self._map_debuff.desc2)
		end
	end

	function arg_1_0:__onClick_map_preview_map_bg_drop_available()
		local var_43_0 = var_0_5:getInstance("ship_available")
		local var_43_1 = gameconfig.drop_available_config.find_object_by_pve_id(self.map_fight_id)

		if var_43_0 then
			var_43_0:show(var_0_6.go_to_ship_available.main_go, var_43_1)
		else
			var_0_5:createInstance("ship_available"):show(var_0_6.go_to_ship_available.main_go, var_43_1)
		end
	end

	function arg_1_0:__onClick_map_preview_map_boss_bg_drop_available()
		local var_44_0 = var_0_5:getInstance("ship_available")
		local var_44_1 = gameconfig.drop_available_config.find_object_by_pve_id(self.map_fight_id)

		if var_44_0 then
			var_44_0:show(var_0_6.go_to_ship_available.main_go, var_44_1)
		else
			var_0_5:createInstance("ship_available"):show(var_0_6.go_to_ship_available.main_go, var_44_1)
		end
	end
end

function var_0_0.extend_obj(arg_45_0)
	return
end

return var_0_0
