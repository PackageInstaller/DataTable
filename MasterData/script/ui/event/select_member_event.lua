local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.prompt
local var_0_3 = gamecore.UILoader
local var_0_4 = gamecore.Language
local var_0_5 = gamecore.util_func
local var_0_6 = gameenum.common_type
local var_0_7 = gameconfig.ship_config
local var_0_8 = gameconfig.sixth_map_config
local var_0_9 = table.insert

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg_container_back_btn()
		var_0_1:set_all_select_member_list()

		if self._is_custom_formation then
			self._panel_type = 0

			self:_set_custom_ship_info()
			self:__onClick_all_ship_info_custom_ship_2()
			self:_init_select_member_button_postion()

			return
		end

		self._panel_type = 0
		self._temporary_data = {}
		self._is_choiced_num = 0

		self:setVisible(false)
		self:after_close_select_member(true)

		self._is_already_fast_init = false
		self._is_already_custom_init = false
		self._is_custom_formation = false
		self._team_data = {}

		if self._enter_type == var_0_6.enter_select_member_type.dock_disassemble then
			self._ships_for_dock_disassemble_id_list = {}
			self._is_fast_formation = true

			local var_2_0 = var_0_3:getInstance("dock")

			if var_2_0 then
				var_2_0:__update_reusable_cell_4()
			end
		elseif self._enter_type == var_0_6.enter_select_member_type.restaurant then
			local var_2_1 = var_0_3:getInstance("restaurant_setting")

			if not var_2_1 then
				return
			end

			var_2_1:setVisible(true)

			return
		elseif self._enter_type == var_0_6.enter_select_member_type.college then
			local var_2_2 = var_0_3:getInstance("select_tactis_view")

			if not var_2_2 then
				return
			end

			var_2_2:update_school_panel_state()
		elseif self._enter_type == var_0_6.enter_select_member_type.captainroom_fleet then
			local var_2_3 = var_0_3:getInstance("captainroom_fleet")

			if not var_2_3 then
				return
			end

			var_2_3:show_layer(true)

			return
		elseif self._enter_type == var_0_6.enter_select_member_type.dormitory then
			local var_2_4 = var_0_3:getInstance("dormitory")

			if var_2_4 then
				var_2_4:setVisible(true)
				var_2_4:toggle_canvas_render_mode(true)
				var_2_4:set_special_sortingOrder()
				var_2_4:check_need_update()
			end

			return
		elseif self._enter_type == var_0_6.enter_select_member_type.six_year_primary then
			local var_2_5 = var_0_3:getInstance("six_year_main_interface")

			if not var_2_5 then
				return
			end

			var_2_5:setVisible(true)
			var_0_3:destroyInstance("equip_list")

			return
		elseif self._enter_type == var_0_6.enter_select_member_type.strengthen then
			local var_2_6 = var_0_3:getInstance("remake")

			if not var_2_6 then
				return
			end

			var_2_6:setVisible(true)

			return
		elseif self._enter_type == var_0_6.enter_select_member_type.strengthen_res then
			self._detail_index = var_0_6.dock_detail_layer.once

			self:__set_fast_btn_switch(false)

			local var_2_7 = var_0_3:getInstance("remake")

			if not var_2_7 then
				return
			end

			var_2_7:setVisible(true)

			return
		elseif self._enter_type == var_0_6.enter_select_member_type.skill then
			self._detail_index = var_0_6.dock_detail_layer.once

			local var_2_8 = var_0_3:getInstance("remake")

			if not var_2_8 then
				return
			end

			var_2_8:setVisible(true)

			return
		elseif self._enter_type == var_0_6.enter_select_member_type.pre_formation then
			local var_2_9 = var_0_3:getInstance("dock_team")

			if var_2_9 then
				var_2_9:setVisible(false)
			end

			local var_2_10 = var_0_3:getInstance("pre_formation")

			if not var_2_10 then
				return
			end

			var_2_10:setVisible(true)

			return
		elseif self._enter_type == var_0_6.enter_select_member_type.research_ship then
			local var_2_11 = var_0_3:getInstance("research_development")
			local var_2_12 = var_0_3:getInstance("select_member")

			if var_2_12 then
				var_2_12:setVisible(false)
			end

			if var_2_11 then
				var_2_11:setVisible(true)
			end

			return
		elseif self._enter_type == var_0_6.enter_select_member_type.secretary_info_ship then
			local var_2_13 = var_0_3:getInstance("ship_clerk_prepare")
			local var_2_14 = var_0_3:getInstance("select_member")

			if var_2_14 then
				var_2_14:setVisible(false)
			end

			if var_2_13 then
				var_2_13:setVisible(true)
			end

			return
		elseif self._enter_type == var_0_6.enter_select_member_type.restaurant_show_type then
			if self._sort_layer and var_0_1:get_cook_common_state() then
				self._sort_layer._sort_type_state = 1
				self._sort_layer._now_select_sort_layer_num = 19

				self._sort_layer:reset_tactics_select_state()
				self._sort_layer:set_select_panel(19)
				self._sort_layer:reset_cook_select_state()
				self._sort_layer:select_sort_down_19()
			end

			local var_2_15 = var_0_3:getInstance("restaurant_type_layer")

			if var_2_15 then
				var_2_15:show()
			end
		else
			self._is_fast_formation = false
			self._is_custom_formation = false
			self._detail_index = var_0_6.dock_detail_layer.once

			self:__set_fast_btn_switch(false)

			local var_2_16 = var_0_3:getInstance("dock_team")

			if var_2_16 then
				var_2_16:setVisible(true)
				var_2_16:update_content(var_0_6.dock_team_toggle_type.formation, var_2_16._current_team_index or 1)
			end

			local var_2_17 = var_0_3:getInstance("fight_prepare")

			if var_2_17 then
				var_2_17:setVisible(true)
			end
		end
	end

	function arg_1_0:__onClick_fast_btn()
		self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.task_goto))

		self._is_fast_formation = not self._is_fast_formation

		self._control.confirm_btn:SetActive(self._is_fast_formation)
		self:__set_fast_btn_switch(self._is_fast_formation)
		self:update_content()

		self._is_already_fast_init = self._is_fast_formation
	end

	function arg_1_0:__onClick_detail_btn()
		if self._is_nf then
			if not next(var_0_1:get_mist_combat_info().ship) then
				return
			end

			self:__change_mist_info_detail()

			return
		else
			self._detail_index = self._detail_index + 1

			if self._enter_type == var_0_6.enter_select_member_type.strengthen_res then
				if self._detail_index <= var_0_6.dock_detail_layer.second then
					self._detail_index = self._detail_index or var_0_6.dock_detail_layer.once
				end
			elseif self._detail_index <= var_0_6.dock_detail_layer.fourth then
				self._detail_index = self._detail_index or var_0_6.dock_detail_layer.once
			end

			self:__change_info_list_detail()
		end
	end

	function arg_1_0:__onClick_sort_order_btn()
		self._sort_layer = self._sort_layer or self:loadUI("sort_layer_2")

		if var_0_1:get_cook_common_state() then
			self._sort_layer._sort_type_state = 1
			self._sort_layer._now_select_sort_layer_num = 19

			self._sort_layer:reset_tactics_select_state()
			self._sort_layer:set_select_panel(19)
			self._sort_layer:reset_cook_select_state()
			self._sort_layer:select_sort_down_19()
		end

		self._sort_layer:setVisible(true)
	end

	function arg_1_0:__onClick_sort_type_btn()
		self:get_type_layer()
		self._type_layer:show(true)
	end

	function arg_1_0:ship_have_max_level()
		if self._ships_for_dock_research_ship_id_list and #self._ships_for_dock_research_ship_id_list >= 1 then
			for iter_7_0, iter_7_1 in pairs(self._ships_for_dock_research_ship_id_list) do
				if var_0_1:find_character_by_id(iter_7_1).level == var_0_6.ship_max_level then
					return true
				end
			end
		end
	end

	function arg_1_0:ship_have_evo_ship()
		if self._ships_for_dock_research_ship_id_list and #self._ships_for_dock_research_ship_id_list >= 1 then
			for iter_8_0, iter_8_1 in pairs(self._ships_for_dock_research_ship_id_list) do
				if var_0_7.find_object_by_cid(var_0_1:find_character_by_id(iter_8_1).cid).evo_class then
					return true
				end
			end
		end
	end

	function arg_1_0:__onClick_confirm_btn()
		local var_9_0 = var_0_5.check_team_if_has_member(self._team_data)
		local var_9_2 = (self._enter_type ~= var_0_6.enter_select_member_type.dock_disassemble and self._enter_type ~= var_0_6.enter_select_member_type.strengthen and self._enter_type ~= var_0_6.enter_select_member_type.strengthen_res and self._enter_type ~= var_0_6.enter_select_member_type.research_ship and self._enter_type ~= var_0_6.enter_select_member_type.strike_map_select and self._enter_type ~= var_0_6.enter_select_member_type.six_year_primary and self._enter_type ~= var_0_6.enter_select_member_type.six_year_map_select or nil) and var_0_1:get_team_data(1, self._team_index)

		if var_9_2 and var_9_2.station and self._enter_type ~= var_0_6.enter_select_member_type.secretary_info_ship then
			self._is_already_fast_init = false

			self:setVisible(false)
			self:after_close_select_member()
			var_0_2:show(var_0_4:getNowLang("guard_tip"))

			return
		end

		if not var_9_0 then
			if (self._enter_type == var_0_6.enter_select_member_type.dock_team or self._enter_type == var_0_6.enter_select_member_type.fight or self._enter_type == var_0_6.enter_select_member_type.tower or nil) and self._team_index and self._team_index == 1 then
				var_0_2:show(var_0_4:getNowLang("needflagshipinfleet"))

				return
			end
		end

		self._is_already_fast_init = false

		self:after_close_select_member()

		if self._enter_type == var_0_6.enter_select_member_type.dock_disassemble then
			local var_9_4 = var_0_3:getInstance("dock")

			if var_9_4 then
				if self._ships_for_dock_disassemble_id_list then
					var_9_4:set_disassemble_data(self._ships_for_dock_disassemble_id_list)
				end

				self:__onClick_bg_container_back_btn()
			end
		elseif self._enter_type == var_0_6.enter_select_member_type.strengthen_res then
			local var_9_5 = var_0_3:getInstance("remake")

			if var_9_5 then
				if self._ships_for_remould_id_list then
					var_9_5:set_strength_res_data(self._ships_for_remould_id_list)
				end

				self:__onClick_bg_container_back_btn()
			end
		elseif self._enter_type == var_0_6.enter_select_member_type.research_ship then
			local function var_9_8()
				local var_10_0 = var_0_3:getInstance("research_development")

				if var_10_0 then
					local var_10_1 = {}

					for iter_10_0 = 1, #self._ships_for_dock_research_ship_id_list do
						table.insert(var_10_1, {
							num = 1,
							cid = self._ships_for_dock_research_ship_id_list[iter_10_0]
						})
					end

					local var_10_2 = {}

					for iter_10_1, iter_10_2 in pairs(var_10_1) do
						table.insert(var_10_2, var_0_1:find_character_by_id(iter_10_2.cid).lock)
					end

					if var_0_5.have_data(var_10_2, true) then
						self:__onClick_bg_container_back_btn()
						var_0_2:show(var_0_4:getNowLang("errorcode-320"))
					else
						var_0_1:req_ResearchTaskSubmitReq(var_10_0._now_ship_id, var_10_0.start_type, var_10_1)
					end
				end

				self:__onClick_bg_container_back_btn()
			end

			if self:ship_have_max_level() then
				var_0_3:createInstance("msgbox"):show(var_0_4:getNowLang("submit_level_max"), var_9_8, nil, var_0_4:getNowLang("submit_confirm"))
			elseif self:ship_have_evo_ship() then
				var_0_3:createInstance("msgbox"):show(var_0_4:getNowLang("submit_remake"), var_9_8, nil, var_0_4:getNowLang("submit_confirm"))
			else
				local var_9_9 = var_0_3:getInstance("research_development")

				if var_9_9 then
					local var_9_10 = {}

					for iter_9_0 = 1, #self._ships_for_dock_research_ship_id_list do
						table.insert(var_9_10, {
							num = 1,
							cid = self._ships_for_dock_research_ship_id_list[iter_9_0]
						})
					end

					var_0_3:createInstance("msgbox"):show(var_0_4:getNowLang("submit_ship"), function()
						local var_11_0 = {}

						for iter_11_0, iter_11_1 in pairs(var_9_10) do
							table.insert(var_11_0, var_0_1:find_character_by_id(iter_11_1.cid).lock)
						end

						if var_0_5.have_data(var_11_0, true) then
							self:__onClick_bg_container_back_btn()
							var_0_2:show(var_0_4:getNowLang("errorcode-320"))
						else
							var_0_1:req_ResearchTaskSubmitReq(var_9_9._now_ship_id, var_9_9.start_type, var_9_10)
							self:__onClick_bg_container_back_btn()
						end
					end, nil, var_0_4:getNowLang("submit_confirm"))
				end
			end
		elseif self._enter_type == var_0_6.enter_select_member_type.restaurant then
			self:setVisible(false)
			self:after_close_select_member()
			var_0_3:getInstance("restaurant_setting"):setVisible(true)
		elseif self._enter_type == var_0_6.enter_select_member_type.captainroom_fleet then
			self:setVisible(false)
			var_0_3:getInstance("captainroom_fleet"):select_ship_req(self._team_data)

			return
		elseif self._enter_type == var_0_6.enter_select_member_type.dormitory then
			local var_9_11 = var_0_3:getInstance("dormitory")

			var_9_11:select_ship_req(self._team_data)
			var_9_11:toggle_canvas_render_mode(true)
		elseif self._enter_type == var_0_6.enter_select_member_type.six_year_primary then
			self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.open))

			if self._is_nf then
				if self._team_data < 20 then
					var_0_2:show(var_0_4:getNowLang("ship_incorrect_quantity"))
				end
			elseif self._small_ship_count < self._shipton_num_small or self._middle_ship_count < self._shipton_num_middle or self._big_ship_count < self._shipton_num_big then
				var_0_2:show(var_0_4:getNowLang("ship_incorrect_quantity"))

				return
			end

			local var_9_12 = var_0_3:getInstance("six_year_main_interface")

			if var_9_12._bigmap_info.state == 1 then
				local var_9_13 = var_0_8.find_object_by_id(self._map_id)

				if var_9_13 then
					var_0_1:req_EnterSixthBigMapReq(var_9_13.level_id, self._team_data)
					self:setVisible(false)
					self:after_close_select_member()
				end
			elseif var_9_12._bigmap_info.state ~= 1 and var_9_12._initial_ticket ~= 0 then
				local var_9_14 = var_0_8.find_object_by_id(self._map_id)

				if var_9_14 then
					var_0_1:req_EnterSixthBigMapReq(var_9_14.level_id, self._team_data)
					self:setVisible(false)
				end

				self:setVisible(false)
				self:after_close_select_member()
			else
				local var_9_15 = var_0_8.find_object_by_id(self._map_id)

				if var_9_15 then
					var_0_1:req_EnterSixthBigMapReq(var_9_15.level_id, self._team_data)
					self:setVisible(false)
					self:after_close_select_member()
				end
			end
		elseif self._enter_type == var_0_6.enter_select_member_type.ocean_attack_map_select then
			var_0_1:req_OceanSaveTeamReq(self._team_data)
			var_0_3:destroyInstance("select_member")
		elseif self._enter_type == var_0_6.enter_select_member_type.fight then
			var_0_3:createInstance("fight_prepare"):__save_team_all_info(self._team_data)
			self:setVisible(false)
			self:after_close_select_member()
		elseif self._enter_type == var_0_6.enter_select_member_type.six_year_map_select then
			var_0_1:req_SixthTeamSaveReq(self._team_data)
			var_0_3:destroyInstance("select_member")
		elseif self._enter_type == var_0_6.enter_select_member_type.strike_map_select then
			var_0_1:req_SolidSaveTeamReq(self._team_data)
			var_0_3:destroyInstance("select_member")
		elseif self._enter_type == var_0_6.enter_select_member_type.tower then
			local var_9_16 = var_0_3:getInstance("fight_prepare")

			if var_9_16 and not var_9_16:save_team_info_all(self._team_data) then
				var_0_2:show(var_0_4:getNowLang("needflagshipinfleet"))
			end

			var_0_3:destroyInstance("select_member")
		elseif self._enter_type == var_0_6.enter_select_member_type.pre_formation then
			if not self._team_data then
				return
			end

			local var_9_17 = var_0_3:getInstance("pre_formation")

			if var_9_17 then
				var_9_17:setVisible(true)
				var_9_17:save_team_info_all(self._team_data, nil)
			end

			var_0_3:destroyInstance("select_member")
		elseif self._enter_type == var_0_6.enter_select_member_type.abyss_dock_team_formation then
			if not self._team_data then
				return
			end

			var_0_1:req_AbyssSaveTeamReq(self._team_data)
			var_0_3:destroyInstance("select_member")
		elseif self._enter_type == var_0_6.enter_select_member_type.secretary_info_ship then
			if not self._team_data then
				return
			end

			local var_9_18 = {}

			for iter_9_1, iter_9_2 in pairs(self._team_data) do
				var_0_9(var_9_18, iter_9_2)
			end

			var_0_1:req_ChangeSecretaryDataReq(var_9_18)
			var_0_3:destroyInstance("select_member")
			var_0_3:getInstance("ship_clerk_prepare"):setVisible(true)
		else
			local var_9_19 = var_0_3:createInstance("dock_team")

			if var_9_19 then
				if var_9_19:save_team_info_all(self._team_data) then
					self:__onClick_bg_container_back_btn()
				else
					var_0_2:show(var_0_4:getNowLang("pre_formation_cannot_use"))
				end
			end
		end
	end

	function arg_1_0:__onClick_full_strengthen_btn()
		self._full_strengthen_flag = not self._full_strengthen_flag

		self:__show_or_hide_full_strengthen()
	end

	function arg_1_0:__onClick_full_skill_btn()
		self._full_skill_flag = not self._full_skill_flag

		self:__show_or_hide_full_skill()
	end

	function arg_1_0:__onClick_auto_btn()
		if self._is_choiced_num == 0 then
			self._team_data = {}

			self:__auto_select_sixth_team()

			self._is_choiced_num = 1
		else
			self._team_data = {}

			self:__auto_select_sixth_team()
		end
	end

	function arg_1_0:__onScaleButtonClick_bg_container_back_btn()
		self:__onClick_bg_container_back_btn()
	end

	function arg_1_0:__onClick_confirm_fast_btn()
		self:__onClick_clearall_fast_btn()

		self._select_state = 1
		self._dock_disassemble_team = {}
		self._dock_disassemble_team = lx.clone_table(self._all_panel_disassemble_info)

		for iter_16_0, iter_16_1 in pairs(self._dock_disassemble_team) do
			self:update_fast_team_index(iter_16_1, var_0_6.max_select_type.two_hundred, true)
		end
	end

	function arg_1_0:__onClick_clearall_fast_btn()
		self._select_state = 2

		if self._all_panel_disassemble_info and #self._all_panel_disassemble_info > 0 then
			self._dock_disassemble_team = lx.clone_table(self._all_panel_disassemble_info)
		else
			return
		end

		if self._dock_disassemble_team and next(self._dock_disassemble_team) then
			for iter_17_0, iter_17_1 in pairs(self._dock_disassemble_team) do
				self:update_fast_team_index(iter_17_1, var_0_6.max_select_type.two_hundred, true)
			end
		end

		self._ships_for_dock_disassemble_id_list = {}
	end

	function arg_1_0.__onClick_all_ship_info_all_ship_btn(arg_18_0)
		return
	end

	function arg_1_0:__onClick_all_ship_info_custom_ship_btn()
		self:__onClick_all_ship_info_all_ship_btn_txt_all_ship_2_btn()
	end

	function arg_1_0:__onClick_custom_editor_btn()
		if self._enter_type == var_0_6.enter_select_member_type.research_ship then
			return
		end

		if self._is_fast_formation then
			var_0_2:show(var_0_4:getNowLang("custom_busy"))

			return
		end

		self:init_custom_panel(true)

		self._is_custom_formation = true
		self._panel_type = var_0_6.enter_select_member_type.custom_ship

		self:set_iscustom_button_postion()

		self._iscustom_state = false

		self:update_content()
		self:set_select_ship_num()

		self._is_already_custom_init = true
	end

	function arg_1_0:init_custom_panel(arg_21_1)
		self._control.all_ship_info:SetActive(not arg_21_1)
		self._control.custom_ship_info:SetActive(arg_21_1)

		if self._enter_type == var_0_6.enter_select_member_type.evo or self._enter_type == var_0_6.enter_select_member_type.restaurant or self._enter_type == var_0_6.enter_select_member_type.college or self._enter_type == var_0_6.enter_select_member_type.fight and self._team_type == var_0_6.team_type.campaign or self._enter_type == var_0_6.enter_select_member_type.skill then
			self._control.fast_btn:SetActive(false)
		else
			self._control.fast_btn:SetActive(not arg_21_1)
		end

		self._control.custom_editor_btn:SetActive(false)
		self._control.cancel_editor_btn:SetActive(arg_21_1)
		self._control.comfirm_custom_btn:SetActive(arg_21_1)
		self._control.full_strengthen_btn:SetActive(false)
		self._control.full_skill_btn:SetActive(false)
		self._control.confirm_btn:SetActive(false)
	end

	function arg_1_0:__onClick_cancel_editor_btn()
		self._custom_team_data = {}
		self._is_already_custom_init = true
		self._is_clear_custom_select_ship = true

		self:__update_reusable_cell()

		self._control.custom_ship_info.custom_img.custom_num.text.text = 0 .. "/" .. var_0_6.max_select_type.two_hundred
		self._is_clear_custom_select_ship = false
	end

	function arg_1_0:__onClick_research_ship_info_research_confirm_fast_btn()
		local var_23_0 = var_0_1:get_need_research_ship_task_info().num - var_0_1:get_research_ship_select_ship_num()

		self:__onClick_research_ship_info_research_clearall_fast_btn()

		self._select_state = 1
		self._dock_research_ship_team = {}
		self._team_data = {}

		for iter_23_0, iter_23_1 in pairs(self._all_panel_research_ship_info) do
			self:update_fast_team_index(iter_23_1, var_23_0, true)
		end

		self:update_research_info()
	end

	function arg_1_0:__onClick_research_ship_info_research_clearall_fast_btn()
		self._select_state = 2

		if self._all_panel_research_ship_info and #self._all_panel_research_ship_info > 0 then
			self._dock_research_ship_team = lx.clone_table(self._all_panel_research_ship_info)
		else
			return
		end

		local var_24_0 = var_0_1:get_need_research_ship_task_info().num - var_0_1:get_research_ship_select_ship_num()

		if self._dock_research_ship_team and next(self._dock_research_ship_team) then
			for iter_24_0, iter_24_1 in pairs(self._dock_research_ship_team) do
				self:update_fast_team_index(iter_24_1, var_24_0, true)
			end
		end

		self._ships_for_dock_research_ship_id_list = {}
		self._team_data = {}

		self:update_research_info()
	end

	function arg_1_0.__onClick_all_ship_info_all_ship_btn_all_ship_btn_txt(arg_25_0)
		return
	end

	function arg_1_0.__onClick_share_btn(arg_26_0)
		return
	end

	function arg_1_0.__onClick_detail_btn_2(arg_27_0)
		return
	end

	function arg_1_0.__onClick_all_ship_info_all_ship_btn_txt(arg_28_0)
		return
	end

	function arg_1_0:__onClick_all_ship_info_all_ship_btn_txt_all_ship_2_btn()
		self._is_clear_custom_select_ship = false

		self:is_custom_select_member_panel(1)
		self:show_all_ship_panel()

		if self._enter_type == var_0_6.enter_select_member_type.research_ship then
			return
		end

		self:update_content()
		self._control.all_ship_info.all_ship_btn_txt.all_ship_2_btn:SetActive(false)
	end

	function arg_1_0:__onClick_all_ship_info_custom_ship_2()
		self._control.all_ship_info.all_ship_btn_txt.all_ship_2_btn:SetActive(true)

		self._is_already_custom_init = false
		self._is_custom_formation = false
		self._is_clear_custom_select_ship = false

		self:is_custom_select_member_panel(2)
		self:show_custom_panel()

		if self._enter_type == var_0_6.enter_select_member_type.strengthen then
			self._control.full_strengthen_btn:SetActive(true)
			self._control.fast_btn:SetActive(false)
		end

		if self._enter_type == var_0_6.enter_select_member_type.restaurant then
			self._control.confirm_btn:SetActive(true)
		end

		if self._enter_type == var_0_6.enter_select_member_type.skill then
			self._control.full_skill_btn:SetActive(true)
		end

		self:update_content()

		if self._enter_type == var_0_6.enter_select_member_type.restaurant_show_type then
			self._control.fast_btn:SetActive(false)
		end
	end

	function arg_1_0.__onClick_custom_ship_info_custom_img(arg_31_0)
		return
	end

	function arg_1_0:__onClick_comfirm_custom_btn()
		self._is_already_custom_init = false
		self._is_custom_formation = false
		self._is_clear_custom_select_ship = false

		var_0_2:show(var_0_4:getNowLang("adjustment_set"))

		if self._custom_team_data and next(self._custom_team_data) then
			var_0_1:req_ChangeStarSetReq(self._custom_team_data)
		else
			var_0_1:req_ChangeStarSetReq({
				0
			})
		end

		self:init_custom_panel(false)
		self:_init_select_member_button_postion()
	end

	function arg_1_0:__onClick_auto_select_confirm_btn()
		if self._enter_type ~= var_0_6.enter_select_member_type.strengthen_res then
			return
		end

		local var_33_0 = var_0_3:getInstance("remake")
		local var_33_1

		if var_33_0 then
			var_33_1 = var_33_0._data
		end

		if not var_33_1 or not var_33_1.id then
			var_0_2:show(var_0_4:getNowLang("auto_strengthen_error"))

			return
		end

		self:__auto_plan_strengthen_res(var_33_1)
	end

	function arg_1_0:__set_fast_btn_switch(arg_34_1)
		if not arg_34_1 then
			self._control.fast_btn.changefleetfast.text.text = var_0_4:getNowLang("changefleetfast")

			self._control.confirm_btn:SetActive(false)
		else
			self._control.fast_btn.changefleetfast.text.text = var_0_4:getNowLang("changefleetnormal")

			self._control.confirm_btn:SetActive(true)
		end

		self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.task_goto))
	end

	function arg_1_0:__change_info_list_detail(arg_35_1)
		self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.task_goto))

		if self._detail_index == var_0_6.dock_detail_layer.once then
			self._control.detail_btn.image.sprite = self:loadSprite(var_0_6.ship_detail_switch.close)
			self._control.detail_btn.detail_status.text.text = var_0_4:getNowLang("detailtypeclose")
		else
			self._control.detail_btn.image.sprite = self:loadSprite(var_0_6.ship_detail_switch.open)
			self._control.detail_btn.detail_status.text.text = var_0_4:getNowLang("detailtypeopen")
		end

		if arg_35_1 then
			return
		end

		self:__update_reusable_cell()
	end

	function arg_1_0:__change_mist_info_detail()
		self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.task_goto))

		self._detail_index = self._detail_index + 1

		if self._detail_index == var_0_6.dock_detail_layer.second then
			self._control.detail_btn.image.sprite = self:loadSprite(var_0_6.ship_detail_switch.open)
			self._control.detail_btn.detail_status.text.text = var_0_4:getNowLang("detailtypeopen")
		elseif self._detail_index > var_0_6.dock_detail_layer.once then
			self._detail_index = var_0_6.dock_detail_layer.once
			self._control.detail_btn.image.sprite = self:loadSprite(var_0_6.ship_detail_switch.close)
			self._control.detail_btn.detail_status.text.text = var_0_4:getNowLang("detailtypeclose")
		end

		self:__update_reusable_cell()
	end

	function arg_1_0:__show_or_hide_full_strengthen()
		self._control.full_strengthen_btn.status.text.text = not self._full_strengthen_flag and var_0_4:getNowLang("hide") or var_0_4:getNowLang("filterlabel")

		self:__update_reusable_cell()
	end

	function arg_1_0:__show_or_hide_full_skill()
		self._control.full_skill_btn.status.text.text = not self._full_skill_flag and var_0_4:getNowLang("hide") or var_0_4:getNowLang("filterlabel")

		self:__update_reusable_cell()
	end
end

function var_0_0.extend_obj(arg_39_0)
	arg_39_0._sort_layer = nil
	arg_39_0._type_layer = nil
end

return var_0_0
