local var_0_0 = {}
local var_0_5 = gamecore.NetworkManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.req_announcement(arg_2_0, arg_2_1)
		var_0_5:sendMsg("user.DailyNoticeReq", {
			state = arg_2_1
		})
	end

	function arg_1_0.req_enter(arg_3_0, arg_3_1)
		var_0_5:sendMsg("user.EnterReq", {})
	end

	function arg_1_0.req_ChangePlayerName(arg_4_0, arg_4_1)
		var_0_5:sendMsg("user.ChangeNameReq", {
			name = arg_4_1
		})
	end

	function arg_1_0.req_InitShip(arg_5_0, arg_5_1)
		var_0_5:sendMsg("user.GetNewPlayerShipReq", {
			index = arg_5_1
		})
	end

	function arg_1_0.req_Signin(arg_6_0)
		var_0_5:sendMsg("user.GetDailyAwardReq", {})
	end

	function arg_1_0.req_Sp_signin(arg_7_0, arg_7_1)
		var_0_5:sendMsg("user.GetOnceDailyAwardReq", {})
	end

	function arg_1_0.req_LevelAwards(arg_8_0, arg_8_1)
		var_0_5:sendMsg("user.GetLevelUpAwardReq", {
			id = arg_8_1
		})
	end

	function arg_1_0.req_ShipSupply(arg_9_0, arg_9_1)
		var_0_5:sendMsg("user.ShipSupplyReq", arg_9_1)
	end

	function arg_1_0.req_TeamSupply(arg_10_0, arg_10_1)
		var_0_5:sendMsg("user.TeamSupplyReq", arg_10_1)
	end

	function arg_1_0.req_AllShipSupply(arg_11_0, arg_11_1)
		var_0_5:sendMsg("user.AllShipSupplyReq", arg_11_1)
	end

	function arg_1_0.req_TeamQuickRepair(arg_12_0, arg_12_1)
		var_0_5:sendMsg("user.TeamRepairReq", arg_12_1)
	end

	function arg_1_0.req_ActiveAutoSupplyReq(arg_13_0)
		var_0_5:sendMsg("user.ActiveAutoSupplyReq", {})
	end

	function arg_1_0.req_GetFirstRewardReq(arg_14_0)
		var_0_5:sendMsg("user.GetFirstRewardReq", {})
	end

	function arg_1_0.req_TellDeviceReq(arg_15_0, arg_15_1)
		var_0_5:sendMsg("user.TellDeviceReq", arg_15_1)
	end

	function arg_1_0.req_RealNameAuthReq(arg_16_0, arg_16_1)
		var_0_5:sendMsg("login.RealNameAuthReq", arg_16_1)
	end

	function arg_1_0.req_SecretaryShipAdjustReq(arg_17_0, arg_17_1)
		var_0_5:sendMsg("user.SecretaryShipAdjustReq", {
			cid = arg_17_1.cid,
			scale = arg_17_1.scale,
			pos_x = arg_17_1.pos_x,
			pos_y = arg_17_1.pos_y
		})
	end

	function arg_1_0.req_ChangeStarSetReq(arg_18_0, arg_18_1)
		var_0_5:sendMsg("user.ChangeStarSetReq", {
			ids = arg_18_1
		})
	end

	function arg_1_0.req_ActivityDurationReq(arg_19_0, arg_19_1)
		var_0_5:sendMsg("user.ActivityDurationReq", {
			id = arg_19_1.id,
			start_time = arg_19_1.start_time,
			end_time = arg_19_1.end_time
		})
	end

	function arg_1_0.req_ChangeSecretaryDataReq(arg_20_0, arg_20_1)
		var_0_5:sendMsg("user.ChangeSecretaryDataReq", {
			members = arg_20_1
		})
	end

	function arg_1_0.req_ChangeMiddleBrokenReq(arg_21_0, arg_21_1)
		var_0_5:sendMsg("user.ChangeMiddleBrokenReq", {
			middle_broken_flag = arg_21_1
		})
	end

	function arg_1_0.req_ChangeRandSecretaryReq(arg_22_0, arg_22_1)
		var_0_5:sendMsg("user.ChangeRandSecretaryReq", {
			rand_secretary_flag = arg_22_1
		})
	end

	function arg_1_0.req_BindingPhoneReq(arg_23_0, arg_23_1)
		var_0_5:sendMsg("user.BindingPhoneReq", {
			state = arg_23_1
		})
	end

	function arg_1_0.req_SensitiveWordsReq(arg_24_0, arg_24_1)
		var_0_5:sendMsg("user.SensitiveWordsReq", {
			type = arg_24_1.type,
			sensitive_words = arg_24_1.sensitive_words
		})
	end

	function arg_1_0.req_TokenRefreshReq(arg_25_0, arg_25_1)
		var_0_5:sendMsg("user.TokenRefreshReq", {
			channel = arg_25_1.channel,
			refresh_token = arg_25_1.refresh_token
		})
	end
end

function var_0_0.extend_obj(arg_26_0)
	return
end

return var_0_0
