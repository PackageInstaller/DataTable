local var_0_0 = {}
local var_0_1 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_main_school_btn()
		self:setVisible(false)
		var_0_1:getInstance("home"):setVisible(false)
		var_0_1:createInstance("living_areas"):show()
	end
end

function var_0_0.extend_obj(arg_3_0)
	return
end

return var_0_0
