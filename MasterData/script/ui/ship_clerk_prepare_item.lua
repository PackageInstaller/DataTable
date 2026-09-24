local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.util_func
local var_0_4 = gamecore.Language
local var_0_5 = gameenum.common_type
local var_0_6 = gameconfig.skin_config
local var_0_7 = lx.UserData
local var_0_8 = string.format

gamecore.UILoader:define("ship_clerk_prepare_item", function(arg_1_0)
	function arg_1_0.__onUpdate(arg_2_0)
		return
	end

	function arg_1_0:show(arg_3_1, arg_3_2, arg_3_3)
		self:setVisible(true)

		local var_3_0 = var_0_1:getInstance("fight_prepare")

		self:setVisible(true)
		self:__init_panel(arg_3_1, arg_3_2 and var_0_2.little_clone(arg_3_2) or {}, arg_3_3)
	end

	function arg_1_0:__init_panel(arg_4_1, arg_4_2, arg_4_3)
		if arg_4_2 and next(arg_4_2) then
			local var_4_0

			self._data = arg_4_2 and var_0_2.little_clone(arg_4_2) or {}
			self._ship_config = arg_4_3

			self._control.select_bg:SetActive(false)

			local var_4_1 = self:__set_tab_type(arg_4_3)

			if var_4_1 then
				self._data.hp = var_4_1.hp_max
			end

			local var_4_2 = var_0_2:use_big_break_painting(self._data, var_0_5.ship_icon_type.model_m, true)

			var_4_0 = self._data.skin ~= 0 and var_0_5:get_ship_icon(var_4_2, var_0_6.find_object_by_cid(self._data.skin).icon, var_0_6.find_object_by_cid(self._data.skin).icon) or var_0_5:get_ship_icon(var_4_2, tostring(self._ship_config.pic_id), tostring(self._ship_config.pic_id))

			self._control.ship_item.item_icon_mask.quality:SetActive(true)

			self._control.ship_item.item_icon_mask.quality.image.sprite = self:loadSprite(var_0_5.ship_quality_frame_s[self._data.star])

			self._control.level_layer:SetActive(true)
			self._control.ship_item.info_layer:SetActive(true)
			self._control.level_layer:SetActive(true)

			local var_4_3 = tonumber(var_0_7:getKeyData("is_secretary_info_id"))

			if var_4_3 and var_4_3 > 0 and var_4_3 == self._data.id then
				self._control.select_bg:SetActive(true)
			else
				var_0_1:getInstance("ship_clerk_prepare")._control.select_bg:SetActive(false)
			end

			self._control.ship_item.item_icon_mask.ship_icon:SetActive(false)
			self._control.ship_item.item_icon_mask.item_icon:SetActive(true)

			self._control.ship_item.item_icon_mask.item_icon.image.sprite = self:loadSprite(var_4_0)

			for iter_4_0 = 1, self._control.level_layer.star_layer.transform.childCount do
				if iter_4_0 <= arg_4_3.star then
					self._control.level_layer.star_layer.transform:GetChild(iter_4_0 - 1).gameObject:SetActive(true)
				else
					self._control.level_layer.star_layer.transform:GetChild(iter_4_0 - 1).gameObject:SetActive(false)
				end
			end

			self._control.ship_item.info_layer.name_level_1.text.text = self._data.name

			self._control.ship_item.info_layer:GetComponent("TextHorizonScroller"):SetText(self._data.name)

			self._control.ship_item.item_icon_mask.love_bg.love.image.sprite = self:loadSprite(var_0_5:get_love_path(arg_4_2))
			self._control.level_layer.type_txt.text.text = var_0_4:getNowLang(var_0_5:get_ship_type_language_key(arg_4_3.type, 1))
			self._control.level_layer.country_txt.text.text = var_0_8("(%s)", var_0_4:getNowLang(var_0_5:get_country_language_key(arg_4_3.country)))
			self._control.level_layer.lock_tag.image.sprite = self._data.lock and self:loadSprite(var_0_5.ship_lock.ship_lock_l) or self:loadSprite(var_0_5.ship_unlock.ship_unlock_l)
			self._control.level_layer.level_txt.text.text = "Lv" .. "." .. self._data.level
			self._control.level_layer.level_txt.text.color = self._data.level < 110 and Color.New(1, 1, 1) or Color.New(0.996078431372549, 0.9882352941176471, 0)
		else
			self._control.ship_item.item_icon_mask.ship_icon:SetActive(true)
			self._control.ship_item.item_icon_mask.item_icon:SetActive(false)

			self._control.ship_item.item_icon_mask.item_icon.image.sprite = self:loadSprite(var_0_5.secretary_list_img.select_big)

			self._control.level_layer:SetActive(false)
			self._control.ship_item.info_layer:SetActive(false)
			self._control.level_layer:SetActive(false)
			self._control.ship_item.item_icon_mask.quality:SetActive(false)
			self._control.ship_item.item_icon_mask.love_bg:SetActive(false)
		end
	end

	function arg_1_0:__set_tab_type(arg_5_1)
		if not self._tab_type then
			return
		end

		return self:__set_data(arg_5_1) or arg_5_1
	end

	function arg_1_0:__set_data(arg_6_1)
		if not arg_6_1 then
			return
		end

		local var_6_1 = var_0_2.little_clone(arg_6_1)

		var_6_1.hp_max = var_0_2:get_ship_attr(self._data, self._ship_config).hp

		return var_6_1
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0.__initia_lize(arg_8_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_9_0)
	local var_9_0 = var_0_1:class("ship_clerk_prepare_item")

	var_9_0:__initia_lize()

	return var_9_0
end

return var_0_0
