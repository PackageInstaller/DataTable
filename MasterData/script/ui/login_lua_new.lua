local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = lx.json_encode
local var_0_3 = lx.json_decode
local var_0_4 = lx.http_request
local var_0_5 = gamecore.prompt
local var_0_6 = gamecore.AccountPlatform
local var_0_8 = gameenum.launch_common_type
local var_0_9 = lx.UserData
local var_0_10 = gamecore.Language
local var_0_11 = "[^%w_]"
local var_0_12 = gamecore.AuditServerManager
local var_0_13 = gamecore.util_func
local var_0_14 = gamecore.user

gamecore.UILoader:define("login_lua_new", function(arg_1_0)
	function arg_1_0.__onUpdate(arg_2_0)
		return
	end

	function arg_1_0:show(arg_3_1)
		local var_3_0 = var_0_1:getInstance("enter_game")

		if var_3_0 then
			var_3_0._is_test_new_login = true

			var_0_14:set_test_login_channel("hm_android_jp")
		end

		self:setVisible(true)
		self:__init_panel(arg_3_1)
	end

	function arg_1_0:__init_panel(arg_4_1)
		self._can_phone_login = true
		self._can_code_login = true
		self._can_fast_login = true

		self._control.LoginWnd_CN.OrderBox.Left:SetActive(false)
		self._control.PhoneLoginWnd_CN.OrderBox.Left:SetActive(false)
		self._control.CodeLoginWnd_CN.OrderBox.Left:SetActive(false)
		self._control.LoginWnd_CN.PhoneNumberLogin:SetActive(self._can_phone_login)
		self._control.LoginWnd_CN.PhoneLogin:SetActive(self._can_code_login)
		self._control.LoginWnd_CN.QuickRegiest:SetActive(self._can_fast_login)

		self._channel = var_0_6:__get_channel()

		print("测试日服的渠道")

		self._channel = "hm_android_jp"

		self:__set_all_callback()
		self:__set_all_login_input()
		self:__normal_user_regiester()
		self:__forget_password()
	end

	function arg_1_0:__set_all_callback()
		function self:_succeed_callback()
			var_0_1:destroyInstance("loading")
			gamecore.AccountPlatform:setUid(self.uuid)
			gamecore.AccountPlatform:setToken(tostring(self.token))
			self:setVisible(false)
			self:__login_success(self._login_data)
			log.print_r(self._login_data, "self._login_data????")
		end

		function self._register_succeed_callback(arg_7_0)
			log.print_r(arg_7_0, "response??????????????")
			var_0_1:destroyInstance("loading")
			self:setVisible(false)
			self:__user_register_success(self._register_data)
		end

		log.print_r(self._register_succeed_callback, "self._register_succeed_callback")

		function self._change_pwd_succeed_callback(arg_8_0)
			var_0_1:destroyInstance("loading")
			self:setVisible(false)
			self:__change_pwd_success()
		end

		function self._url_pwd_succeed_callback(arg_9_0)
			var_0_1:destroyInstance("loading")
			self:setVisible(false)
			self:__url_pwd_success()
		end
	end

	function arg_1_0.__login_success(arg_10_0, arg_10_1)
		log.print_r(arg_10_1, "看看data是啥")
		var_0_9:setKeyData("Account_UserName", arg_10_1.username)
		var_0_9:setKeyData("Account_PassWord", arg_10_1.password)
		var_0_1:createInstance("enter_game"):show()
	end

	function arg_1_0.__user_register_success(arg_11_0)
		log.print_r("注册成功了！？！！！！！！！！！")
	end

	function arg_1_0:__set_all_login_input()
		self:__init_slider_normal_login_listenter_one()
		self:__init_slider_normal_login_listenter_two()
	end

	function arg_1_0:__normal_user_regiester()
		self:__init_slider_normal_regiester_listenter_one()
		self:__init_slider_normal_regiester_listenter_two()
		self:__init_slider_normal_regiester_listenter_three()
		self:__init_slider_normal_regiester_listenter_four()
		self:__init_slider_normal_regiester_listenter_five()
	end

	function arg_1_0:__init_slider_normal_login_listenter_one()
		self._control.LoginWnd_CN.RegBox.UserName.inputField.onEndEdit:RemoveAllListeners()
		self._control.LoginWnd_CN.RegBox.UserName.inputField.onEndEdit:AddListener(function()
			log.print_r(self._control.LoginWnd_CN.RegBox.UserName.inputField.text, "input_info")

			self._user_username = string.gsub(self._control.LoginWnd_CN.RegBox.UserName.inputField.text, var_0_11, "")

			log.print_r(self._user_username, "self._user_username")
		end)
	end

	function arg_1_0:__init_slider_normal_login_listenter_two()
		self._control.LoginWnd_CN.PasBox.PassWord.inputField.onEndEdit:RemoveAllListeners()
		self._control.LoginWnd_CN.PasBox.PassWord.inputField.onEndEdit:AddListener(function()
			self._user_password = self._control.LoginWnd_CN.PasBox.PassWord.inputField.text
		end)
	end

	function arg_1_0:__user_login_info()
		log.print_r(self._user_username, "self._phone_number")
		log.print_r(self._user_password, "self._user_password")

		if self._user_username and self._user_password then
			log.print_r(#self._user_username, "self._phone_number")
			log.print_r(#self._user_password, "self._user_password")
		end

		if not self._user_username or not self._user_password or self._user_username == "" or self._user_password == "" then
			var_0_5:show(var_0_10:get("账号密码不能为空"))

			return
		elseif self._user_username and self._user_password then
			if not self:__input_user_info_is_pass(self._user_password) or not self:__input_user_info_is_pass(self._user_username) then
				var_0_5:show(var_0_10:get("账号密码不符合规范"))
			end

			if #self._user_username >= 6 and #self._user_username <= 12 and #self._user_password >= 6 and #self._user_password <= 12 then
				log.print_r("打开登录了,测试渠道改成hm_android_jp")
				self:__req_account_login(self._user_username, self._user_password, self._channel)
			end
		end
	end

	function arg_1_0:__user_req_info()
		local var_19_6 = self:__input_user_info_is_pass(self._reg_username)
		local var_19_7 = self:__input_user_info_is_pass(self._reg_password)
		local var_19_8 = self:__input_phone_is_pass(self._reg_phonenumber)

		if not var_19_6 or not var_19_7 or not var_19_8 then
			return
		end

		local var_19_9 = var_0_13.check_card_str_valid(self._reg_realname)
		local var_19_10 = self:__input_realcard_is_pass(self._reg_cardnum)

		if not var_19_9 then
			var_0_5:show(var_0_10:get("真实姓名不能为空或者不符合格式"))

			return
		end

		log.print_r(var_19_6, "user_pass")
		log.print_r(var_19_7, "pwd_pass")
		log.print_r(var_19_8, "phone_pass")
		log.print_r(var_19_9, "realname_pass")
		log.print_r(var_19_10, "cardnum_pass")

		if (var_19_6 and var_19_7 and var_19_8 and var_19_9 and var_19_10 or nil) and true then
			log.print_r("所有输入的都过了，下面的继续")
			log.print_r("注册这里先等等，后面再看")
			self:__req_account_register(self._reg_username, self._reg_password, self._channel, self._reg_phonenumber, self._reg_realname, self._reg_cardnum)
		else
			var_0_5:show(var_0_10:get("注册信息不符合"))

			return
		end
	end

	function arg_1_0:__input_user_info_is_pass(arg_20_1)
		print(arg_20_1, "source这里有吗？？？？？")

		if arg_20_1 == nil or arg_20_1 == "" then
			print("不能为空")
			var_0_5:show(var_0_10:get("用户名密码不能为空"))

			return false
		elseif #arg_20_1 < 6 or #arg_20_1 > 25 then
			var_0_5:show(var_0_10:get("用户名密码长度为6-24长度"))

			return false
		elseif self._reg_username then
			if #self._reg_username == 0 then
				return
			elseif #self._reg_username > 0 then
				local var_20_2 = 1

				while var_20_2 <= #self._reg_username do
					local var_20_3 = string.byte(self._reg_username, var_20_2)

					if not var_20_3 then
						break
					end

					if (var_20_3 < 48 or var_20_3 > 57 and var_20_3 < 65 or var_20_3 > 90 and var_20_3 < 97 or var_20_3 > 122 and var_20_3 < 128) and var_20_3 ~= 95 then
						return false
					elseif var_20_3 >= 128 then
						return false
					end

					var_20_2 = var_20_2 + 1
				end
			end
		end

		return true
	end

	function arg_1_0.__input_phone_is_pass(arg_21_0, arg_21_1)
		if arg_21_1 == nil then
			return false
		end

		log.print_r(#arg_21_1, "len？")

		if #arg_21_1 ~= 11 then
			var_0_5:show(var_0_10:get("手机信息不符合"))

			return false
		end

		local var_21_1 = false

		if #arg_21_1 == 0 then
			return false
		elseif #arg_21_1 > 0 then
			while 1 <= #arg_21_1 do
				local var_21_2 = string.byte(arg_21_1, 1)

				if not var_21_2 then
					break
				end

				if var_21_2 >= 48 and var_21_2 <= 57 then
					var_21_1 = true
				else
					var_21_1 = false

					return false
				end
			end
		end

		return var_21_1
	end

	function arg_1_0.__input_realcard_is_pass(arg_22_0, arg_22_1)
		if not arg_22_1 then
			var_0_5:show(var_0_10:getNowLang("verify_error"))

			return
		end

		local var_22_1 = var_0_13.utf8len(arg_22_1)

		if #arg_22_1 == 18 and var_22_1 then
			var_22_1 = true
		else
			var_0_5:show(var_0_10:getNowLang("verify_error"))

			return false
		end

		return var_22_1
	end

	function arg_1_0:__req_account_login(arg_23_1, arg_23_2, arg_23_3)
		self._login_data = {
			username = arg_23_1,
			password = arg_23_2,
			channel = arg_23_3
		}

		log.print_r(self._login_data, "看看_login_data")

		local var_23_0 = var_0_4:create()

		var_23_0:set_url("http://192.168.1.195:10006/login/")
		var_23_0:set_fields((var_0_2(self._login_data)))
		var_23_0:set_post()
		var_23_0:set_response_func(function(arg_24_0, arg_24_1)
			log.print_r(arg_24_0, "url")
			log.print_r(arg_24_1, "response_data")

			local var_24_0 = var_0_3(arg_24_1)

			if var_24_0.error_code == 0 then
				self._repeat_num = 0

				if self._succeed_callback then
					self._succeed_callback(var_24_0)
				end
			elseif var_24_0.error_code == -113 then
				self._repeat_num = 0

				self:loadUI("login_prompt"):show(var_0_10:getNowLang("errorcode_019"))
				self:__show_login()
			elseif self._repeat_num < 3 then
				self._repeat_num = self._repeat_num + 1

				self:__req_account_login(arg_23_1, arg_23_2, arg_23_3)
			else
				self:__show_login()
			end
		end)
		var_23_0:set_error_func(function(arg_25_0, arg_25_1)
			log.print_r(arg_25_1, "没连上，看看code")
			log.print_r(arg_25_0, "没连上，看看url")
			self:__req_account_login(arg_23_1, arg_23_2, arg_23_3)
		end)
		var_23_0:execute()
	end

	function arg_1_0:__req_account_register(arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5, arg_26_6)
		arg_26_3 = "hm_android_jp"

		local var_26_0 = {
			username = arg_26_1,
			password = arg_26_2
		}

		var_26_0.channel = "hm_android_jp"
		var_26_0.phone = arg_26_4
		var_26_0.idcard = arg_26_6
		var_26_0.realname = arg_26_5
		self._register_data = var_26_0

		log.print_r(self._register_data, "self._register_data")
		log.print_r("http://192.168.1.195:10006/registe/", "url地址？？？")

		local var_26_2 = var_0_4:create()

		print(var_0_12:isAuditVersion(), "AuditServerManager:isAuditVersion()")
		print("hm_android_jp", "channel")
		print(var_0_8:channel_back("registe_url", var_0_12:isAuditVersion(), "hm_android_jp"), "返回的url")
		var_26_2:set_url("http://192.168.1.195:10006/registe/")
		var_26_2:set_fields((var_0_2(self._register_data)))
		var_26_2:set_post()
		var_26_2:set_response_func(function(arg_27_0, arg_27_1)
			log.print_r("这里有吗？？？")

			local var_27_0 = var_0_3(arg_27_1)

			log.print_r(var_27_0, "response??????????????????")

			if var_27_0.error_code == 0 then
				log.print_r("1成功？1111111111")

				self._repeat_num = 0

				if self._register_succeed_callback then
					self._register_succeed_callback(var_27_0)
				end
			else
				log.print_r(var_27_0.error_msg, "不成功")
				self:loadUI("login_prompt"):show(var_0_10:get(var_27_0.error_msg))
				self:__show_login()
			end
		end)
		var_26_2:set_error_func(function(arg_28_0, arg_28_1)
			log.print_r(arg_28_0, "重连了url")
			log.print_r(arg_28_1, "重连了error_code")

			if self._repeat_num < 2 then
				self:__req_account_register(arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5, arg_26_6)

				self._repeat_num = self._repeat_num + 1
			end
		end)
		var_26_2:execute()
	end

	function arg_1_0:__init_slider_normal_regiester_listenter_one()
		self._control.RegiesterWnd.RegiesterAll.RegBox.UserName.inputField.onEndEdit:RemoveAllListeners()
		self._control.RegiesterWnd.RegiesterAll.RegBox.UserName.inputField.onEndEdit:AddListener(function()
			self._reg_username = self._control.RegiesterWnd.RegiesterAll.RegBox.UserName.inputField.text
		end)
	end

	function arg_1_0:__init_slider_normal_regiester_listenter_two()
		self._control.RegiesterWnd.RegiesterAll.PasBox.PassWord.inputField.onEndEdit:RemoveAllListeners()
		self._control.RegiesterWnd.RegiesterAll.PasBox.PassWord.inputField.onEndEdit:AddListener(function()
			self._reg_password = self._control.RegiesterWnd.RegiesterAll.PasBox.PassWord.inputField.text
		end)
	end

	function arg_1_0:__init_slider_normal_regiester_listenter_three()
		self._control.RegiesterWnd.RegiesterAll.PhoneBox.PhoneWord.inputField.onEndEdit:RemoveAllListeners()
		self._control.RegiesterWnd.RegiesterAll.PhoneBox.PhoneWord.inputField.onEndEdit:AddListener(function()
			self._reg_phonenumber = self._control.RegiesterWnd.RegiesterAll.PhoneBox.PhoneWord.inputField.text
		end)
	end

	function arg_1_0:__init_slider_normal_regiester_listenter_four()
		self._control.RegiesterWnd.RegiesterAll.RealNameBox.NameWord.inputField.onEndEdit:RemoveAllListeners()
		self._control.RegiesterWnd.RegiesterAll.RealNameBox.NameWord.inputField.onEndEdit:AddListener(function()
			self._reg_realname = self._control.RegiesterWnd.RegiesterAll.RealNameBox.NameWord.inputField.text
		end)
	end

	function arg_1_0:__init_slider_normal_regiester_listenter_five()
		self._control.RegiesterWnd.RegiesterAll.CardBox.CardWord.inputField.onEndEdit:RemoveAllListeners()
		self._control.RegiesterWnd.RegiesterAll.CardBox.CardWord.inputField.onEndEdit:AddListener(function()
			self._reg_cardnum = self._control.RegiesterWnd.RegiesterAll.CardBox.CardWord.inputField.text
		end)
	end

	function arg_1_0:__forget_password()
		print("进入通过账号找回密码")
		self._control.ForgetPasswordStep.RegBox.UserName.inputField.onEndEdit:RemoveAllListeners()
		self._control.ForgetPasswordStep.RegBox.UserName.inputField.onEndEdit:AddListener(function()
			self._forget_password_username = self._control.ForgetPasswordStep.RegBox.UserName.inputField.text
		end)
	end

	function arg_1_0:__set_password_find_info()
		if not false then
			return
		end

		self._control.ForgetPasswordStep.RegBox:SetActive(false)
		self._control.ForgetPasswordStep.FindButton:SetActive(false)
		self._control.ForgetPasswordStep.FinishFind:SetActive(true)
	end

	function arg_1_0:__show_login()
		var_0_1:destroyInstance("loading")

		self._repeat_num = 0

		self:show()
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0.__initia_lize(arg_44_0)
		arg_44_0._channel = nil
		arg_44_0._user_username = nil
		arg_44_0._user_password = nil
		arg_44_0._reg_username = nil
		arg_44_0._reg_password = nil
		arg_44_0._reg_phonenumber = nil
		arg_44_0._reg_realname = nil
		arg_44_0._reg_cardnum = nil
		arg_44_0._forget_password_username = nil
		arg_44_0._repeat_num = 0
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_45_0)
	local var_45_0 = var_0_1:class("login_lua_new")

	var_45_0:__initia_lize()

	return var_45_0
end

return var_0_0
