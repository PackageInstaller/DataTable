local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.prompt
local var_0_3 = gameenum.error_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.ShipRepairResp(arg_2_0, arg_2_1)
		if arg_2_1.result == 0 then
			local var_2_0 = var_0_1:getInstance("bathroom_repair")

			if var_2_0 then
				var_2_0:setVisible(false)
			end

			local var_2_1 = var_0_1:getInstance("bathroom")

			if var_2_1 then
				var_2_1._allow_mouse_move = true

				var_2_1:ship_repaired_general(false)
			end
		else
			var_0_2:show(var_0_3:get_err_msg(arg_2_1.result))
		end
	end

	function arg_1_0.QuickRepairResp(arg_3_0, arg_3_1)
		local var_3_0 = var_0_1:getInstance("fight_prepare")

		if arg_3_1.result == 0 then
			local var_3_1 = var_0_1:getInstance("bathroom_repair")

			if var_3_1 then
				var_3_1:init_layer_info()
				var_3_1:init_repair_list()
			end

			local var_3_2 = var_0_1:getInstance("bathroom")

			if var_3_2 then
				var_3_2:quick_repair_resp()
			end

			if var_3_0 then
				var_3_0:ship_repair_refresh()
			end
		else
			var_0_2:show(var_0_3:get_err_msg(arg_3_1.result))
		end

		if var_3_0 then
			var_3_0:set_repair_btn_state(true)
		end
	end

	function arg_1_0.RubBackResp(arg_4_0, arg_4_1)
		if arg_4_1.result == 0 then
			local var_4_0 = var_0_1:getInstance("bathroom")

			if not var_4_0 then
				return
			end

			var_4_0:role_rub_resp()
		else
			var_0_2:show(var_0_3:get_err_msg(arg_4_1.result))
		end
	end

	function arg_1_0:ChangeRepairStyleResp(arg_5_1)
		if arg_5_1.result == 0 then
			local var_5_0 = var_0_1:getInstance("bathroom_change_style")

			if var_5_0 then
				var_5_0:change_style_resp()
			end

			local var_5_1 = var_0_1:getInstance("bathroom")

			if var_5_1 then
				var_5_1:set_bathroom_style()

				var_5_1._control.expantion_layer.expantion_count_txt.text.text = var_5_1:__get_basket_count() .. "/" .. #self:get_bathroom_style() * 4
			end
		else
			var_0_2:show(var_0_3:get_err_msg(arg_5_1.result))
		end
	end

	function arg_1_0.ChangeRoomStyleResp(arg_6_0, arg_6_1)
		if arg_6_1.result == 0 then
			local var_6_0 = var_0_1:getInstance("bathroom_change_style")

			if var_6_0 then
				var_6_0:change_style_resp()
			end

			local var_6_1 = var_0_1:getInstance("bathroom")

			if var_6_1 then
				var_6_1:changestyle_resp()
			end
		else
			var_0_2:show(var_0_3:get_err_msg(arg_6_1.result))
		end
	end

	function arg_1_0.MultiShipRepairResp(arg_7_0, arg_7_1)
		if arg_7_1.result == 0 then
			local var_7_0 = var_0_1:getInstance("bathroom_repair")

			if var_7_0 then
				var_7_0:setVisible(false)
			end

			local var_7_1 = var_0_1:getInstance("bathroom")

			if var_7_1 then
				var_7_1._allow_mouse_move = true

				var_7_1:ship_repaired_general(false)
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
