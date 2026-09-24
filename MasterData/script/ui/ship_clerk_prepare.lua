local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.user
local var_0_3 = gamecore.util_func
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.Language
local var_0_6 = gameconfig.ship_config
local var_0_8 = gameconfig.skin_config
local var_0_17 = lx.UserData
local var_0_18 = string.format

gamecore.UILoader:define("ship_clerk_prepare", function(arg_1_0)
	function arg_1_0.__onUpdate(arg_2_0)
		return
	end

	function arg_1_0:show(arg_3_1)
		self:setVisible(true)
		self:__init_panel(arg_3_1)
	end

	function arg_1_0:__init_panel(arg_4_1)
		self:__init_language()
		self:__init_data()
	end

	function arg_1_0:__init_language()
		self._control.top_widget.top_title_text.text.text = var_0_5:getNowLang("secretary_title_1")
		self._control.ship_sum_tip.ship_tip.text.text = var_0_5:getNowLang("secretary_title_2")
		self._control.broke_close_text.text.text = var_0_5:getNowLang("broken_display")
		self._control.circulation_text.text.text = var_0_5:getNowLang("random_display")
		self._control.resert_btn.resert_text.text.text = var_0_5:getNowLang("secretary_reset_desc")
		self._control.down_show.down_show_txt.text.text = var_0_5:getNowLang(var_0_18(var_0_4.help_info_language.help_info_1101, (lan_rand(1, 6))))
		self._control.useragreement_msgbox.toptitle.agreetitle.text.text = var_0_5:getNowLang("ui_ny21_synthesis_interface_synthesis_talk")
		self._control.useragreement_msgbox.agreecontent.agreetext.text.text = var_0_5:getNowLang("secretary_description")
		self._control.useragreement_msgbox.btn_back.back.back_txt.text.text = var_0_5:getNowLang("settingoff")
	end

	function arg_1_0:__init_data()
		if not var_0_4.open_broken then
			self._control.right_list.broke_close:SetActive(false)
		else
			self._control.right_list.broke_close:SetActive(true)
		end

		var_0_17:setKeyData("custom_panel", 1)
		self._control.bg_2:SetActive(false)
		self._control.useragreement_msgbox:SetActive(false)

		self._user_data = var_0_2:get_use_info_data()

		local var_6_0 = lx.clone_table((var_0_2:get_secretary_info()))
		local var_6_2

		if var_6_0 and next(var_6_0) then
			if var_6_0.members and next(var_6_0.members) then
				local var_6_3 = var_0_2:find_character_by_id(var_6_0.members[1])

				var_6_2 = var_6_3 and var_0_3.little_clone(var_6_3) or {}
				self._data = var_6_2

				if var_6_0.members and #var_6_0.members == 1 then
					var_0_17:setKeyData("is_secretary_info_id", self._data.id)
					self._control.select_bg:SetActive(true)
				end
			else
				local var_6_4 = var_0_2:find_character_by_id(var_0_2:get_use_info_data().secretary)

				var_6_2 = var_6_4 and var_0_3.little_clone(var_6_4) or {}
				self._data = var_6_2
			end
		end

		self._main_panel_cid = var_6_2.cid

		local var_6_5 = var_0_3:get_ship_attr(var_6_2, (var_0_6.find_object_by_cid(var_6_2.cid)))

		if var_6_5 and next(var_6_5) and var_6_2.hp ~= var_6_5.hp then
			var_6_2.hp = var_6_5.hp
		end

		local var_6_6 = var_0_6.find_object_by_cid(var_6_2.cid)
		local var_6_7
		local var_6_8 = var_0_3:use_big_break_painting(var_6_2, var_0_4.ship_icon_type.model_m, true)

		var_6_7 = var_6_2.skin ~= 0 and var_0_4:get_ship_icon(var_6_8, var_0_8.find_object_by_cid(var_6_2.skin).icon, var_0_8.find_object_by_cid(var_6_2.skin).icon) or var_0_4:get_ship_icon(var_6_8, tostring(var_6_6.pic_id), tostring(var_6_6.pic_id))
		self._control.all_layer.icon_layer.image.sprite = self:loadSprite(var_0_4.ship_quality_frame_s[self._data.star])
		self._control.all_layer.icon_layer.ship_icon.image.sprite = self:loadSprite(var_6_7)
		self._control.all_layer.supply_type_layer.info_layer.name_layer.name_dd.name_dd_1.text.text = var_6_2.name

		self._control.all_layer.supply_type_layer.info_layer.name_layer.name_dd:GetComponent("TextHorizonScroller"):SetText(var_6_2.name)

		self._control.all_layer.supply_type_layer.info_layer.name_layer.name_level.name_level_1.text.text = var_6_6.title_class

		self._control.all_layer.supply_type_layer.info_layer.name_layer.name_level:GetComponent("TextHorizonScroller"):SetText(var_6_6.title_class)

		self._control.all_layer.level_layer.type_txt.text.text = var_0_5:getNowLang(var_0_4:get_ship_type_language_key(var_6_6.type, 1))
		self._control.all_layer.level_layer.country_txt.text.text = var_0_18("(%s)", var_0_5:getNowLang(var_0_4:get_country_language_key(var_6_6.country)))
		self._control.all_layer.level_layer.level_txt.text.text = "Lv" .. "." .. var_6_2.level
		self._control.all_layer.level_layer.level_txt.text.color = var_6_2.level < 110 and Color.New(1, 1, 1) or Color.New(0.996078431372549, 0.9882352941176471, 0)

		for iter_6_0 = 1, self._control.all_layer.level_layer.star_layer.transform.childCount do
			if iter_6_0 <= var_6_2.star then
				self._control.all_layer.level_layer.star_layer.transform:GetChild(iter_6_0 - 1).gameObject:SetActive(true)
			else
				self._control.all_layer.level_layer.star_layer.transform:GetChild(iter_6_0 - 1).gameObject:SetActive(false)
			end
		end

		self._control.all_layer.level_layer.lock_tag.image.sprite = var_6_2.lock and self:loadSprite(var_0_4.ship_lock.ship_lock_l) or self:loadSprite(var_0_4.ship_unlock.ship_unlock_l)
		self._control.all_layer.love_layer.love.image.sprite = self:loadSprite(var_0_4:get_love_path(var_6_2))

		self._control.all_layer.main_icon.info_bg_txt:SetActive(false)
		self:_set_right_button_show()
		self:_set_mian_secretary_list()

		local var_6_10 = tonumber(var_0_17:getKeyData("is_secretary_info_id"))

		if var_6_10 and var_6_10 > 0 and var_6_10 == self._data.id then
			self._control.select_bg:SetActive(true)
		elseif var_0_3.have_data(var_6_0.members, var_6_10) then
			self._control.select_bg:SetActive(false)
		else
			self._control.select_bg:SetActive(true)
		end
	end

	function arg_1_0:_set_mian_secretary_list()
		local var_7_0 = lx.clone_table((var_0_2:get_secretary_info()))
		local var_7_3 = self._control.left_list.all_ship.transform.childCount

		if self._control.left_list.all_ship.transform.childCount and var_7_3 > 0 then
			for iter_7_0 = 1, var_7_3 do
				self:destroyChildren("ship_clerk_prepare_item")
			end
		end

		local var_7_4 = 0

		for iter_7_1 = 2, 6 do
			local var_7_5 = self:loadUI("ship_clerk_prepare_item")

			var_7_5._panel.transform:SetParent(self._control.left_list.all_ship.rectTransform, false)

			local var_7_6 = var_7_0.members[iter_7_1] or nil

			if var_7_6 then
				var_7_5._panel.transform.localPosition = Vector3.New(var_7_4, 265, 0)

				local var_7_7 = var_0_2:find_character_by_id(var_7_6)

				var_7_5:show(iter_7_1, var_7_7, (var_0_6.find_object_by_cid(var_7_7.cid)))

				var_7_4 = var_7_4 + 150
			else
				var_7_5:show(iter_7_1, nil, nil)

				var_7_5._panel.transform.localPosition = Vector3.New(var_7_4, 265, 0)
				var_7_4 = var_7_4 + 150
			end
		end
	end

	function arg_1_0:_set_right_button_show()
		local var_8_0 = var_0_2:get_secretary_info()

		if var_8_0 then
			self._middle_broken_flag = var_8_0.middle_broken_flag
			self._rand_secretary_flag = var_8_0.rand_secretary_flag

			if self._middle_broken_flag == 0 then
				self._control.right_list.broke_close.image.sprite = self:loadSprite(var_0_4.secretary_list_img.close)
			elseif self._middle_broken_flag == 1 then
				self._control.right_list.broke_close.image.sprite = self:loadSprite(var_0_4.secretary_list_img.open)
			end

			if self._rand_secretary_flag == 0 then
				self._control.right_list.circulation.image.sprite = self:loadSprite(var_0_4.secretary_list_img.close)
			elseif self._rand_secretary_flag == 1 then
				self._control.right_list.circulation.image.sprite = self:loadSprite(var_0_4.secretary_list_img.open)
			end
		end
	end

	function arg_1_0:_play_into_se(arg_9_1)
		self:playSE(arg_9_1, false)
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0.__initia_lize(arg_11_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_12_0)
	local var_12_0 = var_0_1:class("ship_clerk_prepare")

	var_12_0:__initia_lize()

	var_12_0._ship_item_list = {}
	var_12_0._reusable_cell = nil
	var_12_0._data = nil

	return var_12_0
end

return var_0_0
