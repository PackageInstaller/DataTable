local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = string.format
local var_0_5 = table.insert
local var_0_6 = gameenum.common_type
local var_0_7 = gameconfig.equip_config
local var_0_8 = gameconfig.ship_config
local var_0_9 = gameconfig.workshop_config
local var_0_10 = gamecore.util_func
local var_0_11 = {
	tog_three = "tog_three",
	tog_four = "tog_four",
	tog_one = "tog_one",
	tog_two = "tog_two"
}

gamecore.UILoader:define("equip_record", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__init_panel(arg_2_1)
	end

	function arg_1_0:use_equip_recore()
		self:setVisible(false)

		local var_3_0 = var_0_2:getInstance("ship_detail")

		if var_3_0 then
			var_3_0:setVisible(true)
			var_3_0:update_data()
		end
	end

	function arg_1_0:update_data()
		if self._data then
			self._data = var_0_3:find_character_by_id(self._data.id)

			self:__set_current_data(self._now_label)
		end
	end

	function arg_1_0:__init_panel(arg_5_1)
		self._data = arg_5_1

		self:__init_title_name()
		self:__set_ship()
		self:__init_select()

		self._control.bg_container.ship_hint_txt.text.text = var_0_1:getNowLang(var_0_4(var_0_6.help_info_language.help_info_1401, (lan_rand(1, 5))))
	end

	function arg_1_0:__init_title_name()
		if self._already_init then
			return
		end

		self._control.bg_container.title.text.text = var_0_1:getNowLang("ui_equip_record")

		self:__init_detail_attr_title()
		self:__init_ship_detail_content()

		self._control.content.content.toggle_group.tog_one.title.text.text = "I"
		self._control.content.content.toggle_group.tog_two.title.text.text = "II"
		self._control.content.content.toggle_group.tog_three.title.text.text = "III"
		self._control.content.content.toggle_group.tog_four.title.text.text = "IV"
		self._control.content.content.record_btn.title.text.text = var_0_1:getNowLang("logrecord")
		self._control.content.content.use_btn.title.text.text = var_0_1:getNowLang("loguse")
		self._equip_content = {
			self._control.content.content.equips.equip_1,
			self._control.content.content.equips.equip_2,
			self._control.content.content.equips.equip_3,
			self._control.content.content.equips.equip_4
		}
		self._already_init = true
	end

	function arg_1_0:__init_detail_attr_title()
		self._control.content.content.ship_detail.attr_1.title.text.text = var_0_1:getNowLang("hp")
		self._control.content.content.ship_detail.attr_2.title.text.text = var_0_1:getNowLang("def")
		self._control.content.content.ship_detail.attr_3.title.text.text = var_0_1:getNowLang("miss")
		self._control.content.content.ship_detail.attr_4.title.text.text = var_0_1:getNowLang("capacity")
		self._control.content.content.ship_detail.attr_5.title.text.text = var_0_1:getNowLang("speed")
		self._control.content.content.ship_detail.attr_6.title.text.text = var_0_1:getNowLang("range")
		self._control.content.content.ship_detail.attr_7.title.text.text = var_0_1:getNowLang("atk")
		self._control.content.content.ship_detail.attr_8.title.text.text = var_0_1:getNowLang("torpedo")
		self._control.content.content.ship_detail.attr_9.title.text.text = var_0_1:getNowLang("airdef")
		self._control.content.content.ship_detail.attr_10.title.text.text = var_0_1:getNowLang("antisub")
		self._control.content.content.ship_detail.attr_11.title.text.text = var_0_1:getNowLang("radar")
		self._control.content.content.ship_detail.attr_12.title.text.text = var_0_1:getNowLang("luck")
	end

	function arg_1_0:__init_ship_detail_content()
		self._detail_attr_content = {
			hp = self._control.content.content.ship_detail.attr_1,
			def = self._control.content.content.ship_detail.attr_2,
			miss = self._control.content.content.ship_detail.attr_3,
			capacity = self._control.content.content.ship_detail.attr_4,
			speed = self._control.content.content.ship_detail.attr_5,
			range = self._control.content.content.ship_detail.attr_6,
			atk = self._control.content.content.ship_detail.attr_7,
			torpedo = self._control.content.content.ship_detail.attr_8,
			air_def = self._control.content.content.ship_detail.attr_9,
			antisub = self._control.content.content.ship_detail.attr_10,
			radar = self._control.content.content.ship_detail.attr_11,
			luck = self._control.content.content.ship_detail.attr_12
		}
	end

	function arg_1_0:__workshop_add(arg_9_1)
		local var_9_0 = var_0_8.find_object_by_cid(var_0_3:find_character_by_id(self._data.id).cid)

		for iter_9_0, iter_9_1 in pairs((var_0_3:get_workshop_data())) do
			local var_9_1 = var_0_9.find_object_by_id(iter_9_1.id).effect[1]

			if var_9_1.shipTypes then
				for iter_9_2, iter_9_3 in pairs(var_9_1.shipTypes) do
					if var_9_1.shipTypes and var_9_1.shipTypes[iter_9_2] == var_9_0.type then
						local var_9_2 = var_0_6:get_attr_name(var_9_1.num4)

						if var_9_1.type == var_0_6.workshop_const.work_type.add_attribute then
							if var_9_1.countrys then
								for iter_9_4, iter_9_5 in pairs(var_9_1.countrys) do
									if iter_9_5 == var_9_0.country and arg_9_1[var_9_2] then
										arg_9_1[var_9_2] = arg_9_1[var_9_2] + var_9_1.num
									end
								end
							else
								arg_9_1[var_9_2] = arg_9_1[var_9_2] + var_9_1.num
							end
						elseif var_9_1.type == var_0_6.workshop_const.work_type.add_torpedo_damage and var_9_0[var_9_2] ~= 0 and arg_9_1[var_9_2] then
							arg_9_1[var_9_2] = arg_9_1[var_9_2] + var_9_1.num
						end
					end
				end
			end
		end
	end

	function arg_1_0:__set_ship_detail()
		self._control.content.content.ship_detail.attr_4.attr_num.text.text = self._data.capacity
		self._control.content.content.ship_detail.attr_5.attr_num.text.text = self._data.speed

		local var_10_0, var_10_1 = self:get_ship_attr(self._data, (var_0_8.find_object_by_cid(self._data.cid)))

		self:__workshop_add(var_10_1)

		self._attrs_no_equips = var_10_1

		for iter_10_0, iter_10_1 in pairs(var_10_1) do
			if self._detail_attr_content[iter_10_0] then
				if iter_10_0 == "range" then
					self._detail_attr_content[iter_10_0].attr_num.text.text = var_0_6:get_shoot_type_name(iter_10_1)
				elseif iter_10_0 == "speed" then
					local var_10_2, var_10_3 = math.modf(iter_10_1)

					self._detail_attr_content[iter_10_0].attr_num.text.text = var_10_3 < 0.1 and var_10_2 .. var_0_1:getNowLang("speedtext") or string.format("%.1f", iter_10_1) .. var_0_1:getNowLang("speedtext")
				else
					var_10_1[iter_10_0] = math.floor(iter_10_1)
					self._detail_attr_content[iter_10_0].attr_num.text.text = iter_10_1
				end

				self._detail_attr_content[iter_10_0].attr_num.text.color = Color.New(0.23921568627450981, 0.615686274509804, 0.996078431372549)
			end
		end

		for iter_10_2, iter_10_3 in pairs((self:__get_attribute_by_equips())) do
			if self._detail_attr_content[iter_10_2] then
				if iter_10_2 == "range" then
					if iter_10_3 ~= 0 then
						self._detail_attr_content[iter_10_2].attr_num.text.text = var_0_6:get_shoot_type_name(iter_10_3)
					end

					self._detail_attr_content[iter_10_2].frame.image.sprite = self:loadSprite(var_0_6.ship_detail_equip_record.frame_data_gray)
				elseif iter_10_2 == "speed" then
					local var_10_4, var_10_5 = math.modf(var_10_1[iter_10_2])

					self._detail_attr_content[iter_10_2].attr_num.text.text = var_10_5 < 0.1 and var_10_4 .. var_0_1:getNowLang("speedtext") or string.format("%.1f", var_10_1[iter_10_2]) .. var_0_1:getNowLang("speedtext")
				else
					self._detail_attr_content[iter_10_2].attr_num.text.text = iter_10_3 + var_10_1[iter_10_2]
				end

				self._detail_attr_content[iter_10_2].attr_bg:SetActive(iter_10_3 ~= 0 and iter_10_2 ~= "range")

				if iter_10_3 > 0 and iter_10_2 ~= "range" then
					self._detail_attr_content[iter_10_2].frame.image.sprite = self:loadSprite(var_0_6.ship_detail_equip_record.frame_data_blue)
					self._detail_attr_content[iter_10_2].attr_bg.image.sprite = self:loadSprite(var_0_6.ship_detail_equip_record.bg_data_blud)
					self._detail_attr_content[iter_10_2].attr_num.text.color = Color.New(1, 1, 1)
					self._detail_attr_content[iter_10_2].attr_change_num.text.color = Color.New(0.23921568627450981, 0.615686274509804, 0.996078431372549)
					self._detail_attr_content[iter_10_2].attr_change_num.text.text = "+" .. iter_10_3

					self._detail_attr_content[iter_10_2].attr_change_num:SetActive(true)
				elseif iter_10_3 < 0 and iter_10_2 ~= "range" then
					self._detail_attr_content[iter_10_2].frame.image.sprite = self:loadSprite(var_0_6.ship_detail_equip_record.frame_data_red)
					self._detail_attr_content[iter_10_2].attr_bg.image.sprite = self:loadSprite(var_0_6.ship_detail_equip_record.bg_data_red)
					self._detail_attr_content[iter_10_2].attr_change_num.text.text = iter_10_3
					self._detail_attr_content[iter_10_2].attr_num.text.color = Color.New(1, 1, 1)
					self._detail_attr_content[iter_10_2].attr_change_num.text.color = Color.New(0.9450980392156862, 0.3764705882352941, 0.3058823529411765)

					self._detail_attr_content[iter_10_2].attr_change_num:SetActive(true)
				elseif iter_10_3 == 0 then
					self._detail_attr_content[iter_10_2].frame.image.sprite = self:loadSprite(var_0_6.ship_detail_equip_record.frame_data_gray)
					self._detail_attr_content[iter_10_2].attr_num.text.color = Color.New(0.23921568627450981, 0.615686274509804, 0.996078431372549)

					self._detail_attr_content[iter_10_2].attr_change_num:SetActive(false)
				end
			end
		end
	end

	function arg_1_0:__set_ship()
		if not self._data then
			return
		end

		if not self._single_ship then
			local var_11_0 = self:loadUI("single_ship")

			var_11_0._panel.transform:SetParent(self._control.content.ship_layer.rectTransform, false)

			var_11_0._panel.transform.anchoredPosition = Vector2.zero
			self._single_ship = var_11_0
		end

		self._single_ship:show(self._data)
		self._single_ship:no_click_event(true)
	end

	function arg_1_0:__init_equips()
		for iter_12_0 = 1, #self._equip_content do
			self._equip_content[iter_12_0].add_equip:SetActive(true)
			self._equip_content[iter_12_0].equipment:SetActive(false)
		end

		for iter_12_1 = #self._now_record.equips + 1, #self._equip_content do
			self._equip_content[iter_12_1].name_mask.equipname.text.text = "--"

			self._equip_content[iter_12_1].name_mask.textHorizonScroller:SetText("--")
		end

		for iter_12_2, iter_12_3 in ipairs(self._now_record.equips) do
			self._equip_content[iter_12_2].add_equip:SetActive(iter_12_3 == 0)
			self._equip_content[iter_12_2].equipment:SetActive(iter_12_3 ~= 0)

			if iter_12_3 ~= 0 then
				local var_12_0 = var_0_7.find_object_by_cid(iter_12_3)

				self._equip_content[iter_12_2].equipment.equip_rarity.image.sprite = self:loadSprite(var_0_4(var_0_6.equip_back.equip_back_normal, var_12_0.star))
				self._equip_content[iter_12_2].equipment.equip_icon.image.sprite = self:loadSprite(var_0_4(var_0_6.equip_icon.large, var_12_0.pic_id))
				self._equip_content[iter_12_2].name_mask.equipname.text.text = var_12_0.title

				self._equip_content[iter_12_2].name_mask.textHorizonScroller:SetText(var_12_0.title)
			else
				self._equip_content[iter_12_2].name_mask.equipname.text.text = "--"

				self._equip_content[iter_12_2].name_mask.textHorizonScroller:SetText("--")
			end
		end

		self:__set_ship_detail()
	end

	function arg_1_0:__init_select()
		if self._now_content then
			self._now_content.toggle.isOn = false
		end

		self:__select_one("tog_one")

		self._now_content.toggle.isOn = true
	end

	function arg_1_0:__select_one(arg_14_1)
		if self._now_label == arg_14_1 then
			return
		end

		self._now_label = arg_14_1

		self:__set_current_data(arg_14_1)
	end

	function arg_1_0:__set_current_data(arg_15_1)
		if arg_15_1 == var_0_11.tog_one then
			self._now_content = self._control.content.content.toggle_group.tog_one
			self._now_record = self._data.record[1]
		elseif arg_15_1 == var_0_11.tog_two then
			self._now_content = self._control.content.content.toggle_group.tog_two
			self._now_record = self._data.record[2]
		elseif arg_15_1 == var_0_11.tog_three then
			self._now_content = self._control.content.content.toggle_group.tog_three
			self._now_record = self._data.record[3]
		elseif arg_15_1 == var_0_11.tog_four then
			self._now_content = self._control.content.content.toggle_group.tog_four

			if self._data.record and #self._data.record == 3 then
				var_0_5(self._data.record, {
					index = 4,
					equips = {}
				})
			end

			self._now_record = self._data.record[4]
		end

		self:__init_equips()
	end

	function arg_1_0:__get_attribute_by_equips()
		local var_16_0 = {}

		for iter_16_0, iter_16_1 in pairs(self._attrs_no_equips) do
			var_16_0[iter_16_0] = 0
		end

		for iter_16_2, iter_16_3 in pairs(self._now_record.equips) do
			local var_16_1 = var_0_7.find_object_by_cid(iter_16_3)

			if var_16_1 then
				for iter_16_4, iter_16_5 in pairs(var_0_6.equip_attribute) do
					if iter_16_5 == "range" then
						if var_16_1[iter_16_5] > var_16_0[iter_16_5] then
							var_16_0[iter_16_5] = var_16_1[iter_16_5] or var_16_0[iter_16_5]
						end
					else
						var_16_0[iter_16_5] = var_16_0[iter_16_5] or 0
						var_16_0[iter_16_5] = var_16_0[iter_16_5] + var_16_1[iter_16_5]
					end
				end

				if next(var_16_1.exclusive_cid) then
					for iter_16_6, iter_16_7 in pairs(var_16_1.exclusive_cid) do
						if self._data.cid == iter_16_7 and next(var_16_1.exclusive_buff) then
							for iter_16_8, iter_16_9 in pairs(var_16_1.exclusive_buff) do
								if iter_16_9.num4 and iter_16_9.type == 1 then
									local var_16_2 = var_0_6:get_attr_name(iter_16_9.type)

									if var_16_0[var_16_2] then
										var_16_0[var_16_2] = var_16_0[var_16_2] + iter_16_9.num
									end
								end
							end
						end
					end
				end
			end
		end

		return var_16_0
	end

	function arg_1_0:_play_into_se(arg_17_1)
		self:playSE(arg_17_1, false)
	end

	function arg_1_0:get_ship_attr(arg_18_1, arg_18_2)
		local var_18_0 = {
			"hp",
			"atk",
			"def",
			"torpedo",
			"miss",
			"air_def",
			nil,
			nil,
			"antisub",
			"speed",
			"radar",
			"range",
			"luck",
			"hit_repair",
			"miss_repair",
			"crit_repair",
			"hit",
			"now_hp",
			"ext"
		}
		local var_18_1
		local var_18_2

		if not arg_18_2 then
			for iter_18_0, iter_18_1 in pairs(arg_18_1.equips) do
				local var_18_4 = gameconfig.equip_config.find_object_by_cid(iter_18_1)
			end

			var_18_1 = arg_18_1 and var_0_10.little_clone(arg_18_1) or {}
		elseif tonumber(string.sub(arg_18_1.cid, 7)) == 18 then
			local var_18_8 = gamecore.user:get_abyss_character_attribute_by_calculate(arg_18_1.id)

			var_18_1 = var_18_8 and var_0_10.little_clone(var_18_8) or {}

			local var_18_9 = gamecore.user:get_abyss_character_attribute_by_calculate_no_equips(arg_18_1.id)

			var_18_2 = var_18_9 and var_0_10.little_clone(var_18_9) or {}
		else
			local var_18_10 = gamecore.user:get_attribute_effect_by_equip(arg_18_1.id)
			local var_18_11 = var_18_10 and var_0_10.little_clone(var_18_10) or {}
			local var_18_12 = gamecore.user:get_character_attribute_by_calculate(arg_18_1.id)

			var_18_1 = var_18_12 and var_0_10.little_clone(var_18_12) or {}

			local var_18_13 = gamecore.user:get_character_attribute_by_calculate_no_equips(arg_18_1.id)

			var_18_2 = var_18_13 and var_0_10.little_clone(var_18_13) or {}
		end

		for iter_18_2, iter_18_3 in pairs(var_18_0) do
			if var_18_1 and not var_18_1[iter_18_3] then
				var_18_1[iter_18_3] = 0
			end
		end

		if arg_18_2 then
			local var_18_14 = arg_18_2

			for iter_18_4, iter_18_5 in pairs((gamecore.user:get_player_desk_collection_data())) do
				local var_18_15 = gameconfig.item_config.find_object_by_cid(iter_18_5.id)

				if var_18_15 and tonumber(arg_18_2.cid) % 100 ~= 18 then
					if var_0_10:match_collection_ship_type(var_18_15.buff_effect.ship_type, var_18_14.type) and (var_18_15.buff_effect.country == 0 or var_18_15.buff_effect.country == var_18_14.country) then
						if var_18_1 then
							var_18_1[var_18_15.buff_effect.attr] = (var_18_1[var_18_15.buff_effect.attr] or 0) + var_18_15.buff_effect.val
						end

						if var_18_2 then
							var_18_2[var_18_15.buff_effect.attr] = (var_18_2[var_18_15.buff_effect.attr] or 0) + var_18_15.buff_effect.val
						end
					end
				end
			end

			local var_18_18 = gamecore.user:get_restaurant_cookbook_buff()

			if var_18_18 and tonumber(arg_18_2.cid) % 100 ~= 18 and tonumber(arg_18_2.cid) % 100 ~= 19 and lx.ServerTime:getUtcTime() < var_18_18.end_time then
				local var_18_19 = gameconfig.cook_book_config.find_object_by_cid(var_18_18.id)
				local var_18_20 = var_18_19.effect.attr

				if var_18_1[var_18_19.effect.attr] and var_18_18.end_time >= lx.ServerTime:getUtcTime() and (var_18_19.effect.type == 5 or var_18_19.effect.type == 6) then
					local var_18_22 = var_18_19.effect.country or 0
					local var_18_23 = var_18_19.effect.ship_type or 0
					local var_18_24 = var_18_19.effect.ship_ton or 0

					if (var_18_23 == 0 or var_18_23 == var_18_14.type) and (var_18_22 == 0 or var_18_22 == var_18_14.country) and (var_18_24 == 0 or var_18_24 == var_18_14.ship_ton) then
						var_18_1[var_18_20] = var_18_1[var_18_20] + var_18_19.effect.value
					end
				end
			end

			local var_18_25 = gamecore.user:get_dormitory_race_buff()

			if var_18_25 and tonumber(arg_18_2.cid) % 100 ~= 18 and tonumber(arg_18_2.cid) % 100 ~= 19 and lx.ServerTime:getUtcTime() < var_18_25.end_time then
				local var_18_26 = gameconfig.furniture_config.find_object_by_cid(var_18_25.id).buff
				local var_18_27 = var_18_26.ship_type or 0
				local var_18_28 = var_18_26.shipTon or 0
				local var_18_29 = gameenum.common_type:get_attr_name(var_18_26.num4)

				if var_18_26.type == 1 and (var_18_27 == 0 or var_18_27 == var_18_14.type) and (var_18_25.country == 0 or var_18_25.country == var_18_14.country) and (var_18_28 == 0 or var_18_28 == var_18_14.ship_ton) then
					var_18_1[var_18_29] = var_18_1[var_18_29] + var_18_26.num
				end
			end

			local var_18_30 = gamecore.user:get_workshop_data()

			if next(var_18_30) and tonumber(arg_18_2.cid) % 100 ~= 18 and tonumber(arg_18_2.cid) % 100 ~= 19 then
				for iter_18_6, iter_18_7 in pairs(var_18_30) do
					local var_18_31 = gameconfig.workshop_config.find_object_by_id(iter_18_7.id).effect[1]

					if var_18_31.shipTypes then
						for iter_18_8, iter_18_9 in pairs(var_18_31.shipTypes) do
							if var_18_31.shipTypes[iter_18_8] == var_18_14.type then
								local var_18_32 = gameenum.common_type:get_attr_name(var_18_31.num4)

								if var_18_31.type == gameenum.common_type.workshop_const.work_type.add_attribute then
									if var_18_31.countrys then
										for iter_18_10, iter_18_11 in pairs(var_18_31.countrys) do
											if iter_18_11 == var_18_14.country and var_18_1[var_18_32] then
												var_18_1[var_18_32] = var_18_1[var_18_32] + var_18_31.num
											end
										end
									elseif var_18_1[var_18_32] then
										var_18_1[var_18_32] = var_18_1[var_18_32] + var_18_31.num
									end
								elseif var_18_31.type == gameenum.common_type.workshop_const.work_type.add_torpedo_damage and var_18_14[var_18_32] ~= 0 and var_18_1[var_18_32] then
									var_18_1[var_18_32] = var_18_1[var_18_32] + var_18_31.num
								end
							end
						end
					end
				end
			end

			local var_18_33 = not arg_18_1.now_skill and gameconfig.skill_config.find_object_by_skill_id(arg_18_1.skill_id) or gameconfig.skill_config.find_object_by_skill_type_skill_level(arg_18_1.now_skill, arg_18_1.skill_level)
			local var_18_34
			local var_18_35

			if var_18_33 and var_18_33.effect[1] then
				for iter_18_12, iter_18_13 in pairs(var_18_33.effect) do
					if var_18_33.effect[iter_18_12].type == 1 and var_18_33.effect[iter_18_12].stage[1] == 1 then
						for iter_18_14, iter_18_15 in pairs(var_18_33.effect[iter_18_12].effect) do
							if iter_18_15.type == 3 then
								for iter_18_16, iter_18_17 in pairs(var_18_0) do
									if iter_18_15[var_18_0[iter_18_16]] then
										var_18_34 = var_18_0[iter_18_16]
										var_18_35 = iter_18_15[var_18_0[iter_18_16]]
									end
								end

								if var_18_34 and var_18_35 and var_18_1[var_18_34] then
									var_18_35 = var_18_35 * self:get_attr_multiple_by_config(var_18_33, arg_18_1, iter_18_12)
									var_18_1[var_18_34] = var_18_1[var_18_34] + var_18_35
									var_18_2[var_18_34] = var_18_2[var_18_34] + var_18_35
								end
							elseif iter_18_15.type == 4 then
								for iter_18_18, iter_18_19 in pairs(iter_18_15) do
									if iter_18_18 ~= "type" then
										var_18_1[iter_18_18] = var_18_1[iter_18_18] or 1
										var_18_1[iter_18_18] = var_18_1[iter_18_18] + var_18_1[iter_18_18] * iter_18_19
										var_18_2[iter_18_18] = var_18_2[iter_18_18] or 1
										var_18_2[iter_18_18] = var_18_2[iter_18_18] + var_18_2[iter_18_18] * iter_18_19
									end
								end
							elseif iter_18_15.type == 5 then
								if var_18_1[var_18_0[iter_18_15.attribute]] and var_18_1[var_18_0[iter_18_15.attribute2]] then
									var_18_1[var_18_0[iter_18_15.attribute2]] = var_18_1[var_18_0[iter_18_15.attribute2]] + var_18_1[var_18_0[iter_18_15.attribute]] * iter_18_15.rate
								end

								if var_18_2[var_18_0[iter_18_15.attribute]] and var_18_2[var_18_0[iter_18_15.attribute2]] then
									var_18_2[var_18_0[iter_18_15.attribute2]] = var_18_2[var_18_0[iter_18_15.attribute2]] + var_18_2[var_18_0[iter_18_15.attribute]] * iter_18_15.rate
								end
							elseif iter_18_15.type == 94 then
								if var_18_1.range >= iter_18_15.num then
									var_18_1.range = var_18_1.range or iter_18_15.num
								end

								if var_18_2.range >= iter_18_15.num then
									var_18_2.range = var_18_2.range or iter_18_15.num
								end
							elseif iter_18_15.type == 49 then
								break
							elseif iter_18_15.type == 50 then
								break
							elseif iter_18_15.type == 51 then
								break
							elseif iter_18_15.type == 52 then
								break
							elseif iter_18_15.type == 54 then
								break
							elseif iter_18_15.type == 131 then
								local var_18_37

								if var_18_2[var_18_0[iter_18_15.attribute]] then
									var_18_37 = self:attr_impact_by_speed(var_18_2.speed, var_18_2[var_18_0[iter_18_15.attribute]], iter_18_15.num1, iter_18_15.num2) - var_18_2[var_18_0[iter_18_15.attribute]]
								end

								if var_18_37 then
									var_18_1[var_18_0[iter_18_15.attribute]] = var_18_1[var_18_0[iter_18_15.attribute]] + var_18_37
								end
							end
						end
					end
				end
			end
		end

		return var_18_1, var_18_2
	end

	function arg_1_0.get_attr_multiple_by_config(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
		local var_19_0 = 1

		if not arg_19_1.effect[arg_19_3].condition then
			return 1
		end

		for iter_19_0, iter_19_1 in pairs(arg_19_1.effect[arg_19_3].condition) do
			if iter_19_1.type == gameenum.common_type.ship_detail_const.ships_count_of_map_mul_effect then
				local var_19_2 = {}

				for iter_19_2, iter_19_3 in pairs((gamecore.user:get_cardbook_ship_list())) do
					for iter_19_4, iter_19_5 in pairs(iter_19_1.shipCids) do
						if iter_19_3.id == iter_19_5 then
							table.insert(var_19_2, iter_19_5)
						end
					end
				end

				var_19_0 = #var_19_2
			elseif iter_19_1.type == gameenum.common_type.ship_detail_const.gofight_count_div_num_mul_effect then
				local var_19_3 = gamecore.user:get_user_info().map_total / iter_19_1.num

				var_19_3 = var_19_3 > 1 and 1 or var_19_3
				var_19_0 = var_19_3
			elseif iter_19_1.type == gameenum.common_type.ship_detail_const.level_div_num_mul_effect then
				var_19_0 = math.floor(arg_19_2.level / iter_19_1.num)
			end
		end

		return var_19_0
	end

	function arg_1_0.attr_impact_by_speed(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
		if not arg_20_1 then
			return arg_20_2
		end

		arg_20_3 = arg_20_3 or 0
		arg_20_4 = arg_20_4 or 0

		return math.floor(arg_20_2 * (1 + ((arg_20_1 < 12.2 or nil) and arg_20_3 + (12.2 - arg_20_1) * (arg_20_4 - arg_20_3) / 12.2)))
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_21_0)
	local var_21_0 = var_0_2:class("equip_record")

	var_21_0._already_init = false
	var_21_0._now_label = nil
	var_21_0._now_content = nil
	var_21_0._now_record = nil
	var_21_0._attrs_no_equips = nil
	var_21_0._detail_attr_content = {}
	var_21_0._single_ship = nil
	var_21_0._data = nil

	return var_21_0
end

return var_0_0
