local var_0_0 = {}
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader

gamecore.UILoader:define("change_user_layer", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)

		self._now_change_data = arg_2_1

		self:__init_panel()
	end

	function arg_1_0:__init_panel()
		self._control.main.title.text.text = var_0_2:getNowLang("renametitle")
		self._control.main.confirmbtn.text.text.text = var_0_2:getNowLang("chest_got_agree")
		self._control.main.gogo.use.text.text = var_0_2:getNowLang("renameattention")
		self._control.main.InputField.inputField.text = ""
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_4_0)
	local var_4_0 = var_0_3:class("change_user_layer")

	var_4_0._now_change_data = {}
	var_4_0._text_str = ""

	return var_4_0
end

return var_0_0
