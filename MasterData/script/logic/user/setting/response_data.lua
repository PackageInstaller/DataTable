local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.prompt
local var_0_3 = gamecore.Language
local var_0_4 = gameenum.error_type
local var_0_5 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:RedeemCodeResp(arg_2_1)
		if arg_2_1.result == 0 then
			local var_2_0 = var_0_1:getInstance("setting")

			if var_2_0 then
				var_2_0._control.exchange:SetActive(false)
			end

			self:__get_present_success(arg_2_1.reward)
		elseif arg_2_1.result == var_0_4.RET_INVALID_REDEEM_CODE then
			var_0_2:show(var_0_3:getNowLang("errorcode-1201"))
		else
			var_0_2:show(var_0_4:get_err_msg(arg_2_1.result))
		end
	end

	function arg_1_0.__get_present_success(arg_3_0, arg_3_1)
		if var_0_1:getInstance("setting") then
			var_0_1:destroyInstance("setting")
		end

		var_0_1:createInstance("mail_box"):show_awards_enter_from_other_ways(arg_3_1, var_0_5.enter_get_ship_type.present_exchange)
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
