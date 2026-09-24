local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gameenum.common_type
local var_0_4 = gamecore.UILoader
local var_0_5 = gamecore.user
local var_0_6 = 0.4

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg_bot_menu_supply_supply_btn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_goto))
		self:team_supply()
	end

	function arg_1_0:__onToggle_bg_top_menu_tab_toggle_tab_1()
		self:__close_custom_btn(false)
		var_0_5:set_all_select_member_list()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_top_btn))

		if self._current_content_type == var_0_2.dock_team_toggle_type.formation then
			return
		end

		self:__destroy_single_select_team_list()

		if self._current_team_index ~= 1 then
			self._current_content_type = var_0_2.dock_team_toggle_type.formation
			self.switch_content_not_first_team = true

			self:reset_fleet()
		else
			self:update_content(var_0_2.dock_team_toggle_type.formation, nil, nil, true)
		end

		self._control.bg.top_menu.fleet_toggle.fleetid1.text.text.color = Color.New(0.06274509803921569, 0.5058823529411764, 0.8745098039215686)
	end

	function arg_1_0:__onToggle_bg_top_menu_tab_toggle_tab_3()
		self:__close_custom_btn(false)
		var_0_5:set_all_select_member_list()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_top_btn))

		if self._current_content_type == var_0_2.dock_team_toggle_type.supply then
			return
		end

		self:__destroy_single_select_team_list()

		if self._current_team_index ~= 1 then
			self._current_content_type = var_0_2.dock_team_toggle_type.supply
			self.switch_content_not_first_team = true

			self:reset_fleet()
		else
			self:update_content(var_0_2.dock_team_toggle_type.supply, nil, nil, true)
		end

		self._control.bg.top_menu.fleet_toggle.fleetid1.text.text.color = Color.New(0.06274509803921569, 0.5058823529411764, 0.8745098039215686)
		self._team_click_times = var_0_6
	end

	function arg_1_0:__onToggle_bg_top_menu_tab_toggle_tab_4()
		if not self._is_short_into then
			self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_top_btn))
		end

		var_0_5:set_all_select_member_list()

		if self._current_content_type == var_0_2.dock_team_toggle_type.equipment then
			return
		end

		self:__destroy_single_select_team_list()

		if self._current_team_index ~= 1 then
			self._current_content_type = var_0_2.dock_team_toggle_type.equipment
			self.switch_content_not_first_team = true

			self:reset_fleet()
		else
			self:update_content(var_0_2.dock_team_toggle_type.equipment, nil, nil, true)
		end

		self._control.bg.top_menu.fleet_toggle.fleetid1.text.text.color = Color.New(0.06274509803921569, 0.5058823529411764, 0.8745098039215686)
		self._team_click_times = var_0_6
	end

	function arg_1_0:__onToggle_bg_top_menu_fleet_toggle_fleetid1()
		self:__close_custom_btn(false)

		if self._current_team_index == 1 then
			return
		end

		self:update_content(self._current_content_type, 1)

		for iter_6_0, iter_6_1 in ipairs(self._dock_tween_list) do
			iter_6_1:Kill()
		end

		self._dock_tween_list = {}

		self:__play_scroll_animation()
		var_0_5:set_all_select_member_list()
	end

	function arg_1_0:__onToggle_bg_top_menu_fleet_toggle_fleetid2()
		self:__close_custom_btn(false)

		if self._current_team_index == 2 then
			return
		end

		self:update_content(self._current_content_type, 2)

		for iter_7_0, iter_7_1 in ipairs(self._dock_tween_list) do
			iter_7_1:Kill()
		end

		self._dock_tween_list = {}

		self:__play_scroll_animation()
		var_0_5:set_all_select_member_list()
	end

	function arg_1_0:__onToggle_bg_top_menu_fleet_toggle_fleetid3()
		self:__close_custom_btn(false)

		if self._current_team_index == 3 then
			return
		end

		self:update_content(self._current_content_type, 3)

		for iter_8_0, iter_8_1 in ipairs(self._dock_tween_list) do
			iter_8_1:Kill()
		end

		self._dock_tween_list = {}

		self:__play_scroll_animation()
		var_0_5:set_all_select_member_list()
	end

	function arg_1_0:__onToggle_bg_top_menu_fleet_toggle_fleetid4()
		self:__close_custom_btn(false)

		if self._current_team_index == 4 then
			return
		end

		self:update_content(self._current_content_type, 4)

		for iter_9_0, iter_9_1 in ipairs(self._dock_tween_list) do
			iter_9_1:Kill()
		end

		self._dock_tween_list = {}

		self:__play_scroll_animation()
		var_0_5:set_all_select_member_list()
	end

	function arg_1_0:__onToggle_bg_top_menu_fleet_toggle_fleetid5()
		if self._team_click_times > 0 then
			return
		end

		if self._current_team_index == 5 then
			return
		end

		self:update_content(self._current_content_type, 5)
		self._type_layer:setVisible(true)

		if self._type_layer then
			self._type_layer:reset_select_state()
			self._type_layer:setVisible(false)
		end

		self._sort_layer:setVisible(true)

		if self._sort_layer then
			self._sort_layer:reset_select_state()
			self._sort_layer:setVisible(false)
		end

		self:update_single_select_team_list()

		if self._current_content_type == var_0_2.dock_team_toggle_type.equipment then
			self._control.bg.bot_menu.filter:SetActive(true)
			self._control.bg.bot_menu.tips:SetActive(false)
			self._control.bg.bot_menu.supply:SetActive(false)

			return
		end

		self._control.bg.bot_menu.filter:SetActive(false)
	end

	function arg_1_0:__onClick_bg_top_menu_repair_btn()
		self:setVisible(false)

		if var_0_4:getInstance("select_member") then
			var_0_4:destroyInstance("select_member")
		end

		if var_0_4:getInstance("home") then
			var_0_4:destroyInstance("home")
		end

		var_0_4:createInstance("bathroom"):show("dock_team")
	end

	function arg_1_0:__onClick_bg_bot_menu_filter_sort_type_btn()
		self._type_layer:setVisible(true)
	end

	function arg_1_0:__onClick_bg_bot_menu_filter_sort_order_btn()
		self._sort_layer:setVisible(true)
	end

	function arg_1_0:__onClick_bg_middle_menu_team_content_obj_left_btn()
		local var_14_0 = self._current_team_index == self._min_team_index and self._max_team_index or self:__calculate_team_index(self._current_team_index - 1, "minus")

		if not var_14_0 then
			return
		end

		self._control.bg.top_menu.fleet_toggle["fleetid" .. tostring(var_14_0)].toggle.isOn = true
	end

	function arg_1_0:__onClick_bg_middle_menu_team_content_obj_right_btn()
		self._control.bg.top_menu.fleet_toggle["fleetid" .. tostring(self._current_team_index == self._max_team_index and self._min_team_index or self:__calculate_team_index(self._current_team_index + 1, "plus"))].toggle.isOn = true
	end

	function arg_1_0:__onScaleButtonClick_bg_top_menu_return_btn()
		self._is_short_into = false

		var_0_5:set_all_select_member_list()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back_two))
		self:play_out_animation(function()
			var_0_4:destroyInstance("select_member")
			var_0_4:destroyInstance("dock_team")
			var_0_4:destroyInstance("equip_list")
			var_0_4:destroyInstance("equip_sort_layer")

			local var_17_0 = var_0_4:createInstance("home")

			if var_17_0 then
				var_17_0:show()
			end
		end)
	end

	function arg_1_0:__onClick_bg_top_menu_fleet_toggle_fleetid_pre_formation()
		local var_18_0 = var_0_4:getInstance("dock_team")

		if var_18_0 then
			var_18_0:setVisible(false)
		end

		var_0_4:createInstance("pre_formation"):show({
			sub_type = 1,
			enter_type = var_0_2.enter_select_member_type.dock_team,
			enter_team = self._current_team_index
		})
	end

	function arg_1_0.__onClick_bg_middle_menu_cancel_station(arg_19_0)
		local var_19_0 = var_0_4:createInstance("msgbox")

		if not var_19_0 then
			return
		end

		var_19_0:show(var_0_1:getNowLang("ui_activitydefendcanceltip"), function()
			var_19_0:setVisible(false)

			local var_20_0 = var_0_5:get_fifth_station_info()

			if next(var_20_0) then
				for iter_20_0, iter_20_1 in pairs(var_20_0) do
					if iter_20_1 == arg_19_0._current_team_index then
						var_0_5:req_ConcertoStationExitReq(arg_19_0._current_team_index)
					end
				end
			else
				var_0_5:req_StationPointExitReq(arg_19_0._current_team_index)
			end
		end, function()
			var_19_0:setVisible(false)
		end, var_0_1:getNowLang("ui_activitydefendcancel"))
	end

	function arg_1_0.__onClick_bg_top_menu_fleet_toggle_equip_all_ship_info_custom_ship_btn(arg_22_0)
		return
	end

	function arg_1_0.__onClick_bg_top_menu_fleet_toggle_equip_all_ship_info_all_ship_btn_txt(arg_23_0)
		return
	end

	function arg_1_0:__onClick_bg_top_menu_fleet_toggle_equip_all_ship_info_all_ship_btn_txt_all_ship_2_btn()
		self._is_custom_panel = false

		self:set_all_ship_or_custom_ship_state(false)
		self:update_single_select_team_list()
	end

	function arg_1_0:__onClick_bg_top_menu_fleet_toggle_equip_all_ship_info_custom_ship_2()
		self._is_custom_panel = true

		self:set_all_ship_or_custom_ship_state(true)
		self:update_single_select_team_list()
	end
end

function var_0_0.extend_obj(arg_26_0)
	arg_26_0._sort_layer = nil
	arg_26_0._type_layer = nil
end

return var_0_0
