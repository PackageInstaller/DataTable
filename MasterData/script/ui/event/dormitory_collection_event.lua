local var_0_0 = {}
local var_0_1 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg_close_btn()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.back))
		self:__show_head_layer(false)

		if self._callback_listener then
			self._callback_listener()
		end
	end

	function arg_1_0:__onClick_bg_award_frame()
		self:__show_award_info()
	end

	function arg_1_0:__onClick_bg_icon_tip()
		self:__show_tip_layer(false)
	end

	function arg_1_0:__onClick_bg_award_btn()
		self:__req_get_award()
	end
end

function var_0_0.extend_obj(arg_6_0)
	return
end

return var_0_0
