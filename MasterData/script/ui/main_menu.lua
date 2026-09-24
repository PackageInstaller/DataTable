local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = string.format
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.AudioManager
local var_0_7 = {
	remake = "remake",
	activity = "activity",
	cardbookui = "cardbookui",
	mall = "mall",
	friend = "friend",
	build = "build"
}

gamecore.UILoader:define("main_menu", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true, arg_2_1)
	end

	function arg_1_0:play_out_animation(arg_3_1)
		self._control.ui_tween.uITweenSequence:PlayReverse(function()
			if arg_3_1 then
				arg_3_1()
			end
		end)
	end

	function arg_1_0:main_menu_out_animaiton(arg_5_1)
		if self._seq and self._seq:IsPlaying() then
			local var_5_0 = var_0_1:createInstance("home")

			var_5_0:play_open_ui_animation(true)
			var_5_0:play_model_animation(true)

			return
		end

		self._seq = self:autoKillDOTween(DG.Tweening.DOTween.Sequence())

		self._seq:Append(self._control.content.transform:DOBlendableLocalMoveBy(Vector3(-400, 0, 0), 0.3))
		self._seq:AppendCallback(arg_5_1)
	end

	function arg_1_0:reset(arg_6_1)
		if not arg_6_1 and (self._now_label == var_0_7.activity or self._now_label == var_0_7.cardbookui or self._now_label == var_0_7.remake) then
			return
		elseif arg_6_1 and (self._now_label == var_0_7.activity or self._now_label == var_0_7.cardbookui or self._now_label == var_0_7.remake) then
			self._now_label = nil

			return
		else
			if self._now_content then
				self._now_content.checkMark:SetActive(false)
			end

			self._now_label = nil
			self._arrow_open = false

			if self._arrow then
				self._arrow:SetActive(false)
			else
				self._control.content.arrow:SetActive(false)
			end
		end
	end

	function arg_1_0:get_guide_btn_pos_info(arg_7_1)
		if arg_7_1 == var_0_4.guide_const_id.six_group.one then
			return self._control.content.toggle_group.build.transform
		elseif arg_7_1 == var_0_4.guide_const_id.six_group.two then
			return self._arrow.content.item_btn_1.transform
		end
	end

	function arg_1_0.set_home_active(arg_8_0, arg_8_1)
		var_0_5:destroyCV()
		var_0_1:getInstance("home"):setVisible(arg_8_1)
	end

	function arg_1_0:__onVisible(arg_9_1, arg_9_2)
		if not arg_9_1 then
			local var_9_0 = var_0_1:getInstance("home")

			if var_9_0 then
				var_9_0.menu_is_open = false
			end

			return
		end

		self:__init_panel(arg_9_2)
	end

	function arg_1_0:__play_in_animation(arg_10_1)
		self._control.ui_tween.uITweenSequence:Play(function()
			if arg_10_1 then
				arg_10_1()
			end
		end)
	end

	function arg_1_0:__play_in_arrow_animation(arg_12_1)
		self._arrow_open = true

		self._arrow.uITweenSequence:Kill()
		self._arrow.uITweenSequence:Play(function()
			if arg_12_1 then
				arg_12_1()
			end

			self._arrow.content.item_btn_6.gameObject:SetActive(false)
		end)
	end

	function arg_1_0:play_out_arrow_animation(arg_14_1)
		self._arrow_open = false

		self._arrow.uITweenSequence:PlayReverse(function()
			if arg_14_1 then
				arg_14_1()
			end

			if self._now_content then
				self._now_content.checkMark:SetActive(false)
			end

			self._arrow:SetActive(false)
		end)
	end

	function arg_1_0:__init_panel(arg_16_1)
		var_0_1:createInstance("home").menu_is_open = true
		self._control.content.toggle_group.mall.title.text.text = var_0_2:getNowLang("mall")
		self._control.content.toggle_group.activity.title.text.text = var_0_2:getNowLang("activity")
		self._control.content.toggle_group.build.title.text.text = var_0_2:getNowLang("build")
		self._control.content.toggle_group.remake.title.text.text = var_0_2:getNowLang("remake")
		self._control.content.toggle_group.cardbookui.title.text.text = var_0_2:getNowLang("cardbookui")
		self._control.content.toggle_group.friend.title.text.text = var_0_2:getNowLang("friend")

		if arg_16_1 then
			self:__play_in_animation()
		end

		self._arrow = self._control.content.arrow

		self._arrow.content.item_btn_6.gameObject:SetActive(false)

		self._order_toggle_group = {
			self._control.content.toggle_group.mall,
			self._control.content.toggle_group.activity,
			self._control.content.toggle_group.build,
			self._control.content.toggle_group.remake,
			self._control.content.toggle_group.cardbookui,
			self._control.content.toggle_group.friend
		}
	end

	function arg_1_0:__select_one(arg_17_1)
		if self._now_label == arg_17_1 then
			return
		end

		self._now_label = arg_17_1

		self:__set_current_content(arg_17_1)
		self._control.content.toggle_group.mall.checkMark:SetActive(false)
		self._control.content.toggle_group.activity.checkMark:SetActive(false)
		self._control.content.toggle_group.build.checkMark:SetActive(false)
		self._control.content.toggle_group.remake.checkMark:SetActive(false)
		self._control.content.toggle_group.cardbookui.checkMark:SetActive(false)
		self._control.content.toggle_group.friend.checkMark:SetActive(false)

		if self._now_content and self._now_content.activeSelf then
			self._now_content.checkMark:SetActive(true)
		end
	end

	function arg_1_0:__set_current_content(arg_18_1)
		if arg_18_1 == var_0_7.mall then
			self._now_content = self._control.content.toggle_group.mall
		elseif arg_18_1 == var_0_7.activity then
			self._now_content = self._control.content.toggle_group.activity
		elseif arg_18_1 == var_0_7.build then
			self._now_content = self._control.content.toggle_group.build
		elseif arg_18_1 == var_0_7.remake then
			self._now_content = self._control.content.toggle_group.remake
		elseif arg_18_1 == var_0_7.cardbookui then
			self._now_content = self._control.content.toggle_group.cardbookui
		elseif arg_18_1 == var_0_7.friend then
			self._now_content = self._control.content.toggle_group.friend
		end
	end

	function arg_1_0:toggle_remake_btn()
		self:__select_one("remake")
		self:__set_arrow_parent(self._control.content.toggle_group.remake.transform, true)
	end

	function arg_1_0:__set_arrow_parent(arg_20_1, arg_20_2)
		self._arrow.transform:SetParent(arg_20_1)

		self._arrow.transform.localPosition = Vector3.New(arg_20_1.transform.sizeDelta.x / 2, 10, 0)

		self._arrow:SetActive(true)
		self:__init_arrow()

		if arg_20_2 then
			return
		end

		self:__play_in_arrow_animation()
	end

	function arg_1_0:__init_arrow()
		local var_21_0 = self._arrow.content

		if self._now_label == "activity" then
			var_21_0.item_btn_3.canvasGroup.alpha = 1
			var_21_0.item_btn_4.canvasGroup.alpha = 1
			var_21_0.item_btn_5.canvasGroup.alpha = 1
			var_21_0.item_btn_6.canvasGroup.alpha = 0

			gamecore.util_func.setTextHorizonInfo(var_21_0.item_btn_1.title_mask, var_0_2:getNowLang("combats"))

			var_21_0.item_btn_1.icon.image.sprite = self:loadSprite(var_0_3(var_0_4.main_menu_btn, "1_4"))

			gamecore.util_func.setTextHorizonInfo(var_21_0.item_btn_2.title_mask, var_0_2:getNowLang("spoils"))

			var_21_0.item_btn_2.icon.image.sprite = self:loadSprite(var_0_3(var_0_4.main_menu_btn, "1_0"))

			gamecore.util_func.setTextHorizonInfo(var_21_0.item_btn_3.title_mask, var_0_2:getNowLang("loginbonus"))

			var_21_0.item_btn_3.icon.image.sprite = self:loadSprite(var_0_3(var_0_4.main_menu_btn, "1_1"))

			gamecore.util_func.setTextHorizonInfo(var_21_0.item_btn_4.title_mask, var_0_2:getNowLang("upgradebonus"))

			var_21_0.item_btn_4.icon.image.sprite = self:loadSprite(var_0_3(var_0_4.main_menu_btn, "1_2"))

			gamecore.util_func.setTextHorizonInfo(var_21_0.item_btn_5.title_mask, var_0_2:getNowLang("firstrechargebonus"))

			local var_21_1 = app:getSystem():getChannel()

			if var_21_1 == var_0_4.channel.android_jp or var_21_1 == var_0_4.channel.iOS_jp then
				var_21_0.item_btn_5.text.text.fontSize = 23
			end

			var_21_0.item_btn_5.icon.image.sprite = self:loadSprite(var_0_3(var_0_4.main_menu_btn, "1_3"))
		elseif self._now_label == "cardbookui" then
			var_21_0.item_btn_3.canvasGroup.alpha = 1
			var_21_0.item_btn_4.canvasGroup.alpha = 1
			var_21_0.item_btn_5.canvasGroup.alpha = 0
			var_21_0.item_btn_6.canvasGroup.alpha = 0

			gamecore.util_func.setTextHorizonInfo(var_21_0.item_btn_1.title_mask, var_0_2:getNowLang("leaderboardui"))

			var_21_0.item_btn_1.icon.image.sprite = self:loadSprite(var_0_3(var_0_4.main_menu_btn, "4_0"))

			gamecore.util_func.setTextHorizonInfo(var_21_0.item_btn_2.title_mask, var_0_2:getNowLang("ui_collectionship"))

			var_21_0.item_btn_2.icon.image.sprite = self:loadSprite(var_0_3(var_0_4.main_menu_btn, "4_1"))

			gamecore.util_func.setTextHorizonInfo(var_21_0.item_btn_3.title_mask, var_0_2:getNowLang("ui_collectionequip"))

			var_21_0.item_btn_3.icon.image.sprite = self:loadSprite(var_0_3(var_0_4.main_menu_btn, "4_2"))

			gamecore.util_func.setTextHorizonInfo(var_21_0.item_btn_4.title_mask, var_0_2:getNowLang("ui_music"))

			var_21_0.item_btn_4.icon.image.sprite = self:loadSprite(var_0_3(var_0_4.main_menu_btn, "4_3"))
		elseif self._now_label == "remake" then
			var_21_0.item_btn_3.canvasGroup.alpha = 0
			var_21_0.item_btn_4.canvasGroup.alpha = 0
			var_21_0.item_btn_5.canvasGroup.alpha = 0
			var_21_0.item_btn_6.canvasGroup.alpha = 0

			gamecore.util_func.setTextHorizonInfo(var_21_0.item_btn_1.title_mask, var_0_2:getNowLang("remake"))

			var_21_0.item_btn_1.icon.image.sprite = self:loadSprite(var_0_3(var_0_4.main_menu_btn, "3_0"))

			gamecore.util_func.setTextHorizonInfo(var_21_0.item_btn_2.title_mask, var_0_2:getNowLang("those"))

			var_21_0.item_btn_2.icon.image.sprite = self:loadSprite(var_0_3(var_0_4.main_menu_btn, "3_1"))
		elseif self._now_label == "build" then
			var_21_0.item_btn_3.canvasGroup.alpha = 0
			var_21_0.item_btn_4.canvasGroup.alpha = 0
			var_21_0.item_btn_5.canvasGroup.alpha = 0
			var_21_0.item_btn_6.canvasGroup.alpha = 0

			gamecore.util_func.setTextHorizonInfo(var_21_0.item_btn_1.title_mask, var_0_2:getNowLang("build"))

			var_21_0.item_btn_1.icon.image.sprite = self:loadSprite(var_0_3(var_0_4.main_menu_btn, "3_0"))

			gamecore.util_func.setTextHorizonInfo(var_21_0.item_btn_2.title_mask, var_0_2:getNowLang("research_name"))

			var_21_0.item_btn_2.icon.image.sprite = self:loadSprite(var_0_3(var_0_4.main_menu_btn, "2_2"))
		end
	end

	function arg_1_0:_play_into_se(arg_22_1)
		self:playSE(arg_22_1, false)
	end

	function arg_1_0:__onReset()
		self._control.content.toggle_group.mall.checkMark:SetActive(false)
		self._control.content.toggle_group.activity.checkMark:SetActive(false)
		self._control.content.toggle_group.build.checkMark:SetActive(false)
		self._control.content.toggle_group.remake.checkMark:SetActive(false)
		self._control.content.toggle_group.cardbookui.checkMark:SetActive(false)
		self._control.content.toggle_group.friend.checkMark:SetActive(false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_24_0)
	local var_24_0 = var_0_1:class("main_menu")

	var_24_0._now_label = nil
	var_24_0._now_content = nil
	var_24_0._arrow_open = false
	var_24_0._arrow = nil

	return var_24_0
end

return var_0_0
