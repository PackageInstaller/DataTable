return {
	init = function(arg_1_0)
		SDKManager.registerLoginHandler(function(arg_2_0, arg_2_1, arg_2_2)
			print("Oppo Login Callback: ", arg_2_0, arg_2_2, arg_2_1)

			local account_manager = require("controller.account_manager")

			arg_2_1 = arg_2_1 and string.urlencode(arg_2_1)

			if arg_2_0 == 1 then
				if account_manager.loginRequestingHandler then
					account_manager.loginRequestingHandler = nil
					account_manager.accountInfo.uid = arg_2_2

					account_manager.loginRequestingHandler(1, arg_2_2, arg_2_1)
				end
			elseif account_manager.loginRequestingHandler then
				account_manager.loginRequestingHandler(2)
			end
		end)
	end,
	login = function(arg_3_0)
		SDKManager.login()
	end
}
