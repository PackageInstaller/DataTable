local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = table.sort
local var_0_3 = gamecore.prompt
local var_0_4 = table.insert
local var_0_5 = gamecore.UILoader
local var_0_6 = gamecore.Language
local var_0_7 = gamecore.util_func
local var_0_8 = gameenum.common_type
local var_0_9 = gameconfig.ship_config
local var_0_11 = gameconfig.skill_config
local var_0_12 = gameconfig.sensitive_words_config

gamecore.UILoader:define("pre_formation_team_item", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
		self._index = arg_2_1
		self._current_team_index = arg_2_1
		self._now_page_num = arg_2_4
		self._team_data = arg_2_2
		self._enter_type = arg_2_3
		self._enter_team = arg_2_5

		self:__init_data(arg_2_3)
		self:__init_text()
		self:__init_panel()
		self:__set_total_props_panel_data()
		self:setVisible(true)
	end

	function arg_1_0.__init_data(arg_3_0, arg_3_1)
		arg_3_0._params = arg_3_1
		arg_3_0._team_type = var_0_8.team_type.pre_formation_team
		arg_3_0._from_type = arg_3_1.enter_type
		arg_3_0._sub_type = arg_3_1.sub_type
	end

	function arg_1_0:__init_text()
		self._control.top_weight.team_name.text.text = var_0_6:getNowLang("pre_formation") .. self._index
		self._control.right_weight.props_panel.title.text.text = var_0_6:getNowLang("pvepreparetotalprops")
		self._control.right_weight.props_panel.radar_chart_bg.prop1.title.text.text = var_0_6:getNowLang("cardattribute5")
		self._control.right_weight.props_panel.radar_chart_bg.prop2.title.text.text = var_0_6:getNowLang("radar")
		self._control.right_weight.props_panel.radar_chart_bg.prop3.title.text.text = var_0_6:getNowLang("airdef")
		self._control.right_weight.props_panel.radar_chart_bg.prop4.title.text.text = var_0_6:getNowLang("def")
		self._control.right_weight.props_panel.radar_chart_bg.prop5.title.text.text = var_0_6:getNowLang("torpedo")
		self._control.right_weight.props_panel.radar_chart_bg.prop6.title.text.text = var_0_6:getNowLang("atk")
		self._control.right_weight.record_team.Text.text.text = var_0_6:getNowLang("pre_formation_record")
		self._control.right_weight.confirm_team.Text.text.text = var_0_6:getNowLang("pre_formation_confirm")
	end

	function arg_1_0:__init_panel()
		self._team_detail_data = {}

		for iter_5_0 = 1, var_0_8.pre_formation_params.pre_formationItem_count do
			local var_5_0 = self._ship_item_list[iter_5_0]

			if not self._ship_item_list[iter_5_0] then
				var_5_0 = self:loadUI("fight_prepare_ship_item")

				var_5_0._panel.transform:SetParent(self._control.left_weight.pre_formation.rectTransform, false)
			end

			if self._team_data then
				local var_5_1 = self._team_data.members[iter_5_0] or nil

				if var_5_1 then
					local var_5_2 = var_0_1:find_character_by_id(var_5_1)

					if var_5_2 then
						local var_5_3 = var_0_9.find_object_by_cid(var_5_2.cid)

						var_5_0:show(iter_5_0, var_0_8.fight_prepare_right_panel_type.pre_formation, var_5_2, var_5_3, self._team_type)
						var_5_0:set_pre_team_num(self._team_data)

						self._team_data[#self._team_data + 1] = var_5_2.id
						self._team_detail_data[#self._team_detail_data + 1] = {
							data = var_5_2,
							config = var_5_3
						}
					else
						self._team_data[#self._team_data] = self._team_data[#self._team_data - 1]
					end

					goto label_5_0
				end
			end

			var_5_0:show(iter_5_0, var_0_8.fight_prepare_right_panel_type.pre_formation, nil, nil, self._team_type)
			var_5_0:set_pre_team_num(self._team_data)

			::label_5_0::

			var_5_0._control.ship_item.ship_item_drag:SetActive(false)

			var_5_0._panel.transform.anchoredPosition = Vector2((iter_5_0 - 1) * (var_5_0._panel.transform.rect.width + 11), var_5_0._panel.transform.anchoredPosition.y)
			self._ship_item_list[iter_5_0] = var_5_0
		end

		if self._sub_type == var_0_8.fight_prepare_right_panel_type.tower or var_0_1:get_into_tower() then
			for iter_5_1, iter_5_2 in ipairs(self._team_detail_data) do
				-- block empty
			end
		end

		self._control.top_weight.fleet_name:SetActive(false)
		self._control.top_weight.team_name:SetActive(true)

		self._control.top_weight.fleet_name.inputField.text = var_0_6:getNowLang("pre_formation") .. self._current_team_index + (self._now_page_num - 1) * 5
		self._control.top_weight.fleet_name.placeholder.text.fontSize = 26
		self._control.top_weight.fleet_name.text.text.fontSize = 26

		self:__update_team_name()
		self._control.top_weight.fleet_name.inputField.onEndEdit:RemoveAllListeners()
		self._control.top_weight.fleet_name.inputField.onEndEdit:AddListener(function()
			self:edit_team_name()
		end)
		var_0_7:input_del_emoji(self._control.top_weight.fleet_name.inputField)
	end

	function arg_1_0:__update_team_name()
		if self._current_team_index then
			local var_7_0 = var_0_1:get_team_data(3, self._current_team_index + (self._now_page_num - 1) * 5 + 8)

			if var_7_0 then
				local var_7_1 = var_7_0.name
				local var_7_2 = (not var_7_0.name or var_7_1 == "") and var_0_6:getNowLang("pre_formation") .. self._current_team_index + (self._now_page_num - 1) * 5 or var_7_1

				if (not var_7_0.name or var_7_1 == "") and self._current_team_index == 1 then
					var_7_2 = var_0_6:getNowLang("pre_formation") .. self._current_team_index + (self._now_page_num - 1) * 5
				end

				self._control.top_weight.fleet_name.inputField.text = var_7_2
				self._control.top_weight.team_name.text.text = var_7_2
			end

			self._control.top_weight.fleet_name:SetActive(false)
			self._control.top_weight.team_name:SetActive(true)
		end
	end

	function arg_1_0:edit_team_name()
		local var_8_0 = {
			id = self._current_team_index + (self._now_page_num - 1) * 5 + 8,
			name = self._control.top_weight.fleet_name.inputField.text
		}
		local var_8_1 = true

		if var_8_0.name == "" or var_8_0.name == nil then
			self:__update_team_name()
		else
			local var_8_2 = app:getSystem():getChannel()

			if (var_8_2 == var_0_8.channel.android_jp or var_8_2 == var_0_8.channel.iOS_jp) and var_0_7.calculate_utf8_char_length(var_8_0.name) > 40 then
				var_0_3:show(var_0_6:getNowLang("pre_formation_rename_tips"))
				self:__update_team_name()

				return
			elseif var_8_2 ~= var_0_8.channel.android_jp and var_8_2 ~= var_0_8.channel.iOS_jp and var_0_7.calculate_utf8_char_length(var_8_0.name) > 16 then
				var_0_3:show(var_0_6:getNowLang("pre_formation_rename_tips"))
				self:__update_team_name()

				return
			end

			local var_8_3, var_8_4 = var_0_7.calculate_utf8_char_length(var_8_0.name)

			for iter_8_0, iter_8_1 in pairs((var_0_12.get_sequence())) do
				if iter_8_1.word ~= "" and string.find(var_8_0.name, iter_8_1.word, 1, true) ~= nil then
					local var_8_5 = var_0_1:get_account_id()

					var_0_1:req_SensitiveWordsReq({
						type = var_0_8.sensitive_words_type.pre_team_name,
						sensitive_words = var_8_0.name
					})

					var_8_0.name = var_0_6:getNowLang("pre_formation") .. self._current_team_index + (self._now_page_num - 1) * 5
					self._control.top_weight.fleet_name.inputField.text = var_8_0.name

					break
				end

				var_8_1 = not var_0_7:filter_spec_chars(var_8_0.name)

				if var_8_1 == false then
					var_8_0.name = var_0_6:getNowLang("pre_formation") .. self._current_team_index + (self._now_page_num - 1) * 5
				end
			end
		end

		if var_8_1 then
			self._control.top_weight.team_name.text.text = var_8_0.name

			var_0_1:req_TeamRename(var_8_0)
		end

		self._control.top_weight.fleet_name:SetActive(false)
		self._control.top_weight.team_name:SetActive(true)
	end

	function arg_1_0:__get_team_index()
		local var_9_0 = var_0_5:getInstance("dock_team")

		if var_9_0 then
			self._team_index = var_9_0:get_current_team_index()

			return self._team_index
		end

		local var_9_1 = var_0_5:getInstance("fight_prepare")

		if var_9_1 then
			self._team_index = var_9_1:get_current_team_index()

			return self._team_index
		end
	end

	function arg_1_0:__set_total_props_panel_data()
		local var_10_0 = {}
		local var_10_1 = {}
		local var_10_3 = 0
		local var_10_4 = 0
		local var_10_5 = 0
		local var_10_7 = 0
		local var_10_8 = 0
		local var_10_10 = 0
		local var_10_11 = 0
		local var_10_13 = 0
		local var_10_14 = 0
		local var_10_16 = 0
		local var_10_17 = 0
		local var_10_19 = 0
		local var_10_20 = 0

		for iter_10_0, iter_10_1 in ipairs(self._team_detail_data) do
			local var_10_23 = var_0_7:get_ship_attr(iter_10_1.data, iter_10_1.config)

			if var_10_23 then
				var_10_0[iter_10_0] = {
					add_by_skill = false,
					speed_num = var_10_23.speed
				}
				var_10_1[iter_10_0] = {
					radar_num = var_10_23.radar
				}

				for iter_10_2, iter_10_3 in pairs(var_10_23) do
					if iter_10_2 == "luck" then
						var_10_4 = math.floor(var_10_4 + iter_10_3)
					elseif iter_10_2 == "air_def" then
						var_10_10 = math.floor(var_10_10 + iter_10_3)
					elseif iter_10_2 == "def" then
						var_10_13 = math.floor(var_10_13 + iter_10_3)
					elseif iter_10_2 == "torpedo" then
						var_10_16 = math.floor(var_10_16 + iter_10_3)
					elseif iter_10_2 == "atk" then
						var_10_19 = math.floor(var_10_19 + iter_10_3)
					end
				end
			end
		end

		for iter_10_4, iter_10_5 in ipairs(self._team_detail_data) do
			self:__add_speed_by_buff_skill(self._team_detail_data, var_10_0, var_10_1, iter_10_4)
		end

		for iter_10_6, iter_10_7 in pairs(var_10_0) do
			var_10_3 = var_10_3 + iter_10_7.speed_num
		end

		var_0_2(var_10_0, function(arg_11_0, arg_11_1)
			return arg_11_0.speed_num < arg_11_1.speed_num
		end)

		for iter_10_8, iter_10_9 in pairs(var_10_1) do
			var_10_7 = var_10_7 + iter_10_9.radar_num
		end

		local var_10_24 = math.floor(var_10_7)
		local var_10_25 = "E7E7E7"

		if next(var_10_0) then
			if var_10_0[1].add_by_skill == true then
				var_10_25 = "2DA6F6"
			end

			if var_10_0[#var_10_0].add_by_skill == true then
				-- block empty
			end

			for iter_10_10, iter_10_11 in pairs(var_10_0) do
				if iter_10_11.add_by_skill == true then
					-- block empty
				end
			end

			self._control.right_weight.speed_info_panel.min_speed.text.text = string.format("<color=#%s>%s</color>", var_10_25, string.format("%0.1f%s", var_10_0[1].speed_num, var_0_6:getNowLang("speedtext")))
			self._control.right_weight.speed_info_panel.max_speed.text.text = string.format("<color=#%s>%s</color>", "E7E7E7", string.format("%0.1f%s", var_10_0[#var_10_0].speed_num, var_0_6:getNowLang("speedtext")))
			self._control.right_weight.speed_info_panel.mean_speed.text.text = string.format("<color=#%s>%s</color>", "E7E7E7", string.format("%0.2f%s", var_10_3 / #var_10_0, var_0_6:getNowLang("speedtext")))
		else
			self._control.right_weight.speed_info_panel.min_speed.text.text = string.format("<color=#%s>%s</color>", var_10_25, string.format("%0d%s", 0, var_0_6:getNowLang("speedtext")))
			self._control.right_weight.speed_info_panel.max_speed.text.text = string.format("<color=#%s>%s</color>", var_10_25, string.format("%0d%s", 0, var_0_6:getNowLang("speedtext")))
			self._control.right_weight.speed_info_panel.mean_speed.text.text = string.format("<color=#%s>%s</color>", var_10_25, string.format("%0d%s", 0, var_0_6:getNowLang("speedtext")))
		end

		local var_10_28 = 500

		for iter_10_12, iter_10_13 in ipairs({
			var_10_5,
			var_10_8,
			var_10_11,
			var_10_14,
			var_10_17,
			var_10_20
		}) do
			if var_10_28 < iter_10_13 then
				var_10_28 = iter_10_13
			end
		end

		local var_10_29 = {}

		var_0_4(var_10_29, var_10_4 / var_10_28)
		var_0_4(var_10_29, var_10_24 / var_10_28)
		var_0_4(var_10_29, var_10_10 / var_10_28)
		var_0_4(var_10_29, var_10_13 / var_10_28)
		var_0_4(var_10_29, var_10_16 / var_10_28)
		var_0_4(var_10_29, var_10_19 / var_10_28)
		var_0_2(var_10_29, function(arg_12_0, arg_12_1)
			return arg_12_0 < arg_12_1
		end)

		local var_10_30 = 1

		if var_10_29[#var_10_29] > 1 then
			var_10_30 = var_10_29[#var_10_29]
		end

		self._control.right_weight.props_panel.radar_chart_bg.draw_web:SetActive(false)

		self._control.right_weight.props_panel.radar_chart_bg.draw_web.uIPolygon.VerticesDistances[0] = var_10_4 / var_10_28 / var_10_30
		self._control.right_weight.props_panel.radar_chart_bg.draw_web.uIPolygon.VerticesDistances[1] = var_10_24 / var_10_28 / var_10_30
		self._control.right_weight.props_panel.radar_chart_bg.draw_web.uIPolygon.VerticesDistances[2] = var_10_10 / var_10_28 / var_10_30
		self._control.right_weight.props_panel.radar_chart_bg.draw_web.uIPolygon.VerticesDistances[3] = var_10_13 / var_10_28 / var_10_30
		self._control.right_weight.props_panel.radar_chart_bg.draw_web.uIPolygon.VerticesDistances[4] = var_10_16 / var_10_28 / var_10_30
		self._control.right_weight.props_panel.radar_chart_bg.draw_web.uIPolygon.VerticesDistances[5] = var_10_19 / var_10_28 / var_10_30

		self._control.right_weight.props_panel.radar_chart_bg.draw_web.uIPolygon:DrawPolygon(6, self._control.right_weight.props_panel.radar_chart_bg.draw_web.uIPolygon.VerticesDistances, 270)
		self._control.right_weight.props_panel.radar_chart_bg.draw_web:SetActive(true)

		self._control.right_weight.props_panel.radar_chart_bg.prop1.num.text.text = tostring(var_10_4)
		self._control.right_weight.props_panel.radar_chart_bg.prop2.num.text.text = tostring(var_10_24)
		self._control.right_weight.props_panel.radar_chart_bg.prop3.num.text.text = tostring(var_10_10)
		self._control.right_weight.props_panel.radar_chart_bg.prop4.num.text.text = tostring(var_10_13)
		self._control.right_weight.props_panel.radar_chart_bg.prop5.num.text.text = tostring(var_10_16)
		self._control.right_weight.props_panel.radar_chart_bg.prop6.num.text.text = tostring(var_10_19)
	end

	function arg_1_0.__add_speed_by_skill_by_effect(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
		for iter_13_0, iter_13_1 in pairs(arg_13_3) do
			if iter_13_1.type == 3 and iter_13_1.speed then
				arg_13_1[arg_13_4].speed_num = arg_13_1[arg_13_4].speed_num + iter_13_1.speed
				arg_13_1[arg_13_4].add_by_skill = true
			elseif iter_13_1.type == 3 and iter_13_1.radar then
				arg_13_2[arg_13_4].radar_num = arg_13_2[arg_13_4].radar_num + iter_13_1.radar
			end
		end
	end

	function arg_1_0:__add_speed_by_buff_skill(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
		local var_14_0 = arg_14_1[arg_14_4].data
		local var_14_1 = var_0_11.find_object_by_skill_type_skill_level(arg_14_1[arg_14_4].data.now_skill, arg_14_1[arg_14_4].data.skill_level)

		if not var_14_1 then
			return
		end

		if not var_14_1.pre_effect[1] then
			return
		end

		for iter_14_0, iter_14_1 in pairs(var_14_1.pre_effect) do
			local var_14_2 = false

			if iter_14_1.condition then
				for iter_14_2, iter_14_3 in pairs(iter_14_1.condition) do
					if iter_14_3.type == 43 then
						local var_14_3 = true

						for iter_14_4, iter_14_5 in pairs(arg_14_1) do
							if iter_14_5.data.id ~= var_14_0.id then
								for iter_14_6, iter_14_7 in pairs(iter_14_3.shipTypes) do
									if iter_14_5.data.type == iter_14_7 then
										var_14_3 = false
									end
								end
							end
						end

						var_14_2 = var_14_3
					elseif iter_14_3.type == 26 and arg_14_4 == 1 then
						var_14_2 = true
					end
				end
			else
				var_14_2 = true
			end

			if var_14_2 == false then
				return
			end

			for iter_14_8, iter_14_9 in pairs(iter_14_1.target) do
				if iter_14_9.type == 2 then
					for iter_14_10, iter_14_11 in pairs(iter_14_9.shipTypes) do
						if arg_14_1[arg_14_4 - 1] and arg_14_1[arg_14_4 - 1].data.type == iter_14_11 then
							self:__add_speed_by_skill_by_effect(arg_14_2, arg_14_3, iter_14_1.effect, arg_14_4 - 1)
						end

						if arg_14_1[arg_14_4 + 1] and arg_14_1[arg_14_4 + 1].data.type == iter_14_11 then
							self:__add_speed_by_skill_by_effect(arg_14_2, arg_14_3, iter_14_1.effect, arg_14_4 + 1)
						end
					end
				elseif iter_14_9.type == 4 then
					local var_14_4 = 0

					for iter_14_12, iter_14_13 in pairs(arg_14_1) do
						if iter_14_13.data.id == var_14_0.id then
							var_14_4 = iter_14_12
						end
					end

					for iter_14_14, iter_14_15 in pairs(arg_14_1) do
						if iter_14_14 < var_14_4 and iter_14_14 >= var_14_4 - iter_14_9.num then
							self:__add_speed_by_skill_by_effect(arg_14_2, arg_14_3, iter_14_1.effect, iter_14_14)
						end
					end
				elseif iter_14_9.type == 7 then
					self:__add_speed_by_skill_by_effect(arg_14_2, arg_14_3, iter_14_1.effect, arg_14_4)
				elseif iter_14_9.type == 8 then
					for iter_14_16, iter_14_17 in pairs(arg_14_1) do
						self:__add_speed_by_skill_by_effect(arg_14_2, arg_14_3, iter_14_1.effect, iter_14_16)
					end
				elseif iter_14_9.type == 10 then
					for iter_14_18, iter_14_19 in pairs(arg_14_1) do
						local var_14_5 = var_0_9.find_object_by_cid(iter_14_19.data.cid)

						if var_14_5 then
							for iter_14_20, iter_14_21 in ipairs(iter_14_9.country) do
								if var_14_5.country == iter_14_21 then
									self:__add_speed_by_skill_by_effect(arg_14_2, arg_14_3, iter_14_1.effect, iter_14_18)
								end
							end
						end
					end
				elseif iter_14_9.type == 11 or iter_14_9.type == 12 then
					for iter_14_22, iter_14_23 in pairs(arg_14_1) do
						local var_14_6 = var_0_9.find_object_by_cid(iter_14_23.data.cid)

						if var_14_6 then
							local var_14_7 = false

							for iter_14_24, iter_14_25 in pairs(iter_14_9.shipTypes or {}) do
								if var_14_6.type == iter_14_25 then
									var_14_7 = true

									break
								end
							end

							if not var_14_7 then
								for iter_14_26, iter_14_27 in pairs(iter_14_9.shipTons or {}) do
									if var_14_6.ship_ton == iter_14_27 then
										var_14_7 = true

										break
									end
								end
							end

							if not var_14_7 then
								for iter_14_28, iter_14_29 in pairs(iter_14_9.guardTypes or {}) do
									if var_14_6.guard_type == iter_14_29 then
										var_14_7 = true

										break
									end
								end
							end

							local var_14_10 = true

							if iter_14_9.type == 12 then
								var_14_10 = false

								for iter_14_30, iter_14_31 in pairs(iter_14_9.country or {}) do
									if var_14_6.country == iter_14_31 then
										var_14_10 = true

										break
									end
								end
							end

							if var_14_7 and var_14_10 then
								self:__add_speed_by_skill_by_effect(arg_14_2, arg_14_3, iter_14_1.effect, iter_14_22)
							end
						end
					end
				end
			end
		end
	end

	function arg_1_0:save_team_info_all()
		local var_15_0 = {}
		local var_15_1 = {}

		for iter_15_0, iter_15_1 in pairs(self._team_data.members) do
			var_0_4(var_15_0, {
				keys = iter_15_0,
				id = iter_15_1
			})
		end

		var_0_2(var_15_0, function(arg_16_0, arg_16_1)
			return arg_16_0.keys < arg_16_1.keys
		end)

		for iter_15_2, iter_15_3 in ipairs(var_15_0) do
			var_15_1[iter_15_2] = iter_15_3.id
		end

		if self._team_data.id and self._team_data.id == 1 and (not var_15_0 or not next(var_15_0)) then
			return false
		end

		var_0_1:req_TeamSave({
			quick = true,
			id = self._team_data.id,
			members = var_15_1
		})

		return true
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_17_0)
	local var_17_0 = var_0_5:class("pre_formation_team_item")

	var_17_0._index = nil
	var_17_0._team_data = {}
	var_17_0._ship_item_list = {}
	var_17_0._team_detail_data = {}
	var_17_0._current_team_index = 1

	return var_17_0
end

return var_0_0
