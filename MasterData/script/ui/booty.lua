local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader

gamecore.UILoader:define("booty", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:__init_panel()
		self._control.numberof.text.text = var_0_1:getNowLang("limit_left")
		self._control.typename.text.text = var_0_1:getNowLang("trophytype1")
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_4_0)
	return (var_0_2:class("booty"))
end

return var_0_0
