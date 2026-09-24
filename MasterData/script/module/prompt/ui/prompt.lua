local var_0_0 = {}
local var_0_1 = string.format
local var_0_2 = gamecore.UILoader
local var_0_3 = DG.Tweening.DOTween
local var_0_4 = gamecore.Language

gamecore.UILoader:define("prompt", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self:close_battle_start_consume()
		self:close_night_attack_consume()
		self:close_battle_pve_consume()
		self:close_seven_start_consume()
		self:close_get_seven_config_card()
		self:setVisible(true)

		local var_2_0 = self:autoKillDOTween(var_0_3.Sequence())

		var_2_0:Append(self._panel.transform:DOBlendableLocalMoveBy(Vector3.New(0, 128), 0.86))
		var_2_0:AppendCallback(function()
			self:destroy()
		end)
		var_2_0:Play()

		if arg_2_2 == "seven_start_consume" then
			self:show_seven_start_consume(arg_2_1)

			return
		end

		if arg_2_2 == "battle_start_consume" then
			self:show_battle_start_consume(arg_2_1)

			return
		end

		if arg_2_2 == "night_consume" then
			self:show_night_attack_consume(arg_2_1)

			return
		end

		if arg_2_2 == "pveskipsuccess" then
			self:show_battle_pveskipsuccess_consume(arg_2_1)

			return
		elseif arg_2_2 == "pveskipfail" then
			self:show_battle_pveskipfail_consume(arg_2_1)

			return
		end

		self._control.text.gameObject:SetActive(true)

		self._control.text.text = arg_2_1

		if arg_2_2 == "seven_find_config_card" then
			self._control.text.gameObject:SetActive(false)
			self:show_get_seven_config_card(arg_2_1)
		end
	end

	function arg_1_0:show_battle_start_consume(arg_4_1)
		self._control.battle_consume_tip.alpha = 1
		self._control.title.text = var_0_4:getNowLang("pvesupplycost")
		self._control.oil_consume_txt.text = var_0_1("- %s", arg_4_1)
		self._control.bullet_consume_txt.text = var_0_1("- %s", arg_4_1)
	end

	function arg_1_0:show_battle_pveskipsuccess_consume(arg_5_1)
		self._control.skipsuccess_consume_tip.alpha = 1
		self._control.skipsuccess_title.text = var_0_4:getNowLang("pveskipsuccess")
		self._control.skipsuccess_oil_consume_txt.text = var_0_1("- %s", arg_5_1)
	end

	function arg_1_0:show_battle_pveskipfail_consume(arg_6_1)
		self._control.skipsuccess_consume_tip.alpha = 1
		self._control.skipsuccess_title.text = var_0_4:getNowLang("pveskipfail")
		self._control.skipsuccess_oil_consume_txt.text = var_0_1("- %s", arg_6_1)
	end

	function arg_1_0:show_night_attack_consume(arg_7_1)
		self._control.night_consume_tip.alpha = 1
		self._control.night_txt.text = var_0_4:getNowLang("nightwarcost")
		self._control.night_title.text = var_0_4:getNowLang("pvesupplycost")
		self._control.bullet_consume_txt.text = var_0_1("- %s", arg_7_1)
	end

	function arg_1_0:show_seven_start_consume(arg_8_1)
		self._control.battle_consume_tip.alpha = 1
		self._control.title.text = var_0_4:getNowLang("pvesupplycost")
		self._control.bullet_consume_txt.text = var_0_1("- %s", arg_8_1)
	end

	function arg_1_0:show_get_seven_config_card(arg_9_1)
		self._control.seven_active_tip.alpha = 1
		self._control.config_num_txt.text = var_0_4:getNowLang("ui_rewardtitle") .. "           x  " .. arg_9_1
	end

	function arg_1_0:close_seven_start_consume()
		self._control.battle_consume_tip.alpha = 0
	end

	function arg_1_0:close_battle_start_consume()
		self._control.battle_consume_tip.alpha = 0
	end

	function arg_1_0:close_night_attack_consume()
		self._control.night_consume_tip.alpha = 0
	end

	function arg_1_0:close_battle_pve_consume()
		self._control.skipsuccess_consume_tip.alpha = 0
	end

	function arg_1_0:close_get_seven_config_card()
		self._control.seven_active_tip.alpha = 0
	end
end)

function var_0_0.create(arg_15_0)
	local var_15_0 = var_0_2:class("prompt")

	var_15_0:__registerControl("text", UnityEngine.UI.Text)
	var_15_0:__registerControl("background/battle_consume_tip/title", UnityEngine.UI.Text, "title")
	var_15_0:__registerControl("background/battle_consume_tip", UnityEngine.CanvasGroup, "battle_consume_tip")
	var_15_0:__registerControl("background/battle_consume_tip/oil_consume_txt", UnityEngine.UI.Text, "oil_consume_txt")
	var_15_0:__registerControl("background/battle_consume_tip/bullet_consume_txt", UnityEngine.UI.Text, "bullet_consume_txt")
	var_15_0:__registerControl("background/night_consume_tip", UnityEngine.CanvasGroup, "night_consume_tip")
	var_15_0:__registerControl("background/night_consume_tip/night", UnityEngine.UI.Text, "night_txt")
	var_15_0:__registerControl("background/night_consume_tip/title", UnityEngine.UI.Text, "night_title")
	var_15_0:__registerControl("background/night_consume_tip/bullet_consume_txt", UnityEngine.UI.Text, "night_bullet_consume_txt")
	var_15_0:__registerControl("background/skipsuccess_consume_tip", UnityEngine.CanvasGroup, "skipsuccess_consume_tip")
	var_15_0:__registerControl("background/skipsuccess_consume_tip/title", UnityEngine.UI.Text, "skipsuccess_title")
	var_15_0:__registerControl("background/skipsuccess_consume_tip/title/oil_icon", UnityEngine.UI.Text, "oil_icon")
	var_15_0:__registerControl("background/skipsuccess_consume_tip/title/oil_icon/oil_consume_txt", UnityEngine.UI.Text, "skipsuccess_oil_consume_txt")
	var_15_0:__registerControl("background/seven_active_tip", UnityEngine.CanvasGroup, "seven_active_tip")
	var_15_0:__registerControl("background/seven_active_tip/config_icon", UnityEngine.UI.Text, "config_icon")
	var_15_0:__registerControl("background/seven_active_tip/config_num_txt", UnityEngine.UI.Text, "config_num_txt")

	return var_15_0
end

return var_0_0
