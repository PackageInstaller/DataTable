local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_3 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg_close_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
		self:show_style_layer(false)
	end

	function arg_1_0:__onToggle_bg_style_switch_style_0_btn()
		self:show_style_by_index(1)
	end

	function arg_1_0:__onToggle_bg_style_switch_style_1_btn()
		self:show_style_by_index(2)
	end

	function arg_1_0:__onClick_bg_use_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))

		if self._now_style_id == self._now_click_style_id then
			return
		end

		var_0_1:req_ChangeMansionStyleReq(self._now_click_style_id)
	end
end

function var_0_0.extend_obj(arg_6_0)
	return
end

return var_0_0
