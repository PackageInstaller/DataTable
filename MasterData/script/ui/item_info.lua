local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = string.format
local var_0_4 = gameenum.common_type

gamecore.UILoader:define("item_info", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
		self:setVisible(true)
		self:__init_panel(arg_2_1)
	end

	function arg_1_0.set_listener(arg_3_0, arg_3_1, arg_3_2)
		arg_3_0._confirm_listener = arg_3_1
		arg_3_0._close_listener = arg_3_2
	end

	function arg_1_0:_play_into_se(arg_4_1)
		self:playSE(arg_4_1, false)
	end

	function arg_1_0:__init_panel(arg_5_1)
		var_0_4:play_in_out_animation(self._control.maskbg.uITweenSequence, true)

		local var_5_0 = self._control.main

		self._control.main.title.text.text = var_0_1:getNowLang("shopitemdetailinfotitle")
		var_5_0.detailsbtn.text.text.text = var_0_1:getNowLang("detailinfo")
		var_5_0.rewardone.reward.image.sprite = self:loadSprite(var_0_3(var_0_4.icon.item_icon, arg_5_1.icon))
		var_5_0.main_text.title.text.text = arg_5_1.title
		var_5_0.main_text.describe.text.text = arg_5_1.describe

		var_5_0.main_text.describe.nonBreakingSpaceTextComponent:SetMyText()
		var_5_0.detailsbtn:SetActive(arg_5_1.type == var_0_4.mall_layer_type.layer_other)
		var_5_0.rewardone.line:SetActive(arg_5_1.type == var_0_4.mall_layer_type.layer_other)

		self._item_id = tonumber(arg_5_1.icon)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_6_0)
	local var_6_0 = var_0_2:class("item_info")

	var_6_0._item_id = nil
	var_6_0._confirm_listener = nil
	var_6_0._close_listener = nil

	return var_6_0
end

return var_0_0
