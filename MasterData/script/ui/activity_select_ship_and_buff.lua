local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_3 = gamecore.UILoader
local var_0_4 = gamecore.Language
local var_0_5 = table.insert
local var_0_6 = DG.Tweening.DOTween
local var_0_7 = gameenum.common_type
local var_0_8 = string.format

gamecore.UILoader:define("activity_select_ship_and_buff", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self._is_nf = var_0_1:get_select_into_nf()

		self:setVisible(true)

		local var_2_0 = var_0_3:getInstance("nf_map_node")

		if self._is_nf and var_2_0 then
			self._panel.transform:GetComponent("Canvas").sortingOrder = var_2_0._panel.transform:GetComponent("Canvas").sortingOrder + 1
		end

		self:__init_panel(arg_2_1)
	end

	function arg_1_0:set_all_card_state(arg_3_1)
		if arg_3_1 then
			self._tmp_coin = arg_3_1
		end

		local var_3_0 = false

		for iter_3_0, iter_3_1 in ipairs(self._ship_and_buff_list) do
			if iter_3_1 then
				iter_3_1:__set_cost_layer(self._tmp_coin)
			end

			if iter_3_1 and iter_3_1._select_this then
				var_3_0 = true
			end
		end

		if var_3_0 then
			self._control.bottom.confirm_btn.image.sprite = self:loadSprite(var_0_8(var_0_7.exchange_btn, 16))
			self._control.bottom.confirm_btn.title.text.text = var_0_4:getNowLang("confirm")
			self._control.bottom.confirm_btn.title.text.color = Color.New(0, 0, 0)
		else
			self._control.bottom.confirm_btn.image.sprite = self:loadSprite(var_0_8(var_0_7.exchange_btn, 14))
			self._control.bottom.confirm_btn.title.text.text = var_0_4:getNowLang("settingclose")
			self._control.bottom.confirm_btn.title.text.color = Color.New(1, 1, 1)
		end

		self._control.top.coin.coin_count.text.text = self._tmp_coin
	end

	function arg_1_0:reset_ship_and_buff_data(arg_4_1)
		if self._is_nf then
			self._mist_combat_info = var_0_1:get_mist_combat_info()
			self._tmp_coin = self._mist_combat_info.coin
		else
			self._sixth_combat_info = var_0_1:get_sixth_combat_info()
			self._tmp_coin = self._sixth_combat_info.coin
		end

		if arg_4_1 then
			for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
				self._ship_and_buff_list[iter_4_0]:show(iter_4_1, iter_4_0, iter_4_1.type == var_0_7.sixth_card_type.ship, self._tmp_coin)
			end
		end

		self._control.top.coin.coin_count.text.text = tostring(self._tmp_coin)

		self:set_all_card_state()
	end

	function arg_1_0:show_adjutant_skill_effect(arg_5_1)
		if self._control.select_content.transform.childCount > 0 then
			for iter_5_0 = 1, self._control.select_content.transform.childCount do
				self:destroyGameObject(self._control.select_content.transform:GetChild(iter_5_0 - 1).gameObject)
			end
		end

		if not arg_5_1 then
			return
		end

		self:setVisible(true)
		self:__open_hidden_obj()

		local var_5_1 = self._control.skill_content.transform.childCount
		local var_5_4 = var_0_1:get_sixth_combat_info()

		self._all_ship_info = (self._is_nf and var_0_1:get_mist_combat_info() or var_0_1:get_sixth_combat_info()).ship or {}

		if var_5_1 == 0 then
			for iter_5_1, iter_5_2 in pairs(arg_5_1) do
				local var_5_5 = self:loadUI("single_select_ship_and_buff")

				var_5_5._panel.transform:SetParent(self._control.skill_content.rectTransform)
				var_5_5:show(arg_5_1[iter_5_1], iter_5_1, iter_5_2.type == var_0_7.sixth_card_type.ship, nil)
				var_0_5(self._skill_effect_list, var_5_5)
				self:__contrast_ship_info(iter_5_2.id, iter_5_1)
			end
		else
			self._skill_effect_list = {}

			for iter_5_3, iter_5_4 in pairs(arg_5_1) do
				local var_5_6 = self:loadUI("single_select_ship_and_buff")

				var_5_6._panel.transform:SetParent(self._control.skill_content.rectTransform)
				var_0_5(self._skill_effect_list, var_5_6)
				self._skill_effect_list[iter_5_3]:show(arg_5_1[iter_5_3], iter_5_3, iter_5_4.type == var_0_7.sixth_card_type.ship, nil)
				self:__contrast_ship_info(iter_5_4.id, iter_5_3)
			end
		end

		self:__set_curr_point_state(true)
	end

	function arg_1_0:__contrast_ship_info(arg_6_1, arg_6_2)
		self._skill_effect_list[arg_6_2]._control.bg.ship_level_image.gameObject:SetActive(false)

		for iter_6_0, iter_6_1 in pairs(self._all_ship_info) do
			if arg_6_1 == iter_6_1.id and iter_6_1.level ~= 1 then
				self._skill_effect_list[arg_6_2]._control.bg.ship_level_image.gameObject:SetActive(true)

				self._skill_effect_list[arg_6_2]._control.bg.ship_level_image.ship_level_txt.text.text = "+" .. iter_6_1.level - 1
			end
		end
	end

	function arg_1_0:__init_panel(arg_7_1)
		local var_7_0 = var_0_3:getInstance("sixth_map_node")

		self._panel.transform:GetComponent("Canvas").sortingOrder = var_7_0 and var_7_0._panel:GetComponent("Canvas").sortingOrder + 2 or 505
		self._data = arg_7_1

		if self._is_nf then
			self._mist_combat_info = var_0_1:get_mist_combat_info()
			self._tmp_coin = self._mist_combat_info.coin
		else
			self._sixth_combat_info = var_0_1:get_sixth_combat_info()
			self._tmp_coin = self._sixth_combat_info.coin
		end

		self._control.bottom.confirm_btn.image.sprite = self:loadSprite(var_0_8(var_0_7.exchange_btn, 14))
		self._control.bottom.confirm_btn.title.text.text = var_0_4:getNowLang("confirm")

		if not self._already_init then
			self:__init_ship_and_buff()
		else
			self:reset_ship_and_buff_data(arg_7_1)
		end

		self._control.top.title_txt.text.text = var_0_4:getNowLang("get_combat_readiness_fleet")
		self._control.bottom.refresh_btn.title.text.text = var_0_4:getNowLang("ui_refresh")
		self._control.bottom.confirm_btn.title.text.text = var_0_4:getNowLang("settingclose")
		self._control.top.coin.coin_count.text.text = tostring(self._tmp_coin)

		self:__open_raycasts(true)
		self:__open_hidden_obj()
		self:__set_curr_point_state(false)

		if self._is_nf then
			var_0_1:set_mist_open_sixth_select_and_buff("true")
		end
	end

	function arg_1_0:__init_ship_and_buff()
		self._already_init = true
		self._ship_and_buff_list = {}

		local var_8_0 = self._data

		if self._control.select_content.transform.childCount > 0 then
			for iter_8_0 = 1, self._control.select_content.transform.childCount do
				self:destroyGameObject(self._control.select_content.transform:GetChild(iter_8_0 - 1).gameObject)
			end
		end

		for iter_8_1, iter_8_2 in pairs(var_8_0) do
			local var_8_1 = self:loadUI("single_select_ship_and_buff")

			var_8_1._panel.transform:SetParent(self._control.select_content.rectTransform)
			var_8_1:show(var_8_0[iter_8_1], iter_8_1, iter_8_2.type == 1, self._tmp_coin)
			var_0_5(self._ship_and_buff_list, var_8_1)
		end
	end

	function arg_1_0:__play_fade_out_animation()
		self:__open_raycasts(false)

		local var_9_0 = self:autoKillDOTween(var_0_6.Sequence())

		var_9_0:Append(self._control.bg.image:DOColor(Color.New(0, 0, 0, 0), 0.3))
		var_9_0:Join(self._control.bg.bg_frame.canvasGroup:DOFade(0, 0.3))
		var_9_0:Join(self._control.bg_image.canvasGroup:DOFade(0, 0.3))
		var_9_0:Join(self._control.top.canvasGroup:DOFade(0, 0.3))
		var_9_0:Join(self._control.bottom.canvasGroup:DOFade(0, 0.3))
		var_9_0:AppendCallback(function()
			var_0_3:destroyInstance("activity_select_ship_and_buff")
		end)
	end

	function arg_1_0:__open_raycasts(arg_11_1)
		self._control.bg.bg_frame.canvasGroup.blocksRaycasts = arg_11_1
		self._control.bg.bg_frame.canvasGroup.interactable = arg_11_1
		self._control.bg_image.canvasGroup.blocksRaycasts = arg_11_1
		self._control.bg_image.canvasGroup.interactable = arg_11_1
		self._control.top.canvasGroup.blocksRaycasts = arg_11_1
		self._control.top.canvasGroup.interactable = arg_11_1
		self._control.bottom.canvasGroup.blocksRaycasts = arg_11_1
		self._control.bottom.canvasGroup.interactable = arg_11_1
		self._control.bottom.refresh_btn.button.interactable = not (self._is_nf and var_0_1:get_mist_combat_info() or var_0_1:get_sixth_combat_info()).refresh
	end

	function arg_1_0:__open_hidden_obj()
		self._control.bg.bg_frame.canvasGroup.alpha = 1
		self._control.bg_image.canvasGroup.alpha = 1
		self._control.top.canvasGroup.alpha = 1
		self._control.bottom.canvasGroup.alpha = 1
	end

	function arg_1_0:_play_into_se(arg_13_1)
		self:playSE(arg_13_1, false)
	end

	function arg_1_0:__set_curr_point_state(arg_14_1)
		self._control.skill_content:SetActive(arg_14_1)
		self._control.bottom:SetActive(not arg_14_1)
		self._control.top.coin:SetActive(not arg_14_1)
		self._control.select_content:SetActive(not arg_14_1)
	end

	function arg_1_0.__onReset(arg_15_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_16_0)
	local var_16_0 = var_0_3:class("activity_select_ship_and_buff")

	var_16_0._already_init = false
	var_16_0._ship_and_buff_list = {}
	var_16_0._data = {}
	var_16_0._select_list = {}
	var_16_0._tmp_coin = 0
	var_16_0._has_refresh = 0
	var_16_0._skill_effect_list = {}
	var_16_0._all_ship_info = {}

	return var_16_0
end

return var_0_0
