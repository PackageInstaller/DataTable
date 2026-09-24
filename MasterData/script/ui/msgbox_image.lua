local var_0_0 = {}
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.util_func
local var_0_11 = UnityEngine.Vector3

gamecore.UILoader:define("msgbox_image", function(arg_1_0)
	function arg_1_0:Show_Info(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
		self._confirm_func = arg_2_2
		self._cancel_func = arg_2_3
		self._control.main.title.text.text = arg_2_4
		self._msg_type = arg_2_5

		self:setVisible(true)

		if arg_2_6 then
			self._control.main:SetActive(false)
			self._control.main_1:SetActive(true)

			self._control.main_1.confirm.text.text.text = var_0_2:getNowLang("ui_cbtn1")
			self._control.main_1.back.text.text.text = var_0_2:getNowLang("ui_cbtn2")
			self._control.main_1.title.text.text = var_0_2:getNowLang("settingquitgame")
			self._control.main_1.reduce_cd.title.text.text = var_0_2:getNowLang("exitgame")
			self._panel.transform:GetComponent("Canvas").sortingOrder = 1002

			return
		else
			self._control.main:SetActive(true)
			self._control.main_1:SetActive(false)
		end

		self:__init_panel(arg_2_1)

		self._control.main.confirm.image.sprite = self:loadSprite("data/ui/common/common_btn_bg.png")
		self._control.main.confirm.text.text.color = Color.New(0.2, 0.2, 0.2)
		self._control.main.back.image.sprite = self:loadSprite("data/ui/common/common_btn_bg_14.png")
		self._control.main.back.text.text.color = Color.New(1, 1, 1)
		self._control.main.confirm.text.text.text = var_0_2:getNowLang("ui_cbtn1")
		self._control.main.back.text.text.text = var_0_2:getNowLang("ui_cbtn2")
	end

	function arg_1_0:__init_panel(arg_3_1)
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
		self._control.main.title.three_point.gameObject:SetActive(true)
		self._control.main.reduce_cd:SetActive(true)
		self._control.main:SetActive(true)

		self._control.main.transform.localScale = var_0_11.New(1, 1, 1)

		self._control.main.back:SetActive(true)
		self._control.main.confirm:SetActive(true)
		self._control.main.reduce_cd:SetActive(true)

		self._control.main.reduce_cd.title.text.text = arg_3_1.title
		self._control.main.reduce_cd.item_1.title.text.text = arg_3_1.title_1
		self._control.main.reduce_cd.item_2.title.text.text = arg_3_1.title_2
		self._control.main.reduce_cd.item_1.cur.text.text = arg_3_1.cur_count
		self._control.main.reduce_cd.item_1.next.text.text = arg_3_1.cur_count - 1
		self._control.main.reduce_cd.item_2.cur.text.text = var_0_5.secondsToTime(arg_3_1.finish_time - lx.ServerTime:getUtcTime())
		self._control.main.reduce_cd.item_2.next.text.text = "00:00:00"
		self._finish_time = arg_3_1.finish_time
	end

	function arg_1_0:__onUpdate()
		if self._finish_time then
			self._control.main.reduce_cd.item_2.cur.text.text = var_0_5.secondsToTime(self._finish_time - lx.ServerTime:getUtcTime())
		end
	end

	function arg_1_0:__onClick_main_confirm()
		local var_5_0 = self._confirm_func

		self._confirm_func = nil

		var_0_4:play_in_out_animation(self._control.emptybox.uITweenSequence, false, function()
			if var_5_0 then
				var_5_0()
			end

			self:setVisible(false)
		end)
	end

	function arg_1_0:__onClick_main_back()
		local var_7_0 = self._cancel_func

		self._cancel_func = nil

		var_0_4:play_in_out_animation(self._control.emptybox.uITweenSequence, false, function()
			self:setVisible(false)

			if var_7_0 then
				var_7_0()
			end
		end)
	end

	function arg_1_0:__onClick_main_1_confirm()
		local var_9_0 = self._confirm_func

		self._confirm_func = nil

		var_0_4:play_in_out_animation(self._control.emptybox.uITweenSequence, false, function()
			if var_9_0 then
				var_9_0()
			end

			self:setVisible(false)
		end)
	end

	function arg_1_0:__onClick_main_1_back()
		local var_11_0 = self._cancel_func

		self._cancel_func = nil

		var_0_4:play_in_out_animation(self._control.emptybox.uITweenSequence, false, function()
			self:setVisible(false)

			if var_11_0 then
				var_11_0()
			end
		end)
	end

	function arg_1_0:_play_into_se(arg_13_1)
		self:playSE(arg_13_1, false)
	end

	function arg_1_0:get_guide_btn_pos_info(arg_14_1)
		if arg_14_1 == var_0_4.guide_const_id.second_group.two or arg_14_1 == var_0_4.guide_const_id.five_group.two or arg_14_1 == var_0_4.guide_const_id.five_group.four or arg_14_1 == var_0_4.guide_const_id.seven_group.two then
			return self._control.main.one.transform
		elseif arg_14_1 == var_0_4.guide_const_id.six_group.eight then
			return self._control.main.confirm.transform
		end
	end
end)

function var_0_0.create(arg_15_0)
	local var_15_0 = var_0_3:class("msgbox_image")

	var_15_0._confirm_func = nil
	var_15_0._cancel_func = nil
	var_15_0._finish_time = nil

	var_15_0:__registerClickEvent("main/back")
	var_15_0:__registerClickEvent("main/confirm")

	var_15_0._msg_type = nil

	return var_15_0
end

return var_0_0
