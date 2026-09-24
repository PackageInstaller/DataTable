local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.prompt
local var_0_3 = gameenum.error_type
local var_0_4 = table.insert
local var_0_5 = gamecore.Language

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:UseItemBoxResp(arg_2_1)
		if arg_2_1.result == 0 then
			local var_2_0 = self:get_box_result()
			local var_2_1 = {}

			for iter_2_0, iter_2_1 in pairs(arg_2_1.reward) do
				for iter_2_2 = 1, iter_2_1.count do
					if iter_2_1.type == 5 then
						var_0_4(var_2_1, {
							id = iter_2_1.id,
							type = iter_2_1.type,
							is_new = iter_2_1.is_new,
							item_id = var_2_0[iter_2_0].id,
							lock = var_2_0[iter_2_0].lock
						})
					elseif iter_2_1.type == 6 then
						var_0_4(var_2_1, {
							id = iter_2_1.id,
							type = iter_2_1.type,
							is_new = iter_2_1.is_new
						})
					end
				end
			end

			local var_2_2 = var_0_1:getInstance("chest_open_layer")

			if not var_2_2 then
				return
			end

			var_2_2:chest_open_result(var_2_1)
		else
			var_0_2:show(var_0_3:get_err_msg(arg_2_1.result))
		end

		self:reset_box_result_flag()
	end

	function arg_1_0.ChangeMansionStyleResp(arg_3_0, arg_3_1)
		if arg_3_1.result == 0 then
			local var_3_0 = var_0_1:getInstance("captainroom_change_style")

			if var_3_0 then
				var_3_0:show_style_layer(false)
			end

			local var_3_1 = var_0_1:getInstance("captainroom")

			if var_3_1 then
				var_3_1:show()
			end
		else
			var_0_2:show(var_0_3:get_err_msg(arg_3_1.result))
		end
	end

	function arg_1_0.ChangeSignatureResp(arg_4_0, arg_4_1)
		if arg_4_1.result == 0 then
			-- block empty
		else
			var_0_2:show(var_0_3:get_err_msg(arg_4_1.result))
		end
	end

	function arg_1_0.ChangeChatHeadResp(arg_5_0, arg_5_1)
		if arg_5_1.result == 0 then
			local var_5_0 = var_0_1:getInstance("captainroom")
			local var_5_1 = var_0_1:getInstance("user_info")

			if var_5_0 then
				var_5_0:set_chat_head()
				var_0_2:show(var_0_5:getNowLang("changeavatarok"))
			elseif var_5_1 then
				var_5_1:set_head_icon()
				var_0_2:show(var_0_5:getNowLang("changeavatarok"))
			end
		else
			var_0_2:show(var_0_3:get_err_msg(arg_5_1.result))
		end
	end

	function arg_1_0.SaveGarrisonResp(arg_6_0, arg_6_1)
		if arg_6_1.result == 0 then
			local var_6_0 = var_0_1:getInstance("captainroom_fleet")

			if var_6_0 then
				var_6_0:show_layer(true)
				var_6_0:set_fleet_list()
			end

			local var_6_1 = var_0_1:getInstance("select_member")

			if var_6_1 then
				var_6_1:setVisible(false)
			end
		else
			var_0_2:show(var_0_3:get_err_msg(arg_6_1.result))
		end
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
