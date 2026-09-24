local var_0_0 = {}
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_info_framework_info_bg_close_button()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
		self:play_out_animation(function()
			gamecore.UILoader:destroyInstance("user_info")
		end)
	end

	function arg_1_0:__onScaleButtonClick_info_framework_info_bg_close_button()
		self:__onClick_info_framework_info_bg_close_button()
	end

	function arg_1_0.__onClick_info_framework_user_main_info_header_info_img(arg_5_0)
		local var_5_0 = var_0_3:createInstance("captainroom_change_head")

		if var_5_0 then
			var_5_0:show()
		end
	end
end

function var_0_0.extend_obj(arg_6_0)
	return
end

return var_0_0
