local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gameenum.common_type
local var_0_4 = UnityEngine.Vector3

gamecore.UILoader:define("msgbox_image_simlpe", function(arg_1_0)
	function arg_1_0:Show_Info(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))

		self._confirm_func = arg_2_2
		self._cancel_func = arg_2_3
		self._control.main.title.text.text = arg_2_4

		self:__init_panel()

		self._control.main.confirm.image.sprite = self:loadSprite("data/ui/common/common_btn_bg.png")
		self._control.main.confirm.text.text.color = Color.New(0.2, 0.2, 0.2)
		self._control.main.back.image.sprite = self:loadSprite("data/ui/common/common_btn_bg_14.png")
		self._control.main.back.text.text.color = Color.New(1, 1, 1)
		self._control.main.confirm.text.text.text = var_0_1:getNowLang("ui_cbtn1")
		self._control.main.back.text.text.text = var_0_1:getNowLang("ui_cbtn2")
		self._control.main.reduce_cd.title.text.text = arg_2_1

		self:setVisible(true)
	end

	function arg_1_0:__init_panel()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))
		self._control.main.title.three_point.gameObject:SetActive(true)
		self._control.main.reduce_cd:SetActive(true)
		self._control.main:SetActive(true)

		self._control.main.transform.localScale = var_0_4.New(1, 1, 1)

		self._control.main.back:SetActive(true)
		self._control.main.confirm:SetActive(true)
		self._control.main.reduce_cd:SetActive(true)
	end

	function arg_1_0:__onClick_main_confirm()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))

		local var_4_0 = self._confirm_func

		self._confirm_func = nil

		var_0_3:play_in_out_animation(self._control.emptybox.uITweenSequence, false, function()
			if var_4_0 then
				var_4_0()
			end

			self:setVisible(false)
		end)
	end

	function arg_1_0:__onClick_main_back()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))

		local var_6_0 = self._cancel_func

		self._cancel_func = nil

		var_0_3:play_in_out_animation(self._control.emptybox.uITweenSequence, false, function()
			self:setVisible(false)

			if var_6_0 then
				var_6_0()
			end
		end)
	end

	function arg_1_0:_play_into_se(arg_8_1)
		self:playSE(arg_8_1, false)
	end
end)

function var_0_0.create(arg_9_0)
	local var_9_0 = var_0_2:class("msgbox_image_simlpe")

	var_9_0._confirm_func = nil
	var_9_0._cancel_func = nil

	var_9_0:__registerClickEvent("main/back")
	var_9_0:__registerClickEvent("main/confirm")

	return var_9_0
end

return var_0_0
