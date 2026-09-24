local var_0_0 = {}
local var_0_1 = gameenum.common_type
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gamecore.prompt
local var_0_5 = gamecore.Language
local var_0_6 = DG.Tweening.DOTween

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_empty()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.open))

		if self._no_click_event then
			return
		end

		self:__prevent_frequently_click()

		if self._tab_type == var_0_1.dock_team_toggle_type.formation then
			local var_2_0 = var_0_2:getInstance("select_member")

			if not var_2_0 then
				var_2_0 = var_0_2:createInstance("select_member")
				var_2_0._is_dock_team_change = true
			end

			var_2_0:show(self._data, self._index, nil, nil, nil, nil, true)
			var_2_0:show_by_type(var_0_1.enter_select_member_type.dock_team_empty, nil, self._data, nil, nil, nil, function()
				self:set_dock_team_visible(true)
			end)
		elseif self._tab_type == var_0_1.dock_team_toggle_type.supply then
			-- block empty
		elseif self._tab_type == var_0_1.dock_team_toggle_type.equipment then
			-- block empty
		end
	end

	function arg_1_0:__onClick_BG_all_layer_item_btn()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.task_goto))

		if self._no_click_event then
			return
		end

		self:__prevent_frequently_click()

		if self._tab_type == var_0_1.dock_team_toggle_type.formation then
			local var_4_0 = var_0_2:getInstance("select_member")

			if not var_4_0 then
				var_4_0 = var_0_2:createInstance("select_member")
				var_4_0._is_dock_team_change = true
			end

			var_4_0:show(self._data, self._index)
			var_4_0:show_by_type(self._tab_type, nil, self._data, nil, nil, nil, function()
				self:set_dock_team_visible(true)
			end)

			var_4_0._is_dock_team_change = true
		elseif self._tab_type == var_0_1.dock_team_toggle_type.supply then
			if var_0_3:is_character_station_state(self._data.id) then
				var_0_4:show(var_0_5:getNowLang("guard_tip"))

				return
			end

			if not var_0_3:get_guide_state() then
				var_0_2:getInstance("dock_team"):ship_supply(self._index)
			end
		elseif self._tab_type == var_0_1.dock_team_toggle_type.equipment then
			local var_4_1 = var_0_2:getInstance("dock_team")
			local var_4_3 = var_0_3:get_team_data(var_0_1.team_type.normal, (var_4_1 or nil) and var_4_1:get_current_team_index())

			if var_4_3 then
				var_4_1:setVisible(false)
				var_0_2:createInstance("ship_detail"):show(var_0_1.enter_ship_detail_type.dock_team_equip, {
					index = self._index,
					toggle_type = self._tab_type,
					team_data = var_4_3
				})
			end
		end
	end

	function arg_1_0:__onLongClick_BG_all_layer_item_btn()
		if self._no_click_event then
			return
		end

		local var_6_0 = var_0_2:createInstance("ship_detail")
		local var_6_1 = var_0_2:getInstance("dock_team")
		local var_6_3 = var_0_3:get_team_data(var_0_1.team_type.normal, (var_6_1 or nil) and var_6_1:get_current_team_index())

		if var_6_3 then
			var_6_0:show(var_0_1.enter_ship_detail_type.dock_team, {
				index = self._index,
				toggle_type = self._tab_type,
				team_data = var_6_3,
				marry = var_6_3.marry
			})
		end
	end

	function arg_1_0:__onClick_BG_all_layer_drag_layer()
		if self._no_click_event then
			return
		end

		if var_0_3:get_guide_state() and self._tab_type == var_0_1.dock_team_toggle_type.supply then
			var_0_2:getInstance("dock_team"):ship_supply(self._index)
		end
	end

	function arg_1_0.set_dock_team_visible(arg_8_0, arg_8_1)
		local var_8_0 = var_0_2:getInstance("dock_team")

		if var_8_0 then
			var_8_0:setVisible(arg_8_1)
		end
	end

	function arg_1_0:__prevent_frequently_click()
		local var_9_0 = var_0_2:getInstance("dock_team")

		if var_9_0 and var_9_0:isVisible() then
			var_9_0._control.bg.cover:SetActive(true)

			local var_9_1 = self:autoKillDOTween(var_0_6.Sequence())

			var_9_1:AppendInterval(0.5)
			var_9_1:AppendCallback(function()
				var_9_0._control.bg.cover:SetActive(false)
			end)
			var_9_1:Play()
		end
	end
end

function var_0_0.extend_obj(arg_11_0)
	return
end

return var_0_0
