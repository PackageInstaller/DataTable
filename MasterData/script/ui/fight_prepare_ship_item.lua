local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = gameconfig.ship_config
local var_0_6 = gameconfig.equip_config
local var_0_7 = string.format
local var_0_9 = gameconfig.skin_config
local var_0_10 = UnityEngine.Vector2
local var_0_11 = gameconfig.tactics_config
local var_0_12 = DG.Tweening.DOTween
local var_0_13 = math.modf
local var_0_14 = gameconfig.tower_buff_config
local var_0_15 = gameconfig.ship_config
local var_0_17 = {
	bullet = 1,
	oil = 2
}
local var_0_18 = gamecore.util_func

gamecore.UILoader:define("fight_prepare_ship_item", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7)
		local var_2_0 = var_0_3:getInstance("fight_prepare")

		self:setVisible(true)

		self._team_type = arg_2_5
		self._go_to_map_id = arg_2_6
		self._campagion_data = arg_2_7

		local var_2_1 = arg_2_3 and var_0_18.little_clone(arg_2_3) or {}

		self._is_nf = var_0_1:get_select_into_nf()

		self:__init_panel(arg_2_1, arg_2_2, var_2_1, arg_2_4)
	end

	function arg_1_0:set_pre_team_num(arg_3_1)
		self._pre_team = {}

		for iter_3_0, iter_3_1 in pairs(arg_3_1.members) do
			local var_3_0 = var_0_1:find_character_by_id(iter_3_1)
			local var_3_1 = var_3_0 and var_0_18.little_clone(var_3_0) or {}

			if next(var_3_1) then
				table.insert(self._pre_team, var_3_1)
			else
				table.remove(arg_3_1.members, iter_3_0)
			end
		end

		self._pre_team_num = arg_3_1.id
	end

	function arg_1_0:refresh_supply()
		if not self._data then
			return
		end

		local var_4_0 = var_0_1:find_character_by_id(self._data.id)

		self._data = var_4_0 and var_0_18.little_clone(var_4_0) or {}

		self:__set_supply()
	end

	function arg_1_0:refresh_hp()
		if not self._data then
			return
		end

		local var_5_0 = var_0_1:find_character_by_id(self._data.id)

		self._data = var_5_0 and var_0_18.little_clone(var_5_0) or {}

		self:refresh_attr(self._data)

		if self._is_nf then
			self:__set_mist_hp()
		else
			self:__set_hp()
		end
	end

	function arg_1_0:refresh_attr(arg_6_1)
		if arg_6_1 and arg_6_1.id then
			local var_6_0 = var_0_1:find_character_by_id(arg_6_1.id)
			local var_6_1 = var_0_18:get_ship_attr(var_6_0 and var_0_18.little_clone(var_6_0) or {}, self._ship_config)

			arg_6_1.hp_max = var_6_1.hp
			arg_6_1.hp = var_6_1.hp
		end
	end

	function arg_1_0:toggle_item_type(arg_7_1)
		self._prepare_type = arg_7_1

		self._control.ship_item.ship_info_1.bg.lock_tag:SetActive(true)

		if self._is_nf then
			self._control.ship_item.shell_layer:SetActive(false)
			self._control.ship_item.shell_small:SetActive(false)
			self._control.ship_item.item_icon_mask.love_bg:SetActive(false)

			self._control.ship_item.bottom_middle.canvasGroup.alpha = 0
			self._control.ship_item.bottom_little.canvasGroup.alpha = 1

			return
		end

		if arg_7_1 == var_0_4.fight_prepare_right_panel_type.supply or arg_7_1 == var_0_4.fight_prepare_right_panel_type.pre_formation then
			self._control.ship_item.bottom_middle.canvasGroup.alpha = 1
			self._control.ship_item.bottom_small.canvasGroup.alpha = 0
			self._control.ship_item.bottom_little.canvasGroup.alpha = 0

			self._control.ship_item.item_icon_mask.love_bg:SetActive(true)

			self._control.ship_item.ship_info_1.rectTransform.anchoredPosition = var_0_10(0, 166)
		elseif arg_7_1 == var_0_4.fight_prepare_right_panel_type.war_concerto_play or arg_7_1 == var_0_4.fight_prepare_right_panel_type.abyss_model and self._team_type == var_0_4.team_type.abyss_team then
			self._control.ship_item.bottom_middle.canvasGroup.alpha = 0
			self._control.ship_item.bottom_small.canvasGroup.alpha = 0
			self._control.ship_item.bottom_little.canvasGroup.alpha = 1

			self._control.ship_item.item_icon_mask.love_bg:SetActive(false)
			self._control.ship_item.ship_info_1.bg.lock_tag:SetActive(false)

			self._control.ship_item.ship_info_1.rectTransform.anchoredPosition = var_0_10(0, 80)
		else
			self._control.ship_item.bottom_middle.canvasGroup.alpha = 0
			self._control.ship_item.bottom_small.canvasGroup.alpha = 1
			self._control.ship_item.bottom_little.canvasGroup.alpha = 0

			self._control.ship_item.item_icon_mask.love_bg:SetActive(true)

			if not self._campaign_member_limit then
				self._control.campaign_layer.static_text.text.text = var_0_2:getNowLang("ui_typelimit")
			end

			self._control.campaign_layer:SetActive(self._campaign)

			if self._campaign and self._campagion_data and next(self._campagion_data.fleet_rule) then
				self._control.campaign_layer.limit_type.text.text = self._campagion_data.fleet_rule[self._index] == 0 and var_0_2:getNowLang("shiptypedetail0") or self._campagion_data.fleet_rule[self._index] == -1 and "" or var_0_2:getNowLang(var_0_4:get_ship_type_language_key(self._campagion_data.fleet_rule[self._index], 1))
				self._ship_type = self._campagion_data.fleet_rule[self._index]
			end

			self._control.ship_item.ship_info_1.rectTransform.anchoredPosition = var_0_10(0, 130)
		end

		local var_7_0
		local var_7_1

		if self._data then
			var_7_0 = {
				num = 0,
				carry_type = 1
			}
			var_7_1 = 0

			for iter_7_0, iter_7_1 in ipairs(self._data.equips) do
				if iter_7_1.carry_type and iter_7_1.carry_type > var_0_4.equip_carry_type.normal then
					var_7_0.carry_type = iter_7_1.carry_type
					var_7_0.num = var_7_0.num + iter_7_1.num

					if var_7_0.carry_type == var_0_4.equip_carry_type.plane then
						local var_7_2 = self._ship_config.capacity_slot or self._ship_config.missile_slot

						if var_7_2 and next(var_7_2) and var_7_2[iter_7_0] then
							var_7_1 = var_7_1 + var_7_2[iter_7_0]
						end
					end
				end
			end
		end

		if (arg_7_1 == var_0_4.fight_prepare_right_panel_type.equip_preview or arg_7_1 == var_0_4.fight_prepare_right_panel_type.six_equip_preview or arg_7_1 == var_0_4.fight_prepare_right_panel_type.strike_equip_preview or arg_7_1 == var_0_4.fight_prepare_right_panel_type.ninth_equip_preview or arg_7_1 == var_0_4.fight_prepare_right_panel_type.farfight_equip_preview) and self._data then
			self._control.ship_item.equipment_type_layer.info_layer.ship_info.bg.type_txt.text.text = var_0_2:getNowLang(var_0_4:get_ship_type_language_key(self._ship_config.type, 1))
			self._control.ship_item.equipment_type_layer.info_layer.ship_info.bg.country_txt.text.text = var_0_7("(%s)", var_0_2:getNowLang(var_0_4:get_country_language_key(self._ship_config.country)))
			self._control.ship_item.equipment_type_layer.info_layer.ship_info.ship_name.ship_name_1.text.text = self._data.name

			self._control.ship_item.equipment_type_layer.info_layer.ship_info.ship_name:GetComponent("TextHorizonScroller"):SetText(self._data.name)

			self._control.ship_item.equipment_type_layer.info_layer.ship_info.bg.level_txt.text.color = self._data.level < 110 and Color.New(1, 1, 1) or Color.New(0.996078431372549, 0.9882352941176471, 0)
			self._control.ship_item.equipment_type_layer.info_layer.ship_info.bg.level_txt.text.text = var_0_7("LV.%d", self._data.level)
			self._control.ship_item.bottom_middle.canvasGroup.alpha = 0
			self._control.ship_item.bottom_small.canvasGroup.alpha = 0
			self._control.ship_item.bottom_little.canvasGroup.alpha = 0

			self._control.ship_item.equipment_type_layer.info_layer.ship_info.bg.ship_remake:SetActive(var_0_5.find_object_by_cid(self._data.cid).evo_class)

			if self:_is_ship_custom(self._data.id) then
				self._control.ship_item.ship_info_1.bg.ship_custom:SetActive(true)
			else
				self._control.ship_item.ship_info_1.bg.ship_custom:SetActive(false)
			end

			self:show_equipment_for_preformation()

			if var_7_0.num + var_7_1 > 0 then
				self._control.ship_item.equipment_type_layer.shell_layer.gameObject:SetActive(true)

				self._control.ship_item.equipment_type_layer.shell_layer.count_txt.text.text = var_0_7("%s/%s", var_7_0.num, var_7_1)
			else
				self._control.ship_item.equipment_type_layer.shell_layer.gameObject:SetActive(false)
			end

			if self._control.ship_item.item_icon_mask.mark_bg.expedition.canvasGroup.alpha == 1 or self._control.ship_item.item_icon_mask.mark_bg.repair.canvasGroup.alpha == 1 or self._control.ship_item.item_icon_mask.mark_bg.tower_limit.canvasGroup.alpha == 1 or self._control.ship_item.item_icon_mask.mark_bg.stationed.canvasGroup.alpha == 1 then
				self._control.ship_item.equipment_type_layer.shell_layer:SetActive(false)
				self._control.ship_item.equipment_type_layer.info_layer.ship_info.bg.ship_remake:SetActive(false)
				self._control.ship_item.ship_info_1.bg.ship_custom:SetActive(false)
			end
		else
			self:set_type_state(true)
			self._control.ship_item.shell_small:SetActive(false)
		end

		local var_7_4 = self._prepare_type == var_0_4.fight_prepare_right_panel_type.supply

		if self._prepare_type == var_0_4.fight_prepare_right_panel_type.pre_formation then
			var_7_4 = true
		end

		if self._data and var_7_0 and var_7_0.carry_type ~= var_0_4.equip_carry_type.normal then
			local var_7_5

			if var_7_0.num / var_7_1 >= 0.5 then
				var_7_5 = var_0_4.dock_carry_icon[var_7_0.carry_type]
			elseif var_7_0.num / var_7_1 >= 0.25 and var_7_0.num / var_7_1 < 0.5 then
				var_7_5 = var_0_4.dock_carry_icon2[var_7_0.carry_type]
			elseif var_7_0.num / var_7_1 < 0.25 then
				var_7_5 = var_0_4.dock_carry_icon3[var_7_0.carry_type]
			end

			self._control.ship_item.shell_layer.icon.image.sprite = self:loadSprite(var_7_5)
			self._control.ship_item.shell_small.icon.image.sprite = self:loadSprite(var_7_5)
			self._control.ship_item.shell_layer.count_txt.text.text = var_0_7("%s/%s", var_7_0.num, var_7_1)

			self._control.ship_item.shell_layer:SetActive(var_7_4)
			self._control.ship_item.shell_small:SetActive(not var_7_4)

			if arg_7_1 == var_0_4.fight_prepare_right_panel_type.pre_formation then
				self._control.ship_item.equipment_type_layer.shell_layer.icon.image.sprite = self:loadSprite(var_7_5)
				self._control.ship_item.equipment_type_layer.shell_layer.count_txt.text.text = var_0_7("%s/%s", var_7_0.num, var_7_1)
			end

			if arg_7_1 == var_0_4.fight_prepare_right_panel_type.equip_preview or arg_7_1 == var_0_4.fight_prepare_right_panel_type.farfight_equip_preview or arg_7_1 == var_0_4.fight_prepare_right_panel_type.strike_equip_preview or arg_7_1 == var_0_4.fight_prepare_right_panel_type.ninth_equip_preview or arg_7_1 == var_0_4.fight_prepare_right_panel_type.six_equip_preview then
				self._control.ship_item.shell_small:SetActive(false)
				self._control.ship_item.equipment_type_layer.shell_layer:SetActive(true)
			end
		else
			self._control.ship_item.shell_layer:SetActive(false)
			self._control.ship_item.shell_small:SetActive(false)
		end

		if (arg_7_1 == var_0_4.fight_prepare_right_panel_type.equip_preview or arg_7_1 == var_0_4.fight_prepare_right_panel_type.six_equip_preview or arg_7_1 == var_0_4.fight_prepare_right_panel_type.strike_equip_preview or arg_7_1 == var_0_4.fight_prepare_right_panel_type.ninth_equip_preview or arg_7_1 == var_0_4.fight_prepare_right_panel_type.farfight_equip_preview) and self._data then
			self._control.ship_item.shell_small:SetActive(false)
			self:__set_level(self._ship_config.star)
		end
	end

	function arg_1_0.SetCampagion(arg_8_0, arg_8_1)
		arg_8_0._campaign = arg_8_1
	end

	function arg_1_0._is_ship_custom(arg_9_0, arg_9_1)
		local var_9_0 = false
		local var_9_1 = var_0_1:get_custom_ship_list()

		if var_9_1 and next(var_9_1) then
			for iter_9_0, iter_9_1 in ipairs(var_9_1) do
				if arg_9_1 == iter_9_1 then
					var_9_0 = true

					return true
				end
			end
		end

		return var_9_0
	end

	function arg_1_0:get_supply_need()
		local var_10_0 = 0
		local var_10_1 = 0
		local var_10_2 = 0

		if self._data and self._ship_config then
			var_10_0 = self._data.oil - self._data.now_oil

			local var_10_3 = var_0_1:get_bullet_limit_by_tactic(self._data.id)

			var_10_1 = var_10_3 - self._data.now_bullet < 0 and 0 or var_10_3 - self._data.now_bullet

			if self._data.equips then
				for iter_10_0, iter_10_1 in ipairs(self._data.equips) do
					if type(iter_10_1) ~= "number" and iter_10_1.id and iter_10_1.id ~= 0 and iter_10_1.carry_type ~= var_0_4.equip_carry_type.normal then
						local var_10_4 = 0

						if iter_10_1.carry_type == var_0_4.equip_carry_type.plane then
							if self._ship_config.capacity_slot[iter_10_0] then
								var_10_4 = self._ship_config.capacity_slot[iter_10_0] - iter_10_1.num
							end
						else
							var_10_4 = self._ship_config.missile_slot[iter_10_0] - iter_10_1.num
						end

						var_10_2 = var_10_2 + var_10_4 * var_0_6.find_object_by_cid(iter_10_1.id).aluminium_use
					end
				end
			end
		end

		if var_10_0 + var_10_1 + var_10_2 > 0 then
			self._need_supply = true
		end

		return {
			oil_need = var_10_0,
			bullet_need = var_10_1,
			aluminium_need = var_10_2
		}
	end

	function arg_1_0:get_quick_repair_need()
		local var_11_0 = 0
		local var_11_1 = 0
		local var_11_2 = 0

		if self._data and self._ship_config then
			self._data.hp = var_0_18:get_ship_attr(self._data, (var_0_15.find_object_by_cid(self._data.cid))).hp

			if self._data.hp - self._data.now_hp > 0 then
				if self._data.state ~= var_0_4.ship_state.repair then
					var_11_0 = (self._data.hp - self._data.now_hp) * self._ship_config.repair_oil_modulus
					var_11_1 = (self._data.hp - self._data.now_hp) * self._ship_config.repair_steel_modulus
				end

				var_11_2 = 1
			end
		end

		return {
			oil_need = var_11_0,
			steel_need = var_11_1,
			repair_item_need = var_11_2
		}
	end

	function arg_1_0:get_data()
		return self._data
	end

	function arg_1_0:show_tactic(arg_13_1)
		self:__show_tactic_anim(arg_13_1)
	end

	function arg_1_0:show_strike_forbidden(arg_14_1)
		self:__show_strike_forbidden(arg_14_1)
	end

	function arg_1_0:__init_panel(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
		if next(arg_15_3) and arg_15_3.id then
			if arg_15_2 == var_0_4.fight_prepare_right_panel_type.war_concerto_play then
				arg_15_3.hp_max = arg_15_3.hp
			elseif arg_15_2 == var_0_4.fight_prepare_right_panel_type.sixth and self._is_nf then
				-- block empty
			else
				local var_15_0 = var_0_18:get_ship_attr(arg_15_3, arg_15_4)

				arg_15_3.hp_max = var_15_0.hp
				arg_15_3.hp = var_15_0.hp
			end
		end

		self._index = arg_15_1
		self._prepare_type = arg_15_2
		self._data = arg_15_3

		if self._data and not next(self._data) then
			self._data = nil
		end

		self._ship_config = arg_15_4

		self._control.ship_item.tactic_layer:SetActive(false)
		self._control.ship_item.nf_type_layer:SetActive(false)

		local var_15_1 = app:getSystem():getChannel()

		if not self._campaign_member_limit then
			self._control.ship_empty.bg.image.sprite = (var_15_1 == var_0_4.channel.android_jp or var_15_1 == var_0_4.channel.iOS_jp) and self:loadSprite(var_0_4.fight_prepare_ship_item.ship_empty_bg_jp) or self:loadSprite(var_0_4.fight_prepare_ship_item.ship_empty_bg)
		end

		if self._data then
			self._control.ship_item.ship_item_drag.rankableLayoutItem.isFilled = true

			if not self._is_nf then
				self._control.ship_item.item_icon_mask.quality.image.sprite = self._data.cid % 100 == 18 and (self._data.boss == 1 and self:loadSprite(var_0_4.abyss_ui_path.main .. "abyss_ship_bg_m_2.png") or self:loadSprite(var_0_4.abyss_ui_path.main .. "abyss_ship_bg_m_1.png")) or self:loadSprite(var_0_4.ship_quality_frame[self._data.star])

				if arg_15_2 == var_0_4.fight_prepare_right_panel_type.pre_formation then
					self._control.ship_item.equipment_type_layer.info_layer.ship_info.bg.type_txt.text.text = var_0_2:getNowLang(var_0_4:get_ship_type_language_key(self._ship_config.type, 1))
					self._control.ship_item.equipment_type_layer.info_layer.ship_info.bg.country_txt.text.text = var_0_7("(%s)", var_0_2:getNowLang(var_0_4:get_country_language_key(self._ship_config.country)))
					self._control.ship_item.equipment_type_layer.info_layer.ship_info.ship_name.ship_name_1.text.text = self._data.name

					self._control.ship_item.equipment_type_layer.info_layer.ship_info.ship_name:GetComponent("TextHorizonScroller"):SetText(self._data.name)
				else
					self._control.ship_item.ship_info_1.bg.type_txt.text.text = var_0_2:getNowLang(var_0_4:get_ship_type_language_key(self._ship_config.type, 1))
					self._control.ship_item.ship_info_1.bg.country_txt.text.text = var_0_7("(%s)", var_0_2:getNowLang(var_0_4:get_country_language_key(self._ship_config.country)))
					self._control.ship_item.ship_info_1.ship_name.ship_name_1.text.text = self._data.name

					self._control.ship_item.ship_info_1.ship_name:GetComponent("TextHorizonScroller"):SetText(self._data.name)
				end
			else
				self._control.ship_item.item_icon_mask.quality.image.sprite = self:loadSprite(var_0_4.ship_quality_frame[self._data.rarity])
				self._control.ship_item.ship_info_1.bg.type_txt.text.text = var_0_2:getNowLang(var_0_4:get_ship_type_language_key(self._ship_config.type, 1))
				self._control.ship_item.ship_info_1.bg.country_txt.text.text = var_0_7("(%s)", var_0_2:getNowLang(var_0_4:get_country_language_key(self._ship_config.country)))
				self._control.ship_item.ship_info_1.ship_name.ship_name_1.text.text = self._data.name

				self._control.ship_item.ship_info_1.ship_name:GetComponent("TextHorizonScroller"):SetText(self._data.name)
			end

			if not self._is_nf then
				self:__set_level(self._ship_config.star)
			end

			if not self._is_nf then
				self:__set_hp()
			end

			self:__set_supply()

			self._control.ship_item.item_icon_mask.mark_bg.expedition.txt.text.text = var_0_2:getNowLang("pveinexpore")
			self._control.ship_item.item_icon_mask.mark_bg.repair.txt.text.text = var_0_2:getNowLang("inrepair")
			self._control.ship_item.item_icon_mask.mark_bg.tower_limit.txt.text.text = var_0_2:getNowLang("ui_ship_status_forbidden")
			self._control.ship_item.item_icon_mask.mark_bg.stationed.txt.text.text = var_0_2:getNowLang("inguard")

			if arg_15_2 == var_0_4.fight_prepare_right_panel_type.tower then
				self:__set_tower_info()
				self:__set_tower_cost(arg_15_4)
				self._control.ship_item.cost_bg:SetActive(true)
			elseif var_0_1:get_into_tower() then
				self:__set_tower_info()
				self:__set_tower_cost(arg_15_4)
				self._control.ship_item.cost_bg:SetActive(true)
			else
				self._tower_status = false

				self._control.ship_item.cost_bg:SetActive(false)
			end

			self:__set_ship_state_mark()

			if not self._is_nf then
				local var_15_2 = var_0_5.find_object_by_cid(arg_15_3.cid)

				self._control.ship_item.ship_info_1.bg.ship_remake:SetActive(var_15_2.evo_class)

				if self:_is_ship_custom(self._data.id) then
					self._control.ship_item.ship_info_1.bg.ship_custom:SetActive(true)
				else
					self._control.ship_item.ship_info_1.bg.ship_custom:SetActive(false)
				end

				local var_15_3 = tostring(arg_15_3.cid)

				self._control.ship_item.ship_info_1.bg.ship_remake.image.sprite = string.sub(var_15_3, #var_15_3 - 1) == "18" and self:loadSprite(var_0_4.abyss_const.abyss_reform_icon) or self:loadSprite(var_0_4.abyss_const.ship_remake_icon)
				self._control.ship_item.item_icon_mask.love_bg.love.image.sprite = self:loadSprite(var_0_4:get_love_path(arg_15_3))

				if arg_15_2 == var_0_4.fight_prepare_right_panel_type.pre_formation then
					self._control.ship_item.equipment_type_layer.info_layer.ship_info.bg.ship_remake:SetActive(var_15_2.evo_class)
					self:set_preformation_item_interable(true)

					local var_15_5 = var_0_3:getInstance("pre_formation")

					if ((var_15_5 or nil) and var_15_5:get_sub_type()) == var_0_4.fight_prepare_right_panel_type.tower then
						self:__set_tower_info()
						self:__set_tower_cost(arg_15_4)
						self._control.ship_item.cost_bg:SetActive(true)
					elseif var_0_1:get_into_tower() then
						self:__set_tower_info()
						self:__set_tower_cost(arg_15_4)
						self._control.ship_item.cost_bg:SetActive(true)
					else
						self._tower_status = false

						self._control.ship_item.cost_bg:SetActive(false)
					end

					if self._control.ship_item.item_icon_mask.mark_bg.expedition.canvasGroup.alpha == 1 or self._control.ship_item.item_icon_mask.mark_bg.repair.canvasGroup.alpha == 1 or self._control.ship_item.item_icon_mask.mark_bg.tower_limit.canvasGroup.alpha == 1 or self._control.ship_item.item_icon_mask.mark_bg.stationed.canvasGroup.alpha == 1 then
						self._control.ship_item.equipment_type_layer.shell_layer:SetActive(false)
						self._control.ship_item.equipment_type_layer.info_layer.ship_info.bg.ship_remake:SetActive(false)
						self._control.ship_item.ship_info_1.bg.ship_custom:SetActive(false)
					end
				end
			else
				self._control.ship_item.nf_type_layer:SetActive(true)

				self._control.ship_item.nf_type_layer.ship_info.bg.type_txt.text.text = var_0_2:getNowLang(var_0_4:get_nf_ship_type_language_key(self._ship_config.shiptype))
				self._control.ship_item.item_icon_mask.quality.image.sprite = self:loadSprite(var_0_4.ship_quality_frame[self._ship_config.rarity])
				self._control.ship_item.nf_type_layer.ship_info.bg.country_txt.text.text = ""
				self._control.ship_item.nf_type_layer.ship_info.bg.level_txt.text.color = Color.New(0.996078431372549, 0.9882352941176471, 0)
				self._control.ship_item.nf_type_layer.ship_info.bg.level_txt.text.text = var_0_7("LV.%d", self._ship_config.maxlevel)
				self._control.ship_item.nf_type_layer.ship_info.ship_name.ship_name_1.text.text = self._ship_config.shipnamecn
				self._control.ship_item.nf_type_layer.info_layer.atk_info.image.sprite = self:loadSprite(var_0_4.nf_ship_info_icon.gunfire)
				self._control.ship_item.nf_type_layer.info_layer.torpedo_info.image.sprite = self:loadSprite(var_0_4.nf_ship_info_icon.torpfire)
				self._control.ship_item.nf_type_layer.info_layer.def_info.image.sprite = self:loadSprite(var_0_4.nf_ship_info_icon.def)
				self._control.ship_item.nf_type_layer.info_layer.air_def_info.image.sprite = self:loadSprite(var_0_4.nf_ship_info_icon.airdef)

				if self._ship_config.shiptype == 6 then
					self._control.ship_item.nf_type_layer.info_layer.atk_info.image.sprite = self:loadSprite(var_0_4.nf_ship_info_icon.bomber)
					self._control.ship_item.nf_type_layer.info_layer.torpedo_info.image.sprite = self:loadSprite(var_0_4.nf_ship_info_icon.torpedoplane)
				end

				self._control.ship_item.nf_type_layer.ship_info.ship_name:GetComponent("TextHorizonScroller"):SetText(self._ship_config.shipnamecn)
				self:__set_mist_level(self._ship_config.rarity)
				self:__set_mist_hp()
				self:__set_mist_info()
			end
		else
			if arg_15_2 == var_0_4.fight_prepare_right_panel_type.pre_formation then
				self:set_preformation_item_interable(true)
				self._control.ship_item.shell_layer:SetActive(false)
				self._control.ship_item.bottom_middle:SetActive(false)
				self._control.ship_item.ship_info_1:SetActive(false)
				self._control.ship_item.equipment_type_layer:SetActive(true)
			end

			self._control.ship_item.ship_item_drag.rankableLayoutItem.isFilled = false
		end

		self._control.ship_item.canvasGroup.alpha = self._data and 1 or 0

		self:toggle_item_type(self._prepare_type)
		self._control.campaign_layer:SetActive(self._campaign)

		if self._team_type == var_0_4.team_type.sixth_team then
			self:__set_sixth_ship_level()
		elseif self._team_type == var_0_4.team_type.mist_team then
			self:__set_mist_ship_level()
		else
			self._control.ship_item.ship_level_image:SetActive(false)
		end

		if arg_15_2 == var_0_4.fight_prepare_right_panel_type.pre_formation and self._data then
			self:show_equipment_for_preformation()
		end
	end

	function arg_1_0:set_type_state(arg_16_1)
		self._control.ship_item.shell_layer:SetActive(arg_16_1)
		self._control.ship_item.bottom_middle:SetActive(arg_16_1)
		self._control.ship_item.ship_info_1:SetActive(arg_16_1)
		self._control.ship_item.equipment_type_layer:SetActive(not arg_16_1)
	end

	function arg_1_0:show_equipment_for_preformation()
		self:set_type_state(false)

		for iter_17_0 = 1, self._control.ship_item.equipment_type_layer.equip_list.transform.childCount do
			local var_17_0 = self._control.ship_item.equipment_type_layer.equip_list.transform:GetChild(iter_17_0 - 1).gameObject

			if iter_17_0 > self._data.equipment_num then
				var_17_0.frame.image.sprite = self:loadSprite(var_0_4.equip_icon.no)

				var_17_0.icon:SetActive(false)
			elseif self._data.equips[iter_17_0] and self._data.equips[iter_17_0].id and self._data.equips[iter_17_0].id > 0 then
				local var_17_1 = var_0_6.find_object_by_cid(self._data.equips[iter_17_0].id)

				var_17_0.icon:SetActive(true)

				var_17_0.frame.image.sprite = self:loadSprite(var_0_4.equip_quality_frame[var_17_1.star])
				var_17_0.icon.image.sprite = self:loadSprite(var_0_7(var_0_4.equip_icon.large, var_17_1.pic_id))
			else
				var_17_0.frame.image.sprite = self:loadSprite(var_0_4.equip_icon.empty)

				var_17_0.icon:SetActive(false)
			end
		end
	end

	function arg_1_0:__set_level(arg_18_1)
		self._control.ship_item.ship_info_1.bg.level_txt.text.color = self._data.level < 110 and Color.New(1, 1, 1) or Color.New(0.996078431372549, 0.9882352941176471, 0)
		self._control.ship_item.ship_info_1.bg.level_txt.text.text = var_0_7("LV.%d", self._data.level)

		if self._prepare_type == var_0_4.fight_prepare_right_panel_type.pre_formation or self._prepare_type == var_0_4.fight_prepare_right_panel_type.equip_preview or self._prepare_type == var_0_4.fight_prepare_right_panel_type.six_equip_preview or self._prepare_type == var_0_4.fight_prepare_right_panel_type.strike_equip_preview or self._prepare_type == var_0_4.fight_prepare_right_panel_type.ninth_equip_preview or self._prepare_type == var_0_4.fight_prepare_right_panel_type.farfight_equip_preview then
			self._control.ship_item.equipment_type_layer.info_layer.ship_info.bg.level_txt.text.color = self._data.level < 110 and Color.New(1, 1, 1) or Color.New(0.996078431372549, 0.9882352941176471, 0)
			self._control.ship_item.equipment_type_layer.info_layer.ship_info.bg.level_txt.text.text = var_0_7("LV.%d", self._data.level)

			for iter_18_0 = 1, self._control.ship_item.ship_info_1.bg.star_layer.transform.childCount do
				self._control.ship_item.equipment_type_layer.info_layer.ship_info.bg.star_layer[var_0_7("star_%s", iter_18_0)].gameObject:SetActive(iter_18_0 <= arg_18_1)
			end

			self._control.ship_item.equipment_type_layer.info_layer.ship_info.bg.lock_tag.image.sprite = self._data.lock and self:loadSprite(var_0_4.ship_lock.ship_lock_s) or self:loadSprite(var_0_4.ship_unlock.ship_unlock_s)
		else
			for iter_18_1 = 1, self._control.ship_item.ship_info_1.bg.star_layer.transform.childCount do
				self._control.ship_item.ship_info_1.bg.star_layer[var_0_7("star_%s", iter_18_1)].gameObject:SetActive(iter_18_1 <= arg_18_1)
			end

			self._control.ship_item.ship_info_1.bg.lock_tag.image.sprite = self._data.lock and self:loadSprite(var_0_4.ship_lock.ship_lock_s) or self:loadSprite(var_0_4.ship_unlock.ship_unlock_s)
		end
	end

	function arg_1_0:__set_mist_level(arg_19_1)
		for iter_19_0 = 1, self._control.ship_item.nf_type_layer.ship_info.bg.star_layer.transform.childCount do
			self._control.ship_item.nf_type_layer.ship_info.bg.star_layer[var_0_7("star_%s", iter_19_0)].gameObject:SetActive(iter_19_0 <= arg_19_1)
		end
	end

	function arg_1_0:__set_hp()
		local var_20_0 = var_0_4.ship_hp_slider.ship_hp_l_green
		local var_20_1 = self._data.now_hp / self._data.hp_max

		if self._data.now_hp / self._data.hp_max >= 0.25 and var_20_1 < 0.5 then
			var_20_0 = var_0_4.ship_hp_slider.ship_hp_l_yellow
		elseif var_20_1 < 0.25 then
			var_20_0 = var_0_4.ship_hp_slider.ship_hp_l_red
		end

		local var_20_3 = var_0_18:use_big_break_painting(self._data, var_0_4.ship_icon_type.model_m, true)

		self._control.ship_item.item_icon_mask.item_icon.image.sprite = self:loadSprite(self._data.skin ~= 0 and var_0_4:get_ship_icon(var_20_3, var_0_9.find_object_by_cid(self._data.skin).icon, var_0_9.find_object_by_cid(self._data.skin).icon) or var_0_4:get_ship_icon(var_20_3, tostring(self._ship_config.pic_id), tostring(self._ship_config.pic_id)))
		self._control.ship_item.ship_info_1.hp_bar_bg.hp_bar.image.sprite = self:loadSprite(var_20_0)
		self._control.ship_item.ship_info_1.hp_bar_bg.hp_bar.image.fillAmount = var_20_1
		self._need_repair = self._data.now_hp < self._data.hp
	end

	function arg_1_0:__set_mist_hp()
		self._control.ship_item.item_icon_mask.item_icon.image.sprite = self:loadSprite((var_0_4:get_ship_icon(gameenum.common_type.ship_icon.model_normal_m, tostring(self._ship_config.pic_id), tostring(self._ship_config.pic_id))))
		self._control.ship_item.ship_info_1.hp_bar_bg.hp_bar.image.sprite = self:loadSprite(var_0_4.ship_hp_slider.ship_hp_l_green)
		self._control.ship_item.ship_info_1.hp_bar_bg.hp_bar.image.fillAmount = 1
	end

	function arg_1_0:__set_mist_info()
		self._control.ship_item.nf_type_layer.info_layer.atk_info.Tip.text.text = var_0_2:get("炮击")
		self._control.ship_item.nf_type_layer.info_layer.torpedo_info.Tip.text.text = var_0_2:get("雷击")
		self._control.ship_item.nf_type_layer.info_layer.def_info.Tip.text.text = var_0_2:get("耐久")
		self._control.ship_item.nf_type_layer.info_layer.air_def_info.Tip.text.text = var_0_2:getNowLang("airdef")

		if self._ship_config.shiptype == 6 then
			self._control.ship_item.nf_type_layer.info_layer.atk_info.Tip.text.text = var_0_2:get("舰爆")
			self._control.ship_item.nf_type_layer.info_layer.torpedo_info.Tip.text.text = var_0_2:get("舰攻")
		end

		self._control.ship_item.nf_type_layer.info_layer.atk_info.num.text.text = self._ship_config.gunpower
		self._control.ship_item.nf_type_layer.info_layer.torpedo_info.num.text.text = self._ship_config.torpedopower
		self._control.ship_item.nf_type_layer.info_layer.def_info.num.text.text = self._ship_config.maxhp
		self._control.ship_item.nf_type_layer.info_layer.air_def_info.num.text.text = self._ship_config.antiair
	end

	function arg_1_0:__set_supply()
		self._control.ship_item.bottom_small.bullet.title.text.text = var_0_7("%s%s", var_0_2:getNowLang("ammo"), ":")
		self._control.ship_item.bottom_small.fuel.title.text.text = var_0_7("%s%s", var_0_2:getNowLang("fuel"), ":")
		self._control.ship_item.bottom_middle.bullet.title.text.text = var_0_7("%s%s", var_0_2:getNowLang("ammo"), ":")
		self._control.ship_item.bottom_middle.fuel.title.text.text = var_0_7("%s%s", var_0_2:getNowLang("fuel"), ":")

		if self._is_nf then
			self._control.ship_item.bottom_middle.bullet.count.bullet1.image.sprite = self:loadSprite(var_0_4.supply_info_icon.bullet_green)
			self._control.ship_item.bottom_small.bullet.count.bullet1.image.sprite = self:loadSprite(var_0_4.supply_info_icon.bullet_green)
			self._need_supply = false

			return
		end

		self._control.ship_item.bottom_middle.bullet.count_text.text.text = var_0_7("%d/%s", self._data.now_bullet, self._data.bullet)
		self._control.ship_item.bottom_middle.fuel.count_text.text.text = var_0_7("%d/%s", self._data.now_oil, self._data.oil)

		self:__set_info_num(self._control.ship_item.bottom_small.bullet.count.transform, 10 * (self._data.now_bullet / self._data.bullet), var_0_17.bullet)
		self:__set_info_num(self._control.ship_item.bottom_middle.bullet.count.transform, 10 * (self._data.now_bullet / self._data.bullet), var_0_17.bullet)
		self:__set_info_num(self._control.ship_item.bottom_small.fuel.count.transform, 10 * (self._data.now_oil / self._data.oil), var_0_17.oil)
		self:__set_info_num(self._control.ship_item.bottom_middle.fuel.count.transform, 10 * (self._data.now_oil / self._data.oil), var_0_17.oil)

		if self._data.now_bullet > self._data.bullet then
			self._control.ship_item.bottom_middle.bullet.count.bullet1.image.sprite = self:loadSprite(var_0_4.supply_info_icon.bullet_green)
			self._control.ship_item.bottom_small.bullet.count.bullet1.image.sprite = self:loadSprite(var_0_4.supply_info_icon.bullet_green)
		end

		local var_23_0
		local var_23_1

		if self._data then
			var_23_0 = {
				num = 0,
				carry_type = 1
			}
			var_23_1 = 0

			for iter_23_0, iter_23_1 in ipairs(self._data.equips) do
				if iter_23_1.carry_type and iter_23_1.carry_type > var_0_4.equip_carry_type.normal then
					var_23_0.carry_type = iter_23_1.carry_type
					var_23_0.num = var_23_0.num + iter_23_1.num

					if var_23_0.carry_type == var_0_4.equip_carry_type.plane then
						local var_23_2 = self._ship_config.capacity_slot or self._ship_config.missile_slot

						if var_23_2 and next(var_23_2) and var_23_2[iter_23_0] then
							var_23_1 = var_23_1 + var_23_2[iter_23_0]
						end
					end
				end
			end
		end

		self._control.ship_item.shell_layer.count_txt.text.text = var_0_7("%s/%s", var_23_0.num, var_23_1)

		if var_23_0.num + var_23_1 > 0 then
			self._control.ship_item.equipment_type_layer.shell_layer.count_txt.text.text = var_0_7("%s/%s", var_23_0.num, var_23_1)
		else
			self._control.ship_item.equipment_type_layer.shell_layer.gameObject:SetActive(false)
		end

		local var_23_3 = self._prepare_type == var_0_4.fight_prepare_right_panel_type.supply or self._prepare_type == var_0_4.fight_prepare_right_panel_type.pre_formation

		if self._data and var_23_0 and var_23_0.carry_type ~= var_0_4.equip_carry_type.normal then
			local var_23_4

			if var_23_0.num / var_23_1 >= 0.5 then
				var_23_4 = var_0_4.dock_carry_icon[var_23_0.carry_type]
			elseif var_23_0.num / var_23_1 >= 0.25 and var_23_0.num / var_23_1 < 0.5 then
				var_23_4 = var_0_4.dock_carry_icon2[var_23_0.carry_type]
			elseif var_23_0.num / var_23_1 < 0.25 then
				var_23_4 = var_0_4.dock_carry_icon3[var_23_0.carry_type]
			end

			self._control.ship_item.shell_layer.icon.image.sprite = self:loadSprite(var_23_4)
			self._control.ship_item.equipment_type_layer.shell_layer.icon.image.sprite = self:loadSprite(var_23_4)
			self._control.ship_item.shell_small.icon.image.sprite = self:loadSprite(var_23_4)
			self._control.ship_item.shell_layer.count_txt.text.text = var_0_7("%s/%s", var_23_0.num, var_23_1)
			self._control.ship_item.equipment_type_layer.shell_layer.count_txt.text.text = var_0_7("%s/%s", var_23_0.num, var_23_1)

			self._control.ship_item.equipment_type_layer.shell_layer:SetActive(var_23_3)
			self._control.ship_item.shell_layer:SetActive(var_23_3)
			self._control.ship_item.shell_small:SetActive(not var_23_3)
		else
			self._control.ship_item.shell_layer:SetActive(false)
			self._control.ship_item.shell_small:SetActive(false)
		end

		self._need_supply = self._data.now_oil < self._data.oil or self._data.now_bullet < self._data.bullet

		if self._prepare_type == var_0_4.fight_prepare_right_panel_type.equip_preview or self._prepare_type == var_0_4.fight_prepare_right_panel_type.farfight_equip_preview or self._prepare_type == var_0_4.fight_prepare_right_panel_type.strike_equip_preview or self._prepare_type == var_0_4.fight_prepare_right_panel_type.ninth_equip_preview or self._prepare_type == var_0_4.fight_prepare_right_panel_type.six_equip_preview then
			self._control.ship_item.shell_small:SetActive(false)

			local var_23_6

			if self._data then
				local var_23_7 = {
					num = 0,
					carry_type = 1
				}

				var_23_6 = 0

				for iter_23_2, iter_23_3 in ipairs(self._data.equips) do
					if iter_23_3.carry_type and iter_23_3.carry_type > var_0_4.equip_carry_type.normal then
						var_23_7.carry_type = iter_23_3.carry_type
						var_23_7.num = var_23_7.num + iter_23_3.num

						if var_23_7.carry_type == var_0_4.equip_carry_type.plane then
							local var_23_8 = self._ship_config.capacity_slot or self._ship_config.missile_slot

							if var_23_8 and next(var_23_8) and var_23_8[iter_23_2] then
								var_23_6 = var_23_6 + var_23_8[iter_23_2]
							end
						end
					end
				end
			end

			if var_23_6 > 0 then
				self._control.ship_item.equipment_type_layer.shell_layer:SetActive(true)
			else
				self._control.ship_item.equipment_type_layer.shell_layer:SetActive(false)
			end
		end
	end

	function arg_1_0.__set_color_supply(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
		local var_24_0

		if arg_24_2 <= 1 and arg_24_2 > 0 then
			if arg_24_1 == var_0_17.bullet then
				var_24_0 = var_0_4.supply_info_icon.bullet_red
			elseif arg_24_1 == var_0_17.oil then
				var_24_0 = var_0_4.supply_info_icon.oil_red
			end
		elseif arg_24_3 and arg_24_2 <= 2 then
			if arg_24_1 == var_0_17.bullet then
				var_24_0 = var_0_4.supply_info_icon.bullet_red
			elseif arg_24_1 == var_0_17.oil then
				var_24_0 = var_0_4.supply_info_icon.oil_yellow
			end
		elseif arg_24_2 <= 2 and arg_24_2 > 1 then
			if arg_24_1 == var_0_17.bullet then
				var_24_0 = var_0_4.supply_info_icon.bullet_yellow
			elseif arg_24_1 == var_0_17.oil then
				var_24_0 = var_0_4.supply_info_icon.oil_yellow
			end
		elseif arg_24_2 >= 2 and arg_24_2 < 4 then
			if arg_24_1 == var_0_17.bullet then
				var_24_0 = var_0_4.supply_info_icon.bullet_yellow
			elseif arg_24_1 == var_0_17.oil then
				var_24_0 = var_0_4.supply_info_icon.oil_yellow
			end
		elseif arg_24_3 and arg_24_2 >= 4 and arg_24_2 <= 5 then
			if arg_24_1 == var_0_17.bullet then
				var_24_0 = var_0_4.supply_info_icon.bullet_yellow
			elseif arg_24_1 == var_0_17.oil then
				var_24_0 = var_0_4.supply_info_icon.oil_blue
			end
		elseif arg_24_2 >= 4 and arg_24_2 <= 5 then
			if arg_24_1 == var_0_17.bullet then
				var_24_0 = var_0_4.supply_info_icon.bullet_blue
			elseif arg_24_1 == var_0_17.oil then
				var_24_0 = var_0_4.supply_info_icon.oil_blue
			end
		end

		return var_24_0
	end

	function arg_1_0:__set_sixth_ship_level()
		if self._data then
			local var_25_0 = self:__get_sixth_ship_level(self._data.id)

			if var_25_0 - 1 > 0 then
				self._control.ship_item.ship_level_image:SetActive(true)

				self._control.ship_item.ship_level_image.ship_level_txt.text.text = "+" .. var_25_0 - 1
			else
				self._control.ship_item.ship_level_image:SetActive(false)
			end
		else
			self._control.ship_item.ship_level_image:SetActive(false)
		end
	end

	function arg_1_0.__get_sixth_ship_level(arg_26_0, arg_26_1)
		for iter_26_0, iter_26_1 in ipairs(var_0_1:get_sixth_combat_info().ship) do
			if iter_26_1.id == arg_26_1 then
				return iter_26_1.level
			end
		end

		return 0
	end

	function arg_1_0:__set_mist_ship_level()
		if self._data then
			local var_27_0 = self:__get_mist_ship_level(self._data.id)

			if var_27_0 - 1 > 0 then
				self._control.ship_item.ship_level_image:SetActive(true)

				self._control.ship_item.ship_level_image.ship_level_txt.text.text = "+" .. var_27_0 - 1
			else
				self._control.ship_item.ship_level_image:SetActive(false)
			end
		else
			self._control.ship_item.ship_level_image:SetActive(false)
		end
	end

	function arg_1_0.__get_mist_ship_level(arg_28_0, arg_28_1)
		for iter_28_0, iter_28_1 in ipairs(var_0_1:get_mist_combat_info().ship) do
			if iter_28_1.id == arg_28_1 then
				return iter_28_1.level
			end
		end

		return 0
	end

	function arg_1_0:__set_tower_cost(arg_29_1)
		local var_29_0 = 0

		if self._tower_buff and next(self._tower_buff) then
			for iter_29_0, iter_29_1 in pairs(self._tower_buff) do
				for iter_29_2, iter_29_3 in pairs(var_0_14.find_object_by_id(iter_29_1).effect) do
					if iter_29_3.num4 == 18 then
						if iter_29_3.shipTon then
							var_29_0 = var_29_0 + self:__check_buff_info(arg_29_1.ship_ton, iter_29_3.shipTon, iter_29_3.type, iter_29_3.num)
						elseif iter_29_3.shipType then
							var_29_0 = var_29_0 + self:__check_buff_info(arg_29_1.type, iter_29_3.shipType, iter_29_3.type, iter_29_3.num)
						elseif iter_29_3.country then
							var_29_0 = var_29_0 + self:__check_buff_info(arg_29_1.country, iter_29_3.country, iter_29_3.type, iter_29_3.num)
						elseif iter_29_3.guardType then
							var_29_0 = var_29_0 + self:__check_buff_info(arg_29_1.guard_type, iter_29_3.guardType, iter_29_3.type, iter_29_3.num)
						end
					end
				end
			end
		end

		self._control.ship_item.cost_bg.cost.text.text = var_0_7("<color=#%s>%d</color>", var_29_0 == 0 and "FFFFFF" or var_29_0 > 0 and "FF0000" or "00FF00", (arg_29_1.cost + var_29_0 < 0 or nil) and 0)
	end

	function arg_1_0.__check_buff_info(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4)
		local var_30_0 = 0

		for iter_30_0, iter_30_1 in pairs(arg_30_2) do
			if arg_30_1 == iter_30_1 then
				if arg_30_3 == 9 then
					var_30_0 = var_30_0 + arg_30_4
				elseif arg_30_3 == 10 then
					var_30_0 = var_30_0 - arg_30_4
				end
			end
		end

		return var_30_0
	end

	function arg_1_0:__set_tower_info()
		local var_31_0, var_31_1 = var_0_1:get_tower_used_ship()

		if var_31_1 then
			for iter_31_0, iter_31_1 in ipairs(var_31_0) do
				if iter_31_1 == self._data.id then
					self._tower_status = true

					break
				else
					self._tower_status = false
				end
			end
		end
	end

	function arg_1_0:__set_info_num(arg_32_1, arg_32_2, arg_32_3)
		local var_32_1 = arg_32_1.childCount
		local var_32_2

		if arg_32_3 == var_0_17.bullet then
			var_32_2 = var_0_4.supply_info_icon.bullet_empty_m
		elseif arg_32_3 == var_0_17.oil then
			var_32_2 = var_0_4.supply_info_icon.oil_empty_m
		end

		local var_32_3, var_32_4 = var_0_13(arg_32_2)
		local var_32_5 = false

		if var_32_3 >= 8 then
			arg_32_2 = math.floor(arg_32_2)
		elseif var_32_3 >= 6 and var_32_4 > 0 and var_32_3 < 8 then
			var_32_5 = true
			arg_32_2 = 8
		elseif var_32_3 > 6 and var_32_4 == 0 and var_32_3 < 8 then
			arg_32_2 = 8
		elseif var_32_3 < 6 and var_32_3 >= 4 and var_32_4 > 0 then
			var_32_5 = true
			arg_32_2 = 6
		elseif var_32_3 <= 6 and var_32_3 > 4 and var_32_4 == 0 then
			arg_32_2 = 6
		elseif var_32_3 >= 2 and var_32_3 < 4 and var_32_4 > 0 then
			var_32_5 = true
			arg_32_2 = 4
		else
			arg_32_2 = var_32_3 > 2 and var_32_3 <= 4 and 4 or var_32_3 > 0 and var_32_3 <= 2 and 2 or var_32_3 == 0 and var_32_4 > 0 and 2 or var_32_3 == 0 and var_32_4 == 0 and 0 or math.floor(arg_32_2)
		end

		if arg_32_2 > 10 then
			arg_32_2 = 10
		end

		arg_32_2 = arg_32_2 / 2

		for iter_32_0 = 1, var_32_1 do
			arg_32_1:GetChild(iter_32_0 - 1).gameObject.image.sprite = iter_32_0 <= arg_32_2 and self:loadSprite((self:__set_color_supply(arg_32_3, arg_32_2, var_32_5))) or self:loadSprite(var_32_2)
		end
	end

	function arg_1_0:update_ship_state()
		if not self._data then
			return
		end

		self:__set_ship_state_mark()
	end

	function arg_1_0:__set_ship_state_mark()
		if self._is_nf then
			self._control.ship_item.item_icon_mask.mark_bg.canvasGroup.alpha = 0

			return
		end

		if self._is_state_station or var_0_1:is_character_station_state(self._data.id) then
			self._control.ship_item.item_icon_mask.mark_bg.stationed.canvasGroup.alpha = 1
			self._control.ship_item.item_icon_mask.mark_bg.stationed.txt.text.text = var_0_2:getNowLang("inguard")
			self._control.ship_item.item_icon_mask.mark_bg.canvasGroup.alpha = 1

			return
		else
			self._control.ship_item.item_icon_mask.mark_bg.stationed.canvasGroup.alpha = 0
			self._control.ship_item.item_icon_mask.mark_bg.canvasGroup.alpha = 0
		end

		if self._data.state == var_0_4.ship_state.expedition then
			if self._team_type == var_0_4.team_type.sixth_team then
				self._control.ship_item.item_icon_mask.mark_bg.expedition.canvasGroup.alpha = 0
				self._control.ship_item.item_icon_mask.mark_bg.canvasGroup.alpha = 0
			else
				self._control.ship_item.item_icon_mask.mark_bg.expedition.canvasGroup.alpha = 1
				self._control.ship_item.item_icon_mask.mark_bg.canvasGroup.alpha = 1
			end

			self._control.ship_item.item_icon_mask.mark_bg.repair.canvasGroup.alpha = 0
			self._control.ship_item.item_icon_mask.mark_bg.tower_limit.canvasGroup.alpha = 0
		elseif self._data.state == var_0_4.ship_state.repair then
			self._control.ship_item.item_icon_mask.mark_bg.expedition.canvasGroup.alpha = 0
			self._control.ship_item.item_icon_mask.mark_bg.tower_limit.canvasGroup.alpha = 0
			self._control.ship_item.item_icon_mask.mark_bg.repair.canvasGroup.alpha = 1
			self._control.ship_item.item_icon_mask.mark_bg.canvasGroup.alpha = 1
		elseif self._tower_status then
			self._control.ship_item.item_icon_mask.mark_bg.expedition.canvasGroup.alpha = 0
			self._control.ship_item.item_icon_mask.mark_bg.repair.canvasGroup.alpha = 0
			self._control.ship_item.item_icon_mask.mark_bg.tower_limit.canvasGroup.alpha = 1
			self._control.ship_item.item_icon_mask.mark_bg.tower_limit.txt.text.text = var_0_2:getNowLang("is_doing")
			self._control.ship_item.item_icon_mask.mark_bg.canvasGroup.alpha = 1
		else
			self._control.ship_item.item_icon_mask.mark_bg.expedition.canvasGroup.alpha = 0
			self._control.ship_item.item_icon_mask.mark_bg.tower_limit.canvasGroup.alpha = 0
			self._control.ship_item.item_icon_mask.mark_bg.stationed.canvasGroup.alpha = 0
			self._control.ship_item.item_icon_mask.mark_bg.repair.canvasGroup.alpha = 0
			self._control.ship_item.item_icon_mask.mark_bg.canvasGroup.alpha = 0
		end
	end

	function arg_1_0:__show_strike_forbidden(arg_35_1)
		if not self._data then
			return
		end

		if arg_35_1 then
			self._control.ship_item.item_icon_mask.mark_bg.expedition.canvasGroup.alpha = 0
			self._control.ship_item.item_icon_mask.mark_bg.repair.canvasGroup.alpha = 0
			self._control.ship_item.item_icon_mask.mark_bg.tower_limit.canvasGroup.alpha = 1
			self._control.ship_item.item_icon_mask.mark_bg.tower_limit.txt.text.text = var_0_2:getNowLang("ui_ship_status_forbidden")
			self._control.ship_item.item_icon_mask.mark_bg.canvasGroup.alpha = 1
		else
			self._control.ship_item.item_icon_mask.mark_bg.tower_limit.canvasGroup.alpha = 0
		end
	end

	function arg_1_0.__get_quick_repair_item_count(arg_36_0)
		local var_36_1 = var_0_1:get_item(var_0_4.quick_repair_item_cid)

		return (var_36_1 or nil) and (var_36_1.count or 0)
	end

	function arg_1_0:set_active_rankable_layout_item(arg_37_1)
		self._control.ship_item.ship_item_drag.rankableLayoutItem.dragable = arg_37_1
	end

	function arg_1_0:set_preformation_item_interable(arg_38_1)
		self._control.ship_item.canvasGroup.interactable = arg_38_1
		self._control.ship_item.canvasGroup.blocksRaycasts = arg_38_1
	end

	function arg_1_0:__show_tactic_anim(arg_39_1)
		local var_39_0 = self._control.ship_item.tactic_layer
		local var_39_1 = var_0_11.find_object_by_cid(arg_39_1.later)
		local var_39_2 = var_39_1.level == 0 and 1 or var_39_1.level + 1

		if var_39_1.level_exp[var_39_1.level == 0 and 1 or var_39_1.level + 1] == nil then
			var_39_2 = var_39_2 - 1
		end

		local var_39_3 = lx.ServerTime:getUtcTime()

		self._user_data = var_0_1:get_use_info_data()

		if self._user_data.combatshop_tactics_card and var_39_3 < self._user_data.combatshop_tactics_card then
			arg_39_1.exp = arg_39_1.exp * 2
		end

		local var_39_4 = var_0_7(var_0_4.college_tactics_s, var_39_1.icon)
		local var_39_5 = arg_39_1.now_exp

		var_39_0:SetActive(true)

		var_39_0.tactic_info.transform.localPosition = Vector3.New(20, 0, 0)
		var_39_0.tactic_info.canvas.sortingOrder = 600
		var_39_0.tactic_info.tactic_icon.image.sprite = self:loadSprite(var_39_4)
		var_39_0.tactic_info.exp_plus.text.text = "+" .. arg_39_1.exp

		if var_39_2 == 3 and var_39_5 == 0 then
			var_39_5 = var_39_2 == var_39_1.level and 500 or 0
		end

		var_39_0.tactic_info.exp_num.text.text = var_0_7("%s/%s", var_39_5, var_39_1.level_exp[var_39_2])
		self._sequence = self:autoKillDOTween(var_0_12.Sequence())

		self._sequence:Append(var_39_0.tactic_info.rectTransform:DOAnchorPos(var_0_10(-10, 0), 0.5):SetEase(DG.Tweening.Ease.OutSine):SetAutoKill(true))
		self._sequence:AppendCallback(function()
			if not var_39_0:Equals(nil) then
				var_39_0:SetActive(false)
			end
		end)
	end

	function arg_1_0:_play_into_se(arg_41_1)
		self:playSE(arg_41_1, false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_42_0)
	local var_42_0 = var_0_3:class("fight_prepare_ship_item")

	var_42_0._data = nil
	var_42_0._ship_config = nil
	var_42_0._prepare_type = var_0_4.fight_prepare_right_panel_type.props
	var_42_0._index = nil
	var_42_0._need_supply = false
	var_42_0._need_repair = false
	var_42_0._campaign = false
	var_42_0._team_type = nil
	var_42_0._click_time = 0
	var_42_0._tower_status = false
	var_42_0._go_to_map_id = nil
	var_42_0._campagion_data = nil
	var_42_0._ship_type = nil
	var_42_0._campaign_member_limit = false
	var_42_0._tower_buff = {}

	return var_42_0
end

return var_0_0
