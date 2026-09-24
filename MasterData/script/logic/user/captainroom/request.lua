local var_0_0 = {}
local var_0_1 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:req_UseItemBox(arg_2_1)
		var_0_1:sendMsg("user.UseItemBoxReq", {
			id = arg_2_1.id,
			num = arg_2_1.count
		})
		self:clear_box_result()
	end

	function arg_1_0.req_ChangeMansionStyleReq(arg_3_0, arg_3_1)
		var_0_1:sendMsg("user.ChangeMansionStyleReq", {
			id = arg_3_1
		})
	end

	function arg_1_0.req_ChangeSignatureReq(arg_4_0, arg_4_1)
		var_0_1:sendMsg("user.ChangeSignatureReq", {
			signature = arg_4_1
		})
	end

	function arg_1_0.req_ChangeChatHeadReq(arg_5_0, arg_5_1)
		var_0_1:sendMsg("user.ChangeChatHeadReq", {
			id = arg_5_1
		})
	end

	function arg_1_0.req_SaveGarrisonReq(arg_6_0, arg_6_1)
		var_0_1:sendMsg("user.SaveGarrisonReq", {
			members = arg_6_1
		})
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
