local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_6 = UnityEngine.Canvas

gamecore.UILoader:define("addiction_box", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self._data = arg_2_1

		self:setVisible(true)
		self:__init_panel()

		self._panel:GetComponent(typeof(var_0_6)).sortingOrder = 9000
	end

	function arg_1_0.__init_panel(arg_3_0)
		return
	end

	function arg_1_0:_play_into_se(arg_4_1)
		self:playSE(arg_4_1, false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_5_0)
	local var_5_0 = var_0_2:class("addiction_box")

	gamecore.extend_obj(var_5_0)

	return var_5_0
end

return var_0_0
