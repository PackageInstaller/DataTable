local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg_close_btn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
		self:show_fleet_layer(false)
	end

	function arg_1_0:__onClick_bg_role_list_role_1()
		self:role_click_event()
	end

	function arg_1_0:__onClick_bg_role_list_role_2()
		self:role_click_event()
	end

	function arg_1_0:__onClick_bg_role_list_role_3()
		self:role_click_event()
	end

	function arg_1_0:__onClick_bg_role_list_role_4()
		self:role_click_event()
	end

	function arg_1_0:__onClick_bg_role_list_role_5()
		self:role_click_event()
	end

	function arg_1_0:__onClick_bg_role_list_role_6()
		self:role_click_event()
	end

	function arg_1_0.__onClick_bg_func_btn(arg_9_0)
		return
	end

	function arg_1_0:show_layer(arg_10_1)
		var_0_1:createInstance("captainroom"):setVisible(arg_10_1)
		self:setVisible(arg_10_1)
	end

	function arg_1_0:role_click_event()
		if var_0_1:getActiveInstance("gotofight") then
			return
		end

		self:show_layer(false)
		var_0_1:createInstance("select_member"):show_by_type(var_0_2.enter_select_member_type.captainroom_fleet, self._team_character_data_list, nil)
	end
end

function var_0_0.extend_obj(arg_12_0)
	return
end

return var_0_0
