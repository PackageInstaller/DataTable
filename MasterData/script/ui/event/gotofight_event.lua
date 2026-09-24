local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.SceneManager
local var_0_3 = UnityEngine.Color(1, 1, 1, 1)
local var_0_4 = UnityEngine.Color(1, 1, 1, 0.5)
local var_0_5 = UnityEngine.Vector3(1.1, 1.1, 1.1)
local var_0_6 = UnityEngine.Vector3(1, 1, 1)
local var_0_7 = gamecore.user
local var_0_8 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onClick_start_fight_btn(arg_2_0)
		var_0_2:loadScene(var_0_8:get_battle_scene_name(), function()
			arg_2_0:__destroy_gotofight_panel()
			var_0_1:destroyInstance("gotofight")
			var_0_1:destroyStateUISet("game")
			var_0_1:createInstance(var_0_8:get_battle_name()):show()
		end)
	end

	function arg_1_0:__onToggle_top_menu_tab_toggle_tab_1()
		self:_play_into_se(var_0_8:get_audio_url(var_0_8.common_icon.music_path, var_0_8.task_top_btn))

		for iter_4_0 = 1, 5 do
			if iter_4_0 == 1 then
				self._control.top_menu.tab_toggle["tab_" .. iter_4_0]["sbt" .. iter_4_0].text.color = var_0_3 or var_0_4
			end

			if iter_4_0 == 1 then
				self._control.top_menu.tab_toggle["tab_" .. iter_4_0]["sbt" .. iter_4_0].transform.localScale = var_0_5 or var_0_6
			end
		end

		self._current_toggle_index = 1
		self._current_far_toggle_index = 1

		self:__select_top_toggle("gotofight", true)
	end

	function arg_1_0:__onToggle_top_menu_tab_toggle_tab_2()
		self:_play_into_se(var_0_8:get_audio_url(var_0_8.common_icon.music_path, var_0_8.task_top_btn))

		for iter_5_0 = 1, 5 do
			if iter_5_0 == 2 then
				self._control.top_menu.tab_toggle["tab_" .. iter_5_0]["sbt" .. iter_5_0].text.color = var_0_3 or var_0_4
			end

			if iter_5_0 == 2 then
				self._control.top_menu.tab_toggle["tab_" .. iter_5_0]["sbt" .. iter_5_0].transform.localScale = var_0_5 or var_0_6
			end
		end

		self._current_toggle_index = 2
		self._current_far_toggle_index = 1

		self:__select_top_toggle("exercise")
		self._control.top_menu.tab_toggle.red_image_tips_root.tab_1_tips.trophy_remain:SetActive(false)

		if self._map_scroll_view_control then
			self._map_scroll_view_control.lattice_scroll_view.latticeScrollRect.horizontal = true
		end
	end

	function arg_1_0:__onToggle_top_menu_tab_toggle_tab_3()
		self:_play_into_se(var_0_8:get_audio_url(var_0_8.common_icon.music_path, var_0_8.task_top_btn))

		for iter_6_0 = 1, 5 do
			if iter_6_0 == 3 then
				self._control.top_menu.tab_toggle["tab_" .. iter_6_0]["sbt" .. iter_6_0].text.color = var_0_3 or var_0_4
			end

			if iter_6_0 == 3 then
				self._control.top_menu.tab_toggle["tab_" .. iter_6_0]["sbt" .. iter_6_0].transform.localScale = var_0_5 or var_0_6
			end
		end

		self._current_toggle_index = 3

		self:__select_top_toggle("farfight")
		self._control.top_menu.tab_toggle.red_image_tips_root.tab_1_tips.trophy_remain:SetActive(false)

		if self._map_scroll_view_control then
			self._map_scroll_view_control.lattice_scroll_view.latticeScrollRect.horizontal = true
		end
	end

	function arg_1_0:__onToggle_top_menu_tab_toggle_tab_4()
		self:_play_into_se(var_0_8:get_audio_url(var_0_8.common_icon.music_path, var_0_8.task_top_btn))

		for iter_7_0 = 1, 5 do
			if iter_7_0 == 4 then
				self._control.top_menu.tab_toggle["tab_" .. iter_7_0]["sbt" .. iter_7_0].text.color = var_0_3 or var_0_4
			end

			if iter_7_0 == 4 then
				self._control.top_menu.tab_toggle["tab_" .. iter_7_0]["sbt" .. iter_7_0].transform.localScale = var_0_5 or var_0_6
			end
		end

		self._current_toggle_index = 4
		self._current_far_toggle_index = 1

		self:__select_top_toggle("campaign")
		self._control.top_menu.tab_toggle.red_image_tips_root.tab_1_tips.trophy_remain:SetActive(false)

		if self._map_scroll_view_control then
			self._map_scroll_view_control.lattice_scroll_view.latticeScrollRect.horizontal = true
		end
	end

	function arg_1_0:__onToggle_top_menu_tab_toggle_tab_5()
		self:_play_into_se(var_0_8:get_audio_url(var_0_8.common_icon.music_path, var_0_8.task_top_btn))

		for iter_8_0 = 1, 5 do
			if iter_8_0 == 5 then
				self._control.top_menu.tab_toggle["tab_" .. iter_8_0]["sbt" .. iter_8_0].text.color = var_0_3 or var_0_4
			end

			if iter_8_0 == 5 then
				self._control.top_menu.tab_toggle["tab_" .. iter_8_0]["sbt" .. iter_8_0].transform.localScale = var_0_5 or var_0_6
			end
		end

		self._current_toggle_index = 5
		self._current_far_toggle_index = 1

		self:__select_top_toggle("active_panel")
		self._control.top_menu.tab_toggle.red_image_tips_root.tab_1_tips.trophy_remain:SetActive(false)

		if self._map_scroll_view_control then
			self._map_scroll_view_control.lattice_scroll_view.latticeScrollRect.horizontal = true
		end
	end

	function arg_1_0:__onScaleButtonClick_top_menu_return_btn()
		var_0_7:set_to_normal_fight(false)
		self:_play_into_se(var_0_8:get_audio_url(var_0_8.common_icon.music_path, var_0_8.back))
		self:__destroy_panel()

		if var_0_1:getInstance("fight_prepare") then
			var_0_1:destroyInstance("fight_prepare")
		end

		if var_0_1:getInstance("select_member") then
			var_0_1:destroyInstance("select_member")
		end

		local var_9_0 = var_0_1:createInstance("home")

		if not var_9_0 then
			return
		end

		var_9_0:into_home_bgm()
	end

	function arg_1_0.__onClick_small_map_information_closebtn(arg_10_0)
		return
	end
end

function var_0_0.extend_obj(arg_11_0)
	return
end

return var_0_0
