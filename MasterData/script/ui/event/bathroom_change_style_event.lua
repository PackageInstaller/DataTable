local var_0_0 = {}
local var_0_3 = gamecore.user
local var_0_4 = gamecore.UILoader
local var_0_5 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg_close_btn()
		self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.back))

		self._open_bathroom_rubdown._allow_mouse_move = true

		self:__show_style_layer(false)
	end

	function arg_1_0:__onToggle_bg_style_switch_style_0_btn()
		self:toggle_event(1)
	end

	function arg_1_0:__onToggle_bg_style_switch_style_1_btn()
		self:toggle_event(2)
	end

	function arg_1_0:__onToggle_bg_style_switch_style_2_btn()
		self:toggle_event(3)
	end

	function arg_1_0:__onClick_bg_use_btn()
		local var_6_0 = var_0_4:createInstance("bathroom")

		if var_6_0._now_all_style_list[var_6_0._now_room_num] == self._now_click_style_id then
			return
		end

		var_6_0._now_room_style_change = false

		local var_6_1

		if var_6_0._now_style_index ~= self._now_selected_style then
			self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.back))

			var_6_1 = {
				id = self._now_click_style_id
			}
		end

		var_6_1.room_id = var_6_0._now_room_num

		var_0_3:req_ChangeRoomStyleReq(var_6_1)

		if self._now_click_style_id == 174 then
			var_6_0:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.bathroom_one))
		elseif self._now_click_style_id == 274 then
			var_6_0:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.bathroom_two))
		elseif self._now_click_style_id == 374 then
			var_6_0:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.bathroom_three))
		end
	end

	function arg_1_0:__onClick_bg_buy_btn()
		self:__click_buy_btn_event()
	end

	function arg_1_0:toggle_event(arg_8_1)
		self._now_click_toggle_index = arg_8_1

		self:__show_style_by_index(arg_8_1)
	end
end

function var_0_0.extend_obj(arg_9_0)
	return
end

return var_0_0
