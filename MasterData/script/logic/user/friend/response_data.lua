local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.error_type
local var_0_3 = gamecore.prompt
local var_0_4 = gamecore.Language

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.RequestAddFriendResp(arg_2_0, arg_2_1)
		local var_2_0 = var_0_1:getInstance("friendsmain")

		if arg_2_1.result == 0 then
			if var_2_0 and var_2_0._cell_copy then
				var_2_0:init_move(var_2_0._cell_copy)
			end

			var_0_3:show(var_0_4:getNowLang("addfriendsuccess"))
		else
			var_0_3:show(var_0_2:get_err_msg(arg_2_1.result))
		end

		if var_2_0 then
			var_2_0:button_flag(true)
		end
	end

	function arg_1_0.AddFriendResp(arg_3_0, arg_3_1)
		if arg_3_1.result == 0 then
			local var_3_0 = var_0_1:createInstance("friendsmain")

			var_3_0:updata_data()
			var_3_0:_tip_have()
		else
			var_0_3:show(var_0_2:get_err_msg(arg_3_1.result))
		end
	end

	function arg_1_0.RemoveFriendRequestResp(arg_4_0, arg_4_1)
		if arg_4_1.result == 0 then
			local var_4_0 = var_0_1:createInstance("friendsmain")

			var_4_0:updata_data()
			var_4_0:_tip_have()
		end
	end

	function arg_1_0.RemoveAllFriendRequestResp(arg_5_0, arg_5_1)
		if arg_5_1.result == 0 then
			local var_5_0 = var_0_1:createInstance("friendsmain")

			var_5_0:updata_data()
			var_5_0:_tip_have()
		end
	end

	function arg_1_0.RemoveFriendResp(arg_6_0, arg_6_1)
		if arg_6_1.result == 0 then
			var_0_1:createInstance("friendsmain"):updata_data()
		else
			var_0_3:show(var_0_2:get_err_msg(arg_6_1.result))
		end
	end

	function arg_1_0.GetRecommendListResp(arg_7_0, arg_7_1)
		local var_7_0 = var_0_1:createInstance("maskwait")
		local var_7_1 = var_0_1:getInstance("friendsmain")

		if arg_7_1.result == 0 then
			var_7_1._recommend_data = arg_7_1.list

			var_7_1:updata_data()
		else
			var_0_3:show(var_0_2:get_err_msg(arg_7_1.result))
		end

		var_7_1:button_flag(true)
	end

	function arg_1_0.RecommendResp(arg_8_0, arg_8_1)
		return
	end

	function arg_1_0.CancelFriendStateResp(arg_9_0, arg_9_1)
		return
	end

	function arg_1_0.TopFriendStateResp(arg_10_0, arg_10_1)
		if arg_10_1.result == 0 then
			var_0_1:getInstance("friendsmain"):updata_data()
		else
			var_0_3:show(var_0_2:get_err_msg(arg_10_1.result))
		end
	end
end

function var_0_0.extend_obj(arg_11_0)
	return
end

return var_0_0
