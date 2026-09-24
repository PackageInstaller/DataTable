local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.user
local var_0_4 = gameconfig.shop_config
local var_0_5 = gameconfig.support_config
local var_0_6 = gameconfig.ship_config
local var_0_7 = gamecore.util_func
local var_0_8 = gamecore.Language
local var_0_9 = gamecore.prompt
local var_0_10 = gameconfig.strike_buff_config
local var_0_11 = gameconfig.map_campaign_config
local var_0_12 = DG.Tweening.DOTween
local var_0_13 = gameconfig.ship_rule_config
local var_0_14 = gameconfig.tower_buff_config
local var_0_15 = gameconfig.strike_weather_config
local var_0_16 = table.remove
local var_0_17 = next

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onScaleButtonClick_top_widget_return_btn()
		if self._no_clicking then
			return
		end

		if self._fight_prepare_type == var_0_2.fight_type.strike then
			local var_2_0 = var_0_1:getInstance("strike_map")

			if var_2_0 then
				var_2_0:setVisible(true)
				var_2_0:destroyChildren("strike_buff_obj")
				var_2_0:__init_buff_pos()

				var_2_0._control.main.top.return_btn.button.enabled = true

				var_0_1:destroyInstance("strike_main")

				local var_2_1 = var_0_3:get_strike_point_info()

				if var_2_1 and var_0_17(var_2_1) and var_2_1.buffs and var_0_17(var_2_1.buffs) then
					for iter_2_0, iter_2_1 in pairs(var_2_1.buffs) do
						if iter_2_1.point_id == var_2_1.next_point_id then
							var_0_16(var_2_1.buffs, iter_2_0)
						end
					end
				end
			else
				var_0_1:createInstance("strike_main"):strike_set_active(true)
				var_0_1:createInstance("strike_weather"):show()
			end
		end

		local var_2_2 = var_0_1:getInstance("select_member")

		if var_2_2 then
			var_2_2._limit_type = nil
		end

		if self._fight_prepare_type == var_0_2.fight_type.tower_fight then
			var_0_1:getInstance("climb_tower"):set_layer_from_fight_prepare()
		end

		if self._fight_prepare_type == var_0_2.fight_type.abyss_model_first_phase then
			if self._abyss_prepare_point then
				var_0_1:createInstance("msgbox"):show(var_0_8:getNowLang("leaveconfirmdetail"), function()
					var_0_3:req_AbyssQuitMapReq()
					self:__destroy_panel()
				end, nil, (var_0_8:getNowLang("leaveconfirm")))

				return
			else
				self:__play_out_animation()
			end
		elseif self._fight_prepare_type == var_0_2.fight_type.score_attack then
			local var_2_3 = var_0_1:getInstance("score_push_map")

			if var_2_3 then
				self:setVisible(false)
				var_2_3:setVisible(true)
			else
				self:setVisible(false)
				var_0_1:createInstance("score_push_map"):show()
			end

			if var_0_1:getInstance("fight_prepare") then
				var_0_1:destroyInstance("fight_prepare")
			end
		elseif self._fight_prepare_type == var_0_2.fight_type.ninth_attack then
			if var_0_1:getInstance("fight_prepare") then
				var_0_1:destroyInstance("fight_prepare")
			end

			local var_2_4 = var_0_1:getInstance("ninth_main_map")

			if var_2_4 then
				self:setVisible(false)
				var_2_4:setVisible(true)
			else
				self:setVisible(false)
				var_0_1:createInstance("ninth_main_map"):show()
			end
		else
			local var_2_5 = var_0_1:getInstance("enemy_ship_detail")

			if var_2_5 then
				self:setVisible(false)
				var_0_1:getInstance("gotofight"):setVisible(true)
				var_2_5:setVisible(true)
			else
				self:__play_out_animation()
			end
		end
	end

	function arg_1_0:__onToggle_left_widget_team_toggle_toggle1()
		if self._no_clicking then
			return
		end

		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_goto))
		self:toggle_team(1 + 4 * (self._team_type - 1))
		self:__play_animation(self._control.right_widget.bg_back.speed_skeleton_mask.speed_skeleton, "meter_deep_sea_version", false)
	end

	function arg_1_0:__onToggle_left_widget_team_toggle_toggle2()
		if self._no_clicking then
			return
		end

		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_goto))
		self:toggle_team(2 + 4 * (self._team_type - 1))
		self:__play_animation(self._control.right_widget.bg_back.speed_skeleton_mask.speed_skeleton, "meter_deep_sea_version", false)
	end

	function arg_1_0:__onToggle_left_widget_team_toggle_toggle3()
		if self._no_clicking then
			return
		end

		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_goto))
		self:toggle_team(3 + 4 * (self._team_type - 1))
		self:__play_animation(self._control.right_widget.bg_back.speed_skeleton_mask.speed_skeleton, "meter_deep_sea_version", false)
	end

	function arg_1_0:__onToggle_left_widget_team_toggle_toggle4()
		if self._no_clicking then
			return
		end

		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_goto))
		self:toggle_team(4 + 4 * (self._team_type - 1))
		self:__play_animation(self._control.right_widget.bg_back.speed_skeleton_mask.speed_skeleton, "meter_deep_sea_version", false)
	end

	function arg_1_0:__onToggle_left_widget_func_toggle_toggle1()
		if self._no_clicking then
			return
		end

		if self._fight_prepare_type == var_0_2.fight_type.gotofight then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.props)
		elseif self._fight_prepare_type == var_0_2.fight_type.exercise or self._fight_prepare_type == var_0_2.fight_type.show_room_friend or self._fight_prepare_type == var_0_2.fight_type.tower_rank_list then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.props)
		elseif self._fight_prepare_type == var_0_2.fight_type.farfight then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.condition)
		elseif self._fight_prepare_type == var_0_2.fight_type.campaign then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.props)
		elseif self._fight_prepare_type == var_0_2.fight_type.sixth_fight then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.sixth)
		elseif self._fight_prepare_type == var_0_2.fight_type.tower_fight then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.tower)
		elseif self._fight_prepare_type == var_0_2.fight_type.strike then
			self._control.right_widget.bg_back.strike_info.toggle_info.toggle.isOn = false
			self._control.right_widget.bg_back.strike_info.toggle_buff.toggle.isOn = true

			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.strike)
		elseif self._fight_prepare_type == var_0_2.fight_type.fearlessness_sea then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.props)
		elseif self._fight_prepare_type == var_0_2.fight_type.ocean_attack then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.ocean_attack)
		elseif self._fight_prepare_type == var_0_2.fight_type.war_concerto then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.props)
		elseif self._fight_prepare_type == var_0_2.fight_type.abyss_model_first_phase then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.abyss_model)
		elseif self._fight_prepare_type == var_0_2.fight_type.seventh then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.props)
		elseif self._fight_prepare_type == var_0_2.fight_type.score_attack then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.props)
		elseif self._fight_prepare_type == var_0_2.fight_type.eighth_attack then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.props)
		elseif self._fight_prepare_type == var_0_2.fight_type.ninth_attack then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.ninth_preview)
		end
	end

	function arg_1_0:__onToggle_left_widget_func_toggle_toggle2()
		if self._no_clicking then
			return
		end

		self:__set_total_supply_panel_data()

		self._is_onclick_quick_supply = true
		self._is_onclick_quick_repair = false

		self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.supply)
	end

	function arg_1_0:__onToggle_left_widget_func_toggle_toggle3()
		if self._no_clicking then
			return
		end

		self:__set_total_repair_panel_data()

		self._is_onclick_quick_repair = true
		self._is_onclick_quick_supply = false

		self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.repair)
	end

	function arg_1_0:__onClick_right_widget_bg_back_supply_panel_supply_all_btn()
		if self._no_clicking then
			return
		end

		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_goto))
		self:__set_total_supply_panel_data()

		local var_11_0 = self._total_oil_need + self._total_bullet_need + self._total_aluminium_need

		if self._fight_prepare_type == var_0_2.fight_type.exercise or self._fight_prepare_type == var_0_2.fight_type.show_room_friend or self._fight_prepare_type == var_0_2.fight_type.tower_rank_list then
			self._is_supply_all_btn = true
		end

		if self._fight_prepare_type == var_0_2.fight_type.campaign or self._fight_prepare_type == var_0_2.fight_type.sixth_fight or self._fight_prepare_type == var_0_2.fight_type.ocean_attack or self._fight_prepare_type == var_0_2.fight_type.strike or self._fight_prepare_type == var_0_2.fight_type.abyss_model_first_phase then
			if self._fight_prepare_type == var_0_2.fight_type.sixth_fight then
				if not var_0_17(self._sixth_team_data) then
					var_0_9:show(var_0_8:getNowLang("errorcode_096"))

					return
				end
			elseif self._fight_prepare_type == var_0_2.fight_type.strike then
				if not var_0_17(self._strike_team_data) then
					var_0_9:show(var_0_8:getNowLang("errorcode_096"))

					return
				end
			elseif self._fight_prepare_type == var_0_2.fight_type.ocean_attack then
				if not var_0_17(self._ocean_team_data) then
					var_0_9:show(var_0_8:getNowLang("errorcode_096"))

					return
				end
			elseif self._fight_prepare_type == var_0_2.fight_type.campaign then
				local var_11_1 = false

				for iter_11_0, iter_11_1 in pairs(self._campagion_team_data) do
					if iter_11_1 ~= 0 then
						var_11_1 = true
					end
				end

				if var_11_1 == false then
					var_0_9:show(var_0_8:getNowLang("errorcode_096"))

					return
				end
			elseif self._fight_prepare_type == var_0_2.fight_type.abyss_model_first_phase then
				self._abyss_team_data = var_0_3:get_normal_team_info() or {}

				if not var_0_17(self._abyss_team_data) then
					var_0_9:show(var_0_8:getNowLang("errorcode_096"))

					return
				end
			end

			if var_11_0 == 0 then
				var_0_9:show(var_0_8:getNowLang("fleetsupplyisfullnotice"))

				return
			else
				self:ship_supply()
			end
		else
			if (self._fight_prepare_type == var_0_2.fight_type.gotofight or self._fight_prepare_type == var_0_2.fight_type.farfight) and not var_0_17(self._team_data) then
				var_0_9:show(var_0_8:getNowLang("errorcode_096"))

				return
			end

			if var_11_0 == 0 then
				var_0_9:show(var_0_8:getNowLang("fleetsupplyisfullnotice"))

				return
			else
				self:team_supply()
			end
		end
	end

	function arg_1_0:__onClick_right_widget_bg_back_repair_panel_repair_all_btn()
		if self._no_clicking then
			return
		end

		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_goto))
		self:__set_total_repair_panel_data()

		if self._fight_prepare_type == var_0_2.fight_type.abyss_model_first_phase then
			self:campaign_team_repair()

			return
		end

		if self._fight_prepare_type == var_0_2.fight_type.campaign or self._fight_prepare_type == var_0_2.fight_type.sixth_fight or self._fight_prepare_type == var_0_2.fight_type.ocean_attack or self._fight_prepare_type == var_0_2.fight_type.strike then
			if self._fight_prepare_type == var_0_2.fight_type.sixth_fight then
				if not var_0_17(self._sixth_team_data) then
					var_0_9:show(var_0_8:getNowLang("errorcode_096"))

					return
				end
			elseif self._fight_prepare_type == var_0_2.fight_type.strike then
				if not var_0_17(self._strike_team_data) then
					var_0_9:show(var_0_8:getNowLang("errorcode_096"))

					return
				end
			elseif self._fight_prepare_type == var_0_2.fight_type.ocean_attack then
				if not var_0_17(self._ocean_team_data) then
					var_0_9:show(var_0_8:getNowLang("errorcode_096"))

					return
				end
			elseif self._fight_prepare_type == var_0_2.fight_type.campaign then
				local var_12_0 = false

				for iter_12_0, iter_12_1 in pairs(self._campagion_team_data) do
					if iter_12_1 ~= 0 then
						var_12_0 = true
					end
				end

				if var_12_0 == false then
					var_0_9:show(var_0_8:getNowLang("errorcode_096"))

					return
				end

				var_0_3:set_campaign_team_info(self._team_detail_data)
			end

			self:campaign_team_repair()
		else
			if self._fight_prepare_type == var_0_2.fight_type.gotofight and not var_0_17(self._team_data) then
				var_0_9:show(var_0_8:getNowLang("errorcode_096"))

				return
			end

			self:team_repair()
		end
	end

	function arg_1_0:__onScaleButtonClick_right_widget_damage_group_bg_add_btn()
		if self._no_clicking then
			return
		end

		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_goto))

		local var_13_0 = var_0_4.find_object_by_id(var_0_2.shop_damage_control_cid)

		var_0_1:createInstance("shop_bounced"):show({
			price = var_13_0.price,
			title = var_13_0.title,
			id = var_0_2.shop_damage_control_cid
		}, var_0_2.buy_enter_type.fight_prepare)
	end

	function arg_1_0:__onClick_bottom_widget_start_fight_btn()
		if self._is_nf then
			var_0_1:createInstance("nf_map_node"):goto_mist_scene()

			return
		end

		if self._no_clicking then
			return
		end

		if self.isGray then
			var_0_9:show(var_0_8:getNowLang("active_outtime_tip"))

			return
		end

		if self:has_repair_or_expedition_or_station() then
			return
		end

		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.begin_to_fight))

		if self._start_fight_time > 0 then
			self:__prevent_frequently_click()

			return
		else
			self._start_fight_time = 5
		end

		if self._fight_prepare_type == var_0_2.fight_type.eighth_attack then
			var_0_3:clear_open_eighth_panel(nil)
			var_0_3:set_eight_monster_hurt_id(nil)
		elseif self._fight_prepare_type == var_0_2.fight_type.fearlessness_sea then
			var_0_3:set_open_fearless_sea_panel(false, nil)
		end

		self._control.cover:SetActive(true)

		local var_14_0 = self:autoKillDOTween(var_0_12.Sequence())

		var_0_1:createInstance("loading"):show(true)
		self:__play_rotation_animation()
		var_14_0:AppendCallback(function()
			local var_16_0 = var_0_1:getInstance("loading")

			if var_16_0 then
				var_16_0:show(false)
			end

			if self._fight_prepare_type == var_0_2.fight_type.sixth_fight then
				local var_16_1 = var_0_3:get_sixth_combat_info()

				var_0_3:set_back_type(var_0_2.select_back_type.sixth_fight)

				if var_16_1.members and var_0_17(var_16_1.members) then
					for iter_16_0, iter_16_1 in pairs(var_16_1.members) do
						local var_16_2 = var_0_3:find_character_by_id(iter_16_1)
						local var_16_3 = var_16_2 and var_0_7.little_clone(var_16_2) or {}

						var_16_3.hp = var_0_7:get_ship_attr(var_16_3, (var_0_6.find_object_by_cid(var_16_3.cid))).hp

						if var_16_3.now_hp / var_16_3.hp < var_0_2.health_sprite_rule.red.max_value and iter_16_0 == 1 then
							var_0_9:show(var_0_8:getNowLang("flagshipisbigbroken1"))

							return
						elseif var_16_3.now_hp / var_16_3.hp < var_0_2.health_sprite_rule.red.max_value then
							(var_0_1:getInstance("msgbox") or var_0_1:createInstance("msgbox")):show(var_0_8:getNowLang("sixth_broke_info"), function()
								if self._auto_supply then
									self:ship_supply()

									self._is_sixth_enter_point = true
								else
									var_0_3:req_SixthEnterPointReq()
								end
							end, nil, var_0_8:getNowLang("guardconfirm"))

							return
						end
					end

					if self._auto_supply then
						self:ship_supply()

						self._is_sixth_enter_point = true
					else
						var_0_3:req_SixthEnterPointReq()
					end
				else
					var_0_9:show(var_0_8:getNowLang("not_ship"))

					return
				end
			elseif self._fight_prepare_type == var_0_2.fight_type.strike then
				if var_0_3:get_return_type() then
					local var_16_4 = var_0_1:getInstance("strike_map")

					if var_16_4 then
						var_16_4:setVisible(true)
						var_0_1:destroyInstance("fight_prepare")
						var_16_4:__onClick_main_bottom_import_btn()
					end

					var_0_3:set_return_type(false)
				else
					local var_16_5 = var_0_3:get_strike_point_info()

					if self._strike_team_data and var_0_17(self._strike_team_data) and self._strike_team_data[1] then
						local var_16_6 = var_0_3:find_character_by_id(self._strike_team_data[1])
						local var_16_7

						if var_16_6.now_hp / var_0_7:get_ship_attr(var_16_6, (var_0_6.find_object_by_cid(var_16_6.cid))).hp < var_0_2.health_sprite_rule.red.max_value then
							var_0_9:show(var_0_8:getNowLang("flagshipisbigbroken1"))

							do return end

							var_16_7 = {}
						end
					end

					for iter_16_2, iter_16_3 in pairs((lx.clone_table(self._current_strike_buffs))) do
						if not iter_16_3.replace then
							table.insert(var_16_7, iter_16_3)
						end
					end

					self:__append_strike_weather_buff_to_list(var_16_7)

					self._attr_buff_list = {}
					self._attr_by_pre_effect_list = {}

					self:select_ship_attr_by_pre_effect(self._strike_team_data)

					for iter_16_4, iter_16_5 in pairs(var_16_7) do
						local var_16_8

						if iter_16_5.id < 1000 then
							var_16_8 = var_0_15.find_object_by_id(iter_16_5.id)

							if iter_16_5.state then
								var_16_8 = var_0_15.find_object_by_id(iter_16_5.change_id)
							end
						else
							var_16_8 = var_0_10.find_object_by_id(iter_16_5.id)

							if iter_16_5.state then
								var_16_8 = var_0_10.find_object_by_id(iter_16_5.change_id)
							end
						end

						for iter_16_6, iter_16_7 in pairs(var_16_8.effect) do
							self:select_ship_attrs_by_pvebuff(self._strike_team_data, iter_16_7, self._fight_prepare_type, true)
						end
					end

					for iter_16_8, iter_16_9 in pairs(var_16_7) do
						if not iter_16_9.replace then
							local var_16_9 = self:__get_strike_buff_data_by_buff_entry(iter_16_9)

							if var_16_9 and not self:__is_strike_buff_team_satisfy(var_16_9, (self:__get_strike_team_data_for_buff())) then
								var_0_9:show(var_0_8:getNowLang("ship_type_dissatisfy"))

								return
							end
						end
					end

					for iter_16_10, iter_16_11 in pairs(var_16_7) do
						if not iter_16_11.replace then
							local var_16_10 = self:__get_strike_buff_data_by_buff_entry(iter_16_11)

							if var_16_10 and var_16_10.effect then
								for iter_16_12, iter_16_13 in pairs(var_16_10.effect) do
									if iter_16_13.type == 38 then
										if not self:__check_strike_buff_type38_team_pass(self._strike_team_data) then
											var_0_9:show(var_0_8:getNowLang("ship_type_dissatisfy"))

											return
										end

										break
									end
								end
							end
						end
					end

					var_0_3:set_battle_type(var_0_2.battle_type.strike)

					local function var_16_11()
						if self._fight_prepare_type == var_0_2.fight_type.strike then
							var_0_3:set_strike_map_panel_buff()
						end

						if self._auto_supply then
							self:ship_supply()

							self._is_strike_enter_point = true
						else
							self:__enter_strike_map()
						end
					end

					if self._strike_team_data and var_0_17(self._strike_team_data) then
						for iter_16_14, iter_16_15 in pairs(self._strike_team_data) do
							local var_16_12 = var_0_3:find_character_by_id(iter_16_15)

							if var_16_12.now_hp / var_0_7:get_ship_attr(var_16_12, (var_0_6.find_object_by_cid(var_16_12.cid))).hp < var_0_2.health_sprite_rule.red.max_value then
								(var_0_1:getInstance("msgbox") or var_0_1:createInstance("msgbox")):show(var_0_8:getNowLang("sixth_broke_info"), var_16_11, nil, var_0_8:getNowLang("guardconfirm"))

								return
							end
						end
					else
						var_0_9:show(var_0_8:getNowLang("not_ship"))

						return
					end

					var_16_11()
				end
			elseif self._fight_prepare_type == var_0_2.fight_type.ocean_attack then
				if var_0_7.dict_lenght(var_0_3:get_character_list()) >= var_0_3:get_use_info_data().max_ship then
					var_0_1:createInstance("msgbox"):showthird(nil, function()
						var_0_1:destroyInstance("msgbox")

						local var_19_0 = var_0_1:getInstance("dock")

						if var_0_1:getInstance("fight_prepare") then
							var_0_1:destroyInstance("fight_prepare")
						end

						if var_19_0 then
							var_19_0:setVisible(true)
							var_19_0:__onToggle_top_layer_toggle_control_disassemble()
						else
							local var_19_1 = var_0_1:createInstance("dock")

							var_19_1:show(true, "disassemble")
							var_19_1:set_enter_type("home")
							var_19_1:_now__play_bgm()
							var_19_1:__select_one("disassemble", true)
						end
					end, function()
						var_0_1:destroyInstance("msgbox")

						local var_20_0 = var_0_1:getInstance("remake")

						if var_0_1:getInstance("fight_prepare") then
							var_0_1:destroyInstance("fight_prepare")
						end

						local var_20_1 = var_0_1:getInstance("home")

						if var_20_1 then
							var_20_1:_bgm_play()
						end

						if var_20_0 then
							var_20_0:setVisible(true)
						else
							local var_20_2 = var_0_1:createInstance("remake")

							var_20_2:set_enter_type("home")
							var_20_2:show(true)
						end
					end, function()
						var_0_1:destroyInstance("msgbox")

						local var_21_0 = var_0_1:getInstance("home")

						if var_21_0 then
							var_21_0:_bgm_play()
						end

						local var_21_1 = var_0_1:getInstance("mall_shop")

						if var_21_1 then
							var_21_1:setVisible(true)
							var_21_1:__onToggle_top_layer_top_btn_btnthree()
						else
							var_0_1:createInstance("mall_shop"):show(var_0_2.mall_layer_type.layer_func, var_0_2.mall_enter_type.enter_home)
						end
					end, "", var_0_2.msg_type.ship_full, nil, true)

					return
				end

				var_0_3:set_battle_type(var_0_2.battle_type.ocean)

				local var_16_13 = var_0_3:get_current_ocean_map_start_point()
				local var_16_14 = tonumber(string.sub(var_16_13, 1, 4))

				if self._ocean_team_data and var_0_17(self._ocean_team_data) then
					for iter_16_16, iter_16_17 in pairs(self._ocean_team_data) do
						local var_16_15 = var_0_3:find_character_by_id(iter_16_17)

						if var_16_15.now_hp / var_16_15.hp < var_0_2.health_sprite_rule.red.max_value then
							(var_0_1:getInstance("msgbox") or var_0_1:createInstance("msgbox")):show(var_0_8:getNowLang("sixth_broke_info"), function()
								if self._auto_supply then
									self:ship_supply()

									self._is_ocean_attack_enter_point = true
								else
									var_0_3:req_OceanEnterMapReq(var_16_14, var_16_13)
								end
							end, nil, var_0_8:getNowLang("guardconfirm"))

							return
						end
					end

					if self._auto_supply then
						self:ship_supply()

						self._is_ocean_attack_enter_point = true
					else
						var_0_3:req_OceanEnterMapReq(var_16_14, var_16_13)
					end
				else
					var_0_9:show(var_0_8:getNowLang("not_ship"))

					return
				end
			elseif self._fight_prepare_type == var_0_2.fight_type.war_concerto_play then
				local var_16_16 = var_0_3:get_fifth_team_data()

				if var_16_16 and var_0_17(var_16_16) then
					var_0_3:req_RecreationEnterMapReq(var_0_3:get_fifth_level_cfg().id)
				else
					var_0_9:show(var_0_8:getNowLang("not_ship"))

					return
				end
			elseif self._fight_prepare_type == var_0_2.fight_type.abyss_model_first_phase then
				local var_16_17 = var_0_3:get_normal_team_info()
				local var_16_18 = var_0_3:get_abyss_team_info()
				local var_16_19 = #var_16_17 == 0 or #var_16_18 == 0

				if not self._team_type then
					var_16_19 = #var_16_17 == 0 or #var_16_18 == 0
				end

				if not self._team_type or self._team_type == var_0_2.team_type.abyss_owner_team or self._team_type == var_0_2.team_type.abyss_team then
					for iter_16_18, iter_16_19 in pairs(var_16_17) do
						local var_16_20 = var_0_3:find_character_by_id(iter_16_19)

						if var_16_20 then
							self._click_times = 0

							if self._auto_supply and self:__check_resource_enough() == false then
								return
							end

							if var_16_20.now_hp / var_16_20.hp < var_0_2.health_sprite_rule.red.max_value and iter_16_18 == 1 then
								var_0_9:show(var_0_8:getNowLang("flagshipisbigbroken1"))

								return
							elseif var_16_20.now_hp / var_16_20.hp < var_0_2.health_sprite_rule.red.max_value then
								local function var_16_22()
									self:setVisible(false)
									var_0_1:createInstance("abyss_preview"):show(var_0_3:get_abyss_now_chapter_cfg(), var_0_2.abyss_const.abyss_enter_preview_type.select_team)
								end

								local var_16_23 = var_0_1:createInstance("msgbox")

								if self._auto_supply then
									self._is_abyss_enter_point = true
									self._supply_item_index = 1
									self._supply_item_list = {}

									for iter_16_20, iter_16_21 in pairs(self._ship_item_list) do
										local var_16_24 = iter_16_21:get_data()

										if var_16_24 then
											table.insert(self._supply_item_list, var_16_24.id)
										end
									end

									var_0_3:req_ShipSupply({
										id_array = var_0_3:get_normal_team_info()
									})
									self:__set_total_supply_panel_data()
									self:__set_total_repair_panel_data()
								end

								local var_16_25 = var_0_3:get_abyss_prepare_to_fight_type()

								self:autoKillDOTween(var_0_12.Sequence()):AppendCallback(function()
									var_16_23:show(var_0_8:getNowLang("sixth_broke_info"), var_16_22, nil, var_0_8:getNowLang("guardconfirm"))
								end)

								return
							end

							if var_16_20.now_oil <= 0 and self._auto_supply ~= true then
								var_0_9:show(var_0_8:getNowLang("supply_not_enough"))

								return
							end
						end
					end
				end

				if not var_16_19 then
					if self._team_type == var_0_2.team_type.abyss_owner_team and self._auto_supply then
						if self:__check_resource_enough() then
							local var_16_26 = var_0_3:get_normal_team_info()

							if var_16_26 and var_0_17(var_16_26) then
								self._is_abyss_enter_point = true
								self._supply_item_index = 1
								self._supply_item_list = {}

								for iter_16_22, iter_16_23 in pairs(self._ship_item_list) do
									local var_16_27 = iter_16_23:get_data()

									if var_16_27 then
										table.insert(self._supply_item_list, var_16_27.id)
									end
								end

								var_0_3:req_ShipSupply({
									id_array = var_16_26
								})
								self:__set_total_supply_panel_data()
								self:__set_total_repair_panel_data()

								local var_16_28 = var_0_3:get_abyss_now_chapter_cfg()
								local var_16_29 = var_0_2.abyss_const.abyss_enter_preview_type.select_team
								local var_16_30 = var_0_1:createInstance("abyss_preview")
								local var_16_31 = self:autoKillDOTween(var_0_12.Sequence())

								var_16_31:AppendInterval(0.5)
								var_16_31:AppendCallback(function()
									self:setVisible(false)
									var_16_30:show(var_16_28, var_16_29)
								end)
							end
						end
					else
						local var_16_32 = var_0_1:createInstance("abyss_preview")

						if var_16_32 then
							self:setVisible(false)

							self._abyss_now_page = var_16_32:get_now_page()

							var_0_3:set_abyss_fight_team_detail(self._team_detail_data)

							if self._auto_supply then
								local var_16_33 = var_0_3:get_normal_team_info()

								if var_0_17(var_16_33) then
									var_0_3:req_ShipSupply({
										id_array = var_16_33
									})
								end
							end

							var_16_32:show(var_0_3:get_abyss_now_chapter_cfg(), var_0_2.abyss_const.abyss_enter_preview_type.select_team)
						end
					end
				else
					var_0_9:show(var_0_8:getNowLang("errorcode_096"))
				end
			elseif not self._campaign then
				if var_0_7.dict_lenght(var_0_3:get_character_list()) >= var_0_3:get_use_info_data().max_ship and self._fight_prepare_type ~= var_0_2.fight_type.farfight and self._fight_prepare_type ~= var_0_2.fight_type.exercise and self._fight_prepare_type ~= var_0_2.fight_type.show_room_friend and self._fight_prepare_type ~= var_0_2.fight_type.tower_rank_list and self._fight_prepare_type ~= var_0_2.fight_type.tower_fight then
					var_0_1:createInstance("msgbox"):showthird(nil, function()
						var_0_1:destroyInstance("msgbox")

						local var_26_0 = var_0_1:getInstance("dock")

						if var_0_1:getInstance("fight_prepare") then
							var_0_1:destroyInstance("fight_prepare")
						end

						if var_26_0 then
							var_26_0:setVisible(true)
							var_26_0:__onToggle_top_layer_toggle_control_disassemble()
						else
							local var_26_1 = var_0_1:createInstance("dock")

							var_26_1:show(true, "disassemble")
							var_26_1:set_enter_type("home")
							var_26_1:_now__play_bgm()
							var_26_1:__select_one("disassemble", true)
						end
					end, function()
						var_0_1:destroyInstance("msgbox")

						local var_27_0 = var_0_1:getInstance("remake")

						if var_0_1:getInstance("fight_prepare") then
							var_0_1:destroyInstance("fight_prepare")
						end

						local var_27_1 = var_0_1:getInstance("home")

						if var_27_1 then
							var_27_1:_bgm_play()
						end

						if var_27_0 then
							var_27_0:setVisible(true)
						else
							local var_27_2 = var_0_1:createInstance("remake")

							var_27_2:set_enter_type("home")
							var_27_2:show(true)
						end
					end, function()
						var_0_1:destroyInstance("msgbox")

						local var_28_0 = var_0_1:getInstance("home")

						if var_28_0 then
							var_28_0:_bgm_play()
						end

						local var_28_1 = var_0_1:getInstance("mall_shop")

						if var_28_1 then
							var_28_1:setVisible(true)
							var_28_1:__onToggle_top_layer_top_btn_btnthree()
						else
							var_0_1:createInstance("mall_shop"):show(var_0_2.mall_layer_type.layer_func, var_0_2.mall_enter_type.enter_home)
						end
					end, "", var_0_2.msg_type.ship_full, nil, true)

					return
				end

				local var_16_34 = self._team_group_data[self._current_team_index]

				if not self._team_group_data[self._current_team_index] then
					return
				end

				if not var_0_17(var_16_34.members) then
					var_0_9:show(var_0_8:getNowLang("not_ship"))

					return
				end

				if not self._auto_supply then
					for iter_16_24, iter_16_25 in pairs(var_16_34.members) do
						local var_16_35 = var_0_3:find_character_by_id(iter_16_25)

						if var_16_35.now_bullet == 0 or var_16_35.now_oil == 0 then
							var_0_9:show(var_0_8:getNowLang("supply_not_enough"))

							return
						end
					end
				end

				for iter_16_26, iter_16_27 in pairs(var_16_34.members) do
					local var_16_36 = var_0_3:find_character_by_id(iter_16_27)
					local var_16_37 = var_16_36.now_hp / var_0_7:get_ship_attr(var_16_36, (var_0_6.find_object_by_cid(var_16_36.cid))).hp

					if var_16_37 < var_0_2.health_sprite_rule.red.max_value and iter_16_26 == 1 then
						var_0_9:show(var_0_8:getNowLang("errorcode_251"))

						return
					elseif var_16_37 < var_0_2.health_sprite_rule.red.max_value and self._fight_prepare_type ~= var_0_2.fight_type.exercise and self._fight_prepare_type ~= var_0_2.fight_type.captainroom_friend and self._fight_prepare_type ~= var_0_2.fight_type.show_room_friend and self._fight_prepare_type ~= var_0_2.fight_type.farfight then
						var_0_1:createInstance("msgbox"):show(var_0_8:getNowLang("sixth_broke_info"), function()
							local var_29_0 = {
								id = self._go_to_map_id,
								team_id = var_16_34.id,
								start_point = self._init_node_id
							}

							if self._auto_supply then
								self:team_supply(true)
							elseif self._supply_type then
								if not self._support_supply_full then
									var_0_9:show(var_0_8:getNowLang("support_not_full"))

									return
								end
							elseif self._fight_prepare_type == var_0_2.fight_type.seventh then
								var_0_3:set_now_seven_map_id(self._seven_map_data.id)

								if not self.seventh_is_boss then
									if self._is_encounter then
										var_0_3:set_now_seven_map_fight_type(var_0_2.select_seventh_fight_type.encounter)
										var_0_3:req_SeventhEnterEliteReq(self._seven_map_data.id, self._seven_pos_num, self._current_team_index)

										return
									else
										var_0_3:set_now_seven_map_fight_type(var_0_2.select_seventh_fight_type.exploration)
										var_0_3:req_SeventhEnterChaseReq(self._seven_map_data.id, self._seven_pos_num, self._current_team_index)

										return
									end
								else
									var_0_3:set_now_seven_map_fight_type(var_0_2.select_seventh_fight_type.boss)
									var_0_3:req_SeventhEnterMapReq(self._seven_map_data.id, self._current_team_index)

									return
								end
							elseif self._fight_prepare_type == var_0_2.fight_type.score_attack then
								var_0_3:req_AnswerEnterMapReq(var_29_0)
							elseif self._fight_prepare_type == var_0_2.fight_type.fearlessness_sea then
								var_0_3:req_PushEnterMapReq(var_29_0)
							elseif self._fight_prepare_type == var_0_2.fight_type.eighth_attack then
								var_0_3:set_now_eighth_map_id(self._eighth_map_data.id)

								if self._eighth_is_boss then
									var_0_3:set_now_eighth_map_fight_type(var_0_2.select_eighth_fight_type.boss)
									var_0_3:req_EighthEnterMapReq(self._eighth_map_data.id, self._current_team_index)
								else
									var_0_3:set_now_eighth_map_fight_type(var_0_2.select_eighth_fight_type.encounter)
									var_0_3:req_EighthEnterEliteReq(self._eighth_map_data.id, self._eighth_pos_num, self._current_team_index)

									return
								end
							elseif self._fight_prepare_type == var_0_2.fight_type.ninth_attack then
								var_0_3:req_NinthEnterMapReq(var_29_0)
							else
								var_0_3:req_EnterMapReq(var_29_0)
							end
						end, nil, var_0_8:getNowLang("guardconfirm"))

						return
					elseif var_16_36.now_hp <= 0 then
						var_0_9:show(var_0_8:getNowLang("fight_cant_go"))

						return
					elseif self._fight_prepare_type == var_0_2.fight_type.farfight and (var_16_36.now_oil < var_16_36.oil or var_16_36.now_bullet < var_16_36.bullet) then
						if self._auto_supply then
							self._is_farfight_auto_supply = true

							self:team_supply(true)
						else
							var_0_9:show(var_0_8:getNowLang("shipsupplylack"))
						end

						return
					end

					if self._fight_prepare_type == var_0_2.fight_type.fearlessness_sea and self._go_to_map_id == 9527 and (var_16_36.type == 15 or var_16_36.type == 14) then
						var_0_9:show(var_0_8:getNowLang("errorcode_156"))

						return
					end

					if not self._auto_supply and (var_16_36.now_oil == 0 or var_16_36.now_bullet == 0) then
						var_0_9:show(var_0_8:getNowLang("supply_not_enough"))

						return
					end
				end

				if self._fight_prepare_type == var_0_2.fight_type.gotofight then
					if self._auto_supply then
						self:team_supply(true)
					else
						if self._supply_type and not self._support_supply_full then
							var_0_9:show(var_0_8:getNowLang("support_not_full"))

							return
						end

						var_0_3:req_EnterMapReq({
							id = self._go_to_map_id,
							team_id = var_16_34.id,
							start_point = self._init_node_id
						})
					end
				elseif self._fight_prepare_type == var_0_2.fight_type.farfight then
					if not self._farfight_condition.is_ok then
						var_0_9:show(self._farfight_condition.not_ok_info)

						return
					end

					local var_16_38 = {
						team_id = var_16_34.id,
						id = self._farfight_data.id
					}
					local var_16_39 = app:getSystem():getChannel()

					print("发送111")

					local var_16_40 = var_0_2:get_now_appversion_num()

					var_0_3:req_ExpeditionStartReq(var_16_38)
					log.print_r(var_16_39, "channel渠道名字")
					log.print_r(var_16_40, "version_num版本号数")

					if var_16_39 == "hm_android" and var_16_40 > var_0_2.version_init_num then
						NotifyManager.InitReceivedHandler()

						function NotifyManager.receivedCallback(arg_30_0)
							print("通知触发回调")
						end

						log.print_r(self._farfight_data.need_time, "需要时间111")
						print("发送11111")
						NotifyManager.CreateAndroidNotification("提督大人", string.format(var_0_8:getNowLang("expeditioncompleted"), var_16_34.id, self._farfight_data.title), self._farfight_data.need_time, true, "", "icon_1", "", var_16_34.id, var_16_39)
					end
				elseif self._fight_prepare_type == var_0_2.fight_type.exercise then
					self:__set_total_supply_panel_data()
					var_0_3:set_battle_type(var_0_2.battle_type.exercise)
					var_0_3:set_back_type(var_0_2.select_back_type.go_to_fight)

					if self._auto_supply then
						if not self:__just_supply() then
							var_0_3:req_EnterManeuverReq(self._exercise_id, var_16_34.id, false)
						end
					else
						var_0_3:req_EnterManeuverReq(self._exercise_id, var_16_34.id, false)
					end
				elseif self._fight_prepare_type == var_0_2.fight_type.captainroom_friend then
					self:__set_total_supply_panel_data()
					var_0_3:set_battle_type(var_0_2.battle_type.friend_exercise)
					var_0_3:set_back_type(var_0_2.select_back_type.captainroom)

					if self._auto_supply then
						if not self:__just_supply() then
							var_0_3:req_EnterManeuverReq(self._firend_account_id, var_16_34.id, true)
						end
					else
						var_0_3:req_EnterManeuverReq(self._firend_account_id, var_16_34.id, true)
					end
				elseif self._fight_prepare_type == var_0_2.fight_type.show_room_friend then
					self:__set_total_supply_panel_data()
					var_0_3:set_battle_type(var_0_2.battle_type.friend_exercise)
					var_0_3:set_back_type(var_0_2.select_back_type.show_room)

					if self._auto_supply then
						if not self:__just_supply() then
							var_0_3:req_EnterManeuverReq(self._firend_account_id, var_16_34.id, true)
						end
					else
						var_0_3:req_EnterManeuverReq(self._firend_account_id, var_16_34.id, true)
					end
				elseif self._fight_prepare_type == var_0_2.fight_type.tower_rank_list then
					self:__set_total_supply_panel_data()
					var_0_3:set_battle_type(var_0_2.battle_type.friend_exercise)
					var_0_3:set_back_type(var_0_2.select_back_type.tower_rank_list)

					if self._auto_supply then
						if not self:__just_supply() then
							var_0_3:req_EnterManeuverReq(self._firend_account_id, var_16_34.id, true)
						end
					else
						var_0_3:req_EnterManeuverReq(self._firend_account_id, var_16_34.id, true)
					end
				elseif self._fight_prepare_type == var_0_2.fight_type.tower_rank_friend_captainroom then
					self:__set_total_supply_panel_data()
					var_0_3:set_battle_type(var_0_2.battle_type.friend_exercise)
					var_0_3:set_back_type(var_0_2.select_back_type.tower_rank_friend_captainroom)

					if self._auto_supply then
						if not self:__just_supply() then
							var_0_3:req_EnterManeuverReq(self._firend_account_id, var_16_34.id, true)
						end
					else
						var_0_3:req_EnterManeuverReq(self._firend_account_id, var_16_34.id, true)
					end
				elseif self._fight_prepare_type == var_0_2.fight_type.fearlessness_sea then
					if self._auto_supply then
						self:team_supply(true)
					else
						if self._supply_type and not self._support_supply_full then
							var_0_9:show(var_0_8:getNowLang("support_not_full"))

							return
						end

						var_0_3:req_PushEnterMapReq({
							id = self._go_to_map_id,
							team_id = var_16_34.id,
							start_point = self._init_node_id
						})
					end

					var_0_3:set_back_type(var_0_2.select_back_type.fearlessness_sea)
				elseif self._fight_prepare_type == var_0_2.fight_type.tower_fight then
					for iter_16_28, iter_16_29 in pairs(self._now_layer_map_cfg.tower_buff) do
						for iter_16_30, iter_16_31 in pairs(var_0_14.find_object_by_id(iter_16_29).effect) do
							if not var_0_7.have_data(self._tower_cost_affected_buff_list, iter_16_31) and not self:select_ship_by_pvebuff(self._team_data, iter_16_31, self._fight_prepare_type) then
								var_0_9:show(var_0_8:getNowLang("ship_type_dissatisfy"))

								return
							end
						end
					end

					var_0_3:set_battle_type(var_0_2.battle_type.climb_tower)

					if self._tower_cost <= self._limit_tower then
						if self._auto_supply then
							self._climb_tower_team_id = var_16_34.id

							self:ship_supply()
							var_0_3:req_EnterTowerReq(self._climb_tower_team_id, self._tower_monster, self._now_layer)
						else
							var_0_3:req_EnterTowerReq(var_16_34.id, self._tower_monster, self._now_layer)
						end
					else
						var_0_9:show(var_0_8:getNowLang("ui_tower_cost_not_enough"))
					end
				elseif self._fight_prepare_type == var_0_2.fight_type.war_concerto then
					if self._auto_supply then
						self._is_war_concerto_enter = true

						self:ship_supply()
						var_0_3:set_battle_type(var_0_2.fight_type.war_concerto)
					else
						var_0_3:set_battle_type(var_0_2.fight_type.war_concerto)
						var_0_3:set_current_team(self:get_current_team_index())
						var_0_3:req_ConcertoEnterMapReq(var_0_3:get_fifth_level_cfg().id, self._team_group_data[self:get_current_team_index()].id)
					end
				elseif self._fight_prepare_type == var_0_2.fight_type.seventh then
					var_0_3:set_battle_type(var_0_2.fight_type.seventh)
					var_0_3:set_clear_map_reward(nil)

					if self._auto_supply then
						self:ship_supply()

						self._is_seventh_point = true
					else
						var_0_3:set_now_seven_map_id(self._seven_map_data.id)

						if not self.seventh_is_boss then
							if self._is_encounter then
								var_0_3:set_now_seven_map_fight_type(var_0_2.select_seventh_fight_type.encounter)
								var_0_3:req_SeventhEnterEliteReq(self._seven_map_data.id, self._seven_pos_num, self._current_team_index)
							else
								var_0_3:set_now_seven_map_fight_type(var_0_2.select_seventh_fight_type.exploration)
								var_0_3:req_SeventhEnterChaseReq(self._seven_map_data.id, self._seven_pos_num, self._current_team_index)
							end
						else
							var_0_3:set_now_seven_map_fight_type(var_0_2.select_seventh_fight_type.boss)
							var_0_3:req_SeventhEnterMapReq(self._seven_map_data.id, self._current_team_index)
						end
					end
				elseif self._fight_prepare_type == var_0_2.fight_type.score_attack then
					var_0_1:destroyInstance("score_push_map")
					var_0_3:set_back_type(var_0_2.fight_type.score_attack)
					var_0_3:set_come_in_score_panel_id(self._go_to_map_id)

					if self._auto_supply then
						self:team_supply(true)
					else
						if self._supply_type and not self._support_supply_full then
							var_0_9:show(var_0_8:getNowLang("support_not_full"))

							return
						end

						var_0_3:req_AnswerEnterMapReq({
							id = self._go_to_map_id,
							team_id = var_16_34.id,
							start_point = self._init_node_id
						})
					end
				elseif self._fight_prepare_type == var_0_2.fight_type.eighth_attack then
					var_0_3:set_battle_type(var_0_2.fight_type.eighth_attack)
					var_0_3:set_clear_map_reward(nil)

					if self._auto_supply then
						self:ship_supply()

						self._is_eighth_point = true
					else
						var_0_3:set_now_eighth_map_id(self._eighth_map_data.id)

						if self._eighth_is_boss then
							var_0_3:set_now_eighth_map_fight_type(var_0_2.select_eighth_fight_type.boss)
							var_0_3:req_EighthEnterMapReq(self._eighth_map_data.id, self._current_team_index)
						else
							var_0_3:set_now_eighth_map_fight_type(var_0_2.select_eighth_fight_type.encounter)
							var_0_3:req_EighthEnterEliteReq(self._eighth_map_data.id, self._eighth_pos_num, self._current_team_index)
						end
					end
				elseif self._fight_prepare_type == var_0_2.fight_type.ninth_attack then
					var_0_1:destroyInstance("ninth_main_map")

					if self._auto_supply then
						self:team_supply(true)
					else
						if self._supply_type and not self._support_supply_full then
							var_0_9:show(var_0_8:getNowLang("support_not_full"))

							return
						end

						var_0_3:req_NinthEnterMapReq({
							id = self._go_to_map_id,
							team_id = var_16_34.id,
							start_point = self._init_node_id
						})
					end
				end
			else
				local var_16_41 = var_0_3:get_campaign_members(self._go_to_map_id)
				local var_16_42 = {}
				local var_16_43 = {}

				for iter_16_32, iter_16_33 in pairs(self._campagion_team_data) do
					if iter_16_32 == 1 and iter_16_33 == 0 then
						var_0_9:show(var_0_8:getNowLang("pvecampaignshipnotfull"))

						return
					end

					if iter_16_33 ~= 0 then
						local var_16_44 = var_0_3:find_character_by_id(iter_16_33)

						table.insert(var_16_42, var_16_44 and var_0_7.little_clone(var_16_44) or {})
					end
				end

				for iter_16_34, iter_16_35 in pairs(var_16_42) do
					table.insert(var_16_43, (self:__refresh_attr(iter_16_35)))
				end

				for iter_16_36, iter_16_37 in pairs(var_16_43) do
					local var_16_45

					if not iter_16_37.now_hp then
						var_0_9:show(var_0_8:getNowLang("pvecampaignflagshipovermiddlebroken"))

						return
					else
						var_16_45 = iter_16_37.now_hp / iter_16_37.hp
					end

					if var_16_45 < var_0_2.health_sprite_rule.red.max_value and iter_16_36 == 1 then
						var_0_9:show(var_0_8:getNowLang("pvecampaignflagshipovermiddlebroken"))

						return
					end

					if var_16_45 < var_0_2.health_sprite_rule.red.max_value and iter_16_36 ~= 1 then
						var_0_9:show(var_0_8:getNowLang("pvecampaignhasdamageship"))

						return
					end

					if not self._auto_supply and (iter_16_37.now_oil == 0 or iter_16_37.now_bullet == 0) then
						var_0_9:show(var_0_8:getNowLang("supply_not_enough"))

						return
					end
				end

				if var_16_41 then
					for iter_16_38, iter_16_39 in pairs(var_16_41) do
						if var_0_3:is_character_station_state(iter_16_39) then
							var_0_9:show(var_0_8:getNowLang("pvecampaignhasguardship"))

							return
						end
					end
				else
					var_16_41 = {}

					for iter_16_40 = 1, 6 do
						table.insert(var_16_41, 0)
					end
				end

				local var_16_46 = 0
				local var_16_47 = var_0_11.find_object_by_id(self._go_to_map_id)

				for iter_16_41, iter_16_42 in pairs(var_16_47.fleet_rule) do
					if iter_16_42 > 0 then
						var_16_46 = var_16_46 + 1
					end

					if iter_16_42 > 0 and var_16_41[iter_16_41] > 0 and var_0_3:find_character_by_id(var_16_41[iter_16_41]).type ~= iter_16_42 then
						var_0_9:show(var_0_8:getNowLang("pvecampaignshipnotfull"))

						return
					end
				end

				local var_16_48 = 0

				for iter_16_43, iter_16_44 in pairs(var_16_41) do
					if var_16_47.difficulty == 1 then
						if iter_16_44 ~= 0 then
							var_16_48 = var_16_48 + 1
						else
							break
						end
					end
				end

				local var_16_49 = 0

				for iter_16_45, iter_16_46 in pairs(var_16_41) do
					if var_16_47.difficulty == 1 and iter_16_46 ~= 0 then
						var_16_49 = var_16_49 + 1
					end
				end

				if var_16_48 < var_16_49 then
					var_0_9:show(var_0_8:getNowLang("pvecampaignnoshiphole"))

					return
				end

				local var_16_50 = 0

				for iter_16_47, iter_16_48 in pairs(var_16_41) do
					if var_16_47.difficulty == 2 then
						if var_16_46 < iter_16_47 then
							break
						end

						if iter_16_48 == 0 then
							var_0_9:show(var_0_8:getNowLang("pvecampaignshipnotfull"))

							return
						else
							var_16_50 = var_16_50 + 1
						end
					elseif var_16_47.difficulty == 1 and iter_16_48 ~= 0 then
						var_16_50 = var_16_50 + 1
					end

					local var_16_51 = var_0_3:find_character_by_id(iter_16_48)

					if var_16_51 and var_0_17(var_16_51) then
						if var_16_51.state == var_0_2.ship_state.expedition then
							var_0_9:show(var_0_8:getNowLang("pvecampaignshipinexplore"))

							return
						elseif var_16_51.now_hp <= 0 then
							var_0_9:show(var_0_8:getNowLang("fight_cant_go"))

							return
						end
					end
				end

				if var_16_50 == 0 then
					var_0_9:show(var_0_8:getNowLang("pvecampaignshipnotfull"))

					return
				end

				if var_0_3:get_campaign_count() < self.__campaign_total_num() then
					var_0_3:set_battle_type(var_0_2.battle_type.campaign)

					if self._auto_supply and self:__need_supply() then
						self._is_campaign_enter = true

						self:ship_supply()

						return
					end

					var_0_3:req_EnterCampaignReq({
						id = self._go_to_map_id
					})
				else
					var_0_9:show(var_0_8:getNowLang("pvecampaignnotimesleft"))
				end
			end
		end)
		var_14_0:AppendInterval(0.5)
		var_14_0:AppendCallback(function()
			if self._control.cover and not self._control.cover:Equals(nil) then
				self._control.cover:SetActive(false)
			end
		end)

		self.__dw_seq = var_14_0
	end

	function arg_1_0.__refresh_attr(arg_31_0, arg_31_1)
		if arg_31_1 and arg_31_1.id then
			local var_31_0 = var_0_3:find_character_by_id(arg_31_1.id)

			arg_31_1.hp = var_0_7:get_ship_attr(var_31_0, (var_0_6.find_object_by_cid(var_31_0.cid))).hp
		end

		return arg_31_1
	end

	function arg_1_0.__campaign_total_num(arg_32_0)
		local var_32_0 = 8
		local var_32_1 = var_0_13.find_object_by_id(10)
		local var_32_2 = lx.ServerTime:getUtcTime()

		if var_32_1.content.startTime <= var_32_2 and var_32_2 < var_32_1.content.endTime then
			var_32_0 = var_0_13.find_object_by_id(10).content.campaignNum

			return var_32_0
		else
			return var_32_0
		end
	end

	function arg_1_0:__onClick_repair_btn()
		if self._no_clicking then
			return
		end

		var_0_1:destroyInstance("fight_prepare")

		local var_33_0 = {
			fight_prepare_type = self._fight_prepare_type,
			go_to_map_id = self._go_to_map_id
		}

		if self._fight_prepare_type == var_0_2.fight_type.seventh then
			var_33_0 = {
				fight_prepare_type = self._fight_prepare_type,
				go_to_map_id = self._go_to_map_id,
				map_data = self._seven_map_data,
				pos_num = self._seven_pos_num,
				is_encounter = self._is_encounter,
				is_boss = self.seventh_is_boss
			}
		elseif self._fight_prepare_type == var_0_2.fight_type.eighth_attack then
			var_33_0 = {
				fight_prepare_type = self._fight_prepare_type,
				go_to_map_id = self._go_to_map_id,
				map_data = self._eighth_map_data,
				elite_id = self._eighth_pos_num,
				is_encounter = self._is_encounter,
				is_boss = self._eighth_is_boss
			}
		elseif self._fight_prepare_type == var_0_2.fight_type.farfight then
			var_33_0.farfight_data = self._farfight_data
		elseif self._fight_prepare_type == var_0_2.fight_type.campaign then
			var_33_0.config_data = self._campagion_data
			var_33_0.difficulty = self._difficulty
			var_33_0.strike_is_deal = self.__strike_is_deal
			var_33_0.campaign = self._campaign
			var_33_0.hard_open = self._hard_open
		elseif self._fight_prepare_type == var_0_2.fight_type.exercise then
			var_33_0.exercise_id = self._exercise_id
		elseif self._fight_prepare_type == var_0_2.fight_type.captainroom_friend or self._fight_prepare_type == var_0_2.fight_type.show_room_friend or self._fight_prepare_type == var_0_2.fight_type.tower_rank_list or self._fight_prepare_type == var_0_2.fight_type.tower_rank_friend_captainroom then
			var_33_0.firend_account_id = self._firend_account_id
		elseif self._fight_prepare_type == var_0_2.fight_type.sixth_fight then
			var_33_0.sixth_map = self._sixth_map
			var_33_0.is_return_sixth_map_node = self._is_return_sixth_map_node
			var_33_0.bg_pos = self._six_map_node_bg
		end

		var_0_1:createInstance("bathroom"):show("fight_prepare", var_33_0)
	end

	function arg_1_0.__onClick_support_notify_btn(arg_34_0)
		return
	end

	function arg_1_0:__onClick_support_layer()
		if self._no_clicking then
			return
		end

		self._control.support_layer:SetActive(false)
	end

	function arg_1_0:__onClick_parent_support_icon_bg()
		if self._no_clicking then
			return
		end

		local var_36_0, var_36_1, var_36_2, var_36_3 = var_0_3:get_support_notify()

		self:__update_support_info(var_36_0, var_36_1, var_36_0 and var_0_5.find_object_by_id(var_36_0) or var_0_5.find_object_by_sequence_index(1), var_36_3)
	end

	function arg_1_0:__onScaleButtonClick_parent_collect_icon_bg()
		if self._no_clicking then
			return
		end

		self:__show_collection((var_0_3:get_player_desk_collection_data()))
	end

	function arg_1_0.__onClick_collect_btn(arg_38_0)
		return
	end

	function arg_1_0:__onClick_collect_layer()
		if self._no_clicking then
			return
		end

		self._control.collect_layer:SetActive(false)
	end

	function arg_1_0:__onClick_auto_supply_btn()
		if self._no_clicking then
			return
		end

		var_0_3:req_ActiveAutoSupplyReq()
		self:__onupdate_auto_toggle(not self._auto_supply)
	end

	function arg_1_0:__onClick_supply_type_btn()
		if self._no_clicking then
			return
		end

		self._supply_type = not self._supply_type

		var_0_3:req_ActiveShellingReq(self._go_to_map_id)
		self:__onupdate_type_toggle(self._supply_type)
	end

	function arg_1_0:__play_rotation_animation()
		if self._no_clicking then
			return
		end

		self._control.right_widget.bg_back.speed_skeleton_mask.speed_skeleton.skeletonGraphic.Skeleton:SetToSetupPose()
		self._control.right_widget.bg_back.speed_skeleton_mask.speed_skeleton.skeletonGraphic.AnimationState:ClearTracks()
		self:__play_animation(self._control.right_widget.bg_back.speed_skeleton_mask.speed_skeleton, "meter_deep_sea_version", false)
	end

	function arg_1_0:__onClick_right_widget_bg_back_supply_panel_map_support_support_button()
		if self._no_clicking then
			return
		end

		if not self._support_supply_full then
			if self._go_to_map_id then
				var_0_3:req_SupportSupplyReq(self._go_to_map_id)
			end
		else
			self._req_support_sup_time = self._req_support_sup_time or 0
			self._req_support_sup_time = self._req_support_sup_time + 1

			if self._req_support_sup_time > 5 then
				self._req_support_sup_time = 0
			end
		end
	end

	function arg_1_0:__onClick_parent_tower_icon_bg()
		if self._no_clicking then
			return
		end

		self:__update_tower_buff()
	end

	function arg_1_0:__onClick_tower_buff()
		if self._no_clicking then
			return
		end

		self._tower_buff_canvas_group.alpha = 0
		self._tower_buff_canvas_group.blocksRaycasts = false
	end

	function arg_1_0:__onClick_buff_btn()
		if self._no_clicking then
			return
		end

		self:setVisible(false)
		var_0_1:createInstance("analysis_room"):show_by_bype("fight_prepare")
	end

	function arg_1_0:__onToggle_right_widget_bg_back_tower_info_toggle_info()
		if self._no_clicking then
			return
		end

		self:__select_tower_toggle(var_0_2.tower_toggle.enemy_info)
	end

	function arg_1_0:__onToggle_right_widget_bg_back_tower_info_toggle_layer()
		if self._no_clicking then
			return
		end

		self:__select_tower_toggle(var_0_2.tower_toggle.layer_info)
	end

	function arg_1_0:__onClick_ocean_cia_buff_info_bg()
		if self._no_clicking then
			return
		end

		self._control.ocean_cia_buff_info_bg:SetActive(false)
	end

	function arg_1_0:__onClick_parent_pre_formation_bg()
		if self._no_clicking then
			return
		end

		self:setVisible(false)

		local var_50_0 = var_0_2.enter_select_member_type.fight

		if self._team_type == var_0_2.team_type.abyss_owner_team then
			var_50_0 = var_0_2.enter_select_member_type.abyss_normal_prepare_team
		end

		var_0_1:createInstance("pre_formation"):show(self._fight_prepare_type == var_0_2.fight_type.strike and {
			enter_team = 1,
			enter_type = var_50_0,
			sub_type = var_0_2.fight_prepare_right_panel_type.strike
		} or {
			enter_type = var_50_0,
			sub_type = self._current_content_type,
			enter_team = self._current_team_index
		})
	end

	function arg_1_0:__onClick_support_layer_support_bg_card_bg_icon_btn()
		if self._no_clicking then
			return
		end

		var_0_1:createInstance("supportlist"):show()
	end

	function arg_1_0:__onClick_support_layer_support_bg_get_btn()
		if self._no_clicking then
			return
		end

		if self._support_time <= 0 then
			var_0_3:req_ActiveRankSupportReq()

			self._support_time = 1
		end
	end

	function arg_1_0:__onToggle_left_widget_abyss_btn_owner_team_tog()
		if self._no_clicking then
			return
		end

		self._this_toggle_not_need_refresh = false
		self._control.right_widget.bg_back.abyss_panel.power_tog.toggle.isOn = true
		self._control.right_widget.bg_back.abyss_panel.buff_tog.toggle.isOn = false

		self:__click_update_team_info(var_0_2.team_type.abyss_owner_team)
		self:__change_abyss_panel_state()
		self:__show_abyss_team_buff_ilist()
	end

	function arg_1_0:__onToggle_left_widget_abyss_btn_deep_sea_team_tog()
		if self._no_clicking then
			return
		end

		self._this_toggle_not_need_refresh = true
		self._control.left_widget.func_toggle.toggle1.toggle.isOn = true
		self._control.left_widget.func_toggle.toggle2.toggle.isOn = false
		self._control.left_widget.func_toggle.toggle3.toggle.isOn = false

		self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.abyss_model)
		self:__show_abyss_team_power_meter()
		self:__click_update_team_info(var_0_2.team_type.abyss_team)

		self._control.right_widget.bg_back.abyss_panel.power_tog.toggle.isOn = true

		self:__set_buff_display_state(false)
		self:__show_abyss_team_buff_ilist()
	end

	function arg_1_0:__click_update_team_info(arg_55_1)
		if self._no_clicking then
			return
		end

		self:__set_bottom_info_state(arg_55_1)
		self:update_abyss_model_team_list(self._current_content_type, arg_55_1)
		self:__set_total_props_panel_data()
	end

	function arg_1_0:__onToggle_right_widget_bg_back_abyss_panel_power_tog()
		if self._no_clicking then
			return
		end

		self._abyss_prepare_toggle_index = var_0_2.abyss_right_layer_type.power_layer
		self._control.right_widget.bg_back.abyss_panel.power_tog.title.text.fontSize = 25
		self._control.right_widget.bg_back.abyss_panel.buff_tog.title.text.fontSize = 20

		self:__change_abyss_panel_state()
	end

	function arg_1_0:__onToggle_right_widget_bg_back_abyss_panel_buff_tog()
		if self._no_clicking then
			return
		end

		self._abyss_prepare_toggle_index = var_0_2.abyss_right_layer_type.buff_layer
		self._control.right_widget.bg_back.abyss_panel.power_tog.title.text.fontSize = 20
		self._control.right_widget.bg_back.abyss_panel.buff_tog.title.text.fontSize = 25

		self:__change_abyss_panel_state()
		self:__show_abyss_team_buff_ilist()
	end

	function arg_1_0:__onClick_pre_formation_bg_jp()
		if self._no_clicking then
			return
		end

		self:setVisible(false)
		var_0_1:createInstance("pre_formation"):show({
			enter_type = var_0_2.enter_select_member_type.fight,
			sub_type = self._current_content_type,
			enter_team = self._current_team_index
		})
	end

	function arg_1_0:__prevent_frequently_click()
		local var_59_0 = self:autoKillDOTween(var_0_12.Sequence())

		var_59_0:AppendInterval(0.4)
		var_59_0:Play()
	end

	function arg_1_0:__onClick_strike_buff_weather_close_btn()
		self._control.strike_buff:SetActive(false)
	end

	function arg_1_0:__onToggle_right_widget_bg_back_strike_info_toggle_info()
		if self._no_clicking then
			return
		end

		self:__select_strike_toggle("toggle_info")
	end

	function arg_1_0:__onToggle_right_widget_bg_back_strike_info_toggle_buff()
		if self._no_clicking then
			return
		end

		self:__select_strike_toggle("toggle_buff")
	end

	function arg_1_0:__onToggle_left_widget_func_toggle_toggle4()
		if self._no_clicking then
			return
		end

		if self._fight_prepare_type == var_0_2.fight_type.gotofight then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.equip_preview)
		elseif self._fight_prepare_type == var_0_2.fight_type.exercise or self._fight_prepare_type == var_0_2.fight_type.show_room_friend or self._fight_prepare_type == var_0_2.fight_type.tower_rank_list then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.equip_preview)
		elseif self._fight_prepare_type == var_0_2.fight_type.farfight then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.farfight_equip_preview)
		elseif self._fight_prepare_type == var_0_2.fight_type.campaign then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.equip_preview)
		elseif self._fight_prepare_type == var_0_2.fight_type.sixth_fight then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.six_equip_preview)
		elseif self._fight_prepare_type == var_0_2.fight_type.tower_fight then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.tower)
		elseif self._fight_prepare_type == var_0_2.fight_type.strike then
			self._control.right_widget.bg_back.strike_info.toggle_info.toggle.isOn = false
			self._control.right_widget.bg_back.strike_info.toggle_buff.toggle.isOn = true

			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.strike_equip_preview)
		elseif self._fight_prepare_type == var_0_2.fight_type.fearlessness_sea then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.equip_preview)
		elseif self._fight_prepare_type == var_0_2.fight_type.ocean_attack then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.equip_preview)
		elseif self._fight_prepare_type == var_0_2.fight_type.war_concerto then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.equip_preview)
		elseif self._fight_prepare_type == var_0_2.fight_type.abyss_model_first_phase then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.equip_preview)
		elseif self._fight_prepare_type == var_0_2.fight_type.seventh then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.equip_preview)
		elseif self._fight_prepare_type == var_0_2.fight_type.score_attack then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.equip_preview)
		elseif self._fight_prepare_type == var_0_2.fight_type.eighth_attack then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.equip_preview)
		elseif self._fight_prepare_type == var_0_2.fight_type.ninth_attack then
			self:__toggle_right_panel(var_0_2.fight_prepare_right_panel_type.ninth_equip_preview)
		end
	end

	function arg_1_0:__onToggle_right_widget_bg_back_ninth_info_ninth_toggle_info()
		self._control.right_widget.bg_back.ninth_info.ninth_buffs:SetActive(false)
		self._control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg:SetActive(true)
		self._control.right_widget.bg_back.ninth_info.ninth_speed_info_panel:SetActive(true)
		self._control.right_widget.bg_back.speed_skeleton_mask:SetActive(true)
		self._control.right_widget.bg_back.speed_skeleton_mask.speed_skeleton:SetActive(true)
	end

	function arg_1_0:__onToggle_right_widget_bg_back_ninth_info_ninth_toggle_buff()
		self._control.right_widget.bg_back.ninth_info.ninth_buffs:SetActive(true)
		self._control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg:SetActive(false)
		self._control.right_widget.bg_back.ninth_info.ninth_speed_info_panel:SetActive(false)
		self._control.right_widget.bg_back.speed_skeleton_mask:SetActive(false)
		self._control.right_widget.bg_back.speed_skeleton_mask.speed_skeleton:SetActive(false)
	end
end

function var_0_0.extend_obj(arg_66_0)
	return
end

return var_0_0
