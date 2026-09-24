local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gameenum.common_type
local var_0_5 = string.format

gamecore.UILoader:define("item_tip", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true, arg_2_1)
	end

	function arg_1_0:__onVisible(arg_3_1, arg_3_2)
		if not arg_3_1 then
			return
		end

		self:__init_panel(arg_3_2)
	end

	function arg_1_0:__init_panel(arg_4_1)
		self._control.content.title.text.text = var_0_1:getNowLang("shopitemdetailinfotitle")

		self._control.content.detail:SetActive(false)

		self._control.content.detail.detail_btn.text.text.text = var_0_1:getNowLang("detailinfo")
		self._control.content.icon.image.sprite = self:loadSprite(var_0_5(var_0_3.icon.item_icon, arg_4_1.cid))
		self._control.content.item_title.text.text = arg_4_1.title
		self._control.content.desc.text.text = arg_4_1.desc

		var_0_3:play_in_out_animation(self._control.bg.uITweenSequence, true)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_5_0)
	return (var_0_2:class("item_tip"))
end

return var_0_0
