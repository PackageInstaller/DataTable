local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_3 = table.getn
local var_0_5 = gamecore.prompt
local var_0_6 = string.find
local var_0_8 = table.remove
local var_0_9 = table.insert
local var_0_10 = gamecore.Language
local var_0_11 = gamecore.UILoader
local var_0_12 = DG.Tweening.DOTween
local var_0_13 = UnityEngine.Vector2
local var_0_14 = string.format
local var_0_15 = gamecore.util_func
local var_0_16 = gameenum.common_type
local var_0_17 = gameconfig.ship_config
local var_0_18 = gameconfig.sixth_map_config
local var_0_19 = gameconfig.workshop_config
local var_0_20 = gameconfig.sixth_combat_chapter_config
local var_0_21 = gameconfig.item_config
local var_0_22 = string.lower
local var_0_23 = gameconfig.cook_book_config
local var_0_24 = gameconfig.skill_config
local var_0_25 = gameconfig.equip_config
local var_0_26 = lx.UserData
local var_0_29 = gamecore.AuditServerManager

gamecore.UILoader:define("select_member", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7)
		if not var_0_1:get_guide_state() and not var_0_29:isAuditVersion() then
			if not var_0_1:get_is_preload_completed() then
				var_0_1:set_preload_xm_ship_callback_func(function()
					self:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7)
				end)

				return
			end
		else
			var_0_1:set_is_preload_completed(true)
		end

		self:setVisible(true)
		self:__prevent_frequently_click()

		self._is_fast_formation = false
		self._is_type = false
		self._map_id = arg_2_4
		self._enter_type = nil
		self._go_to_map_id = nil
		self._config_data = arg_2_1
		self._ship_type = arg_2_5
		self._index = arg_2_2
		self._campaign = arg_2_3

		if arg_2_7 then
			self:__init_panel()
		end

		self._control.fast_btn:SetActive(true)
		self:play_enlarge_animation()

		self._back_func = arg_2_6 or nil

		local var_2_0 = var_0_11:getInstance("fight_prepare")
		local var_2_1 = var_0_11:getInstance("dock_team")
		local var_2_2 = var_0_11:getInstance("remake")

		if var_2_0 and not var_2_2 then
			var_2_0._panel.transform:GetComponent("Canvas").sortingOrder = self._panel.transform:GetComponent("Canvas").sortingOrder - 1
		end

		if var_2_2 and not var_2_0 then
			var_2_2._panel.transform:GetComponent("Canvas").sortingOrder = self._panel.transform:GetComponent("Canvas").sortingOrder - 1
			self._panel.transform:GetComponent("Canvas").sortingOrder = self._panel.transform:GetComponent("Canvas").sortingOrder + 1
		end

		if var_2_1 then
			var_2_1._panel.transform:GetComponent("Canvas").sortingOrder = self._panel.transform:GetComponent("Canvas").sortingOrder - 1
		end

		self:_set_custom_ship_info()
		self:_init_select_member_button_postion()
		self:get_now_panel_state()
	end

	function arg_1_0:show_by_type(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7, arg_4_8)
		if not var_0_1:get_guide_state() and not var_0_29:isAuditVersion() and not var_0_1:get_is_preload_completed() then
			var_0_1:set_preload_xm_ship_callback_func(function()
				self:show_by_type(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7)
			end)

			return
		end

		self:setVisible(true)

		self._is_nf = var_0_1:get_select_into_nf()

		if self._is_nf then
			self._save_click_mist = arg_4_3
			self._save_nf_ships = var_0_15.little_clone(var_0_1:get_mist_combat_info().ship)
		end

		self._enter_type = arg_4_1
		self._ships_for_dock_disassemble_id_list = {}
		self._ships_for_dock_research_ship_id_list = {}
		self._ships_for_dock_secretary_ship_id_list = {}

		local var_4_0 = arg_4_2 and var_0_15.little_clone(arg_4_2) or {}
		local var_4_1 = var_0_11:getInstance("remake")
		local var_4_2 = var_0_11:getInstance("remake")

		self._control.fast_btn:SetActive(true)
		self._control.detail_btn:SetActive(true)
		self._control.confirm_fast_btn:SetActive(false)
		self._control.clearall_fast_btn:SetActive(false)

		if var_4_1 and not var_4_2 then
			self._panel.transform:GetComponent("Canvas").sortingOrder = var_4_1._panel.transform:GetComponent("Canvas").sortingOrder + 1
		end

		if var_4_2 and not var_4_1 then
			var_4_2._panel.transform:GetComponent("Canvas").sortingOrder = self._panel.transform:GetComponent("Canvas").sortingOrder - 1
		end

		if var_0_11:getInstance("six_year_main_interface") then
			self._ship_type = nil
			self._limit_type = nil
		end

		if self._enter_type == var_0_16.enter_select_member_type.six_year_primary or self._enter_type == var_0_16.enter_select_member_type.six_year_map_select then
			self._limit_type = nil
			self._ship_type = nil
			self._sixth_ships = var_0_1:get_sixth_combat_info().ship_total
		end

		if self._enter_type == var_0_16.enter_select_member_type.college or self._enter_type == var_0_16.enter_select_member_type.dock_disassemble or self._enter_type == var_0_16.enter_select_member_type.secretary_info_ship then
			self._limit_type = nil
			self._ship_type = nil
		end

		self._map_id = arg_4_4
		self._team_type = arg_4_5
		self._go_to_map_id = arg_4_6
		self._select_state = 0

		if self._enter_type == var_0_16.enter_select_member_type.dock_disassemble then
			self._team_data = {}

			self._control.confirm_fast_btn:SetActive(true)

			self._team_index = nil

			self._control.clearall_fast_btn:SetActive(true)
			self._control.bg_container.tip_title.desc:SetActive(true)

			self._control.bg_container.tip_title.desc_text.text.text = var_0_10:getNowLang("select_ship_tip1")
			self._control.confirm_fast_btn.confirm_fast_btn_txt.text.text = var_0_10:getNowLang("all_select")
			self._control.clearall_fast_btn.clearall_fast_btn_txt.text.text = var_0_10:getNowLang("cancel_select")

			local var_4_3 = var_0_11:getInstance("dock")

			if var_4_3 then
				self._panel.transform:GetComponent("Canvas").sortingOrder = var_4_3._panel:GetComponent("Canvas").sortingOrder + 1
			end
		elseif self._enter_type == var_0_16.enter_select_member_type.strengthen_res then
			self._control.bg_container.tip_title.desc:SetActive(true)

			self._control.bg_container.tip_title.desc_text.text.text = var_0_10:getNowLang("strengthenmaterialtitle")
		elseif self._enter_type == var_0_16.enter_select_member_type.restaurant_show_type then
			if self._sort_layer then
				self._sort_layer:reset_tactics_select_state()
			end

			self._food_info = arg_4_8

			self._control.fast_btn:SetActive(false)
			self._control.detail_btn:SetActive(false)

			self._control.bg_container.tip_title.desc_text.text.text = arg_4_8.title
		else
			self._control.all_ship_info:SetActive(true)

			self._control.bg_container.tip_title.desc_text.text.text = var_0_10:getNowLang("select_ship_tip2")

			self._control.bg_container.tip_title.desc:SetActive(true)
		end

		if self._enter_type == var_0_16.enter_select_member_type.strike_map_select then
			local var_4_4 = var_0_1:get_strike_team_data()

			self._team_data = var_4_4 and var_0_15.little_clone(var_4_4) or {}
		end

		if self._enter_type == var_0_16.enter_select_member_type.abyss_dock_team_formation then
			local var_4_5 = var_0_1:get_normal_team_info()

			self._team_data = var_4_5 and var_0_15.little_clone(var_4_5) or {}
		end

		if self._enter_type == var_0_16.enter_select_member_type.ocean_attack_map_select then
			local var_4_6 = var_0_1:get_ocean_team_data()

			self._team_data = var_4_6 and var_0_15.little_clone(var_4_6) or {}
		end

		if self._enter_type == var_0_16.enter_select_member_type.six_year_map_select then
			local var_4_7 = var_0_1:get_sixth_combat_info().members

			self._team_data = var_4_7 and var_0_15.little_clone(var_4_7) or {}
		end

		if self._enter_type == var_0_16.enter_select_member_type.strengthen_res then
			self._ships_for_remould_id_list = arg_4_2
		end

		self._config_data = arg_4_3
		self._prepare_disassemble_data = arg_4_2 or {}

		if self._enter_type == var_0_16.enter_select_member_type.dock_disassemble then
			for iter_4_0, iter_4_1 in ipairs(var_4_0) do
				var_0_9(self._ships_for_dock_disassemble_id_list, iter_4_1.id)
			end
		end

		if self._enter_type == var_0_16.enter_select_member_type.research_ship then
			for iter_4_2, iter_4_3 in ipairs(var_4_0) do
				var_0_9(self._ships_for_dock_research_ship_id_list, iter_4_3.id)
			end
		end

		if self._enter_type == var_0_16.enter_select_member_type.secretary_info_ship then
			for iter_4_4, iter_4_5 in ipairs(var_4_0) do
				var_0_9(self._ships_for_dock_secretary_ship_id_list, iter_4_5)
			end
		end

		if self._enter_type == var_0_16.enter_select_member_type.pre_formation or var_0_11:getInstance("strike_map") or var_0_11:getInstance("strike_main") then
			local var_4_8 = var_0_11:getInstance("pre_formation")

			if var_4_8 then
				self._panel.transform:GetComponent("Canvas").sortingOrder = var_4_8._panel.transform:GetComponent("Canvas").sortingOrder + 1
			end
		end

		self:__inite_language()

		if self._enter_type == var_0_16.enter_select_member_type.restaurant_show_type then
			self._control.bg_container.tip_title.text.text = arg_4_8.title
		end

		self:__init_remove_ship()
		self:__init_content_by_type()
		self:__init_panel()
		self:play_enlarge_animation()
		self._type_layer:set_rebuild_group_visible(self._enter_type == var_0_16.enter_select_member_type.strengthen)
		self._type_layer:set_skill_group_visible(self._enter_type == var_0_16.enter_select_member_type.skill)
		self._type_layer:set_cost_num_group_visible(self._enter_type == var_0_16.enter_select_member_type.tower)
		self._type_layer:set_tactics_group_visible(self._enter_type == var_0_16.enter_select_member_type.tactics_type)
		self._type_layer:set_cook_group_visible(self._enter_type == var_0_16.enter_select_member_type.restaurant_show_type)
		self._type_layer:set_love_group_visible(self._enter_type)
		self._sort_layer:set_cost_sort_btn_active(self._enter_type == var_0_16.enter_select_member_type.tower)

		self._back_func = arg_4_7 or nil

		if self._enter_type == var_0_16.enter_select_member_type.strengthen_res or self._enter_type == var_0_16.enter_select_member_type.research_ship then
			self._control.all_ship_info:SetActive(false)
		end

		self:get_now_panel_state()

		if self._enter_type == var_0_16.enter_select_member_type.restaurant_show_type then
			self._control.fast_btn:SetActive(false)
			self._control.detail_btn:SetActive(false)
		end
	end

	function arg_1_0:after_close_select_member(arg_6_1)
		self.content_pos = arg_6_1 and self._control.all_ship.Viewport.edge_mask.Content.transform.anchoredPosition or nil

		if self._back_func then
			self._back_func()

			self._back_func = nil
		end
	end

	function arg_1_0:update_data()
		self:__inite_language()
		self:__init_content_by_type()
		self:__init_panel()
	end

	function arg_1_0.is_state(arg_8_0, arg_8_1)
		arg_8_0._is_type = arg_8_1
	end

	function arg_1_0:__onUpdate()
		if var_0_1:get_guide_state() and self._reusable_cell then
			self._reusable_cell:update()
		elseif self._reusable_cell and var_0_1:get_is_preload_completed() then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:get_index()
		return self._index
	end

	function arg_1_0:get_index_in_team_data(arg_11_1)
		if arg_11_1 then
			return (var_0_15.get_index(self._team_data, arg_11_1.id))
		end
	end

	function arg_1_0:get_index_in_custom_data(arg_12_1)
		if arg_12_1 and self._custom_team_data and next(self._custom_team_data) then
			return (var_0_15.get_index(self._custom_team_data, arg_12_1.id))
		end
	end

	function arg_1_0:get_index_in_disassemble_info_team_data(arg_13_1)
		if arg_13_1 then
			return (var_0_15.get_index(self._ships_for_dock_disassemble_id_list, arg_13_1.id))
		end
	end

	function arg_1_0:get_index_in_research_ship_info_team_data(arg_14_1)
		if arg_14_1 then
			return (var_0_15.get_index(self._ships_for_dock_research_ship_id_list, arg_14_1.id))
		end
	end

	function arg_1_0:get_index_in_secretary_ship_info_team_data(arg_15_1)
		if arg_15_1 then
			return (var_0_15.get_index(self._ships_for_dock_secretary_ship_id_list, arg_15_1.id))
		end
	end

	function arg_1_0:get_index_in_cell_data(arg_16_1)
		if arg_16_1 then
			for iter_16_0, iter_16_1 in pairs(self._cell_data) do
				if iter_16_1.id == arg_16_1.id then
					return iter_16_0
				end
			end
		end
	end

	function arg_1_0:get_is_fast_formation()
		return self._is_fast_formation
	end

	function arg_1_0:get_is_custom_formation()
		return self._is_custom_formation
	end

	function arg_1_0:sort_layer_toggle_on(arg_19_1, arg_19_2)
		self._sort_layer:change_sort_text(self._control.sort_order_btn.sort_txt, arg_19_1)

		if self._enter_type == var_0_16.enter_select_member_type.captainroom_fleet then
			self:update_cap_fleet_content()

			return
		end

		self:update_content()
		self:__update_edge_mask()
	end

	function arg_1_0:type_layer_confirm_btn_on()
		self._type_layer:change_type_text(self._control.sort_type_btn.sort_txt)

		if self._enter_type == var_0_16.enter_select_member_type.captainroom_fleet and not self._iscustom_state or self._enter_type == var_0_16.enter_select_member_type.pre_formation and not self._iscustom_state then
			self:update_cap_fleet_content()

			return
		end

		self:update_content()
		self:__update_edge_mask()
	end

	function arg_1_0:update_cap_fleet_content()
		local var_21_0 = var_0_1:get_character_list()
		local var_21_1 = self:__sort_table_by_rule((self:__sort_table_by_type(self:__filter_table_by_name(var_21_0 and var_0_15.little_clone(var_21_0) or {}), self._prepare_disassemble_data)))
		local var_21_2 = {}
		local var_21_3 = {}

		if var_21_1 then
			for iter_21_0, iter_21_1 in ipairs(var_21_1) do
				local var_21_4 = self:find_index_in_cap_fleet_team(iter_21_1.id)

				if var_21_4 then
					var_21_3[var_21_4] = iter_21_1
				else
					var_0_9(var_21_2, iter_21_1)
				end
			end
		end

		if var_21_3 and next(var_21_3) then
			for iter_21_2, iter_21_3 in ipairs(var_21_3) do
				var_0_9(var_21_2, iter_21_2, iter_21_3)
			end
		end

		self._cell_data = var_21_2

		self:__update_reusable_cell()
	end

	function arg_1_0:find_index_in_cap_fleet_team(arg_22_1)
		if self._prepare_disassemble_data then
			for iter_22_0, iter_22_1 in ipairs(self._prepare_disassemble_data) do
				if iter_22_1.id == arg_22_1 then
					return iter_22_0
				end
			end
		end
	end

	function arg_1_0:update_content(arg_23_1)
		if self._is_fast_formation and not self._iscustom_state then
			self:__load_info_list((self:__filter_fast_all_character_list()))

			if self._enter_type == var_0_16.enter_select_member_type.dock_disassemble or self._enter_type == var_0_16.enter_select_member_type.strengthen_res or self._enter_type == var_0_16.enter_select_member_type.captainroom_fleet or self._enter_type == var_0_16.enter_select_member_type.dormitory or self._enter_type == var_0_16.enter_select_member_type.strike_map_select or self._enter_type == var_0_16.enter_select_member_type.research_ship or self._enter_type == var_0_16.enter_select_member_type.secretary_info_ship or self._enter_type == var_0_16.enter_select_member_type.abyss_dock_team_formation then
				self:__update_fast_content_by_type()

				if self._enter_type == var_0_16.enter_select_member_type.strengthen_res then
					self:__update_edge_mask()
				end
			elseif self._enter_type == var_0_16.enter_select_member_type.six_year_primary or self._enter_type == var_0_16.enter_select_member_type.six_year_map_select or self._enter_type == var_0_16.enter_select_member_type.ocean_attack_map_select then
				self._is_already_fast_init = true

				self:__update_fast_content_by_type()
			else
				self:__update_fast_content()
				self:__update_edge_mask()
			end
		elseif self._panel_type == var_0_16.enter_select_member_type.custom_ship and not self._is_already_custom_init then
			if arg_23_1 then
				self:__update_custom_content(arg_23_1)
			else
				self:__update_custom_content()
			end
		elseif self._panel_type == var_0_16.enter_select_member_type.custom_ship and self._is_already_custom_init then
			if arg_23_1 then
				self:__update_custom_content(arg_23_1)
			else
				self:__update_custom_content()
			end
		elseif self._iscustom_state and self._is_fast_formation then
			self:__update_fast_content()
		else
			self._temporary_data = {}

			self:__load_info_list((self._enter_type == var_0_16.enter_select_member_type.strengthen or self._enter_type == var_0_16.enter_select_member_type.evo or self._enter_type == var_0_16.enter_select_member_type.restaurant or self._enter_type == var_0_16.enter_select_member_type.skill or self._enter_type == var_0_16.enter_select_member_type.six_year_map_select or self._enter_type == var_0_16.enter_select_member_type.abyss_dock_team_formation or self._enter_type == var_0_16.enter_select_member_type.strike_map_select) and self:__filter_fast_all_character_list() or self:__filter_fast_all_character_list(true, arg_23_1))

			if self._enter_type ~= nil and self._enter_type ~= var_0_16.enter_select_member_type.dock_team and self._enter_type ~= var_0_16.enter_select_member_type.dock_team_empty and self._enter_type ~= var_0_16.enter_select_member_type.fight then
				if not var_0_11:getInstance("school") and not var_0_11:getInstance("restaurant") then
					self:__update_edge_mask()
				end
			end
		end

		self:__update_search_name()
		self:__change_info_list_detail(true)
	end

	function arg_1_0:update_custom_team_index(arg_24_1, arg_24_2, arg_24_3)
		local var_24_0 = self._select_state == 0 and self._enter_type == var_0_16.enter_select_member_type.dock_disassemble and self:get_index_in_disassemble_info_team_data(arg_24_1) or self:get_index_in_custom_data(arg_24_1)

		if self._enter_type ~= var_0_16.enter_select_member_type.six_year_primary and self._enter_type ~= var_0_16.enter_select_member_type.strengthen_res and self._enter_type ~= var_0_16.enter_select_member_type.research_ship and self._enter_type ~= var_0_16.enter_select_member_type.secretary_info_ship and self._enter_type ~= var_0_16.enter_select_member_type.dock_disassemble and var_24_0 and arg_24_1.team_num ~= 0 then
			self._temporary_data[self:get_index_in_cell_data(arg_24_1)] = arg_24_1
		end

		if var_24_0 then
			var_0_8(self._custom_team_data, var_24_0)

			if self._enter_type == var_0_16.enter_select_member_type.dormitory then
				for iter_24_0, iter_24_1 in pairs(self._prepare_disassemble_data) do
					if iter_24_1.id == arg_24_1.id then
						var_0_8(self._prepare_disassemble_data, iter_24_0)
					end
				end
			elseif self._enter_type == var_0_16.enter_select_member_type.dock_team then
				if not var_0_15.have_data(self._custom_team_data, arg_24_1) then
					arg_24_1.team_num = 0
				end
			elseif self._enter_type == var_0_16.enter_select_member_type.dock_disassemble then
				if self._select_state == 0 then
					for iter_24_2, iter_24_3 in ipairs(self._ships_for_dock_disassemble_id_list) do
						if iter_24_3 == arg_24_1.id then
							var_0_8(self._ships_for_dock_disassemble_id_list, iter_24_2)

							break
						end
					end
				elseif self._ships_for_dock_disassemble_id_list and next(self._ships_for_dock_disassemble_id_list) then
					if var_0_15.have_data(self._ships_for_dock_disassemble_id_list, arg_24_1.id) then
						-- block empty
					else
						var_0_9(self._ships_for_dock_disassemble_id_list, arg_24_1.id)
					end
				else
					var_0_9(self._ships_for_dock_disassemble_id_list, arg_24_1.id)
				end
			end
		else
			local var_24_1 = self._enter_type == var_0_16.enter_select_member_type.dock_disassemble or self._enter_type == var_0_16.enter_select_member_type.strengthen_res

			if self._enter_type ~= var_0_16.enter_select_member_type.six_year_primary then
				if self._enter_type == var_0_16.enter_select_member_type.dock_disassemble then
					if (self._select_state == 0 or self._select_state == 1) and self._ships_for_dock_disassemble_id_list and arg_24_2 <= var_0_3(self._ships_for_dock_disassemble_id_list) then
						var_0_5:show(var_0_14(var_0_10:getNowLang("selectstrenmaterialmax"), arg_24_2))

						return
					end
				elseif self._enter_type == var_0_16.enter_select_member_type.research_ship then
					if (self._select_state == 0 or self._select_state == 1) and self._ships_for_dock_research_ship_id_list and arg_24_2 <= var_0_3(self._ships_for_dock_research_ship_id_list) then
						var_0_5:show(var_0_14(var_0_10:getNowLang("selectstrenmaterialmax"), arg_24_2))

						return
					end
				elseif self._enter_type == var_0_16.enter_select_member_type.secretary_info_ship then
					if (self._select_state == 0 or self._select_state == 1) and self._ships_for_dock_secretary_ship_id_list and arg_24_2 <= var_0_3(self._ships_for_dock_secretary_ship_id_list) then
						var_0_5:show(var_0_14(var_0_10:getNowLang("selectstrenmaterialmax"), arg_24_2))

						return
					end
				elseif self._enter_type == var_0_16.enter_select_member_type.strengthen_res then
					if self._prepare_disassemble_data and arg_24_2 <= var_0_3(self._prepare_disassemble_data) then
						var_0_5:show(var_0_14(var_0_10:getNowLang("selectstrenmaterialmax"), arg_24_2))

						return
					end
				elseif self._panel_type == var_0_16.enter_select_member_type.custom_ship then
					if self._custom_team_data and var_0_3(self._custom_team_data) >= var_0_16.max_select_type.two_hundred then
						var_0_5:show(var_0_14(var_0_10:getNowLang("selectstrenmaterialmax"), var_0_16.max_select_type.two_hundred))

						return
					end
				elseif self._team_data and arg_24_2 <= var_0_3(self._team_data) then
					var_0_5:show(var_0_14(var_0_10:getNowLang("selectstrenmaterialmax"), arg_24_2))

					return
				end
			end

			if self._enter_type ~= var_0_16.enter_select_member_type.research_ship and self._enter_type ~= var_0_16.enter_select_member_type.secretary_info_ship and self._panel_type ~= var_0_16.enter_select_member_type.custom_ship and not var_24_1 then
				for iter_24_4, iter_24_5 in pairs(self._team_data) do
					local var_24_2 = var_0_17.find_object_by_cid(var_0_1:find_character_by_id(iter_24_5).cid)
					local var_24_3 = {}

					if arg_24_1 then
						var_24_3 = var_0_17.find_object_by_cid(var_0_1:find_character_by_id(arg_24_1.id).cid)
					end

					if var_24_3 and (var_24_2.cid == var_24_3.cid or var_24_2.evo_cid == var_24_3.evo_cid) then
						var_0_5:show(var_0_10:getNowLang("cannotusesameidshipinonefleet"))

						return
					end
				end
			end

			local var_24_4 = var_0_1:get_sixth_bigmap_info()
			local var_24_5 = var_0_1:get_sixth_combat_info()

			if self._enter_type == var_0_16.enter_select_member_type.six_year_primary then
				arg_24_2 = self._shipton_num_small + self._shipton_num_middle + self._shipton_num_big

				local var_24_6, var_24_7, var_24_8 = self:__get_sixth_member_count()

				if not arg_24_1 then
					return
				end

				local var_24_9 = var_0_17.find_object_by_cid(arg_24_1.cid)
				local var_24_10 = var_0_20.find_object_by_id(self._bigmap_info)

				if var_24_10 and next(var_24_10.shipton_num) then
					local var_24_11 = var_24_10.shipton_num

					self._shipton_num_small = var_24_10.shipton_num[1]
					self._shipton_num_middle = var_24_11[2]
					self._shipton_num_big = var_24_11[3]

					if var_24_9 and var_24_9.ship_ton == 1 then
						var_24_6 = var_24_6 + 1
					elseif var_24_9 and var_24_9.ship_ton == 2 then
						var_24_7 = var_24_7 + 1
					elseif var_24_9 and var_24_9.ship_ton == 3 then
						var_24_8 = var_24_8 + 1
					end

					if var_24_6 > var_24_11[1] or var_24_7 > var_24_11[2] or var_24_8 > var_24_11[3] then
						var_0_5:show(var_0_10:getNowLang("sixth_members_limit"))

						return
					end
				end
			end

			if arg_24_1 then
				var_0_9(self._custom_team_data, arg_24_1.id)
			end

			if self._enter_type == var_0_16.enter_select_member_type.dormitory then
				self._prepare_disassemble_data = {}

				for iter_24_6, iter_24_7 in ipairs(self._team_data) do
					var_0_9(self._prepare_disassemble_data, (var_0_1:find_character_by_id(iter_24_7)))
				end
			elseif self._enter_type == var_0_16.enter_select_member_type.strengthen_res then
				var_0_9(self._ships_for_remould_id_list, arg_24_1.id)
			elseif self._enter_type == var_0_16.enter_select_member_type.dock_disassemble then
				var_0_9(self._ships_for_dock_disassemble_id_list, arg_24_1.id)
			elseif self._enter_type == var_0_16.enter_select_member_type.research_ship then
				var_0_9(self._ships_for_dock_research_ship_id_list, arg_24_1.id)
			elseif self._enter_type == var_0_16.enter_select_member_type.secretary_info_ship then
				var_0_9(self._ships_for_dock_secretary_ship_id_list, arg_24_1.id)
			end
		end

		self:__update_select_ship_info()

		if #self._team_data == 0 and (self._enter_type == var_0_16.enter_select_member_type.dock_team or self._enter_type == var_0_16.enter_select_member_type.dock_team_empty) and self._enter_type == var_0_16.enter_select_member_type.fight and self._enter_type ~= var_0_16.enter_select_member_type.dormitory then
			var_0_5:show(var_0_10:getNowLang("needflagshipinfleet"))

			return
		end

		if not arg_24_3 then
			self:__update_reusable_cell()
		else
			self:update_all_cell_number_setting()
		end
	end

	function arg_1_0:update_fast_team_index(arg_25_1, arg_25_2, arg_25_3)
		local var_25_0 = self._select_state == 0 and self._enter_type == var_0_16.enter_select_member_type.dock_disassemble and self:get_index_in_disassemble_info_team_data(arg_25_1) or self._select_state == 0 and self._enter_type == var_0_16.enter_select_member_type.research_ship and self:get_index_in_research_ship_info_team_data(arg_25_1) or self._select_state == 0 and self._enter_type == var_0_16.enter_select_member_type.secretary_info_ship and self:get_index_in_secretary_ship_info_team_data(arg_25_1) or self:get_index_in_team_data(arg_25_1)

		if self._enter_type ~= var_0_16.enter_select_member_type.six_year_primary and self._enter_type ~= var_0_16.enter_select_member_type.strengthen_res and self._enter_type ~= var_0_16.enter_select_member_type.research_ship and self._enter_type ~= var_0_16.enter_select_member_type.secretary_info_ship and self._enter_type ~= var_0_16.enter_select_member_type.dock_disassemble and var_25_0 and arg_25_1.team_num ~= 0 then
			self._temporary_data[self:get_index_in_cell_data(arg_25_1)] = arg_25_1
		end

		if var_25_0 then
			var_0_8(self._team_data, var_25_0)

			if self._enter_type == var_0_16.enter_select_member_type.dormitory then
				for iter_25_0, iter_25_1 in pairs(self._prepare_disassemble_data) do
					if iter_25_1.id == arg_25_1.id then
						var_0_8(self._prepare_disassemble_data, iter_25_0)
					end
				end
			elseif self._enter_type == var_0_16.enter_select_member_type.dock_team then
				if not var_0_15.have_data(self._team_data, arg_25_1) then
					arg_25_1.team_num = 0
				end
			elseif self._enter_type == var_0_16.enter_select_member_type.strengthen_res then
				for iter_25_2, iter_25_3 in ipairs(self._ships_for_remould_id_list) do
					if iter_25_3 == arg_25_1.id then
						var_0_8(self._ships_for_remould_id_list, iter_25_2)

						break
					end
				end
			elseif self._enter_type == var_0_16.enter_select_member_type.dock_disassemble then
				if self._select_state == 0 then
					for iter_25_4, iter_25_5 in ipairs(self._ships_for_dock_disassemble_id_list) do
						if iter_25_5 == arg_25_1.id then
							var_0_8(self._ships_for_dock_disassemble_id_list, iter_25_4)

							break
						end
					end
				elseif self._ships_for_dock_disassemble_id_list and next(self._ships_for_dock_disassemble_id_list) then
					if var_0_15.have_data(self._ships_for_dock_disassemble_id_list, arg_25_1.id) then
						-- block empty
					else
						var_0_9(self._ships_for_dock_disassemble_id_list, arg_25_1.id)
					end
				else
					var_0_9(self._ships_for_dock_disassemble_id_list, arg_25_1.id)
				end
			elseif self._enter_type == var_0_16.enter_select_member_type.research_ship then
				if self._select_state == 0 then
					for iter_25_6, iter_25_7 in ipairs(self._ships_for_dock_research_ship_id_list) do
						if iter_25_7 == arg_25_1.id then
							var_0_8(self._ships_for_dock_research_ship_id_list, iter_25_6)

							break
						end
					end
				elseif self._ships_for_dock_research_ship_id_list and next(self._ships_for_dock_research_ship_id_list) then
					if var_0_15.have_data(self._ships_for_dock_research_ship_id_list, arg_25_1.id) then
						-- block empty
					else
						var_0_9(self._ships_for_dock_research_ship_id_list, arg_25_1.id)
					end
				else
					var_0_9(self._ships_for_dock_research_ship_id_list, arg_25_1.id)
				end
			elseif self._enter_type == var_0_16.enter_select_member_type.secretary_info_ship then
				if self._select_state == 0 then
					for iter_25_8, iter_25_9 in ipairs(self._ships_for_dock_secretary_ship_id_list) do
						if iter_25_9 == arg_25_1.id then
							var_0_8(self._ships_for_dock_secretary_ship_id_list, iter_25_8)

							break
						end
					end
				elseif self._ships_for_dock_secretary_ship_id_list and next(self._ships_for_dock_secretary_ship_id_list) then
					if var_0_15.have_data(self._ships_for_dock_secretary_ship_id_list, arg_25_1.id) then
						-- block empty
					else
						var_0_9(self._ships_for_dock_secretary_ship_id_list, arg_25_1.id)
					end
				else
					var_0_9(self._ships_for_dock_secretary_ship_id_list, arg_25_1.id)
				end
			end
		else
			local var_25_1 = self._enter_type == var_0_16.enter_select_member_type.dock_disassemble or self._enter_type == var_0_16.enter_select_member_type.strengthen_res

			if self._enter_type ~= var_0_16.enter_select_member_type.six_year_primary then
				if self._enter_type == var_0_16.enter_select_member_type.dock_disassemble then
					if (self._select_state == 0 or self._select_state == 1) and self._ships_for_dock_disassemble_id_list and arg_25_2 <= var_0_3(self._ships_for_dock_disassemble_id_list) then
						var_0_5:show(var_0_14(var_0_10:getNowLang("selectstrenmaterialmax"), arg_25_2))

						return
					end
				elseif self._enter_type == var_0_16.enter_select_member_type.research_ship then
					if (self._select_state == 0 or self._select_state == 1) and self._ships_for_dock_research_ship_id_list and arg_25_2 <= var_0_3(self._ships_for_dock_research_ship_id_list) then
						var_0_5:show(var_0_14(var_0_10:getNowLang("selectstrenmaterialmax"), arg_25_2))

						return
					end
				elseif self._enter_type == var_0_16.enter_select_member_type.secretary_info_ship then
					if self._ships_for_dock_secretary_ship_id_list and arg_25_2 <= var_0_3(self._ships_for_dock_secretary_ship_id_list) then
						var_0_5:show(var_0_14(var_0_10:getNowLang("selectstrenmaterialmax"), arg_25_2))

						return
					end
				elseif self._enter_type == var_0_16.enter_select_member_type.strengthen_res then
					if self._prepare_disassemble_data and arg_25_2 <= var_0_3(self._prepare_disassemble_data) then
						var_0_5:show(var_0_14(var_0_10:getNowLang("selectstrenmaterialmax"), arg_25_2))

						return
					end
				elseif self._panel_type == var_0_16.enter_select_member_type.custom_ship then
					if self._team_data and var_0_3(self._team_data) >= var_0_16.max_select_type.two_hundred then
						var_0_5:show(var_0_14(var_0_10:getNowLang("selectstrenmaterialmax"), var_0_16.max_select_type.two_hundred))

						return
					end
				elseif self._team_data and arg_25_2 <= var_0_3(self._team_data) then
					var_0_5:show(var_0_14(var_0_10:getNowLang("selectstrenmaterialmax"), arg_25_2))

					return
				end
			end

			if self._enter_type ~= var_0_16.enter_select_member_type.research_ship and self._enter_type ~= var_0_16.enter_select_member_type.secretary_info_ship and self._panel_type ~= var_0_16.enter_select_member_type.custom_ship and not var_25_1 then
				for iter_25_10, iter_25_11 in pairs(self._team_data) do
					local var_25_2 = var_0_17.find_object_by_cid(var_0_1:find_character_by_id(iter_25_11).cid)
					local var_25_3 = {}

					if arg_25_1 then
						var_25_3 = var_0_17.find_object_by_cid(var_0_1:find_character_by_id(arg_25_1.id).cid)
					end

					if var_25_3 and (var_25_2.cid == var_25_3.cid or var_25_2.evo_cid == var_25_3.evo_cid) then
						var_0_5:show(var_0_10:getNowLang("cannotusesameidshipinonefleet"))

						return
					end
				end
			end

			local var_25_4 = var_0_1:get_sixth_bigmap_info()
			local var_25_5 = var_0_1:get_sixth_combat_info()

			if self._enter_type == var_0_16.enter_select_member_type.six_year_primary then
				arg_25_2 = self._shipton_num_small + self._shipton_num_middle + self._shipton_num_big

				local var_25_6, var_25_7, var_25_8 = self:__get_sixth_member_count()

				if not arg_25_1 then
					return
				end

				local var_25_9 = var_0_17.find_object_by_cid(arg_25_1.cid)
				local var_25_10 = var_0_20.find_object_by_id(self._bigmap_info)

				if var_25_10 and next(var_25_10.shipton_num) then
					local var_25_11 = var_25_10.shipton_num

					self._shipton_num_small = var_25_10.shipton_num[1]
					self._shipton_num_middle = var_25_11[2]
					self._shipton_num_big = var_25_11[3]

					if var_25_9 and var_25_9.ship_ton == 1 then
						var_25_6 = var_25_6 + 1
					elseif var_25_9 and var_25_9.ship_ton == 2 then
						var_25_7 = var_25_7 + 1
					elseif var_25_9 and var_25_9.ship_ton == 3 then
						var_25_8 = var_25_8 + 1
					end

					if var_25_6 > var_25_11[1] or var_25_7 > var_25_11[2] or var_25_8 > var_25_11[3] then
						var_0_5:show(var_0_10:getNowLang("sixth_members_limit"))

						return
					end
				end
			end

			if arg_25_1 then
				var_0_9(self._team_data, arg_25_1.id)
			end

			if self._enter_type == var_0_16.enter_select_member_type.dormitory then
				self._prepare_disassemble_data = {}

				for iter_25_12, iter_25_13 in ipairs(self._team_data) do
					var_0_9(self._prepare_disassemble_data, (var_0_1:find_character_by_id(iter_25_13)))
				end
			elseif self._enter_type == var_0_16.enter_select_member_type.strengthen_res then
				var_0_9(self._ships_for_remould_id_list, arg_25_1.id)
			elseif self._enter_type == var_0_16.enter_select_member_type.dock_disassemble then
				var_0_9(self._ships_for_dock_disassemble_id_list, arg_25_1.id)
			elseif self._enter_type == var_0_16.enter_select_member_type.research_ship then
				var_0_9(self._ships_for_dock_research_ship_id_list, arg_25_1.id)
			end
		end

		self:__update_select_ship_info()

		if #self._team_data == 0 and (self._enter_type == var_0_16.enter_select_member_type.dock_team or self._enter_type == var_0_16.enter_select_member_type.dock_team_empty) and self._enter_type == var_0_16.enter_select_member_type.fight and self._enter_type ~= var_0_16.enter_select_member_type.dormitory then
			var_0_5:show(var_0_10:getNowLang("needflagshipinfleet"))

			return
		end

		if not arg_25_3 then
			self:__update_reusable_cell()
		else
			self:update_all_cell_number_setting()
		end

		if self._enter_type == var_0_16.enter_select_member_type.strengthen_res then
			self:update_strengthen_info()
		end

		if self._enter_type == var_0_16.enter_select_member_type.research_ship then
			self:update_research_info()
		end

		if self._enter_type == var_0_16.enter_select_member_type.secretary_info_ship then
			self:update_secretary_info()
		end
	end

	function arg_1_0:__auto_select_sixth_team()
		local var_26_0 = var_0_11:getInstance("six_year_main_interface").now_map_info

		if self._start_map_info and next(self._start_map_info) then
			for iter_26_0, iter_26_1 in ipairs(self._start_map_info.members) do
				self:update_fast_team_index((var_0_1:find_character_by_id(iter_26_1)))
			end
		end
	end

	function arg_1_0.__set_work_add(arg_27_0, arg_27_1)
		local var_27_0 = 0

		for iter_27_0, iter_27_1 in pairs((var_0_1:get_workshop_data())) do
			local var_27_1 = var_0_19.find_object_by_id(iter_27_1.id).effect[1]

			if var_27_1.type == var_0_16.workshop_const.work_type.add_intensify_exp and var_27_1.shipTypes then
				for iter_27_2, iter_27_3 in pairs(var_27_1.shipTypes) do
					if var_27_1.shipTypes and arg_27_1 == var_27_1.shipTypes[iter_27_2] then
						var_27_0 = var_27_1.num

						return var_27_1.num
					end
				end
			end
		end

		return var_27_0
	end

	function arg_1_0:update_strengthen_info()
		local var_28_0 = {
			0,
			0,
			0,
			0
		}

		for iter_28_0 = 1, #self._ships_for_remould_id_list do
			local var_28_1 = var_0_1:find_character_by_id(self._ships_for_remould_id_list[iter_28_0])

			if var_28_1 then
				local var_28_2 = var_0_17.find_object_by_cid(var_28_1.cid)

				for iter_28_1, iter_28_2 in pairs(var_28_2.strengthen_supply_exp) do
					local var_28_3 = self:__set_work_add(var_28_2.type)

					if iter_28_2.name == "atk" then
						var_28_0[1] = iter_28_2.value + var_28_0[1] + math.floor(iter_28_2.value * var_28_3 / 100)
					elseif iter_28_2.name == "torpedo" then
						var_28_0[2] = iter_28_2.value + var_28_0[2] + math.floor(iter_28_2.value * var_28_3 / 100)
					elseif iter_28_2.name == "def" then
						var_28_0[3] = iter_28_2.value + var_28_0[3] + math.floor(iter_28_2.value * var_28_3 / 100)
					elseif iter_28_2.name == "air_def" then
						var_28_0[4] = iter_28_2.value + var_28_0[4] + math.floor(iter_28_2.value * var_28_3 / 100)
					end
				end
			end
		end

		self._control.strengthen_info.atk.text.text = var_28_0[1]
		self._control.strengthen_info.torpedo.text.text = var_28_0[2]
		self._control.strengthen_info.def.text.text = var_28_0[3]
		self._control.strengthen_info.air_def.text.text = var_28_0[4]
	end

	function arg_1_0.__get_strengthen_remain_exp(arg_29_0, arg_29_1)
		local var_29_0 = {
			air_def = 0,
			def = 0,
			torpedo = 0,
			atk = 0
		}

		if not arg_29_1 then
			return var_29_0
		end

		local var_29_1 = var_0_17.find_object_by_cid(arg_29_1.cid)

		if not var_29_1 or not var_29_1.strengthen_top then
			return var_29_0
		end

		local var_29_2 = {}

		if arg_29_1.intensify then
			for iter_29_0, iter_29_1 in pairs(arg_29_1.intensify) do
				var_29_2[iter_29_1.attr] = iter_29_1.exp or 0
			end
		end

		for iter_29_2, iter_29_3 in ipairs(var_29_1.strengthen_top) do
			if iter_29_3.value and iter_29_3.value ~= 0 then
				var_29_0[iter_29_3.name] = math.max(0, iter_29_3.value - (var_29_2[iter_29_3.name] or 0))
			end
		end

		return var_29_0
	end

	function arg_1_0:__get_strengthen_have_exp(arg_30_1)
		local var_30_0 = {
			air_def = 0,
			def = 0,
			torpedo = 0,
			atk = 0
		}

		if not arg_30_1 then
			return var_30_0
		end

		local var_30_1 = var_0_17.find_object_by_cid(arg_30_1.cid)

		if not var_30_1 or not var_30_1.strengthen_supply_exp then
			return var_30_0
		end

		local var_30_2 = self:__set_work_add(var_30_1.type)

		for iter_30_0, iter_30_1 in pairs(var_30_1.strengthen_supply_exp) do
			if iter_30_1.name then
				local var_30_3 = iter_30_1.value or 0

				var_30_0[iter_30_1.name] = math.floor(var_30_3 + var_30_3 * var_30_2 / 100)
			end
		end

		return var_30_0
	end

	function arg_1_0.__get_strengthen_remain_levels(arg_31_0, arg_31_1)
		local var_31_0 = {
			air_def = 0,
			def = 0,
			torpedo = 0,
			atk = 0
		}

		if not arg_31_1 then
			return var_31_0
		end

		local var_31_1 = var_0_17.find_object_by_cid(arg_31_1.cid)

		if not var_31_1 or not var_31_1.strengthen_level_up_exp or var_31_1.strengthen_level_up_exp <= 0 then
			return var_31_0
		end

		local var_31_2 = var_31_1.strengthen_level_up_exp
		local var_31_3 = {}

		if arg_31_1.intensify then
			for iter_31_0, iter_31_1 in pairs(arg_31_1.intensify) do
				var_31_3[iter_31_1.attr] = iter_31_1.exp or 0
			end
		end

		for iter_31_2, iter_31_3 in ipairs(var_31_1.strengthen_top) do
			if iter_31_3.value and iter_31_3.value ~= 0 then
				var_31_0[iter_31_3.name] = math.max(0, iter_31_3.value / var_31_2 - math.floor((var_31_3[iter_31_3.name] or 0) / var_31_2))
			end
		end

		return var_31_0
	end

	function arg_1_0:__get_strengthen_have_levels(arg_32_1, arg_32_2)
		local var_32_0 = {
			air_def = 0,
			def = 0,
			torpedo = 0,
			atk = 0
		}

		if not arg_32_1 or not arg_32_2 or arg_32_2 <= 0 then
			return var_32_0
		end

		local var_32_1 = var_0_17.find_object_by_cid(arg_32_1.cid)

		if not var_32_1 or not var_32_1.strengthen_supply_exp then
			return var_32_0
		end

		local var_32_2 = self:__set_work_add(var_32_1.type)

		for iter_32_0, iter_32_1 in pairs(var_32_1.strengthen_supply_exp) do
			local var_32_3 = iter_32_1.value or 0

			var_32_0[iter_32_1.name] = math.floor(var_32_3 + var_32_3 * var_32_2 / 100) / arg_32_2
		end

		return var_32_0
	end

	function arg_1_0.__get_dismantle_sum(arg_33_0, arg_33_1)
		local var_33_0 = 0

		if not arg_33_1 then
			return var_33_0
		end

		local var_33_1 = var_0_17.find_object_by_cid(arg_33_1.cid)

		if not var_33_1 or not var_33_1.dismantle then
			return var_33_0
		end

		for iter_33_0 = 1, 4 do
			var_33_0 = var_33_0 + ((var_33_1.dismantle[iter_33_0] or nil) and (var_33_1.dismantle[iter_33_0].value or 0))
		end

		return var_33_0
	end

	function arg_1_0:__get_strengthen_value(arg_34_1, arg_34_2, arg_34_3)
		local var_34_0 = self:__get_dismantle_sum(arg_34_3)

		if var_34_0 <= 0 then
			if arg_34_1 > 0 then
				return math.huge
			end

			return 0
		end

		return arg_34_1 / (var_34_0 + arg_34_2 * 0.3)
	end

	function arg_1_0.__is_better_strengthen_ship(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4, arg_35_5, arg_35_6)
		if not arg_35_4 then
			return true
		end

		if arg_35_4 < arg_35_1 then
			return true
		end

		if arg_35_1 == arg_35_4 and arg_35_5 < arg_35_2 then
			return true
		end

		if arg_35_1 == arg_35_4 and arg_35_2 == arg_35_5 and (not arg_35_6 or arg_35_3 < arg_35_6) then
			return true
		end

		return false
	end

	function arg_1_0.__get_useful_and_waste(arg_36_0, arg_36_1, arg_36_2)
		local var_36_0 = 0
		local var_36_1 = 0

		for iter_36_0, iter_36_1 in ipairs({
			"atk",
			"torpedo",
			"def",
			"air_def"
		}) do
			local var_36_2 = arg_36_1[iter_36_1] or 0
			local var_36_3 = arg_36_2[iter_36_1] or 0

			if var_36_3 > 0 then
				var_36_0 = var_36_0 + math.min(var_36_2, var_36_3)
				var_36_1 = var_36_1 + math.max(0, var_36_2 - var_36_3)
			else
				var_36_1 = var_36_1 + var_36_2
			end
		end

		return var_36_0, var_36_1
	end

	function arg_1_0.__remove_strengthen_remain(arg_37_0, arg_37_1, arg_37_2)
		for iter_37_0, iter_37_1 in ipairs({
			"atk",
			"torpedo",
			"def",
			"air_def"
		}) do
			arg_37_1[iter_37_1] = math.max(0, (arg_37_1[iter_37_1] or 0) - (arg_37_2[iter_37_1] or 0))
		end
	end

	function arg_1_0.__has_strengthen_remain(arg_38_0, arg_38_1)
		for iter_38_0, iter_38_1 in ipairs({
			"atk",
			"torpedo",
			"def",
			"air_def"
		}) do
			if (arg_38_1[iter_38_1] or 0) > 0 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__remove_zero_useful_ships(arg_39_1, arg_39_2, arg_39_3)
		local var_39_0 = self:__get_strengthen_remain_levels(arg_39_2)
		local var_39_1 = {}
		local var_39_2 = {}
		local var_39_3 = {}

		for iter_39_0, iter_39_1 in ipairs(arg_39_1) do
			local var_39_4 = self:__get_strengthen_have_levels(iter_39_1, arg_39_3)
			local var_39_5, var_39_6 = self:__get_useful_and_waste(var_39_4, var_39_0)

			if var_39_5 > 0 then
				var_0_9(var_39_1, iter_39_1)

				var_39_2[iter_39_1.id] = true
				var_39_3[iter_39_1.id] = var_39_5

				self:__remove_strengthen_remain(var_39_0, var_39_4)
			end
		end

		return var_39_1, var_39_2, var_39_3
	end

	function arg_1_0:__auto_plan_strengthen_res(arg_40_1)
		local var_40_0 = self:__get_strengthen_remain_exp(arg_40_1)
		local var_40_1 = false

		for iter_40_0, iter_40_1 in ipairs({
			"atk",
			"torpedo",
			"def",
			"air_def"
		}) do
			if (var_40_0[iter_40_1] or 0) > 0 then
				var_40_1 = true

				break
			end
		end

		if not var_40_1 then
			var_0_5:show("该舰船强化已满")

			return
		end

		local var_40_3 = {}
		local var_40_4 = self._cell_data

		if not self._cell_data or not next(var_40_4) then
			var_40_4 = self:__filter_fast_all_character_list()
		end

		for iter_40_2, iter_40_3 in ipairs(var_40_4) do
			if iter_40_3 and iter_40_3.id and not iter_40_3.lock then
				var_0_9(var_40_3, iter_40_3)
			end
		end

		if #var_40_3 == 0 then
			var_0_5:show(var_0_10:getNowLang("auto_strengthen_null"))

			return
		end

		local var_40_5 = {}
		local var_40_6 = {}
		local var_40_7 = {}

		while var_0_16.max_select_type.eighty > #var_40_5 do
			local var_40_8 = 0
			local var_40_9 = 0

			for iter_40_4, iter_40_5 in ipairs({
				"atk",
				"torpedo",
				"def",
				"air_def"
			}) do
				local var_40_10 = var_40_0[iter_40_5] or 0

				if var_40_10 > 0 then
					var_40_8 = var_40_8 + 1
					var_40_9 = var_40_10
				end
			end

			if var_40_8 == 0 then
				break
			end

			local var_40_11
			local var_40_12 = 0
			local var_40_13 = 0
			local var_40_14 = -1

			for iter_40_6, iter_40_7 in ipairs(var_40_3) do
				if not var_40_6[iter_40_7.id] then
					local var_40_15, var_40_16 = self:__get_useful_and_waste(self:__get_strengthen_have_exp(iter_40_7), var_40_0)

					if var_40_15 > 0 then
						local var_40_17 = self:__get_dismantle_sum(iter_40_7)
						local var_40_18 = self:__get_strengthen_value(var_40_15, var_40_16, iter_40_7)

						if var_40_14 < var_40_18 or var_40_18 == var_40_14 and var_40_12 < var_40_15 or var_40_18 == var_40_14 and var_40_15 == var_40_12 and var_40_16 < var_40_13 then
							var_40_11 = iter_40_7
							var_40_12 = var_40_15
							var_40_13 = var_40_16
							var_40_14 = var_40_18
						end
					end
				end
			end

			if not var_40_11 then
				break
			end

			local var_40_19 = self:__get_dismantle_sum(var_40_11)

			if var_40_8 == 1 and var_40_12 < var_40_13 and var_40_9 > var_40_12 * 10 then
				break
			end

			var_0_9(var_40_5, var_40_11)

			var_40_6[var_40_11.id] = true
			var_40_7[var_40_11.id] = var_40_12

			local var_40_20 = self:__get_strengthen_have_exp(var_40_11)

			for iter_40_8, iter_40_9 in ipairs({
				"atk",
				"torpedo",
				"def",
				"air_def"
			}) do
				var_40_0[iter_40_9] = math.max(0, (var_40_0[iter_40_9] or 0) - (var_40_20[iter_40_9] or 0))
			end
		end

		local var_40_22 = {}
		local var_40_23 = {}
		local var_40_24 = {}
		local var_40_25 = self:__get_strengthen_remain_exp(arg_40_1)

		for iter_40_10, iter_40_11 in ipairs(var_40_5) do
			local var_40_26 = self:__get_strengthen_have_exp(iter_40_11)
			local var_40_27, var_40_28 = self:__get_useful_and_waste(var_40_26, var_40_25)

			if var_40_27 > 0 then
				var_0_9(var_40_22, iter_40_11)

				var_40_23[iter_40_11.id] = true
				var_40_24[iter_40_11.id] = var_40_27

				for iter_40_12, iter_40_13 in ipairs({
					"atk",
					"torpedo",
					"def",
					"air_def"
				}) do
					var_40_25[iter_40_13] = math.max(0, (var_40_25[iter_40_13] or 0) - (var_40_26[iter_40_13] or 0))
				end
			end
		end

		if #var_40_22 == 0 then
			var_0_5:show(var_0_10:getNowLang("auto_strengthen_null"))

			return
		end

		self._team_data = {}
		self._ships_for_remould_id_list = {}
		self._prepare_disassemble_data = self._ships_for_remould_id_list

		for iter_40_14, iter_40_15 in ipairs(var_40_22) do
			self:update_fast_team_index(iter_40_15, var_0_16.max_select_type.eighty, true)
		end

		local var_40_30 = {}

		for iter_40_16, iter_40_17 in ipairs(self._ships_for_remould_id_list) do
			var_40_30[iter_40_17] = iter_40_16
		end

		local var_40_31 = {}
		local var_40_32 = {}

		for iter_40_18, iter_40_19 in ipairs(self._cell_data) do
			if iter_40_19 and iter_40_19.id and var_40_30[iter_40_19.id] then
				var_40_31[var_40_30[iter_40_19.id]] = iter_40_19
			else
				var_0_9(var_40_32, iter_40_19)
			end
		end

		local var_40_33 = {}

		for iter_40_20 = 1, #self._ships_for_remould_id_list do
			if var_40_31[iter_40_20] then
				var_0_9(var_40_33, var_40_31[iter_40_20])
			end
		end

		for iter_40_21, iter_40_22 in ipairs(var_40_32) do
			var_0_9(var_40_33, iter_40_22)
		end

		self._cell_data = var_40_33

		self:__update_reusable_cell()
		self:update_all_cell_number_setting()
		self:update_strengthen_info()

		if (self._control.sort_type_btn.sort_txt.text.text ~= var_0_10:getNowLang("questall") or nil) and false then
			var_0_5:show(var_0_10:getNowLang("auto_strengthen_success"))
		else
			var_0_5:show(var_0_10:getNowLang("auto_strengthen_filter"))
		end
	end

	function arg_1_0:play_enlarge_animation()
		if self._enter_req then
			return
		end

		self._enter_req = self:autoKillDOTween(var_0_12.Sequence())

		local var_41_0 = self._panel.transform:GetComponent("CanvasGroup")

		var_41_0.blocksRaycasts = false
		self._control.all_ship.transform.parent.localScale = Vector3.New(0, 0, 0)

		self._enter_req:AppendCallback(function()
			self._panel.transform:DOScale(1, 0.3):SetEase(DG.Tweening.Ease.OutBack):OnComplete(function()
				var_41_0.blocksRaycasts = true
				self._enter_req = nil
			end)

			local var_42_0 = self:autoKillDOTween(var_0_12.Sequence())

			var_42_0:AppendCallback(function()
				var_41_0:DOFade(0, 0)
			end)
			var_42_0:AppendInterval(0.01)
			var_42_0:AppendCallback(function()
				var_41_0:DOFade(1, 0)
				self:__update_edge_mask()

				self._control.all_ship:GetComponent("ScrollRect").enabled = false

				if self.content_pos and self._enter_type ~= var_0_16.enter_select_member_type.strengthen and self._enter_type ~= var_0_16.enter_select_member_type.strengthen_res and self._enter_type ~= var_0_16.enter_select_member_type.dock_disassemble then
					self._control.all_ship.Viewport.edge_mask.Content.transform.anchoredPosition = self.content_pos
				end

				self._control.all_ship:GetComponent("ScrollRect").enabled = true
			end)
		end)
	end

	function arg_1_0:__inite_language()
		self._control.bg_container.tip_title.text.text = var_0_10:getNowLang("select_team_basic")

		self._control.bg_container.select_team_basic:SetActive(false)

		self._control.bg_container.ship_capacity.dockcapacity.text.text = var_0_10:getNowLang("dockcapacity")
		self._control.detail_btn.pvpdetailbtn.text.text = var_0_10:getNowLang("pvpdetailbtn")
		self._control.full_strengthen_btn.fullstrengthen.text.text = var_0_10:getNowLang("fullstrengthen")
		self._control.full_skill_btn.fullskill.text.text = var_0_10:getNowLang("fullskill")
		self._control.strengthen_info.atk_title.text.text = var_0_10:getNowLang("atk")
		self._control.strengthen_info.tor_title.text.text = var_0_10:getNowLang("torpedo")
		self._control.auto_select_confirm_btn.auto_select_txt.text.text = var_0_10:getNowLang("auto_strengthen")
		self._control.strengthen_info.def_title.text.text = var_0_10:getNowLang("def")
		self._control.strengthen_info.airDef_title.text.text = var_0_10:getNowLang("airdef")
		self._control.research_ship_info.bg.need_text.text.text = var_0_10:getNowLang("research_need")
		self._control.research_ship_info.bg.have_text.text.text = var_0_10:getNowLang("research_choose")
		self._control.confirm_btn.confirm.text.text = var_0_10:getNowLang("confirm")
		self._control.fast_btn.changefleetfast.text.text = var_0_10:getNowLang("changefleetfast")
		self._control.bg_container.select_team_basic.text.text = self._enter_type == var_0_16.enter_select_member_type.six_year_primary and var_0_10:getNowLang("select_cur_map") or var_0_10:getNowLang("select_team_basic")
		self._control.all_ship_info.all_ship_info_txt.text.text = var_0_10:getNowLang("show_state")
		self._control.all_ship_info.all_ship_btn_txt.text.text = var_0_10:getNowLang("equip0") .. var_0_10:getNowLang("leaderboardship")
		self._control.custom_editor_btn.custom_editor.text.text = var_0_10:getNowLang("custom_editor_btn")
		self._control.cancel_editor_btn.cancel_editor_txt.text.text = var_0_10:getNowLang("ui_tower_floor_reset")
		self._control.comfirm_custom_btn.comfirm_custom_txt.text.text = var_0_10:getNowLang("save")
	end

	function arg_1_0:get_guide_btn_pos_info(arg_47_1)
		if arg_47_1 == var_0_16.guide_const_id.eight_group.three then
			return self._record_ship_btn.transform
		end
	end

	function arg_1_0:__init_panel()
		self:_play_into_se(var_0_16:get_audio_url(var_0_16.common_icon.music_path, var_0_16.open))

		if not self._is_already_init then
			self._control.sort_order_btn.sorttype.text.text = var_0_10:getNowLang("sorttype")
			self._control.sort_order_btn.sort_txt.text.text = var_0_1:get_cook_common_state() and var_0_10:getNowLang("goodat") .. var_0_10:getNowLang("arrow_down") or var_0_10:getNowLang("sorttypes3")
			self._control.sort_type_btn.type.text.text = var_0_10:getNowLang("type")
			self._control.sort_type_btn.sort_txt.text.text = var_0_10:getNowLang("questall")

			self:get_sort_layer()
			self:get_type_layer()
			self._control.bg_container.search.inputField.onEndEdit:AddListener(function()
				if self._control.bg_container.search.inputField.text ~= "" then
					self._filter_name = self._control.bg_container.search.inputField.text

					local var_49_0, var_49_1 = var_0_6(self._filter_name, "%(")

					if var_49_0 ~= nil and var_49_1 ~= nil then
						self._filter_name = var_0_15._str_insert(self._filter_name, var_49_0, "%")
					end

					self:update_content()
				end
			end)
			self:__init_ship_list()

			self._is_already_init = true
		end

		if var_0_1:get_cook_common_state() then
			self._control.sort_order_btn.sort_txt.text.text = var_0_10:getNowLang("goodat") .. var_0_10:getNowLang("arrow_down")
		end

		if self._limit_type then
			self._type_layer:set_type_limit(self._limit_type)
			self._type_layer:change_type_text(self._control.sort_type_btn.sort_txt)

			self._limit_type = nil
		end

		self._control.ship_six_info:SetActive(self._enter_type == var_0_16.enter_select_member_type.six_year_primary)
		self._control.all_ship_info:SetActive(self._enter_type ~= var_0_16.enter_select_member_type.six_year_primary)

		if self._enter_type == var_0_16.enter_select_member_type.strengthen_res or self._enter_type == var_0_16.enter_select_member_type.research_ship then
			self._control.all_ship_info:SetActive(false)
		end

		if self._enter_type == var_0_16.enter_select_member_type.six_year_primary then
			self._control.custom_editor_btn:SetActive(false)
		end

		self._control.confirm_btn:GetComponent("Button").interactable = true
		self._control.confirm_btn.image.sprite = self:loadSprite(var_0_16.ship_detail_switch.open)

		if not self._is_dock_team_change and not self._is_already_init and self._enter_type ~= var_0_16.enter_select_member_type.dormitory then
			self:__update_edge_mask()
		end

		if not self._is_nf then
			self._control.bg_container.ship_capacity:SetActive(true)
			self:__update_capacity()
		else
			self._control.bg_container.ship_capacity:SetActive(false)
			self._control.all_ship_info:SetActive(false)
		end

		if self._enter_type == var_0_16.enter_select_member_type.war_concerto_play then
			self:__init_character_data_list_for_concerto_play()
		else
			self:__init_character_data_list()
		end

		if self._panel_type == var_0_16.enter_select_member_type.custom_ship then
			self._control.all_ship_info:SetActive(false)
			self._control.custom_editor_btn:SetActive(false)
			self._control.fast_btn:SetActive(false)
		end

		if self._iscustom_state then
			self._control.custom_editor_btn:SetActive(true)
		else
			self:show_all_ship_panel()
			self._control.custom_editor_btn:SetActive(false)
		end

		self:update_content()
	end

	function arg_1_0:get_sort_layer()
		self._sort_layer = self._sort_layer or self:loadUI("sort_layer_2")

		self._sort_layer:show(false)
		self._sort_layer._panel.transform:SetParent(self._control.sort_layer.rectTransform, false)
		self._sort_layer:set_listener(self, self.sort_layer_toggle_on)
	end

	function arg_1_0:get_type_layer()
		self._type_layer = self._type_layer or self:loadUI("type_layer")

		self._type_layer:show(false)
		self._type_layer._panel.transform:SetParent(self._control.type_layer.rectTransform, false)
		self._type_layer:set_listener(self, self.type_layer_confirm_btn_on)
	end

	function arg_1_0:set_scrollbar()
		self.scrollbar_value = self._control.all_ship.Scrollbar:GetComponent("Scrollbar").value
		self.select_member_content_pos = self._control.all_ship.Viewport.edge_mask.Content.transform.anchoredPosition
	end

	function arg_1_0:get_scrollbar()
		self._control.all_ship.Scrollbar:GetComponent("Scrollbar").value = self.scrollbar_value
		self._control.all_ship.Viewport.edge_mask.Content.transform.anchoredPosition = self.select_member_content_pos
	end

	function arg_1_0:__update_edge_mask()
		self._control.all_ship.Viewport.edge_mask.Content.transform.anchoredPosition = var_0_13(0, 0)
	end

	function arg_1_0:__init_content_by_type()
		self._control.fast_btn:SetActive(false)
		self._control.bg_container.ship_capacity:SetActive(true)
		self._control.detail_btn:SetActive(true)
		self._control.sort_order_btn:SetActive(true)
		self._control.sort_type_btn:SetActive(true)
		self._control.bg_pic:SetActive(false)

		local var_55_0 = false

		if self._enter_type == var_0_16.enter_select_member_type.six_year_primary then
			local var_55_1 = {}

			for iter_55_0, iter_55_1 in pairs((var_0_1:get_bigmap_info())) do
				var_0_9(var_55_1, iter_55_1)
			end

			local var_55_2 = var_0_1:get_sixth_combat_info()
			local var_55_3 = var_0_1:get_cur_sixth_map()
			local var_55_4 = var_0_1:get_clear_map_info()
			local var_55_5 = var_0_18.find_object_by_id(self._map_id).level_id
			local var_55_6

			for iter_55_2, iter_55_3 in pairs(var_55_1) do
				if iter_55_3.id == var_55_5 then
					var_55_6 = iter_55_3
				end
			end

			self._start_map_info = var_55_6

			if var_55_6 and next(var_55_6) and var_55_6.state ~= 1 then
				if var_55_6.members and next(var_55_6.members) then
					var_55_0 = true
				end
			else
				var_55_0 = false
			end
		end

		self._control.auto_btn:SetActive(var_55_0)

		if var_55_0 then
			self:set_is_button_postion()
		end

		self._control.auto_btn.changefleetfast.text.text = var_0_10:getNowLang("last_select_team")

		self._control.full_strengthen_btn:SetActive(self._enter_type == var_0_16.enter_select_member_type.strengthen)

		if self._enter_type == var_0_16.enter_select_member_type.strengthen_res then
			self._control.strengthen_info:SetActive(true)
			self._control.auto_select_confirm_btn:SetActive(true)
		else
			self._control.strengthen_info:SetActive(false)
			self._control.auto_select_confirm_btn:SetActive(false)
		end

		self._control.research_ship_info:SetActive(self._enter_type == var_0_16.enter_select_member_type.research_ship)
		self._control.full_skill_btn:SetActive(self._enter_type == var_0_16.enter_select_member_type.skill)

		if self._enter_type == var_0_16.enter_select_member_type.dock_disassemble then
			self._control.bg_container.search:SetActive(true)
			self._control.confirm_btn:SetActive(true)

			self._is_fast_formation = true
			self._control.bg_container.select_team_basic.text.text = var_0_10:getNowLang("select_team_basic")
		elseif self._enter_type == var_0_16.enter_select_member_type.strengthen then
			self._control.bg_container.search:SetActive(true)
			self._control.confirm_btn:SetActive(false)

			self._is_fast_formation = false
			self._full_strengthen_flag = false
			self._control.bg_container.select_team_basic.text.text = var_0_10:getNowLang("strengthentargettitle")
		elseif self._enter_type == var_0_16.enter_select_member_type.strengthen_res then
			self._control.bg_container.search:SetActive(true)
			self._control.confirm_btn:SetActive(true)

			self._is_fast_formation = true
			self._control.bg_container.select_team_basic.text.text = var_0_10:getNowLang("strengthenmaterialtitle")
		elseif self._enter_type == var_0_16.enter_select_member_type.research_ship then
			self._control.bg_container.search:SetActive(false)
			self._control.confirm_btn:SetActive(true)

			self._is_fast_formation = true
			self._control.bg_container.select_team_basic.text.text = var_0_10:getNowLang("select_team_basic")
			self._control.research_ship_info.research_confirm_fast_btn.research_confirm_fast_btn_txt.text.text = var_0_10:getNowLang("all_select")
			self._control.research_ship_info.research_clearall_fast_btn.research_clearall_fast_btn_txt.text.text = var_0_10:getNowLang("cancel_select")

			self._control.all_ship_info:SetActive(false)
		elseif self._enter_type == var_0_16.enter_select_member_type.evo then
			self._control.bg_container.search:SetActive(true)
			self._control.confirm_btn:SetActive(false)

			self._is_fast_formation = false
			self._control.bg_container.select_team_basic.text.text = var_0_10:getNowLang("evotargettitle")
		elseif self._enter_type == var_0_16.enter_select_member_type.skill then
			self._control.bg_container.search:SetActive(true)
			self._control.confirm_btn:SetActive(false)

			self._is_fast_formation = false

			if self._full_skill_flag == nil then
				self._full_skill_flag = false
			end

			self._control.bg_container.select_team_basic.text.text = var_0_10:getNowLang("skillselecttargettitle")
		elseif self._enter_type == var_0_16.enter_select_member_type.restaurant then
			self._control.bg_container.search:SetActive(true)
			self._control.confirm_btn:SetActive(true)
			self._control.detail_btn:SetActive(false)

			self._is_fast_formation = false
		elseif self._enter_type == var_0_16.enter_select_member_type.college then
			self._control.bg_container.search:SetActive(true)
			self._control.detail_btn:SetActive(false)
			self._control.confirm_btn:SetActive(false)

			self._is_fast_formation = false
		elseif self._enter_type == var_0_16.enter_select_member_type.captainroom_fleet then
			self._control.bg_container.search:SetActive(true)
			self._control.confirm_btn:SetActive(true)
			self._control.detail_btn:SetActive(true)

			self._is_fast_formation = true
			self._detail_index = var_0_16.dock_detail_layer.once
		elseif self._enter_type == var_0_16.enter_select_member_type.dormitory then
			self._control.bg_container.search:SetActive(true)
			self._control.confirm_btn:SetActive(true)
			self._control.detail_btn:SetActive(false)

			self._is_fast_formation = true
		elseif self._enter_type == var_0_16.enter_select_member_type.six_year_primary then
			self._control.confirm_btn:SetActive(true)
			self._control.bg_container.ship_capacity:SetActive(false)
			self._control.bg_container.search:SetActive(false)
			self._control.fast_btn:SetActive(false)

			self._is_fast_formation = true

			self:__update_select_ship_info()

			self._control.bg_container.select_team_basic.text.text = var_0_10:getNowLang("select_cur_map")
		elseif self._enter_type == var_0_16.enter_select_member_type.six_year_map_select then
			self._control.bg_container.search:SetActive(false)
			self._control.fast_btn:SetActive(true)
			self._control.confirm_btn:SetActive(false)

			self._is_fast_formation = false

			if self._is_nf then
				self._control.sort_order_btn:SetActive(false)
				self._control.sort_type_btn:SetActive(false)
				self._control.fast_btn:SetActive(false)
			end
		elseif self._enter_type == var_0_16.enter_select_member_type.war_concerto_play then
			self._control.bg_container.search:SetActive(false)
			self._control.confirm_btn:SetActive(false)
			self._control.bg_container.ship_capacity:SetActive(false)
			self._control.detail_btn:SetActive(false)
			self._control.sort_order_btn:SetActive(false)
			self._control.sort_type_btn:SetActive(false)
			self._control.bg_pic:SetActive(true)

			self._is_fast_formation = false
		elseif self._enter_type == var_0_16.enter_select_member_type.pre_formation then
			self._control.bg_container.search:SetActive(true)
			self._control.confirm_btn:SetActive(true)
			self._control.detail_btn:SetActive(true)

			self._is_fast_formation = true
		elseif self._enter_type == var_0_16.enter_select_member_type.secretary_info_ship then
			self._control.fast_btn:SetActive(false)
			self._control.confirm_btn:SetActive(true)
			self._control.all_ship_info.custom_ship_2:SetActive(false)

			self._is_fast_formation = true
		else
			self._control.bg_container.search:SetActive(true)
			self._control.fast_btn:SetActive(true)
			self._control.confirm_btn:SetActive(false)

			self._is_fast_formation = false
		end

		if self._campaign then
			self._control.fast_btn:SetActive(false)
		end
	end

	function arg_1_0:__get_sixth_member_count()
		local var_56_0 = 0
		local var_56_1 = 0
		local var_56_2 = 0

		for iter_56_0, iter_56_1 in pairs(self._team_data) do
			local var_56_3 = var_0_17.find_object_by_cid(var_0_1:find_character_by_id(iter_56_1).cid)

			if var_56_3.ship_ton == 1 then
				var_56_0 = var_56_0 + 1
			elseif var_56_3.ship_ton == 2 then
				var_56_1 = var_56_1 + 1
			elseif var_56_3.ship_ton == 3 then
				var_56_2 = var_56_2 + 1
			end
		end

		return var_56_0, var_56_1, var_56_2
	end

	function arg_1_0:__update_select_ship_info()
		if self._is_nf then
			return
		end

		self._control.ship_six_info.small_ship.text.text = var_0_10:getNowLang("shipton1")
		self._control.ship_six_info.middle_ship.text.text = var_0_10:getNowLang("shipton2")
		self._control.ship_six_info.big_ship.text.text = var_0_10:getNowLang("shipton3")

		local var_57_0, var_57_1, var_57_2 = self:__get_sixth_member_count()

		self._small_ship_count = var_57_0
		self._middle_ship_count = var_57_1
		self._big_ship_count = var_57_2
		self._bigmap_info = var_0_1:get_now_map_level()

		local var_57_3 = var_0_20.find_object_by_id(self._bigmap_info)

		if var_57_3 and next(var_57_3.shipton_num) then
			local var_57_4 = var_57_3.shipton_num

			self._shipton_num_small = var_57_3.shipton_num[1]
			self._shipton_num_middle = var_57_4[2]
			self._shipton_num_big = var_57_4[3]
			self._control.ship_six_info.small_ship_count.text.text = var_0_14("<color=%s>%s/%s</color>", var_57_0 < var_57_4[1] and "#F10000" or "#2bc6f8", var_57_0, var_57_4[1])
			self._control.ship_six_info.middle_ship_count.text.text = var_0_14("<color=%s>%s/%s</color>", var_57_1 < var_57_4[2] and "#F10000" or "#2bc6f8", var_57_1, var_57_4[2])
			self._control.ship_six_info.big_ship_count.text.text = var_0_14("<color=%s>%s/%s</color>", var_57_2 < var_57_4[3] and "#F10000" or "#2bc6f8", var_57_2, var_57_4[3])
		else
			self._control.ship_six_info.small_ship_count.text.text = ""
			self._control.ship_six_info.middle_ship_count.text.text = ""
			self._control.ship_six_info.big_ship_count.text.text = ""
			self._control.ship_six_info.small_ship.text.text = ""
			self._control.ship_six_info.middle_ship.text.text = ""
			self._control.ship_six_info.big_ship.text.text = ""
		end
	end

	function arg_1_0:__update_sixth()
		local var_58_0 = var_0_1:get_use_info_data()
		local var_58_1 = var_0_1:get_sixth_combat_info().ship or {}
		local var_58_2 = var_0_15.dict_lenght(var_0_1:get_character_list())
		local var_58_3 = var_0_1:get_sixth_bigmap_info()

		self._control.confirm_btn:SetActive(self._enter_type ~= var_0_16.enter_select_member_type.six_year_map_select)

		self._control.bg_container.ship_capacity.amount_txt.text.text = var_0_14("%d/%d", #var_58_1, var_58_0.max_ship)
	end

	function arg_1_0:__update_capacity()
		self._control.bg_container.ship_capacity.amount_txt.text.text = var_0_14("%d/%d", var_0_15.dict_lenght(var_0_1:get_character_list()), var_0_1:get_use_info_data().max_ship)
	end

	function arg_1_0:__update_search_name()
		self._filter_name = nil
		self._control.bg_container.search.inputField.text = ""
	end

	function arg_1_0:__filter_fast_character_list()
		local var_61_0 = {}
		local var_61_1 = {}

		if self._iscustom_state then
			local var_61_2 = var_0_1:get_character_list()
			local var_61_3 = var_0_1:get_custom_ship_list()

			if #var_61_3 < 1 then
				return
			end

			for iter_61_0, iter_61_1 in ipairs(var_61_3) do
				var_0_9(var_61_1, (var_0_1:find_character_by_id(iter_61_1)))
			end
		else
			var_61_1 = var_0_1:get_character_list()
		end

		for iter_61_2, iter_61_3 in pairs(var_61_1) do
			local var_61_4 = true
			local var_61_5 = self:__get_team_index()
			local var_61_7 = var_0_1:get_team_data((var_61_5 > 8 or nil) and 3, self:__get_team_index())

			if self._enter_type == var_0_16.enter_select_member_type.strike_map_select then
				var_61_7 = nil
			end

			if var_61_7 and var_0_15.have_data(var_61_7.members, iter_61_3.id) then
				var_61_4 = not not ((self._enter_type == var_0_16.enter_select_member_type.dormitory or self._enter_type == var_0_16.enter_select_member_type.captainroom_fleet) and self._iscustom_state)
			end

			if (self._is_already_fast_init and self._team_data and var_0_15.have_data(self._team_data, iter_61_3.id) or nil) and false then
				local var_61_8 = 0

				if self._enter_type ~= var_0_16.enter_select_member_type.pre_formation and self._is_fast_formation and self._is_custom_formation and var_61_5 > 4 then
					var_61_8 = var_0_1:get_team_all_data()[1][1].members[1]
				end

				iter_61_3.team_num = var_0_1:get_team_index_by_id(var_0_16.team_type.normal, iter_61_3.id) or var_0_1:get_team_index_by_id(var_0_16.team_type.expedition, iter_61_3.id)

				if iter_61_3.id ~= var_61_8 then
					var_0_9(var_61_0, iter_61_3)
				end

				if (self._enter_type == var_0_16.enter_select_member_type.dormitory or self._enter_type == var_0_16.enter_select_member_type.captainroom_fleet) and self._iscustom_state and iter_61_3.id == var_61_8 then
					var_0_9(var_61_0, iter_61_3)
				end
			end
		end

		local var_61_9 = self:__filter_table_by_name(var_61_0)

		return (self:__sort_table_by_rule(self._enter_type == var_0_16.enter_select_member_type.strengthen and self:__sort_table_by_type(var_61_9, nil, "rebuild", true) or self._enter_type == var_0_16.enter_select_member_type.strengthen_res and self:__sort_table_by_type(var_61_9, nil, "rebuild", false) or self:__sort_table_by_type(var_61_9)))
	end

	function arg_1_0:__filter_custom_character_list(arg_62_1)
		local var_62_0 = {}
		local var_62_1 = var_0_1:get_character_list()
		local var_62_2 = {}

		var_62_2 = self._custom_team_data and next(self._custom_team_data) and self._custom_team_data or var_0_1:get_custom_ship_list()

		for iter_62_0, iter_62_1 in pairs(var_62_1) do
			local var_62_3 = not (var_62_2 and var_0_15.have_data(var_62_2, iter_62_1.id))

			if (self._is_already_custom_init and self._custom_team_data and var_0_15.have_data(self._custom_team_data, iter_62_1.id) or nil) and false then
				local var_62_4 = 0

				if self._enter_type ~= var_0_16.enter_select_member_type.pre_formation and self._is_custom_formation == false then
					var_62_4 = var_0_1:get_team_all_data()[1][1].members[1]
				end

				iter_62_1.team_num = var_0_1:get_team_index_by_id(var_0_16.team_type.normal, iter_62_1.id) or var_0_1:get_team_index_by_id(var_0_16.team_type.expedition, iter_62_1.id)

				if iter_62_1.id ~= var_62_4 then
					var_0_9(var_62_0, iter_62_1)
				end
			end
		end

		local var_62_5 = self:__filter_table_by_name(var_62_0)

		return (self:__sort_table_by_rule(self._enter_type == var_0_16.enter_select_member_type.strengthen and self:__sort_table_by_type(var_62_5, nil, "rebuild", true) or self._enter_type == var_0_16.enter_select_member_type.strengthen_res and self:__sort_table_by_type(var_62_5, nil, "rebuild", false) or self:__sort_table_by_type(var_62_5)))
	end

	function arg_1_0:__update_cell_data_by_cid(arg_63_1)
		if not self._cell_data then
			return
		end

		for iter_63_0, iter_63_1 in pairs(self._cell_data) do
			if iter_63_1.id == arg_63_1 then
				local var_63_0 = var_0_1:find_character_by_id(arg_63_1)

				self._cell_data[iter_63_0] = var_63_0 and var_0_15.little_clone(var_63_0) or {}
			end
		end

		self:get_scrollbar()
	end

	function arg_1_0:__filter_fast_all_character_list(arg_64_1, arg_64_2)
		local var_64_0

		if arg_64_1 then
			for iter_64_0, iter_64_1 in pairs(self._character_data_list) do
				if iter_64_1.id == arg_64_2 then
					self._character_data_list[iter_64_0] = var_0_1:find_character_by_id(arg_64_2)
				end
			end

			var_64_0 = self._character_data_list
		else
			local var_64_1 = var_0_1:get_character_list()

			var_64_0 = var_64_1 and var_0_15.little_clone(var_64_1) or {}

			local var_64_2 = {}

			if self._enter_type == var_0_16.enter_select_member_type.evo then
				for iter_64_2, iter_64_3 in pairs(var_64_0) do
					if var_0_17.find_object_by_cid(iter_64_3.cid).can_evo then
						var_0_9(var_64_2, iter_64_3)
					end
				end

				var_64_0 = var_64_2
			elseif self._enter_type == var_0_16.enter_select_member_type.skill then
				for iter_64_4, iter_64_5 in pairs(var_64_0) do
					local var_64_3 = var_0_1:find_character_by_id(iter_64_5.id)

					if var_64_3 and #var_64_3.skills > 0 then
						var_0_9(var_64_2, iter_64_5)
					end
				end

				var_64_0 = var_64_2
			elseif self._enter_type == var_0_16.enter_select_member_type.strengthen then
				for iter_64_6, iter_64_7 in pairs(var_64_0) do
					if not self:__found_in_disassemble_data(iter_64_7.id) then
						var_0_9(var_64_2, iter_64_7)
					end
				end

				var_64_0 = var_64_2
			elseif self._enter_type == var_0_16.enter_select_member_type.six_year_map_select then
				if self._is_nf then
					var_64_0 = var_0_1:get_mist_combat_info().ship or {}
				else
					local var_64_4 = var_0_1:get_sixth_combat_info()

					var_64_0 = var_64_4.ship or {}

					local var_64_5 = var_64_4.members or {}
					local var_64_6 = {}
					local var_64_7 = {}

					for iter_64_8, iter_64_9 in pairs(var_64_5) do
						if next(var_64_5) then
							var_0_9(var_64_6, (var_0_1:find_character_by_id(iter_64_9)))
						end
					end

					for iter_64_10, iter_64_11 in pairs(var_64_0) do
						local var_64_10 = var_0_1:find_character_by_id(iter_64_11.id)
						local var_64_11 = true

						for iter_64_12, iter_64_13 in ipairs(var_64_5) do
							if iter_64_13 == iter_64_11.id then
								var_64_11 = false
							end
						end

						if var_64_11 then
							var_0_9(var_64_7, var_64_10)
						end
					end

					for iter_64_14, iter_64_15 in pairs(var_64_7) do
						var_0_9(var_64_6, iter_64_15)
					end

					var_64_0 = self._is_fast_formation and var_64_6 or var_64_7
				end
			elseif self._enter_type == var_0_16.enter_select_member_type.strike_map_select then
				local var_64_12 = var_0_1:get_strike_team_data()
				local var_64_13 = var_64_12 and var_0_15.little_clone(var_64_12) or {}

				self._ships_for_strike_id_list = var_64_13
				var_64_0 = var_0_1:get_character_list() or {}

				local var_64_14 = var_64_13 or {}

				for iter_64_16, iter_64_17 in pairs(self._team_data) do
					local var_64_15 = false

					for iter_64_18, iter_64_19 in pairs(var_64_13) do
						if iter_64_17 == iter_64_19 then
							var_64_15 = true
						end
					end

					if not var_64_15 then
						var_0_9(var_64_14, iter_64_17)
					end
				end

				self._ships_for_strike_list = {}

				for iter_64_20, iter_64_21 in pairs(var_64_0) do
					local var_64_16 = true

					for iter_64_22, iter_64_23 in ipairs(var_64_14) do
						if iter_64_23 == iter_64_21.id then
							self._ships_for_strike_list[iter_64_22] = iter_64_21
							var_64_16 = false
						end
					end

					if var_64_16 then
						var_0_9(var_64_2, (var_0_1:find_character_by_id(iter_64_21.id)))
					end
				end

				var_64_0 = var_64_2
			elseif self._enter_type == var_0_16.enter_select_member_type.abyss_dock_team_formation then
				local var_64_17 = var_0_1:get_normal_team_info()
				local var_64_18 = var_64_17 and var_0_15.little_clone(var_64_17) or {}

				self._ships_for_abyss_dock_id_list = var_64_18
				var_64_0 = var_0_1:get_character_list() or {}

				local var_64_19 = var_64_18 or {}

				for iter_64_24, iter_64_25 in pairs(self._team_data) do
					local var_64_20 = false

					for iter_64_26, iter_64_27 in pairs(var_64_18) do
						if iter_64_25 == iter_64_27 then
							var_64_20 = true
						end
					end

					if not var_64_20 then
						var_0_9(var_64_19, iter_64_25)
					end
				end

				self._ships_for_abyss_list = {}

				for iter_64_28, iter_64_29 in pairs(var_64_0) do
					local var_64_21 = true

					for iter_64_30, iter_64_31 in ipairs(var_64_19) do
						if iter_64_31 == iter_64_29.id then
							self._ships_for_abyss_list[iter_64_30] = iter_64_29
							var_64_21 = false
						end
					end

					if var_64_21 then
						var_0_9(var_64_2, (var_0_1:find_character_by_id(iter_64_29.id)))
					end
				end

				var_64_0 = var_64_2
			elseif self._enter_type == var_0_16.enter_select_member_type.ocean_attack_map_select then
				local var_64_22 = var_0_1:get_ocean_team_data()
				local var_64_23 = var_64_22 and var_0_15.little_clone(var_64_22) or {}

				self._ships_for_ocean_id_list = var_64_23
				var_64_0 = var_0_1:get_character_list() or {}

				local var_64_24 = var_64_23 or {}

				for iter_64_32, iter_64_33 in pairs(self._team_data) do
					local var_64_25 = false

					for iter_64_34, iter_64_35 in pairs(var_64_23) do
						if iter_64_33 == iter_64_35 then
							var_64_25 = true
						end
					end

					if not var_64_25 then
						var_0_9(var_64_24, iter_64_33)
					end
				end

				self._ships_for_ocean_list = {}

				for iter_64_36, iter_64_37 in pairs(var_64_0) do
					local var_64_26 = true

					for iter_64_38, iter_64_39 in ipairs(var_64_24) do
						if iter_64_39 == iter_64_37.id then
							self._ships_for_ocean_list[iter_64_38] = iter_64_37
							var_64_26 = false
						end
					end

					if var_64_26 then
						var_0_9(var_64_2, (var_0_1:find_character_by_id(iter_64_37.id)))
					end
				end

				var_64_0 = var_64_2
			end
		end

		local var_64_27 = {}

		for iter_64_40, iter_64_41 in pairs(var_64_0) do
			if self._enter_type == var_0_16.enter_select_member_type.dock_disassemble or self._enter_type == var_0_16.enter_select_member_type.strengthen_res or self._enter_type == var_0_16.enter_select_member_type.research_ship then
				local var_64_28 = false

				for iter_64_42, iter_64_43 in pairs(self._remove_ship_list) do
					if iter_64_41.id == iter_64_43 then
						var_64_28 = true
					end
				end

				if iter_64_41.state == var_0_16.ship_state.free and not iter_64_41.lock and not var_64_28 then
					if self._config_data then
						if self._config_data.id ~= iter_64_41.id then
							var_0_9(var_64_27, iter_64_41)
						end
					else
						var_0_9(var_64_27, iter_64_41)
					end
				end
			elseif self._enter_type == var_0_16.enter_select_member_type.dock_team or self._enter_type == var_0_16.enter_select_member_type.dock_team_empty or self._enter_type == var_0_16.enter_select_member_type.fight then
				local var_64_29 = var_0_1:get_team_index_by_id(1, iter_64_41.id)

				iter_64_41.team_num = var_64_29 ~= 0 and var_64_29 or var_0_1:get_team_index_by_id(2, iter_64_41.id)

				var_0_9(var_64_27, iter_64_41)
			elseif self._enter_type == var_0_16.enter_select_member_type.tower then
				iter_64_41.team_num = var_0_1:get_team_index_by_id(1, iter_64_41.id) or 0

				var_0_9(var_64_27, iter_64_41)
			elseif self._enter_type == var_0_16.enter_select_member_type.restaurant_show_type then
				local var_64_30 = false

				for iter_64_44, iter_64_45 in pairs(self._remove_ship_list) do
					if iter_64_41.id == iter_64_45 then
						var_64_30 = true
					end
				end

				if not var_64_30 then
					if self._config_data then
						if self._config_data.id ~= iter_64_41.id then
							var_0_9(var_64_27, iter_64_41)
						end
					else
						var_0_9(var_64_27, iter_64_41)
					end
				end
			else
				var_0_9(var_64_27, iter_64_41)
			end
		end

		local var_64_31 = self._enter_type ~= var_0_16.enter_select_member_type.six_year_map_select and self:__filter_table_by_name(var_64_27) or var_64_27
		local var_64_32

		if self._enter_type == var_0_16.enter_select_member_type.captainroom_fleet or self._enter_type == var_0_16.enter_select_member_type.pre_formation then
			var_64_32 = self._prepare_disassemble_data
		end

		local var_64_33 = {}
		local var_64_34

		if self._is_nf then
			var_64_34 = var_64_0

			return var_64_0
		end

		var_64_33 = self._enter_type == var_0_16.enter_select_member_type.strengthen and self:__sort_table_by_type(var_64_31, var_64_32, "rebuild", true) or self._enter_type == var_0_16.enter_select_member_type.strengthen_res and self:__sort_table_by_type(var_64_31, var_64_32, "rebuild", false) or self._enter_type == var_0_16.enter_select_member_type.pre_formation and self:__sort_table_by_type(var_64_31, var_64_32) or self:__sort_table_by_type(var_64_31)

		if self._filter_name ~= nil then
			var_64_34 = self:__sort_table_by_rule(var_64_31)
		elseif not self._filter_name and self._control.sort_type_btn.sort_txt.text.text ~= var_0_10:getNowLang("equip0") then
			var_64_34 = self:__sort_table_by_rule(var_64_33)

			if self._enter_type == var_0_16.enter_select_member_type.six_year_map_select and self._is_fast_formation then
				local var_64_35 = {}

				for iter_64_46, iter_64_47 in pairs(self._team_data) do
					var_0_9(var_64_35, (var_0_1:find_character_by_id(iter_64_47)))
				end

				for iter_64_48, iter_64_49 in pairs(var_64_34) do
					var_0_9(var_64_35, iter_64_49)
				end

				var_64_34 = var_64_35
			end
		elseif self._enter_type == var_0_16.enter_select_member_type.six_year_map_select then
			for iter_64_50, iter_64_51 in pairs(var_64_33) do
				var_0_9(iter_64_51, self._team_data)
			end

			var_64_34 = var_64_33
		else
			var_64_34 = self:__sort_table_by_rule(var_64_33)
		end

		if self._ship_type and self._enter_type ~= var_0_16.enter_select_member_type.six_year_primary and self._enter_type ~= var_0_16.enter_select_member_type.six_year_map_select then
			var_64_34 = self:__check_sort_type(var_64_34)
		end

		local var_64_36 = {}

		if self._iscustom_state then
			local var_64_37 = var_0_1:get_custom_ship_list()

			if var_64_37 and next(var_64_37) then
				for iter_64_52, iter_64_53 in ipairs(var_64_34) do
					for iter_64_54, iter_64_55 in ipairs(var_64_37) do
						if iter_64_53.id == iter_64_55 then
							var_0_9(var_64_36, iter_64_53)
						end
					end
				end
			end

			var_64_34 = {}
			var_64_34 = var_64_36
		end

		return var_64_34
	end

	function arg_1_0.__found_in_team(arg_65_0, arg_65_1)
		for iter_65_0, iter_65_1 in pairs((var_0_1:get_all_ship_in_team())) do
			if iter_65_1.id == arg_65_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0.__found_in_garrison(arg_66_0, arg_66_1)
		for iter_66_0, iter_66_1 in pairs((var_0_1:get_captainroom_garrison())) do
			if iter_66_1 == arg_66_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__in_sixth_ships(arg_67_1)
		local var_67_0 = var_0_1:get_sixth_combat_info()

		if var_67_0 then
			self._sixth_ships = var_67_0.ship_total or {}
		end

		if next(self._sixth_ships) then
			for iter_67_0, iter_67_1 in ipairs(self._sixth_ships) do
				if iter_67_1 == arg_67_1 then
					return true
				end
			end

			return false
		end
	end

	function arg_1_0.__in_strike_ships(arg_68_0, arg_68_1)
		for iter_68_0, iter_68_1 in ipairs((var_0_1:get_strike_team_data())) do
			if iter_68_1 == arg_68_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0.__in_ocean_ships(arg_69_0, arg_69_1)
		for iter_69_0, iter_69_1 in ipairs((var_0_1:get_ocean_team_data())) do
			if iter_69_1 == arg_69_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0.__in_fifth_ships(arg_70_0, arg_70_1)
		for iter_70_0, iter_70_1 in pairs((var_0_1:get_fifth_station_info())) do
			for iter_70_2, iter_70_3 in pairs(iter_70_1) do
				if iter_70_3 == arg_70_1 then
					return true
				end
			end
		end

		return false
	end

	function arg_1_0.__in_abyss_ships(arg_71_0, arg_71_1)
		for iter_71_0, iter_71_1 in pairs((var_0_1:get_normal_team_info())) do
			if iter_71_1 == arg_71_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__check_sort_type(arg_72_1)
		local var_72_0 = {}

		for iter_72_0, iter_72_1 in pairs(arg_72_1) do
			if iter_72_1.type == self._ship_type then
				var_0_9(var_72_0, iter_72_1)
			end
		end

		return var_72_0
	end

	function arg_1_0:__found_in_disassemble_data(arg_73_1)
		if not self._prepare_disassemble_data then
			return false
		end

		for iter_73_0, iter_73_1 in pairs(self._prepare_disassemble_data) do
			if iter_73_1.id == arg_73_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__update_fast_content()
		if self._enter_type == var_0_16.enter_select_member_type.strengthen or self._enter_type == var_0_16.enter_select_member_type.strengthen_res or self._enter_type == var_0_16.enter_select_member_type.secretary_info_ship or self._enter_type == var_0_16.enter_select_member_type.research_ship then
			return
		end

		local var_74_3 = var_0_1:get_team_config_data((self:__get_team_index() > 8 or nil) and 3, self:__get_team_index())

		if self._enter_type == var_0_16.enter_select_member_type.strike_map_select then
			var_74_3 = {}

			local var_74_4 = var_0_1:get_strike_team_data()

			if var_74_4 and next(var_74_4) then
				for iter_74_0, iter_74_1 in pairs(var_74_4) do
					var_0_9(var_74_3, var_0_1:find_character_by_id(iter_74_1))
				end
			end
		end

		local var_74_6 = self:__filter_fast_character_list()
		local var_74_7 = var_74_6 and var_0_15.little_clone(var_74_6) or {}

		if not self._is_already_fast_init then
			self._team_data = {}

			for iter_74_2, iter_74_3 in pairs(var_74_3) do
				var_0_9(self._team_data, iter_74_3.id)
			end
		end

		for iter_74_4, iter_74_5 in pairs(self._team_data) do
			var_0_9(var_74_7, iter_74_4, (var_0_1:find_character_by_id(iter_74_5)))
		end

		if not self._is_already_fast_init then
			self:__load_info_list(var_74_7, true)

			self._is_already_fast_init = true
		else
			self:__update_fast_content_by_name()

			local var_74_8 = {}

			for iter_74_6, iter_74_7 in pairs(self._temporary_data) do
				var_0_9(var_74_8, iter_74_6)
			end

			table.sort(var_74_8)

			for iter_74_8, iter_74_9 in pairs(var_74_8) do
				if not var_0_15.have_data(var_74_7, self._temporary_data[iter_74_9]) then
					var_0_9(var_74_7, iter_74_9, self._temporary_data[iter_74_9])
				end
			end

			self._cell_data = var_74_7

			self:__update_reusable_cell()
		end
	end

	function arg_1_0:__update_custom_content(arg_75_1)
		if self._enter_type == var_0_16.enter_select_member_type.strengthen and self._panel_type ~= var_0_16.enter_select_member_type.custom_ship or self._enter_type == var_0_16.enter_select_member_type.strengthen_res or self._enter_type == var_0_16.enter_select_member_type.research_ship then
			return
		end

		local var_75_1 = {}
		local var_75_2 = self:__filter_fast_all_character_list()
		local var_75_3 = var_0_1:get_custom_ship_list()
		local var_75_4 = var_0_1:get_common_ship_deatil_num()
		local var_75_5 = 0

		var_75_5 = var_75_3 and next(var_75_3) and #var_75_3 or 0

		if var_75_4 ~= var_75_5 then
			if arg_75_1 and self._custom_team_data and next(self._custom_team_data) then
				if #self._custom_team_data ~= var_75_5 and var_75_5 < #self._custom_team_data then
					local var_75_6 = var_0_1:get_custom_ship_state()

					if var_75_6 then
						for iter_75_0, iter_75_1 in ipairs(self._custom_team_data) do
							if iter_75_1 == arg_75_1 then
								var_0_8(self._custom_team_data, iter_75_0)
							end
						end

						var_0_9(self._custom_team_data, var_75_5, arg_75_1)
					elseif var_75_6 == false then
						for iter_75_2, iter_75_3 in ipairs(self._custom_team_data) do
							if iter_75_3 == arg_75_1 then
								var_0_8(self._custom_team_data, iter_75_2)
							end
						end
					end
				end

				if var_75_5 > #self._custom_team_data then
					var_0_9(self._custom_team_data, var_75_5, arg_75_1)
				end
			elseif arg_75_1 and #self._custom_team_data ~= #var_75_3 then
				local var_75_7 = var_0_1:get_custom_ship_state()

				if var_75_7 then
					var_0_9(self._custom_team_data, arg_75_1)
				end

				if not var_75_7 then
					return
				end
			end
		elseif arg_75_1 and var_75_4 == var_75_5 then
			return
		end

		if var_75_3 and next(var_75_3) then
			for iter_75_4, iter_75_5 in ipairs(var_75_3) do
				var_0_9(var_75_1, (var_0_1:find_character_by_id(iter_75_5)))
			end
		end

		local var_75_8 = self:__filter_custom_character_list(arg_75_1)
		local var_75_10 = var_75_8 and var_0_15.little_clone(var_75_8) or {}

		if not self._is_already_custom_init then
			self._custom_team_data = {}

			for iter_75_6, iter_75_7 in pairs(var_75_1) do
				var_0_9(self._custom_team_data, iter_75_7.id)
			end
		end

		for iter_75_8, iter_75_9 in pairs(self._custom_team_data) do
			var_0_9(var_75_10, iter_75_8, (var_0_1:find_character_by_id(iter_75_9)))
		end

		if not self._is_already_custom_init then
			self:__load_info_list(var_75_10)

			self._is_already_custom_init = true
		else
			self:__update_fast_content_by_name()

			local var_75_11 = {}

			for iter_75_10, iter_75_11 in pairs(self._temporary_data) do
				var_0_9(var_75_11, iter_75_10)
			end

			table.sort(var_75_11)

			for iter_75_12, iter_75_13 in pairs(var_75_11) do
				if not var_0_15.have_data(var_75_10, self._temporary_data[iter_75_13]) then
					var_0_9(var_75_10, iter_75_13, self._temporary_data[iter_75_13])
				end
			end

			self._cell_data = var_75_10

			self:__update_reusable_cell()
		end
	end

	function arg_1_0:__update_fast_content_by_type()
		local var_76_0 = self._prepare_disassemble_data

		if self._prepare_disassemble_data == nil then
			var_76_0 = {}
		end

		if self._enter_type == var_0_16.enter_select_member_type.strengthen_res then
			var_76_0 = self._ships_for_remould_id_list
		elseif self._enter_type == var_0_16.enter_select_member_type.dock_disassemble then
			var_76_0 = self._ships_for_dock_disassemble_id_list
		elseif self._enter_type == var_0_16.enter_select_member_type.research_ship then
			var_76_0 = self._ships_for_dock_research_ship_id_list
		elseif self._enter_type == var_0_16.enter_select_member_type.secretary_info_ship then
			var_76_0 = self._ships_for_dock_secretary_ship_id_list
		elseif self._enter_type == var_0_16.enter_select_member_type.abyss_dock_team_formation then
			var_76_0 = self._ships_for_abyss_dock_id_list
		elseif self._enter_type == var_0_16.enter_select_member_type.strike_map_select then
			var_76_0 = self._ships_for_strike_id_list
		elseif self._enter_type == var_0_16.enter_select_member_type.ocean_attack_map_select then
			var_76_0 = self._ships_for_ocean_id_list
		end

		local var_76_1 = self:__filter_fast_all_character_list()

		if self._enter_type ~= var_0_16.enter_select_member_type.six_year_primary and self._enter_type ~= var_0_16.enter_select_member_type.strengthen_res and self._enter_type ~= var_0_16.enter_select_member_type.dock_disassemble and self._enter_type ~= var_0_16.enter_select_member_type.strike_map_select and self._enter_type ~= var_0_16.enter_select_member_type.research_ship and self._enter_type ~= var_0_16.enter_select_member_type.secretary_info_ship and self._enter_type ~= var_0_16.enter_select_member_type.abyss_dock_team_formation and self._enter_type ~= var_0_16.enter_select_member_type.six_year_map_select and self._enter_type ~= var_0_16.enter_select_member_type.ocean_attack_map_select then
			self._team_data = {}

			for iter_76_0, iter_76_1 in pairs(var_76_1) do
				for iter_76_2, iter_76_3 in pairs(var_76_0) do
					if iter_76_1.id == iter_76_3.id then
						var_0_9(self._team_data, iter_76_3.id)
					end
				end
			end

			if self._enter_type == var_0_16.enter_select_member_type.dormitory then
				for iter_76_4, iter_76_5 in ipairs(var_76_0) do
					local var_76_2 = false

					for iter_76_6, iter_76_7 in ipairs(self._team_data) do
						if iter_76_5.id == iter_76_7 then
							var_76_2 = true
						end
					end

					if not var_76_2 then
						var_0_9(self._team_data, iter_76_5.id)
					end
				end
			end
		elseif self._enter_type == var_0_16.enter_select_member_type.strengthen_res then
			self._team_data = {}

			for iter_76_8, iter_76_9 in pairs(var_76_1) do
				for iter_76_10, iter_76_11 in pairs(var_76_0) do
					if iter_76_9.id == iter_76_11 then
						var_0_9(self._team_data, iter_76_11)
					end
				end
			end
		elseif self._enter_type == var_0_16.enter_select_member_type.dock_disassemble then
			self._team_data = {}

			for iter_76_12, iter_76_13 in pairs(var_76_1) do
				for iter_76_14, iter_76_15 in pairs(var_76_0) do
					if iter_76_13.id == iter_76_15 then
						var_0_9(self._team_data, iter_76_15)
					end
				end
			end
		elseif self._enter_type == var_0_16.enter_select_member_type.research_ship then
			self._team_data = {}

			for iter_76_16, iter_76_17 in pairs(var_76_1) do
				for iter_76_18, iter_76_19 in pairs(var_76_0) do
					if iter_76_17.id == iter_76_19 then
						var_0_9(self._team_data, iter_76_19)
					end
				end
			end
		elseif self._enter_type == var_0_16.enter_select_member_type.secretary_info_ship then
			self._team_data = {}
			self._team_data = var_76_0
		elseif self._enter_type == var_0_16.enter_select_member_type.strike_map_select then
			local var_76_3 = self._team_data and var_0_15.little_clone(self._team_data) or {}

			self._team_data = {}

			for iter_76_20, iter_76_21 in ipairs(self._ships_for_strike_list) do
				var_0_9(var_76_1, iter_76_20, iter_76_21)
			end

			self._team_data = var_76_3
		elseif self._enter_type == var_0_16.enter_select_member_type.abyss_dock_team_formation then
			local var_76_4 = self._team_data and var_0_15.little_clone(self._team_data) or {}

			for iter_76_22, iter_76_23 in ipairs(self._ships_for_abyss_list) do
				var_0_9(var_76_1, iter_76_22, iter_76_23)
			end

			self._team_data = var_76_4
		elseif self._enter_type == var_0_16.enter_select_member_type.ocean_attack_map_select then
			local var_76_5 = self._team_data and var_0_15.little_clone(self._team_data) or {}

			for iter_76_24, iter_76_25 in ipairs(self._ships_for_ocean_list) do
				var_0_9(var_76_1, iter_76_24, iter_76_25)
			end

			self._team_data = var_76_5
		elseif self._enter_type == var_0_16.enter_select_member_type.six_year_map_select then
			-- block empty
		else
			if not self._is_already_fast_init then
				self._team_data = {}

				for iter_76_26, iter_76_27 in pairs(var_76_1) do
					for iter_76_28, iter_76_29 in pairs(var_76_0) do
						if iter_76_27.id == iter_76_29.id then
							var_0_9(self._team_data, iter_76_29.id)
						end
					end
				end
			end

			if not self._is_already_custom_init then
				self._team_data = {}

				for iter_76_30, iter_76_31 in pairs(var_76_1) do
					for iter_76_32, iter_76_33 in pairs(var_76_0) do
						if iter_76_31.id == iter_76_33.id then
							var_0_9(self._team_data, iter_76_33.id)
						end
					end
				end
			end
		end

		if self._enter_type == var_0_16.enter_select_member_type.strengthen_res and self._ships_for_remould_id_list and #self._ships_for_remould_id_list > 0 then
			local var_76_6 = {}

			for iter_76_34, iter_76_35 in ipairs(self._ships_for_remould_id_list) do
				var_76_6[iter_76_35] = iter_76_34
			end

			local var_76_7 = {}
			local var_76_8 = {}

			for iter_76_36, iter_76_37 in ipairs(var_76_1) do
				if iter_76_37 and iter_76_37.id and var_76_6[iter_76_37.id] then
					var_76_7[var_76_6[iter_76_37.id]] = iter_76_37
				else
					var_0_9(var_76_8, iter_76_37)
				end
			end

			local var_76_9 = {}

			for iter_76_38 = 1, #self._ships_for_remould_id_list do
				if var_76_7[iter_76_38] then
					var_0_9(var_76_9, var_76_7[iter_76_38])
				end
			end

			for iter_76_39, iter_76_40 in ipairs(var_76_8) do
				var_0_9(var_76_9, iter_76_40)
			end

			var_76_1 = var_76_9
		end

		if not self._is_already_fast_init then
			self:__load_info_list(var_76_1)

			self._is_already_fast_init = true
		elseif not self._is_already_custom_init then
			self:__load_info_list(var_76_1)

			self._is_already_custom_init = true
		else
			if self._control.bg_container.search.activeSelf and self._enter_type ~= var_0_16.enter_select_member_type.captainroom_fleet and self._enter_type ~= var_0_16.enter_select_member_type.dormitory then
				self:__update_fast_content_by_name()
			end

			self._cell_data = var_76_1

			self:__sort_cell_of_special_enter_type(var_76_1)
			self:__update_reusable_cell()
		end

		self:__change_info_list_detail()

		if self._enter_type == var_0_16.enter_select_member_type.strengthen_res then
			self:update_strengthen_info()
		end

		if self._enter_type == var_0_16.enter_select_member_type.research_ship then
			self:update_research_info()
		end

		if self._enter_type == var_0_16.enter_select_member_type.secretary_info_ship then
			self:update_secretary_info()
		end
	end

	function arg_1_0:__update_custom_content_by_type()
		local var_77_0 = self._prepare_disassemble_data

		if self._prepare_disassemble_data == nil then
			var_77_0 = {}
		end

		if self._enter_type == var_0_16.enter_select_member_type.strengthen_res then
			var_77_0 = self._ships_for_remould_id_list
		elseif self._enter_type == var_0_16.enter_select_member_type.dock_disassemble then
			var_77_0 = self._ships_for_dock_disassemble_id_list
		elseif self._enter_type == var_0_16.enter_select_member_type.research_ship then
			var_77_0 = self._ships_for_dock_research_ship_id_list
		elseif self._enter_type == var_0_16.enter_select_member_type.secretary_info_ship then
			var_77_0 = self._ships_for_dock_secretary_ship_id_list
		elseif self._enter_type == var_0_16.enter_select_member_type.abyss_dock_team_formation then
			var_77_0 = self._ships_for_abyss_dock_id_list
		elseif self._enter_type == var_0_16.enter_select_member_type.strike_map_select then
			var_77_0 = self._ships_for_strike_id_list
		elseif self._enter_type == var_0_16.enter_select_member_type.ocean_attack_map_select then
			var_77_0 = self._ships_for_ocean_id_list
		end

		if self._iscustom_state then
			local var_77_2 = var_0_1:get_custom_ship_list()
		end

		local var_77_3 = self:__filter_fast_all_character_list()

		if self._enter_type ~= var_0_16.enter_select_member_type.six_year_primary and self._enter_type ~= var_0_16.enter_select_member_type.strengthen_res and self._enter_type ~= var_0_16.enter_select_member_type.dock_disassemble and self._enter_type ~= var_0_16.enter_select_member_type.strike_map_select and self._enter_type ~= var_0_16.enter_select_member_type.research_ship and self._enter_type ~= var_0_16.enter_select_member_type.secretary_info_ship and self._enter_type ~= var_0_16.enter_select_member_type.abyss_dock_team_formation and self._enter_type ~= var_0_16.enter_select_member_type.six_year_map_select and self._enter_type ~= var_0_16.enter_select_member_type.ocean_attack_map_select then
			self._team_data = {}

			for iter_77_0, iter_77_1 in pairs(var_77_3) do
				for iter_77_2, iter_77_3 in pairs(var_77_0) do
					if iter_77_1.id == iter_77_3.id then
						var_0_9(self._team_data, iter_77_3.id)
					end
				end
			end

			if self._enter_type == var_0_16.enter_select_member_type.dormitory then
				for iter_77_4, iter_77_5 in ipairs(var_77_0) do
					local var_77_4 = false

					for iter_77_6, iter_77_7 in ipairs(self._team_data) do
						if iter_77_5.id == iter_77_7 then
							var_77_4 = true
						end
					end

					if not var_77_4 then
						var_0_9(self._team_data, iter_77_5.id)
					end
				end
			end
		elseif self._enter_type == var_0_16.enter_select_member_type.strengthen_res then
			self._team_data = {}

			for iter_77_8, iter_77_9 in pairs(var_77_3) do
				for iter_77_10, iter_77_11 in pairs(var_77_0) do
					if iter_77_9.id == iter_77_11 then
						var_0_9(self._team_data, iter_77_11)
					end
				end
			end
		elseif self._enter_type == var_0_16.enter_select_member_type.dock_disassemble then
			self._team_data = {}

			for iter_77_12, iter_77_13 in pairs(var_77_3) do
				for iter_77_14, iter_77_15 in pairs(var_77_0) do
					if iter_77_13.id == iter_77_15 then
						var_0_9(self._team_data, iter_77_15)
					end
				end
			end
		elseif self._enter_type == var_0_16.enter_select_member_type.research_ship then
			self._team_data = {}

			for iter_77_16, iter_77_17 in pairs(var_77_3) do
				for iter_77_18, iter_77_19 in pairs(var_77_0) do
					if iter_77_17.id == iter_77_19 then
						var_0_9(self._team_data, iter_77_19)
					end
				end
			end
		elseif self._enter_type == var_0_16.enter_select_member_type.secretary_info_ship then
			self._team_data = {}

			for iter_77_20, iter_77_21 in pairs(var_77_3) do
				for iter_77_22, iter_77_23 in pairs(var_77_0) do
					if iter_77_21.id == iter_77_23 then
						var_0_9(self._team_data, iter_77_23)
					end
				end
			end
		elseif self._enter_type == var_0_16.enter_select_member_type.strike_map_select then
			local var_77_5 = self._team_data and var_0_15.little_clone(self._team_data) or {}

			self._team_data = {}

			for iter_77_24, iter_77_25 in ipairs(self._ships_for_strike_list) do
				var_0_9(var_77_3, iter_77_24, iter_77_25)
			end

			self._team_data = var_77_5
		elseif self._enter_type == var_0_16.enter_select_member_type.abyss_dock_team_formation then
			local var_77_6 = self._team_data and var_0_15.little_clone(self._team_data) or {}

			for iter_77_26, iter_77_27 in ipairs(self._ships_for_abyss_list) do
				var_0_9(var_77_3, iter_77_26, iter_77_27)
			end

			self._team_data = var_77_6
		elseif self._enter_type == var_0_16.enter_select_member_type.ocean_attack_map_select then
			local var_77_7 = self._team_data and var_0_15.little_clone(self._team_data) or {}

			for iter_77_28, iter_77_29 in ipairs(self._ships_for_ocean_list) do
				var_0_9(var_77_3, iter_77_28, iter_77_29)
			end

			self._team_data = var_77_7
		elseif self._enter_type == var_0_16.enter_select_member_type.six_year_map_select then
			self._cell_data = var_77_3
		else
			if not self._is_already_fast_init then
				self._team_data = {}

				for iter_77_30, iter_77_31 in pairs(var_77_3) do
					for iter_77_32, iter_77_33 in pairs(var_77_0) do
						if iter_77_31.id == iter_77_33.id then
							var_0_9(self._team_data, iter_77_33.id)
						end
					end
				end
			end

			if not self._is_already_custom_init then
				self._custom_team_data = {}

				for iter_77_34, iter_77_35 in pairs(var_77_3) do
					for iter_77_36, iter_77_37 in pairs(var_77_0) do
						if iter_77_35.id == iter_77_37.id then
							var_0_9(self._custom_team_data, iter_77_37.id)
						end
					end
				end
			end
		end

		if not self._is_already_fast_init then
			self:__load_info_list(var_77_3)
		elseif not self._is_already_custom_init then
			self:__load_info_list(var_77_3)
		else
			if self._control.bg_container.search.activeSelf and self._enter_type ~= var_0_16.enter_select_member_type.captainroom_fleet and self._enter_type ~= var_0_16.enter_select_member_type.dormitory then
				self:__update_fast_content_by_name()
			end

			self._cell_data = var_77_3

			self:__sort_cell_of_special_enter_type(var_77_3)
			self:__update_reusable_cell()
		end

		self:__change_info_list_detail()
	end

	function arg_1_0:__update_fast_content_by_name()
		local var_78_2 = var_0_1:get_team_config_data((self:__get_team_index() > 8 or nil) and 3, self:__get_team_index())

		if self._enter_type == var_0_16.enter_select_member_type.ocean_attack_map_select then
			var_78_2 = self._team_data
		end

		local var_78_3 = {}

		if not self._filter_name then
			for iter_78_0 = 1, #var_78_2 do
				var_78_3[iter_78_0] = var_78_2[iter_78_0]
			end
		else
			for iter_78_1 = 1, #var_78_2 do
				if var_0_15.name_filter_match(var_78_2[iter_78_1].name, self._filter_name) then
					var_0_9(var_78_3, var_78_2[iter_78_1])
				end
			end
		end

		self._cell_data = var_78_3
	end

	function arg_1_0:__sort_table_by_rule(arg_79_1)
		if self._enter_type == var_0_16.enter_select_member_type.restaurant_show_type then
			local var_79_0 = var_0_1:get_restaurant_cookbook_info()
			local var_79_1 = {}

			if var_79_0 and next(var_79_0) then
				for iter_79_0, iter_79_1 in ipairs(var_79_0) do
					if iter_79_1.info then
						for iter_79_2, iter_79_3 in ipairs(iter_79_1.info) do
							if iter_79_3.id == self._food_info.cid then
								var_0_9(var_79_1, {
									id = iter_79_1.ship_id,
									exp = iter_79_3.exp
								})
							end
						end
					end
				end
			end

			if var_79_1 and next(var_79_1) then
				if arg_79_1 and next(arg_79_1) then
					for iter_79_4, iter_79_5 in pairs(arg_79_1) do
						local var_79_2, var_79_3 = self:__have_cook_data(var_79_1, iter_79_5.id)

						if var_79_2 then
							iter_79_5.ship_index = var_0_17.find_object_by_cid(iter_79_5.cid).ship_index
							iter_79_5.cook_exp = var_79_3
						else
							iter_79_5.ship_index = var_0_17.find_object_by_cid(iter_79_5.cid).ship_index
							iter_79_5.cook_exp = 0
						end
					end
				end
			elseif arg_79_1 and next(arg_79_1) then
				for iter_79_6, iter_79_7 in pairs(arg_79_1) do
					iter_79_7.ship_index = var_0_17.find_object_by_cid(iter_79_7.cid).ship_index
					iter_79_7.cook_exp = 0
				end
			end

			return arg_79_1
		end

		if self._sort_layer then
			if arg_79_1 and next(arg_79_1) then
				for iter_79_8, iter_79_9 in ipairs(arg_79_1) do
					iter_79_9.ship_index = var_0_17.find_object_by_cid(iter_79_9.cid).ship_index
				end
			end

			return self._sort_layer:sort_table_by_rule(arg_79_1)
		end
	end

	function arg_1_0:__sort_table_by_type(arg_80_1, arg_80_2, arg_80_3, arg_80_4)
		if self._type_layer then
			self._type_layer:set_sort_exclude(arg_80_2)
			self._type_layer:set_target_type_group_state(arg_80_3, arg_80_4)

			return self._type_layer:sort_table_by_type(arg_80_1)
		end
	end

	function arg_1_0:__filter_table_by_name(arg_81_1)
		local var_81_0 = {}

		if not self._filter_name then
			return arg_81_1
		end

		local var_81_1, var_81_2 = var_0_6(self._filter_name, "%(")

		if var_81_1 ~= nil and var_81_2 ~= nil then
			self._filter_name = var_0_15._str_insert(self._filter_name, var_81_1, "%")
		end

		local var_81_3, var_81_4 = var_0_6(self._filter_name, "%%")

		if var_81_3 ~= nil and var_81_4 ~= nil then
			self._filter_name = var_0_15._str_insert(self._filter_name, var_81_3, "%")
		end

		local var_81_5, var_81_6 = var_0_6(self._filter_name, "%[")

		if var_81_5 ~= nil and var_81_6 ~= nil then
			self._filter_name = var_0_15._str_insert(self._filter_name, var_81_5, "%")
		end

		local var_81_7, var_81_8 = var_0_6(self._filter_name, "%]")

		if var_81_7 ~= nil and var_81_8 ~= nil then
			self._filter_name = var_0_15._str_insert(self._filter_name, var_81_7, "%")
		end

		local var_81_9, var_81_10 = var_0_6(self._filter_name, "%-")

		if var_81_9 ~= nil and var_81_10 ~= nil then
			self._filter_name = var_0_15._str_insert(self._filter_name, var_81_9, "%")
		end

		for iter_81_0, iter_81_1 in pairs(arg_81_1) do
			if var_0_15.name_filter_match(iter_81_1.name, self._filter_name) then
				var_0_9(var_81_0, iter_81_1)
			end
		end

		return var_81_0
	end

	function arg_1_0:__init_character_data_list()
		self._character_data_list = {}

		local var_82_0 = var_0_1:get_character_list()
		local var_82_1 = var_82_0 and var_0_15.little_clone(var_82_0) or {}

		if self._config_data and self._config_data.id then
			var_82_1[self._config_data.id] = nil
		end

		self._character_data_list = var_82_1
	end

	function arg_1_0:__init_character_data_list_for_concerto_play()
		self._character_data_list = {}

		local var_83_0 = var_0_1:get_fifth_ship_list()

		if self._config_data then
			for iter_83_0, iter_83_1 in pairs(var_83_0) do
				if iter_83_1.cid ~= self._config_data.cid then
					if not self._ship_type or self._ship_type == 0 then
						var_0_9(self._character_data_list, iter_83_1)
					elseif iter_83_1.type == self._ship_type then
						var_0_9(self._character_data_list, iter_83_1)
					end
				end
			end
		else
			for iter_83_2, iter_83_3 in pairs(var_83_0) do
				if not self._ship_type or self._ship_type == 0 then
					var_0_9(self._character_data_list, iter_83_3)
				elseif iter_83_3.type == self._ship_type then
					var_0_9(self._character_data_list, iter_83_3)
				end
			end
		end
	end

	function arg_1_0:__load_info_list(arg_84_1)
		if not arg_84_1 then
			return
		end

		if self._config_data and next(self._config_data) and not self._is_fast_formation and not self._is_custom_formation and self._enter_type ~= var_0_16.enter_select_member_type.strengthen_res then
			local var_84_0 = {}

			for iter_84_0 = 1, var_0_3(arg_84_1) + 1 do
				if iter_84_0 == 1 then
					var_84_0[1] = {}
					var_84_0[1].is_exist = true
				else
					var_84_0[iter_84_0] = arg_84_1[iter_84_0 - 1]
					var_84_0[iter_84_0].is_exist = false
				end
			end

			self._cell_data = var_84_0

			self:__update_reusable_cell()
		else
			self._cell_data = arg_84_1

			self:__sort_cell_of_special_enter_type(arg_84_1)
			self:__update_reusable_cell()
		end

		if self._enter_type == var_0_16.enter_select_member_type.strengthen then
			self:__show_or_hide_full_strengthen()
		elseif self._enter_type == var_0_16.enter_select_member_type.skill then
			self:__show_or_hide_full_skill()
		end
	end

	function arg_1_0:__get_team_index()
		if var_0_11:getInstance("pre_formation") then
			self._team_index = var_0_1:get_current_team()

			if not self._team_index then
				return 1
			end

			return self._team_index
		end

		local var_85_0 = var_0_11:getInstance("dock_team")

		if var_85_0 then
			self._team_index = var_85_0:get_current_team_index()

			if not self._team_index then
				return 1
			end

			return self._team_index
		end

		local var_85_1 = var_0_11:getInstance("fight_prepare")

		if var_85_1 then
			self._team_index = var_85_1:get_current_team_index()

			if not self._team_index then
				return 1
			end

			return self._team_index
		end

		return 1
	end

	function arg_1_0.__set_no_info_back(arg_86_0)
		var_0_11:destroyInstance("select_member")
	end

	function arg_1_0.get_is_strength_full(arg_87_0, arg_87_1)
		for iter_87_0, iter_87_1 in ipairs(var_0_17.find_object_by_cid(arg_87_1.cid).strengthen_top) do
			for iter_87_2, iter_87_3 in pairs(arg_87_1.intensify or {}) do
				if iter_87_1.name == iter_87_3.attr and iter_87_1.value ~= iter_87_3.exp then
					return false
				end
			end
		end

		return true
	end

	function arg_1_0.get_is_research_ship(arg_88_0, arg_88_1, arg_88_2)
		if arg_88_1.shipTypes and next(arg_88_1.shipTypes) then
			for iter_88_0, iter_88_1 in pairs(arg_88_1.shipTypes) do
				if arg_88_2.type == iter_88_1 then
					return false
				end
			end
		elseif arg_88_1.shipCids and next(arg_88_1.shipCids) then
			for iter_88_2, iter_88_3 in pairs(arg_88_1.shipCids) do
				if arg_88_2.cid == iter_88_3 then
					return false
				end
			end
		elseif arg_88_1.shipTons and next(arg_88_1.shipTons) then
			for iter_88_4, iter_88_5 in pairs(arg_88_1.shipTons) do
				if var_0_16:get_ship_size(arg_88_2.type) == iter_88_5 then
					return false
				end
			end
		elseif arg_88_1.guardTypes and next(arg_88_1.guardTypes) then
			for iter_88_6, iter_88_7 in pairs(arg_88_1.guardTypes) do
				if var_0_15.have_data(var_0_16.maip_ship_type, arg_88_2.type) then
					return false
				end
			end
		end

		return true
	end

	function arg_1_0.get_is_skill_full(arg_89_0, arg_89_1)
		if arg_89_1.skill_level >= var_0_17.find_object_by_cid(arg_89_1.cid).max_skill_level then
			return true
		end

		return false
	end

	function arg_1_0:__init_ship_list()
		if not self._reusable_cell then
			self._reusable_cell = gamecore.reusable_cell:create(self, self._control.all_ship.Viewport.edge_mask.Content.endlessScrollView, self._control.all_ship.Viewport.edge_mask.Content, "single_select_team", "select_member", true)

			self._reusable_cell:init()
		end
	end

	function arg_1_0:_set_nf_ship_data()
		local var_91_0 = var_0_1:get_mist_combat_info().members
		local var_91_1 = {}
		local var_91_2 = {}

		for iter_91_0, iter_91_1 in pairs(self._save_nf_ships) do
			for iter_91_2, iter_91_3 in pairs(var_91_0) do
				if iter_91_3 == iter_91_1.id then
					var_0_8(self._save_nf_ships, iter_91_0)
				end
			end
		end

		if self._save_click_mist then
			for iter_91_4 = 1, #self._save_nf_ships + 1 do
				if iter_91_4 == 1 then
					var_91_2[1] = {}
					var_91_2[1].is_exist = true
				else
					var_91_2[iter_91_4] = self._save_nf_ships[iter_91_4 - 1]
					var_91_2[iter_91_4].is_exist = false
				end
			end

			var_91_1 = var_91_2
		else
			var_91_1 = self._save_nf_ships
		end

		return var_91_1
	end

	function arg_1_0:__update_reusable_cell()
		self._cell_list = {}
		self._all_panel_disassemble_info = {}
		self._all_panel_disassemble_info_id = {}
		self._all_panel_research_ship_info = {}
		self._all_panel_research_ship_info_id = {}
		self._all_panel_custom_ship_info = {}
		self._all_panel_custom_ship_info_id = {}

		local var_92_0 = self._enter_type == var_0_16.enter_select_member_type.six_year_map_select and (self._is_nf and self:_set_nf_ship_data() or self._cell_data) or self._cell_data and var_0_15.little_clone(self._cell_data) or {}
		local var_92_1 = true

		if self._filter_name then
			for iter_92_0, iter_92_1 in pairs((var_0_1:get_character_list())) do
				var_92_1 = not not var_0_15.name_filter_match(iter_92_1.name, self._filter_name)
			end
		end

		if self._enter_type ~= var_0_16.enter_select_member_type.six_year_primary and self._enter_type ~= var_0_16.enter_select_member_type.dock_disassemble and self._enter_type ~= var_0_16.enter_select_member_type.six_year_map_select and self._enter_type ~= var_0_16.enter_select_member_type.strike_map_select and self._enter_type ~= var_0_16.enter_select_member_type.strengthen_res and self._enter_type ~= var_0_16.enter_select_member_type.evo and self._enter_type ~= var_0_16.enter_select_member_type.skill and #var_92_0 == 0 and not var_92_1 and not self._is_type then
			var_0_5:show(var_0_10:getNowLang("noshipsearched"))
		end

		if self._enter_type == var_0_16.enter_select_member_type.strengthen and self._panel_type ~= var_0_16.enter_select_member_type.custom_ship then
			for iter_92_2 = #var_92_0, 1, -1 do
				if self:get_is_strength_full(var_92_0[iter_92_2]) and not self._full_strengthen_flag then
					var_0_8(var_92_0, iter_92_2)
				end
			end
		elseif self._enter_type == var_0_16.enter_select_member_type.skill and self._panel_type ~= var_0_16.enter_select_member_type.custom_ship then
			for iter_92_3 = #var_92_0, 1, -1 do
				if self:get_is_skill_full(var_92_0[iter_92_3]) and not self._full_skill_flag then
					var_0_8(var_92_0, iter_92_3)
				end
			end
		end

		if self._enter_type == var_0_16.enter_select_member_type.college and self._prepare_disassemble_data then
			local var_92_2 = var_92_0 and var_0_15.little_clone(var_92_0) or {}

			for iter_92_4, iter_92_5 in pairs(var_92_0) do
				if self:__found_in_disassemble_data(iter_92_5.id) then
					for iter_92_6, iter_92_7 in pairs(var_92_2) do
						if iter_92_7.id == iter_92_5.id then
							var_0_8(var_92_2, iter_92_6)
						end
					end
				end
			end

			var_92_0 = var_92_2
		end

		if self._enter_type == var_0_16.enter_select_member_type.tower then
			var_92_0 = self:__check_ship_if_is_in_can_act_(var_92_0)
		end

		if self._enter_type == var_0_16.enter_select_member_type.research_ship then
			local var_92_3 = var_0_1:get_need_research_ship_task_info()

			for iter_92_8 = #var_92_0, 1, -1 do
				if self:get_is_research_ship(var_92_3, var_92_0[iter_92_8]) then
					var_0_8(var_92_0, iter_92_8)
				end
			end
		elseif self._enter_type == var_0_16.enter_select_member_type.secretary_info_ship then
			local var_92_4 = var_0_1:get_secretary_info().members

			for iter_92_9 = 1, #var_92_4 do
				local var_92_5, var_92_6 = self:__have_data(var_92_0, var_92_4[iter_92_9])

				if var_92_5 then
					var_0_8(var_92_0, var_92_6)
				end
			end
		end

		if self._is_fast_formation then
			var_92_0 = var_0_15.eliminate_repetitive_ships(var_92_0)
		end

		if self._is_custom_formation then
			var_92_0 = var_0_15.eliminate_repetitive_ships(var_92_0)
		end

		if self._enter_type == var_0_16.enter_select_member_type.secretary_info_ship then
			for iter_92_10, iter_92_11 in pairs(var_0_1:get_secretary_info().members) do
				var_0_9(var_92_0, iter_92_10, (var_0_1:find_character_by_id(iter_92_11)))
			end
		end

		if self._enter_type == var_0_16.enter_select_member_type.restaurant_show_type then
			self._sort_layer:sort_table_by_rule(var_92_0)
		end

		local var_92_7 = {}

		for iter_92_12, iter_92_13 in pairs(var_92_0) do
			if iter_92_13 and iter_92_13.id then
				var_0_9(var_92_7, iter_92_13.id)
			end
		end

		var_0_1:set_all_select_member_list(var_92_7)
		self:__init_ship_list()
		self._reusable_cell:set_data(var_92_0)

		if self._enter_type == var_0_16.enter_select_member_type.dock_disassemble then
			for iter_92_14, iter_92_15 in ipairs(var_92_0) do
				if iter_92_14 <= var_0_16.max_select_type.two_hundred and not var_0_15.have_data(self._all_panel_disassemble_info, iter_92_15.id) then
					var_0_9(self._all_panel_disassemble_info, iter_92_15)
					var_0_9(self._all_panel_disassemble_info_id, iter_92_15.id)
				end
			end
		end

		if self._enter_type == var_0_16.enter_select_member_type.research_ship then
			local var_92_8 = var_0_1:get_need_research_ship_task_info().num - var_0_1:get_research_ship_select_ship_num()

			for iter_92_16, iter_92_17 in ipairs(var_92_0) do
				if iter_92_16 <= var_92_8 and not var_0_15.have_data(self._all_panel_research_ship_info, iter_92_17.id) then
					var_0_9(self._all_panel_research_ship_info, iter_92_17)
					var_0_9(self._all_panel_research_ship_info_id, iter_92_17.id)
				end
			end
		end

		for iter_92_18, iter_92_19 in ipairs(var_92_0) do
			var_0_9(self._all_panel_custom_ship_info, iter_92_19)
			var_0_9(self._all_panel_custom_ship_info_id, iter_92_19.id)
		end

		function self._reusable_cell:_set_func(arg_93_1)
			local var_93_0 = var_0_1:get_character_attribute(var_92_0[arg_93_1 + 1].id)
			local var_93_1 = var_93_0 and var_0_15.little_clone(var_93_0)

			if self._enter_type ~= var_0_16.enter_select_member_type.war_concerto_play and not self._is_nf then
				self:__calculate_attribute_by_intensify(var_92_0[arg_93_1 + 1], var_93_1)
				self:__calculate_attribute_by_equips(var_92_0[arg_93_1 + 1], var_93_1)
				self:__add_collections_attr(var_92_0[arg_93_1 + 1], var_93_1)
				self:__add_skill_attr(var_92_0[arg_93_1 + 1], var_93_1)
				self:__add_restaurant_attr(var_92_0[arg_93_1 + 1], var_93_1)
				self:__add_workshop_attr(var_92_0[arg_93_1 + 1], var_93_1)
			end

			var_92_0[arg_93_1 + 1].attrs = var_93_1

			self:set_enter_type(self._enter_type, self._campaign, self:__get_team_index())
			self:show(var_92_0[arg_93_1 + 1], var_0_16.dock_team_toggle_type.formation, nil, self._team_type, nil, self._go_to_map_id, self._config_data)

			if self._enter_type == var_0_16.enter_select_member_type.restaurant_show_type then
				self:show_cook_detail_layer(var_92_0[arg_93_1 + 1].cook_exp)
			end

			if self._is_nf then
				self:show_mist_detail_layer(self._detail_index)
			else
				self:show_detail_layer(self._detail_index)
			end

			if self._is_fast_formation then
				local var_93_2 = 0

				var_93_2 = self._enter_type == var_0_16.enter_select_member_type.strengthen_res and self:__find_index_in_res_data(var_92_0[arg_93_1 + 1].id) or self._enter_type == var_0_16.enter_select_member_type.dock_disassemble and self:__find_index_in_disa_data(var_92_0[arg_93_1 + 1].id) or self._enter_type == var_0_16.enter_select_member_type.research_ship and self:__find_index_in_research_data(var_92_0[arg_93_1 + 1].id) or self._enter_type == var_0_16.enter_select_member_type.secretary_info_ship and self:__find_index_in_secretary_data(var_92_0[arg_93_1 + 1].id) or self._enter_type == var_0_16.enter_select_member_type.six_year_map_select and self:__find_index_in_six_team_data(var_92_0[arg_93_1 + 1].id) or self:__find_index_in_team_data(var_92_0[arg_93_1 + 1].id)

				if self._enter_type == var_0_16.enter_select_member_type.dock_disassemble then
					if self._select_state == 1 then
						self:set_fast_team_num(true, var_93_2, self._enter_type)
					elseif self._select_state == 2 then
						self:set_fast_team_num()
					elseif self._select_state == 0 then
						self:set_fast_team_num(true, var_93_2, self._enter_type)
					end
				else
					self:set_fast_team_num(true, var_93_2, self._enter_type)
				end
			elseif self._enter_type == var_0_16.enter_select_member_type.six_year_map_select then
				self:set_fast_team_num(nil, nil, self._enter_type)
			else
				self:set_fast_team_num()
			end

			if self._is_custom_formation then
				self:set_custom_team_num(true, self:__find_index_in_custorm_team_data(var_92_0[arg_93_1 + 1].id), self._enter_type)
			else
				self:set_custom_team_num()
			end

			if self._is_clear_custom_select_ship then
				self:set_custom_team_num()
			end

			if arg_93_1 == 0 then
				self:__set_single_item_name()
			end

			for iter_93_0, iter_93_1 in pairs(self._cell_list) do
				if iter_93_1 == self then
					self._cell_list[iter_93_0] = nil
				end
			end

			self._cell_list[arg_93_1 + 1] = self
		end
	end

	function arg_1_0.__have_data(arg_94_0, arg_94_1, arg_94_2)
		local var_94_1 = false

		for iter_94_0, iter_94_1 in pairs(arg_94_1) do
			if iter_94_1.id == arg_94_2 then
				var_94_1 = true

				return true, iter_94_0
			end
		end

		return var_94_1
	end

	function arg_1_0.__have_cook_data(arg_95_0, arg_95_1, arg_95_2)
		local var_95_1 = false

		for iter_95_0, iter_95_1 in pairs(arg_95_1) do
			if iter_95_1.id == arg_95_2 then
				var_95_1 = true

				return true, iter_95_1.exp
			end
		end

		return var_95_1
	end

	function arg_1_0.__calculate_attribute_by_intensify(arg_96_0, arg_96_1, arg_96_2)
		if not arg_96_1.id then
			return
		end

		local var_96_0 = var_0_17.find_object_by_cid(var_0_1:find_character_by_id(arg_96_1.id).cid)
		local var_96_1 = var_0_1:get_character_intensify(arg_96_1.id)

		if var_96_1 then
			for iter_96_0, iter_96_1 in pairs(var_96_1) do
				arg_96_2[iter_96_1.attr] = iter_96_1.attr == "range" and iter_96_1.exp / var_96_0.strengthen_level_up_exp or arg_96_2[iter_96_1.attr] + iter_96_1.exp / var_96_0.strengthen_level_up_exp
			end
		end
	end

	function arg_1_0.__calculate_attribute_by_equips(arg_97_0, arg_97_1, arg_97_2)
		if not arg_97_1.id then
			return
		end

		for iter_97_0, iter_97_1 in pairs(arg_97_1.equips or {}) do
			local var_97_0 = var_0_25.find_object_by_cid(iter_97_1.id)

			if var_97_0 then
				for iter_97_2, iter_97_3 in pairs(var_0_16.equip_attribute) do
					var_97_0[iter_97_3] = var_97_0[iter_97_3] or 0
					arg_97_2[iter_97_3] = arg_97_2[iter_97_3] or 0

					if iter_97_3 == "range" then
						if var_97_0[iter_97_3] > arg_97_2[iter_97_3] then
							arg_97_2[iter_97_3] = var_97_0[iter_97_3] or arg_97_2[iter_97_3]
						end
					else
						arg_97_2[iter_97_3] = arg_97_2[iter_97_3] + var_97_0[iter_97_3]
					end
				end
			end
		end
	end

	function arg_1_0:__add_collections_attr(arg_98_1, arg_98_2)
		if not arg_98_1.id then
			return
		end

		local var_98_0 = var_0_17.find_object_by_cid(arg_98_1.cid)

		if not next(self._collection_data) then
			local var_98_1 = var_0_1:get_player_desk_collection_data()

			self._collection_data = var_98_1 and var_0_15.little_clone(var_98_1) or {}
		end

		for iter_98_0, iter_98_1 in pairs(self._collection_data) do
			local var_98_2 = var_0_21.find_object_by_cid(iter_98_1.id)

			if var_98_2 then
				local var_98_3 = var_0_22(var_98_2.buff_effect.attr)

				if (var_98_2.buff_effect.ship_type == 0 or var_98_2.buff_effect.ship_type == var_98_0.type) and (var_98_2.buff_effect.country == 0 or var_98_2.buff_effect.country == var_98_0.country) and arg_98_2[var_98_3] then
					arg_98_2[var_98_3] = arg_98_2[var_98_3] + var_98_2.buff_effect.val
				end
			end
		end
	end

	function arg_1_0:__add_restaurant_attr(arg_99_1, arg_99_2)
		if not arg_99_1.id then
			return
		end

		if not next(self._restaurant_buff) then
			local var_99_0 = var_0_1:get_restaurant_cookbook_buff()

			self._restaurant_buff = var_99_0 and var_0_15.little_clone(var_99_0) or {}
		end

		if not self._restaurant_buff.end_time then
			return
		end

		local var_99_1

		if lx.ServerTime:getUtcTime() < self._restaurant_buff.end_time then
			var_99_1 = var_0_23.find_object_by_cid(self._restaurant_buff.id)
		end

		if not var_99_1 then
			return
		end

		local var_99_2 = var_0_17.find_object_by_cid(arg_99_1.cid)

		if not var_99_2 then
			return
		end

		local var_99_3 = var_99_1.effect.attr

		if arg_99_2[var_99_1.effect.attr] and self._restaurant_buff.end_time >= lx.ServerTime:getUtcTime() and (var_99_1.effect.type == 5 or var_99_1.effect.type == 6) then
			local var_99_5 = var_99_1.effect.country or 0
			local var_99_6 = var_99_1.effect.ship_type or 0
			local var_99_7 = var_99_1.effect.ship_ton or 0

			if (var_99_6 == 0 or var_99_6 == var_99_2.type) and (var_99_5 == 0 or var_99_5 == var_99_2.country) and (var_99_7 == 0 or var_99_7 == var_99_2.ship_ton) then
				arg_99_2[var_99_3] = arg_99_2[var_99_3] + var_99_1.effect.value
			end
		end
	end

	function arg_1_0:__add_skill_attr(arg_100_1, arg_100_2)
		if not arg_100_1.id then
			return
		end

		local var_100_0 = var_0_1:get_character_attribute_by_calculate_no_equips(arg_100_1.id)
		local var_100_1 = not arg_100_1.now_skill and var_0_24.find_object_by_skill_id(arg_100_1.skill_id) or var_0_24.find_object_by_skill_type_skill_level(arg_100_1.now_skill, arg_100_1.skill_level)

		if not var_100_1 then
			return
		end

		self._detail_attr_table = {
			"hp",
			"atk",
			"def",
			"torpedo",
			"miss",
			"air_def",
			"capacity",
			nil,
			"antisub",
			"speed",
			"radar",
			"range",
			"luck",
			nil,
			nil,
			"crit",
			"hit",
			nil,
			"ext"
		}

		local var_100_2
		local var_100_3

		if var_100_1.effect[1] then
			for iter_100_0, iter_100_1 in pairs(var_100_1.effect) do
				if var_100_1.effect[iter_100_0].type == 1 and var_100_1.effect[iter_100_0].stage[1] == 1 then
					for iter_100_2, iter_100_3 in pairs(var_100_1.effect[iter_100_0].effect) do
						if iter_100_3.type == 3 then
							for iter_100_4, iter_100_5 in pairs(self._detail_attr_table) do
								if iter_100_3[self._detail_attr_table[iter_100_4]] then
									var_100_2 = self._detail_attr_table[iter_100_4]
									var_100_3 = iter_100_3[self._detail_attr_table[iter_100_4]]
								end
							end

							if var_100_2 and var_100_3 and arg_100_2[var_100_2] then
								var_100_3 = var_100_3 * var_0_15.get_attr_multiple_by_config(var_100_1, arg_100_1, iter_100_0)
								arg_100_2[var_100_2] = arg_100_2[var_100_2] + var_100_3
							end
						elseif iter_100_3.type == 4 then
							for iter_100_6, iter_100_7 in pairs(iter_100_3) do
								if iter_100_6 ~= "type" then
									arg_100_2[iter_100_6] = arg_100_2[iter_100_6] or 1
									arg_100_2[iter_100_6] = arg_100_2[iter_100_6] + arg_100_2[iter_100_6] * iter_100_7
								end
							end
						elseif iter_100_3.type == 5 then
							if arg_100_2[self._detail_attr_table[iter_100_3.attribute]] and arg_100_2[self._detail_attr_table[iter_100_3.attribute2]] then
								arg_100_2[self._detail_attr_table[iter_100_3.attribute2]] = arg_100_2[self._detail_attr_table[iter_100_3.attribute2]] + arg_100_2[self._detail_attr_table[iter_100_3.attribute]] * iter_100_3.rate
							end
						elseif iter_100_3.type == 94 then
							if arg_100_2.range >= iter_100_3.num then
								arg_100_2.range = arg_100_2.range or iter_100_3.num
							end
						elseif iter_100_3.type == 49 then
							for iter_100_8, iter_100_9 in ipairs(arg_100_1.equips) do
								local var_100_5 = var_0_25.find_object_by_cid(iter_100_9.id)

								if var_100_5 then
									for iter_100_10, iter_100_11 in pairs(var_100_5) do
										if arg_100_2[iter_100_10] and iter_100_11 ~= 0 and iter_100_10 ~= "range" and iter_100_10 ~= "hp" then
											arg_100_2[iter_100_10] = arg_100_2[iter_100_10] + iter_100_11 * iter_100_3.rate
										end
									end
								end
							end
						elseif iter_100_3.type == 50 then
							for iter_100_12, iter_100_13 in ipairs(arg_100_1.equips) do
								if iter_100_13.id > 0 then
									local var_100_6 = var_0_25.find_object_by_cid(iter_100_13.id)

									if arg_100_2[self._detail_attr_table[iter_100_3.attribute]] and var_100_6[self._detail_attr_table[iter_100_3.attribute]] and arg_100_2[self._detail_attr_table[iter_100_3.attribute2]] then
										arg_100_2[self._detail_attr_table[iter_100_3.attribute2]] = arg_100_2[self._detail_attr_table[iter_100_3.attribute2]] + var_100_6[self._detail_attr_table[iter_100_3.attribute]] * iter_100_3.rate
									end
								end
							end
						elseif iter_100_3.type == 51 then
							local var_100_7 = 0

							for iter_100_14, iter_100_15 in ipairs(arg_100_1.equips) do
								for iter_100_16, iter_100_17 in pairs(iter_100_3.equipment_type) do
									if iter_100_15.id > 0 and var_0_25.find_object_by_cid(iter_100_15.id).type == iter_100_17 then
										var_100_7 = var_100_7 + 1
									end
								end
							end

							for iter_100_18, iter_100_19 in pairs(iter_100_3) do
								if arg_100_2[iter_100_18] then
									arg_100_2[iter_100_18] = arg_100_2[iter_100_18] + iter_100_19 * var_100_7

									break
								end
							end
						elseif iter_100_3.type == 52 then
							for iter_100_20, iter_100_21 in ipairs(arg_100_1.equips) do
								for iter_100_22, iter_100_23 in pairs(iter_100_3.equipment_type) do
									local var_100_8 = var_0_25.find_object_by_cid(iter_100_21.id)

									if iter_100_21.id > 0 and var_100_8.type == iter_100_23 then
										for iter_100_24, iter_100_25 in pairs(iter_100_3) do
											if arg_100_2[iter_100_24] and var_100_8[iter_100_24] then
												arg_100_2[iter_100_24] = arg_100_2[iter_100_24] + var_100_8[iter_100_24] * iter_100_3[iter_100_24]
											end
										end
									end
								end
							end
						elseif iter_100_3.type == 54 then
							for iter_100_26, iter_100_27 in ipairs(arg_100_1.equips) do
								if iter_100_27.id > 0 then
									for iter_100_28, iter_100_29 in pairs(iter_100_3.equipment_type) do
										local var_100_9 = var_0_25.find_object_by_cid(iter_100_27.id)

										if iter_100_27.id > 0 and var_100_9.type == iter_100_3.equipment_type then
											for iter_100_30, iter_100_31 in pairs(iter_100_3) do
												if arg_100_2[self._detail_attr_table[iter_100_3.attribute]] and var_100_9[self._detail_attr_table[iter_100_3.attribute]] and arg_100_2[self._detail_attr_table[iter_100_3.attribute2]] then
													arg_100_2[self._detail_attr_table[iter_100_3.attribute2]] = arg_100_2[self._detail_attr_table[iter_100_3.attribute2]] + var_100_9[self._detail_attr_table[iter_100_3.attribute]] * iter_100_3.rate

													break
												end
											end
										end
									end
								end
							end
						elseif iter_100_3.type == 131 then
							local var_100_10

							if var_100_0[self._detail_attr_table[iter_100_3.attribute]] then
								var_100_10 = var_0_15.attr_impact_by_speed(var_100_0.speed, var_100_0[self._detail_attr_table[iter_100_3.attribute]], iter_100_3.num1, iter_100_3.num2) - var_100_0[self._detail_attr_table[iter_100_3.attribute]]
							end

							if var_100_10 then
								arg_100_2[self._detail_attr_table[iter_100_3.attribute]] = arg_100_2[self._detail_attr_table[iter_100_3.attribute]] + var_100_10
							end
						end
					end
				end
			end
		end
	end

	function arg_1_0:__add_workshop_attr(arg_101_1, arg_101_2)
		if not arg_101_1.id then
			return
		end

		if not next(self._workdata) then
			local var_101_0 = var_0_1:get_workshop_data()

			self._workdata = var_101_0 and var_0_15.little_clone(var_101_0) or {}
		end

		local var_101_1 = var_0_17.find_object_by_cid(arg_101_1.cid)

		for iter_101_0, iter_101_1 in pairs(self._workdata) do
			local var_101_2 = var_0_19.find_object_by_id(iter_101_1.id).effect[1]

			if var_101_2.shipTypes then
				for iter_101_2, iter_101_3 in pairs(var_101_2.shipTypes) do
					if var_101_2.shipTypes[iter_101_2] == var_101_1.type then
						local var_101_3 = var_0_16:get_attr_name(var_101_2.num4)

						if var_101_2.type == var_0_16.workshop_const.work_type.add_attribute and arg_101_2[var_101_3] then
							if var_101_2.countrys then
								for iter_101_4, iter_101_5 in pairs(var_101_2.countrys) do
									if iter_101_5 == var_101_1.country then
										arg_101_2[var_101_3] = arg_101_2[var_101_3] + var_101_2.num
									end
								end
							else
								arg_101_2[var_101_3] = arg_101_2[var_101_3] + var_101_2.num
							end
						elseif var_101_2.type == var_0_16.workshop_const.work_type.add_torpedo_damage and arg_101_2[var_101_3] and var_101_1[var_101_3] ~= 0 then
							arg_101_2[var_101_3] = arg_101_2[var_101_3] + var_101_2.num
						end
					end
				end
			end
		end
	end

	function arg_1_0:update_all_cell_number_setting()
		for iter_102_0, iter_102_1 in pairs(self._cell_list) do
			self:update_one_cell_number_setting(iter_102_1)
		end
	end

	function arg_1_0:update_one_cell_number_setting(arg_103_1)
		if not arg_103_1 then
			return
		end

		if self._is_fast_formation then
			local var_103_0 = 0

			var_103_0 = self._enter_type == var_0_16.enter_select_member_type.strengthen_res and self:__find_index_in_res_data(arg_103_1._data.id) or self._enter_type == var_0_16.enter_select_member_type.dock_disassemble and self:__find_index_in_disa_data(arg_103_1._data.id) or self._enter_type == var_0_16.enter_select_member_type.research_ship and self:__find_index_in_research_data(arg_103_1._data.id) or self._enter_type == var_0_16.enter_select_member_type.secretary_info_ship and self:__find_index_in_secretary_data(arg_103_1._data.id) or self:__find_index_in_team_data(arg_103_1._data.id)

			if self._enter_type == var_0_16.enter_select_member_type.dock_disassemble or self._enter_type == var_0_16.enter_select_member_type.secretary_info_ship or self._enter_type == var_0_16.enter_select_member_type.research_ship then
				if self._select_state == 1 then
					arg_103_1:set_fast_dock_disassemble_team_num(true, var_103_0, self._enter_type, 1)
				elseif self._select_state == 2 then
					arg_103_1:set_fast_dock_disassemble_team_num(nil, nil, nil, 2)
				elseif self._select_state == 0 then
					arg_103_1:set_fast_team_num(true, var_103_0, self._enter_type)
				else
					arg_103_1:set_fast_team_num(true, var_103_0, self._enter_type)
				end
			else
				arg_103_1:set_fast_team_num(true, var_103_0, self._enter_type)
			end
		end

		if self._is_custom_formation then
			self:set_select_ship_num(true)
			arg_103_1:set_custom_team_num(true, self:__find_index_in_custorm_team_data(arg_103_1._data.id), self._enter_type)
		else
			arg_103_1:set_custom_team_num()
		end
	end

	function arg_1_0:set_select_ship_num(arg_104_1)
		if arg_104_1 then
			self._control.custom_ship_info.custom_img.custom_num.text.text = #self._custom_team_data .. "/" .. var_0_16.max_select_type.two_hundred
		else
			local var_104_1 = var_0_1:get_custom_ship_list()

			if #var_104_1 == 1 then
				for iter_104_0, iter_104_1 in ipairs(var_104_1) do
					if iter_104_1 == 0 then
						-- block empty
					end
				end
			else
				self._control.custom_ship_info.custom_img.custom_num.text.text = #var_104_1 .. "/" .. var_0_16.max_select_type.two_hundred
			end
		end
	end

	function arg_1_0.__check_ship_if_is_in_can_act_(arg_105_0, arg_105_1)
		if not arg_105_1 then
			return
		end

		local var_105_0, var_105_1 = var_0_1:get_tower_used_ship()

		if var_105_1 and var_105_0 then
			for iter_105_0, iter_105_1 in pairs(arg_105_1) do
				if var_0_15.have_data(var_105_0, iter_105_1.id) then
					arg_105_1[iter_105_0]._can_not_act = true
				end
			end
		end

		return arg_105_1
	end

	function arg_1_0:__find_index_in_six_team_data(arg_106_1)
		for iter_106_0, iter_106_1 in ipairs(self._team_data) do
			if iter_106_1 == arg_106_1 then
				local var_106_0 = var_0_1:find_character_by_id(arg_106_1)

				return iter_106_0
			end
		end
	end

	function arg_1_0:__find_index_in_custorm_team_data(arg_107_1)
		local var_107_0 = var_0_1:get_custom_ship_list()

		if self._custom_team_data and next(self._custom_team_data) and self._custom_team_data then
			for iter_107_0, iter_107_1 in ipairs(self._custom_team_data) do
				if iter_107_1 == arg_107_1 then
					local var_107_1 = var_0_1:find_character_by_id(arg_107_1)

					return iter_107_0
				end
			end
		end
	end

	function arg_1_0:__find_index_in_team_data(arg_108_1)
		for iter_108_0, iter_108_1 in ipairs(self._team_data) do
			if iter_108_1 == arg_108_1 then
				local var_108_0 = var_0_1:find_character_by_id(arg_108_1)

				return iter_108_0
			end
		end
	end

	function arg_1_0:__find_index_in_res_data(arg_109_1)
		for iter_109_0, iter_109_1 in ipairs(self._ships_for_remould_id_list) do
			if iter_109_1 == arg_109_1 then
				local var_109_0 = var_0_1:find_character_by_id(arg_109_1)

				return iter_109_0
			end
		end

		return nil
	end

	function arg_1_0:__find_index_in_disa_data(arg_110_1)
		for iter_110_0, iter_110_1 in ipairs(self._ships_for_dock_disassemble_id_list) do
			if iter_110_1 == arg_110_1 then
				return iter_110_0
			end
		end

		return nil
	end

	function arg_1_0:__find_index_in_research_data(arg_111_1)
		for iter_111_0, iter_111_1 in ipairs(self._ships_for_dock_research_ship_id_list) do
			if iter_111_1 == arg_111_1 then
				return iter_111_0
			end
		end

		return nil
	end

	function arg_1_0:__find_index_in_secretary_data(arg_112_1)
		for iter_112_0, iter_112_1 in ipairs(self._ships_for_dock_secretary_ship_id_list) do
			if iter_112_1 == arg_112_1 then
				return iter_112_0
			end
		end

		return nil
	end

	function arg_1_0:_play_into_se(arg_113_1)
		self:playSE(arg_113_1, false)
	end

	function arg_1_0:__set_single_item_name()
		if var_0_1:get_guide_state() then
			local var_114_0 = self._control.all_ship.Viewport.edge_mask.Content.transform:GetChild(1).gameObject
			local var_114_1 = var_114_0.transform:Find("BG")

			self._record_ship_btn = var_114_0.transform:GetChild(0)

			if var_114_1 then
				var_114_1.name = var_0_16.guide_const_name.team_parent_guide_name
			end
		end
	end

	function arg_1_0:__sort_cell_of_special_enter_type(arg_115_1)
		if self._enter_type == var_0_16.enter_select_member_type.captainroom_fleet or self._enter_type == var_0_16.enter_select_member_type.dormitory then
			local var_115_0 = self._prepare_disassemble_data

			if self._prepare_disassemble_data == nil then
				var_115_0 = {}
			end

			local var_115_1 = self:__filter_fast_all_character_list()

			self._team_data = {}

			for iter_115_0, iter_115_1 in ipairs(var_115_0) do
				for iter_115_2, iter_115_3 in pairs(var_115_1) do
					if iter_115_1.id == iter_115_3.id then
						var_0_9(self._team_data, iter_115_3.id)
					end
				end
			end

			if self._enter_type == var_0_16.enter_select_member_type.dormitory then
				local var_115_2 = {}
				local var_115_3 = var_0_11:getInstance("dormitory")

				if var_115_3._curr_room_index then
					for iter_115_4, iter_115_5 in pairs(arg_115_1) do
						if iter_115_5.room == var_115_3._curr_room_index or iter_115_5.room == 0 then
							var_0_9(var_115_2, iter_115_5)
						end
					end

					arg_115_1 = var_115_2
				end
			end

			local var_115_4 = {}

			for iter_115_6, iter_115_7 in ipairs(var_115_0) do
				for iter_115_8, iter_115_9 in pairs(arg_115_1) do
					if iter_115_7.id == iter_115_9.id then
						var_0_9(var_115_4, iter_115_9)

						break
					end
				end
			end

			for iter_115_10, iter_115_11 in ipairs(var_115_0) do
				local var_115_5 = false
				local var_115_6 = false

				for iter_115_12, iter_115_13 in ipairs(var_115_4) do
					if iter_115_11.id == iter_115_13.id then
						var_115_5 = true
					end
				end

				for iter_115_14, iter_115_15 in ipairs(self._team_data) do
					if iter_115_11.id == iter_115_15 then
						var_115_6 = true
					end
				end

				if not var_115_5 then
					var_0_9(var_115_4, iter_115_11)
				end

				if not var_115_6 then
					var_0_9(self._team_data, iter_115_11.id)
				end
			end

			for iter_115_16, iter_115_17 in pairs(arg_115_1) do
				local var_115_7 = false

				for iter_115_18, iter_115_19 in pairs(var_115_0) do
					if iter_115_17.id == iter_115_19.id then
						var_115_7 = true
					end
				end

				if not var_115_7 then
					var_0_9(var_115_4, iter_115_17)
				end
			end

			self._cell_data = var_115_4
		end
	end

	function arg_1_0:__prevent_frequently_click()
		local var_116_0 = self:autoKillDOTween(var_0_12.Sequence())

		var_116_0:AppendInterval(0.4)
		var_116_0:Play()
	end

	function arg_1_0:__init_remove_ship()
		if self._enter_type == var_0_16.enter_select_member_type.dock_disassemble or self._enter_type == var_0_16.enter_select_member_type.strengthen_res or self._enter_type == var_0_16.enter_select_member_type.research_ship then
			self._remove_ship_list = {}

			for iter_117_0, iter_117_1 in pairs((var_0_1:get_all_ship_in_team())) do
				var_0_9(self._remove_ship_list, iter_117_1.id)
			end

			for iter_117_2, iter_117_3 in pairs((var_0_1:get_captainroom_garrison())) do
				var_0_9(self._remove_ship_list, iter_117_3)
			end

			local var_117_0 = var_0_1:get_sixth_combat_info()

			for iter_117_4, iter_117_5 in pairs((var_117_0 or nil) and (var_117_0.ship_total or {})) do
				var_0_9(self._remove_ship_list, iter_117_5)
			end

			for iter_117_6, iter_117_7 in pairs((var_0_1:get_strike_team_data())) do
				var_0_9(self._remove_ship_list, iter_117_7)
			end

			for iter_117_8, iter_117_9 in pairs((var_0_1:get_ocean_team_data())) do
				var_0_9(self._remove_ship_list, iter_117_9)
			end

			for iter_117_10, iter_117_11 in pairs((var_0_1:get_normal_team_info())) do
				var_0_9(self._remove_ship_list, iter_117_11)
			end

			for iter_117_12, iter_117_13 in pairs(var_0_1:get_secretary_info().members) do
				var_0_9(self._remove_ship_list, iter_117_13)
			end

			local var_117_1 = {}

			for iter_117_14 = 1, #var_0_16.campaign_map_id do
				if var_0_1:get_campaign_members(var_0_16.campaign_map_id[iter_117_14]) then
					var_0_9(var_117_1, (var_0_1:get_campaign_members(var_0_16.campaign_map_id[iter_117_14])))

					if var_117_1[iter_117_14] and next(var_117_1[iter_117_14]) and var_117_1[iter_117_14] ~= 0 then
						for iter_117_15, iter_117_16 in pairs(var_117_1[iter_117_14]) do
							if iter_117_16 and iter_117_16 ~= 0 then
								var_0_9(self._remove_ship_list, iter_117_16)
							end
						end
					end
				end
			end

			local var_117_2 = {}

			if self._enter_type == var_0_16.enter_select_member_type.research_ship then
				local var_117_3 = var_0_1:get_class_total_info()

				if #var_117_3 > 0 then
					for iter_117_17, iter_117_18 in pairs(var_117_3) do
						for iter_117_19 = 1, 6 do
							if iter_117_18.seat[iter_117_19] ~= 0 then
								var_0_9(var_117_2, iter_117_18.seat[iter_117_19])
							end
						end
					end
				end

				local var_117_4 = var_0_1:get_use_info_data()

				if var_117_4.chef then
					var_0_9(var_117_2, var_117_4.chef)
				end

				if var_117_4.secretary then
					var_0_9(var_117_2, var_117_4.secretary)
				end
			end

			local var_117_5 = {}

			for iter_117_20, iter_117_21 in pairs(self._remove_ship_list) do
				if not var_117_5[iter_117_21] then
					var_117_5[iter_117_21] = true

					var_0_9(var_117_2, iter_117_21)
				end
			end

			self._remove_ship_list = var_117_2
		elseif self._enter_type == var_0_16.enter_select_member_type.restaurant_show_type then
			local var_117_6 = {}

			for iter_117_22, iter_117_23 in pairs((var_0_1:get_character_list())) do
				if self._food_info.country ~= var_0_16.country_type_rule.general.value and var_0_17.find_object_by_cid(iter_117_23.cid).country ~= self._food_info.country then
					var_0_9(var_117_6, iter_117_23.id)
				end
			end

			self._remove_ship_list = var_117_6
		end
	end

	function arg_1_0:set_select_panel_order()
		local var_118_0 = var_0_11:getInstance("dock_team")

		if ((var_118_0 or nil) and var_118_0._panel.transform:GetComponent("Canvas").sortingOrder) == self._panel.transform:GetComponent("Canvas").sortingOrder then
			self._panel.transform:GetComponent("Canvas").sortingOrder = self._panel.transform:GetComponent("Canvas").sortingOrder + 1
		end
	end

	function arg_1_0:update_research_info()
		self._control.research_ship_info.bg.need_text.need_txt.text.text = var_0_1:get_need_research_ship_task_info().num - var_0_1:get_research_ship_select_ship_num()
		self._control.research_ship_info.bg.have_text.have_txt.text.text = #self._ships_for_dock_research_ship_id_list

		if #self._ships_for_dock_research_ship_id_list == 0 then
			self._control.confirm_btn.image.sprite = self:loadSprite(var_0_16.ship_detail_switch.close)
			self._control.confirm_btn:GetComponent("Button").interactable = false
		else
			self._control.confirm_btn:GetComponent("Button").interactable = true
			self._control.confirm_btn.image.sprite = self:loadSprite(var_0_16.ship_detail_switch.open)
		end
	end

	function arg_1_0:update_secretary_info()
		if #self._ships_for_dock_secretary_ship_id_list == 0 then
			self._control.confirm_btn.image.sprite = self:loadSprite(var_0_16.ship_detail_switch.close)
			self._control.confirm_btn:GetComponent("Button").interactable = false
		else
			self._control.confirm_btn:GetComponent("Button").interactable = true
			self._control.confirm_btn.image.sprite = self:loadSprite(var_0_16.ship_detail_switch.open)
		end
	end

	function arg_1_0:_set_custom_ship_info()
		if self._iscustom_state then
			self._control.all_ship_info.custom_ship_btn:SetActive(true)
			self._control.all_ship_info.custom_ship_2:SetActive(false)
			self._control.all_ship_info.all_ship_btn_bg:SetActive(false)
		else
			self._control.all_ship_info.custom_ship_btn:SetActive(false)
			self._control.all_ship_info.custom_ship_2:SetActive(true)
			self._control.all_ship_info.all_ship_btn_bg:SetActive(true)
		end

		self._control.all_ship_info:SetActive(true)
		self._control.custom_ship_info:SetActive(false)
		self._control.custom_editor_btn:SetActive(false)
		self._control.cancel_editor_btn:SetActive(false)
		self._control.comfirm_custom_btn:SetActive(false)
	end

	function arg_1_0:show_custom_panel()
		self._iscustom_state = true

		self._control.all_ship_info.custom_ship_btn:SetActive(true)
		self._control.all_ship_info.custom_ship_2:SetActive(false)
		self._control.all_ship_info.all_ship_btn_bg:SetActive(false)
		self._control.custom_editor_btn:SetActive(true)

		if self._enter_type == var_0_16.enter_select_member_type.strengthen_res or self._enter_type == var_0_16.enter_select_member_type.research_ship then
			self._control.custom_editor_btn:SetActive(false)
			self._control.all_ship_info:SetActive(false)
		end

		if self._enter_type == var_0_16.enter_select_member_type.evo or self._enter_type == var_0_16.enter_select_member_type.restaurant or self._enter_type == var_0_16.enter_select_member_type.college or self._enter_type == var_0_16.enter_select_member_type.captainroom_fleet or self._enter_type == var_0_16.enter_select_member_type.pre_formation or self._enter_type == var_0_16.enter_select_member_type.secretary_info_ship or self._enter_type == var_0_16.enter_select_member_type.fight and self._team_type == var_0_16.team_type.campaign or self._enter_type == var_0_16.enter_select_member_type.skill then
			self._control.fast_btn:SetActive(false)
		else
			self._control.fast_btn:SetActive(true)
		end
	end

	function arg_1_0:show_all_ship_panel()
		self._iscustom_state = false

		self._control.all_ship_info.custom_ship_btn:SetActive(false)
		self._control.all_ship_info.custom_ship_2:SetActive(true)
		self._control.all_ship_info.all_ship_btn_bg:SetActive(true)
		self._control.custom_editor_btn:SetActive(false)

		if self._enter_type == var_0_16.enter_select_member_type.six_year_primary or self._enter_type == var_0_16.enter_select_member_type.research_ship or self._enter_type == var_0_16.enter_select_member_type.six_year_map_select or self._enter_type == var_0_16.enter_select_member_type.strengthen_res or self._enter_type == var_0_16.enter_select_member_type.secretary_info_ship or self._enter_type == var_0_16.enter_select_member_type.dock_disassemble then
			self._control.all_ship_info.custom_ship_2:SetActive(false)
			self._control.custom_editor_btn:SetActive(false)
		end
	end

	function arg_1_0:set_iscustom_button_postion()
		self._control.detail_btn.rectTransform.anchoredPosition = var_0_13(var_0_16.select_member_btn_posX.detail_btn_posX, var_0_16.select_member_btn_pos.detail_btn_posY + 130)
		self._control.sort_order_btn.rectTransform.anchoredPosition = var_0_13(var_0_16.select_member_btn_posX.detail_btn_posX, var_0_16.select_member_btn_pos.sort_order_btn_posY + 130)
		self._control.sort_type_btn.rectTransform.anchoredPosition = var_0_13(var_0_16.select_member_btn_posX.detail_btn_posX, var_0_16.select_member_btn_pos.sort_type_btn_posY + 130)
		self._control.bg_container.tip_title.desc_text.text.text = var_0_10:getNowLang("select_ship_tip4")

		self._control.bg_container.tip_title.desc:SetActive(true)

		self._control.bg_container.tip_title.text.text = var_0_10:getNowLang("custom_editor")
	end

	function arg_1_0:set_is_button_postion()
		self._control.detail_btn.rectTransform.anchoredPosition = var_0_13(var_0_16.select_member_btn_posX.detail_btn_posX, var_0_16.select_member_btn_pos.detail_btn_posY - 65)
		self._control.sort_order_btn.rectTransform.anchoredPosition = var_0_13(var_0_16.select_member_btn_posX.detail_btn_posX, var_0_16.select_member_btn_pos.sort_order_btn_posY - 60)
		self._control.sort_type_btn.rectTransform.anchoredPosition = var_0_13(var_0_16.select_member_btn_posX.detail_btn_posX, var_0_16.select_member_btn_pos.sort_type_btn_posY - 60)
	end

	function arg_1_0:_init_select_member_button_postion()
		self._control.detail_btn.rectTransform.anchoredPosition = var_0_13(var_0_16.select_member_btn_posX.detail_btn_posX, var_0_16.select_member_btn_pos.detail_btn_posY)
		self._control.sort_order_btn.rectTransform.anchoredPosition = var_0_13(var_0_16.select_member_btn_posX.detail_btn_posX, var_0_16.select_member_btn_pos.sort_order_btn_posY)
		self._control.sort_type_btn.rectTransform.anchoredPosition = var_0_13(var_0_16.select_member_btn_posX.detail_btn_posX, var_0_16.select_member_btn_pos.sort_type_btn_posY)
		self._panel_type = 0
	end

	function arg_1_0:is_custom_select_member_panel(arg_127_1)
		if self._enter_type ~= var_0_16.enter_select_member_type.six_year_primary and self._enter_type ~= var_0_16.enter_select_member_type.six_year_map_select and self._enter_type ~= var_0_16.enter_select_member_type.research_ship and self._enter_type ~= var_0_16.enter_select_member_type.strengthen_res and self._enter_type ~= var_0_16.enter_select_member_type.dock_disassemble then
			var_0_26:setKeyData("custom_panel", arg_127_1)
		end

		if arg_127_1 == 1 then
			self._control.bg_container.tip_title.desc_text.text.text = var_0_10:getNowLang("select_ship_tip2")
			self._control.bg_container.tip_title.text.text = var_0_10:getNowLang("select_team_basic")
		elseif arg_127_1 == 2 then
			self._control.bg_container.tip_title.desc_text.text.text = var_0_10:getNowLang("select_ship_tip3")
			self._control.bg_container.tip_title.text.text = var_0_10:getNowLang("select_team_basic")
		end

		if self._enter_type == var_0_16.enter_select_member_type.dock_disassemble then
			self._control.bg_container.tip_title.desc_text.text.text = var_0_10:getNowLang("select_ship_tip1")
		elseif self._enter_type == var_0_16.enter_select_member_type.strengthen_res then
			self._control.bg_container.tip_title.desc_text.text.text = var_0_10:getNowLang("select_ship_tip8")
		elseif self._enter_type == var_0_16.enter_select_member_type.research_ship then
			self._control.bg_container.tip_title.desc_text.text.text = var_0_10:getNowLang("select_ship_tip6")
		elseif self._enter_type == var_0_16.enter_select_member_type.six_year_primary or self._enter_type == var_0_16.enter_select_member_type.six_year_map_select then
			self._control.bg_container.tip_title.desc_text.text.text = var_0_10:getNowLang("select_ship_tip7")
		end
	end

	function arg_1_0:get_now_panel_state()
		local var_128_0 = var_0_26:getKeyData("custom_panel")

		if var_128_0 and var_128_0 == "2" and self._enter_type ~= var_0_16.enter_select_member_type.six_year_primary and self._enter_type ~= var_0_16.enter_select_member_type.research_ship and self._enter_type ~= var_0_16.enter_select_member_type.six_year_map_select and self._enter_type ~= var_0_16.enter_select_member_type.strengthen_res and self._enter_type ~= var_0_16.enter_select_member_type.dock_disassemble then
			local var_128_1 = self:autoKillDOTween(var_0_12.Sequence())

			var_128_1:AppendInterval(0.1)
			var_128_1:AppendCallback(function()
				self:__onClick_all_ship_info_custom_ship_2()
			end)
			var_128_1:AppendCallback(function()
				var_128_1:Kill()
			end)
			var_128_1:Play()
		else
			local var_128_2 = self:autoKillDOTween(var_0_12.Sequence())

			var_128_2:AppendInterval(0.1)
			var_128_2:AppendCallback(function()
				self:__onClick_all_ship_info_all_ship_btn_txt_all_ship_2_btn()
			end)
			var_128_2:AppendCallback(function()
				var_128_2:Kill()
			end)
			var_128_2:Play()
		end
	end

	function arg_1_0:__onReset()
		self._is_already_init = false
		self._character_data_list = {}
		self._team_data = {}
		self._is_already_fast_init = false
		self._is_already_custom_init = false
		self._is_fast_formation = false
		self._is_custom_formation = false
		self._enter_type = nil
		self._prepare_disassemble_data = {}
		self._filter_name = nil
		self._full_strengthen_flag = false
		self._full_skill_flag = false
		self._detail_index = 1
		self._campaign = false
		self._bigmap_info = nil
		self._small_ship_count = 0
		self._middle_ship_count = 0
		self._big_ship_count = 0
		self._shipton_num_small = 0
		self._shipton_num_middle = 0
		self._shipton_num_big = 0
		self._team_type = nil
		self._sixth_ships = {}
		self._big_map_pb = {}
		self._ships_for_remould_id_list = {}
		self._ships_for_dock_disassemble_id_list = {}
		self._ships_for_dock_research_ship_id_list = {}
		self._ships_for_dock_secretary_ship_id_list = {}
		self._is_dock_team_change = false
		self._is_choiced_num = 0
		self._temporary_data = {}

		if self._sort_layer then
			self._sort_layer:destroy()
		end

		if self._type_layer then
			self._type_layer:destroy()
		end

		self._sort_layer = nil
		self._type_layer = nil
		self._cell_data = {}
		self._control.all_ship.Viewport.edge_mask.Content.rectTransform.anchoredPosition = var_0_13(0, 0)
		self.content_pos = nil
		self._limit_type = nil
		self._workdata = {}
		self._collection_data = {}
		self._restaurant_buff = {}
		self._select_state = false
		self._panel_type = 0
		self._iscustom_state = false
		self._food_info = nil
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_134_0)
	local var_134_0 = var_0_11:class("select_member")

	var_134_0._is_already_init = false
	var_134_0._config_data = nil
	var_134_0._info_list = {}
	var_134_0._character_data_list = {}
	var_134_0._team_index = nil
	var_134_0._index = nil
	var_134_0._team_data = {}
	var_134_0._is_already_fast_init = false
	var_134_0._is_already_custom_init = false
	var_134_0._is_fast_formation = false
	var_134_0._enter_type = nil
	var_134_0._prepare_disassemble_data = {}
	var_134_0._filter_name = nil
	var_134_0._full_strengthen_flag = false
	var_134_0._full_skill_flag = false
	var_134_0._reusable_cell = nil
	var_134_0._cell_data = nil
	var_134_0._detail_index = 1
	var_134_0._campaign = false
	var_134_0._bigmap_info = nil
	var_134_0._small_ship_count = 0
	var_134_0._middle_ship_count = 0
	var_134_0._big_ship_count = 0
	var_134_0._shipton_num_small = 0
	var_134_0._shipton_num_middle = 0
	var_134_0._shipton_num_big = 0
	var_134_0._team_type = nil
	var_134_0._ship_type = nil
	var_134_0._sixth_ships = {}
	var_134_0._big_map_pb = {}
	var_134_0._ships_for_remould_id_list = {}
	var_134_0._ships_for_dock_disassemble_id_list = {}
	var_134_0._ships_for_dock_research_ship_id_list = {}
	var_134_0._ships_for_dock_secretary_ship_id_list = {}
	var_134_0._is_dock_team_change = false
	var_134_0._is_choiced_num = 0
	var_134_0._temporary_data = {}
	var_134_0._remove_ship_list = {}
	var_134_0._limit_type = nil
	var_134_0._workdata = {}
	var_134_0._collection_data = {}
	var_134_0._restaurant_buff = {}
	var_134_0._select_state = 0
	var_134_0._iscustom_state = false
	var_134_0._iscustom_ship_list = {}
	var_134_0._is_custom_formation = false
	var_134_0._custorm_team_data = {}
	var_134_0._ships_for_dock_custorm_id_list = {}
	var_134_0._panel_type = 0
	var_134_0._is_clear_custom_select_ship = false
	var_134_0._food_info = nil

	gamecore.extend_obj(var_134_0)

	return var_134_0
end

return var_0_0
