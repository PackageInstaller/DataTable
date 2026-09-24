local var_0_0 = {}
local var_0_2 = gamecore.UILoader

gamecore.UILoader:define("taskmodel", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:__init_panel()
		self._contents = {
			self._control.taskreward.rewartypeone,
			self._control.taskreward.rewartypetwo,
			self._control.taskreward.rewartypethree,
			self._control.taskreward.rewartypefour,
			self._control.taskreward.rewartypefive
		}
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_4_0)
	local var_4_0 = var_0_2:class("taskmodel")

	var_4_0._contents = {}

	return var_4_0
end

return var_0_0
