local var_0_0 = {}
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = gameconfig.ship_config
local var_0_6 = string.format
local var_0_7 = gameconfig.skin_config
local var_0_14 = Vector3.zero
local var_0_17 = gamecore.util_func

gamecore.UILoader:define("abyss_single_ship", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3)
		self._tab_type = arg_2_2 or var_0_4.abyss_dock_team_toggle_type.formation
		self._no_click_event = false

		self:__init_panel(arg_2_1, arg_2_3)
		self:setVisible(true)
	end

	function arg_1_0:set_active_rankable_layout_item(arg_3_1)
		self._control.BG.all_layer.drag_layer.rankableLayoutItem.dragable = arg_3_1
	end

	function arg_1_0:set_main(arg_4_1)
		if arg_4_1 == false then
			self._control.BG.flag_ship:SetActive(false)
		else
			self._control.BG.flag_ship:SetActive(true)
		end
	end

	function arg_1_0.no_click_event(arg_5_0, arg_5_1)
		arg_5_0._no_click_event = arg_5_1
	end

	function arg_1_0:__init_panel(arg_6_1, arg_6_2)
		self._data = arg_6_1 and var_0_17.little_clone(arg_6_1) or {}
		self._index = arg_6_2

		self._control.BG.all_layer.tactic_layer:SetActive(false)

		if next(self._data) then
			self._control.BG.flag_ship:SetActive(false)
			self._control.BG.all_layer:SetActive(true)
			self._control.BG.all_layer.icon_layer:SetActive(true)
			self._control.BG.all_layer.cover_sprite:SetActive(true)
			self._control.BG.all_layer.item_btn:SetActive(true)
			self._control.BG.all_layer.level_layer:SetActive(true)

			local var_6_0 = var_0_5.find_abyss_object_by_cid(self._data.cid)

			self._ship_config = var_6_0

			local var_6_1 = self:__set_tab_type(var_6_0)

			self._data.hp = var_6_1.hp_max

			local var_6_2 = var_0_17:use_big_break_painting(self._data, var_0_4.ship_icon_type.model_m, true)

			self._control.BG.all_layer.icon_layer.icon.image.sprite = self:loadSprite(self._data.skin ~= 0 and var_0_4:get_ship_icon(var_6_2, var_0_7.find_object_by_cid(self._data.skin).icon, var_0_7.find_object_by_cid(self._data.skin).icon) or var_0_4:get_ship_icon(var_6_2, tostring(self._ship_config.pic_id), tostring(self._ship_config.pic_id)))
			self._control.BG.all_layer.icon_layer.image.sprite = self._data.boss == 1 and self:loadSprite(var_0_4.abyss_ui_path.main .. "abyss_ship_bg_L_2.png") or self:loadSprite(var_0_4.abyss_ui_path.main .. "abyss_ship_bg_L_1.png")
			self._control.BG.all_layer.level_layer.type_txt.text.text = var_0_2:getNowLang(var_0_4:get_ship_type_language_key(var_6_1.type, 1))
			self._control.BG.all_layer.level_layer.country_txt.text.text = var_0_6("(%s)", var_0_2:getNowLang(var_0_4:get_country_language_key(var_6_1.country)))

			self:__set_level()
		end
	end

	function arg_1_0:__set_tab_type(arg_7_1)
		if self._tab_type == 0 then
			return
		end

		local var_7_0

		if self._tab_type == var_0_4.abyss_dock_team_toggle_type.formation then
			self._control.BG.all_layer.name_layer:SetActive(true)

			var_7_0 = self:__set_formation_type_layer(arg_7_1)
		end

		return var_7_0 or arg_7_1
	end

	function arg_1_0:__set_formation_type_layer(arg_8_1)
		self._control.BG.all_layer.name_layer.name_dd.name_dd_1.text.text = self._data.name

		self._control.BG.all_layer.name_layer.name_dd:GetComponent("TextHorizonScroller"):SetText(self._data.name)

		self._control.BG.all_layer.name_layer.name_level.name_level_1.text.text = var_0_6("/%s/", self._ship_config.class_no)

		self._control.BG.all_layer.name_layer.name_level:GetComponent("TextHorizonScroller"):SetText(var_0_6("/%s/", self._ship_config.class_no))

		var_0_14.x = -85
		var_0_14.y = -203.5
		self._control.BG.all_layer.level_layer.transform.localPosition = var_0_14

		if not arg_8_1 then
			return
		end

		local var_8_1 = lx.clone_table(arg_8_1)

		var_8_1.hp_max = var_0_17:get_ship_attr(self._data, self._ship_config).hp

		self._control.BG.all_layer.evo_image:SetActive(var_0_5.find_abyss_object_by_cid(self._data.cid).evo_class)

		return var_8_1
	end

	function arg_1_0:__set_level()
		self._control.BG.all_layer.level_layer.level_txt.text.text = var_0_6("Lv.%d", self._data.level)
		self._control.BG.all_layer.level_layer.level_txt.text.color = self._data.level < 110 and Color.New(1, 1, 1) or Color.New(0.996078431372549, 0.9882352941176471, 0)

		for iter_9_0 = 1, self._control.BG.all_layer.level_layer.star_layer.transform.childCount do
			if iter_9_0 <= self._data.star then
				self._control.BG.all_layer.level_layer.star_layer.transform:GetChild(iter_9_0 - 1).gameObject:SetActive(true)

				self._control.BG.all_layer.level_layer.star_layer.transform:GetChild(iter_9_0 - 1).gameObject.image.sprite = self:loadSprite(var_0_4.abyss_ui_path.card .. "star_icon.png")
			elseif iter_9_0 > self._data.star and iter_9_0 < 7 then
				self._control.BG.all_layer.level_layer.star_layer.transform:GetChild(iter_9_0 - 1).gameObject.image.sprite = self:loadSprite(var_0_4.abyss_ui_path.card .. "star_blank_icon.png")
			else
				self._control.BG.all_layer.level_layer.star_layer.transform:GetChild(iter_9_0 - 1).gameObject:SetActive(false)
			end
		end
	end

	function arg_1_0.__onReset(arg_10_0)
		arg_10_0._data = {}
		arg_10_0._tab_type = 0
		arg_10_0._ship_config = {}
		arg_10_0._index = 0
		arg_10_0._no_click_event = false
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_11_0)
	local var_11_0 = var_0_3:class("abyss_single_ship")

	var_11_0._data = {}
	var_11_0._tab_type = 0
	var_11_0._ship_config = {}
	var_11_0._index = 0
	var_11_0._no_click_event = false

	gamecore.extend_obj(var_11_0)

	return var_11_0
end

return var_0_0
