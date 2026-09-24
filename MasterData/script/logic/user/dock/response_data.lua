local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.error_type
local var_0_3 = gamecore.prompt
local var_0_4 = lx.json_decode
local var_0_5 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.BuildShipResp(arg_2_0, arg_2_1)
		if arg_2_1.result == 0 then
			var_0_1:createInstance("dock_bet"):hide(function()
				local var_3_0 = var_0_1:getInstance("dock")

				if var_3_0 then
					var_3_0:setVisible(true)
				else
					var_0_1:createInstance("dock"):show()
				end
			end)
		else
			var_0_3:show(var_0_2:get_err_msg(arg_2_1.result))
		end
	end

	function arg_1_0.BuildEquipmentResp(arg_4_0, arg_4_1)
		if arg_4_1.result == 0 then
			var_0_1:createInstance("dock_bet"):hide(function()
				local var_5_0 = var_0_1:getInstance("dock")

				if var_5_0 then
					var_5_0:setVisible(true)
				else
					var_0_1:createInstance("dock"):show()
				end
			end)
		else
			var_0_3:show(var_0_2:get_err_msg(arg_4_1.result))
		end
	end

	function arg_1_0.GetBuildShipRewardResp(arg_6_0, arg_6_1)
		if arg_6_1.result == 0 then
			var_0_1:createInstance("new_ship_or_equip"):show(true, arg_6_1.reward, var_0_5.enter_get_ship_type.dock_building)

			local var_6_0 = var_0_1:getInstance("dock")

			if var_6_0 then
				var_6_0:on_GetBuildShipReward_resp()
			end
		else
			var_0_3:show(var_0_2:get_err_msg(130))
		end
	end

	function arg_1_0.GetBuildEquipmentRewardResp(arg_7_0, arg_7_1)
		if arg_7_1.result == 0 then
			var_0_1:createInstance("new_ship_or_equip"):show(true, arg_7_1.reward)
		else
			var_0_3:show(var_0_2:get_err_msg(arg_7_1.result))
		end
	end

	function arg_1_0.QuickBuildShipResp(arg_8_0, arg_8_1)
		if arg_8_1.result == 0 then
			local var_8_0 = var_0_1:getInstance("dock")

			if var_8_0 then
				var_8_0:update_data()
			end
		else
			var_0_3:show(var_0_2:get_err_msg(arg_8_1.result))
		end
	end

	function arg_1_0.QuickBuildEquipmentResp(arg_9_0, arg_9_1)
		if arg_9_1.result == 0 then
			local var_9_0 = var_0_1:getInstance("dock")

			if var_9_0 then
				var_9_0:update_data()
			end
		else
			var_0_3:show(var_0_2:get_err_msg(arg_9_1.result))
		end
	end

	function arg_1_0.BatchBuildShipResp(arg_10_0, arg_10_1)
		if arg_10_1.result == 0 then
			var_0_1:createInstance("new_ship_or_equip"):show(true, arg_10_1.reward, var_0_5.enter_get_ship_type.dock_building)

			local var_10_0 = var_0_1:getInstance("dock")

			if var_10_0 then
				var_10_0:update_data()
			end

			local var_10_1 = var_0_1:getInstance("dock_bet")

			if var_10_1 then
				var_10_1:__init_data()
			end
		else
			var_0_3:show(var_0_2:get_err_msg(arg_10_1.result))
		end
	end

	function arg_1_0.BatchBuildEquipmentResp(arg_11_0, arg_11_1)
		if arg_11_1.result == 0 then
			var_0_1:createInstance("new_ship_or_equip"):show(true, arg_11_1.reward)

			local var_11_0 = var_0_1:getInstance("dock")

			if var_11_0 then
				var_11_0:update_data()
			end

			local var_11_1 = var_0_1:getInstance("dock_bet")

			if var_11_1 then
				var_11_1:__init_data()
			end
		else
			var_0_3:show(var_0_2:get_err_msg(arg_11_1.result))
		end
	end

	function arg_1_0.DecomposeShipResp(arg_12_0, arg_12_1)
		if arg_12_1.result == 0 then
			local var_12_0 = var_0_1:getInstance("dock")

			if var_12_0 then
				var_12_0:update_user_res_data(true)
				var_12_0:update_data()
				var_12_0:clear_disassemble_data()
			end
		else
			var_0_3:show(var_0_2:get_err_msg(arg_12_1.result))
		end
	end

	function arg_1_0.DecomposeEquipmentResp(arg_13_0, arg_13_1)
		if arg_13_1.result == 0 then
			local var_13_0 = var_0_1:getInstance("dock")

			if var_13_0 then
				var_13_0:update_user_res_data(true)
				var_13_0:update_data()
			end
		else
			var_0_3:show(var_0_2:get_err_msg(arg_13_1.result))
		end
	end

	function arg_1_0.DecomposeCoreResp(arg_14_0, arg_14_1)
		if arg_14_1.result == 0 then
			local var_14_0 = var_0_1:getInstance("core_list")

			if var_14_0 then
				var_14_0:update_data()
			end
		else
			var_0_3:show(var_0_2:get_err_msg(arg_14_1.result))
		end
	end

	function arg_1_0:BuildRecordResp(arg_15_1)
		var_0_1:getInstance("loading"):show(false)

		if arg_15_1.result == 0 then
			self._build_records[arg_15_1.type] = var_0_4(arg_15_1.records)

			var_0_1:createInstance("dock_log"):show(arg_15_1.type)
		else
			var_0_3:show(var_0_2:get_err_msg(arg_15_1.result))
		end
	end

	function arg_1_0.CollectBuildRecordResp(arg_16_0, arg_16_1)
		if arg_16_1.result == 0 then
			local var_16_0 = var_0_1:getInstance("dock_log")

			if var_16_0 then
				var_16_0:update_data()
			end
		else
			var_0_3:show(var_0_2:get_err_msg(arg_16_1.result))
		end
	end

	function arg_1_0.DeleteBuildRecordResp(arg_17_0, arg_17_1)
		if arg_17_1.result == 0 then
			local var_17_0 = var_0_1:getInstance("dock_log")

			if var_17_0 then
				var_17_0:update_data()
			end
		else
			var_0_3:show(var_0_2:get_err_msg(arg_17_1.result))
		end
	end

	function arg_1_0.SimulatedBuildResp(arg_18_0, arg_18_1)
		if arg_18_1.result == 0 then
			local var_18_0 = var_0_1:getInstance("ship_available")

			if var_18_0 then
				var_18_0:show(arg_18_1.type, arg_18_1.cids)
			else
				var_0_1:createInstance("ship_available"):show(arg_18_1.type, arg_18_1.cids)
			end
		else
			var_0_3:show(var_0_2:get_err_msg(arg_18_1.result))
		end
	end
end

function var_0_0.extend_obj(arg_19_0)
	return
end

return var_0_0
