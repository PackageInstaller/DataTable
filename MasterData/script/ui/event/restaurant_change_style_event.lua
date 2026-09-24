local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.user
local var_0_3 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg_close_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
		self:__play_narrow_animation()
	end

	function arg_1_0:__onClick_bg_use_btn()
		if var_0_1:getInstance("restaurant")._now_style_id == self._my_style[self._now_selected_style].id then
			return
		end

		var_0_2:req_SetCookStyleReq(self._my_style[self._now_selected_style].id)
	end

	function arg_1_0:__onToggle_bg_scrollview_viewport_content_style_1_lv_1()
		self:toggle_event(1)
	end

	function arg_1_0:__onToggle_bg_scrollview_viewport_content_style_1_lv_2()
		self:toggle_event(2)
	end

	function arg_1_0:__onToggle_bg_scrollview_viewport_content_style_1_lv_3()
		self:toggle_event(3)
	end

	function arg_1_0:__onToggle_bg_scrollview_viewport_content_style_2_lv_1()
		self:toggle_event(4)
	end

	function arg_1_0:__onToggle_bg_scrollview_viewport_content_style_3_lv_1()
		self:toggle_event(5)
	end

	function arg_1_0:toggle_event(arg_9_1)
		if arg_9_1 == self._now_selected_style then
			return
		end

		self:set_panel_by_style(arg_9_1)
	end
end

function var_0_0.extend_obj(arg_10_0)
	return
end

return var_0_0
