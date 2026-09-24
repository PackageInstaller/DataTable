local var_0_0 = {}
local var_0_2 = gamecore.UILoader

gamecore.UILoader:define("mail_item", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0.__init_panel(arg_3_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_4_0)
	return (var_0_2:class("mail_item"))
end

return var_0_0
