local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = gameconfig.ship_config
local var_0_6 = gameconfig.skin_config
local var_0_7 = gameconfig.sixth_combat_buff_config
local var_0_8 = string.format
local var_0_9 = DG.Tweening.DOTween
local var_0_10 = gamecore.util_func
local var_0_11 = UnityEngine.Vector2
local var_0_13 = gameconfig.pve_mist_ship_config

gamecore.UILoader:define("single_select_ship_and_buff", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		self:setVisible(true)

		self._index = arg_2_2
		self._is_ship = arg_2_3
		self._tmp_coin = arg_2_4
		self._is_nf = var_0_1:get_select_into_nf()

		self:__init_panel(arg_2_1)
		self:__set_select_state(false)
		self:__show_use_skill_effect()
	end

	function arg_1_0:__init_panel(arg_3_1)
		self._data = arg_3_1
		self._canvasgroup = self._control.bg.transform.parent:GetComponent("CanvasGroup")
		self._canvasgroup.interactable = true
		self._canvasgroup.blocksRaycasts = true
		self._canvasgroup.alpha = 1
		self._control.bg.cost_layer.cost_coin_count.text.text = "x" .. self._data.cost

		self._control.bg.buff_level_image:SetActive(false)
		self:__set_select_state(false)

		if not self._data then
			self:setVisible(false)

			return
		elseif self._is_ship then
			self:__change_layer(true)

			if self._is_nf then
				self._ship_data = var_0_13.find_object_by_id(self._data.id)

				self._control.bg.all_layer:SetActive(true)
				self._control.bg.all_layer.ship_layer:SetActive(true)
				self._control.bg.all_layer.ship_layer.love_layer:SetActive(false)

				self._control.bg.all_layer.ship_layer.ship_icon_layer.icon.image.sprite = self:loadSprite((var_0_4:get_ship_icon(var_0_10:use_big_break_painting(self._ship_data, var_0_4.ship_icon_type.model_m, true), tostring(self._ship_data.pic_id), tostring(self._ship_data.pic_id))))
				self._control.bg.all_layer.ship_layer.ship_icon_layer.image.sprite = self:loadSprite(var_0_4.ship_quality_s[self._ship_data.rarity])
				self._control.bg.all_layer.ship_layer.ship_icon_layer.icon.rectTransform.anchoredPosition = var_0_11(62.5, 69)
				self._control.bg.all_layer.ship_layer.ship_icon_layer.icon.transform.localScale = Vector3.New(0.7, 0.7, 1)

				self._control.bg.all_layer.ship_layer.ship_icon_layer.icon.image:SetNativeSize()
				self:__set_mist_formation_type_layer()

				self._control.bg.all_layer.info_layer.name_layer.name_level_1.text.text = self._ship_data.shipnamecn

				local var_3_1 = self:__get_ship_level_in_mist_activity(self._data.id)

				self._control.bg.ship_level_image:SetActive(false)

				if var_3_1 > 0 then
					self._control.bg.ship_level_image:SetActive(self._is_ship)

					self._control.bg.ship_level_image.ship_level_txt.text.text = "+" .. var_3_1
				else
					self._control.bg.ship_level_image:SetActive(false)
				end
			else
				self._ship_data = var_0_1:find_character_by_id(self._data.id)

				local var_3_2

				if self._ship_data then
					var_3_2 = var_0_5.find_object_by_cid(self._ship_data.cid)
				end

				if var_3_2 and self._ship_data then
					self._ship_data.hp = var_3_2.hp
				end

				if self._ship_data and self._ship_data.id and var_0_10:is_add_hp(self._ship_data, var_3_2) and next(self._ship_data) then
					self._ship_data.hp = var_0_10:get_ship_attr(self._ship_data, var_3_2).hp
				end

				self._ship_config = var_3_2 and var_0_10.little_clone(var_3_2) or {}

				self._control.bg.all_layer:SetActive(true)
				self._control.bg.all_layer.ship_layer:SetActive(true)

				local var_3_3
				local var_3_4 = var_0_10:use_big_break_painting(self._ship_data, var_0_4.ship_icon_type.model_m, true)

				var_3_3 = self._ship_data and self._ship_data.skin ~= 0 and var_0_4:get_ship_icon(var_3_4, var_0_6.find_object_by_cid(self._ship_data.skin).icon, var_0_6.find_object_by_cid(self._ship_data.skin).icon) or var_0_4:get_ship_icon(var_3_4, tostring(self._ship_config.pic_id), tostring(self._ship_config.pic_id))

				if not self._is_nf then
					self._control.bg.all_layer.ship_layer.love_layer.love.image.sprite = self:loadSprite(var_0_4:get_love_path_2(self._ship_data, false))
				end

				self._control.bg.all_layer.ship_layer.ship_icon_layer.icon.image.sprite = self:loadSprite(var_3_3)
				self._control.bg.all_layer.ship_layer.ship_icon_layer.image.sprite = self:loadSprite(var_0_4.ship_quality_s[self._ship_data.star])
				self._control.bg.all_layer.ship_layer.ship_icon_layer.icon.rectTransform.anchoredPosition = var_0_11(62.5, 69)
				self._control.bg.all_layer.ship_layer.ship_icon_layer.icon.transform.localScale = Vector3.New(0.7, 0.7, 1)

				self._control.bg.all_layer.ship_layer.ship_icon_layer.icon.image:SetNativeSize()
				self:__set_formation_type_layer()

				self._control.bg.all_layer.info_layer.name_layer.name_level_1.text.text = self._ship_data.name

				local var_3_5 = self:__get_ship_level_in_sixth_activity(self._data.id)

				self._control.bg.ship_level_image:SetActive(false)

				if var_3_5 > 0 then
					self._control.bg.ship_level_image:SetActive(self._is_ship)

					self._control.bg.ship_level_image.ship_level_txt.text.text = "+" .. var_3_5
				else
					self._control.bg.ship_level_image:SetActive(false)
				end
			end
		else
			self:__change_layer(false)

			local var_3_6 = var_0_1:get_sixth_buff_config(self._data.id)

			self._ship_config = var_3_6 and var_0_10.little_clone(var_3_6) or {}

			local var_3_7

			for iter_3_0, iter_3_1 in ipairs(var_0_1:get_sixth_combat_info().buff) do
				if self._data.id == iter_3_1.id then
					var_3_7 = var_0_7.find_object_by_id(iter_3_1.id * 100 + iter_3_1.level)
				end
			end

			if var_3_7 then
				self._ship_config = var_0_10.little_clone(var_3_7)
			end

			local var_3_8 = var_0_1:get_sixth_combat_info()

			if next(self._ship_config) then
				if next(var_3_8.buff) then
					local var_3_10 = false

					for iter_3_2, iter_3_3 in pairs(var_3_8.buff) do
						if iter_3_3.id == self._ship_config.buff_id then
							var_3_10 = true
							self._ship_config.level = iter_3_3.level + 1
						end
					end

					if not var_3_10 then
						self._ship_config.level = 1
					end
				else
					self._ship_config.level = 1
				end
			end

			self._control.bg.all_layer.info_layer.name_layer.name_level_1.text.text = self._ship_config.title

			self._control.bg.all_layer.info_layer.name_layer:GetComponent("TextHorizonScroller"):SetText(self._ship_config.title)

			self._control.bg.all_layer.buff_layer.buff_icon_layer.icon.image.sprite = self:loadSprite((var_0_8(var_0_4.tactics_buff, self._ship_config.buff_id)))
			self._control.bg.all_layer.buff_layer.buff_formation_type_layer.buff_mask.buff_txt.text.text = self._ship_config.simple_desc

			self._control.bg.all_layer.buff_layer.buff_formation_type_layer.buff_mask:GetComponent("TextHorizonScroller"):SetText(self._ship_config.simple_desc)
			self._control.bg.buff_level_image:SetActive(false)

			if self._ship_config.level > 0 then
				self._control.bg.buff_level_image:SetActive(not self._is_ship)

				self._control.bg.buff_level_image.buff_level_txt.text.text = "Lv." .. self._ship_config.level
			else
				self._control.bg.buff_level_image:SetActive(false)
			end
		end

		if not self._tmp_coin then
			return
		end

		self:__set_cost_layer(self._tmp_coin)
	end

	function arg_1_0:__change_layer(arg_4_1)
		self._control.bg.all_layer.ship_layer:SetActive(arg_4_1)
		self._control.bg.all_layer.buff_layer:SetActive(not arg_4_1)
	end

	function arg_1_0:__set_formation_type_layer()
		self._control.bg.all_layer.info_layer.name_layer:GetComponent("TextHorizonScroller"):SetText(self._ship_data.name)
		self:__set_hp_layer(self._control.bg.all_layer.ship_layer.ship_formation_type_layer.info_bg.level_layer.hp_layer)
		self:__set_level_layer(self._control.bg.all_layer.ship_layer.ship_formation_type_layer.info_bg.level_layer)
	end

	function arg_1_0:__set_mist_formation_type_layer()
		self._control.bg.all_layer.info_layer.name_layer:GetComponent("TextHorizonScroller"):SetText(self._ship_data.shipnamecn)
		self:__set_hp_layer(self._control.bg.all_layer.ship_layer.ship_formation_type_layer.info_bg.level_layer.hp_layer)
		self:__set_mist_level_layer(self._control.bg.all_layer.ship_layer.ship_formation_type_layer.info_bg.level_layer)
	end

	function arg_1_0:__set_hp_layer(arg_7_1)
		local var_7_0 = var_0_4.ship_hp_slider.ship_hp_l_green
		local var_7_2 = self._is_nf and 1 or self._ship_data.now_hp / self._ship_data.hp

		if (self._is_nf and 1 or self._ship_data.now_hp / self._ship_data.hp) >= 0.25 and var_7_2 < 0.5 then
			var_7_0 = var_0_4.ship_hp_slider.ship_hp_l_yellow
		elseif var_7_2 < 0.25 then
			var_7_0 = var_0_4.ship_hp_slider.ship_hp_l_red
		end

		arg_7_1.full_img.image.sprite = self:loadSprite(var_7_0)
		arg_7_1.full_img.image.fillAmount = var_7_2
	end

	function arg_1_0:__set_level_layer(arg_8_1)
		arg_8_1.type_txt.text.text = var_0_2:getNowLang(var_0_4:get_ship_type_language_key(self._ship_config.type, 1))
		arg_8_1.country_txt.text.text = var_0_8("(%s)", var_0_2:getNowLang(var_0_4:get_country_language_key(self._ship_config.country)))
		arg_8_1.level_txt.text.color = self._ship_data.level < 110 and Color.New(1, 1, 1) or Color.New(0.996078431372549, 0.9882352941176471, 0)
		arg_8_1.level_txt.text.text = var_0_8("LV.%d", self._ship_data.level)
		arg_8_1.lock_tag.image.sprite = self._ship_data.lock and self:loadSprite(var_0_4.ship_lock.ship_lock_s) or self:loadSprite(var_0_4.ship_unlock.ship_unlock_s)

		arg_8_1.ship_remake:SetActive(self._ship_config.evo_class)

		for iter_8_0 = 1, arg_8_1.star_layer.transform.childCount do
			if iter_8_0 <= self._ship_data.star then
				arg_8_1.star_layer.transform:GetChild(iter_8_0 - 1).gameObject:SetActive(true)
			else
				arg_8_1.star_layer.transform:GetChild(iter_8_0 - 1).gameObject:SetActive(false)
			end
		end
	end

	function arg_1_0:__set_mist_level_layer(arg_9_1)
		arg_9_1.type_txt.text.text = var_0_2:getNowLang(var_0_4:get_nf_ship_type_language_key(self._ship_data.shiptype))

		arg_9_1.country_txt:SetActive(false)

		arg_9_1.level_txt.text.color = Color.New(0.996078431372549, 0.9882352941176471, 0)
		arg_9_1.level_txt.text.text = var_0_8("LV.%d", self._ship_data.maxlevel)

		arg_9_1.lock_tag:SetActive(false)
		arg_9_1.ship_remake:SetActive(false)

		for iter_9_0 = 1, arg_9_1.star_layer.transform.childCount do
			if iter_9_0 <= self._ship_data.rarity then
				arg_9_1.star_layer.transform:GetChild(iter_9_0 - 1).gameObject:SetActive(true)
			else
				arg_9_1.star_layer.transform:GetChild(iter_9_0 - 1).gameObject:SetActive(false)
			end
		end
	end

	function arg_1_0:__set_select_state(arg_10_1)
		self._select_this = arg_10_1

		self._control.bg.select_layer:SetActive(arg_10_1)
		self._control.bg.select_border:SetActive(arg_10_1)
		self._control.bg.cost_layer.coin_bg:SetActive(arg_10_1)
		self._control.bg.no_select_mask:SetActive(not arg_10_1)
	end

	function arg_1_0:__set_cost_layer(arg_11_1)
		if arg_11_1 then
			self._tmp_coin = arg_11_1
		end

		local var_11_0 = self._control.bg.cost_layer
		local var_11_1 = self._data.cost
		local var_11_2 = self._tmp_coin

		self._control.bg.select_btn.button.onClick:RemoveAllListeners()
		self._control.bg.select_btn.button.onClick:AddListener(function()
			self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.task_goto))

			if self._select_this then
				self:__set_select_state(false)

				self._select_this = false
				var_11_2 = var_11_2 + var_11_1

				var_0_3:getInstance("activity_select_ship_and_buff"):set_all_card_state(var_11_2)
			else
				self:__set_select_state(true)

				self._select_this = true
				var_11_2 = var_11_2 - var_11_1

				local var_12_0 = var_0_3:getInstance("activity_select_ship_and_buff")

				if var_12_0 then
					log.print_r("当前存在activity_select_ship_and_buff")
				end

				var_12_0:set_all_card_state(var_11_2)
			end

			var_11_0.cost_coin_count.text.color = self._select_this and Color.New(0.07450980392156863, 0.8352941176470589, 1) or Color.New(1, 1, 1)
		end)

		if self._data.cost <= self._tmp_coin and not self._select_this then
			self._control.bg.all_layer.cover_layer:SetActive(false)

			var_11_0.cost_coin_count.text.color = Color.New(1, 1, 1)
		elseif self._select_this then
			return
		else
			self._control.bg.select_btn.button.onClick:RemoveAllListeners()
			self:__set_select_state(false)

			self._select_this = false

			self._control.bg.all_layer.cover_layer:SetActive(true)

			var_11_0.cost_coin_count.text.color = Color.New(0.9450980392156862, 0.1450980392156863, 0.4)
		end
	end

	function arg_1_0.__get_ship_level_in_sixth_activity(arg_13_0, arg_13_1)
		for iter_13_0, iter_13_1 in ipairs(var_0_1:get_sixth_combat_info().ship) do
			if iter_13_1.id == arg_13_1 then
				return iter_13_1.level
			end
		end

		return 0
	end

	function arg_1_0.__get_ship_level_in_mist_activity(arg_14_0, arg_14_1)
		for iter_14_0, iter_14_1 in ipairs(var_0_1:get_mist_combat_info().ship) do
			if iter_14_1.id == arg_14_1 then
				return iter_14_1.level
			end
		end

		return 0
	end

	function arg_1_0:__play_animation()
		self._canvasgroup.blocksRaycasts = false
		self._canvasgroup.interactable = false

		local var_15_0 = self:autoKillDOTween(var_0_9.Sequence())

		var_15_0:Append(self._control.bg.transform.parent:DOMove(self._activity_select_ship_and_buff._control.bottom.move_target.transform.position, 0.3))
		var_15_0:Insert(0.15, self._control.bg.transform.parent:GetComponent("CanvasGroup"):DOFade(0, 0.15))
	end

	function arg_1_0:__play_fade_out_animation(arg_16_1)
		self:autoKillDOTween(var_0_9.Sequence()):Append(self._control.bg.transform.parent:GetComponent("CanvasGroup"):DOFade(0, arg_16_1))
	end

	function arg_1_0:_play_into_se(arg_17_1)
		self:playSE(arg_17_1, false)
	end

	function arg_1_0:__show_use_skill_effect()
		if not self._tmp_coin then
			self:__set_select_state(true)
			self:__set_buff_point_state(false)

			return
		end

		self:__set_buff_point_state(true)
	end

	function arg_1_0:__set_buff_point_state(arg_19_1)
		self._control.bg.cost_layer.split_image:SetActive(arg_19_1)
		self._control.bg.cost_layer.coin_image:SetActive(arg_19_1)
		self._control.bg.cost_layer.cost_coin_count:SetActive(arg_19_1)
		self._control.bg.cost_layer.split_image_end:SetActive(arg_19_1)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_20_0)
	local var_20_0 = var_0_3:class("single_select_ship_and_buff")

	var_20_0._is_ship = false
	var_20_0._data = nil
	var_20_0._ship_data = {}
	var_20_0._ship_config = nil
	var_20_0._index = nil
	var_20_0._activity_select_ship_and_buff = var_0_3:getInstance("activity_select_ship_and_buff")
	var_20_0._tmp_coin = 0

	return var_20_0
end

return var_0_0
