local var_0_0 = {
	_conf = {
		patch = {
			"http://tcloud-patch-xr.moefantasy.com:10080/",
			"http://aliyun-patch-xr.moefantasy.com:10080/",
			"http://hwhk-patch-xr.moefantasy.com:10080/"
		},
		pay = {
			"https://tcloud-pay-xr.moefantasy.com",
			"https://aliyun-pay-xr.moefantasy.com",
			"https://hwhk-pay-xr.moefantasy.com"
		},
		account_sdk = {
			hm_sdk_android = {
				"https://tcloud-passport-and-xr.moefantasy.com/",
				"https://aliyun-passport-and-xr.moefantasy.com/",
				"https://hwhk-passport-and-xr.moefantasy.com/"
			},
			hm_sdk_ios = {
				"https://tcloud-passport-ios-xr.moefantasy.com/",
				"https://aliyun-passport-ios-xr.moefantasy.com/",
				"https://hwhk-passport-ios-xr.moefantasy.com/"
			}
		},
		account_server = {
			hm_sdk_android = {
				"http://tcloud-xr-server-4.moefantasy.com:10005/auth/",
				"http://aliyun-xr-server-4.moefantasy.com:10005/auth/",
				"http://hwhk-xr-server-4.moefantasy.com:10005/auth/"
			},
			hm_sdk_ios = {
				"http://tcloud-xr-server-4.moefantasy.com:10006/auth/",
				"http://aliyun-xr-server-4.moefantasy.com:10006/auth/",
				"http://hwhk-xr-server-4.moefantasy.com:10006/auth/"
			}
		}
	},
	_channel_rep = {
		patch = {
			hm_android_small = "hm_android_small",
			hm_android_go_ios_small = "hm_android_go_ios_small",
			xiaomi = "xiaomi",
			hm_ios = "hm_ios",
			taptap = "taptap",
			hm_android_go_ios = "hm_android_go_ios",
			hm_android = "hm_android",
			yyb = "yyb"
		},
		pay = {
			taptap = "hm_sdk_android",
			yyb = "hm_sdk_android",
			xiaomi = "hm_sdk_android",
			hm_sdk_android = "hm_sdk_android",
			hm_sdk_ios = "hm_sdk_ios",
			hm_android_to_ios = "hm_sdk_android"
		},
		account_sdk = {
			taptap = "hm_sdk_android",
			hm_sdk_ios = "hm_sdk_ios",
			hm_android_to_ios = "hm_sdk_android",
			hm_sdk_android = "hm_sdk_android"
		},
		account_server = {
			taptap = "hm_sdk_android",
			hm_sdk_ios = "hm_sdk_ios",
			hm_android_to_ios = "hm_sdk_android",
			hm_sdk_android = "hm_sdk_android"
		}
	}
}

function var_0_0.get_connect_list(arg_1_0, arg_1_1, arg_1_2)
	if not var_0_0._channel_rep[arg_1_2] then
		return {}
	end

	local var_1_0 = var_0_0._channel_rep[arg_1_2][arg_1_1]

	if not var_0_0._channel_rep[arg_1_2][arg_1_1] then
		return {}
	end

	local var_1_1 = var_0_0._conf[arg_1_2]

	if not var_0_0._conf[arg_1_2] then
		return {}
	end

	if var_1_1[var_1_0] then
		return var_1_1[var_1_0]
	end

	return var_1_1
end

return var_0_0
