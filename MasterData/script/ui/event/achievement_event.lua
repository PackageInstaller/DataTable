local var_0_0 = {}
local var_0_1 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onToggle_content_toggle_group_tog_detail()
		self:__select_one("tog_detail")
	end

	function arg_1_0:__onToggle_content_toggle_group_tog_record()
		self:__select_one("tog_record")
	end

	function arg_1_0:__onToggle_content_toggle_group_tog_medal()
		self:__select_one("tog_medal")
	end

	function arg_1_0:__onClick_content_close_btn()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.back))
		var_0_1:play_in_out_animation(self._control.bg.uITweenSequence, false, function()
			self:setVisible(false)
		end)
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
