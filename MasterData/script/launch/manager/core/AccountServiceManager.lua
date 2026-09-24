local var_0_0 = lx
local var_0_4 = lx.http_request
local var_0_5 = lx.json_encode
local var_0_6 = lx.json_decode
local var_0_7 = gameenum.launch_common_type
local var_0_8 = gamecore.AuditServerManager
local var_0_9 = gameenum.replace_connect
local var_0_10 = gamecore.UILoader
local var_0_13 = lx.UserData

lx.define_class("AccountServiceManager", function(arg_1_0)
	function arg_1_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		arg_2_0._succeed_callback = arg_2_1
		arg_2_0._fail_callback = arg_2_2
		arg_2_0._repeat_req_func = arg_2_3
	end

	function arg_1_0.req_account_server(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
		if arg_3_1 == "" then
			return
		end

		local var_3_0 = var_0_5({
			token = arg_3_1,
			channel = arg_3_2,
			channel_uid = arg_3_3,
			product_id = arg_3_4,
			uid = arg_3_5
		})
		local var_3_1 = var_0_7:channel_back("auth_url", var_0_8:isAuditVersion(), arg_3_2)

		if arg_3_2 == "android_cbt" or arg_3_2 == "hm_android_jp" or var_0_8:isAuditVersion() or arg_3_2 == "hm_ios_jp" then
			var_3_1 = var_0_7:channel_back("cbt_auth_url", var_0_8:isAuditVersion(), arg_3_2)
		end

		var_0_10:createInstance("loading"):show(true, nil, false, "")

		local var_3_2 = var_0_0.connect_selector:create()

		var_3_2:set_default_url(var_3_1)

		for iter_3_0, iter_3_1 in pairs(var_0_9:get_connect_list(arg_3_2, "account_server")) do
			var_3_2:add_url(iter_3_1)
		end

		var_3_2:set_func(function(arg_4_0, arg_4_1)
			arg_3_0:__reql_req_account_server(arg_4_0, var_3_0)
		end)
		var_3_2:execute()
	end

	function arg_1_0.__reql_req_account_server(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = var_0_4:create()

		var_5_0:set_url(arg_5_1)
		var_5_0:set_fields(arg_5_2)
		var_5_0:set_post()
		var_5_0:set_response_func(function(arg_6_0, arg_6_1)
			local var_6_0 = var_0_6(arg_6_1)

			if var_6_0.error_code == 0 then
				arg_5_0._repeat_num = 0

				var_0_10:destroyInstance("loading")

				if arg_5_0._succeed_callback then
					arg_5_0._succeed_callback(var_6_0)
				end
			elseif arg_5_0._repeat_num < 3 then
				arg_5_0._repeat_num = arg_5_0._repeat_num + 1

				arg_5_0._repeat_req_func()
			else
				arg_5_0:__show_login()
			end
		end)
		var_5_0:set_error_func(function(arg_7_0, arg_7_1)
			arg_5_0._repeat_req_func()
		end)
		var_5_0:execute()
	end

	function arg_1_0.__show_login(arg_8_0)
		var_0_10:destroyInstance("loading")

		local var_8_0 = var_0_13:getKeyData("last_login_android_or_ios")

		if var_8_0 == "" then
			gamecore.AccountPlatform:login(nil, true)
		elseif var_8_0 == "android" then
			gamecore.AccountPlatform:login("android", true)
		elseif var_8_0 == "ios" then
			gamecore.AccountPlatform:login("ios", true)
		end

		arg_8_0._repeat_num = 0
	end
end)

return function()
	local var_9_0 = var_0_0.class("AccountServiceManager")

	var_9_0._succeed_callback = nil
	var_9_0._fail_callback = nil
	var_9_0._repeat_req_func = nil
	var_9_0._repeat_num = 0

	return var_9_0
end
