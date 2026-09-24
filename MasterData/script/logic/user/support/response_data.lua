local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.error_type
local var_0_3 = gamecore.prompt
local var_0_4 = gamecore.Language

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.ChangeRankSupportResp(arg_2_0, arg_2_1)
		if arg_2_1.result == 0 then
			local var_2_0 = var_0_1:getInstance("supportlist")

			if var_2_0 then
				var_2_0:__update_panel_info()
			end

			local var_2_1 = var_0_1:getInstance("fight_prepare")

			if var_2_1 then
				var_2_1:update_support_change()
			end
		else
			var_0_3:show(var_0_2:get_err_msg(arg_2_1.result))
		end
	end

	function arg_1_0.SupportLevelUpResp(arg_3_0, arg_3_1)
		local var_3_0 = var_0_1:getInstance("support_info")

		var_3_0:uplevel(true)
		var_0_1:getInstance("gotofight"):support_up_level()

		if arg_3_1.result == 0 then
			if var_3_0 then
				var_0_3:show(var_0_4:getNowLang("levelupsuccess"))
				var_3_0:_update_panel_info()
			end
		else
			var_0_3:show(var_0_2:get_err_msg(arg_3_1.result))
		end
	end

	function arg_1_0.ReadRankSupportResp(arg_4_0, arg_4_1)
		if arg_4_1.result == 0 then
			local var_4_0 = var_0_1:getInstance("supportlist")

			if var_4_0 then
				var_4_0:__update_panel_info(true)
			end
		end
	end

	function arg_1_0.ActiveRankSupportResp(arg_5_0, arg_5_1)
		if arg_5_1.result == 0 then
			local var_5_0 = var_0_1:getInstance("fight_prepare")

			if var_5_0 then
				var_5_0:__update_support_active_info()
			end
		end
	end

	function arg_1_0.SupportSupplyResp(arg_6_0, arg_6_1)
		if arg_6_1.result == 0 then
			local var_6_0 = var_0_1:getInstance("fight_prepare")

			if var_6_0 then
				var_6_0:__set_support_data()
				var_6_0:__set_total_supply_panel_data()
			end
		end
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
