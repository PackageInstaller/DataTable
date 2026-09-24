local var_0_0 = {}
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onToggle_maintop_topmenu_topbtn_btnone()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_top_btn))
		self:__select_one("btnone")
	end

	function arg_1_0:__onToggle_maintop_topmenu_topbtn_btntwo()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_top_btn))
		self:__select_one("btntwo")
	end

	function arg_1_0:__onToggle_maintop_topmenu_topbtn_btnthree()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_top_btn))
		self:__select_one("btnthree")
	end

	function arg_1_0:__onToggle_maintop_topmenu_topbtn_btnfour()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_top_btn))
		self:__select_one("btnfour")
	end

	function arg_1_0:__onClick_maintop_topmenu_returnbtn()
		var_0_2:play_in_out_animation(self._control.bg.uITweenSequence, false)
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
		self:setVisible(false)
	end

	function arg_1_0.__onClick_mainapplyfor_undealwith_allrefuse(arg_7_0)
		return
	end

	function arg_1_0.__onToggle_makefriends_addfriends_main_toggle(arg_8_0)
		return
	end

	function arg_1_0.__onClick_makefriends_addfriends_main_send(arg_9_0)
		return
	end

	function arg_1_0.__onClick_mainrecfriend_refresh_refreshbtn(arg_10_0)
		return
	end

	function arg_1_0.__onClick_friendinfo_main_close(arg_11_0)
		return
	end

	function arg_1_0.__onClick_friendinfo_main_delfriend(arg_12_0)
		return
	end

	function arg_1_0.__onClick_friendinfo_main_visit(arg_13_0)
		return
	end
end

function var_0_0.extend_obj(arg_14_0)
	return
end

return var_0_0
