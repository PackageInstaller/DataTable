local var_0_0 = {}
local var_0_1 = gameenum.common_type
local var_0_2 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_buy_msgbox_main_quitbtn()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.back))
		self._control.buy_msgbox:SetActive(false)
	end

	function arg_1_0:__onClick_buy_msgbox_main_confirmbtn()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.open))
		self:__buy_selected_item()
	end

	function arg_1_0:__onClick_buy_msgbox_main_closebtn()
		self._control.buy_msgbox:SetActive(false)
	end

	function arg_1_0:__onClick_top_return_btn()
		self:setVisible(false)
		var_0_2:getInstance("fifth_event"):__change_btn_event(false)
	end
end

function var_0_0.extend_obj(arg_6_0)
	return
end

return var_0_0
