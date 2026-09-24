local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = gameconfig.ship_config
local var_0_6 = string.format
local var_0_7 = gameconfig.skin_config
local var_0_8 = gameconfig.equip_config
local var_0_9 = gameconfig.furniture_config
local var_0_10 = gameconfig.item_config
local var_0_11 = gameconfig.cook_book_config
local var_0_12 = DG.Tweening.DOTween
local var_0_13 = math.modf
local var_0_14 = Vector3.zero
local var_0_15 = string.lower
local var_0_16 = gameconfig.tactics_config
local var_0_18 = {
	bullet = 1,
	oil = 2
}
local var_0_19 = gamecore.util_func
local var_0_20 = math.floor

gamecore.UILoader:define("single_ship", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3)
		self:setVisible(true)

		self._tab_type = arg_2_2 or var_0_4.dock_team_toggle_type.formation
		self._no_click_event = false

		self:__init_panel(arg_2_1, arg_2_2, arg_2_3)
	end

	function arg_1_0:refresh()
		self._last_data = self._data and var_0_19.little_clone(self._data) or {}

		local var_3_0 = var_0_1:find_character_by_id(self._data.id)

		self._data = var_3_0 and var_0_19.little_clone(var_3_0) or {}

		self:__set_supply_type_layer(true)
		self:__set_shell()
	end

	function arg_1_0:set_main(arg_4_1)
		if arg_4_1 == false then
			self._control.BG.flag_ship:SetActive(false)
		elseif self._data then
			self._control.BG.flag_ship:SetActive(true)
		else
			self._control.BG.flag_ship:SetActive(false)
		end
	end

	function arg_1_0:get_data()
		return self._data
	end

	function arg_1_0:get_need_supply()
		return self._need_supply
	end

	function arg_1_0:set_active_rankable_layout_item(arg_7_1)
		self._control.BG.all_layer.drag_layer.rankableLayoutItem.dragable = arg_7_1
	end

	function arg_1_0.no_click_event(arg_8_0, arg_8_1)
		arg_8_0._no_click_event = arg_8_1
	end

	function arg_1_0:show_tactic(arg_9_1)
		self:__show_tactic_anim(arg_9_1)
	end

	function arg_1_0:__init_panel(arg_10_1, arg_10_2, arg_10_3)
		self._data = arg_10_1 and var_0_19.little_clone(arg_10_1) or {}
		self._index = arg_10_3

		self._control.BG.all_layer.tactic_layer:SetActive(false)

		if next(self._data) then
			self._control.BG.flag_ship:SetActive(false)
			self._control.BG.all_layer:SetActive(true)

			local var_10_1 = var_0_5.find_object_by_cid(self._data.cid)

			self._ship_config = var_10_1

			self:__set_shell()

			local var_10_2 = self:__set_tab_type(arg_10_2, var_10_1)

			self._data.hp = var_10_2.hp_max

			local var_10_3 = var_0_19:use_big_break_painting(self._data, var_0_4.ship_icon_type.model_m, true)
			local var_10_4 = var_0_7.find_object_by_cid(self._data.skin) or nil

			self._control.BG.all_layer.icon_layer.icon.image.sprite = self:loadSprite(self._data.skin ~= 0 and var_10_4 and var_0_4:get_ship_icon(var_10_3, var_10_4.icon, var_10_4.icon) or var_0_4:get_ship_icon(var_10_3, tostring(self._ship_config.pic_id), tostring(self._ship_config.pic_id)))
			self._control.BG.all_layer.icon_layer.image.sprite = self:loadSprite(var_0_4.ship_quality_frame[self._data.star])
			self._control.BG.all_layer.level_layer.type_txt.text.text = var_0_2:getNowLang(var_0_4:get_ship_type_language_key(var_10_2.type, 1))
			self._control.BG.all_layer.level_layer.country_txt.text.text = var_0_6("(%s)", var_0_2:getNowLang(var_0_4:get_country_language_key(var_10_2.country)))
			self._control.BG.all_layer.level_layer.lock_tag.image.sprite = self._data.lock and self:loadSprite(var_0_4.ship_lock.ship_lock_l) or self:loadSprite(var_0_4.ship_unlock.ship_unlock_l)

			self._control.BG.all_layer.level_layer.ship_remake:SetActive(var_10_2.evo_class)

			if self:_is_ship_custom(self._data.id) then
				self._control.BG.all_layer.level_layer.ship_custom:SetActive(true)
			else
				self._control.BG.all_layer.level_layer.ship_custom:SetActive(false)
			end

			self._control.BG.all_layer.love_layer.love.image.sprite = self:loadSprite(var_0_4:get_love_path(self._data))

			self:__set_level()

			self._control.BG.all_layer.hp_layer.hp_num.text.text = var_0_6("%d/%d", self._data.now_hp, var_10_2.hp_max)

			local var_10_5 = var_0_4.ship_hp_slider.ship_hp_l_green
			local var_10_6 = self._data.now_hp / var_10_2.hp_max

			if self._data.now_hp / var_10_2.hp_max >= 0.25 and var_10_6 < 0.5 then
				var_10_5 = var_0_4.ship_hp_slider.ship_hp_l_yellow
			elseif var_10_6 < 0.25 then
				var_10_5 = var_0_4.ship_hp_slider.ship_hp_l_red
			end

			self._data.hp = var_10_2.hp_max
			self._control.BG.all_layer.hp_layer.full_img.image.sprite = self:loadSprite(var_10_5)
			self._control.BG.all_layer.hp_layer.full_img.image.fillAmount = var_10_6

			self._control.BG.all_layer.repair_layer:SetActive(self._data.state == var_0_4.ship_state.repair)
			self._control.BG.all_layer.stationed_layer:SetActive(var_0_1:is_character_station_state(self._data.id))

			if self._data.state == var_0_4.ship_state.repair then
				self._control.BG.all_layer.repair_layer.repair_txt.text.text = var_0_2:getNowLang("inrepair")
			end

			self._control.BG.all_layer.stationed_layer.stationed_txt.text.text = var_0_2:getNowLang("inguard")
		end
	end

	function arg_1_0._is_ship_custom(arg_11_0, arg_11_1)
		local var_11_0 = false
		local var_11_1 = var_0_1:get_custom_ship_list()

		if var_11_1 and next(var_11_1) then
			for iter_11_0, iter_11_1 in ipairs(var_11_1) do
				if arg_11_1 == iter_11_1 then
					var_11_0 = true

					return true
				end
			end
		end

		return var_11_0
	end

	function arg_1_0:__set_level()
		self._control.BG.all_layer.level_layer.level_txt.text.text = var_0_6("Lv.%d", self._data.level)
		self._control.BG.all_layer.level_layer.level_txt.text.color = self._data.level < 110 and Color.New(1, 1, 1) or Color.New(0.996078431372549, 0.9882352941176471, 0)

		for iter_12_0 = 1, self._control.BG.all_layer.level_layer.star_layer.transform.childCount do
			if iter_12_0 <= self._data.star then
				self._control.BG.all_layer.level_layer.star_layer.transform:GetChild(iter_12_0 - 1).gameObject:SetActive(true)
			else
				self._control.BG.all_layer.level_layer.star_layer.transform:GetChild(iter_12_0 - 1).gameObject:SetActive(false)
			end
		end
	end

	function arg_1_0:__set_shell()
		self._equips_info = {
			num = 0,
			carry_type = 1
		}

		local var_13_0 = 0

		for iter_13_0, iter_13_1 in ipairs(self._data.equips) do
			if iter_13_1.carry_type and iter_13_1.carry_type > var_0_4.equip_carry_type.normal and self._tab_type == var_0_4.dock_team_toggle_type.supply then
				self._equips_info.carry_type = iter_13_1.carry_type
				self._equips_info.num = self._equips_info.num + iter_13_1.num

				if iter_13_1.carry_type == var_0_4.equip_carry_type.plane then
					local var_13_1 = self._ship_config.capacity_slot or self._ship_config.missile_slot

					if var_13_1 and next(var_13_1) and var_13_1[iter_13_0] then
						var_13_0 = var_13_0 + var_13_1[iter_13_0]
					end
				end
			end
		end

		self._config_count = var_13_0

		if self._equips_info.carry_type ~= var_0_4.equip_carry_type.normal then
			local var_13_2

			if self._equips_info.num / var_13_0 >= 0.5 then
				var_13_2 = var_0_4.dock_carry_icon[self._equips_info.carry_type]
			elseif self._equips_info.num / var_13_0 >= 0.25 and self._equips_info.num / var_13_0 < 0.5 then
				var_13_2 = var_0_4.dock_carry_icon2[self._equips_info.carry_type]
			elseif self._equips_info.num / var_13_0 < 0.25 then
				var_13_2 = var_0_4.dock_carry_icon3[self._equips_info.carry_type]
			end

			self._control.BG.all_layer.shell_layer.icon.image.sprite = self:loadSprite(var_13_2)
			self._control.BG.all_layer.shell_layer.count_txt.text.text = var_0_6("%s/%s", self._equips_info.num, var_13_0)

			self._control.BG.all_layer.shell_layer:SetActive(true)

			if self._equips_info.num == 0 and var_13_0 == 0 then
				self._control.BG.all_layer.shell_layer:SetActive(false)
			end
		else
			self._control.BG.all_layer.shell_layer:SetActive(false)
		end
	end

	function arg_1_0:__set_tab_type(arg_14_1, arg_14_2)
		if not self._tab_type then
			return
		end

		local var_14_0

		if self._tab_type == var_0_4.dock_team_toggle_type.formation then
			self._control.BG.all_layer.formation_type_layer:SetActive(true)
			self._control.BG.all_layer.supply_type_layer:SetActive(false)
			self._control.BG.all_layer.equipment_type_layer:SetActive(false)

			var_14_0 = self:__set_formation_type_layer(arg_14_2)
		elseif self._tab_type == var_0_4.dock_team_toggle_type.supply then
			self._control.BG.all_layer.formation_type_layer:SetActive(false)
			self._control.BG.all_layer.supply_type_layer:SetActive(true)
			self._control.BG.all_layer.equipment_type_layer:SetActive(false)

			var_14_0 = self:__set_formation_type_layer(arg_14_2)

			self:__set_supply_type_layer()
		elseif self._tab_type == var_0_4.dock_team_toggle_type.equipment then
			self._control.BG.all_layer.formation_type_layer:SetActive(false)
			self._control.BG.all_layer.supply_type_layer:SetActive(false)
			self._control.BG.all_layer.equipment_type_layer:SetActive(true)

			var_14_0 = self:__set_formation_type_layer(arg_14_2)

			self:__set_equipment_type_layer()
		end

		return var_14_0 or arg_14_2
	end

	function arg_1_0:__set_formation_type_layer(arg_15_1)
		self._control.BG.all_layer.formation_type_layer.info_layer.name_layer.name_dd.name_dd_1.text.text = self._data.name

		self._control.BG.all_layer.formation_type_layer.info_layer.name_layer.name_dd:GetComponent("TextHorizonScroller"):SetText(self._data.name)

		self._control.BG.all_layer.formation_type_layer.info_layer.name_layer.name_level.name_level_1.text.text = var_0_6("/%s/", self._ship_config.class_no)

		self._control.BG.all_layer.formation_type_layer.info_layer.name_layer.name_level:GetComponent("TextHorizonScroller"):SetText(var_0_6("/%s/", self._ship_config.class_no))

		var_0_14.x = -86
		var_0_14.y = -86.2
		self._control.BG.all_layer.level_layer.transform.localPosition = var_0_14
		var_0_14.x = 0.5
		var_0_14.y = -92.6
		self._control.BG.all_layer.hp_layer.transform.localPosition = var_0_14
		var_0_14.x = 44.7
		var_0_14.y = -24.2
		self._control.BG.all_layer.shell_layer.transform.localPosition = var_0_14
		self._control.BG.all_layer.formation_type_layer.info_layer.atk_info.Tip.text.text = var_0_2:getNowLang("atk")
		self._control.BG.all_layer.formation_type_layer.info_layer.torpedo_info.Tip.text.text = var_0_2:getNowLang("equip3")
		self._control.BG.all_layer.formation_type_layer.info_layer.def_info.Tip.text.text = var_0_2:getNowLang("def")
		self._control.BG.all_layer.formation_type_layer.info_layer.air_def_info.Tip.text.text = var_0_2:getNowLang("airdef")

		local var_15_0 = var_0_19:get_ship_attr(self._data, self._ship_config)

		self._control.BG.all_layer.formation_type_layer.info_layer.atk_info.num.text.text = var_0_20((nil).atk)
		self._control.BG.all_layer.formation_type_layer.info_layer.torpedo_info.num.text.text = var_0_20(var_15_0.torpedo)
		self._control.BG.all_layer.formation_type_layer.info_layer.def_info.num.text.text = var_0_20(var_15_0.def)
		self._control.BG.all_layer.formation_type_layer.info_layer.air_def_info.num.text.text = var_0_20(var_15_0.air_def)

		if not arg_15_1 then
			return
		end

		local var_15_2 = var_0_19.little_clone(arg_15_1)

		var_15_2.hp_max = var_15_0.hp

		return var_15_2
	end

	function arg_1_0:__set_supply_type_layer(arg_16_1)
		self._control.BG.all_layer.supply_type_layer.info_layer.name_layer.name_dd.name_dd_1.text.text = self._data.name

		self._control.BG.all_layer.supply_type_layer.info_layer.name_layer.name_dd:GetComponent("TextHorizonScroller"):SetText(self._data.name)

		self._control.BG.all_layer.supply_type_layer.info_layer.name_layer.name_level.name_level_1.text.text = var_0_6("/%s/", self._ship_config.class_no)

		self._control.BG.all_layer.supply_type_layer.info_layer.name_layer.name_level:GetComponent("TextHorizonScroller"):SetText(var_0_6("/%s/", self._ship_config.class_no))

		var_0_14.x = -86
		var_0_14.y = -99.5
		self._control.BG.all_layer.level_layer.transform.localPosition = var_0_14
		var_0_14.x = 0.5
		var_0_14.y = -105.9
		self._control.BG.all_layer.hp_layer.transform.localPosition = var_0_14
		var_0_14.x = 38
		var_0_14.y = -35.5
		self._control.BG.all_layer.shell_layer.transform.localPosition = var_0_14
		self._control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer.Tip.text.text = var_0_2:getNowLang("ammo") .. ":"
		self._control.BG.all_layer.supply_type_layer.info_layer.fuel_layer.Tip.text.text = var_0_2:getNowLang("fuel") .. ":"
		self._control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer.num.text.text = var_0_6("%s/%s", math.floor(self._data.now_bullet), self._data.bullet)
		self._control.BG.all_layer.supply_type_layer.info_layer.fuel_layer.num.text.text = var_0_6("%s/%s", math.floor(self._data.now_oil), self._data.oil)

		if not arg_16_1 then
			self:__set_info_num(self._control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer.ammunition_img.transform, 10 * (self._data.now_bullet / self._data.bullet), var_0_18.bullet)
			self:__set_info_num(self._control.BG.all_layer.supply_type_layer.info_layer.fuel_layer.fuel_img.transform, 10 * (self._data.now_oil / self._data.oil), var_0_18.oil)
		else
			self:__refresh_animation()
		end

		self._need_supply = self._data.now_oil < self._data.oil or var_0_1:get_bullet_limit_by_tactic(self._data.id) > self._data.now_bullet or self._equips_info.num < self._config_count
	end

	function arg_1_0:__set_equipment_type_layer()
		self._control.BG.all_layer.equipment_type_layer.info_layer.name_layer.name_dd.name_dd_1.text.text = self._data.name

		self._control.BG.all_layer.equipment_type_layer.info_layer.name_layer.name_dd:GetComponent("TextHorizonScroller"):SetText(self._data.name)

		self._control.BG.all_layer.equipment_type_layer.info_layer.name_layer.name_level.name_level_1.text.text = var_0_6("/%s/", self._ship_config.class_no)

		self._control.BG.all_layer.equipment_type_layer.info_layer.name_layer.name_level:GetComponent("TextHorizonScroller"):SetText(var_0_6("/%s/", self._ship_config.class_no))

		var_0_14.x = -86
		var_0_14.y = -51.2
		self._control.BG.all_layer.level_layer.transform.localPosition = var_0_14

		for iter_17_0 = 1, self._control.BG.all_layer.equipment_type_layer.info_layer.equip_list.transform.childCount do
			local var_17_0 = self._control.BG.all_layer.equipment_type_layer.info_layer.equip_list.transform:GetChild(iter_17_0 - 1).gameObject

			if iter_17_0 > self._data.equipment_num then
				var_17_0.frame.image.sprite = self:loadSprite(var_0_4.equip_icon.no)

				var_17_0.icon:SetActive(false)
			elseif self._data.equips[iter_17_0] and self._data.equips[iter_17_0].id and self._data.equips[iter_17_0].id > 0 then
				local var_17_1 = var_0_8.find_object_by_cid(self._data.equips[iter_17_0].id)

				var_17_0.icon:SetActive(true)

				var_17_0.frame.image.sprite = self:loadSprite(var_0_4.equip_quality_frame[var_17_1.star])
				var_17_0.icon.image.sprite = self:loadSprite(var_0_6(var_0_4.equip_icon.large, var_17_1.pic_id))
			else
				var_17_0.frame.image.sprite = self:loadSprite(var_0_4.equip_icon.empty)

				var_17_0.icon:SetActive(false)
			end
		end
	end

	function arg_1_0:__set_info_num(arg_18_1, arg_18_2, arg_18_3)
		local var_18_0
		local var_18_1, var_18_2 = var_0_13(arg_18_2)

		if arg_18_3 == var_0_18.bullet then
			var_18_0 = var_0_4.supply_info_icon.bullet_empty_m
		elseif arg_18_3 == var_0_18.oil then
			var_18_0 = var_0_4.supply_info_icon.oil_empty_m
		end

		local var_18_3 = false

		if var_18_1 >= 8 then
			arg_18_2 = math.floor(arg_18_2)
		elseif var_18_1 >= 6 and var_18_2 > 0 and var_18_1 < 8 then
			var_18_3 = true
			arg_18_2 = 8
		elseif var_18_1 > 6 and var_18_2 == 0 and var_18_1 < 8 then
			arg_18_2 = 8
		elseif var_18_1 < 6 and var_18_1 >= 4 and var_18_2 > 0 then
			var_18_3 = true
			arg_18_2 = 6
		elseif var_18_1 <= 6 and var_18_1 > 4 and var_18_2 == 0 then
			arg_18_2 = 6
		elseif var_18_1 >= 2 and var_18_1 < 4 and var_18_2 > 0 then
			var_18_3 = true
			arg_18_2 = 4
		else
			arg_18_2 = var_18_1 > 2 and var_18_1 <= 4 and 4 or var_18_1 > 0 and var_18_1 <= 2 and 2 or var_18_1 == 0 and var_18_2 > 0 and 2 or var_18_1 == 0 and var_18_2 == 0 and 0 or math.floor(arg_18_2)
		end

		if arg_18_2 > 10 then
			arg_18_2 = 10
		end

		arg_18_2 = math.ceil(arg_18_2 / 2)

		for iter_18_0 = 1, arg_18_1.childCount do
			arg_18_1:GetChild(iter_18_0 - 1).gameObject.image.sprite = iter_18_0 <= arg_18_2 and self:loadSprite((self:__set_color_supply(arg_18_3, arg_18_2, var_18_3))) or self:loadSprite(var_18_0)

			if self._data.now_bullet > self._data.bullet then
				self._control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer.ammunition_img.star_1.image.sprite = self:loadSprite(var_0_4.supply_info_icon.bullet_green)
			end
		end
	end

	function arg_1_0.__set_color_supply(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
		local var_19_0

		if arg_19_2 <= 1 and arg_19_2 > 0 then
			if arg_19_1 == var_0_18.bullet then
				var_19_0 = var_0_4.supply_info_icon.bullet_red
			elseif arg_19_1 == var_0_18.oil then
				var_19_0 = var_0_4.supply_info_icon.oil_red
			end
		elseif arg_19_3 and arg_19_2 <= 2 then
			if arg_19_1 == var_0_18.bullet then
				var_19_0 = var_0_4.supply_info_icon.bullet_red
			elseif arg_19_1 == var_0_18.oil then
				var_19_0 = var_0_4.supply_info_icon.oil_yellow
			end
		elseif arg_19_2 <= 2 and arg_19_2 > 1 then
			if arg_19_1 == var_0_18.bullet then
				var_19_0 = var_0_4.supply_info_icon.bullet_yellow
			elseif arg_19_1 == var_0_18.oil then
				var_19_0 = var_0_4.supply_info_icon.oil_yellow
			end
		elseif arg_19_2 >= 2 and arg_19_2 < 4 then
			if arg_19_1 == var_0_18.bullet then
				var_19_0 = var_0_4.supply_info_icon.bullet_yellow
			elseif arg_19_1 == var_0_18.oil then
				var_19_0 = var_0_4.supply_info_icon.oil_yellow
			end
		elseif arg_19_3 and arg_19_2 >= 4 and arg_19_2 <= 5 then
			if arg_19_1 == var_0_18.bullet then
				var_19_0 = var_0_4.supply_info_icon.bullet_yellow
			elseif arg_19_1 == var_0_18.oil then
				var_19_0 = var_0_4.supply_info_icon.oil_blue
			end
		elseif arg_19_2 >= 4 and arg_19_2 <= 5 then
			if arg_19_1 == var_0_18.bullet then
				var_19_0 = var_0_4.supply_info_icon.bullet_blue
			elseif arg_19_1 == var_0_18.oil then
				var_19_0 = var_0_4.supply_info_icon.oil_blue
			end
		end

		return var_19_0
	end

	function arg_1_0:__refresh_animation()
		local var_20_0 = self:autoKillDOTween(var_0_12.Sequence())
		local var_20_1 = self:autoKillDOTween(var_0_12.Sequence())

		for iter_20_0 = 1, 10 * self._data.now_bullet / self._data.bullet - 10 * self._last_data.now_bullet / self._last_data.bullet do
			local function var_20_2()
				self:__set_info_num(self._control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer.ammunition_img.transform, 10 * (self._last_data.now_bullet / self._last_data.bullet) + iter_20_0, var_0_18.bullet)
			end

			var_20_0:AppendInterval(0.1)
			var_20_0:AppendCallback(var_20_2)
		end

		for iter_20_1 = 1, 10 * self._data.now_bullet / self._data.bullet - 10 * self._last_data.now_bullet / self._last_data.bullet do
			local function var_20_3()
				self:__set_info_num(self._control.BG.all_layer.supply_type_layer.info_layer.fuel_layer.fuel_img.transform, 10 * (self._last_data.now_oil / self._last_data.oil) + iter_20_1, var_0_18.oil)
			end

			var_20_1:AppendInterval(0.1)
			var_20_1:AppendCallback(var_20_3)
		end

		var_20_0:Play()
		var_20_1:Play()
	end

	function arg_1_0:__add_collections_attr(arg_23_1)
		local var_23_0 = var_0_5.find_object_by_cid(self._data)

		for iter_23_0, iter_23_1 in pairs((var_0_1:get_player_desk_collection_data())) do
			local var_23_1 = var_0_10.find_object_by_cid(iter_23_1.id)

			if var_23_1 then
				local var_23_2 = var_0_15(var_23_1.buff_effect.attr)

				if var_0_19:match_collection_ship_type(var_23_1.buff_effect.ship_type, var_23_0.type) and (var_23_1.buff_effect.country == 0 or var_23_1.buff_effect.country == var_23_0.country) and arg_23_1[var_23_2] then
					arg_23_1[var_23_2] = arg_23_1[var_23_2] + var_23_1.buff_effect.val
				end
			end
		end
	end

	function arg_1_0:__add_restaurant_attr(arg_24_1)
		local var_24_0 = var_0_1:get_restaurant_cookbook_buff()

		if not var_24_0 then
			return
		end

		local var_24_1

		if lx.ServerTime:getUtcTime() < var_24_0.end_time then
			var_24_1 = var_0_11.find_object_by_cid(var_24_0.id)
		end

		if not var_24_1 then
			return
		end

		local var_24_2 = var_0_5.find_object_by_cid(self._data)

		if not var_24_2 then
			return
		end

		local var_24_3 = var_24_1.effect.attr

		if arg_24_1[var_24_1.effect.attr] and var_24_0.end_time >= lx.ServerTime:getUtcTime() and (var_24_1.effect.type == 5 or var_24_1.effect.type == 6) then
			local var_24_5 = var_24_1.effect.country or 0
			local var_24_6 = var_24_1.effect.ship_type or 0
			local var_24_7 = var_24_1.effect.ship_ton or 0

			if (var_24_6 == 0 or var_24_6 == var_24_2.type) and (var_24_5 == 0 or var_24_5 == var_24_2.country) and (var_24_7 == 0 or var_24_7 == var_24_2.ship_ton) then
				arg_24_1[var_24_3] = arg_24_1[var_24_3] + var_24_1.effect.value
			end
		end
	end

	function arg_1_0:__add_racing_attr(arg_25_1)
		local var_25_0 = var_0_1:get_dormitory_race_buff()

		if not var_25_0 then
			return
		end

		local var_25_1

		if lx.ServerTime:getUtcTime() < var_25_0.end_time then
			local var_25_2 = var_0_9.find_object_by_cid(var_25_0.id)
		end

		if not var_25_1 then
			return
		end

		if not var_0_5.find_object_by_cid(self._data.cid) then
			return
		end

		local var_25_4 = var_0_4:get_attr_name(var_25_1.buff.num4)
	end

	function arg_1_0:_play_into_se(arg_26_1)
		self:playSE(arg_26_1, false)
	end

	function arg_1_0:__show_tactic_anim(arg_27_1)
		local var_27_0 = self._control.BG.all_layer.tactic_layer
		local var_27_1 = var_0_16.find_object_by_cid(arg_27_1.later)
		local var_27_2 = var_27_1.level == 0 and 1 or var_27_1.level + 1

		if var_27_1.level_exp[var_27_1.level == 0 and 1 or var_27_1.level + 1] == nil then
			var_27_2 = var_27_2 - 1
		end

		local var_27_3 = lx.ServerTime:getUtcTime()

		self._user_data = var_0_1:get_use_info_data()

		if self._user_data.combatshop_tactics_card and var_27_3 < self._user_data.combatshop_tactics_card then
			arg_27_1.exp = arg_27_1.exp * 2
		end

		local var_27_4 = var_0_6(var_0_4.college_tactics_s, var_27_1.icon)
		local var_27_5 = arg_27_1.now_exp

		var_27_0:SetActive(true)

		var_27_0.tactic_info.transform.localPosition = Vector3.New(100, 0, 0)
		var_27_0.tactic_info.canvas.sortingOrder = 600
		var_27_0.tactic_info.tactic_icon.image.sprite = self:loadSprite(var_27_4)
		var_27_0.tactic_info.exp_plus.text.text = "+" .. arg_27_1.exp

		if var_27_2 == 3 and var_27_5 == 0 then
			var_27_5 = var_27_2 == var_27_1.level and 500 or 0
		end

		var_27_0.tactic_info.exp_num.text.text = var_0_6("%s/%s", var_27_5, var_27_1.level_exp[var_27_2])
		self._sequence = self:autoKillDOTween(var_0_12.Sequence())

		self._sequence:Append(var_27_0.tactic_info.rectTransform:DOAnchorPos(Vector2(0, 0), 1):SetEase(DG.Tweening.Ease.OutSine):SetAutoKill(true))
		self._sequence:AppendInterval(0.8)
		self._sequence:Append(var_27_0.tactic_info.rectTransform:DOAnchorPos(Vector2(-100, 0), 1):SetEase(DG.Tweening.Ease.OutSine):SetAutoKill(true))
		self._sequence:AppendCallback(function()
			if not var_27_0:Equals(nil) then
				var_27_0:SetActive(false)
			end
		end)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_29_0)
	local var_29_0 = var_0_3:class("single_ship")

	var_29_0._data = nil
	var_29_0._last_data = nil
	var_29_0._ship_config = nil
	var_29_0._tab_type = nil
	var_29_0._index = nil
	var_29_0._need_supply = false
	var_29_0._no_click_event = false

	return var_29_0
end

return var_0_0
