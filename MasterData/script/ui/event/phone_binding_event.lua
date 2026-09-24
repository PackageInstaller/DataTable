local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_3 = gamecore.prompt
local var_0_4 = gamecore.Language
local var_0_7 = gamecore.AccountPlatform

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg_main_input_main_code_btn()
		self._is_phone_num = false

		if self._phone_number then
			if self:_estimate_is_num(self._phone_number) and #self._phone_number == 11 then
				self._is_phone_num = true

				self:__do_code_success({
					areaCode = 86,
					appid = 0,
					type = 4,
					mobile = self._phone_number
				})
			else
				var_0_3:show(var_0_4:get("手机格式不正确"))
			end
		else
			var_0_3:show(var_0_4:get("手机号不能为空"))
		end
	end

	function arg_1_0:__onClick_bg_main_input_main_btn()
		self._is_phone_num = false

		if not self._phone_number or #self._phone_number == 0 or not self._get_code or #self._get_code == 0 then
			var_0_3:show(var_0_4:get("手机号和验证码都不能为空"))
		elseif self._phone_number and #self._phone_number ~= 0 and self._get_code and #self._get_code ~= 0 then
			local var_3_0 = self:_estimate_is_num(self._get_code)
			local var_3_1 = self:_estimate_is_num(self._phone_number)

			self._is_phone_num = self:_estimate_is_num(self._phone_number)

			if #self._phone_number ~= 11 or not var_3_1 or not self._is_phone_num then
				var_0_3:show(var_0_4:get("手机号格式不正确"))

				return
			end

			if var_3_0 and #self._get_code ~= 6 then
				var_0_3:show(var_0_4:get("验证码格式不正确"))
			elseif var_3_0 and (var_3_1 or self._is_phone_num) then
				self._token = var_0_7:getToken()

				self:__do_phone_success({
					appid = 0,
					areaCode = 86,
					token = self._token,
					mobile = self._phone_number,
					captcha = self._get_code
				})
			else
				var_0_3:show(var_0_4:get("验证码不正确"))
			end
		else
			var_0_3:show(var_0_4:get("手机号或验证码格式不正确"))
		end
	end

	function arg_1_0.__onClick_bg_close(arg_4_0)
		var_0_1:destroyInstance("phone_binding")
	end

	function arg_1_0.__onClick_bg_mail_main_input_main_code_btn(arg_5_0)
		return
	end

	function arg_1_0.__onClick_bg_mail_main_input_main_btn(arg_6_0)
		return
	end

	function arg_1_0.__onClick_bg_mail_close(arg_7_0)
		var_0_1:destroyInstance("phone_binding")
	end

	function arg_1_0.__onClick_bg_mail_need_bind_mail_btn(arg_8_0)
		return
	end
end

function var_0_0.extend_obj(arg_9_0)
	return
end

return var_0_0
