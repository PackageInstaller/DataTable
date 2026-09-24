local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.user
local var_0_4 = gamecore.Language
local var_0_5 = gamecore.prompt
local var_0_6 = table.insert
local var_0_7 = DG.Tweening.DOTween
local var_0_8 = lx.clone_table
local var_0_9 = gameconfig.ship_config
local var_0_10 = gamecore.util_func

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_ship_empty_add_ship_btn()
		self:__prevent_frequently_click()

		if self._team_type == var_0_2.team_type.abyss_owner_team and var_0_3:get_abyss_enter_repair_time() ~= 0 then
			var_0_5:show(var_0_4:getNowLang("battleseanoticeok"))

			return
		end

		local var_2_0 = var_0_1:getInstance("fight_prepare")

		if var_2_0 and var_2_0._no_clicking then
			return
		end

		if self._team_type == var_0_2.team_type.abyss_team then
			self:__show_abyss_team_member()

			return
		end

		local var_2_1 = var_0_1:createInstance("select_member")

		if self._campagion_data and self._campagion_data.fleet_rule and self._campagion_data.fleet_rule[self._index] ~= -1 and self._campagion_data.fleet_rule[self._index] ~= 0 then
			for iter_2_0, iter_2_1 in pairs(var_0_2.filter_type) do
				if iter_2_1 == self._campagion_data.fleet_rule[self._index] then
					var_2_1._limit_type = iter_2_0
				end
			end
		end

		var_2_1:show(self._data, self._index, self._campaign, nil, self._ship_type)

		if self._team_type == var_0_2.team_type.sixth_team or self._team_type == var_0_2.team_type.mist_team then
			var_2_1:show_by_type(var_0_2.enter_select_member_type.six_year_map_select, nil, self._data, nil, self._team_type, self._go_to_map_id)
		elseif self._team_type == var_0_2.team_type.strike_map_team then
			var_2_1:show_by_type(var_0_2.enter_select_member_type.strike_map_select, nil, self._data, nil, self._team_type, self._go_to_map_id)
		elseif self._team_type == var_0_2.team_type.ocean_attack_team then
			var_2_1:show_by_type(var_0_2.enter_select_member_type.ocean_attack_map_select, nil, self._data, nil, self._team_type, self._go_to_map_id, function()
				self:set_what_active("fight_prepare", true)
			end)
		elseif self._team_type == var_0_2.team_type.pre_formation_team then
			local var_2_2 = var_0_1:getInstance("dock_team")

			if var_2_2 then
				var_2_2:setVisible(false)
			end

			local var_2_3 = var_0_1:getInstance("pre_formation")

			if var_2_3 then
				var_2_3:setVisible(false)
			end

			var_0_3:set_current_team(self._pre_team_num)
			var_2_1:show_by_type(var_0_2.enter_select_member_type.pre_formation, self._pre_team, self._data, nil, self._team_type, self._go_to_map_id)
		elseif self._team_type == var_0_2.team_type.abyss_owner_team then
			var_2_1:show_by_type(var_0_2.enter_select_member_type.abyss_dock_team_formation, nil, self._data, nil, self._team_type, self._go_to_map_id, function()
				self:set_what_active("fight_prepare", true)
			end)
		else
			if self._prepare_type == var_0_2.fight_prepare_right_panel_type.tower then
				var_2_1:show_by_type(var_0_2.enter_select_member_type.tower, nil, self._data, nil, self._team_type, self._go_to_map_id, function()
					self:set_what_active("fight_prepare", true)
				end)

				return
			elseif self._prepare_type == var_0_2.fight_prepare_right_panel_type.war_concerto_play then
				var_2_1:show_by_type(var_0_2.enter_select_member_type.war_concerto_play, nil, self._data, nil, self._team_type, self._go_to_map_id)

				return
			end

			var_2_1:show_by_type(var_0_2.enter_select_member_type.fight, nil, self._data, nil, self._team_type, self._go_to_map_id, function()
				self:set_what_active("fight_prepare", true)
			end)
		end

		if var_2_1 then
			var_2_1:setVisible(false)
			var_2_1:setVisible(true)
		end
	end

	function arg_1_0:__onClick_ship_item_ship_item_btn()
		self:__prevent_frequently_click()

		if self._team_type == var_0_2.team_type.abyss_owner_team and var_0_3:get_abyss_enter_repair_time() ~= 0 and self._prepare_type == var_0_2.fight_prepare_right_panel_type.abyss_model then
			var_0_5:show(var_0_4:getNowLang("battleseanoticeok"))

			return
		end

		local var_7_0 = var_0_1:getInstance("fight_prepare")

		if var_7_0 and var_7_0._no_clicking then
			return
		end

		local var_7_1 = var_0_1:getInstance("select_member") or var_0_1:createInstance("select_member")

		if self._campagion_data and self._campagion_data.fleet_rule and self._campagion_data.fleet_rule[self._index] ~= -1 and self._campagion_data.fleet_rule[self._index] ~= 0 then
			for iter_7_0, iter_7_1 in pairs(var_0_2.filter_type) do
				if iter_7_1 == self._campagion_data.fleet_rule[self._index] then
					var_7_1._limit_type = iter_7_0
				end
			end
		end

		if self._prepare_type == var_0_2.fight_prepare_right_panel_type.props or self._prepare_type == var_0_2.fight_prepare_right_panel_type.condition then
			var_7_1:show(self._data, self._index, self._campaign, nil, self._ship_type)
			var_7_1:show_by_type(var_0_2.enter_select_member_type.fight, nil, self._data, nil, self._team_type, self._go_to_map_id, function()
				self:set_what_active("fight_prepare", true)
			end)
			var_7_1:setVisible(false)
			var_7_1:setVisible(true)
		elseif self._prepare_type == var_0_2.fight_prepare_right_panel_type.supply then
			self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_goto))

			local var_7_2 = var_0_1:getInstance("fight_prepare")

			var_7_2:set_click_time(5)

			if not self._need_supply then
				var_0_5:show(var_0_4:getNowLang("supplyfullnotice"))

				return
			end

			local var_7_3 = self:get_supply_need()
			local var_7_4 = var_0_3:get_use_info_data()

			if var_7_3.oil_need > var_7_4.oil then
				var_0_5:show(var_0_4:getNowLang("oilnotenough"))

				return
			end

			if var_7_3.bullet_need > var_7_4.bullet then
				var_0_5:show(var_0_4:getNowLang("ammonotenough"))

				return
			end

			if var_7_3.aluminium_need > var_7_4.al then
				var_0_5:show(var_0_4:getNowLang("aluminumnotenough"))

				return
			end

			var_7_2:ship_supply(self._index)
		elseif self._prepare_type == var_0_2.fight_prepare_right_panel_type.repair then
			self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_goto))

			if not self._need_repair then
				var_0_5:show(var_0_4:getNowLang("no_need_repair"))

				return
			end

			local var_7_5 = self:get_quick_repair_need()
			local var_7_6 = var_0_3:get_use_info_data()

			if var_7_5.oil_need > var_7_6.oil then
				var_0_5:show(var_0_4:getNowLang("oilnotenough"))

				return
			end

			if var_7_5.steel_need > var_7_6.fe then
				var_0_5:show(var_0_4:getNowLang("steelnotenough"))

				return
			end

			if var_7_5.repair_item_need > self:__get_quick_repair_item_count() then
				var_0_5:show(var_0_4:getNowLang("quick_item_not_enough"))

				return
			end

			var_0_1:getInstance("fight_prepare"):ship_repair(self._index)
		elseif self._prepare_type == var_0_2.fight_prepare_right_panel_type.sixth then
			var_7_1:show(self._data, self._index)
			var_7_1:show_by_type(var_0_2.enter_select_member_type.six_year_map_select, nil, self._data, nil, self._team_type, self._go_to_map_id)
			var_7_1:setVisible(false)
			var_7_1:setVisible(true)
		elseif self._prepare_type == var_0_2.fight_prepare_right_panel_type.strike or self._prepare_type == var_0_2.fight_prepare_right_panel_type.strike_equip_preview then
			var_7_1:show(self._data, self._index)
			var_7_1:show_by_type(var_0_2.enter_select_member_type.strike_map_select, nil, self._data, nil, self._team_type, self._go_to_map_id)
			var_7_1:setVisible(false)
			var_7_1:setVisible(true)
		elseif self._prepare_type == var_0_2.fight_prepare_right_panel_type.ocean_attack then
			var_7_1:show(self._data, self._index)
			var_7_1:show_by_type(var_0_2.enter_select_member_type.ocean_attack_map_select, nil, self._data, nil, self._team_type, self._go_to_map_id, function()
				self:set_what_active("fight_prepare", true)
			end)
			var_7_1:setVisible(false)
			var_7_1:setVisible(true)
		elseif self._prepare_type == var_0_2.fight_prepare_right_panel_type.tower then
			var_7_1:show(self._data, self._index, self._campaign, nil, self._ship_type)
			var_7_1:show_by_type(var_0_2.enter_select_member_type.tower, nil, self._data, nil, self._team_type, self._go_to_map_id, function()
				self:set_what_active("fight_prepare", true)
			end)
			var_7_1:setVisible(false)
			var_7_1:setVisible(true)
		elseif self._prepare_type == var_0_2.fight_prepare_right_panel_type.war_concerto_play then
			var_7_1:show(self._data, self._index, self._campaign, nil, self._ship_type)
			var_7_1:show_by_type(var_0_2.enter_select_member_type.war_concerto_play, nil, self._data, nil, self._team_type, self._go_to_map_id)
			var_7_1:setVisible(false)
			var_7_1:setVisible(true)
		elseif self._prepare_type == var_0_2.fight_prepare_right_panel_type.pre_formation then
			var_0_3:set_current_team(self._pre_team_num)
			var_7_1:setVisible(true)
			var_7_1:show(self._data, self._index, self._campaign, nil, self._ship_type)
			var_7_1:show_by_type(var_0_2.enter_select_member_type.pre_formation, self._pre_team, nil, nil, self._team_type, self._go_to_map_id)
		elseif self._prepare_type == var_0_2.fight_prepare_right_panel_type.abyss_model then
			if self._team_type == var_0_2.team_type.abyss_team then
				self:__show_abyss_team_member(self._data)
			else
				var_7_1:show(self._data, self._index, self._campaign, nil, self._ship_type)
				var_7_1:show_by_type(var_0_2.enter_select_member_type.abyss_dock_team_formation, nil, self._data, nil, self._team_type, self._go_to_map_id)
				var_7_1:setVisible(false)
				var_7_1:setVisible(true)
			end
		elseif self._prepare_type == var_0_2.fight_prepare_right_panel_type.equip_preview or self._prepare_type == var_0_2.fight_prepare_right_panel_type.farfight_equip_preview then
			var_7_1:show(self._data, self._index, self._campaign, nil, self._ship_type)
			var_7_1:show_by_type(var_0_2.enter_select_member_type.fight, nil, self._data, nil, self._team_type, self._go_to_map_id, function()
				self:set_what_active("fight_prepare", true)
			end)
			var_7_1:setVisible(false)
			var_7_1:setVisible(true)
		elseif self._prepare_type == var_0_2.fight_prepare_right_panel_type.ninth_preview or self._prepare_type == var_0_2.fight_prepare_right_panel_type.ninth_equip_preview then
			var_7_1:show(self._data, self._index, self._campaign, nil, self._ship_type)
			var_7_1:show_by_type(var_0_2.enter_select_member_type.fight, nil, self._data, nil, self._team_type, self._go_to_map_id, function()
				self:set_what_active("fight_prepare", true)
			end)
			var_7_1:setVisible(false)
			var_7_1:setVisible(true)
		end
	end

	function arg_1_0.__show_abyss_team_member(arg_13_0, arg_13_1)
		local var_13_0 = var_0_1:createInstance("abyss_select_member")
		local var_13_1 = var_0_1:createInstance("fight_prepare")

		if not var_13_0 or not var_13_1 then
			return
		end

		local var_13_2 = {}
		local var_13_3 = var_0_8(var_0_3:get_abyss_team_info() or {})

		for iter_13_0, iter_13_1 in ipairs(var_13_3) do
			var_0_6(var_13_2, iter_13_0, {
				id = iter_13_1
			})
		end

		var_13_0:show(arg_13_1, nil, nil, function(arg_14_0)
			local var_14_0 = {}

			for iter_14_0, iter_14_1 in ipairs(arg_14_0) do
				if iter_14_1._team_idx then
					var_14_0[iter_14_1._team_idx] = iter_14_1.id
				else
					if arg_13_1 then
						for iter_14_2, iter_14_3 in ipairs(var_13_3) do
							if iter_14_3 == arg_13_1.id then
								if iter_14_1._is_exit then
									table.remove(var_13_3, iter_14_2)

									break
								end

								for iter_14_4, iter_14_5 in ipairs(var_13_3) do
									if iter_14_5 == iter_14_1.id then
										var_13_3[iter_14_4] = var_13_3[iter_14_2]

										break
									end
								end

								var_13_3[iter_14_2] = iter_14_1.id

								break
							end
						end
					else
						var_0_6(var_13_3, iter_14_1.id)
					end

					var_14_0 = var_13_3

					break
				end
			end

			if #var_14_0 == 0 then
				var_0_5:show(var_0_4:getNowLang("needflagshipinfleet"))
			else
				if arg_14_0[1] then
					for iter_14_6, iter_14_7 in pairs(var_14_0) do
						if iter_14_7 ~= arg_14_0[1].id and var_0_9.find_object_by_cid(var_0_3:find_abyss_character_by_id(iter_14_7).cid).evo_cid == arg_14_0[1].evo_cid then
							var_0_5:show(var_0_4:getNowLang("nosameshipinteam"))

							return
						end
					end
				end

				var_0_3:req_AbyssAbyssSaveTeamReq(var_14_0)
			end
		end)
		var_13_0:set_enter_team(var_13_2)
		var_13_0:set_back_func(function()
			var_13_1:setVisible(true)
		end)
	end

	function arg_1_0.__onClick_ship_item_ship_item_drag(arg_16_0)
		return
	end

	function arg_1_0:__onLongClick_ship_item_ship_item_btn()
		if self._is_nf then
			var_0_1:createInstance("mist_ship_skill"):show(self._data, self._index)

			return
		end

		local var_17_0 = var_0_1:createInstance("ship_detail")

		if self._team_type == var_0_2.team_type.abyss_owner_team then
			local var_17_1 = var_0_1:getInstance("fight_prepare")

			if not var_17_1 then
				var_0_5:show("this UI was destroyed unexpected")

				return
			end

			local var_17_2

			do
				var_17_1:setVisible(false)

				var_17_2 = {
					id = 1
				}
			end

			var_17_2.members = lx.clone_table(var_0_3:get_normal_team_info())

			local var_17_3

			if var_17_2 then
				var_17_3 = {
					index = self._index,
					toggle_type = self._prepare_type,
					team_data = var_17_2
				}
			end

			var_0_3:set_enter_ship_detail_type(var_0_2.enter_ship_detail_type.abyss_fight_prepare)
			var_17_0:show(var_0_2.enter_ship_detail_type.abyss_fight_prepare, var_17_3)

			return
		end

		if self._team_type == var_0_2.team_type.abyss_team then
			local var_17_4 = {}

			for iter_17_0, iter_17_1 in pairs(var_0_3:get_abyss_team_info()) do
				var_17_4[iter_17_0] = iter_17_1
			end

			var_0_3:set_enter_abyss_ship_detail_type(var_0_2.enter_ship_detail_type.abyss_fight_prepare)

			if next(var_17_4) then
				var_0_1:createInstance("abyss_ship_detail"):show(var_0_2.enter_ship_detail_type.abyss_fight_prepare, {
					index = self._index,
					toggle_type = self._tab_type,
					team_data = var_17_4
				})
			end

			return
		end

		if self._prepare_type == var_0_2.fight_prepare_right_panel_type.war_concerto_play then
			var_0_3:set_enter_ship_detail_type(var_0_2.enter_ship_detail_type.war_concerto_play)
			var_17_0:show(var_0_2.enter_ship_detail_type.war_concerto_play, self._data)

			return
		end

		if self._prepare_type == var_0_2.fight_prepare_right_panel_type.strike or self._team_type == var_0_2.team_type.strike_map_team then
			var_0_3:set_enter_ship_detail_type(var_0_2.enter_ship_detail_type.strike_fight_prepare)

			local var_17_5 = {
				members = {}
			}

			for iter_17_2, iter_17_3 in pairs(var_0_3:get_strike_team_data()) do
				var_17_5.members[iter_17_2] = iter_17_3
			end

			local var_17_6 = var_0_1:getInstance("fight_prepare")

			if var_17_6 then
				var_17_6:setVisible(false)
			end

			var_17_0:show(var_0_2.enter_ship_detail_type.strike_fight_prepare, {
				index = self._index,
				toggle_type = self._tab_type,
				team_data = var_17_5
			})

			return
		end

		if self._team_type == var_0_2.team_type.ocean_attack_team then
			var_0_3:set_enter_ship_detail_type(var_0_2.enter_ship_detail_type.ocean_select)
			var_17_0:show(var_0_2.enter_ship_detail_type.single_ship, self._data)

			return
		end

		if not self._campaign and self._team_type ~= var_0_2.team_type.sixth_team and self._team_type ~= var_0_2.team_type.pre_formation_team then
			local var_17_7 = var_0_1:getInstance("fight_prepare")
			local var_17_8 = 1

			if var_17_7 then
				var_17_7:setVisible(false)

				var_17_8 = var_17_7:get_current_team_index()
			end

			local var_17_9 = var_0_3:get_team_data(var_17_7:get_team_type(), var_17_8)

			if var_17_9 then
				var_17_0:show(var_0_2.enter_ship_detail_type.fight_team, {
					index = self._index,
					toggle_type = self._prepare_type,
					team_data = var_17_9
				})
			end
		elseif self._team_type == var_0_2.team_type.sixth_team then
			local var_17_10 = var_0_3:get_sixth_combat_info()

			if var_17_10 then
				local var_17_11 = var_0_1:getInstance("fight_prepare")

				if var_17_11 then
					var_17_11:setVisible(false)
				end

				var_17_0:show(var_0_2.enter_ship_detail_type.sixth_fight_prepare, {
					index = self._index,
					toggle_type = self._prepare_type,
					team_data = {
						id = 1,
						members = var_17_10.members
					}
				})
			end

			var_0_3:set_enter_ship_detail_type(var_0_2.enter_ship_detail_type.sixth_fight_prepare)
		elseif self._team_type == var_0_2.team_type.pre_formation_team then
			local var_17_12 = var_0_3:get_team_data(var_0_2.team_group_type.prepare, self._pre_team_num)

			if self._index > #var_17_12.members then
				return
			end

			if var_17_12 then
				var_17_0:show(var_0_2.enter_ship_detail_type.pre_formation, {
					index = self._index,
					toggle_type = self._prepare_type,
					team_data = {
						id = self._pre_team_num,
						members = var_17_12.members
					}
				})
			end
		else
			local var_17_13 = var_0_3:get_campaign_data(self._go_to_map_id)

			var_0_3:set_enter_ship_detail_type(var_0_2.enter_ship_detail_type.dormitory_ship)

			local var_17_14 = {}

			if var_17_13 and var_17_13.info.members then
				for iter_17_4, iter_17_5 in pairs(var_17_13.info.members) do
					if iter_17_5 and iter_17_5 ~= 0 then
						var_0_6(var_17_14, iter_17_5)
					end
				end

				for iter_17_6, iter_17_7 in pairs(var_17_14) do
					if iter_17_7 == self._data.id then
						self._data.index = iter_17_6
					end
				end

				self._data.team_data = var_17_13.info and var_0_10.little_clone(var_17_13.info) or {}
				self._data.team_data.members = var_17_14
				self._data.toggle_type = var_0_2.dock_team_toggle_type.formation
			end

			local var_17_16 = var_0_1:getInstance("fight_prepare")

			if var_17_16 then
				var_17_16:setVisible(false)
			end

			var_17_0:show(var_0_2.enter_ship_detail_type.fight_team, self._data, false)
		end
	end

	function arg_1_0:__prevent_frequently_click()
		local var_18_0
		local var_18_1 = var_0_1:getInstance("fight_prepare")
		local var_18_2 = var_0_1:getInstance("pre_formation")

		if var_18_1 and var_18_1:isVisible() then
			var_18_0 = var_18_1
		elseif var_18_2 and var_18_2:isVisible() then
			var_18_0 = var_18_2
		end

		if var_18_0 then
			var_18_0._control.cover:SetActive(true)

			local var_18_3 = self:autoKillDOTween(var_0_7.Sequence())

			var_18_3:AppendInterval(0.5)
			var_18_3:AppendCallback(function()
				var_18_0._control.cover:SetActive(false)
			end)
			var_18_3:Play()
		end
	end

	function arg_1_0.set_what_active(arg_20_0, arg_20_1, arg_20_2)
		local var_20_0 = var_0_1:getInstance(arg_20_1)

		if var_20_0 then
			var_20_0:setVisible(arg_20_2)
		end
	end
end

function var_0_0.extend_obj(arg_21_0)
	return
end

return var_0_0
