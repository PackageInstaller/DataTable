local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.prompt
local var_0_3 = gameenum.error_type
local var_0_4 = gamecore.Language

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.SetCookStyleResp(arg_2_0, arg_2_1)
		if arg_2_1.result == 0 then
			local var_2_0 = var_0_1:getInstance("restaurant_change_style")

			if not var_2_0 then
				return
			end

			var_2_0:set_style_success()
		else
			var_0_2:show(var_0_3:get_err_msg(arg_2_1.result))
		end
	end

	function arg_1_0.SetCookBookResp(arg_3_0, arg_3_1)
		if arg_3_1.result == 0 then
			local var_3_0 = var_0_1:getInstance("restaurant_setting")

			if not var_3_0 then
				return
			end

			var_3_0:update_cookbook_list()
			var_3_0:update_cookbook_used_list()
		else
			var_0_2:show(var_0_4:getNowLang("recipe_full"))
		end
	end

	function arg_1_0.RemoveCookBookResp(arg_4_0, arg_4_1)
		if arg_4_1.result == 0 then
			local var_4_0 = var_0_1:getInstance("restaurant_setting")

			if not var_4_0 then
				return
			end

			var_4_0:update_cookbook_list()
			var_4_0:update_cookbook_used_list()
		else
			var_0_2:show(var_0_3:get_err_msg(arg_4_1.result))
		end
	end

	function arg_1_0:SetChefResp(arg_5_1)
		if arg_5_1.result == 0 then
			local var_5_0 = var_0_1:getInstance("restaurant_setting")

			if self._cook_common then
				return
			end

			if not var_5_0 then
				return
			end

			var_5_0:show()
			var_0_2:show(var_0_4:getNowLang("cg_set"))
		else
			var_0_2:show(var_0_3:get_err_msg(arg_5_1.result))
		end
	end

	function arg_1_0.UseCookBookResp(arg_6_0, arg_6_1)
		if arg_6_1.result == 0 then
			local var_6_0 = var_0_1:getInstance("restaurant_cookinfo")

			if var_6_0 then
				var_6_0:setVisible(false)
			end

			local var_6_1 = var_0_1:getInstance("restaurant")

			if var_6_1 then
				var_6_1:show_cooking_result(arg_6_1.type)
			end
		elseif arg_6_1.result == 14 then
			var_0_2:show(var_0_4:getNowLang("errorcode_008"))
		else
			var_0_2:show(var_0_3:get_err_msg(arg_6_1.result))
		end
	end

	function arg_1_0.UseFriendCookBookResp(arg_7_0, arg_7_1)
		if arg_7_1.result == 0 then
			local var_7_0 = var_0_1:getInstance("restaurant")

			if var_7_0 then
				var_7_0:show_cooking_result(arg_7_1.type)
			end

			local var_7_1 = var_0_1:getInstance("restaurant_cookinfo")

			if var_7_1 then
				var_7_1:setVisible(false)
			end
		else
			var_0_2:show(var_0_3:get_err_msg(arg_7_1.result))
		end
	end
end

function var_0_0.extend_obj(arg_8_0)
	return
end

return var_0_0
