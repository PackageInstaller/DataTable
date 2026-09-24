local var_0_0 = {}
local var_0_1 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_ShipRepairReq(arg_2_0, arg_2_1)
		var_0_1:sendMsg("user.ShipRepairReq", {
			id = arg_2_1.id,
			room_id = arg_2_1.room_id
		})
	end

	function arg_1_0.req_QuickRepairReq(arg_3_0, arg_3_1)
		var_0_1:sendMsg("user.QuickRepairReq", {
			id_array = arg_3_1
		})
	end

	function arg_1_0.req_RubBackReq(arg_4_0, arg_4_1)
		var_0_1:sendMsg("user.RubBackReq", {
			id = arg_4_1
		})
	end

	function arg_1_0.req_ChangeRepairStyleReq(arg_5_0, arg_5_1)
		var_0_1:sendMsg("user.ChangeRepairStyleReq", {
			id = arg_5_1
		})
	end

	function arg_1_0.req_ChangeRoomStyleReq(arg_6_0, arg_6_1)
		var_0_1:sendMsg("user.ChangeRoomStyleReq", arg_6_1)
	end

	function arg_1_0.req_MultiShipRepairReq(arg_7_0, arg_7_1)
		var_0_1:sendMsg("user.MultiShipRepairReq", {
			ship_array = arg_7_1
		})
	end
end

function var_0_0.extend_obj(arg_8_0)
	return
end

return var_0_0
