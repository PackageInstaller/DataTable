local var_0_0 = {}
local var_0_1 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onClick_LoginWnd_CN_OrderBox_Left(arg_2_0)
		log.print_r("账号登录返回")
	end

	function arg_1_0.__onClick_LoginWnd_CN_OrderBox_Close(arg_3_0)
		log.print_r("关闭登录界面")

		if var_0_1:getInstance("login_lua_new") then
			var_0_1:destroyInstance("login_lua_new")
		end
	end

	function arg_1_0:__onClick_LoginWnd_CN_RegBox_Regiest()
		log.print_r("账号注册")
		self._control.LoginWnd_CN:SetActive(false)
		self._control.RegiesterWnd:SetActive(true)
		self:__normal_user_regiester()
	end

	function arg_1_0:__onClick_LoginWnd_CN_PasBox_changePas()
		log.print_r("点击忘记账号密码，弹出对应的找回密码界面界面")
		self._control.LoginWnd_CN:SetActive(false)
		self._control.ForgetPasswordStep:SetActive(true)
	end

	function arg_1_0:__onClick_LoginWnd_CN_LoginButton()
		log.print_r("登录测试")
		self:__user_login_info()
	end

	function arg_1_0.__onClick_LoginWnd_CN_QuickRegiest(arg_7_0)
		return
	end

	function arg_1_0:__onClick_LoginWnd_CN_PhoneNumberLogin()
		log.print_r("手机号登录")
		self._control.LoginWnd_CN:SetActive(false)
		self._control.PhoneLoginWnd_CN:SetActive(true)
	end

	function arg_1_0:__onClick_LoginWnd_CN_PhoneLogin()
		self._control.LoginWnd_CN:SetActive(false)
		self._control.CodeLoginWnd_CN:SetActive(true)
	end

	function arg_1_0:__onClick_ForgetPasswordStep_OrderBox_Left()
		self._control.LoginWnd_CN:SetActive(true)
		self._control.ForgetPasswordStep:SetActive(false)
	end

	function arg_1_0.__onClick_ForgetPasswordStep_OrderBox_Close(arg_11_0)
		return
	end

	function arg_1_0:__onClick_ForgetPasswordStep_FindButton()
		log.print_r("找回密码下一步")
		log.print_r(self._forget_password_username, "self._forget_password_username")
		self:__set_password_find_info()
	end

	function arg_1_0.__onClick_ForgetPasswordStep_FinishFind_BackBtn(arg_13_0)
		return
	end

	function arg_1_0.__onClick_PhoneLoginWnd_CN_OrderBox_Left(arg_14_0)
		return
	end

	function arg_1_0.__onClick_PhoneLoginWnd_CN_OrderBox_Close(arg_15_0)
		log.print_r("关闭手机登录界面")

		if var_0_1:getInstance("login_lua_new") then
			var_0_1:destroyInstance("login_lua_new")
		end
	end

	function arg_1_0:__onClick_PhoneLoginWnd_CN_RegBox_Regiest()
		log.print_r("手机登录界面的注册账号")
		self._control.PhoneLoginWnd_CN:SetActive(false)
		self._control.RegiesterWnd:SetActive(true)
	end

	function arg_1_0:__onClick_PhoneLoginWnd_CN_PasBox_changePas()
		log.print_r("手机登录界面的找回密码")
		self._control.PhoneLoginWnd_CN:SetActive(false)
		self._control.PhoneForgetPwdStep:SetActive(true)
	end

	function arg_1_0:__onClick_PhoneLoginWnd_CN_LoginButton()
		log.print_r("手机登录界面切换为账号登录")
		self._control.LoginWnd_CN:SetActive(true)
		self._control.PhoneLoginWnd_CN:SetActive(true)
	end

	function arg_1_0.__onClick_PhoneLoginWnd_CN_QuickRegiest(arg_19_0)
		return
	end

	function arg_1_0:__onClick_PhoneLoginWnd_CN_NormalLogin()
		self._control.LoginWnd_CN:SetActive(true)
		self._control.PhoneLoginWnd_CN:SetActive(false)
	end

	function arg_1_0:__onClick_PhoneLoginWnd_CN_PhoneLogin()
		log.print_r("手机登录界面切换为手机验证码登录")
		self._control.PhoneLoginWnd_CN:SetActive(false)
		self._control.CodeLoginWnd_CN:SetActive(true)
	end

	function arg_1_0:__onClick_RegiesterWnd_OrderBox_Left()
		log.print_r("注册账号返回")
		self._control.LoginWnd_CN:SetActive(true)
		self._control.RegiesterWnd:SetActive(false)
	end

	function arg_1_0.__onClick_RegiesterWnd_OrderBox_Close(arg_23_0)
		return
	end

	function arg_1_0:__onClick_RegiesterWnd_LoginButton()
		log.print_r("注册并登录")
		self:__user_req_info()
	end

	function arg_1_0:__onClick_PhoneForgetPwdStep_OrderBox_Left()
		log.print_r("手机找回密码返回")
		self._control.PhoneLoginWnd_CN:SetActive(true)
		self._control.PhoneForgetPwdStep:SetActive(false)
	end

	function arg_1_0.__onClick_PhoneForgetPwdStep_OrderBox_Close(arg_26_0)
		return
	end

	function arg_1_0.__onClick_PhoneForgetPwdStep_FinishFind_PwdBox_SendBtn(arg_27_0)
		return
	end

	function arg_1_0.__onClick_CodeLoginWnd_CN_OrderBox_Left(arg_28_0)
		return
	end

	function arg_1_0.__onClick_CodeLoginWnd_CN_OrderBox_Close(arg_29_0)
		log.print_r("关闭验证码登录界面")

		if var_0_1:getInstance("login_lua_new") then
			var_0_1:destroyInstance("login_lua_new")
		end
	end

	function arg_1_0.__onClick_CodeLoginWnd_CN_RegBox_Regiest(arg_30_0)
		return
	end

	function arg_1_0.__onClick_CodeLoginWnd_CN_PasBox_SendButton(arg_31_0)
		return
	end

	function arg_1_0.__onClick_CodeLoginWnd_CN_LoginButton(arg_32_0)
		return
	end

	function arg_1_0.__onClick_CodeLoginWnd_CN_QuickRegiest(arg_33_0)
		return
	end

	function arg_1_0:__onClick_CodeLoginWnd_CN_NormalLogin()
		log.print_r("验证码登录切换手机号登录")
		self._control.LoginWnd_CN:SetActive(true)
		self._control.CodeLoginWnd_CN:SetActive(false)
	end

	function arg_1_0:__onClick_CodeLoginWnd_CN_PhoneLogin()
		log.print_r("验证码登录切换手机号登录")
		self._control.PhoneLoginWnd_CN:SetActive(true)
		self._control.CodeLoginWnd_CN:SetActive(false)
	end

	function arg_1_0.__onClick_ForgetPasswordStep_ChangeFind_mailBtn(arg_36_0)
		return
	end

	function arg_1_0.__onClick_ForgetPasswordStep_ChangeFind_phoneBtn(arg_37_0)
		return
	end

	function arg_1_0.__onClick_ForgetPasswordStep_RegphoneBox_PhoneFindButton(arg_38_0)
		return
	end

	function arg_1_0.__onClick_ForgetPasswordStep_RegphoneBox_codesend(arg_39_0)
		return
	end
end

function var_0_0.extend_obj(arg_40_0)
	return
end

return var_0_0
