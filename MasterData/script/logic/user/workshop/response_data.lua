local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.prompt
local var_0_3 = gameenum.error_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.UpgradeWorkshopResp(arg_2_0, arg_2_1)
		if arg_2_1.result == 0 then
			local var_2_0 = var_0_1:getInstance("workshop")

			if var_2_0 then
				var_2_0:upgrade_workshop_resp()
			end
		else
			var_0_1:createInstance("loading"):show(false)
			var_0_2:show(var_0_3:get_err_msg(arg_2_1.result))
		end
	end
end

function var_0_0.extend_obj(arg_3_0)
	return
end

return var_0_0
