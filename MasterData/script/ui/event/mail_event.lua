local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.UILoader
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.Language

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onScaleButtonClick_main_close()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))

		if not self._is_lock_state then
			var_0_1:set_get_all_mail_state(false)
			self._mail_seq:Pause()
			var_0_3:play_in_out_animation(self._control.show_on_tween.uITweenSequence, false, function()
				local var_3_0 = var_0_2:getInstance("home")

				if var_3_0 then
					var_3_0:update_mail_float()
				end

				self:destroy_panel()
			end)
		else
			self._is_lock_state = false

			self:set_mail_info()
		end
	end

	function arg_1_0.__onScaleButtonClick_main_sbtn_delet_all(arg_4_0)
		if var_0_1:get_receive_mail() ~= 0 then
			var_0_1:req_DeleteAllMail()
		end
	end

	function arg_1_0.__onScaleButtonClick_main_sbtn_read_all(arg_5_0)
		if var_0_1:get_not_receive_mail() ~= 0 then
			local var_5_0 = var_0_2:createInstance("msgbox")

			if var_5_0 then
				var_5_0:show(var_0_4:getNowLang("mail_receive"), function()
					var_0_1:set_get_all_mail_state(true)
					var_0_1:req_GetAllMail()
				end, nil, var_0_4:getNowLang("ensure"), nil, nil, true)
			end
		end
	end

	function arg_1_0:__onScaleButtonClick_main_lock_mail()
		if self._is_lock_state then
			self._is_lock_state = false

			self:__update_cell()
			self:set_mail_info()
		else
			self._is_lock_state = true

			self:__update_cell()
			self:set_mail_info()
		end
	end
end

function var_0_0.extend_obj(arg_8_0)
	return
end

return var_0_0
