local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.util_func

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_top_return_btn()
		var_0_5.clear_all_friend_visit_panel()

		if self._enter_type == var_0_4.enter_music_type.myself then
			local var_2_1 = var_0_5.show_what_panel("home")
		elseif self._enter_type == var_0_4.enter_music_type.friend then
			var_0_5.show_what_panel("friendsmain")
		elseif self._enter_type == var_0_4.enter_music_type.cardbook then
			local var_2_2 = var_0_1:getInstance("cardbook_info")

			if var_2_2 then
				var_2_2:setVisible(true)
			else
				var_0_5.show_what_panel("cardbook")
			end
		elseif self._enter_type == var_0_4.enter_music_type.tower_ranking_list then
			local var_2_3 = var_0_1:getInstance("tower_ranking_list")

			if var_2_3 then
				var_2_3:setVisible(true)
			else
				var_0_1:createInstance("climb_tower"):back_tower_ranking_list()
			end

			return
		else
			var_0_5.return_home_with_menu_active()
		end

		var_0_5.play_home_bgm()

		local var_2_4 = var_0_1:getInstance("home")

		if var_2_4 and var_0_3:get_secretary_info().rand_secretary_flag == 1 then
			var_2_4:updata_model()
		end

		self._is_play_music = false
	end

	function arg_1_0:__onClick_music_reset_btn()
		if var_0_3:get_home_bgm() ~= 0 then
			self:__show_reset_bgm_layer(true)
			self:play_in_out_animation(true)
		else
			self:_fly_txt("ui_music_reset_failed")
		end
	end

	function arg_1_0:__onClick_reset_bgm_layer_ok_btn()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
		var_0_3:req_ResetMusicReq()
	end

	function arg_1_0:__onClick_reset_bgm_layer_cancel_btn()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.back))
		self:__show_reset_bgm_layer(false)
	end
end

function var_0_0.extend_obj(arg_6_0)
	return
end

return var_0_0
