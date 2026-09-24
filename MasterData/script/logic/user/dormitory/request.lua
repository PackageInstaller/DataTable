local var_0_0 = {}
local var_0_1 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_LayoutRoomReq(arg_2_0, arg_2_1)
		var_0_1:sendMsg("user.LayoutRoomReq", arg_2_1)
	end

	function arg_1_0.req_ShipEnterRoomReq(arg_3_0, arg_3_1)
		var_0_1:sendMsg("user.ShipEnterRoomReq", arg_3_1)
	end

	function arg_1_0.req_getFurnitureCoollectRewardReq(arg_4_0, arg_4_1)
		var_0_1:sendMsg("user.getFurnitureCoollectRewardReq", arg_4_1)
	end

	function arg_1_0.req_BuyFurnitureBoxReq(arg_5_0, arg_5_1)
		var_0_1:sendMsg("user.BuyFurnitureBoxReq", {
			id = arg_5_1.id
		})
	end

	function arg_1_0.req_MultiBuyFurnitureBoxReq(arg_6_0, arg_6_1)
		var_0_1:sendMsg("user.MultiBuyFurnitureBoxReq", {
			id = arg_6_1.id,
			num = arg_6_1.count
		})
	end

	function arg_1_0.req_LockFurnitureReq(arg_7_0, arg_7_1)
		var_0_1:sendMsg("user.LockFurnitureReq", {
			id = arg_7_1.id
		})
	end

	function arg_1_0.req_ResolveFurnitureReq(arg_8_0, arg_8_1)
		var_0_1:sendMsg("user.ResolveFurnitureReq", {
			id_set = arg_8_1
		})
	end

	function arg_1_0.req_GetExhibitionReq(arg_9_0, arg_9_1)
		var_0_1:sendMsg("user.GetExhibitionReq", {})
	end

	function arg_1_0.req_AddExhibitionCollectReq(arg_10_0, arg_10_1)
		var_0_1:sendMsg("user.AddExhibitionCollectReq", arg_10_1)
	end

	function arg_1_0.req_RemoveExhibitionCollectReq(arg_11_0, arg_11_1)
		var_0_1:sendMsg("user.RemoveExhibitionCollectReq", arg_11_1)
	end

	function arg_1_0.req_EvaluateExhibitionReq(arg_12_0, arg_12_1)
		var_0_1:sendMsg("user.EvaluateExhibitionReq", arg_12_1)
	end

	function arg_1_0.req_UserExhibitionReq(arg_13_0, arg_13_1)
		var_0_1:sendMsg("user.UserExhibitionReq", arg_13_1)
	end

	function arg_1_0.req_RecordRoomReq(arg_14_0, arg_14_1)
		var_0_1:sendMsg("user.RecordRoomReq", arg_14_1)
	end

	function arg_1_0.req_UseRecordReq(arg_15_0, arg_15_1)
		var_0_1:sendMsg("user.UseRecordReq", arg_15_1)
	end

	function arg_1_0.req_UploadRecordReq(arg_16_0, arg_16_1)
		var_0_1:sendMsg("user.UploadRecordReq", arg_16_1)
	end

	function arg_1_0.req_ResetRecordReq(arg_17_0, arg_17_1)
		var_0_1:sendMsg("user.ResetRecordReq", arg_17_1)
	end

	function arg_1_0.req_RoomExtendReq(arg_18_0)
		var_0_1:sendMsg("user.RoomExtendReq", {})
	end

	function arg_1_0.req_RoomInteractReq(arg_19_0, arg_19_1)
		var_0_1:sendMsg("user.RoomInteractReq", arg_19_1)
	end

	function arg_1_0.req_RoomCropReq(arg_20_0, arg_20_1)
		var_0_1:sendMsg("user.RoomCropReq", arg_20_1)
	end

	function arg_1_0.req_RacingReq(arg_21_0, arg_21_1)
		var_0_1:sendMsg("user.RacingReq", arg_21_1)
	end

	function arg_1_0.req_DollMachineReq(arg_22_0)
		var_0_1:sendMsg("user.DollMachineReq", {})
	end
end

function var_0_0.extend_obj(arg_23_0)
	return
end

return var_0_0
