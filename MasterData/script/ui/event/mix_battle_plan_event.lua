local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.prompt
local var_0_3 = gamecore.Language
local var_0_4 = gamecore.user
local var_0_5 = gameenum.common_type
local var_0_6 = {
	Middle = 2,
	Large = 3,
	Little = 1
}

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_top_return()
		var_0_1:destroyInstance("mix_battle_plan")
		self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.back))

		local var_2_0 = var_0_1:getInstance("seven_sea_map")
		local var_2_1 = var_0_1:getInstance("eighth_sea_map")
		local var_2_2 = var_0_4:get_common_eighth_map_id()

		if var_2_0 then
			var_2_0:setVisible(true)
			var_2_0:__update_point_num()
		end

		if var_2_1 then
			var_2_1:show(var_2_2)
			var_2_1:setVisible(true)
			var_2_1:__update_point_num()
			var_2_1:show_cover_func(false)

			var_2_1._not_set_support_bg = true
		else
			local var_2_3 = var_0_1:createInstance("eighth_sea_map")

			var_2_3:show(var_2_2)
			var_2_3:__update_point_num()
			var_2_3:show_cover_func(false)

			var_2_3._not_set_support_bg = true
		end
	end

	function arg_1_0:__onClick_bottom_reset()
		self:__seng_reset_buff_req()
	end

	function arg_1_0:__onClick_bottom_buff_detail_buff_active()
		local var_4_0

		self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.back))

		if self._activity_num == 7 then
			var_4_0 = var_0_4:get_seventh_buff_point()
		elseif self._activity_num == 8 then
			var_4_0 = var_0_4:get_eighth_buff_point()
		end

		if var_4_0 == 0 then
			var_0_2:show(var_0_3:getNowLang("7th_buff_activation_not_point"))

			return
		end

		self:__send_buff_active_req()
	end

	function arg_1_0:__onToggle_middle_buff_entrance_root_buff_entrance_1()
		if self._cur_ship_ton_buff_index == var_0_6.Large then
			return
		end

		self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.back_two))

		self._cur_ship_ton_buff_index = var_0_6.Large

		self:__update_buff_data()
		self:__switch_toggle_image()
		self:__update_buff_item_display()
		self:__auto_select_last_buff_item()
	end

	function arg_1_0:__onToggle_middle_buff_entrance_root_buff_entrance_2()
		if self._cur_ship_ton_buff_index == var_0_6.Middle then
			return
		end

		self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.back_two))

		self._cur_ship_ton_buff_index = var_0_6.Middle

		self:__update_buff_data()
		self:__switch_toggle_image()
		self:__update_buff_item_display()
		self:__auto_select_last_buff_item()
	end

	function arg_1_0:__onToggle_middle_buff_entrance_root_buff_entrance_3()
		if self._cur_ship_ton_buff_index == var_0_6.Little then
			return
		end

		self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.back_two))

		self._cur_ship_ton_buff_index = var_0_6.Little

		self:__update_buff_data()
		self:__switch_toggle_image()
		self:__update_buff_item_display()
		self:__auto_select_last_buff_item()
	end
end

function var_0_0.extend_obj(arg_8_0)
	return
end

return var_0_0
