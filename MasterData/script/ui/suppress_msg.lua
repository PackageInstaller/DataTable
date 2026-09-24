local var_0_0 = {}
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = DG.Tweening.DOTween
local var_0_5 = gameenum.common_type
local var_0_6 = gameconfig.pve_mix_level_config
local var_0_7 = gameconfig.pve_active_map_config
local var_0_8 = gameconfig.pve_score_level_config
local var_0_9 = gameconfig.pve_eighth_level_config
local var_0_10 = gameconfig.pve_ninth_level_config

gamecore.UILoader:define("suppress_msg", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
		self:setVisible(true)

		self._fight_type = arg_2_5

		if self._is_suppressed ~= arg_2_1 then
			self:__init_panel(arg_2_1, arg_2_2, arg_2_4)

			self._is_init = true
		end

		self._panel.transform.anchoredPosition = Vector3(-140, 60, 0)
		self._fadeout_time = arg_2_3

		self:__panel_fade()

		self._is_suppressed = arg_2_1
	end

	function arg_1_0:__init_panel(arg_3_1, arg_3_2, arg_3_3)
		local var_3_0 = self._control.bg
		local var_3_1 = app:getSystem():getChannel()

		if var_3_1 == "hm_android_jp" or var_3_1 == "hm_ios_jp" then
			self._control.bg.main_title:SetActive(false)
			self._control.bg.target_title:SetActive(false)
		else
			self._control.bg.main_title:SetActive(true)
			self._control.bg.target_title:SetActive(true)
		end

		local var_3_3
		local var_3_4
		local var_3_5
		local var_3_6

		if arg_3_1 == "suppress" then
			var_3_3 = self:loadSprite(var_0_5.suppress_click_msg.suppress)
			var_3_4 = var_0_2:getNowLang("enemy_base_suppress")
			var_3_5 = var_0_2:getNowLang("tactical_target")
		elseif arg_3_1 == "suppressed" then
			var_3_3 = self:loadSprite(var_0_5.suppress_click_msg.suppressed)
			var_3_4 = var_0_2:getNowLang("enemy_base_suppressed")
			var_3_5 = var_0_2:getNowLang("fight_success")
		end

		if arg_3_2 then
			local var_3_7 = var_0_7.find_object_by_id(arg_3_2)

			if self._fight_type == var_0_5.fight_type.seventh then
				var_3_7 = var_0_6.find_object_by_id(arg_3_2)
			elseif self._fight_type == var_0_5.fight_type.eighth_attack then
				var_3_7 = var_0_9.find_object_by_id(arg_3_2)
			elseif self._fight_type == var_0_5.fight_type.score_attack then
				var_3_7 = var_0_8.find_object_by_id(arg_3_2)
			elseif self._fight_type == var_0_5.fight_type.ninth_attack then
				var_3_7 = var_0_10.find_object_by_id(arg_3_2)
			end

			var_3_6 = arg_3_1 == "suppress" and var_3_7.support_pre_desc or var_3_7.support_next_desc
		elseif arg_3_3 then
			var_3_6 = var_0_2:getNowLang("enemy_base_suppressed_content")
		end

		var_3_0.image.sprite = var_3_3
		var_3_0.main_title.text.text = var_3_4
		var_3_0.target_title.text.text = var_3_5
		var_3_0.content_text.text.text = var_3_6
	end

	function arg_1_0:__panel_fade()
		if self._seq then
			self._seq:Kill()
		end

		self._seq = self:autoKillDOTween(var_0_4.Sequence())

		local var_4_0 = self._panel.transform:GetComponent("CanvasGroup")

		self._seq:Append(var_4_0:DOFade(1, self._fadeout_time):SetEase(DG.Tweening.Ease.OutCirc))
		self._seq:Append(var_4_0:DOFade(0, self._fadeout_time):SetEase(DG.Tweening.Ease.InCirc):OnComplete(function()
			if self._seq then
				self._seq:Kill()
			end

			self:setVisible(false)
		end))
	end

	function arg_1_0.__onReset(arg_6_0)
		arg_6_0._is_suppressed = ""
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_7_0)
	local var_7_0 = var_0_3:class("suppress_msg")

	var_7_0._is_suppressed = ""
	var_7_0._seq = nil

	return var_7_0
end

return var_0_0
