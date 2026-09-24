local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.user
local var_0_4 = gamecore.Language
local var_0_6 = lx.json_encode
local var_0_7 = lx.json_decode
local var_0_8 = lx.http_request
local var_0_9 = gamecore.prompt
local var_0_10 = gamecore.AccountPlatform
local var_0_11 = crypto.sha1
local var_0_12 = gameenum.launch_common_type
local var_0_13 = string.format
local var_0_14 = lx.UserData

gamecore.UILoader:define("phone_binding", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self._set_time_down then
			self:_set_time_down_func()
		end
	end

	function arg_1_0:show()
		self:setVisible(true)
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
		self:__init_panel()
	end

	function arg_1_0:__init_panel()
		self._user_info = var_0_3:get_use_info_data()
		self._channel = var_0_10:__get_channel()

		self:_is_refresh_token()
		self:_set_is_pre_bind()
		self:_init_phone_bind()
	end

	function arg_1_0:_init_phone_bind()
		self:__init_slider_listenter_one()
		self:__init_slider_listenter_two()

		self._set_need_code_close = true
		self._control.bg.main.input_main.code.btn.button.interactable = true

		if var_0_3:get_phone_bind_cd_time() then
			self._set_time_down = true
			self._control.bg.main.input_main.code.btn.button.interactable = false

			if var_0_3:get_phone_bind_cd_time() <= lx.ServerTime:getUtcTime() then
				self._control.bg.main.input_main.code.btn.button.interactable = true
				self._set_time_down = false
			end
		else
			self._set_time_down = false
		end

		self._control.bg.main.input_main.code.btn.text.text.text = var_0_4:get("发送验证码")
		self._control.bg.introduce.text.text = var_0_4:get("可以在设置界面再次打开")
		self._control.bg.bind_finish.phone_text.text.text = var_0_4:get("您已绑定手机")
	end

	function arg_1_0:_is_refresh_token()
		if lx.ServerTime:getUtcTime() - tonumber((var_0_14:getKeyData("Expires_in_game_time"))) > 6600 then
			var_0_3:req_TokenRefreshReq({
				refresh_token = lx.UserData:getKeyData("LONGREFRESH_TOKEN"),
				channel = self._channel
			})
		end
	end

	function arg_1_0:_set_is_pre_bind()
		self._control.bg_mail:SetActive(false)
		self._control.bg:SetActive(true)
		self._control.bg.introduce:SetActive(true)
		self._control.bg.main:SetActive(true)
		self._control.bg.bind_finish:SetActive(false)

		if self._user_info.binding_phone == 1 or var_0_3:get_now_bind() then
			self._control.bg.introduce:SetActive(false)
			self._control.bg.main:SetActive(false)
			self._control.bg.bind_finish:SetActive(true)
		elseif self._user_info.binding_email == 1 and self._user_info.binding_phone == 0 then
			self._control.bg_mail:SetActive(true)
			self._control.bg:SetActive(false)
			self:_init_mail()
		elseif self._user_info.binding_email == 0 and self._user_info.binding_phone == 0 then
			self._control.bg_mail:SetActive(false)
		end
	end

	function arg_1_0:_set_bind_now()
		self._control.bg.introduce:SetActive(false)
		self._control.bg.main:SetActive(false)
		self._control.bg.bind_finish:SetActive(true)
	end

	function arg_1_0:_init_mail()
		self._control.bg_mail.need_bind_mail.phone_text.text.text = var_0_4:get("您已经绑定邮箱，已向邮箱发送绑定邮件，请前往邮箱进行手机绑定") .. "\n" .. var_0_4:get("邮件可能有延时，如长时间未收到邮件可再次点击手机绑定重新发送邮件。") .. "\n" .. var_0_4:get("如果邮箱无法接收邮件，请发邮件至cs@moefantasy.com联系客服。") .. "\n" .. var_0_4:get("成功绑定后请重启游戏确认。")
		self._have_mail_code_time = var_0_3:get_mail_send_code_time()

		if self._have_mail_code_time and self._have_mail_code_time ~= 0 then
			if self._have_mail_code_time + 60 > lx.ServerTime:getUtcTime() then
				self._control.bg_mail.need_bind_mail.phone_text.text.text = var_0_4:get("已发送绑定邮件,在") .. self._have_mail_code_time + 60 - lx.ServerTime:getUtcTime() .. var_0_4:get("秒后可以再次发送")
			else
				var_0_3:set_mail_send_code_time(lx.ServerTime:getUtcTime())
				self:__send_mail_code()
			end
		else
			var_0_3:set_mail_send_code_time(lx.ServerTime:getUtcTime())
			self:__send_mail_code()
		end
	end

	function arg_1_0:__init_slider_listenter_one()
		self._control.bg.main.input_main.phone.inputfield_1.inputField.onEndEdit:RemoveAllListeners()
		self._control.bg.main.input_main.phone.inputfield_1.inputField.onEndEdit:AddListener(function()
			self._phone_number = self._control.bg.main.input_main.phone.inputfield_1.inputField.text
		end)
	end

	function arg_1_0:__init_slider_listenter_two()
		self._control.bg.main.input_main.code.inputfield_2.inputField.onEndEdit:RemoveAllListeners()
		self._control.bg.main.input_main.code.inputfield_2.inputField.onEndEdit:AddListener(function()
			self._get_code = self._control.bg.main.input_main.code.inputfield_2.inputField.text
		end)
	end

	function arg_1_0:_set_btn_time_cd()
		self._control.bg.main.input_main.code.btn.button.interactable = false
		self._set_time_down = true
	end

	function arg_1_0._estimate_is_num(arg_15_0, arg_15_1)
		if arg_15_1 == nil then
			return false
		end

		local var_15_1 = false

		if #arg_15_1 == 0 then
			return false
		elseif #arg_15_1 > 0 then
			while 1 <= #arg_15_1 do
				local var_15_2 = string.byte(arg_15_1, 1)

				if not var_15_2 then
					break
				end

				if var_15_2 >= 48 and var_15_2 <= 57 then
					var_15_1 = true
				else
					var_15_1 = false

					return false
				end
			end
		end

		return var_15_1
	end

	function arg_1_0:__send_mail_code()
		local var_16_0 = var_0_8:create()

		self._token = var_0_10:getToken()

		var_16_0:set_url(var_0_12.bind_url.release_http_mail_bind_url)
		var_16_0:set_headers({
			Date = self:http_get_data(),
			Authorization = self:http_authorization(var_0_12.bind_uri.mail_bind_uri)
		})
		var_16_0:set_fields((var_0_6({
			appid = 0,
			token = self._token
		})))
		var_16_0:set_post()
		var_16_0:set_response_func(function(arg_17_0, arg_17_1)
			local var_17_0 = var_0_7(arg_17_1)

			if var_17_0.error == 0 then
				var_0_9:show(var_0_4:get("已发送"))
			elseif var_17_0.error ~= 0 then
				if var_17_0.errmsg ~= "" then
					var_0_9:show(var_17_0.errmsg)
				else
					var_0_9:show((var_0_13("发送失败[code:%d]", var_17_0.error)))
				end
			end
		end)
		var_16_0:set_error_func(function(arg_18_0, arg_18_1)
			return
		end)
		var_16_0:execute()
	end

	function arg_1_0.__estimate_is_mail(arg_19_0, arg_19_1)
		if string.len(arg_19_1 or "") < 6 or not arg_19_1 then
			var_0_9:show(var_0_4:get("邮箱格式过短或者不能为空"))

			return
		end

		local var_19_0, var_19_1 = string.find(arg_19_1 or "", "@")
		local var_19_2 = ""
		local var_19_3 = ""

		if var_19_0 then
			var_19_2 = string.sub(arg_19_1, 1, var_19_0 - 1)
			var_19_3 = string.sub(arg_19_1, var_19_1 + 1, -1)
		else
			var_0_9:show(var_0_4:get("邮箱格式不正确1"))

			return
		end

		local var_19_4, var_19_5 = string.find(var_19_2, "[%w_]+")

		if var_19_4 ~= 1 or var_19_5 ~= string.len(var_19_2) then
			var_0_9:show(var_0_4:get("邮箱格式不正确2"))

			return
		end

		if string.find(var_19_3, "^[%.]+") or string.find(var_19_3, "@") or string.find(var_19_3, "%.[%.]+") or string.find(var_19_3, "%s") or string.find(var_19_3, "[%.]+$") or string.find(var_19_3, "%s") or string.find(var_19_3, "[%.]+$") then
			var_0_9:show(var_0_4:get("邮箱格式不正确3"))

			return
		end

		local var_19_6, var_19_7 = string.gsub(var_19_3, "%.", "")

		if var_19_7 < 1 or var_19_7 > 3 then
			var_0_9:show(var_0_4:get("邮箱格式不正确4"))
		end

		return true
	end

	function arg_1_0:_set_time_down_func()
		if not self._set_need_code_close then
			self._control.bg.main.input_main.code.btn.text.text.text = var_0_4:get("发送验证码")
			self._set_time_down = false
			self._control.bg.main.input_main.code.btn.button.interactable = true

			return
		end

		if var_0_3:get_phone_bind_cd_time() then
			local var_20_0 = var_0_3:get_phone_bind_cd_time()

			if var_20_0 > lx.ServerTime:getUtcTime() then
				self._control.bg.main.input_main.code.btn.text.text.text = var_20_0 - lx.ServerTime:getUtcTime() .. var_0_4:get("秒")
				self._control.bg.main.input_main.code.btn.button.interactable = false
			else
				self._control.bg.main.input_main.code.btn.text.text.text = var_0_4:get("发送验证码")
				self._set_time_down = false
				self._control.bg.main.input_main.code.btn.button.interactable = true
			end
		end
	end

	function arg_1_0:__do_code_success(arg_21_1)
		local var_21_0 = var_0_8:create()

		var_21_0:set_url(var_0_12.bind_url.release_http_code_send_url)
		var_21_0:set_headers({
			Date = self:http_get_data(),
			Authorization = self:http_authorization(var_0_12.bind_uri.code_bind_uri)
		})
		var_21_0:set_fields((var_0_6({
			type = arg_21_1.type,
			appid = arg_21_1.appid,
			mobile = arg_21_1.mobile,
			areaCode = arg_21_1.areaCode
		})))
		var_21_0:set_post()
		var_21_0:set_response_func(function(arg_22_0, arg_22_1)
			local var_22_0 = var_0_7(arg_22_1)

			if var_22_0.error == 0 then
				var_0_9:show(var_0_4:get("验证码已发送"))

				self._control.bg.main.input_main.code.btn.button.interactable = false

				var_0_3:set_phone_bind_cd_time(lx.ServerTime:getUtcTime() + 60)
				self:_set_btn_time_cd()
			elseif var_22_0.errmsg == 32002 then
				var_0_9:show(var_0_4:get("验证码已发送，再次发送请等待60秒"))
			elseif var_22_0.error ~= 0 then
				if var_22_0.error == 32005 then
					var_0_9:show("手机号已绑定")
				elseif var_22_0.errmsg ~= "" then
					var_0_9:show(var_22_0.errmsg)
				else
					var_0_9:show((var_0_13("发送失败[code:%d]", var_22_0.error)))
				end
			end
		end)
		var_21_0:set_error_func(function(arg_23_0, arg_23_1)
			return
		end)
		var_21_0:execute()
	end

	function arg_1_0:__do_phone_success(arg_24_1)
		local var_24_0 = var_0_8:create()

		var_24_0:set_url(var_0_12.bind_url.release_http_phone_bind_url)
		var_24_0:set_headers({
			Date = self:http_get_data(),
			Authorization = self:http_authorization(var_0_12.bind_uri.phone_bind_uri)
		})
		var_24_0:set_fields((var_0_6({
			token = arg_24_1.token,
			appid = arg_24_1.appid,
			mobile = arg_24_1.mobile,
			captcha = arg_24_1.captcha,
			areaCode = arg_24_1.areaCode
		})))
		var_24_0:set_post()
		var_24_0:set_response_func(function(arg_25_0, arg_25_1)
			local var_25_0 = var_0_7(arg_25_1)

			if var_25_0.error == 0 then
				var_0_9:show("绑定成功")
				self:_set_bind_now()
				var_0_3:set_now_bind(true)
			elseif var_25_0.error ~= 0 then
				if var_25_0.error == 32005 then
					var_0_9:show("手机号已绑定")
				elseif var_25_0.error == 32003 then
					var_0_9:show("验证码不匹配")
				elseif var_25_0.errmsg ~= "" then
					var_0_9:show(var_25_0.errmsg)
				else
					var_0_9:show((var_0_13("发送失败[code:%d]", var_25_0.error)))
				end
			end
		end)
		var_24_0:set_error_func(function(arg_26_0, arg_26_1)
			return
		end)
		var_24_0:execute()
	end

	function arg_1_0.http_get_data(arg_27_0)
		local var_27_0 = os.time()
		local var_27_1 = os.date("%a, %d %b %Y %X", var_27_0)

		return os.date("%Y-%m-%d %X", var_27_0)
	end

	function arg_1_0:http_authorization(arg_28_1)
		return string.format("HWS %s:%s", var_0_10._config_table[self._channel].secretAccessKeyID, (encode.base64_encode((var_0_11.hmac(var_0_10._config_table[self._channel].secretAccessKey, string.format("%s\n%s\n%s", "POST", self:http_get_data(), arg_28_1), false)))))
	end

	function arg_1_0:_play_into_se(arg_29_1)
		self:playSE(arg_29_1, false)
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0.__initia_lize(arg_31_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_32_0)
	local var_32_0 = var_0_1:class("phone_binding")

	var_32_0:__initia_lize()

	return var_32_0
end

return var_0_0
