local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg_visit_friend_layer_close_btn()
		self._control.bg.visit_friend_layer:SetActive(false)
	end

	function arg_1_0:__onClick_bg_visit_friend_layer_visit_btn()
		var_0_1:createInstance("show_room"):show(self._click_role_data, var_0_2.show_room_enter_type.cardbook, true)
		self._control.bg.visit_friend_layer:SetActive(false)
		self:setVisible(false)
	end

	function arg_1_0:__onScaleButtonClick_bg_top_return_btn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
		var_0_2:play_in_out_animation(self._control.bg.uITweenSequence, false, function()
			self:setVisible(false)
			var_0_1:getInstance("cardbook"):show()
		end)
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_1_btn_1(arg_6_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_1_btn_2(arg_7_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_1_btn_3(arg_8_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_1_btn_4(arg_9_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_1_btn_5(arg_10_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_2_btn_1(arg_11_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_2_btn_2(arg_12_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_2_btn_3(arg_13_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_2_btn_4(arg_14_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_3_btn_1(arg_15_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_3_btn_2(arg_16_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_3_btn_3(arg_17_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_3_btn_4(arg_18_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_3_btn_5(arg_19_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_4_btn_1(arg_20_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_4_btn_2(arg_21_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_4_btn_3(arg_22_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_4_btn_4(arg_23_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_4_btn_5(arg_24_0)
		return
	end
end

function var_0_0.extend_obj(arg_25_0)
	return
end

return var_0_0
