local var_0_0 = {}
local var_0_5 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_BuildShip(arg_2_0, arg_2_1)
		var_0_5:sendMsg("user.BuildShipReq", {
			pos_id = arg_2_1.pos_id,
			oil = arg_2_1.oil,
			bullet = arg_2_1.bullet,
			fe = arg_2_1.fe,
			al = arg_2_1.al
		})
	end

	function arg_1_0.req_BuildEquipment(arg_3_0, arg_3_1)
		var_0_5:sendMsg("user.BuildEquipmentReq", {
			pos_id = arg_3_1.pos_id,
			oil = arg_3_1.oil,
			bullet = arg_3_1.bullet,
			fe = arg_3_1.fe,
			al = arg_3_1.al
		})
	end

	function arg_1_0.req_GetBuildShipReward(arg_4_0, arg_4_1)
		var_0_5:sendMsg("user.GetBuildShipRewardReq", {
			pos_id = arg_4_1.pos_id
		})
	end

	function arg_1_0.req_GetBuildEquipmentReward(arg_5_0, arg_5_1)
		var_0_5:sendMsg("user.GetBuildEquipmentRewardReq", {
			pos_id = arg_5_1.pos_id
		})
	end

	function arg_1_0.req_QuickBuildShip(arg_6_0, arg_6_1)
		var_0_5:sendMsg("user.QuickBuildShipReq", {
			pos_id = arg_6_1.pos_id
		})
	end

	function arg_1_0.req_QuickBuildEquipment(arg_7_0, arg_7_1)
		var_0_5:sendMsg("user.QuickBuildEquipmentReq", {
			pos_id = arg_7_1.pos_id
		})
	end

	function arg_1_0.req_BatchBuildShip(arg_8_0, arg_8_1)
		var_0_5:sendMsg("user.BatchBuildShipReq", {
			count = arg_8_1.count,
			oil = arg_8_1.oil,
			bullet = arg_8_1.bullet,
			fe = arg_8_1.fe,
			al = arg_8_1.al
		})
	end

	function arg_1_0.req_BatchBuildEquipment(arg_9_0, arg_9_1)
		var_0_5:sendMsg("user.BatchBuildEquipmentReq", {
			count = arg_9_1.count,
			oil = arg_9_1.oil,
			bullet = arg_9_1.bullet,
			fe = arg_9_1.fe,
			al = arg_9_1.al
		})
	end

	function arg_1_0.req_DecomposeShip(arg_10_0, arg_10_1, arg_10_2)
		var_0_5:sendMsg("user.DecomposeShipReq", {
			id_array = arg_10_1,
			remove = arg_10_2
		})
	end

	function arg_1_0.req_DecomposeEquipment(arg_11_0, arg_11_1)
		var_0_5:sendMsg("user.DecomposeEquipmentReq", {
			equip_array = arg_11_1
		})
	end

	function arg_1_0.req_DecomposeCore(arg_12_0, arg_12_1)
		var_0_5:sendMsg("user.DecomposeCoreReq", {
			id = arg_12_1.id,
			count = arg_12_1.count
		})
	end

	function arg_1_0.req_BuildRecord(arg_13_0, arg_13_1)
		var_0_5:sendMsg("user.BuildRecordReq", {
			type = arg_13_1
		})
	end

	function arg_1_0.req_CollectBuildRecord(arg_14_0, arg_14_1)
		var_0_5:sendMsg("user.CollectBuildRecordReq", {
			type = arg_14_1.type,
			record = arg_14_1.record
		})
	end

	function arg_1_0.req_DeleteBuildRecord(arg_15_0, arg_15_1)
		var_0_5:sendMsg("user.DeleteBuildRecordReq", {
			id = arg_15_1.id,
			type = arg_15_1.type
		})
	end

	function arg_1_0.req_SimulatedBuildReq(arg_16_0, arg_16_1)
		var_0_5:sendMsg("user.SimulatedBuildReq", {
			oil = arg_16_1.oil,
			bullet = arg_16_1.bullet,
			fe = arg_16_1.fe,
			al = arg_16_1.al,
			type = arg_16_1.type
		})
	end
end

function var_0_0.extend_obj(arg_17_0)
	return
end

return var_0_0
