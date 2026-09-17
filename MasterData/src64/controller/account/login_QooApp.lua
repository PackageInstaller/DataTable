return {
	init = function(arg_1_0)
		SDKManager.registerLoginHandler(function(arg_2_0)
			print("Qoo Login Callback: ")

			local var_2_0 = json.decode(arg_2_0)
			local account_manager = require("controller.account_manager")

			if var_2_0.code == 200 then
				if var_2_0.is_anonymous then
					global_ShowBlockWords("遊客賬號無法登陸~")

					return
				end

				if account_manager.loginRequestingHandler then
					account_manager.accountInfo.uid = var_2_0.data.user_id

					account_manager.loginRequestingHandler(1, var_2_0.data.user_id)
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
