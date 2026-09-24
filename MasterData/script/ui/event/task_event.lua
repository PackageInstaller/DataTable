local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.user

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

	function arg_1_0:__onToggle_maintop_topmenu_topbtn_btnfive()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_top_btn))
		self:__select_one("btnfive")
	end

	function arg_1_0:__onClick_maintop_topmenu_returnbtn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back_two))
		self:__init_select()
		var_0_2:play_in_out_animation(self._now_content.uITweenSequence, false, function()
			var_0_1:destroyInstance("task")
			var_0_1:createInstance("home"):show(true)
		end)
		var_0_2:play_in_out_animation(self._control.bg.uITweenSequence, false)
	end

	function arg_1_0:__onScaleButtonClick_maintop_topmenu_returnbtn()
		self:__onClick_maintop_topmenu_returnbtn()
		self:__clear_reward_view()
	end

	function arg_1_0.__clear_reward_view(arg_10_0)
		var_0_1:destroyInstance("msgbox")
	end

	function arg_1_0.__onClick_infoline_select_all_btn(arg_11_0)
		var_0_3:req_commitTaskAllReq()
	end
end

function var_0_0.extend_obj(arg_12_0)
	return
end

return var_0_0
