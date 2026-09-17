return {
	init = function(arg_1_0)
		SDKManager.registerLogoutHandler(function()
			global_restart_game()
		end)
		SDKManager.registerLoginHandler(function(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
			print("jiuyou Login Callback: ", arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)

			local account_manager = require("controller.account_manager")

			if arg_3_0 == 0 then
				if account_manager.loginRequestingHandler then
					account_manager.loginRequestingHandler = nil
					account_manager.accountInfo.uid = arg_3_1
					account_manager.loginType = arg_3_4

					account_manager.loginRequestingHandler(1, arg_3_1, arg_3_2)
				end
			elseif account_manager.loginRequestingHandler then
				account_manager.loginRequestingHandler(2)
			end
		end)
	end,
	login = function(arg_4_0)
		SDKManager.login()
	end
}
