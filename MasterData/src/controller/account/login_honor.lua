return {
	init = function(arg_1_0)
		SDKManager.registerLoginHandler(function(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
			print("honor Login Callback: ", arg_2_0, arg_2_1, arg_2_2, arg_2_3)

			local account_manager = require("controller.account_manager")

			if arg_2_0 == 0 then
				if account_manager.loginRequestingHandler then
					account_manager.loginRequestingHandler = nil
					account_manager.accountInfo.uid = arg_2_1

					account_manager.loginRequestingHandler(1, arg_2_1, arg_2_3)
				end
			elseif account_manager.loginRequestingHandler then
				account_manager.loginRequestingHandler(2)
			end
		end)
	end,
	login = function(arg_3_0)
		SDKManager.login()
	end,
	onLoginSuccess = function(arg_4_0)
		local playermodel = require("model.playermodel")

		SDKManager:pushUserInfo(playermodel.userid, playermodel.nickname, playermodel.level, "1", "1", playermodel.curLevel)
	end
}
