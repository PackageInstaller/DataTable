local var_0_0 = {}
local var_0_1 = gamecore.UILoader

gamecore.UILoader:define("eighth_sea_map_support", function(arg_1_0)
	function arg_1_0.__onUpdate(arg_2_0)
		return
	end

	function arg_1_0:show(arg_3_1)
		self:setVisible(true)
		self:__init_panel(arg_3_1)
	end

	function arg_1_0.__init_panel(arg_4_0, arg_4_1)
		return
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0.__initia_lize(arg_6_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_7_0)
	local var_7_0 = var_0_1:class("eighth_sea_map_support")

	var_7_0:__initia_lize()

	return var_7_0
end

return var_0_0
