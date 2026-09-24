local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gameenum.common_type
local var_0_4 = string.format
local var_0_5 = gamecore.user
local var_0_6 = gameconfig.skin_config
local var_0_7 = gameconfig.ship_config
local var_0_8 = gameconfig.equip_config
local var_0_9 = gameconfig.skill_config
local var_0_10 = gameconfig.ship_level_config
local var_0_14 = UnityEngine.Vector2
local var_0_16 = gamecore.util_func
local var_0_18 = math.floor
local var_0_20 = DG.Tweening.DOTween
local var_0_23
local var_0_24
local var_0_25 = lx

gamecore.UILoader:define("abyss_ship_detail", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self:setVisible(true)

		self._enter_type = arg_2_1

		self:__init_variate()
		self:__init_languagee()

		self._special_abyss_enter_type = var_0_5:get_enter_abyss_ship_detail_type()

		self:set_data(arg_2_2)
		self:__init_panel()
	end

	function arg_1_0:play_in_out_animation(arg_3_1, arg_3_2, arg_3_3)
		arg_3_3 = arg_3_3 or self._control.bg.uITweenSequence

		if arg_3_1 then
			arg_3_3:Play(function()
				if arg_3_2 then
					arg_3_2()
				end
			end)
		else
			arg_3_3:PlayReverse(function()
				if arg_3_2 then
					arg_3_2()
				end
			end)
		end
	end

	function arg_1_0:set_data(arg_6_1)
		self._is_single = self._enter_type == var_0_3.enter_ship_detail_type.abyss_single_ship or self._enter_type == var_0_3.enter_ship_detail_type.abyss_remake or self._enter_type == var_0_3.enter_ship_detail_type.abyss_synthesis_explain or self._enter_type == var_0_3.enter_ship_detail_type.abyss_synthesis
		self._is_team = self._enter_type == var_0_3.enter_ship_detail_type.abyss_dock_team or self._enter_type == var_0_3.enter_ship_detail_type.abyss_fight_prepare

		if self._is_single then
			self._data = arg_6_1
			self._now_ship_data = self:__get_ship_cfg(arg_6_1.cid)
			self._now_character_data = arg_6_1
		elseif self._is_team then
			self._index = arg_6_1.index

			local var_6_0 = true

			if self._enter_type == var_0_3.enter_ship_detail_type.abyss_dock_team then
				local var_6_1 = var_0_2:getInstance("abyss_dock_team")
				local var_6_2

				if var_6_1 then
					var_6_2 = var_6_1:get_current_team_index()
				end

				if not var_6_2 or var_6_2 == 0 or var_6_2 == 5 then
					var_6_0 = false
				end
			end

			if arg_6_1.team_data and #arg_6_1.team_data > 0 and var_6_0 then
				self._members = arg_6_1.team_data
			else
				self._data = arg_6_1.team_data
				self._members = {}
				self._now_ship_data = self:__get_ship_cfg(self._data.cid)
				self._now_character_data = arg_6_1.team_data
			end

			self:set_data_by_index(self._index)
		else
			self._now_ship_data = arg_6_1
			self._now_character_data = arg_6_1
		end
	end

	function arg_1_0:set_data_by_index(arg_7_1)
		if #self._members == 0 or not self._members[arg_7_1] then
			return
		end

		local var_7_0 = var_0_5:find_abyss_character_by_id(self._members[arg_7_1])

		self._data = var_7_0 and var_0_16.little_clone(var_7_0) or {}
		self._now_ship_data = self:__get_ship_cfg(self._data.cid)
		self._now_character_data = self._data
	end

	function arg_1_0:show_ship_icon(arg_8_1)
		local var_8_0, var_8_1 = self:loadSprite(var_0_3:get_ship_icon(var_0_16:use_big_break_painting(self._now_character_data, var_0_3.ship_icon_type.model_l, false), arg_8_1))

		self._control.left.ship_role.image.sprite = var_8_0

		if var_8_1 then
			var_0_3:hd_sprite_half_scale(self._control.left.ship_role.transform)
		end
	end

	function arg_1_0.__init_ship_detail_content(arg_9_0, arg_9_1)
		arg_9_0._detail_attr_content = {
			hp = arg_9_1.attr_hp,
			atk = arg_9_1.attr_atk,
			def = arg_9_1.attr_def,
			torpedo = arg_9_1.attr_torpedo,
			miss = arg_9_1.attr_miss,
			air_def = arg_9_1.attr_airdef,
			capacity = arg_9_1.attr_capacity,
			antisub = arg_9_1.attr_antisub,
			speed = arg_9_1.attr_speed,
			radar = arg_9_1.attr_radar,
			range = arg_9_1.attr_range,
			luck = arg_9_1.attr_luck
		}
		arg_9_0._detail_attr_table = {
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
	end

	function arg_1_0:init_ship_detail_info()
		local var_10_0 = (self._enter_type == var_0_3.enter_ship_detail_type.abyss_synthesis_explain or self._enter_type == var_0_3.enter_ship_detail_type.abyss_remake) and (self._data.max_level or self._data.level) or self._data.level

		if self._now_ship_data then
			var_0_24.ship_title.ship_level.text.text = "Lv." .. var_10_0

			if var_10_0 == 110 then
				var_0_24.ship_title.ship_level.text.color = Color.New(255, 255, 0)
			end

			if self._enter_type == var_0_3.enter_ship_detail_type.abyss_synthesis_explain or self._enter_type == var_0_3.enter_ship_detail_type.abyss_remake then
				if not self._data.title then
					var_0_24.ship_title.ship_name_move.ship_name.text.text = self._data.name
				end

				var_0_24.ship_title.ship_name_move.ship_name_move.text.text = self._data.title or self._data.name
			else
				var_0_24.ship_title.ship_name.text.text = self._data.name
			end

			local var_10_2 = var_0_24.ship_title.ship_name_move:GetComponent("TextHorizonScroller")

			if self._enter_type == var_0_3.enter_ship_detail_type.abyss_synthesis_explain or self._enter_type == var_0_3.enter_ship_detail_type.abyss_remake then
				var_10_2:SetText(self._data.title)
			else
				var_10_2:SetText(self._data.name)
			end

			if var_10_0 < self._now_ship_data.max_level then
				local var_10_3 = var_0_10.find_object_by_level(var_10_0).exp

				var_0_24.ship_title.exp_num.text.text = self._data.exp .. "/" .. var_10_3
				var_0_24.ship_title.ship_exp.exp_bar.image.fillAmount = self._data.exp / var_10_3
			else
				var_0_24.ship_title.ship_exp.exp_bar.image.fillAmount = 1
				var_0_24.ship_title.exp_num.text.text = "MAX"
			end
		else
			var_0_24.ship_title.ship_level.text.text = "Lv." .. var_10_0
			var_0_24.ship_title.ship_name.text.text = self._data.title
			var_0_24.ship_title.ship_name_move.ship_name.text.text = self._data.title
			var_0_24.ship_title.ship_name_move.ship_name_move.text.text = self._data.title
			var_0_24.ship_title.exp_num.text.text = "0/0"
			var_0_24.ship_title.ship_exp.exp_bar.image.fillAmount = 1
		end

		self:__set_ship_detail(var_0_24.detail_info.detail)

		local var_10_4 = var_0_24.detail_info.detail.ship_skill

		var_0_24.detail_info.detail.ship_skill:SetActive(self._data.now_skill ~= 0)

		local var_10_5 = not self._data.now_skill and var_0_9.find_object_by_skill_id(self._data.skill_id) or var_0_9.find_object_by_skill_type_skill_level(self._data.now_skill, self._data.skill_level)

		if self._data.now_skill and self._data.now_skill == 0 or not var_10_5 then
			var_0_24.detail_info.detail.skill_name.text.text.text = var_0_1:getNowLang("noskill")

			var_0_24.detail_info.detail.skill_name:GetComponent("TextHorizonScroller"):SetText(var_0_1:getNowLang("noskill"))

			var_10_4.skill_level.text.text = ""
			var_10_4.skill_stage.text.text = ""
			var_10_4.skill_phase.skill_phase_1.text.text = ""
			var_10_4.skill_phase.skill_phase_2.text.text = ""
			var_10_4.scrollview.content.skill_desc.text.text = ""
			var_10_4.scrollview.content.skill_desc.skill_desc_2.text.text = ""
		else
			var_0_24.detail_info.detail.skill_name.text.text.text = var_10_5.title

			var_0_24.detail_info.detail.skill_name:GetComponent("TextHorizonScroller"):SetText(var_10_5.title)

			var_10_4.skill_level.text.text = "Slv:" .. self._data.skill_id % 10
			var_10_4.skill_stage.text.text = var_0_1:getNowLang("shipinfoskillphase")
			var_10_4.skill_phase.skill_phase_1.text.text = var_10_5.phase_desc

			var_10_4.skill_phase:GetComponent("TextHorizonScroller"):SetText(var_10_5.phase_desc)

			var_10_4.scrollview.content.skill_desc.text.text = var_0_16.convert_rich_text(var_10_5.desc)
			var_10_4.scrollview.content.skill_desc.skill_desc_2.text.text = var_0_16.convert_rich_text2(var_10_5.desc)
		end
	end

	function arg_1_0:__set_ship_detail(arg_11_1)
		local var_11_0
		local var_11_1
		local var_11_2

		if not self._now_ship_data then
			for iter_11_0, iter_11_1 in pairs(self._data.equips) do
				var_11_2 = var_0_8.find_object_by_cid(iter_11_1.id)
			end

			var_11_0 = self._data
		elseif self._enter_type == var_0_3.enter_ship_detail_type.abyss_synthesis_explain or self._enter_type == var_0_3.enter_ship_detail_type.abyss_synthesis or self._enter_type == var_0_3.enter_ship_detail_type.abyss_remake then
			var_11_0, var_11_2, var_11_1 = self:__set_abyss_equail_ship_data(self._data)
		else
			var_11_2 = var_0_5:get_abyss_attribute_effect_by_equip(self._data.id)
			var_11_0 = var_0_5:get_abyss_character_attribute_by_calculate(self._data.id)
			var_11_1 = var_0_5:get_abyss_character_attribute_by_calculate_no_equips(self._data.id)
		end

		if var_11_2 then
			for iter_11_2, iter_11_3 in pairs(var_11_2) do
				if self._detail_attr_content[iter_11_2] then
					local var_11_3 = iter_11_3 ~= 0 and iter_11_2 ~= "range"

					self._detail_attr_content[iter_11_2].tip_icon:SetActive(iter_11_3 ~= 0 and iter_11_2 ~= "range")
					self._detail_attr_content[iter_11_2].attr_bg:SetActive(var_11_3)

					self._detail_attr_content[iter_11_2].attr_num.text.color = var_11_3 and Color.New(1, 1, 1) or Color.New(0.23529411764705882, 0.6196078431372549, 1)

					if iter_11_3 > 0 and iter_11_2 ~= "range" then
						self._detail_attr_content[iter_11_2].tip_icon.image.sprite = self:loadSprite(var_0_3.ship_detail.attr_up)
						self._detail_attr_content[iter_11_2].attr_bg.image.sprite = self:loadSprite(var_0_3.ship_detail_equip_record.bg_data_blud)
					elseif iter_11_3 < 0 and iter_11_2 ~= "range" then
						self._detail_attr_content[iter_11_2].tip_icon.image.sprite = self:loadSprite(var_0_3.ship_detail.attr_down)
						self._detail_attr_content[iter_11_2].attr_bg.image.sprite = self:loadSprite(var_0_3.ship_detail_equip_record.bg_data_red)
					end
				end
			end
		end

		if self._now_ship_data then
			local var_11_5 = not self._data.now_skill and var_0_9.find_object_by_skill_id(self._data.skill_id) or var_0_9.find_object_by_skill_type_skill_level(self._data.now_skill, self._data.skill_level)
			local var_11_6
			local var_11_7

			if var_11_5 and var_11_5.effect[1] then
				for iter_11_4, iter_11_5 in pairs(var_11_5.effect) do
					if var_11_5.effect[iter_11_4].type == 1 and var_11_5.effect[iter_11_4].stage[1] == 1 then
						for iter_11_6, iter_11_7 in pairs(var_11_5.effect[iter_11_4].effect) do
							if iter_11_7.type == 3 then
								for iter_11_8, iter_11_9 in pairs(self._detail_attr_table) do
									if iter_11_7[self._detail_attr_table[iter_11_8]] then
										var_11_6 = self._detail_attr_table[iter_11_8]
										var_11_7 = iter_11_7[self._detail_attr_table[iter_11_8]]
									end
								end

								if var_11_6 and var_11_7 and var_11_0[var_11_6] and self._detail_attr_content[var_11_6] then
									var_11_7 = var_11_7 * var_0_16.get_attr_multiple_by_config(var_11_5, self._data, iter_11_4)
									var_11_0[var_11_6] = var_11_0[var_11_6] + var_11_7
								end
							elseif iter_11_7.type == 4 then
								for iter_11_10, iter_11_11 in pairs(iter_11_7) do
									if iter_11_10 ~= "type" then
										var_11_0[iter_11_10] = var_11_0[iter_11_10] or 1
										var_11_0[iter_11_10] = var_11_0[iter_11_10] + var_11_0[iter_11_10] * iter_11_11
									end
								end
							elseif iter_11_7.type == 5 then
								if var_11_0[self._detail_attr_table[iter_11_7.attribute]] and var_11_0[self._detail_attr_table[iter_11_7.attribute2]] then
									var_11_0[self._detail_attr_table[iter_11_7.attribute2]] = var_11_0[self._detail_attr_table[iter_11_7.attribute2]] + var_11_0[self._detail_attr_table[iter_11_7.attribute]] * iter_11_7.rate

									self._detail_attr_content[self._detail_attr_table[iter_11_7.attribute2]].tip_icon:SetActive(true)
									self._detail_attr_content[self._detail_attr_table[iter_11_7.attribute2]].attr_bg:SetActive(true)

									self._detail_attr_content[self._detail_attr_table[iter_11_7.attribute2]].attr_num.text.color = Color.New(1, 1, 1)
									self._detail_attr_content[self._detail_attr_table[iter_11_7.attribute2]].attr_num.text.text = var_11_0[self._detail_attr_table[iter_11_7.attribute2]]
								end
							elseif iter_11_7.type == 94 then
								if var_11_0.range >= iter_11_7.num then
									var_11_0.range = var_11_0.range or iter_11_7.num
								end
							elseif iter_11_7.type == 49 then
								for iter_11_12, iter_11_13 in ipairs(self._data.equips) do
									local var_11_8 = var_0_8.find_object_by_cid(iter_11_13.id)

									if var_11_8 then
										for iter_11_14, iter_11_15 in pairs(var_11_8) do
											if self._detail_attr_content[iter_11_14] and iter_11_15 ~= 0 and iter_11_14 ~= "range" and iter_11_14 ~= "hp" then
												var_11_0[iter_11_14] = var_11_0[iter_11_14] + iter_11_15 * iter_11_7.rate
											end
										end
									end
								end
							elseif iter_11_7.type == 50 then
								for iter_11_16, iter_11_17 in ipairs(self._data.equips) do
									if iter_11_17.id > 0 then
										local var_11_9 = var_0_8.find_object_by_cid(iter_11_17.id)

										if var_11_0[self._detail_attr_table[iter_11_7.attribute]] and var_11_9[self._detail_attr_table[iter_11_7.attribute]] and var_11_0[self._detail_attr_table[iter_11_7.attribute2]] then
											var_11_0[self._detail_attr_table[iter_11_7.attribute2]] = var_11_0[self._detail_attr_table[iter_11_7.attribute2]] + var_11_9[self._detail_attr_table[iter_11_7.attribute]] * iter_11_7.rate

											self._detail_attr_content[self._detail_attr_table[iter_11_7.attribute2]].tip_icon:SetActive(true)
											self._detail_attr_content[self._detail_attr_table[iter_11_7.attribute2]].attr_bg:SetActive(true)

											self._detail_attr_content[self._detail_attr_table[iter_11_7.attribute2]].attr_num.text.color = Color.New(1, 1, 1)
										end
									end
								end
							elseif iter_11_7.type == 51 then
								local var_11_10 = 0

								for iter_11_18, iter_11_19 in ipairs(self._data.equips) do
									for iter_11_20, iter_11_21 in pairs(iter_11_7.equipment_type) do
										if iter_11_19.id > 0 and var_0_8.find_object_by_cid(iter_11_19.id).type == iter_11_21 then
											var_11_10 = var_11_10 + 1
										end
									end
								end

								for iter_11_22, iter_11_23 in pairs(iter_11_7) do
									if var_11_0[iter_11_22] then
										var_11_0[iter_11_22] = var_11_0[iter_11_22] + iter_11_23 * var_11_10

										break
									end
								end
							elseif iter_11_7.type == 52 then
								for iter_11_24, iter_11_25 in ipairs(self._data.equips) do
									for iter_11_26, iter_11_27 in pairs(iter_11_7.equipment_type) do
										local var_11_11 = var_0_8.find_object_by_cid(iter_11_25.id)

										if iter_11_25.id > 0 and var_11_11.type == iter_11_27 then
											for iter_11_28, iter_11_29 in pairs(iter_11_7) do
												if var_11_0[iter_11_28] and var_11_11[iter_11_28] then
													var_11_0[iter_11_28] = var_11_0[iter_11_28] + var_11_11[iter_11_28] * iter_11_7[iter_11_28]
												end
											end
										end
									end
								end
							elseif iter_11_7.type == 54 then
								for iter_11_30, iter_11_31 in ipairs(self._data.equips) do
									if iter_11_31.id > 0 then
										for iter_11_32, iter_11_33 in pairs(iter_11_7.equipment_type) do
											local var_11_12 = var_0_8.find_object_by_cid(iter_11_31.id)

											if iter_11_31.id > 0 and var_11_12.type == iter_11_33 then
												for iter_11_34, iter_11_35 in pairs(iter_11_7) do
													if var_11_0[self._detail_attr_table[iter_11_7.attribute]] and var_11_12[self._detail_attr_table[iter_11_7.attribute]] and var_11_0[self._detail_attr_table[iter_11_7.attribute2]] then
														var_11_0[self._detail_attr_table[iter_11_7.attribute2]] = var_11_0[self._detail_attr_table[iter_11_7.attribute2]] + var_11_12[self._detail_attr_table[iter_11_7.attribute]] * iter_11_7.rate

														self._detail_attr_content[self._detail_attr_table[iter_11_7.attribute2]].tip_icon:SetActive(true)
														self._detail_attr_content[self._detail_attr_table[iter_11_7.attribute2]].attr_bg:SetActive(true)

														self._detail_attr_content[self._detail_attr_table[iter_11_7.attribute2]].attr_num.text.color = Color.New(1, 1, 1)

														break
													end
												end
											end
										end
									end
								end
							elseif iter_11_7.type == 131 then
								local var_11_13

								if var_11_1[self._detail_attr_table[iter_11_7.attribute]] then
									var_11_13 = var_0_16.attr_impact_by_speed(var_11_1.speed, var_11_1[self._detail_attr_table[iter_11_7.attribute]], iter_11_7.num1, iter_11_7.num2) - var_11_1[self._detail_attr_table[iter_11_7.attribute]]
								end

								if var_11_13 then
									var_11_0[self._detail_attr_table[iter_11_7.attribute]] = var_11_0[self._detail_attr_table[iter_11_7.attribute]] + var_11_13
								end
							end
						end
					end
				end
			end
		end

		for iter_11_36, iter_11_37 in pairs(var_11_0) do
			if self._detail_attr_content[iter_11_36] then
				if iter_11_36 == "speed" then
					local var_11_15 = self._detail_attr_content[iter_11_36].attr_bg.rectTransform.sizeDelta
					local var_11_16

					self._detail_attr_content[iter_11_36].attr_num.text.text, var_11_16 = var_0_16.convert_decimals(iter_11_37)
					self._detail_attr_content[iter_11_36].attr_num.text.text = self._detail_attr_content[iter_11_36].attr_num.text.text .. "节"
					var_11_15 = var_11_16 > 0 and var_0_14(78, var_11_15.y) or var_0_14(55, var_11_15.y)
					self._detail_attr_content[iter_11_36].attr_bg.rectTransform.sizeDelta = var_11_15
				else
					self._detail_attr_content[iter_11_36].attr_num.text.text = var_0_18(tonumber(iter_11_37))
				end

				if iter_11_36 == "range" then
					self._detail_attr_content[iter_11_36].attr_num.text.text = var_0_3:get_shoot_type_name(iter_11_37)
				end
			end
		end

		arg_11_1.ship_star.image.sprite = self:loadSprite(var_0_4(var_0_3.ship_detail.star, self._data.star))

		if self._now_ship_data then
			arg_11_1.change_icon:SetActive(self._now_ship_data.evo_class)
		else
			arg_11_1.change_icon:SetActive(false)
		end

		self._now_character_data.hp = var_11_0.hp
	end

	function arg_1_0.__set_abyss_equail_ship_data(arg_12_0, arg_12_1)
		local var_12_0 = var_0_25.clone_table(arg_12_1)
		local var_12_1 = {
			atk = 0,
			def = 0,
			hp = 0,
			torpedo = 0,
			air_def = 0,
			range = 0,
			speed = 0,
			luck = 0,
			capacity = 0,
			miss = 0,
			antisub = 0,
			radar = 0
		}
		local var_12_2 = {}
		local var_12_3 = {}
		local var_12_4 = {}
		local var_12_6 = {}

		for iter_12_0, iter_12_1 in pairs(var_12_0.equips or var_12_0.equipment or {}) do
			var_12_6[iter_12_0] = gameconfig.equip_config.find_object_by_cid(iter_12_1.id)
		end

		for iter_12_2, iter_12_3 in pairs(var_12_1) do
			local var_12_7 = 0

			for iter_12_4, iter_12_5 in pairs(var_12_6) do
				var_12_7 = var_12_7 + (not iter_12_5[iter_12_2] and 0 or iter_12_5[iter_12_2])
			end

			var_12_2[iter_12_2] = var_12_7
		end

		for iter_12_6, iter_12_7 in pairs(var_12_1) do
			var_12_4[iter_12_6] = var_12_0[iter_12_6]
		end

		for iter_12_8, iter_12_9 in pairs(var_12_1) do
			var_12_3[iter_12_8] = var_12_4[iter_12_8] + var_12_2[iter_12_8]

			if iter_12_8 == "range" and var_12_3[iter_12_8] > 4 then
				var_12_3[iter_12_8] = 4
			end
		end

		return var_12_3, var_12_2, var_12_4
	end

	function arg_1_0:show_layer(arg_13_1)
		if arg_13_1 == 1 then
			self:__show_role_icon()
			self:__get_now_skin_index()
		else
			self:__get_now_skin_index()
		end

		self._control.left.ship_info:SetActive(arg_13_1 == 1)
	end

	function arg_1_0.reset_enter_type(arg_14_0)
		arg_14_0._enter_type = var_0_3.enter_ship_detail_type.default
	end

	function arg_1_0.__get_ship_cfg(arg_15_0, arg_15_1)
		return (var_0_7.find_abyss_object_by_cid(arg_15_1))
	end

	function arg_1_0.__get_skin_cfg(arg_16_0, arg_16_1)
		return (var_0_6.find_object_by_cid(arg_16_1))
	end

	function arg_1_0:__init_variate()
		var_0_23 = self._control.left.ship_info
		var_0_24 = self._control.right.ship_detail
	end

	function arg_1_0:__init_panel()
		if self._now_ship_data then
			self:show_ship_icon(self._now_ship_data.pic_id)
		elseif self._data.pic_id then
			self:show_ship_icon(self._data.pic_id)
		end

		self:__init_panel_by_type()
	end

	function arg_1_0:__init_panel_by_type()
		local var_19_0 = self._is_single or self._is_team

		self._control.left.drag_for_switch:SetActive(self._is_team and #self._members > 1)
		var_0_24:SetActive(var_19_0)
		var_0_23:SetActive(not var_19_0)

		if self._is_single or self._is_team then
			local var_19_1 = 0

			if self._now_ship_data then
				for iter_19_0, iter_19_1 in pairs(self._now_ship_data.skins) do
					if self._data.skin == iter_19_1 then
						var_19_1 = iter_19_0
					end
				end
			end

			if var_19_1 ~= 0 then
				if self._now_ship_data then
					self:show_ship_icon(self:__get_skin_cfg(self._now_ship_data.skins[var_19_1]).icon)
				elseif self._data.pic_id then
					self:show_ship_icon(self._data.pic_id)
				end
			end

			self:__init_slider_listenter()
			self:__init_equip_content()
			self:__init_equips()
			self:__init_ship_detail_content(var_0_24.detail_info.detail)
			self:init_ship_detail_info()
		end

		self._control.left.ship_info:SetActive(true)

		var_0_23.ship_type.text.text = var_0_1:getNowLang(var_0_3:get_ship_type_language_key(self._now_ship_data.type, 1))
		var_0_23.country_txt.text.text = var_0_1:getNowLang(var_0_3:get_country_language_key(self._now_ship_data.country))
		self._now_paint_sprite = self._control.left.ship_role.image.sprite
		self._control.left.ship_role.transform.localScale = Vector3.New(1, 1, 1)
	end

	function arg_1_0.__init_equip_content(arg_20_0)
		arg_20_0._equip_content = {
			var_0_24.ship_equip.equip_1,
			var_0_24.ship_equip.equip_2,
			var_0_24.ship_equip.equip_3,
			var_0_24.ship_equip.equip_4
		}
	end

	function arg_1_0:__init_languagee()
		if self._is_already_init then
			return
		end

		var_0_24.ship_equip.shipinfocurrentequips.text.text = var_0_1:getNowLang("shipinfocurrentequips")

		self:__init_detail_attr_title(var_0_24.detail_info.detail)

		self._is_already_init = true
	end

	function arg_1_0.__init_detail_attr_title(arg_22_0, arg_22_1)
		arg_22_1.attr_hp.hp.text.text = var_0_1:getNowLang("hp")
		arg_22_1.attr_atk.atk.text.text = var_0_1:getNowLang("atk")
		arg_22_1.attr_def.def.text.text = var_0_1:getNowLang("def")
		arg_22_1.attr_torpedo.torpedo.text.text = var_0_1:getNowLang("torpedo")
		arg_22_1.attr_miss.miss.text.text = var_0_1:getNowLang("miss")
		arg_22_1.attr_airdef.airdef.text.text = var_0_1:getNowLang("airdef")
		arg_22_1.attr_capacity.capacity.text.text = var_0_1:getNowLang("capacity")
		arg_22_1.attr_antisub.antisub.text.text = var_0_1:getNowLang("antisub")
		arg_22_1.attr_speed.speed.text.text = var_0_1:getNowLang("speed")
		arg_22_1.attr_radar.radar.text.text = var_0_1:getNowLang("radar")
		arg_22_1.attr_range.range.text.text = var_0_1:getNowLang("range")
		arg_22_1.attr_luck.luck.text.text = var_0_1:getNowLang("luck")
	end

	function arg_1_0:__init_slider_listenter()
		self._control.role_scale.slide.slider.value = 0

		self._control.role_scale.slide.slider.onValueChanged:AddListener(function(arg_24_0)
			self._control.left.ship_role.shipViewControl:SetScale(arg_24_0)
		end)
	end

	function arg_1_0:__look_over_view(arg_25_1)
		self._control.right.ship_detail:SetActive(not arg_25_1)
		self._control.role_scale:SetActive(arg_25_1)
		self._control.right_btn_ship:SetActive(arg_25_1)
		self._control.left.return_btn:SetActive(not arg_25_1)
		self._control.left.alone_view_btn:SetActive(not arg_25_1)
		self._control.left.ship_info:SetActive(not arg_25_1)

		local var_25_0 = 1280
		local var_25_1 = 720

		if UnityEngine.Screen.width / UnityEngine.Screen.height > 1.33 and UnityEngine.Screen.width / UnityEngine.Screen.height < 1.34 then
			var_25_0 = 1280
			var_25_1 = 960
		end

		self._control.left.ship_role.shipViewControl.onDrag:RemoveAllListeners()
		self._control.left.ship_role.shipViewControl.onDrag:AddListener(function(arg_26_0, arg_26_1)
			local var_26_0 = self._control.left.ship_role.rectTransform.anchoredPosition.x + arg_26_0
			local var_26_1 = self._control.left.ship_role.rectTransform.anchoredPosition.y + arg_26_1

			if self._control.left.ship_role.rectTransform.anchoredPosition.x + arg_26_0 <= 0 then
				var_26_0 = 0
			end

			if var_26_0 >= var_25_0 then
				var_26_0 = var_25_0
			end

			if var_26_1 <= -var_25_1 / 2 + 66.5 then
				var_26_1 = -var_25_1 / 2 + 66.5
			end

			if var_26_1 >= var_25_1 / 2 + 66.5 then
				var_26_1 = var_25_1 / 2 + 66.5
			end

			self._control.left.ship_role.rectTransform.anchoredPosition = var_0_14(var_26_0, var_26_1)
		end)
	end

	function arg_1_0:__init_equips()
		local var_27_0 = #self._equip_content
		local var_27_1

		for iter_27_0 = 1, #self._equip_content do
			self._equip_content[iter_27_0].nil_bg:SetActive(false)
			self._equip_content[iter_27_0].add_equip:SetActive(false)
			self._equip_content[iter_27_0].equipment:SetActive(false)
		end

		var_27_1 = (self._enter_type == var_0_3.enter_ship_detail_type.abyss_synthesis_explain or self._enter_type == var_0_3.enter_ship_detail_type.abyss_remake) and self._data.equipment or self._data.equips

		for iter_27_1 = #var_27_1 + 1, var_27_0 do
			self._equip_content[iter_27_1].nil_bg:SetActive(true)
		end

		for iter_27_2, iter_27_3 in ipairs(var_27_1) do
			self._equip_content[iter_27_2].equipment.change_btn.clickAndLongClickAndPointerUpEvent.onClick:RemoveAllListeners()

			if iter_27_3.carry_type then
				self._equip_content[iter_27_2].add_equip:SetActive(iter_27_3.id == 0)
				self._equip_content[iter_27_2].equipment:SetActive(iter_27_3.id ~= 0)

				if iter_27_3.id ~= 0 then
					local var_27_2 = var_0_8.find_object_by_cid(iter_27_3.cid)

					self._equip_content[iter_27_2].equipment.equip_rarity.image.sprite = self:loadSprite(var_0_4(var_0_3.equip_back.equip_back_normal, var_27_2.star))
					self._equip_content[iter_27_2].equipment.equip_icon.image.sprite = self:loadSprite(var_0_4(var_0_3.equip_icon.large, var_27_2.pic_id))

					self._equip_content[iter_27_2].equipment.off_btn:SetActive(true)

					self._equip_content[iter_27_2].equipment.name_mask.equipname.text.text = var_27_2.title

					self._equip_content[iter_27_2].equipment.name_mask.textHorizonScroller:SetText(var_27_2.title)

					local var_27_3 = 0

					if iter_27_3.carry_type == var_0_3.equip_carry_type.plane then
						var_27_3 = self._now_ship_data.capacity_slot[iter_27_2]
					elseif iter_27_3.carry_type == var_0_3.equip_carry_type.missile then
						var_27_3 = self._now_ship_data.missile_slot[iter_27_2]
					end

					if var_27_3 ~= 0 then
						self._equip_content[iter_27_2].equipment.carry_num.text.text = iter_27_3.num .. "/" .. var_27_3
					end

					self._equip_content[iter_27_2].equipment.carry_num:SetActive(var_27_3 ~= 0)
				end
			else
				self._equip_content[iter_27_2].add_equip:SetActive(false)
				self._equip_content[iter_27_2].equipment:SetActive(true)

				local var_27_4 = var_0_8.find_object_by_cid(iter_27_3.id)

				if var_27_4 then
					self._equip_content[iter_27_2].equipment.name_mask.equipname.text.text = var_27_4.title

					self._equip_content[iter_27_2].equipment.name_mask.textHorizonScroller:SetText(var_27_4.title)

					self._equip_content[iter_27_2].equipment.equip_rarity.image.sprite = self:loadSprite(var_0_4(var_0_3.equip_back.equip_back_normal, var_27_4.star))
					self._equip_content[iter_27_2].equipment.equip_icon.image.sprite = self:loadSprite(var_0_4(var_0_3.equip_icon.large, var_27_4.pic_id))

					self._equip_content[iter_27_2].equipment.off_btn:SetActive(false)
				end
			end
		end
	end

	function arg_1_0:__get_equip_data(arg_28_1)
		if not self._data.equips[arg_28_1] then
			return nil
		end

		return (var_0_8.find_object_by_cid(type(self._data.equips[arg_28_1]) ~= "number" and (self._data.equips[arg_28_1].id or self._data.equips[arg_28_1].cid) or self._data.equips[arg_28_1]))
	end

	function arg_1_0:__show_equip_att(arg_29_1, arg_29_2)
		self._equip_attr = self._equip_attr or self:loadUI("equip_attr")

		self:__show_equip_attr_panel(true)

		local var_29_1 = self:__get_equip_data(arg_29_2)

		self._equip_attr._panel.transform:SetParent(arg_29_1.rectTransform, false)

		self._equip_attr._panel.transform.anchoredPosition = var_0_14.New(-163, 49)

		if var_29_1 then
			self._equip_attr:show(var_29_1)
		end
	end

	function arg_1_0:__show_equip_attr_panel(arg_30_1)
		if not self._equip_attr then
			return
		end

		self._control.tip_layer:SetActive(arg_30_1)
		self._equip_attr:setVisible(arg_30_1)
	end

	function arg_1_0:play_mall_anim(arg_31_1)
		local var_31_0 = self:autoKillDOTween(var_0_20.Sequence())

		var_31_0:Append(self._control.left.rectTransform:DOLocalMove(var_0_14.New(-1440, 0), 0)):SetEase(DG.Tweening.Ease.Linear)
		var_31_0:Join(self._control.left.rectTransform:DOLocalMove(var_0_14.New(-590, 0), 0.3)):SetEase(DG.Tweening.Ease.Linear)

		if arg_31_1 then
			var_31_0:PlayForward()
		else
			var_31_0:PlayBackwards()
		end
	end

	function arg_1_0:__get_now_skin_index()
		if self._data and self._data.skin ~= 0 and self._now_ship_data ~= nil then
			for iter_32_0, iter_32_1 in pairs(self._now_ship_data.skins) do
				if self._data.skin == iter_32_1 then
					break
				end
			end
		end
	end

	function arg_1_0:__show_role_icon()
		if self._data then
			if self._data.skin == 0 and self._now_ship_data ~= nil then
				self:show_ship_icon(self._now_ship_data.pic_id)
			else
				local var_33_0 = self:__get_skin_cfg(self._data.skin)

				if var_33_0 then
					self:show_ship_icon(var_33_0.icon)
				end
			end
		elseif self._now_ship_data ~= nil then
			self:show_ship_icon(self._now_ship_data.pic_id)
		end
	end

	function arg_1_0:__onReset()
		self._control.left.ship_role.transform.localScale = Vector3.New(1, 1, 1)
		self._is_already_init = false
		self._now_ship_data = {}
		self._now_character_data = nil
		self._is_single = false
		self._is_team = false
		self._index = nil
		self._members = {}
		self._now_paint_sprite = nil
		self._equip_content = {}
		self._data = {}
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_35_0)
	local var_35_0 = var_0_2:class("abyss_ship_detail")

	var_35_0._is_already_init = false
	var_35_0._enter_type = nil
	var_35_0._data = {}
	var_35_0._now_ship_data = {}
	var_35_0._now_character_data = nil
	var_35_0._is_single = false
	var_35_0._is_team = false
	var_35_0._index = nil
	var_35_0._members = {}
	var_35_0._now_paint_sprite = nil
	var_35_0._equip_content = {}

	return var_35_0
end

return var_0_0
