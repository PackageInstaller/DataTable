local var_0_0 = {}
local var_0_2 = gamecore.Language

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_LoginWnd_JP_OrderBox_Close()
		self:__close(false)
	end

	function arg_1_0:__onClick_LoginWnd_JP_RegBox_Regiest()
		self:__change_panel("regist_panel")
	end

	function arg_1_0:__onClick_LoginWnd_JP_PasBox_changePas()
		self:__change_panel("forget_pwd_panel")
	end

	function arg_1_0:__onClick_LoginWnd_JP_LoginButton()
		local var_5_0 = self:loadUI("login_prompt")
		local var_5_1 = app:getSystem():getChannel()

		if var_5_1 == "hm_ios" then
			var_5_1 = "hm_sdk_ios"
		end

		if self._panel_list.login_panel.RegBox.UserName.inputField.text == nil or self._panel_list.login_panel.RegBox.UserName.inputField.text == "" then
			var_5_0:show(var_0_2:getNowLang("hmloginerror21011"))
		elseif self._panel_list.login_panel.PasBox.PassWord.inputField.text == nil or self._panel_list.login_panel.RegBox.UserName.inputField.text == "" then
			var_5_0:show(var_0_2:getNowLang("hmloginerror21012"))
		else
			self:req_account_server(self._panel_list.login_panel.RegBox.UserName.inputField.text, self._panel_list.login_panel.PasBox.PassWord.inputField.text, var_5_1)
		end
	end

	function arg_1_0:__onClick_LoginWnd_JP_QuickRegiest()
		local var_6_0 = DeviceInfo.GetDeviceID()
		local var_6_1 = app:getSystem():getChannel()

		if var_6_1 == "hm_ios" then
			var_6_1 = "hm_sdk_ios"
		end

		if var_6_0 == nil or var_6_0 == "" then
			self:loadUI("login_prompt"):show(var_0_2:getNowLang("hmloginerror21011"))
		else
			self:req_quick_account_server(var_6_0, var_6_1)
		end
	end

	function arg_1_0:__onClick_LoginWnd_JP_changePas()
		self:__change_panel("change_pwd_panel")

		self._panel_list.change_pwd_panel.InputBox.RegBox.OldPass.inputField.text = ""
		self._panel_list.change_pwd_panel.InputBox.PasBox.PassWord.inputField.text = ""
		self._panel_list.change_pwd_panel.InputBox.PasBoxSure.PassWord.inputField.text = ""
	end

	function arg_1_0:__onClick_ForgetPasswordStep_JP_OrderBox_Close()
		self:__close(false)
	end

	function arg_1_0:__onClick_ForgetPasswordStep_JP_RegBox_Regiest()
		self:__change_panel("login_panel")
	end

	function arg_1_0:__onClick_ForgetPasswordStep_JP_LoginButton()
		local var_10_0 = self._panel_list.forget_pwd_panel.RegBox.UserName.inputField.text
		local var_10_1 = app:getSystem():getChannel()

		if var_10_1 == "hm_ios" then
			var_10_1 = "hm_sdk_ios"
		end

		if var_10_0 == nil or var_10_0 == "" then
			self:loadUI("login_prompt"):show(var_0_2:getNowLang("hmloginerror21011"))
		else
			self:req_pwd_url(var_10_0, var_10_1)
		end

		print(var_10_0)
	end

	function arg_1_0:__onClick_RegiesterNotAuthWnd_JP_OrderBox_Close()
		local var_11_0 = self._panel_list.regist_panel.InputBox.RegBox.UserName.inputField.text
		local var_11_1 = self._panel_list.regist_panel.InputBox.PasBox.PassWord.inputField.text
		local var_11_2 = self._panel_list.regist_panel.InputBox.PasBoxSure.PassWord.inputField.text
		local var_11_3 = self:loadUI("login_prompt")
		local var_11_4 = app:getSystem():getChannel()

		if var_11_4 == "hm_ios" then
			var_11_4 = "hm_sdk_ios"
		end

		if var_11_0 == nil or var_11_0 == "" then
			var_11_3:show(var_0_2:getNowLang("sininuseridinputerrornotice"))
		elseif var_11_1 == nil or var_11_1 == "" then
			var_11_3:show(var_0_2:getNowLang("signinpasswordinputerrornotice"))
		elseif var_11_2 == nil or var_11_2 == "" then
			var_11_3:show(var_0_2:getNowLang("signinpasswordinputerrornotice"))
		elseif var_11_1 ~= var_11_2 then
			var_11_3:show(var_0_2:getNowLang("signinregisterpasswordnotsame"))
		else
			self:req_account_register(var_11_0, var_11_1, var_11_4)
		end

		print(var_11_0 .. "  " .. var_11_1 .. "  " .. var_11_2)
	end

	function arg_1_0:__onClick_RegiesterNotAuthWnd_JP_LoginButton()
		self:__change_panel("login_panel")
	end

	function arg_1_0:__onClick_RePasswordWnd_JP_OrderBox_Close()
		self:__close(false)
	end

	function arg_1_0:__onClick_RePasswordWnd_JP_RePassBtn()
		local var_14_0 = self:loadUI("login_prompt")
		local var_14_1 = app:getSystem():getChannel()

		if var_14_1 == "hm_ios" then
			var_14_1 = "hm_sdk_ios"
		end

		if self._panel_list.change_pwd_panel.InputBox.RegBox.OldPass.inputField.text == nil or self._panel_list.change_pwd_panel.InputBox.RegBox.OldPass.inputField.text == "" then
			var_14_0:show(var_0_2:getNowLang("hmloginerror21011"))
		elseif self._panel_list.change_pwd_panel.InputBox.PasBox.PassWord.inputField.text == nil or self._panel_list.change_pwd_panel.InputBox.PasBox.PassWord.inputField.text == "" then
			var_14_0:show(var_0_2:getNowLang("hmloginerror21012"))
		elseif self._panel_list.change_pwd_panel.InputBox.PasBoxSure.PassWord.inputField.text == nil or self._panel_list.change_pwd_panel.InputBox.PasBoxSure.PassWord.inputField.text == "" then
			var_14_0:show(var_0_2:getNowLang("hmloginerror21012"))
		elseif self._panel_list.change_pwd_panel.InputBox.PasBox.PassWord.inputField.text == self._panel_list.change_pwd_panel.InputBox.PasBoxSure.PassWord.inputField.text then
			var_14_0:show(var_0_2:getNowLang("signinpasswordsameerrornotice"))
		else
			self:req_pwd_change(self._panel_list.change_pwd_panel.InputBox.RegBox.OldPass.inputField.text, self._panel_list.change_pwd_panel.InputBox.PasBox.PassWord.inputField.text, self._panel_list.change_pwd_panel.InputBox.PasBoxSure.PassWord.inputField.text, var_14_1)
		end
	end
end

function var_0_0.extend_obj(arg_15_0)
	return
end

return var_0_0
