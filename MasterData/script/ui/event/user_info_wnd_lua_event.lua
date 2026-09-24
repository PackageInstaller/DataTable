local var_0_0 = {}
local var_0_1 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onClick_OrderBox_Left(arg_2_0)
		return
	end

	function arg_1_0.__onClick_OrderBox_Close(arg_3_0)
		log.print_r("销毁用户中心")
		var_0_1:destroyInstance("user_info_wnd_lua")
	end

	function arg_1_0.__onClick_ButtonBox_OutButton(arg_4_0)
		(var_0_1:getInstance("login_lua_new") or var_0_1:createInstance("login_lua_new")):show()
		var_0_1:destroyInstance("user_info_wnd_lua")
	end

	function arg_1_0.__onClick_ButtonBox_BindButton(arg_5_0)
		return
	end

	function arg_1_0:__onClick_UserInfoBox_ChangShow_ChangePass()
		log.print_r("显示修改密码的内容")
		self._control.resetpasswordWnd:SetActive(true)
	end

	function arg_1_0:__onClick_UserInfoBox_ChangShow_bindmailinfo_BindMail()
		log.print_r("点击显示邮箱绑定")
		self._control.bindmail:SetActive(true)
	end

	function arg_1_0.__onClick_UserInfoBox_ChangShow_bindphoneinfo_BindPhone(arg_8_0)
		return
	end

	function arg_1_0:__onClick_resetpasswordWnd_OrderBox_Left()
		self._control.resetpasswordWnd:SetActive(false)
	end

	function arg_1_0.__onClick_resetpasswordWnd_OrderBox_Close(arg_10_0)
		return
	end

	function arg_1_0.__onClick_resetpasswordWnd_verifyButton(arg_11_0)
		return
	end

	function arg_1_0:__onClick_bindmail_OrderBox_Left()
		log.print_r("离开邮箱绑定")
		self._control.bindmail:SetActive(false)
	end

	function arg_1_0.__onClick_bindmail_OrderBox_Close(arg_13_0)
		return
	end

	function arg_1_0.__onClick_bindmail_FindButton(arg_14_0)
		return
	end

	function arg_1_0.__onClick_bindmail_FinishFind_BackBtn(arg_15_0)
		return
	end
end

function var_0_0.extend_obj(arg_16_0)
	return
end

return var_0_0
