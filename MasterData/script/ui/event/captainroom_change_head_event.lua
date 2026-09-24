local var_0_0 = {}
local var_0_1 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg_close_btn()
		self:show_head_layer(false)
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.back))
	end

	function arg_1_0:__onClick_bg_icon_tip()
		self._control.bg.icon_tip:SetActive(false)
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
