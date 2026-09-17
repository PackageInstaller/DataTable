return {
	init = function(arg_1_0)
		SDKManager.registerLogoutHandler(function()
			global_restart_game()
		end)
		SDKManager.registerSwitchAccountHandler(function()
			global_restart_game()
		end)
		SDKManager.setOnSwitchAccountListener()
		SDKManager.registerAntiAddictionHandler(function(arg_4_0)
			global_restart_game()
		end)
		SDKManager.registerLoginHandler(function(arg_5_0, arg_5_1)
			print("aoki Login Callback: ", arg_5_0, arg_5_1)

			local account_manager = require("controller.account_manager")

			if arg_5_0 == 0 then
				if account_manager.loginRequestingHandler then
					account_manager.loginRequestingHandler = nil
					account_manager.accountInfo.uid = uid

					account_manager.loginRequestingHandler(1, nil, arg_5_1)
				end
			elseif arg_5_0 == -1 then
				SDKManager.login()
			elseif account_manager.loginRequestingHandler then
				account_manager.loginRequestingHandler(2)
			end
		end)
	end,
	login = function(arg_6_0)
		SDKManager.login()
	end
}
