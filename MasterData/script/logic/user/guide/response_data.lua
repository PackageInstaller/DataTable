local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.error_type
local var_0_3 = gamecore.prompt

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.SaveGuideResp(arg_2_0, arg_2_1)
		if arg_2_1.result == 0 then
			local var_2_0 = var_0_1:getInstance("home")

			if var_2_0 and var_2_0:get_guide_task_state() then
				var_2_0:set_guide_task_state(false)
				var_0_1:createInstance("guide_panel"):show()
			end
		else
			var_0_3:show(var_0_2:get_err_msg(arg_2_1.result))
		end
	end
end

function var_0_0.extend_obj(arg_3_0)
	return
end

return var_0_0
