local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_3 = gamecore.util_func
local var_0_4 = gamecore.UILoader
local var_0_5 = gameenum.common_type
local var_0_6 = gamecore.user
local var_0_8 = table.insert

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onScaleButtonClick_bg_top_menu_return_btn(arg_2_0)
		var_0_4:destroyInstance("abyss_dock_team")

		if var_0_4:getInstance("abyss_select_member") then
			var_0_4:destroyInstance("abyss_select_member")
		end

		local var_2_0 = var_0_4:getInstance("abyss_event")

		if var_2_0 then
			var_2_0:setVisible(true)
		else
			var_0_4:createInstance("abyss_event"):show(true)
		end
	end

	function arg_1_0:__onToggle_bg_top_menu_tab_toggle_tab_1()
		if self._current_content_type == var_0_5.abyss_dock_team_toggle_type.formation then
			return
		end

		self:_synthesis_clear_data_Active()

		if self._current_team_index ~= 1 then
			self._current_content_type = var_0_5.abyss_dock_team_toggle_type.formation
			self.switch_content_not_first_team = true
		else
			self:update_content(var_0_5.abyss_dock_team_toggle_type.formation)
		end

		var_0_4:destroyInstance("abyss_select_member")
	end

	function arg_1_0:__onToggle_bg_top_menu_tab_toggle_tab_3()
		if self._current_content_type == var_0_5.abyss_dock_team_toggle_type.remake then
			return
		end

		if self._current_team_index ~= 1 then
			self._current_content_type = var_0_5.abyss_dock_team_toggle_type.remake
			self.switch_content_not_first_team = true
		else
			self:update_content(var_0_5.abyss_dock_team_toggle_type.remake)
		end

		var_0_4:destroyInstance("abyss_select_member")
	end

	function arg_1_0:__onToggle_bg_top_menu_tab_toggle_tab_4()
		if self._current_content_type == var_0_5.abyss_dock_team_toggle_type.synthetise then
			return
		end

		self:_synthesis_clear_data_Active()

		if self._current_team_index ~= 1 then
			self._current_content_type = var_0_5.abyss_dock_team_toggle_type.synthetise
			self.switch_content_not_first_team = true

			self._control.bg.middle_menu.synthesis_interface:setActive(true)
		else
			self:update_content(var_0_5.abyss_dock_team_toggle_type.synthetise)
		end

		var_0_4:destroyInstance("abyss_select_member")
	end

	function arg_1_0.__onClick_bg_middle_menu_remake_content_left(arg_6_0)
		return
	end

	function arg_1_0.__onClick_bg_middle_menu_remake_content_left_ship_bg_btn(arg_7_0)
		return
	end

	function arg_1_0:__onClick_bg_middle_menu_synthesis_interface_left_all_right_material()
		self._onclick_right_or_left_pos = 2

		local var_8_0, var_8_1 = self:_get_abyss_ship_data()
		local var_8_2 = var_0_4:getInstance("abyss_select_member") or var_0_4:createInstance("abyss_select_member")

		local function var_8_3(arg_9_0)
			self:_show_synthesis_panel_info(arg_9_0)
		end

		self:setVisible(false)
		var_8_2:close_formation_layer()
		var_8_2:set_synthesis_enter_team(self._abyss_synthesis_ship_info or {})
		var_8_2:show(var_8_0, true, var_8_1, var_8_3, nil, true)
		var_8_2:set_right_up_text((var_0_1:getNowLang("ui_ny21_select_combine")))
		var_8_2:set_back_func(function()
			var_0_4:createInstance("abyss_dock_team"):setVisible(true)
		end)
	end

	function arg_1_0:__onClick_bg_middle_menu_synthesis_interface_left_all_right_material_ship_bg_btn()
		self._onclick_right_or_left_pos = 2

		local var_11_0, var_11_1 = self:_get_abyss_ship_data()
		local var_11_2 = var_0_4:getInstance("abyss_select_member") or var_0_4:createInstance("abyss_select_member")

		local function var_11_3(arg_12_0)
			self:_show_synthesis_panel_info(arg_12_0)
		end

		self:setVisible(false)
		var_11_2:set_synthesis_enter_team(self._abyss_synthesis_ship_info)
		var_11_2:close_formation_layer()
		var_11_2:show(var_11_0, true, var_11_1, var_11_3, nil, true)
		var_11_2:set_right_up_text((var_0_1:getNowLang("ui_ny21_select_combine")))
		var_11_2:set_back_func(function()
			local var_13_0 = var_0_4:createInstance("abyss_dock_team")

			var_13_0:setVisible(true)

			if var_0_6:get_need_clear_panel_info() then
				var_13_0:_synthesis_clear_data_Active()
			else
				return
			end
		end)
	end

	function arg_1_0:__onClick_bg_middle_menu_synthesis_interface_left_all_left_material()
		self._onclick_right_or_left_pos = 1

		local var_14_0, var_14_1 = self:_get_abyss_ship_data()
		local var_14_2 = var_0_4:getInstance("abyss_select_member") or var_0_4:createInstance("abyss_select_member")

		local function var_14_3(arg_15_0)
			self:_show_synthesis_panel_info(arg_15_0)
		end

		self:setVisible(false)
		var_14_2:set_synthesis_enter_team({})
		var_14_2:close_formation_layer()
		var_14_2:show(var_14_0, true, var_14_1, var_14_3, nil, true)
		var_14_2:set_right_up_text((var_0_1:getNowLang("ui_ny21_select_combine")))
		var_14_2:set_back_func(function()
			var_0_4:createInstance("abyss_dock_team"):setVisible(true)
		end)
	end

	function arg_1_0:__onClick_bg_middle_menu_synthesis_interface_left_all_left_material_ship_bg_btn()
		self._onclick_right_or_left_pos = 1

		local var_17_0, var_17_1 = self:_get_abyss_ship_data()
		local var_17_2 = var_0_4:getInstance("abyss_select_member") or var_0_4:createInstance("abyss_select_member")

		local function var_17_3(arg_18_0)
			self:_show_synthesis_panel_info(arg_18_0)
		end

		var_17_2:set_synthesis_enter_team(self._abyss_synthesis_ship_info)
		self:setVisible(false)
		var_17_2:close_formation_layer()
		var_17_2:show(var_17_0, true, var_17_1, var_17_3, nil, true)
		var_17_2:set_right_up_text((var_0_1:getNowLang("ui_ny21_select_combine")))
		var_17_2:set_back_func(function()
			local var_19_0 = var_0_4:createInstance("abyss_dock_team")

			var_19_0:setVisible(true)

			if var_0_6:get_need_clear_panel_info() then
				var_19_0:_synthesis_clear_data_Active()
			else
				return
			end
		end)
	end

	function arg_1_0:__onScaleButtonClick_bg_middle_menu_synthesis_interface_right_all_clear_btn()
		self:_synthesis_clear_data_Active()
	end

	function arg_1_0:__onScaleButtonClick_bg_middle_menu_synthesis_interface_right_all_streng_btn()
		local var_21_0 = 0

		for iter_21_0, iter_21_1 in pairs(self._abyss_synthesis_ship_info) do
			var_21_0 = var_21_0 + 1
		end

		if var_21_0 == 2 then
			if self:_is_have_boss_ship_2() then
				var_0_4:createInstance("msgbox"):show(var_0_1:getNowLang("ui_ny21_deep_combine_boss_content"), function()
					self:__onclik_msgbox_yes_req()
				end, function()
					self:__onclik_msgbox_no_back()
				end, var_0_1:getNowLang("ui_ny21_deep_combine_boss_title"), var_0_5.msg_type.tip, false)
			else
				self:__onclik_msgbox_yes_req()
			end
		end
	end

	function arg_1_0:__onScaleButtonClick_bg_middle_menu_remake_content_right_right_bg_2_streng_btn()
		var_0_6:req_AbyssEvoReq(self._data2)
	end

	function arg_1_0.__onClick_bg_middle_menu_remake_content_left_shipinfo_select_btn(arg_25_0)
		local var_25_0 = var_0_4:getInstance("abyss_select_member") or var_0_4:createInstance("abyss_select_member")
		local var_25_1 = var_0_4:getInstance("abyss_dock_team") or var_0_4:createInstance("abyss_dock_team")

		if var_25_0 then
			local var_25_2 = {}

			for iter_25_0, iter_25_1 in pairs(var_0_3.little_clone(var_0_6:get_abyss_character_list()) or {}) do
				if iter_25_1.can_evo == false then
					var_0_8(var_25_2, iter_25_1)
				end
			end

			var_25_1:setVisible(false)
			var_25_0:close_formation_layer()
			var_25_0:show(nil, true, var_25_2, function(arg_26_0)
				var_25_1:set_ship_info(arg_26_0[1])
			end)
			var_25_0:set_right_up_text((var_0_1:getNowLang("ui_ny21_select_reform")))
			var_25_0:set_back_func(function()
				var_25_1:setVisible(true)
			end)
		end
	end

	function arg_1_0:__onClick_bg_middle_menu_remake_content_left_shipinfo_ship_change_btn()
		local var_28_0 = var_0_4:getInstance("abyss_select_member") or var_0_4:createInstance("abyss_select_member")
		local var_28_1 = var_0_4:getInstance("abyss_dock_team") or var_0_4:createInstance("abyss_dock_team")

		if var_28_0 then
			local var_28_2 = {}

			for iter_28_0, iter_28_1 in pairs(var_0_3.little_clone(var_0_6:get_abyss_character_list()) or {}) do
				if iter_28_1.can_evo == false then
					var_0_8(var_28_2, iter_28_1)
				end
			end

			var_28_1:setVisible(false)
			var_28_0:close_formation_layer()
			var_28_0:show(self._data, true, var_28_2, function(arg_29_0)
				var_28_1:set_ship_info(arg_29_0[1])

				if arg_29_0[1]._is_exit then
					self:set_ship_info()
					self:init_remake_language()
				end
			end)
			var_28_0:set_right_up_text((var_0_1:getNowLang("ui_ny21_select_reform")))
			var_28_0:set_back_func(function()
				var_28_1:setVisible(true)
			end)
		end
	end

	function arg_1_0:__onLongClick_bg_middle_menu_remake_content_left_shipinfo_ship_change_btn()
		local var_31_0 = var_0_4:getInstance("abyss_dock_team")

		if var_31_0 then
			var_31_0:setVisible(false)
		end

		self._data.equips = self._data2.equips

		var_0_4:createInstance("abyss_ship_detail"):show(var_0_5.enter_ship_detail_type.abyss_remake, self._data)
	end

	function arg_1_0:__onClick_bg_middle_menu_synthesis_interface_right_all_button_ship_detail()
		self:__onclick_button_show_abyss_synthesis_explain()
	end

	function arg_1_0:__onLongClick_bg_middle_menu_synthesis_interface_left_all_right_material_ship_bg_btn()
		self._onclick_right_or_left_pos = 2

		self:__long_click_goto_abyss_ship_detail(var_0_5.enter_ship_detail_type.abyss_synthesis, self._abyss_synthesis_ship_info[2].id)
	end

	function arg_1_0:__onLongClick_bg_middle_menu_synthesis_interface_left_all_left_material_ship_bg_btn()
		self._onclick_right_or_left_pos = 1

		self:__long_click_goto_abyss_ship_detail(var_0_5.enter_ship_detail_type.abyss_synthesis, self._abyss_synthesis_ship_info[1].id)
	end
end

function var_0_0.extend_obj(arg_35_0)
	return
end

return var_0_0
