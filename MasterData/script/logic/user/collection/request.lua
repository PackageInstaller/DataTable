local var_0_0 = {}
local var_0_1 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_ChangeWallCollectionReq(arg_2_0, arg_2_1)
		var_0_1:sendMsg("user.ChangeWallCollectionReq", {
			index = arg_2_1.index,
			id = arg_2_1.id
		})
	end

	function arg_1_0.req_ChangeDeskCollectionReq(arg_3_0, arg_3_1)
		var_0_1:sendMsg("user.ChangeDeskCollectionReq", {
			index = arg_3_1.index,
			id = arg_3_1.id
		})
	end

	function arg_1_0.req_ChangeMedalReq(arg_4_0, arg_4_1)
		var_0_1:sendMsg("user.ChangeMedalReq", {
			id_array = arg_4_1
		})
	end

	function arg_1_0.req_UpgradeMedalReq(arg_5_0, arg_5_1)
		var_0_1:sendMsg("user.UpgradeMedalReq", {
			id = arg_5_1.id
		})
	end

	function arg_1_0.req_ChangeBoxroomStyleReq(arg_6_0, arg_6_1)
		var_0_1:sendMsg("user.ChangeBoxroomStyleReq", {
			id = arg_6_1
		})
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
