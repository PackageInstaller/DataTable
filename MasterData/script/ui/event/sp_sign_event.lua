local var_0_0 = {}
local var_0_1 = gameenum.common_type
local var_0_2 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_main_close()
		self:__play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.back))
		var_0_1:play_in_out_animation(self._control.mask.uITweenSequence, false, function()
			var_0_2:destroyInstance("sp_sign")
		end)
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
