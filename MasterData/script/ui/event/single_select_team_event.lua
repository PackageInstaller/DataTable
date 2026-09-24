local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.user
local var_0_4 = gamecore.prompt
local var_0_5 = gamecore.Language
local var_0_7 = gameconfig.ship_config
local var_0_8 = table.insert
local var_0_9 = gamecore.util_func

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_BG()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_goto))
		log.print_r(self._data.state, "self._data.state")

		if not self._is_can_click and self._data.state == var_0_2.ship_state.expedition then
			return
		elseif self._data.state == var_0_2.ship_state.station then
			local var_2_0 = var_0_1:getInstance("select_member")

			if not var_2_0 then
				return
			end

			if not var_2_0:get_is_fast_formation() and self._enter_type ~= var_0_2.enter_select_member_type.restaurant then
				var_2_0:setVisible(false)
				var_2_0:after_close_select_member(true)
				var_0_4:show(var_0_5:getNowLang("guard_tip"))

				return
			end
		end

		if self._enter_type == var_0_2.enter_select_member_type.dock_team or self._enter_type == var_0_2.enter_select_member_type.fight or self._enter_type == var_0_2.enter_select_member_type.dock_team_empty or self._enter_type == var_0_2.enter_select_member_type.evo or self._enter_type == var_0_2.enter_select_member_type.skill or self._enter_type == var_0_2.enter_select_member_type.college then
			local var_2_1 = var_0_1:getInstance("select_member")

			if var_2_1 then
				var_2_1.content_pos = var_2_1._control.all_ship.Viewport.edge_mask.Content.transform.anchoredPosition
			end
		end

		if self._tab_type == var_0_2.dock_team_toggle_type.captainroom_fleet then
			local var_2_2 = var_0_1:getInstance("captainroom_fleet")

			if var_2_2 then
				var_2_2:show_layer(false)

				local var_2_3 = var_0_3:get_captainroom_garrison()
				local var_2_4 = {}

				if var_2_3 then
					for iter_2_0, iter_2_1 in ipairs(var_2_3) do
						var_0_8(var_2_4, (var_0_3:find_character_by_id(var_2_3[iter_2_0])))
					end
				end

				var_0_1:createInstance("select_member"):show_by_type(var_0_2.enter_select_member_type.captainroom_fleet, var_2_4, nil)
			end

			return
		elseif self._tab_type == var_0_2.dock_team_toggle_type.captainroom_friend_fleet then
			return
		end

		local var_2_5 = var_0_1:getInstance("select_member")

		if var_2_5 and var_2_5:get_is_custom_formation() and var_2_5._panel_type == var_0_2.enter_select_member_type.custom_ship then
			var_2_5:update_custom_team_index(self._data, var_0_2.max_select_type.two_hundred, true)

			return
		end

		if self._enter_type == var_0_2.enter_select_member_type.dock_disassemble or self._enter_type == var_0_2.enter_select_member_type.strengthen_res or self._enter_type == var_0_2.enter_select_member_type.captainroom_fleet or self._enter_type == var_0_2.enter_select_member_type.dormitory or self._enter_type == var_0_2.enter_select_member_type.research_ship or self._enter_type == var_0_2.enter_select_member_type.secretary_info_ship or self._enter_type == var_0_2.enter_select_member_type.pre_formation then
			if var_2_5:get_is_fast_formation() then
				if var_2_5:get_index_in_team_data(self._data) then
					self:set_fast_team_num()
				end

				if self._enter_type == var_0_2.enter_select_member_type.captainroom_fleet or self._enter_type == var_0_2.enter_select_member_type.dormitory or self._enter_type == var_0_2.enter_select_member_type.pre_formation then
					var_2_5:update_fast_team_index(self._data, var_0_2.max_select_type.six, true)
				elseif self._enter_type == var_0_2.enter_select_member_type.strengthen_res then
					var_2_5:update_fast_team_index(self._data, var_0_2.max_select_type.eighty, true)
					self:refresh()
				elseif self._enter_type == var_0_2.enter_select_member_type.research_ship then
					var_2_5._select_state = 0

					var_2_5:update_fast_team_index(self._data, var_0_3:get_need_research_ship_task_info().num - var_0_3:get_research_ship_select_ship_num(), true)
					self:refresh()
				elseif self._enter_type == var_0_2.enter_select_member_type.dock_disassemble then
					var_2_5._select_state = 0

					var_2_5:update_fast_team_index(self._data, var_0_2.max_select_type.two_hundred, true)
					self:refresh()
				elseif self._enter_type == var_0_2.enter_select_member_type.secretary_info_ship then
					var_2_5:update_fast_team_index(self._data, var_0_2.max_select_type.six, true)
					self:refresh()
				else
					var_2_5:update_fast_team_index(self._data, var_0_2.max_select_type.forty, true)
				end
			end
		elseif self._enter_type == var_0_2.enter_select_member_type.strengthen or self._enter_type == var_0_2.enter_select_member_type.evo or self._enter_type == var_0_2.enter_select_member_type.skill then
			for iter_2_2 = 5, 8 do
				local var_2_6 = var_0_3:get_team_data(2, iter_2_2)

				if var_2_6 and var_2_6.members then
					for iter_2_3, iter_2_4 in ipairs(var_2_6.members) do
						local var_2_7 = var_0_3:find_character_by_id(iter_2_4)

						if iter_2_4 == self._data.id and var_2_7.state ~= var_0_2.expedition_state.prepare and var_2_7.state ~= var_0_2.ship_state.repair then
							var_0_4:show(var_0_5:getNowLang("noticeshipisinexplore"))

							return
						end
					end
				end
			end

			local var_2_8 = var_0_1:getInstance("remake")

			if var_2_8 then
				var_2_8:set_ship_info(self._data)
				var_2_5:setVisible(false)
				var_2_8:setVisible(true)
			end
		elseif self._enter_type == var_0_2.enter_select_member_type.restaurant then
			var_2_5:setVisible(false)

			local var_2_9 = var_0_1:getInstance("restaurant_setting")

			var_2_9:setVisible(true)

			if var_2_9._now_chef_id ~= self._data.id then
				var_0_3:req_SetChefReq(self._data.id)
			end

			return
		elseif self._enter_type == var_0_2.enter_select_member_type.college then
			var_0_1:getInstance("select_tactis_view"):save_now_select_ship_data(self._data)
			var_2_5:setVisible(false)

			return
		elseif self._enter_type == var_0_2.enter_select_member_type.restaurant_show_type then
			local var_2_10 = var_0_1:getInstance("msgbox")

			local function var_2_11()
				var_0_3:req_SetChefReq(self._data.id)
			end

			local function var_2_12()
				return
			end

			if var_2_10 then
				var_2_10:show(var_0_5:getNowLang("cook_replace"), var_2_11, var_2_12, var_0_5:getNowLang("restaurantsetting"), var_0_2.msg_type.tip)
			else
				var_0_1:createInstance("msgbox"):show(var_0_5:getNowLang("cook_replace"), var_2_11, var_2_12, var_0_5:getNowLang("restaurantsetting"), var_0_2.msg_type.tip)
			end

			return
		else
			if self._enter_type ~= var_0_2.enter_select_member_type.six_year_primary and self._enter_type ~= var_0_2.enter_select_member_type.six_year_map_select and self._tab_type ~= var_0_2.dock_team_toggle_type.equipment and self._data.state == var_0_2.ship_state.expedition and not self._control.BG.all_layer.mask_img.activeSelf then
				var_0_4:show(var_0_5:getNowLang("noticeshipisinexplore"))

				return
			end

			if self._team_type == var_0_2.team_type.expedition then
				local var_2_13 = var_0_3:get_team_data(self._team_type, self._team_index)
				local var_2_14 = var_2_13 and var_0_9.little_clone(var_2_13) or {}
				local var_2_15

				if var_2_14.members then
					var_2_15 = var_2_14.members
				end

				local var_2_16 = next(var_2_15) ~= nil

				for iter_2_5, iter_2_6 in ipairs(var_2_15) do
					if var_0_3:find_character_by_id(iter_2_6).state ~= var_0_2.ship_state.expedition then
						var_2_16 = false
					end
				end

				if var_2_16 then
					local var_2_17 = var_0_1:getInstance("select_member")

					var_2_17:setVisible(false)
					var_2_17:after_close_select_member(true)
					var_0_4:show(var_0_5:getNowLang("pveinexpore"))

					return
				end
			end

			if self._tab_type == var_0_2.dock_team_toggle_type.supply then
				self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_goto))
			else
				self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.add_ship))
			end
		end

		if var_0_1:getInstance("pre_formation") then
			return
		end

		local var_2_18 = var_2_5 and var_2_5:get_is_fast_formation() or nil
		local var_2_19 = var_0_1:getInstance("dock_team")

		if var_2_19 then
			if self._tab_type == var_0_2.dock_team_toggle_type.formation then
				if var_2_18 then
					if var_2_5:get_index_in_team_data(self._data) then
						self:set_fast_team_num(var_2_18)
					end

					var_2_5:update_fast_team_index(self._data, var_0_2.max_select_type.six, true)

					return
				end

				local var_2_20 = var_2_5:get_index()
				local var_2_21 = true
				local var_2_22 = var_2_19:get_current_team_index()
				local var_2_23

				if self._orgin_ship_data and self._orgin_ship_data.state == var_0_2.ship_state.station or self._orgin_ship_data == nil and var_0_3:get_team_data(1, var_2_22).station then
					var_2_5:setVisible(false)
					var_2_5:after_close_select_member(true)
					var_0_4:show(var_0_5:getNowLang("guard_tip"))

					return
				end

				if self._data then
					var_2_23 = var_0_7.find_object_by_cid(self._data.cid)
				end

				for iter_2_7, iter_2_8 in pairs((var_0_3:get_character_list())) do
					for iter_2_9 = 1, 4 do
						if var_2_22 == iter_2_9 then
							local var_2_24 = var_0_3:get_team_data(1, iter_2_9)

							if var_2_24 and var_2_24.members then
								for iter_2_10, iter_2_11 in pairs(var_2_24.members) do
									local var_2_25 = var_0_3:find_character_by_id(iter_2_11).cid

									if (self._data and self._data.cid == var_2_25 or var_2_23 and var_0_7.find_object_by_cid(var_2_25).evo_cid == var_2_23.evo_cid) and self._data.id ~= iter_2_11 then
										var_2_21 = false
									end
								end
							end
						end
					end
				end

				local var_2_26 = var_2_5:get_index()
				local var_2_27 = var_0_3:get_team_data(1, var_2_22)

				if not var_2_21 and var_2_27.members and var_2_27.members[var_2_26] then
					local var_2_28 = var_0_3:find_character_by_id(var_2_27.members[var_2_26]).cid

					if self._data and self._data.cid == var_2_28 or var_2_23 and var_0_7.find_object_by_cid(var_2_28).evo_cid == var_2_23.evo_cid then
						var_2_21 = true
					end
				end

				if var_2_21 then
					if self._data.is_exist then
						var_2_19:save_team_info_single(var_2_26)
					else
						var_2_19:save_team_info_single(var_2_26, self._data)
					end

					var_2_5:setVisible(false)
					var_2_5:after_close_select_member(true)

					return
				else
					var_0_4:show(var_0_5:getNowLang("nosameshipinteam"))
					var_2_5:setVisible(false)
					var_2_5:after_close_select_member(true)

					return
				end
			elseif self._tab_type == var_0_2.dock_team_toggle_type.supply then
				var_2_19:ship_supply(self._index, self._data.id)
			elseif self._tab_type == var_0_2.dock_team_toggle_type.equipment then
				local var_2_29 = var_0_1:createInstance("ship_detail")
				local var_2_30 = var_0_1:getInstance("dock_team")
				local var_2_31
				local var_2_32 = 1

				if var_2_30 then
					var_2_30:setVisible(false)

					var_2_32 = self._data.team_num
					var_2_31 = var_2_30:get_current_team_index()
				end

				local var_2_33

				if var_2_31 and var_2_31 == 5 then
					var_2_33 = self._data
					var_2_33.members = {}
				else
					var_2_33 = var_0_3:get_team_data(var_0_2.team_type.normal, var_2_32) or self._data
				end

				if var_2_32 == 0 then
					var_2_33.members = {}
				end

				var_2_29:show(var_0_2.enter_ship_detail_type.dock_team_equip, {
					index = self._index,
					toggle_type = self._tab_type,
					team_data = var_2_33
				})

				return
			end
		end

		local var_2_34 = var_2_5 and var_2_5:get_is_fast_formation() or nil
		local var_2_35 = var_0_1:getInstance("fight_prepare")

		if var_2_35 and var_2_5 then
			if var_2_34 then
				if var_2_5:get_index_in_team_data(self._data) then
					self:set_fast_team_num(var_2_34)
				end

				var_2_5:update_fast_team_index(self._data, var_0_2.max_select_type.six, true)

				return
			end

			local var_2_36
			local var_2_37 = false
			local var_2_39 = false
			local var_2_41 = false
			local var_2_43 = false
			local var_2_45 = false
			local var_2_46 = false

			if self._is_nf then
				var_2_45 = true
			end

			if self._enter_type == var_0_2.enter_select_member_type.six_year_map_select and not var_2_45 then
				var_2_36 = var_0_3:get_sixth_combat_info().members or {}
				var_2_37 = true
			elseif self._enter_type == var_0_2.enter_select_member_type.strike_map_select then
				var_2_36 = var_0_3:get_strike_team_data() or {}
				var_2_39 = true
			elseif self._enter_type == var_0_2.enter_select_member_type.war_concerto_play then
				var_2_36 = var_0_3:get_fifth_team_data().members or {}
				var_2_41 = true
			elseif self._enter_type == var_0_2.enter_select_member_type.ocean_attack_map_select then
				var_2_36 = var_0_3:get_ocean_team_data().members or {}
				var_2_43 = true
			elseif self._enter_type == var_0_2.enter_select_member_type.abyss_dock_team_formation then
				var_2_36 = var_0_3:get_normal_team_info() or {}
				var_2_46 = true
			else
				var_2_36 = var_0_3:get_character_list()
			end

			local var_2_48 = true
			local var_2_49 = var_2_35:get_current_team_index()
			local var_2_50 = var_2_49 <= 4 and 1 or 2
			local var_2_51

			if self._data then
				var_2_51 = var_0_7.find_object_by_cid(self._data.cid)
			end

			if var_2_37 then
				for iter_2_12, iter_2_13 in pairs(var_2_36) do
					local var_2_52 = var_0_3:find_character_by_id(iter_2_13).cid

					if (self._data and self._data.cid == var_2_52 or var_2_51 and var_0_7.find_object_by_cid(var_2_52).evo_cid == var_2_51.evo_cid) and self._data.id ~= iter_2_13 then
						var_2_48 = false
					end
				end
			elseif var_2_39 then
				for iter_2_14, iter_2_15 in pairs(var_2_36) do
					local var_2_53 = var_0_3:find_character_by_id(iter_2_15).cid

					if (self._data and self._data.cid == var_2_53 or var_2_51 and var_0_7.find_object_by_cid(var_2_53).evo_cid == var_2_51.evo_cid) and self._data.id ~= iter_2_15 then
						var_2_48 = false
					end
				end
			elseif var_2_41 then
				for iter_2_16, iter_2_17 in pairs(var_2_36) do
					if iter_2_17 and iter_2_17 == self._data.cid then
						var_2_48 = false
					end
				end
			elseif var_2_43 then
				for iter_2_18, iter_2_19 in pairs(var_2_36) do
					local var_2_54 = var_0_3:find_character_by_id(iter_2_19).cid

					if (self._data and self._data.cid == var_2_54 or var_2_51 and var_0_7.find_object_by_cid(var_2_54).evo_cid == var_2_51.evo_cid) and self._data.id ~= iter_2_19 then
						var_2_48 = false
					end
				end
			elseif var_2_46 then
				for iter_2_20, iter_2_21 in pairs(var_2_36) do
					local var_2_55 = var_0_3:find_character_by_id(iter_2_21).cid

					if (self._data and self._data.cid == var_2_55 or var_2_51 and var_0_7.find_object_by_cid(var_2_55).evo_cid == var_2_51.evo_cid) and self._data.id ~= iter_2_21 then
						var_2_48 = false
					end
				end
			else
				for iter_2_22, iter_2_23 in pairs(var_2_36) do
					local var_2_56 = var_0_3:get_team_data(var_2_50, var_2_49)

					if var_2_56 and var_2_56.members then
						for iter_2_24, iter_2_25 in pairs(var_2_56.members) do
							local var_2_57 = var_0_3:find_character_by_id(iter_2_25).cid

							if (self._data and self._data.cid == var_2_57 or var_2_51 and var_0_7.find_object_by_cid(var_2_57).evo_cid == var_2_51.evo_cid) and self._data.id ~= iter_2_25 then
								var_2_48 = false
							end
						end
					end
				end
			end

			local var_2_58 = var_2_5:get_index()

			if not var_2_48 then
				if self._enter_type == var_0_2.enter_select_member_type.abyss_dock_team_formation or self._enter_type == var_0_2.enter_select_member_type.strike_map_select then
					if var_2_36[var_2_58] then
						local var_2_60 = var_0_3:find_character_by_id(var_2_36[var_2_58]).cid

						if self._data and self._data.cid == var_2_60 or var_2_51 and var_0_7.find_object_by_cid(var_2_60).evo_cid == var_2_51.evo_cid then
							var_2_48 = true
						end
					end
				else
					local var_2_61 = var_0_3:get_team_data(var_2_50, var_2_49)

					if var_2_61.members and var_2_61.members[var_2_58] then
						local var_2_62 = var_0_3:find_character_by_id(var_2_61.members[var_2_58]).cid

						if self._data and self._data.cid == var_2_62 or var_2_51 and var_0_7.find_object_by_cid(var_2_62).evo_cid == var_2_51.evo_cid then
							var_2_48 = true
						end
					end
				end
			end

			if not var_2_48 and not self._campaign then
				var_0_4:show(var_0_5:getNowLang("nosameshipinteam"))
				var_2_5:setVisible(false)
				var_2_5:after_close_select_member(true)

				return
			end

			if self._campaign then
				var_2_35:save_campaign_teamdata(var_2_58, self._data)
			elseif var_2_37 then
				var_2_35:save_sixth_single_info(var_2_58, self._data)
			elseif var_2_45 then
				var_2_35:save_mist_single_info(var_2_58, self._data)
			elseif var_2_39 then
				var_2_35:save_strike_team_info(var_2_58, self._data)
			elseif var_2_41 then
				var_2_35:save_war_concerto_team_info(var_2_58, self._data)
			elseif var_2_43 then
				var_2_35:save_ocean_team_info(var_2_58, self._data)
			elseif var_2_46 then
				var_2_35:save_abyss_model_single_info(var_2_58, self._data)
			else
				var_2_35:save_team_single_info(var_2_58, self._data)
			end

			if self._enter_type == var_0_2.enter_select_member_type.dock_team or self._enter_type == var_0_2.enter_select_member_type.fight or self._enter_type == var_0_2.enter_select_member_type.dock_team_empty or self._enter_type == var_0_2.enter_select_member_type.tower then
				var_2_5:after_close_select_member(true)
			else
				var_2_5:after_close_select_member()
			end

			if self._enter_type == var_0_2.enter_select_member_type.fight or self._enter_type == var_0_2.enter_select_member_type.six_year_primary or self._enter_type == var_0_2.enter_select_member_type.six_year_map_select or self._enter_type == var_0_2.enter_select_member_type.strike_map_select or self._enter_type == var_0_2.enter_select_member_type.tower or self._enter_type == var_0_2.enter_select_member_type.war_concerto_play or self._enter_type == var_0_2.enter_select_member_type.ocean_attack_map_select or self._enter_type == var_0_2.enter_select_member_type.abyss_dock_team_formation then
				var_2_5:setVisible(false)
			else
				var_0_1:destroyInstance("select_member")
			end
		end

		if self._enter_type == var_0_2.enter_select_member_type.six_year_primary then
			if var_2_5:get_index_in_team_data(self._data) then
				self:set_fast_team_num(true)
			end

			var_2_5._is_choiced_num = 0

			var_2_5:update_fast_team_index(self._data, nil, true)

			return
		end

		if self._enter_type == var_0_2.enter_select_member_type.tactics_type then
			var_0_1:getInstance("tactics_select_member"):show_static_study_panel(self._data)
		end
	end

	function arg_1_0:__onLongClick_BG()
		if not self._data or not next(self._data) or self._is_nf then
			return
		end

		if (self._data and var_0_9.little_clone(self._data) or {}).is_exist then
			return
		end

		local var_5_0 = var_0_1:getInstance("select_member")

		if var_5_0 and self._tab_type ~= var_0_2.dock_team_toggle_type.active_station_fleet then
			var_5_0:setVisible(false)
		end

		local var_5_1 = var_0_1:getInstance("captainroom_fleet")

		if var_5_1 and self._tab_type ~= var_0_2.dock_team_toggle_type.active_station_fleet then
			var_5_1:setVisible(false)
		end

		local var_5_2 = var_0_1:getInstance("captainroom")

		if var_5_2 then
			var_5_2:setVisible(false)
		end

		local var_5_3 = var_0_1:getInstance("show_room")

		if var_5_3 then
			var_5_3:setVisible(false)
		end

		local var_5_4 = var_0_1:getInstance("captainroom_friend_fleet")

		if var_5_4 then
			var_5_4:setVisible(false)
		end

		local var_5_5 = var_0_3:get_custom_ship_list()

		if var_5_5 and next(var_5_5) then
			var_0_3:set_common_ship_deatil_num(#var_5_5)
		else
			var_0_3:set_common_ship_deatil_num(0)
		end

		if self._enter_type == var_0_2.enter_select_member_type.abyss_dock_team_formation then
			var_0_3:set_enter_abyss_ship_detail_type(var_0_2.enter_ship_detail_type.abyss_dock_team)
			var_0_1:createInstance("ship_detail"):show(var_0_2.enter_ship_detail_type.single_ship, self._data, nil, self)

			return
		end

		local var_5_6 = var_0_1:createInstance("ship_detail")

		if self._tab_type == var_0_2.dock_team_toggle_type.captainroom_fleet then
			self._data = var_0_3:find_character_by_id(self._data.id)

			var_0_3:set_enter_ship_detail_type(var_0_2.enter_ship_detail_type.captainroom_fleet)
		elseif self._tab_type == var_0_2.dock_team_toggle_type.supply and self:__get_dock_toggle_index() ~= 5 then
			var_0_3:set_enter_ship_detail_type(var_0_2.enter_ship_detail_type.dock_team)
		elseif self._enter_friend_captainroom_fleet_type == var_0_2.fight_type.show_room_friend then
			var_0_3:set_enter_ship_detail_type(var_0_2.enter_ship_detail_type.show_room)
		elseif self._enter_friend_captainroom_fleet_type == var_0_2.fight_type.captainroom_friend then
			var_0_3:set_enter_ship_detail_type(var_0_2.enter_ship_detail_type.captainroom_friend_fleet)
		elseif self._enter_type == var_0_2.enter_select_member_type.six_year_primary then
			var_0_3:set_enter_ship_detail_type(var_0_2.enter_ship_detail_type.sixth_select)
			var_5_6:show(var_0_2.enter_ship_detail_type.single_ship, self._data)

			return
		elseif self._enter_type == var_0_2.enter_select_member_type.six_year_map_select then
			var_0_3:set_enter_ship_detail_type(var_0_2.enter_ship_detail_type.sixth_select)
			var_5_6:show(var_0_2.enter_ship_detail_type.sixth_select, self._data)

			return
		elseif self._enter_type == var_0_2.enter_select_member_type.strike_map_select then
			var_0_3:set_enter_ship_detail_type(var_0_2.enter_ship_detail_type.strike_fight_select)
		elseif self._enter_type == var_0_2.enter_select_member_type.dock_team then
			local var_5_7 = self:__get_dock_toggle_index()

			if var_5_7 and var_5_7 == 5 then
				self._data.members = {}

				var_5_6:show(var_0_2.enter_ship_detail_type.dock, self._data)

				return
			else
				var_5_6:show(var_0_2.enter_ship_detail_type.single_ship, self._data, nil, self)
			end
		elseif self._enter_type == var_0_2.enter_select_member_type.dormitory then
			var_0_3:set_enter_ship_detail_type(var_0_2.enter_ship_detail_type.dormitory_ship)
		elseif self._enter_type == var_0_2.enter_select_member_type.war_concerto_play then
			var_0_3:set_enter_ship_detail_type(var_0_2.enter_ship_detail_type.war_concerto_play)
			var_5_6:show(var_0_2.enter_ship_detail_type.war_concerto_play, self._data)

			return
		elseif self._enter_type == var_0_2.enter_select_member_type.tactics_type then
			var_5_6:show(var_0_2.enter_ship_detail_type.single_ship, self._data, nil, nil, nil, nil, true)

			return
		end

		if self._tab_type == var_0_2.dock_team_toggle_type.captainroom_friend_fleet then
			local var_5_11
			local var_5_12 = 1
			local var_5_13 = var_0_1:getInstance("captainroom_friend_fleet")
			local var_5_14 = var_0_1:getInstance("captainroom")

			if var_5_13 then
				var_5_11 = var_5_13._friend_data
			end

			if var_5_14 then
				var_5_11 = var_5_14._friend_data
			end

			if var_5_11 and next(var_5_11) then
				for iter_5_0, iter_5_1 in ipairs(var_5_11.mansion.garrison) do
					if iter_5_1.cid == self._data.cid then
						var_5_12 = iter_5_0
					end
				end
			end

			local var_5_15 = lx.clone_table(self._data)
			local var_5_16 = lx.clone_table(var_0_7.find_object_by_cid(var_5_15.cid))

			var_5_15.lock = false
			var_5_15.name = var_5_16.title
			var_5_15.star = var_5_16.star
			var_5_15.hp = var_5_16.hp
			var_5_15.equipment_num = var_5_16.equipment_num
			var_5_15.exercise_info = self._all_exercise_info
			var_5_15.index = var_5_12

			if var_5_11 and next(var_5_11) then
				var_5_15.exercise_info = var_5_11.mansion.garrison
			end

			var_5_6:show(var_0_2.enter_ship_detail_type.single_ship, var_5_15)

			return
		end

		var_5_6:show(var_0_2.enter_ship_detail_type.single_ship, self._data, nil, self)

		local var_5_17 = var_0_1:getInstance("select_member")

		if var_5_17 then
			var_5_17:setVisible(false)
		end
	end

	function arg_1_0:__onClick_BG_all_layer()
		self:__onClick_BG()
	end

	function arg_1_0.__get_dock_toggle_index(arg_7_0)
		local var_7_0 = var_0_1:getInstance("dock_team")

		return (var_7_0 or nil) and var_7_0:get_current_team_index() or 0
	end
end

function var_0_0.extend_obj(arg_8_0)
	return
end

return var_0_0
