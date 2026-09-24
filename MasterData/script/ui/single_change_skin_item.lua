local var_0_0 = {}
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = gameconfig.ship_config
local var_0_6 = gameconfig.skin_config
local var_0_11 = string.format
local var_0_13 = gamecore.user
local var_0_21 = gamecore.util_func

gamecore.UILoader:define("single_change_skin_item", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3)
		self:setVisible(true)
		self:__onReset()

		self._delegate = arg_2_2
		self._page_idx = arg_2_3

		self:__init_panel(arg_2_1)
	end

	function arg_1_0:__init_panel(arg_3_1)
		self._data = arg_3_1 and var_0_21.little_clone(arg_3_1) or {}

		local var_3_0 = self._control.BG.all_layer

		self._uid = self._data.id
		self._control.BG.image.sprite = self:loadSprite(var_0_4.fight_prepare_ship_item.ship_leave)

		var_3_0:SetActive(true)

		self._ship_config = var_0_5.find_object_by_cid(self._data.cid)

		local var_3_1
		local var_3_2 = var_0_21:use_big_break_painting(self._data, var_0_4.ship_icon_type.model_xm, true)

		if self._data.skin and self._data.skin ~= 0 then
			local var_3_3 = var_0_6.find_object_by_cid(self._data.skin).icon

			var_3_1 = var_0_4:get_ship_icon(var_3_2, tostring(var_3_3), tostring(var_3_3))
		else
			var_3_1 = var_0_4:get_ship_icon(var_3_2, tostring(self._ship_config.pic_id), tostring(self._ship_config.pic_id))
		end

		var_3_0.love_layer.love.image.sprite = self:loadSprite(var_0_4:get_love_path_2(self._data, false))
		var_3_0.icon_layer.icon.image.sprite = self:loadSprite(var_3_1)
		var_3_0.icon_layer.image.sprite = self:loadSprite(var_0_4.ship_quality_s[self._data.star])

		for iter_3_0, iter_3_1 in pairs(self._data) do
			if iter_3_0 == "team_num" then
				self._team_num = iter_3_1
			end
		end

		if self._team_num == 0 then
			self._team_num = var_0_13:get_team_index_by_id(var_0_4.team_type.normal, self._data.id) or var_0_13:get_team_index_by_id(var_0_4.team_type.expedition, self._data.id)
		end

		self:set_team_id(self._team_num)
		self:__set_level_layer(self._control.BG.all_layer.formation_type_layer.level_layer)
	end

	function arg_1_0:__set_level_layer(arg_4_1)
		arg_4_1.type_txt.text.text = var_0_2:getNowLang(var_0_4:get_ship_type_language_key(self._ship_config.type, 1))
		arg_4_1.country_txt.text.text = var_0_11("(%s)", var_0_2:getNowLang(var_0_4:get_country_language_key(self._ship_config.country)))
		arg_4_1.level_txt.text.color = self._data.level < 110 and Color.New(1, 1, 1) or Color.New(0.996078431372549, 0.9882352941176471, 0)
		arg_4_1.level_txt.text.text = var_0_11("LV.%d", self._data.level)
		arg_4_1.lock_tag.image.sprite = self._data.lock and self:loadSprite(var_0_4.ship_lock.ship_lock_s) or self:loadSprite(var_0_4.ship_unlock.ship_unlock_s)

		arg_4_1.ship_remake:SetActive(self._ship_config.evo_class)

		for iter_4_0 = 1, arg_4_1.star_layer.transform.childCount do
			if iter_4_0 <= self._data.star then
				arg_4_1.star_layer.transform:GetChild(iter_4_0 - 1).gameObject:SetActive(true)
			else
				arg_4_1.star_layer.transform:GetChild(iter_4_0 - 1).gameObject:SetActive(false)
			end
		end

		self._control.BG.all_layer.formation_type_layer.info_layer:GetComponent("TextHorizonScroller"):SetText(self._data.name)
		self:__set_hp_layer(self._control.BG.all_layer.formation_type_layer.hp_layer)
	end

	function arg_1_0:__set_hp_layer(arg_5_1)
		if self._data.now_hp then
			local var_5_0 = self._data.now_hp / self._data.hp
			local var_5_1

			if self._data.now_hp / self._data.hp >= 0.25 and var_5_0 < 0.5 then
				var_5_1 = var_0_4.ship_hp_slider.ship_hp_l_yellow
			elseif var_5_0 < 0.25 then
				var_5_1 = var_0_4.ship_hp_slider.ship_hp_l_red
			end

			arg_5_1.full_img.image.sprite = self:loadSprite(var_0_4.ship_hp_slider.ship_hp_l_green)
			arg_5_1.full_img.image.fillAmount = var_5_0
		end
	end

	function arg_1_0:set_team_id(arg_6_1)
		if arg_6_1 and arg_6_1 ~= 0 and arg_6_1 < 9 then
			self._control.team_id_info:SetActive(true)

			self._control.team_id_info.team_id.text.text = arg_6_1
		else
			self._control.team_id_info:SetActive(false)
		end
	end

	function arg_1_0:set_select_num(arg_7_1)
		if arg_7_1 > 0 then
			self._control.BG.all_layer.mask_img:SetActive(true)

			self._control.BG.all_layer.mask_img.number_info.num.text.text = arg_7_1
			self._is_select = true
		else
			self._control.BG.all_layer.mask_img:SetActive(false)

			self._is_select = false
		end
	end

	function arg_1_0:_play_into_se(arg_8_1)
		self:playSE(arg_8_1, false)
	end

	function arg_1_0.update_character_data(arg_9_0, arg_9_1)
		return
	end

	function arg_1_0.set_enter_type(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
		arg_10_0._campaign = arg_10_2
		arg_10_0._team_index = arg_10_3
	end

	function arg_1_0:__get_uid()
		return self._uid
	end

	function arg_1_0:__get_page_idx()
		return self._page_idx
	end

	function arg_1_0:__get_is_select()
		return self._is_select
	end

	function arg_1_0:__set_select_state(arg_14_1, arg_14_2)
		if not self._delegate then
			return
		end

		if arg_14_1 then
			self._is_select = not arg_14_2
		end

		if not self._is_select then
			if self:__get_select_is_max() then
				gamecore.prompt:show(var_0_11(var_0_2:getNowLang("selectstrenmaterialmax"), self._delegate:__get_select_item_count()))

				return
			end

			self._delegate:__add_select_item(self._uid)

			self._is_select = true
		else
			self._delegate:__remove_select_item(self._uid)

			self._is_select = false
		end
	end

	function arg_1_0:__get_select_is_max()
		return self._delegate:__get_select_item_count() >= var_0_4.change_skin_select_max_count
	end

	function arg_1_0.refresh(arg_16_0)
		return
	end

	function arg_1_0.__onReset(arg_17_0)
		arg_17_0._data = nil
		arg_17_0._uid = 0
		arg_17_0._ship_config = nil
		arg_17_0._mask_active = false
		arg_17_0._team_num = 0
		arg_17_0._delegate = nil
		arg_17_0._is_select = false
		arg_17_0._select_idx = 0
		arg_17_0._page_idx = 0
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_18_0)
	local var_18_0 = var_0_3:class("single_change_skin_item")

	var_18_0._data = nil
	var_18_0._uid = 0
	var_18_0._ship_config = nil
	var_18_0._mask_active = false
	var_18_0._team_num = 0
	var_18_0._delegate = nil
	var_18_0._is_select = false
	var_18_0._select_idx = 0
	arg_18_0._page_idx = 0

	return var_18_0
end

return var_0_0
