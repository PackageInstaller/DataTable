local var_0_0 = {}
local var_0_1 = gamecore.UILoader

gamecore.UILoader:define("profile", function(arg_1_0)
	function arg_1_0:start()
		self:setVisible(true)
	end

	function arg_1_0:stop()
		self:setVisible(false)
	end
end)

function var_0_0.create(arg_4_0)
	return (var_0_1:class("profile"))
end

return var_0_0
