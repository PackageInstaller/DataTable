local var_0_1 = {}
local var_0_2 = gamecore.UILoader
local var_0_3 = gameenum.common_type

function var_0_1.extend_method(arg_1_0)
	function arg_1_0:__onScaleButtonClick_top_return_btn()
		var_0_2:destroyInstance("show_room")
		var_0_2:destroyInstance("captainroom")
		var_0_2:destroyInstance("restaurant")
		self:set_climb_tower_clickable(true)
		var_0_3:play_in_out_animation(self._control.bg.uITweenSequence, false, function()
			var_0_2:destroyInstance("tower_ranking_list")
		end)
	end

	function arg_1_0.__onClick_rank_title_rank_title_btn_1(arg_4_0)
		return
	end

	function arg_1_0.__onClick_rank_title_rank_title_btn_2(arg_5_0)
		return
	end

	function arg_1_0.__onClick_rank_title_rank_title_btn_3(arg_6_0)
		return
	end

	function arg_1_0.__onClick_rank_title_rank_title_btn_4(arg_7_0)
		return
	end

	function arg_1_0:__onClick_visit_friend_layer_close_btn()
		self:__play_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
		self._control.visit_friend_layer:SetActive(false)
	end

	function arg_1_0:__onClick_visit_friend_layer_visit_btn()
		self:__play_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))
		var_0_2:createInstance("show_room"):show(self._click_role_data, var_0_3.show_room_enter_type.tower, true)
		self._control.visit_friend_layer:SetActive(false)
		self:setVisible(false)
	end
end

function var_0_1.extend_obj(arg_10_0)
	return
end

return var_0_1
