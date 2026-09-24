local var_0_0 = {}
local var_0_1 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onScaleButtonClick_top_layer_returnbtn()
		self:setVisible(false)

		local var_2_0 = var_0_1:getInstance("dorm_warehouse")

		if var_2_0 then
			var_2_0:show()
		end
	end
end

function var_0_0.extend_obj(arg_3_0)
	return
end

return var_0_0
