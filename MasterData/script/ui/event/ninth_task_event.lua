local var_0_0 = {}
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onToggle_task_bg_middle_tab_toggle_tab_1()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_top_btn))

		if self._current_task_type == "all_task" then
			return
		end

		self:__update_cell("all_task")
		self:__set_scroll_to_top()

		self._current_task_type = "all_task"
		self._control.task_bg.middle.tab_toggle.tab_1.sbt1.text.color = Color.New(1, 1, 1, 1)
		self._control.task_bg.middle.tab_toggle.tab_2.sbt2.text.color = Color.New(1, 1, 1, 0.3333333333333333)

		self:enter_or_return_tween_for_tab(true)
	end

	function arg_1_0:__onToggle_task_bg_middle_tab_toggle_tab_2()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.task_top_btn))

		if self._current_task_type == "self_task" then
			return
		end

		self:__update_cell("self_task")
		self:__set_scroll_to_top()

		self._current_task_type = "self_task"
		self._control.task_bg.middle.tab_toggle.tab_1.sbt1.text.color = Color.New(1, 1, 1, 0.3333333333333333)
		self._control.task_bg.middle.tab_toggle.tab_2.sbt2.text.color = Color.New(1, 1, 1, 1)

		self:enter_or_return_tween_for_tab(true)
	end

	function arg_1_0:__onClick_task_bg_top_back_btn()
		self:enter_or_return_tween(false)
	end

	function arg_1_0.__onClick_task_bg_npc(arg_5_0)
		return
	end
end

function var_0_0.extend_obj(arg_6_0)
	return
end

return var_0_0
