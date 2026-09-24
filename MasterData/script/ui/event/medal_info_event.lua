local var_0_0 = {}
local var_0_3 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onClick_bg_container_btn_lv_btn_1(arg_2_0)
		return
	end

	function arg_1_0.__onClick_bg_container_btn_lv_btn_2(arg_3_0)
		return
	end

	function arg_1_0.__onClick_bg_container_btn_lv_btn_3(arg_4_0)
		return
	end

	function arg_1_0.__onClick_bg_container_btn_lv_btn_4(arg_5_0)
		return
	end

	function arg_1_0.__onClick_bg_container_btn_lv_btn_5(arg_6_0)
		return
	end

	function arg_1_0.__onClick_bg_container_btn_lv_btn_6(arg_7_0)
		return
	end

	function arg_1_0:__onClick_bg_container_close_btn()
		self:play_in_out_animation(false, function()
			self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
			self:init_medal_info()
			self:setVisible(false)
		end)
	end
end

function var_0_0.extend_obj(arg_10_0)
	return
end

return var_0_0
