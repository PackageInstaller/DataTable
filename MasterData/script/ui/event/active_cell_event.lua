local var_0_0 = {}
local var_0_1 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onClick_pic_icon(arg_2_0)
		local var_2_0 = var_0_1:getInstance("gotofight")

		if var_2_0 then
			var_2_0:setVisible(false)
		end

		;(var_0_1:getInstance("home") or var_0_1:createInstance("home")):__six_acticity_enter_event()
	end
end

function var_0_0.extend_obj(arg_3_0)
	return
end

return var_0_0
