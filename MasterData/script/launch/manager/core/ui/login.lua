local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.launch_common_type
local var_0_3 = lx.UserData
local var_0_4 = gamecore.Language
local var_0_5 = lx.http_request
local var_0_6 = lx.json_encode
local var_0_7 = lx.json_decode
local var_0_8 = "[^%w_]"
local var_0_9 = gamecore.AuditServerManager

gamecore.UILoader:define("login", function(arg_1_0)
	function arg_1_0:show()
		self:__init_panel_list()
		self:init()
		self:setVisible(true)
		self:__init_panel_language()
		self:__init_input_listener()
		self:__change_panel("login_panel")
	end

	function arg_1_0.init(arg_3_0)
		function arg_3_0:_succeed_callback()
			var_0_1:destroyInstance("loading")
			gamecore.AccountPlatform:setUid(self.uuid)
			gamecore.AccountPlatform:setToken(tostring(self.token))
			arg_3_0:setVisible(false)
			arg_3_0:__login_success(arg_3_0._login_data)
		end

		function arg_3_0:_register_succeed_callback()
			var_0_1:destroyInstance("loading")
			gamecore.AccountPlatform:setUid(self.uuid)
			gamecore.AccountPlatform:setToken(tostring(self.token))
			arg_3_0:setVisible(false)
			arg_3_0:__register_success(arg_3_0._register_data)
		end

		function arg_3_0._change_pwd_succeed_callback(arg_6_0)
			var_0_1:destroyInstance("loading")
			arg_3_0:setVisible(false)
			arg_3_0:__change_pwd_success()
		end

		function arg_3_0._url_pwd_succeed_callback(arg_7_0)
			var_0_1:destroyInstance("loading")
			arg_3_0:setVisible(false)
			arg_3_0:__url_pwd_success()
		end
	end

	function arg_1_0.__login_success(arg_8_0, arg_8_1)
		var_0_3:setKeyData("Account_UserName", arg_8_1.username)
		var_0_3:setKeyData("Account_PassWord", arg_8_1.password)
		var_0_1:createInstance("enter_game"):show()
	end

	function arg_1_0:__register_success(arg_9_1)
		var_0_3:setKeyData("Account_UserName", arg_9_1.username)
		var_0_3:setKeyData("Account_PassWord", arg_9_1.password)

		self._panel_list.login_panel.RegBox.UserName.inputField.text = arg_9_1.username
		self._panel_list.login_panel.PasBox.PassWord.inputField.text = arg_9_1.password

		var_0_1:createInstance("enter_game"):show()
	end

	function arg_1_0.__change_pwd_success(arg_10_0)
		var_0_1:getInstance("enter_game"):setVisible(true)
	end

	function arg_1_0.__url_pwd_success(arg_11_0)
		var_0_1:getInstance("enter_game"):setVisible(true)
	end

	function arg_1_0:__init_panel_list()
		self._panel_list = {
			login_panel = self._control.LoginWnd_JP,
			regist_panel = self._control.RegiesterNotAuthWnd_JP,
			change_pwd_panel = self._control.RePasswordWnd_JP,
			forget_pwd_panel = self._control.ForgetPasswordStep_JP
		}

		for iter_12_0, iter_12_1 in pairs(self._panel_list) do
			if iter_12_1.gameObject.activeSelf then
				self._curr_panel = iter_12_0

				return
			end
		end

		self._curr_panel = "login_panel"
	end

	function arg_1_0:__init_panel_language()
		if self._already_init then
			return
		else
			local var_13_0, var_13_1, var_13_2 = self:__get_account_username()
			local var_13_3 = app:getSystem():getChannel()

			if var_13_3 == "hm_ios" then
				var_13_3 = "hm_sdk_ios"
			end

			if var_13_0 then
				self:setVisible(false)

				self._panel_list.login_panel.RegBox.UserName.inputField.text = var_13_1
				self._panel_list.login_panel.PasBox.PassWord.inputField.text = var_13_2

				var_0_1:createInstance("loading"):show(true, nil, false, "")
				self:req_account_server(var_13_1, var_13_2, var_13_3)
				var_0_1:createInstance("enter_game"):show()
			else
				self:setVisible(true)
			end
		end

		self._panel_list.login_panel.OrderBox.TitleText.text.text = var_0_4:getNowLang("signinsignin")
		self._panel_list.login_panel.RegBox.UserNameLable.text.text = var_0_4:getNowLang("signinusername")
		self._panel_list.login_panel.RegBox.UserName.Placeholder.text.text = var_0_4:getNowLang("inputsignname")
		self._panel_list.login_panel.RegBox.Regiest.Text.text.text = var_0_4:getNowLang("sreg")
		self._panel_list.login_panel.PasBox.PassWordLable.text.text = var_0_4:getNowLang("signpassword")
		self._panel_list.login_panel.PasBox.PassWord.Placeholder.text.text = var_0_4:getNowLang("inputsignpwd")
		self._panel_list.login_panel.LoginButton.Text.text.text = var_0_4:getNowLang("ui_lt1")
		self._panel_list.login_panel.QuickRegiest.Text.text.text = var_0_4:getNowLang("squi")
		self._panel_list.login_panel.changePas.Text.text.text = var_0_4:getNowLang("settingmp")

		local var_13_4, var_13_5, var_13_6, var_13_7 = self:__get_account_username()

		self._panel_list.login_panel.QuickRegiest:SetActive(not var_13_4 and var_13_7)
		self._panel_list.login_panel.changePas:SetActive(var_13_4 or not var_13_7)

		self._panel_list.forget_pwd_panel.ForgetPasswordStepLable.Text.text.text = var_0_4:getNowLang("signinforgetpasswordcontent2")
		self._panel_list.forget_pwd_panel.OrderBox.TitleText.text.text = var_0_4:getNowLang("signinforgetpasswordtitle")
		self._panel_list.forget_pwd_panel.RegBox.UserNameLable.text.text = var_0_4:getNowLang("signinusername")
		self._panel_list.forget_pwd_panel.RegBox.UserName.Placeholder.text.text = var_0_4:getNowLang("inputsignname")
		self._panel_list.forget_pwd_panel.RegBox.Regiest.Text.text.text = var_0_4:getNowLang("sbtnback")
		self._panel_list.forget_pwd_panel.LoginButton.Text.text.text = var_0_4:getNowLang("sbtnfind")
		self._panel_list.regist_panel.RegiesterLable.Text.text.text = "\t\t" .. string.sub(var_0_4:getNowLang("ui_logintip7"), 1, 60) .. "\n\t\t" .. string.sub(var_0_4:getNowLang("ui_logintip7"), 61)
		self._panel_list.regist_panel.OrderBox.TitleText.text.text = var_0_4:getNowLang("sreg")
		self._panel_list.regist_panel.OrderBox.Close.Text.text.text = var_0_4:getNowLang("sreglg")
		self._panel_list.regist_panel.InputBox.RegBox.UserNameLable.text.text = var_0_4:getNowLang("signinusername")
		self._panel_list.regist_panel.InputBox.RegBox.UserName.Placeholder.text.text = var_0_4:getNowLang("inputsignname")
		self._panel_list.regist_panel.InputBox.PasBox.UserNameLable.text.text = var_0_4:getNowLang("signpassword")
		self._panel_list.regist_panel.InputBox.PasBox.PassWord.Placeholder.text.text = var_0_4:getNowLang("inputsignpwd")
		self._panel_list.regist_panel.InputBox.PasBoxSure.UserNameLable.text.text = var_0_4:getNowLang("settingchangepasswordnew2")
		self._panel_list.regist_panel.InputBox.PasBoxSure.PassWord.Placeholder.text.text = var_0_4:getNowLang("inputpwdagain")
		self._panel_list.regist_panel.LoginButton.Text.text.text = var_0_4:getNowLang("sbtnback")
		self._panel_list.change_pwd_panel.OrderBox.TitleText.text.text = var_0_4:getNowLang("settingmp")
		self._panel_list.change_pwd_panel.InputBox.RegBox.UserNameLable.text.text = var_0_4:getNowLang("signinusername")
		self._panel_list.change_pwd_panel.InputBox.RegBox.OldPass.Placeholder.text.text = var_0_4:getNowLang("inputsignname")
		self._panel_list.change_pwd_panel.InputBox.PasBox.UserNameLable.text.text = var_0_4:getNowLang("settingchangepasswordold")
		self._panel_list.change_pwd_panel.InputBox.PasBox.PassWord.Placeholder.text.text = var_0_4:getNowLang("inputoldpwd")
		self._panel_list.change_pwd_panel.InputBox.PasBoxSure.UserNameLable.text.text = var_0_4:getNowLang("settingchangepasswordnew1")
		self._panel_list.change_pwd_panel.InputBox.PasBoxSure.PassWord.Placeholder.text.text = var_0_4:getNowLang("inputnewpwd")
		self._panel_list.change_pwd_panel.RePassBtn.Text.text.text = var_0_4:getNowLang("confirm")
		self._already_init = true
	end

	function arg_1_0:__change_panel(arg_14_1)
		if arg_14_1 ~= self._curr_panel then
			self._panel_list[self._curr_panel]:SetActive(false)
			self._panel_list[arg_14_1]:SetActive(true)

			self._curr_panel = arg_14_1
		end
	end

	function arg_1_0.__get_account_username(arg_15_0)
		local var_15_0 = var_0_3:getKeyData("Account_UserName")
		local var_15_1 = var_0_3:getKeyData("Account_PassWord")
		local var_15_2 = var_0_9:isAuditVersion()

		if var_15_0 ~= nil and var_15_0 ~= "" and var_15_1 ~= nil and var_15_1 ~= "" then
			return true, var_15_0, var_15_1, var_15_2
		end

		return false, var_15_0, var_15_1, var_15_2
	end

	function arg_1_0:__close(arg_16_1)
		if not arg_16_1 then
			if not self:__get_account_username() then
				self:show()
			else
				self:setVisible(false)
				var_0_1:getInstance("enter_game"):setVisible(true)
			end

			self:__change_panel("login_panel")

			return
		end
	end

	function arg_1_0:req_account_server(arg_17_1, arg_17_2, arg_17_3)
		local var_17_0 = self:loadUI("login_prompt")

		self._login_data = {
			username = arg_17_1,
			password = arg_17_2,
			channel = arg_17_3
		}

		local var_17_1 = var_0_5:create()

		var_17_1:set_url(var_0_2:channel_back("login_url", var_0_9:isAuditVersion(), arg_17_3))
		var_17_1:set_fields((var_0_6(self._login_data)))
		var_17_1:set_post()
		var_17_1:set_response_func(function(arg_18_0, arg_18_1)
			local var_18_0 = var_0_7(arg_18_1)

			if var_18_0.error_code == 0 then
				self._repeat_num = 0

				if self._succeed_callback then
					self._succeed_callback(var_18_0)
				end
			elseif var_18_0.error_code == -113 then
				self._repeat_num = 0

				self:loadUI("login_prompt"):show(var_0_4:getNowLang("errorcode_019"))
				self:__show_login()
			else
				var_17_0:show(var_0_4:get("其他情况 "))

				if self._repeat_num < 3 then
					self._repeat_num = self._repeat_num + 1

					self:req_account_server(arg_17_1, arg_17_2, arg_17_3)
				else
					self:__show_login()
				end
			end
		end)
		var_17_1:set_error_func(function(arg_19_0, arg_19_1)
			var_17_0:show(var_0_4:get("未连接到服务器 ") .. "error: " .. arg_19_1)
			self:req_account_server(arg_17_1, arg_17_2, arg_17_3)
		end)
		var_17_1:execute()
	end

	function arg_1_0:req_quick_account_server(arg_20_1, arg_20_2)
		self._login_data = {
			device_code = arg_20_1,
			channel = arg_20_2
		}

		local var_20_0 = var_0_5:create()

		var_20_0:set_url(var_0_2:channel_back("instant_login", var_0_9:isAuditVersion(), arg_20_2))
		var_20_0:set_fields((var_0_6(self._login_data)))
		var_20_0:set_post()
		var_20_0:set_response_func(function(arg_21_0, arg_21_1)
			local var_21_0 = var_0_7(arg_21_1)

			if var_21_0.error_code == 0 then
				self._repeat_num = 0

				if self._succeed_callback then
					self._succeed_callback(var_21_0)
				end
			elseif self._repeat_num < 3 then
				self._repeat_num = self._repeat_num + 1

				self:req_quick_account_server(arg_20_1, arg_20_2)
			else
				self:loadUI("login_prompt"):show(var_0_4:get(var_21_0.error_msg))
				self:__show_login()
			end
		end)
		var_20_0:set_error_func(function(arg_22_0, arg_22_1)
			self:req_quick_account_server(arg_20_1, arg_20_2)
		end)
		var_20_0:execute()
	end

	function arg_1_0:req_account_register(arg_23_1, arg_23_2, arg_23_3)
		self._register_data = {
			username = arg_23_1,
			password = arg_23_2,
			channel = arg_23_3
		}

		local var_23_0 = var_0_5:create()

		var_23_0:set_url(var_0_2:channel_back("registe_url", var_0_9:isAuditVersion(), arg_23_3))
		var_23_0:set_fields((var_0_6(self._register_data)))
		var_23_0:set_post()
		var_23_0:set_response_func(function(arg_24_0, arg_24_1)
			local var_24_0 = var_0_7(arg_24_1)

			if var_24_0.error_code == 0 then
				if self._register_succeed_callback then
					self._register_succeed_callback(var_24_0)
				end
			else
				self:loadUI("login_prompt"):show(var_0_4:get(var_24_0.error_msg))
				self:__show_login()
			end
		end)
		var_23_0:set_error_func(function(arg_25_0, arg_25_1)
			self:req_account_register(arg_23_1, arg_23_2, arg_23_3)
		end)
		var_23_0:execute()
	end

	function arg_1_0:req_pwd_change(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
		self._changepwd_data = {
			username = arg_26_1,
			password = arg_26_2,
			new_password = arg_26_3,
			channel = arg_26_4
		}

		local var_26_0 = var_0_5:create()

		var_26_0:set_url(var_0_2:channel_back("change_password_url", var_0_9:isAuditVersion(), arg_26_4))
		var_26_0:set_fields((var_0_6(self._changepwd_data)))
		var_26_0:set_post()
		var_26_0:set_response_func(function(arg_27_0, arg_27_1)
			local var_27_0 = var_0_7(arg_27_1)

			if var_27_0.error_code == 0 then
				if self._change_pwd_succeed_callback then
					self._change_pwd_succeed_callback(var_27_0)
				end
			else
				self:loadUI("login_prompt"):show(var_0_4:get(var_27_0.error_msg))
				self:__show_login()
			end
		end)
		var_26_0:set_error_func(function(arg_28_0, arg_28_1)
			self:req_pwd_change(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
		end)
		var_26_0:execute()
	end

	function arg_1_0:__init_input_listener()
		local var_29_0 = self._panel_list.login_panel.RegBox.UserName.inputField

		self._panel_list.login_panel.RegBox.UserName.inputField.contentType = UnityEngine.UI.InputField.ContentType.Standard

		self._panel_list.login_panel.RegBox.UserName.inputField.onValueChanged:RemoveAllListeners()
		self._panel_list.login_panel.RegBox.UserName.inputField.onValueChanged:AddListener(function(arg_30_0)
			var_29_0.text = string.gsub(arg_30_0, var_0_8, "")
		end)
	end

	function arg_1_0:req_pwd_url(arg_31_1, arg_31_2)
		self._urlepwd_data = {
			username = arg_31_1,
			channel = arg_31_2
		}

		local var_31_0 = var_0_5:create()

		var_31_0:set_url(var_0_2:channel_back("get_password_url", var_0_9:isAuditVersion(), arg_31_2))
		var_31_0:set_fields((var_0_6(self._urlepwd_data)))
		var_31_0:set_post()
		var_31_0:set_response_func(function(arg_32_0, arg_32_1)
			local var_32_0 = var_0_7(arg_32_1)

			if var_32_0.error_code == 0 then
				if self._url_pwd_succeed_callback then
					self._url_pwd_succeed_callback(var_32_0)
				end
			else
				self:loadUI("login_prompt"):show(var_0_4:get(var_32_0.error_msg))
			end
		end)
		var_31_0:set_error_func(function(arg_33_0, arg_33_1)
			self:req_pwd_url(arg_31_1, arg_31_2)
		end)
		var_31_0:execute()
	end

	function arg_1_0:__show_login()
		var_0_1:destroyInstance("loading")

		self._repeat_num = 0

		self:show()
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_35_0)
	local var_35_0 = var_0_1:class("login")

	var_35_0._curr_panel = nil
	var_35_0._panel_list = {}
	var_35_0._login_data = nil
	var_35_0._succeed_callback = nil
	var_35_0._already_init = false
	var_35_0._repeat_num = 0

	return var_35_0
end

return var_0_0
