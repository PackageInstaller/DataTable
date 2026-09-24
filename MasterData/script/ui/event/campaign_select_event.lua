local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.UILoader
local var_0_3 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_enemy_info_bg_back_btn()
		self:__reset_close_bvr()

		if self._enter_type == var_0_3.select_prepare_type.sixth_select then
			local var_2_0 = var_0_1:get_sixth_combat_info()

			if var_2_0 and var_2_0.big_id and var_2_0.big_id ~= 0 and var_2_0.id and var_2_0.id ~= 0 then
				var_0_2:createInstance("sixth_map_node"):show({
					id = var_2_0.id
				})
			end
		elseif self._enter_type == var_0_3.select_prepare_type.strike then
			local var_2_1 = var_0_2:getInstance("strike_map")

			if var_2_1 then
				var_2_1:set_last_battle_grade(4)
				var_2_1:set_show_lock(true)

				local var_2_2 = var_0_1:get_strike_point_info()

				if var_2_2 and next(var_2_2) and var_2_2.buffs and next(var_2_2.buffs) and #var_2_2.buffs > 0 then
					for iter_2_0 = 1, #var_2_2.buffs do
						for iter_2_1, iter_2_2 in pairs(var_2_2.buffs) do
							if iter_2_2.point_id == var_2_2.next_point_id then
								table.remove(var_2_2.buffs, iter_2_1)
							end
						end
					end
				end
			end

			if var_0_1:get_next_ship_point() % 10 == 2 then
				var_0_1:req_SolidQuitMapReq()
			else
				local var_2_3 = var_0_2:createInstance("fight_prepare")

				var_0_1:set_return_type(true)
				var_2_3:show((var_0_1:get_fight_info_for_strike()))
			end
		elseif self._enter_type == var_0_3.select_prepare_type.tower_fight then
			var_0_2:createInstance("climb_tower"):show()
		elseif self._enter_type == var_0_3.select_prepare_type.seventh then
			local var_2_4 = var_0_2:getInstance("seven_sea_map")
			local var_2_5 = var_0_1:get_now_seven_map_id()

			if var_2_4 then
				var_2_4:show(var_2_5)
			else
				var_0_2:createInstance("seven_sea_map"):show(var_2_5)
			end

			var_2_4:show_cover_func(false)
		elseif self._enter_type == var_0_3.select_prepare_type.eighth then
			local var_2_6 = var_0_2:getInstance("eighth_sea_map")
			local var_2_7 = var_0_1:get_now_eighth_map_id()

			if var_2_6 then
				var_2_6:show(var_2_7)
				var_2_6:show_cover_func(false)
			else
				local var_2_8 = var_0_2:createInstance("eighth_sea_map")

				var_2_8:show(var_2_7)
				var_2_8:show_cover_func(false)
			end
		elseif self._enter_type == var_0_3.select_prepare_type.exercise then
			local var_2_9 = var_0_2:getInstance("gotofight")

			if var_2_9 then
				var_2_9:setVisible(true)
			end
		elseif self._enter_type == var_0_3.select_prepare_type.friend_exercise then
			local var_2_10 = var_0_2:getInstance("show_room")

			var_2_10:setVisible(true)
			var_2_10:show_btn_list_layer(false)
		elseif self._enter_type == var_0_3.select_prepare_type.campaign then
			local var_2_11 = var_0_2:getInstance("gotofight")

			if var_2_11 then
				var_2_11:setVisible(true)
			else
				local var_2_12 = var_0_2:createInstance("gotofight")

				var_2_12:show({
					toggle_index = var_0_3.fight_type.campaign,
					difficulty = var_0_1:get_campaign_difficulty()
				}, false)

				var_2_12._control.top_menu.tab_toggle.tab_1.toggle.isOn = false
				var_2_12._control.top_menu.tab_toggle.tab_4.toggle.isOn = true

				var_2_12:__onToggle_top_menu_tab_toggle_tab_4()
			end
		elseif self._enter_type == var_0_3.select_prepare_type.eighth then
			local var_2_13 = var_0_2:getInstance("eighth_sea_map")
			local var_2_14 = var_0_1:get_now_eighth_map_id()

			if var_2_13 then
				var_2_13:show(var_2_14)
			else
				var_0_2:createInstance("eighth_sea_map"):show(var_2_14)
			end

			var_2_13:show_cover_func(false)
		else
			local var_2_15 = var_0_2:createInstance("home")

			var_2_15:show()
			var_2_15:into_home_bgm()
			var_2_15:play_open_ui_animation(true)
		end

		self:__reset_panel()
		var_0_2:destroyInstance("campaign_select")

		if self._enter_type ~= var_0_3.select_prepare_type.strike then
			var_0_2:destroyInstance("fight_prepare")
		end

		var_0_2:destroyInstance("select_member")
	end

	function arg_1_0:__onClick_enemy_info_bg_fight_btn()
		self:__toggle_enemy_info(false)

		if self:__ship_count_in_team_check() then
			self:__toggle_select_formation(true)
		else
			self:__select_formation(1)
		end
	end

	function arg_1_0.__onClick_enemy_info_bg_circuity_btn(arg_4_0)
		return
	end

	function arg_1_0:__onClick_select_formation_right_widget_select1()
		self:__select_formation(1)
	end

	function arg_1_0:__onClick_select_formation_right_widget_select2()
		self:__select_formation(2)
	end

	function arg_1_0:__onClick_select_formation_right_widget_select3()
		self:__select_formation(3)
	end

	function arg_1_0:__onClick_select_formation_right_widget_select4()
		self:__select_formation(4)
	end

	function arg_1_0:__onClick_select_formation_right_widget_select5()
		self:__select_formation(5)
	end

	function arg_1_0:__onClick_skip_btn()
		if not self._time_execute_task_list then
			return
		end

		local var_10_0 = self._time_execute_task_list[#self._time_execute_task_list]

		if not self._time_execute_task_list[#self._time_execute_task_list] then
			return
		end

		if var_10_0.can_not_skip then
			return
		end

		if var_10_0.skip_func then
			var_10_0.skip_func()

			var_10_0.skip_func = nil
			var_10_0.execute_func = nil
		else
			var_10_0.execute_time = 0.1
		end
	end

	function arg_1_0:__onClick_enemy_info_bg_bvr_btn()
		if not self._set_bvr_btn_isOn then
			self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))
			var_0_1:req_BVRAttackChangeReq(true)
			self._control.enemy_info_bg.bvr_btn.spine_effect:SetActive(true)
			self:__play_animation(self._control.enemy_info_bg.bvr_btn.spine_effect, "icon_effect_230407", true)
		else
			self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
			self._control.enemy_info_bg.bvr_btn.spine_effect:SetActive(false)
			var_0_1:req_BVRAttackChangeReq(false)
		end

		self._set_bvr_btn_isOn = not self._set_bvr_btn_isOn
	end
end

function var_0_0.extend_obj(arg_12_0)
	return
end

return var_0_0
