local var_0_0 = {}
local var_0_1 = gameenum.common_type
local var_0_2 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg_close_btn()
		self:__hide_all_furniture_to_pool(1)
		self:__hide_all_furniture_to_pool(2)
		self:__hide_all_furniture_to_pool(3)
		self:__hide_all_furniture_to_pool(4)
		self:__hide_all_furniture_to_pool(5)
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.back))
		var_0_1:play_in_out_animation(self._bg_seq, false, function()
			var_0_2:destroyInstance(self._out)
		end)
	end

	function arg_1_0:__onClick_bg_share_btn()
		self:__click_share_btn_event()
	end

	function arg_1_0:__onClick_bg_left_btn()
		self:__click_left_or_right_btn_event(-1)
	end

	function arg_1_0:__onClick_bg_right_btn()
		self:__click_left_or_right_btn_event(1)
	end

	function arg_1_0:__onClick_bg_clear_btn()
		self:__click_clear_btn_event()
	end

	function arg_1_0:__onClick_bg_save_btn()
		self:__click_save_btn_event()
	end

	function arg_1_0:__onClick_bg_use_btn()
		self:__click_use_btn_event()
	end

	function arg_1_0:__onClick_bg_share_layer_close_btn()
		self:__set_alpha(self._control.bg.share_layer, false)
	end

	function arg_1_0:__onClick_bg_share_layer_confirm_btn()
		self:__click_confirm_share_btn_event()
	end

	function arg_1_0:__onClick_bg_tip_layer_confirm_btn()
		self:__click_confirm_upload_btn_event()
	end

	function arg_1_0:__onClick_bg_tip_layer_cancel_btn()
		self:__set_alpha(self._control.bg.tip_layer, false)
	end

	function arg_1_0:__onClick_bg_tip_layer2_confirm_btn()
		self:__req_use_record(true)
	end

	function arg_1_0:__onClick_bg_tip_layer2_cancel_btn()
		self:__set_alpha(self._control.bg.tip_layer2, false)
	end
end

function var_0_0.extend_obj(arg_16_0)
	return
end

return var_0_0
