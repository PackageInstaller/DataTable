local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onScaleButtonClick_content_bg_layer_close_btn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
		self:__pause_mask_move()
		var_0_2:play_in_out_animation(self._control.bg.uITweenSequence, false, function()
			self:setVisible(false)
			self:destroyChildren("single_ship_available")
			var_0_1:destroyInstance("ship_available")
		end)
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
