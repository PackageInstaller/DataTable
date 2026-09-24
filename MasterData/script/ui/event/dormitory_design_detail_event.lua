local var_0_0 = {}
local var_0_1 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg_close_btn()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.back))
		var_0_1:play_in_out_animation(self._bg_seq, false, function()
			self:__hide_all_furniture_to_pool()
		end)
		self:setVisible(false)
	end

	function arg_1_0:__onClick_bg_apply_btn()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.open))
		self:__click_apply_btn_event()
	end

	function arg_1_0:__onClick_bg_cancel_collect_btn()
		self:__click_cancel_collect_btn_event()
	end

	function arg_1_0:__onClick_bg_collect_btn()
		self:__click_collect_btn_event()
	end

	function arg_1_0:__onClick_bg_evaluate_btn()
		self:__click_evaluate_btn_event()
	end

	function arg_1_0:__onClick_evaluate_layer_bg_close_btn()
		self:__click_evaluate_close_btn_event()
	end

	function arg_1_0:__onClick_evaluate_layer_bg_confirm_btn()
		self:__click_evaluate_confirm_btn_event()
	end

	function arg_1_0:__onClick_evaluate_layer_bg_star_btn_1()
		self:__show_evaluate_stars(1)
	end

	function arg_1_0:__onClick_evaluate_layer_bg_star_btn_2()
		self:__show_evaluate_stars(2)
	end

	function arg_1_0:__onClick_evaluate_layer_bg_star_btn_3()
		self:__show_evaluate_stars(3)
	end

	function arg_1_0:__onClick_evaluate_layer_bg_star_btn_4()
		self:__show_evaluate_stars(4)
	end

	function arg_1_0:__onClick_evaluate_layer_bg_star_btn_5()
		self:__show_evaluate_stars(5)
	end

	function arg_1_0:__onClick_bg_tip_layer_close_btn()
		self._control.bg.tip_layer:SetActive(false)
	end

	function arg_1_0:__onClick_bg_tip_layer_confirm_btn()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.open))
		self:__click_confirm_apply_btn_event()
	end

	function arg_1_0:__onClick_bg_tip_layer_cancel_btn()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.back))
		self._control.bg.tip_layer:SetActive(false)
	end
end

function var_0_0.extend_obj(arg_18_0)
	return
end

return var_0_0
