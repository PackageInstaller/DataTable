local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader

gamecore.UILoader:define("diamon_bounced", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)

		self._data = arg_2_1

		self:__init_panel()
	end

	function arg_1_0:__init_panel()
		self._control.main.title.text.text = var_0_1:getNowLang("ui_rewardtitle")
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_4_0)
	local var_4_0 = var_0_2:class("diamon_bounced")

	var_4_0._data = 0

	return var_4_0
end

return var_0_0
