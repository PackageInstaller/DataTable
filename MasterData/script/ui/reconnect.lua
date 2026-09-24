local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader

gamecore.UILoader:define("reconnect", function(arg_1_0)
	function arg_1_0:__onVisible(arg_2_1, ...)
		if arg_2_1 then
			self._control.info.text.text = var_0_1:getNowLang("re_connect")
		end
	end
end)

function var_0_0.create(arg_3_0)
	return (var_0_2:class("reconnect"))
end

return var_0_0
