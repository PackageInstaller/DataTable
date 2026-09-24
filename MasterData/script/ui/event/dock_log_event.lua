local var_0_0 = {}
local var_0_1 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_content_bg_layer_close_btn()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.back))
		self:__pause_mask_move()
		var_0_1:play_in_out_animation(self._control.bg.uITweenSequence, false, function()
			self:setVisible(false)
		end)
	end

	function arg_1_0.__onClick_content_up_btns_log_fav_btn(arg_4_0)
		return
	end

	function arg_1_0.__onClick_content_up_btns_log_builder_btn(arg_5_0)
		return
	end

	function arg_1_0.__onClick_content_up_btns_log_cost_btn(arg_6_0)
		return
	end

	function arg_1_0.__onClick_content_up_btns_log_get_btn(arg_7_0)
		return
	end

	function arg_1_0:__onToggle_content_fav_tog()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.task_top_btn))
	end

	function arg_1_0:__onToggle_content_toggle_group_all_tog()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.task_top_btn))
		self:__select_one("all_tog")
	end

	function arg_1_0:__onToggle_content_toggle_group_tog_1()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.task_top_btn))
		self:__select_one("tog_1")
	end

	function arg_1_0:__onToggle_content_toggle_group_tog_2()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.task_top_btn))
		self:__select_one("tog_2")
	end

	function arg_1_0:__onToggle_content_toggle_group_tog_3()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.task_top_btn))
		self:__select_one("tog_3")
	end

	function arg_1_0:__onToggle_content_toggle_group_tog_4()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.task_top_btn))
		self:__select_one("tog_4")
	end

	function arg_1_0:__onScaleButtonClick_content_bg_layer_close_btn()
		self:__onClick_content_bg_layer_close_btn()
	end
end

function var_0_0.extend_obj(arg_15_0)
	return
end

return var_0_0
