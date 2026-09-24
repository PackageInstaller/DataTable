local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type

gamecore.UILoader:define("firsttopup", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:play_in_animation(arg_3_1)
		self._control.bg.uITweenSequence:Play(function()
			if arg_3_1 then
				arg_3_1()
			end
		end)
	end

	function arg_1_0:play_out_animation(arg_5_1)
		self._control.bg.uITweenSequence:PlayReverse(function()
			if arg_5_1 then
				arg_5_1()
			end
		end)
	end

	function arg_1_0:__init_panel()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
		self:play_in_animation()

		self._control.main.character.image.sprite = self:loadSprite("data/ui/first_charge/first_charge_girl.png")
		self._control.main.rewardmain.rewardone.reward.image.sprite = self:loadSprite("data/ui/icon/2.png")
		self._control.main.rewardmain.rewardtwo.reward.image.sprite = self:loadSprite("data/ui/icon/3.png")
		self._control.main.rewardmain.rewardthree.reward.image.sprite = self:loadSprite("data/ui/icon/4.png")
		self._control.main.rewardmain.rewardfour.reward.image.sprite = self:loadSprite("data/ui/icon/9.png")
		self._control.main.rewardmain.rewardfive.reward.image.sprite = self:loadSprite("data/ui/icon/309.png")
		self._control.main.rewardmain.rewardsix.reward.image.sprite = self:loadSprite("data/ui/icon/310.png")
		self._control.main.rewardname.text.text = var_0_1:getNowLang("ui_firstchargereward")
		self._control.main.introduce.text.text = var_0_1:getNowLang("ui_firstchargeinfo")
		self._control.main.type.text.text = var_0_1:getNowLang("shiptypedetail4")
		self._control.main.charactername.text.text = var_0_1:getNowLang("ui_firstchargeship")
		self.user_info = var_0_3:get_use_info_data()

		if not self.user_info.first_get and not self.user_info.first_pay then
			self._control.main.gain.text.text.text = var_0_1:getNowLang("ui_firstchargetip")
		elseif not self.user_info.first_get and self.user_info.first_pay then
			self._control.main.gain.text.text.text = var_0_1:getNowLang("marketingbtnget")
		else
			self._control.main.gain.scaleButton.interactable = false
			self._control.main.gain.text.text.text = var_0_1:getNowLang("marketinghaveget")
		end
	end

	function arg_1_0:_play_into_se(arg_8_1)
		self:playSE(arg_8_1, false)
	end

	function arg_1_0.__onReset(arg_9_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_10_0)
	local var_10_0 = var_0_2:class("firsttopup")

	var_10_0._out = "firsttopup"
	var_10_0.user_info = nil

	gamecore.extend_obj(var_10_0)

	return var_10_0
end

return var_0_0
