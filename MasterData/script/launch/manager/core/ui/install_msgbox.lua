local var_0_0 = {}
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader

gamecore.UILoader:define("install_msgbox", function(arg_1_0)
	function arg_1_0:showOne(arg_2_1, arg_2_2, arg_2_3)
		arg_2_3 = arg_2_3 or var_0_2:get("确认")
		self._one_func = arg_2_2

		self._control.one.gameObject:SetActive(true)

		self._control.desc.text = arg_2_1
		self._control.one_text.text = arg_2_3

		self:setVisible(true)
	end

	function arg_1_0:__onClick_background_one()
		self._one_func = nil

		self:setVisible(false)

		if self._one_func then
			self._one_func()
		end
	end
end)

function var_0_0.create(arg_4_0)
	local var_4_0 = var_0_3:class("install_msgbox")

	var_4_0._one_func = nil

	var_4_0:__registerControl("background/desc", UnityEngine.UI.Text, "desc")
	var_4_0:__registerControl("background/one/text", UnityEngine.UI.Text, "one_text")
	var_4_0:__registerControl("background/one", UnityEngine.UI.Button, "one")
	var_4_0:__registerClickEvent("background/one")

	return var_4_0
end

return var_0_0
