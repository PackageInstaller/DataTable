local var_0_0 = lx
local var_0_2 = HMSDKManager.Instance
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = gameenum.replace_connect
local var_0_6 = gamecore.prompt
local var_0_7 = gamecore.user
local var_0_8 = gamecore.Language
local var_0_9 = gamecore.AuditServerManager
local var_0_10 = lx.UserData
local var_0_11 = DG.Tweening.DOTween
local var_0_12 = {
	hoolai_login = 2,
	hm_login = 1,
	hoolai_login_fail = 3
}
local var_0_13 = {
	taptap = "taptap",
	hm_android_go_ios_small = "hm_android_to_ios",
	hm_android_jp = "hm_android_jp",
	hm_ios = "hm_sdk_ios",
	android_cbt = "android_cbt",
	default_self = "hm_sdk_lan",
	hm_android_go_ios = "hm_android_to_ios",
	ios_cbt = "hm_sdk_ios",
	hm_ios_jp = "hm_ios_jp",
	yyb = "yyb",
	xiaomi = "xiaomi",
	hm_android_small = "hm_sdk_android",
	hm_android = "hm_sdk_android"
}
local var_0_14 = gamecore.SubPatchManager

lx.define_class("AccountPlatform", function(arg_1_0)
	function arg_1_0:init()
		self._init_finished = false

		local var_2_0 = var_0_0.connect_selector:create()

		var_2_0:set_default_url("https://pay.moefantasy.com")

		for iter_2_0, iter_2_1 in pairs(var_0_5:get_connect_list(self:__get_channel(), "pay")) do
			var_2_0:add_url(iter_2_1)
		end

		var_2_0:set_func(function(arg_3_0, arg_3_1)
			self:__real_init(arg_3_0)
		end)
		var_2_0:execute()
	end

	function arg_1_0:initFinish(arg_4_1)
		if self._init_finished then
			arg_4_1()
		else
			self._init_finished_call_func = arg_4_1
		end
	end

	function arg_1_0:__real_init(arg_5_1)
		self._channel = self:__get_channel()

		if self._channel == "xiaomi" then
			if var_0_10:getKeyData("already_install") == "already_install" then
				SDKAndroid.Instance:Init()
				SDKAndroid.Instance:OnUserAgreed()
			end
		elseif self._channel == "yyb" then
			if var_0_10:getKeyData("already_install") == "already_install" then
				YYBSDKBridge.Instance:Init()
			end

			self:__set_channel_login_setting()
		else
			var_0_2:InitLoginSDK()
			self:__set_channel_login_setting()
			var_0_2:InitPaySDK()
			var_0_2:SetAppId("hmccc321bec5f3451e", arg_5_1)
		end

		if self._channel == "xiaomi" then
			self:setup_xiaomi_callbacks()
		elseif self._channel == "yyb" then
			self:setup_yyb_callbacks()
		else
			self:hm_login_success()
			self:hm_signout_now_player()
			self:hoolai_init_callback()
			self:hoolai_login_success()
			self:hoolai_exit_callback()
		end

		self:provide_content_callback()

		self._init_finished = true
		self._init_finished_call_func = nil

		if self._init_finished_call_func then
			self._init_finished_call_func()
		end
	end

	function arg_1_0.__set_now_appversion_num(arg_6_0)
		local var_6_0 = 0
		local var_6_1 = app:getSystem():getAppVersion()

		for iter_6_0 = 1, #var_6_1 do
			local var_6_2 = tonumber((var_6_1:sub(iter_6_0, iter_6_0)))

			if var_6_2 then
				var_6_0 = var_6_2

				break
			end
		end

		return var_6_0
	end

	function arg_1_0:get_first_version_number()
		return self:__set_now_appversion_num()
	end

	function arg_1_0:__set_channel_login_setting()
		if self:__get_channel() == "yyb" then
			if self._yyb_retry_seq then
				self._yyb_retry_seq:Kill()

				self._yyb_retry_seq = nil
			end

			self._yyb_retry_seq = var_0_11.Sequence()

			self._yyb_retry_seq:AppendInterval(40)
			self._yyb_retry_seq:AppendCallback(function()
				if self:get_login_state() == var_0_12.hoolai_login then
					return
				end

				self._yyb_waiting_auto_login = false

				if self._yyb_auto_login_timer then
					self._yyb_auto_login_timer:Kill()

					self._yyb_auto_login_timer = nil
				end

				YYBSDKBridge.Instance:Logout()

				self._login_state = nil

				YYBSDKBridge.Instance:LoginQQ()
			end)
			self._yyb_retry_seq:SetAutoKill(true)
		elseif self:__get_channel() == "xiaomi" then
			local var_8_0 = var_0_3:getInstance("launch")

			if var_8_0 then
				var_8_0:set_hoolai_is_close()
			end
		end
	end

	function arg_1_0.login_init(arg_10_0)
		local var_10_0 = app:getSystem():getChannel()

		if var_10_0 == "xiaomi" then
			XiaomiSDKBridge.Instance:Login()

			return
		end

		if var_10_0 == "yyb" then
			YYBSDKBridge.Instance:LoginQQ()

			return
		end

		if var_10_0 ~= "xiaomi" and var_10_0 ~= "yyb" and (var_10_0 == "android_cbt" or var_10_0 == "hm_android_jp" or var_10_0 == "hm_ios_jp" or var_0_9:isAuditVersion()) then
			if var_10_0 == "hm_android" and var_0_9:isAuditVersion() then
				var_0_2:Login()
			else
				var_0_3:createInstance("login"):show()
			end
		else
			var_0_2:Login()
		end
	end

	function arg_1_0.__clear_account(arg_11_0)
		if app:isPC() then
			var_0_0.UserData:setKeyData("LONGREFRESH_TOKEN", "")
			var_0_0.UserData:setKeyData("hm_token", "")
			var_0_0.UserData:setKeyData("hm_password", "")
		elseif app:getSystem():getOSType() == "android" then
			var_0_2:Logout()
		elseif app:getSystem():getOSType() == "iOS" then
			var_0_2:Logout()
		end
	end

	function arg_1_0:login(arg_12_1, arg_12_2)
		if arg_12_2 then
			self:__clear_account()
		end

		if arg_12_1 == "android" then
			self._channel = "hm_sdk_android"
			self._game_id = "100"
		elseif arg_12_1 == "ios" then
			self._channel = "hm_sdk_ios"
			self._game_id = "101"
		end

		self:__set_config()
	end

	function arg_1_0.logout(arg_13_0)
		var_0_2:OpenPersonalCenter()

		arg_13_0._open_personal = true
	end

	function arg_1_0.exit(arg_14_0)
		local var_14_0 = app:getSystem():getChannel()

		if var_14_0 == "xiaomi" then
			XiaomiSDKBridge.Instance:Exit()
		elseif var_14_0 == "yyb" then
			exit_self_process()
		else
			var_0_2:Exit()
		end
	end

	function arg_1_0.set_login_state(arg_15_0, arg_15_1)
		arg_15_0._login_state = arg_15_1
	end

	function arg_1_0:get_login_state()
		return self._login_state
	end

	function arg_1_0:getToken()
		return self._token
	end

	function arg_1_0.setToken(arg_18_0, arg_18_1)
		arg_18_0._token = arg_18_1
	end

	function arg_1_0:getChannel()
		return self._channel
	end

	function arg_1_0:getUid()
		return self._uid
	end

	function arg_1_0.setUid(arg_21_0, arg_21_1)
		arg_21_0._uid = arg_21_1
	end

	function arg_1_0:getChannelUid()
		return self._channel_uid
	end

	function arg_1_0:getProductId()
		return self._product_id
	end

	function arg_1_0.provide_content_callback(arg_24_0)
		if pcall(function()
			return
		end) then
			function var_0_2.provideContent(arg_26_0)
				arg_24_0._provide_ios_receipt = arg_26_0
			end
		end
	end

	function arg_1_0:getProvideContent()
		return self._provide_ios_receipt
	end

	function arg_1_0.resetProvideContent(arg_28_0)
		arg_28_0._provide_ios_receipt = nil
	end

	function arg_1_0.hm_login_success(arg_29_0)
		function var_0_2.loginSuccess(arg_30_0)
			arg_29_0:set_login_state(var_0_12.hm_login)

			arg_29_0._token = arg_30_0

			local var_30_0 = var_0_0.UserData:getKeyData("LONGREFRESH_TOKEN")

			arg_29_0:__entergame_hddown()
		end
	end

	function arg_1_0.hm_signout_now_player(arg_31_0)
		function var_0_2.signOutNowPlayer()
			arg_31_0._open_personal = false
		end
	end

	function arg_1_0.getUserInfo(arg_33_0)
		var_0_2:GetUserInfo()
	end

	function arg_1_0:open_personal()
		local var_34_0 = var_0_3:getInstance("enter_game") or var_0_3:createInstance("enter_game")

		self._open_personal = true

		local var_34_1 = self:get_login_state()

		if var_34_1 == var_0_12.hm_login then
			var_0_2:OpenPersonalCenter()

			return
		end

		if var_34_1 == var_0_12.hoolai_login then
			if self:__get_channel() == "yyb" then
				var_34_0._control.all_object.enter_btn.canvasGroup.alpha = 0
				var_34_0._control.all_object.enter_btn.canvasGroup.interactable = false
			end

			if self:__get_channel() == "xiaomi" then
				self._mi_prompt_seq = var_0_11.Sequence()

				self._mi_prompt_seq:AppendInterval(0.5)
				self._mi_prompt_seq:AppendCallback(function()
					var_0_6:show("请前往手机系统设置中切换小米账号")

					self._mi_prompt_seq = nil
				end)
				self._mi_prompt_seq:SetAutoKill(true)
			elseif self:__get_channel() == "yyb" then
				YYBSDKBridge.Instance:Logout()

				self._login_state = nil

				YYBSDKBridge.Instance:LoginQQ()
				self:__set_channel_login_setting()
			else
				var_0_2:Logout()
				var_0_2:InitLoginSDK()
			end

			return
		end

		if var_34_1 == var_0_12.hoolai_login_fail then
			if self:__get_channel() == "yyb" then
				var_34_0._control.all_object.enter_btn.canvasGroup.alpha = 0
				var_34_0._control.all_object.enter_btn.canvasGroup.interactable = false
			end

			var_0_2:InitLoginSDK()

			return
		end

		if var_34_1 == nil then
			local var_34_2 = app:getSystem():getChannel()

			if var_34_2 == "hm_android_jp" or var_34_2 == "android_cbt" or var_34_2 == "hm_ios_jp" or var_0_9:isAuditVersion() then
				var_0_3:createInstance("login"):show()
				var_34_0:setVisible(false)
			end
		end
	end

	function arg_1_0.setup_xiaomi_callbacks(arg_36_0)
		function XiaomiSDKBridge.Instance.xiaomiLoginSuccess(arg_37_0)
			local var_37_0 = {}

			for iter_37_0 in string.gmatch(arg_37_0, "[^|]+") do
				table.insert(var_37_0, iter_37_0)
			end

			if #var_37_0 >= 2 then
				arg_36_0:set_login_state(var_0_12.hoolai_login)

				arg_36_0._uid = var_37_0[1]
				arg_36_0._channel_uid = var_37_0[1]
				arg_36_0._token = var_37_0[2]
				arg_36_0._channel = arg_36_0:__get_channel()
				arg_36_0._product_id = ""
				arg_36_0._xiaomi_login_seq = var_0_11.Sequence()

				arg_36_0._xiaomi_login_seq:AppendInterval(0.5)
				arg_36_0._xiaomi_login_seq:AppendCallback(function()
					arg_36_0._xiaomi_login_seq = nil

					arg_36_0:__entergame_hddown()
				end)
			end
		end

		function XiaomiSDKBridge.Instance.xiaomiLoginFail(arg_39_0)
			arg_36_0._xiaomi_fail_seq = var_0_11.Sequence()

			arg_36_0._xiaomi_fail_seq:AppendInterval(0.5)
			arg_36_0._xiaomi_fail_seq:AppendCallback(function()
				arg_36_0._xiaomi_fail_seq = nil

				var_0_6:show(var_0_8:getNowLang("login_fail"))
			end)
		end

		function XiaomiSDKBridge.Instance.xiaomiExitCallback(arg_41_0)
			if arg_41_0 == "1546" then
				var_0_6:show(var_0_8:getNowLang("login_fail"))

				return
			end

			exit_self_process()
		end
	end

	function arg_1_0.setup_yyb_callbacks(arg_42_0)
		local var_42_0 = YYBSDKBridge.Instance

		function YYBSDKBridge.Instance.yybLoginSuccess(arg_43_0)
			local var_43_0 = {}

			for iter_43_0 in string.gmatch(arg_43_0, "[^|]+") do
				table.insert(var_43_0, iter_43_0)
			end

			if #var_43_0 >= 6 then
				arg_42_0:set_login_state(var_0_12.hoolai_login)

				arg_42_0._uid = var_43_0[1]
				arg_42_0._channel_uid = var_43_0[1]
				arg_42_0._token = var_43_0[2]
				arg_42_0._channel = arg_42_0:__get_channel()
				arg_42_0._product_id = ""
				arg_42_0._ysdk_pf = var_43_0[4]
				arg_42_0._ysdk_pf_key = var_43_0[5]
				arg_42_0._ysdk_pay_token = var_43_0[3]
				arg_42_0._ysdk_platform = (tonumber(var_43_0[6]) or 0) == 2 and "wx" or "qq"

				var_0_10:setKeyData("yyb_has_logged", "1")

				arg_42_0._yyb_waiting_auto_login = false

				if arg_42_0._yyb_auto_login_timer then
					arg_42_0._yyb_auto_login_timer:Kill()

					arg_42_0._yyb_auto_login_timer = nil
				end

				if arg_42_0._yyb_retry_seq then
					arg_42_0._yyb_retry_seq:Kill()

					arg_42_0._yyb_retry_seq = nil
				end

				arg_42_0:__entergame_hddown()
			end
		end

		function YYBSDKBridge.Instance.yybLoginFail(arg_44_0)
			local var_44_0 = {}

			for iter_44_0 in string.gmatch(arg_44_0, "[^|]+") do
				table.insert(var_44_0, iter_44_0)
			end

			local var_44_1 = tonumber(var_44_0[1]) or 0

			if var_44_1 == 2004 or var_44_1 == -1 or var_44_1 == 1002 then
				var_42_0:Logout()

				arg_42_0._login_state = nil

				var_42_0:LoginQQ()
			elseif var_44_1 == 3100 then
				-- block empty
			elseif var_44_1 == 1 or var_44_1 == 8 or var_44_1 == 10002 then
				arg_42_0._yyb_prompt_seq = var_0_11.Sequence()

				arg_42_0._yyb_prompt_seq:AppendInterval(0.5)
				arg_42_0._yyb_prompt_seq:AppendCallback(function()
					var_0_6:show("登录已取消，稍后将自动重新拉起")

					arg_42_0._yyb_prompt_seq = nil
				end)
				arg_42_0._yyb_prompt_seq:SetAutoKill(true)
				arg_42_0:__set_channel_login_setting()
			else
				arg_42_0._yyb_prompt_seq = var_0_11.Sequence()

				arg_42_0._yyb_prompt_seq:AppendInterval(0.5)
				arg_42_0._yyb_prompt_seq:AppendCallback(function()
					var_0_6:show(var_0_8:getNowLang("login_fail"))

					arg_42_0._yyb_prompt_seq = nil
				end)
				arg_42_0._yyb_prompt_seq:SetAutoKill(true)
				arg_42_0:__set_channel_login_setting()
			end
		end
	end

	function arg_1_0.hoolai_init_callback(arg_47_0)
		function var_0_2.hoolaiInit(arg_48_0)
			return
		end
	end

	function arg_1_0.hoolai_login_success(arg_49_0)
		function var_0_2.hoolaiLoginSuccess(arg_50_0)
			local var_50_0 = var_0_0.json_decode(arg_50_0)

			if var_50_0.resultCode == var_0_4.hoolai_callback_type.Type_Login_Success and arg_49_0.__login_success then
				arg_49_0:__login_success(var_50_0)
			end

			if var_50_0.resultCode == var_0_4.hoolai_callback_type.Type_Login_Fail and arg_49_0.__login_fail then
				arg_49_0:__login_fail(var_50_0)
				var_0_2:Login()
				var_0_2:InitLoginSDK()
			end

			if var_50_0.resultCode == var_0_4.hoolai_callback_type.Type_Logout then
				var_0_2:Login()
			end
		end
	end

	function arg_1_0.hoolai_exit_callback(arg_51_0)
		function var_0_2.hoolaiExitCallback(arg_52_0)
			local var_52_0 = var_0_0.json_decode(arg_52_0)

			exit_self_process()
		end
	end

	function arg_1_0:get_channel_info(arg_53_1)
		return self._config_table[arg_53_1]
	end

	function arg_1_0:__login_success(arg_54_1)
		self:set_login_state(var_0_12.hoolai_login)

		self._channel = self:__get_channel()
		self._token = arg_54_1.data.accessToken
		self._uid = arg_54_1.data.uid
		self._channel_uid = arg_54_1.data.channelUid
		self._product_id = arg_54_1.data.productId

		self:__entergame_hddown()
	end

	function arg_1_0:__login_fail(arg_55_1)
		self:set_login_state(var_0_12.hoolai_login_fail)
	end

	function arg_1_0.__logout(arg_56_0, arg_56_1)
		return
	end

	function arg_1_0:__set_config()
		local var_57_0 = self._config_table[self._channel].baseUrl

		if not app:isPC() then
			if self._channel == "hm_sdk_android" or self._channel == "taptap" then
				var_57_0 = "https://andpassportapi.moefantasy.com/"
			elseif self._channel == "hm_sdk_ios" or self._channel == "hm_android_to_ios" then
				var_57_0 = "https://iospassportapi.moefantasy.com/"
			end
		end

		if app:isPC() and (self._channel == "hm_sdk_android" or self._channel == "hm_sdk_ios") then
			var_57_0 = "http://passportapi.moefantasy.com/"
		end

		if self._channel == "hm_sdk_android" or self._channel == "taptap" or self._channel == "hm_sdk_ios" or self._channel == "hm_android_to_ios" then
			local var_57_1 = var_0_0.connect_selector:create()

			var_57_1:set_default_url(var_57_0)

			for iter_57_0, iter_57_1 in pairs(var_0_5:get_connect_list(self._channel, "account_sdk")) do
				var_57_1:add_url(iter_57_1)
			end

			var_57_1:set_func(function(arg_58_0, arg_58_1)
				self:__real_set_config(arg_58_0)
			end)
			var_57_1:execute()
		else
			self:__real_set_config(var_57_0)
		end
	end

	function arg_1_0:__real_set_config(arg_59_1)
		local var_59_0 = self:__get_channel()

		if var_59_0 == "xiaomi" or var_59_0 == "yyb" then
			self:login_init()

			return
		end

		local var_59_1 = self._config_table[self._channel].secretAccessKeyID
		local var_59_2 = 1

		if app:isPC() then
			var_59_2 = 2
		end

		self._game_id = self._game_id or "0"

		var_0_2:SetConfig(arg_59_1, var_59_1, self._config_table[self._channel].secretAccessKey, 1, self._game_id, "wxf4b38716584c04fd", "e2aa3d3d34339612d7eade09707125e5", "1107710893", var_59_2, "193976411167871", "1028497632273-qp1bstl59m2q9ehnnt20g069jh185etd.apps.googleusercontent.com")
		self:login_init()
	end

	function arg_1_0.__get_channel(arg_60_0)
		return var_0_13[app:getSystem():getChannel()]
	end

	function arg_1_0:__entergame_hddown()
		if app:getNotice() then
			if var_0_14 then
				local var_61_0, var_61_1 = pcall(function()
					var_0_14:__set_data_hd_version()
				end)
				local var_61_2, var_61_3 = pcall(function()
					return var_0_14:isDataHDNeedUpdateEnterGame()
				end)

				if var_61_3 then
					pcall(function()
						var_0_14:downloadDataHDEnterGame()
					end)
				else
					local var_61_4, var_61_5 = pcall(function()
						return var_0_3:createInstance("enter_game")
					end)

					if var_61_4 and var_61_5 then
						if self:__get_channel() == "yyb" or self:__get_channel() == "xiaomi" then
							if gamecore.user:isGameIng() then
								return
							end

							local var_61_6, var_61_7 = pcall(function()
								var_61_5:show()
							end)
						else
							pcall(function()
								var_61_5:show(self._open_personal)
							end)
						end
					end
				end
			end
		else
			local var_61_8, var_61_9 = pcall(function()
				return var_0_3:createInstance("enter_game")
			end)

			if var_61_8 and var_61_9 then
				if self:__get_channel() == "yyb" or self:__get_channel() == "xiaomi" then
					if gamecore.user:isGameIng() then
						return
					end

					local var_61_10, var_61_11 = pcall(function()
						var_61_9:show()
					end)
				else
					pcall(function()
						var_61_9:show(self._open_personal)
					end)
				end
			end
		end
	end

	function arg_1_0:call_set_pay_info()
		local var_71_0 = tostring(var_0_7:get_account_id() or "")

		if var_71_0 == "" or var_71_0 == "0" then
			return
		end

		if self._yyb_set_pay_info_called then
			return
		end

		self._yyb_set_pay_info_called = true

		local var_71_1 = "http://xrapi.moefantasy.com/yyb/setPayInfo&" .. "accessToken=" .. (self._token or "") .. "&payToken=" .. (self._ysdk_pay_token or "") .. "&pfKey=" .. (self._ysdk_pf_key or "") .. "&openid=" .. (self._uid or "") .. "&login_type=" .. (self._ysdk_platform or "wx") .. "&account_id=" .. var_71_0 .. "&pf=" .. (self._ysdk_pf or "")

		self._set_pay_info_req = var_0_0.http_request:create()

		self._set_pay_info_req:set_url(var_71_1)
		self._set_pay_info_req:set_response_func(function(arg_72_0, arg_72_1)
			self._set_pay_info_req = nil
		end)
		self._set_pay_info_req:set_error_func(function(arg_73_0, arg_73_1)
			self._set_pay_info_req = nil
		end)
		self._set_pay_info_req:execute()
	end
end)

return function()
	local var_74_0 = var_0_0.class("AccountPlatform")

	var_74_0._token = ""
	var_74_0._channel = ""
	var_74_0._open_personal = false
	var_74_0._config_table = {
		hm_sdk_lan = {
			baseUrl = "http://uat.passport.moefantasy.com/",
			secretAccessKey = "abcdef01234567890abcdef01234567890",
			secretAccessKeyID = "db0123456db0123456"
		},
		hm_sdk_android = {
			baseUrl = "https://passportapi.moefantasy.com/",
			secretAccessKey = "LPCe3twVkpqpwDPocfPsadpzPsEQcIKY",
			secretAccessKeyID = "N4shiJrFaZ9eTVwF"
		},
		hm_android_to_ios = {
			baseUrl = "https://iospassportapi.moefantasy.com/",
			secretAccessKey = "LPCe3twVkpqpwDPocfPsadpzPsEQcIKY",
			secretAccessKeyID = "N4shiJrFaZ9eTVwF"
		},
		taptap = {
			baseUrl = "https://passportapi.moefantasy.com/",
			secretAccessKey = "LPCe3twVkpqpwDPocfPsadpzPsEQcIKY",
			secretAccessKeyID = "N4shiJrFaZ9eTVwF"
		},
		hm_sdk_ios = {
			baseUrl = "https://passportapi.moefantasy.com/",
			secretAccessKey = "LPCe3twVkpqpwDPocfPsadpzPsEQcIKY",
			secretAccessKeyID = "N4shiJrFaZ9eTVwF"
		},
		yyb = {
			baseUrl = "",
			secretAccessKey = "",
			secretAccessKeyID = ""
		},
		xiaomi = {
			baseUrl = "",
			secretAccessKey = "",
			secretAccessKeyID = ""
		},
		hm_android_jp = {
			baseUrl = "http://uat.passport.moefantasy.com/",
			secretAccessKey = "abcdef01234567890abcdef01234567890",
			secretAccessKeyID = "db0123456db0123456"
		},
		hm_ios_jp = {
			baseUrl = "",
			secretAccessKey = "",
			secretAccessKeyID = ""
		},
		android_cbt = {
			baseUrl = "http://uat.passport.moefantasy.com/",
			secretAccessKey = "abcdef01234567890abcdef01234567890",
			secretAccessKeyID = "db0123456db0123456"
		},
		iOS_cbt = {
			baseUrl = "http://uat.passport.moefantasy.com/",
			secretAccessKey = "abcdef01234567890abcdef01234567890",
			secretAccessKeyID = "db0123456db0123456"
		}
	}
	var_74_0._login_state = nil
	var_74_0._game_id = 0
	var_74_0._provide_ios_receipt = nil
	var_74_0._init_finished = false
	var_74_0._init_finished_call_func = nil
	var_74_0._ysdk_pf = ""
	var_74_0._ysdk_pf_key = ""
	var_74_0._ysdk_pay_token = ""
	var_74_0._ysdk_platform = ""
	var_74_0._yyb_set_pay_info_called = false

	return var_74_0
end
