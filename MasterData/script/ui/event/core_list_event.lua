local var_0_0 = {}
local var_0_1 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_content_bg_layer_close_btn()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.back))
		var_0_1:play_in_out_animation(self._control.bg.uITweenSequence, false, function()
			self._seq:Pause()
			self:setVisible(false)
		end)
	end

	function arg_1_0:__onScaleButtonClick_content_bg_layer_close_btn()
		self:__onClick_content_bg_layer_close_btn()
	end
end

function var_0_0.extend_obj(arg_5_0)
	return
end

return var_0_0
