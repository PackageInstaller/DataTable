local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = string.format
local var_0_5 = gameenum.common_type
local var_0_6 = DG.Tweening.DOTween
local var_0_7 = gameconfig.sixth_adjutant_config

gamecore.UILoader:define("adjutant_detail", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)

		self._control.tactics_bg.transform.localScale = Vector3.New(0, 0, 0)

		self._control.tactics_bg.transform:DOScale(1, 0.3)

		self._is_nf = var_0_3:get_select_into_nf()

		self:__init_panel(arg_2_1)
	end

	function arg_1_0:reset_adjutant_state()
		if self._current_card_index ~= self._current_adjutant_index then
			self._control.tactics_bg.center.bottom_btn.title.text.text = var_0_1:getNowLang("ui_tower_buff_switch")
			self._control.tactics_bg.center.bottom_btn.button.interactable = true
		else
			self._control.tactics_bg.center.bottom_btn.title.text.text = var_0_1:getNowLang("is_working")
			self._control.tactics_bg.center.bottom_btn.button.interactable = false
		end
	end

	function arg_1_0:__init_panel(arg_4_1)
		self._current_card_index = arg_4_1

		if self._is_nf then
			self._adjutant_set, self._adjutant_cid, self._current_adjutant_index = var_0_3:get_mist_adjutant()
		else
			self._adjutant_set, self._adjutant_cid, self._current_adjutant_index = var_0_3:get_six_adjutant()
		end

		self._adjutant_config = var_0_7.find_object_by_id(self._adjutant_set[self._current_card_index])
		self._max_card_index = #self._adjutant_set

		self:__init_title_name()
		self:__set_data()
		self:__set_nf_info()
	end

	function arg_1_0:__init_title_name()
		if self._already_init then
			return
		end

		self._already_init = true
	end

	function arg_1_0:__set_data()
		self._control.tactics_bg.center.card_lable.card_title.text.text = self._adjutant_config.title
		self._control.tactics_bg.center.desc_lable.desc_txt.text.text = self._adjutant_config.desc

		if self._current_card_index ~= self._current_adjutant_index then
			self._control.tactics_bg.center.bottom_btn.title.text.text = var_0_1:getNowLang("ui_tower_buff_switch")
			self._control.tactics_bg.center.bottom_btn.button.interactable = true
		else
			self._control.tactics_bg.center.bottom_btn.title.text.text = var_0_1:getNowLang("is_working")
			self._control.tactics_bg.center.bottom_btn.button.interactable = false
		end

		self._control.tactics_bg.center.bottom_btn.image.sprite = self:loadSprite(var_0_5.common_icon.common_btn_bg_08)

		local var_6_0 = var_0_4(var_0_5.sixth_adjutant_image, self._adjutant_config.id)

		self._control.tactics_bg.center.adjutant_border.adjutant_image.image.sprite = self:findPath(var_6_0) and self:loadSprite(var_6_0) or self:loadSprite(var_0_4(var_0_5.tactics_buff, "1"))

		self._control.tactics_bg.center.adjutant_border.adjutant_image.image:SetNativeSize()
	end

	function arg_1_0:__set_nf_info()
		if self._is_nf and self._adjutant_config.id == 10182 then
			self._control.tactics_bg.center.bottom_btn.title.text.text = var_0_1:getNowLang("disable")
			self._control.tactics_bg.center.bottom_btn.image.sprite = self:loadSprite(var_0_5.common_icon.common_btn_bg_10)
			self._control.tactics_bg.center.bottom_btn.button.interactable = false
		end
	end

	function arg_1_0:__move_animation(arg_8_1, arg_8_2)
		if not self._adjutant_set or #self._adjutant_set < 2 then
			do return end

			local var_8_0 = self:autoKillDOTween(var_0_6.Sequence())
		end

		local var_8_1 = Vector3.New(0, self._control.tactics_bg.transform.localPosition.y, self._control.tactics_bg.transform.localPosition.z)

		if arg_8_1 then
			-- block empty
		end

		self:__init_panel(arg_8_2)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_9_0)
	local var_9_0 = var_0_2:class("adjutant_detail")

	var_9_0._already_init = false
	var_9_0._adjutant_cid = {}
	var_9_0._adjutant_config = {}
	var_9_0._buff = {}
	var_9_0._max_card_index = 1
	var_9_0._min_card_index = 1
	var_9_0._current_card_index = 1

	return var_9_0
end

return var_0_0
