local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameconfig
local var_0_5 = gameenum.common_type
local var_0_6 = string.format
local var_0_7 = lx.json_decode
local var_0_8 = UnityEngine
local var_0_9 = UnityEngine.Vector2
local var_0_10 = UnityEngine.Vector3
local var_0_11 = gameconfig.support_atk_config
local var_0_12 = UnityEngine.Color(1, 1, 1, 1)
local var_0_13 = UnityEngine.Color(1, 1, 1, 0.5)
local var_0_14 = UnityEngine.Color(1, 1, 1, 0.2)
local var_0_15 = UnityEngine.Vector3(1.1, 1.1, 1.1)
local var_0_16 = UnityEngine.Vector3(1, 1, 1)
local var_0_17 = gameconfig.expedition_config
local var_0_18 = table.insert
local var_0_19 = gameconfig.map_config
local var_0_20 = gameconfig.map_node_config
local var_0_21 = DG.Tweening.DOTween
local var_0_22 = string.sub
local var_0_23 = gamecore.util_func
local var_0_24 = gameconfig.ship_pve_buff_config
local var_0_25 = gameconfig.ship_rule_config
local var_0_26 = gameconfig.ship_pve_active_config
local var_0_27 = gamecore.AuditServerManager
local var_0_28 = lx.UserData
local var_0_29 = {
	campaign = "campaign",
	gotofight = "gotofight",
	active_panel = "active_panel",
	exercise = "exercise",
	farfight = "farfight"
}
local var_0_30 = {
	"gotofight",
	"exercise",
	"farfight",
	"campaign",
	"active_panel"
}

gamecore.UILoader:define("gotofight", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = var_0_2:getInstance("gotofight")

		if var_2_0 then
			var_2_0:setVisible(true)
		end

		var_0_3:set_to_normal_fight(true)
		self:__init_panel(arg_2_1, arg_2_2)

		if arg_2_3 then
			arg_2_3()
		end
	end

	function arg_1_0:__onUpdate()
		if self._farfight then
			self._farfight:update()
		end

		if self._active_info then
			self._active_info:update_cell()
		end

		if not self._time_execute_task_list then
			return
		end

		for iter_3_0, iter_3_1 in ipairs(self._time_execute_task_list) do
			if iter_3_1.execute_time > 0 then
				iter_3_1.execute_time = iter_3_1.execute_time - Time.deltaTime

				if iter_3_1.execute_time <= 0 and iter_3_1.execute_func then
					if iter_3_0 == #self._time_execute_task_list then
						self._time_execute_task_list = nil
					end

					iter_3_1.execute_func()
				end
			end
		end
	end

	function arg_1_0:get_guide_btn_pos_info(arg_4_1)
		if arg_4_1 == var_0_5.guide_const_id.first_group.two or arg_4_1 == var_0_5.guide_const_id.nine_group.one then
			if not self._is_init_gotofight_panel then
				self:__init_panel_canvas_groups()
				self:__init_gotofight_panel()
			end

			return self._map_scroll_view_control.lattice_scroll_view.transform
		end
	end

	function arg_1_0.string_to_tm(arg_5_0, arg_5_1)
		local var_5_0, var_5_1, var_5_2 = var_0_22(arg_5_1, 9, 10)

		return (os.date("*t", os.time({
			year = tonumber((var_0_22(arg_5_1, 1, 4))),
			month = tonumber((var_0_22(arg_5_1, 5, 6))),
			day = tonumber((var_0_22(arg_5_1, 7, 8))),
			hour = tonumber(var_5_0),
			min = tonumber(var_5_1),
			sec = tonumber(var_5_2)
		})))
	end

	function arg_1_0:string_to_utc_time(arg_6_1)
		if not arg_6_1 then
			return 0
		end

		return os.time(self:string_to_tm(arg_6_1))
	end

	function arg_1_0:support_up_level()
		local var_7_0 = var_0_3:get_supportInfo_data(self:__get_map_data()[self._init_chapter_index][self._init_map_index].id)

		self._mapItemControlList[self._init_map_index].bg_mask.bg.map_support.icon_bg.image.sprite = self:loadSprite(not not var_7_0 and var_0_5.pve_support_bg["pve_support_lv_" .. var_7_0.level] or var_0_5.pve_support_bg.pve_support_lv_0)
	end

	function arg_1_0:__init_panel(arg_8_1, arg_8_2)
		self:__init_panel_canvas_groups()
		self:__play_top_menu_in_animation()

		local var_8_0 = arg_8_1.toggle_index

		self._is_open_init = arg_8_1.is_open_init
		self._difficulty = arg_8_1.difficulty

		if self and self._control then
			self._control.top_menu.tab_toggle.red_image_tips_root.tab_3_tips.red_image:SetActive(false)
		end

		if not var_8_0 then
			local var_8_1, var_8_2 = var_0_17.get_sequence()

			for iter_8_0, iter_8_1 in ipairs(var_8_1) do
				local var_8_3, var_8_4 = var_0_3:check_expedition_state(iter_8_1.id)

				if var_8_3 == var_0_5.expedition_state.done then
					var_8_0 = 3

					if self._control then
						self._control.top_menu.tab_toggle.red_image_tips_root.tab_3_tips.red_image:SetActive(true)
					end

					break
				end
			end
		end

		self._ui_current_top_toggle_tag_name = nil

		local var_8_5, var_8_6 = self:__reset_go_to_which_map(arg_8_1)

		if self and self._control then
			self._control.start_fight_btn.startfight.text.text = var_0_1:getNowLang("ui_combat_fight")
			self._control.top_menu.tab_toggle.tab_1.sbt1.text.text = var_0_1:getNowLang("pbt1")
			self._control.top_menu.tab_toggle.tab_2.sbt2.text.text = var_0_1:getNowLang("pbt2")
			self._control.top_menu.tab_toggle.tab_3.sbt3.text.text = var_0_1:getNowLang("pbt3")
			self._control.top_menu.tab_toggle.tab_4.sbt4.text.text = var_0_1:getNowLang("pbt4")
			self._control.top_menu.tab_toggle.tab_5.sbt5.text.text = var_0_1:getNowLang("special_activity")
		end

		self._from_home = not var_8_0
		self._current_toggle_index = var_8_0 or 1
		self._current_far_toggle_index = self._current_far_toggle_index or 1

		for iter_8_2 = 1, 5 do
			if self and self._control then
				if iter_8_2 == self._current_toggle_index then
					self._control.top_menu.tab_toggle["tab_" .. iter_8_2]["sbt" .. iter_8_2].text.color = var_0_12 or var_0_13
				end

				if iter_8_2 == self._current_toggle_index then
					self._control.top_menu.tab_toggle["tab_" .. iter_8_2]["sbt" .. iter_8_2].transform.localScale = var_0_15 or var_0_16
				end
			end
		end

		if self and self._control then
			self._control.top_menu.tab_toggle[var_0_6("tab_%d", self._current_toggle_index)].toggle.isOn = true
		end

		self:__select_top_toggle(var_0_29[var_0_30[self._current_toggle_index]], nil, self._from_home)

		local var_8_8 = lx.ServerTime:getUtcTime()
		local var_8_9 = var_0_25.find_object_by_id(var_0_5.gotofight_active.fight_active).content
		local var_8_10 = self:string_to_utc_time(var_8_9.startTime)
		local var_8_11 = self:string_to_utc_time(var_8_9.endTime)

		if self and self._control then
			self._control.top_menu.tab_toggle.red_image_tips_root.tab_3_tips.red_image_2:SetActive(not not (var_8_10 and var_8_11 and var_8_10 <= var_8_8 and var_8_8 < var_8_11))

			self._control.top_menu.tab_toggle.red_image_tips_root.tab_3_tips.red_image_2.tips_txt.text.text = var_0_1:getNowLang("bigsuccess2")
		end

		local var_8_12 = var_0_25.find_object_by_id(var_0_5.gotofight_active.expedition_active).content
		local var_8_13 = self:string_to_utc_time(var_8_12.startTime)
		local var_8_14 = self:string_to_utc_time(var_8_12.endTime)

		if self and self._control then
			self._control.top_menu.tab_toggle.red_image_tips_root.tab_1_tips.red_image_2:SetActive(not not (var_8_13 and var_8_14 and var_8_13 <= var_8_8 and var_8_8 < var_8_14))

			self._control.top_menu.tab_toggle.red_image_tips_root.tab_1_tips.red_image_2.tips_txt.text.text = string.format("%s+50%s", var_0_1:getNowLang("resource6"), "%")
		end

		for iter_8_3, iter_8_4 in pairs((var_0_26.get_sequence())) do
			if self:get_acticity_time(iter_8_4) then
				local var_8_15 = var_0_25.find_object_by_id(11)
				local var_8_16 = lx.ServerTime:getUtcTime()

				if iter_8_4.id == var_0_5.pve_active_list.bootyshop and not (var_8_15.content.startTime <= var_8_16 and var_8_16 <= var_8_15.content.endTime) then
					self._control.top_menu.tab_toggle.red_image_tips_root.tab_1_tips.red_image_2:SetActive(true)

					self._control.top_menu.tab_toggle.red_image_tips_root.tab_1_tips.red_image_2.image.sprite = self:loadSprite(var_0_5.spoils_red_image)

					self._control.top_menu.tab_toggle.red_image_tips_root.tab_1_tips.red_image_2:GetComponent("Image"):SetNativeSize()
					self._control.top_menu.tab_toggle.red_image_tips_root.tab_1_tips.red_image_2.tips_txt:SetActive(false)
					self._control.top_menu.tab_toggle.red_image_tips_root.tab_1_tips.red_image_2.transform:SetAsLastSibling()
				end
			end
		end

		local var_8_17 = var_0_25.find_object_by_id(11)
		local var_8_18 = var_8_17.content.endTime
		local var_8_19 = lx.ServerTime:getUtcTime()

		if (var_8_17.content.startTime <= var_8_19 and var_8_19 <= var_8_18) == true then
			self._control.top_menu.tab_toggle.red_image_tips_root.tab_1_tips.red_image_2:SetActive(true)

			self._control.top_menu.tab_toggle.red_image_tips_root.tab_1_tips.red_image_2.tips_txt.text.text = "Exp" .. "+" .. "100%"

			local var_8_20, var_8_21 = var_0_17.get_sequence()
			local var_8_22

			for iter_8_5, iter_8_6 in ipairs(var_8_20) do
				local var_8_24

				var_8_22, var_8_24 = var_0_3:check_expedition_state(iter_8_6.id)

				if var_8_22 == var_0_5.expedition_state.done then
					self._control.top_menu.tab_toggle.red_image_tips_root.tab_3_tips.red_image:SetActive(true)

					break
				end
			end

			if var_8_22 ~= var_0_5.expedition_state.done then
				self._control.top_menu.tab_toggle.red_image_tips_root.tab_3_tips.red_image_2:SetActive(true)

				self._control.top_menu.tab_toggle.red_image_tips_root.tab_3_tips.red_image_2.tips_txt.text.text = var_0_1:getNowLang("bigsuccess2")
			end
		end

		self._now_lock_id = var_8_5

		if not arg_8_2 then
			self:_play_fight_bgm(var_8_5)
		end

		self:__update_red_dot()
	end

	function arg_1_0:_play_fight_bgm(arg_9_1)
		if not arg_9_1 then
			self:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.fignt_one))
		end

		if tonumber(arg_9_1) >= 1 and tonumber(arg_9_1) <= 4 then
			self:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.fignt_one))
		elseif tonumber(arg_9_1) >= 5 and tonumber(arg_9_1) <= 6 then
			self:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.fignt_two))
		else
			self:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.fignt_three))
		end
	end

	function arg_1_0:__reset_go_to_which_map(arg_10_1)
		local var_10_0 = var_0_3:get_last_map_node()
		local var_10_2 = var_0_3:get_guide_state()
		local var_10_3
		local var_10_4

		if arg_10_1 and arg_10_1.init_chapter_index and arg_10_1.init_map_index then
			self._init_chapter_index = arg_10_1.init_chapter_index
			self._init_map_index = arg_10_1.init_map_index
		end

		if self._init_chapter_index and self._init_map_index then
			var_10_4 = self._init_map_index
			var_10_3 = self._init_chapter_index
		elseif not var_10_0 and not var_10_2 then
			local var_10_7 = var_0_3:get_main_line_max_chapter()

			var_10_3 = math.modf(var_10_7 / 100)
			var_10_4 = var_10_7 - var_10_3 * 100
			self._init_chapter_index = var_10_3
			self._init_map_index = var_10_4
		elseif var_10_0 and not var_10_2 then
			var_10_4 = var_10_0.small_mapindex
			var_10_3 = var_10_0.chapter_index
			self._init_chapter_index = var_10_0.chapter_index
			self._init_map_index = var_10_0.small_mapindex
		else
			var_10_3, var_10_4 = self:__select_chapter()
			self._init_chapter_index = var_10_3
			self._init_map_index = var_10_4

			if self._init_chapter_index == 2 and self._init_map_index > 4 then
				self._init_chapter_index = 3
				self._init_map_index = 1
			end
		end

		return var_10_3, var_10_4
	end

	function arg_1_0:__update_red_dot()
		local var_11_0, var_11_1 = var_0_17.get_sequence()
		local var_11_2 = false

		for iter_11_0, iter_11_1 in ipairs(var_11_0) do
			local var_11_3, var_11_4 = var_0_3:check_expedition_state(iter_11_1.id)

			if var_11_3 == var_0_5.expedition_state.done then
				var_11_2 = true

				break
			end
		end

		self._control.top_menu.tab_toggle.red_image_tips_root.tab_3_tips.red_image:SetActive(var_11_2)
	end

	function arg_1_0.set_current_far_toggle_index(arg_12_0, arg_12_1)
		arg_12_0._current_far_toggle_index = arg_12_1
	end

	function arg_1_0.__select_chapter(arg_13_0, arg_13_1, arg_13_2)
		local var_13_2
		local var_13_1
		local var_13_0

		if arg_13_1 then
			do return arg_13_1, arg_13_2 end

			var_13_0 = {}
		end

		for iter_13_0, iter_13_1 in ipairs((var_0_19.get_sequence())) do
			if iter_13_1.pve_id ~= 95 and iter_13_1.pve_id ~= 99 then
				var_0_18(var_13_0, iter_13_1.id)
			end
		end

		for iter_13_2, iter_13_3 in ipairs(var_13_0) do
			if not var_0_3:is_map_pass(iter_13_3) then
				local var_13_3 = var_0_19.find_object_by_id(iter_13_3)

				var_13_1 = var_13_3.pve_id
				var_13_2 = tonumber(var_0_22(var_13_3.map_id, 3, 3))

				break
			end
		end

		if not var_13_1 then
			local var_13_4 = var_0_19.find_object_by_id(var_13_0[#var_13_0])

			var_13_1 = var_13_4.pve_id
			var_13_2 = tonumber(var_0_22(var_13_4.map_id, 3, 3))
		end

		return var_13_1, var_13_2
	end

	function arg_1_0:__destroy_panel()
		self:__play_out_animation()
		self:__play_top_menu_out_animation()
	end

	function arg_1_0:__real_destroy_panel()
		self._control.top_menu.top_menu_mask.image.raycastTarget = false

		var_0_2:destroyInstance("gotofight")
		var_0_2:createInstance("home"):show()
	end

	function arg_1_0:__select_top_toggle(arg_16_1, arg_16_2, arg_16_3)
		if arg_16_1 == self._ui_current_top_toggle_tag_name then
			return
		end

		self:__init_panel_canvas_groups()
		self:__clear_tweener()

		local function var_16_0()
			self:__hide_all_panel()

			if self._ui_current_top_toggle_tag_name == var_0_29.gotofight then
				if arg_16_2 then
					self._is_open_init = true
				end

				self._control.small_map_information_closebtn:SetActive(false)
				self._control.small_map_information_closebtn.button.onClick:RemoveAllListeners()
				self:__init_gotofight_panel()
				self:__play_gotofight_panel_in_animation(arg_16_3)
			elseif self._ui_current_top_toggle_tag_name == var_0_29.exercise then
				self._control.small_map_information_closebtn.button.onClick:RemoveAllListeners()
				self._control.small_map_information_closebtn:SetActive(false)
				self:__init_exercise_panel()
				self:__play_exercise_panel_in_animation()

				self._is_init_gotofight_panel = false
			elseif self._ui_current_top_toggle_tag_name == var_0_29.farfight then
				self._control.small_map_information_closebtn.button.onClick:RemoveAllListeners()
				self._control.small_map_information_closebtn:SetActive(false)
				self:__init_farfight_panel()
				self:__play_farfight_panel_in_animation(arg_16_3)

				self._is_init_gotofight_panel = false
			elseif self._ui_current_top_toggle_tag_name == var_0_29.campaign then
				self._control.small_map_information_closebtn.button.onClick:RemoveAllListeners()
				self._control.small_map_information_closebtn:SetActive(false)
				self:__init_campaign_panel()
				self:__play_campaign_panel_in_animation()

				self._is_init_gotofight_panel = false
			elseif self._ui_current_top_toggle_tag_name == var_0_29.active_panel then
				self._control.small_map_information_closebtn.button.onClick:RemoveAllListeners()
				self._control.small_map_information_closebtn:SetActive(false)

				if not var_0_27:isAuditVersion() then
					self:__init_active_panel()
				end

				self:__play_active_panel_in_animation()

				self._is_init_gotofight_panel = false
			end
		end

		if not self._ui_current_top_toggle_tag_name then
			self._ui_current_top_toggle_tag_name = arg_16_1

			var_16_0()

			return
		end

		self:__play_out_animation(var_16_0, arg_16_1)
	end

	function arg_1_0.__clear_current_chapter_info(arg_18_0)
		arg_18_0._init_chapter_index = nil
		arg_18_0._init_map_index = nil
	end

	function arg_1_0:__hide_all_panel()
		self:__init_panel_canvas_groups()
		self:__hide_gotofight_panel()
		self:__hide_exercise_panel()
		self:__hide_farfight_panel()
		self:__hide_campaign_panel()
		self:__hide_active_info_panel()
	end

	function arg_1_0:__init_panel_canvas_groups()
		if self._canvas_groups then
			return
		end

		self._canvas_groups = {
			gotofight = {},
			exercise = {},
			farfight = {},
			campaign = {},
			active_info = {}
		}
	end

	function arg_1_0:__play_out_animation(arg_21_1, arg_21_2)
		if self._ui_current_top_toggle_tag_name == var_0_29.gotofight then
			self._ui_current_top_toggle_tag_name = arg_21_2

			self:__play_gotofight_panel_out_animation(arg_21_1)
		elseif self._ui_current_top_toggle_tag_name == var_0_29.exercise then
			self._ui_current_top_toggle_tag_name = arg_21_2

			self:__play_exercise_panel_out_animation(arg_21_1)
		elseif self._ui_current_top_toggle_tag_name == var_0_29.farfight then
			self._ui_current_top_toggle_tag_name = arg_21_2

			self:__play_farfight_panel_out_animation(arg_21_1)
		elseif self._ui_current_top_toggle_tag_name == var_0_29.campaign then
			self._ui_current_top_toggle_tag_name = arg_21_2

			self:__play_campaign_panel_out_animation(arg_21_1)
		elseif self._ui_current_top_toggle_tag_name == var_0_29.active_panel then
			self._ui_current_top_toggle_tag_name = arg_21_2

			self:__play_active_panel_out_animation(arg_21_1)
		end
	end

	function arg_1_0:__clear_tweener()
		if self._in_out_tweener1 then
			self._in_out_tweener1.onComplete = nil

			self._in_out_tweener1:Kill()
		end

		if self._in_out_tweener2 then
			self._in_out_tweener2.onComplete = nil

			self._in_out_tweener2:Kill()
		end

		if self._ui_current_top_toggle_tag_name == var_0_29.campaign and self._campaign then
			self._campaign:__clear_tweener()
		end
	end

	function arg_1_0.__get_table_length(arg_23_0, arg_23_1)
		if not arg_23_1 or arg_23_1 == {} then
			return 0
		end

		return #arg_23_1
	end

	function arg_1_0:__create_map_scroll_item_to_num(arg_24_1)
		if not self._mapItemControlList then
			self._mapItemControlList = {}
			self._mapItemObjList = {}
		end

		local var_24_0 = arg_24_1 - self:__get_table_length(self._mapItemControlList)

		if var_24_0 <= 0 then
			return
		end

		for iter_24_0 = 1, var_24_0 do
			local var_24_1, var_24_2 = self:loadUIPrefab("map_scroll_item", self._map_scroll_view_control.lattice_scroll_view.viewport.content.transform)

			var_24_1:setVisible(true)

			var_24_2.bg_mask.bg.map_pass_tag.tag_text.text.text = var_0_1:getNowLang("ui_pvepassed")

			table.insert(self._mapItemControlList, var_24_2)
			table.insert(self._mapItemObjList, var_24_1)
		end
	end

	function arg_1_0:__init_gotofight_panel()
		self._is_init_gotofight_panel = true

		self._control.buttom_line.info_text:SetActive(false)

		if not self._allChapterTb or not self._allNodeTb then
			self._allChapterTb, self._mapSequenceTb = self:__get_map_data()
			self._allNodeTb, self._nodeSequenceTb = self:__get_node_data()
		end

		if not self._map_scroll_view_control then
			local var_25_0, var_25_1 = self:loadUIPrefab("map_scroll_view", self._control.background.transform.parent)

			var_25_0:setVisible(true)

			self._map_scroll_view_control = var_25_1
			self._canvas_groups.gotofight = var_0_23.add_canvas_group_component_to_panel(var_25_0)
		end

		self._canvas_groups.gotofight.alpha = 1
		self._canvas_groups.gotofight.blocksRaycasts = true

		local var_25_2 = self:__get_max_mapnum_per_chapter(self._allChapterTb)

		self:__create_map_scroll_item_to_num(var_25_2)

		for iter_25_0 = 1, var_25_2 do
			if iter_25_0 == 1 then
				self._map_scroll_view_control.lattice_scroll_view.latticeScrollRect:InitItemWidth(self._mapItemObjList[iter_25_0]._panel)
			end
		end

		local var_25_3 = var_0_1:getNowLang("ui_activityworldpasstip")

		if not self._has_loaded_pool then
			self:__preload_map_fragment()
		end

		local var_25_4 = self._allChapterTb[self._init_chapter_index]

		if not self._allChapterTb[self._init_chapter_index] or not next(var_25_4) then
			return
		end

		for iter_25_1 = 1, #var_25_4 do
			self:__update_boss_hp(var_25_4[iter_25_1], var_25_4[iter_25_1].need_pve_level_id, self._mapItemControlList[iter_25_1])
			self:__set_map_lock_info(var_25_4[iter_25_1], self._mapItemControlList[iter_25_1])
		end

		self:__set_map_data_by_chapter(self._init_chapter_index, self._allChapterTb, self._mapSequenceTb, self._map_scroll_view_control, self._mapItemControlList, var_25_3, self._allNodeTb)

		self._chapter_scroll_view_control = self:__load_chapter_scroll_view(function(arg_26_0)
			self._map_scroll_view_control.lattice_scroll_view.latticeScrollRect.horizontal = true
			self._map_scroll_view_control.lattice_scroll_view.next_page_btn.image.raycastTarget = true
			self._map_scroll_view_control.lattice_scroll_view.last_page_btn.image.raycastTarget = true

			self._control.small_map_information_closebtn:SetActive(true)

			for iter_26_0 = 1, #self._allChapterTb[arg_26_0] do
				self:__set_map_lock_info(self._allChapterTb[arg_26_0][iter_26_0], self._mapItemControlList[iter_26_0])
			end

			self:__set_map_data_by_chapter(arg_26_0, self._allChapterTb, self._mapSequenceTb, self._map_scroll_view_control, self._mapItemControlList, var_25_3, self._allNodeTb)
		end)
	end

	function arg_1_0.__update_boss_hp(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
		if arg_27_1.hp > 0 and (arg_27_2 == 0 or var_0_3:is_map_pass(arg_27_2)) then
			local var_27_0 = var_0_3:get_map_list()[arg_27_1.id]

			if var_27_0 then
				local var_27_1 = var_27_0.hp / arg_27_1.hp or 1

				if var_27_1 > 0 then
					arg_27_3.bg_mask.bg.boss_slider.image.fillAmount = var_27_1
					arg_27_3.bg_mask.bg.boss_hp.text.text = var_0_6("%0.2f%s", var_27_1 * 100, "%")

					arg_27_3.bg_mask.bg.boss_hp:SetActive(true)
					arg_27_3.bg_mask.bg.boss_slider:SetActive(true)
					arg_27_3.bg_mask.bg.boss_slider_bg:SetActive(true)
					arg_27_3.bg_mask.bg.boss_title:SetActive(true)

					goto label_27_0
				end
			end

			arg_27_3.bg_mask.bg.boss_slider:SetActive(false)
			arg_27_3.bg_mask.bg.boss_title:SetActive(false)
			arg_27_3.bg_mask.bg.boss_slider_bg:SetActive(false)
			arg_27_3.bg_mask.bg.boss_hp:SetActive(false)
		else
			arg_27_3.bg_mask.bg.boss_slider:SetActive(false)
			arg_27_3.bg_mask.bg.boss_title:SetActive(false)
			arg_27_3.bg_mask.bg.boss_slider_bg:SetActive(false)
			arg_27_3.bg_mask.bg.boss_hp:SetActive(false)
		end

		::label_27_0::
	end

	function arg_1_0.__set_map_lock_info(arg_28_0, arg_28_1, arg_28_2)
		local var_28_0 = lx.ServerTime:getUtcTime()
		local var_28_1 = var_0_26.find_object_by_id(23)

		arg_28_2.bg_mask.bg.info_bg:SetActive(false)
		arg_28_2.back_image_button:SetActive(false)
		arg_28_2.bg_mask.bg.lock_bg:SetActive(false)

		if next(arg_28_1.replace_conditions) then
			if arg_28_1.temporary_pve_debuff == 1 then
				arg_28_2.bg_mask.bg.lock_bg:SetActive(true)
			elseif arg_28_1.temporary_pve_debuff == 0 then
				if var_28_1.start_time < var_28_0 and var_28_0 < var_28_1.end_time then
					arg_28_2.bg_mask.bg.lock_bg:SetActive(true)
				else
					arg_28_2.bg_mask.bg.lock_bg:SetActive(false)
				end
			end

			arg_28_2.bg_mask.bg.lock_bg.lock_icon.button.onClick:RemoveAllListeners()
			arg_28_2.bg_mask.bg.lock_bg.lock_icon.button.onClick:AddListener(function()
				arg_28_0:__check_save_pve_condition(arg_28_1)
				arg_28_0:__show_buff_info(arg_28_2, (var_0_3:get_pve_condition() == var_0_5.map_pve_lock_condition.weak or nil) and (arg_28_1.pve_debuff_weak or arg_28_1.pve_debuff))
				arg_28_0:__on_onclick_lg_lock()
			end)

			if not arg_28_2.back_image_button:Equals(nil) then
				arg_28_2.back_image_button.button.onClick:RemoveAllListeners()
				arg_28_2.back_image_button.button.onClick:AddListener(function()
					arg_28_2.back_image_button:SetActive(false)
					arg_28_2.bg_mask.bg.info_bg:SetActive(false)

					arg_28_0._map_scroll_view_control.lattice_scroll_view.latticeScrollRect.horizontal = true
				end)
			end
		else
			arg_28_2.bg_mask.bg.lock_bg:SetActive(false)
		end
	end

	function arg_1_0:__on_onclick_lg_lock()
		for iter_31_0, iter_31_1 in pairs(self._mapItemControlList) do
			if iter_31_1.bg_mask.bg.info_bg.activeSelf then
				self._control.small_map_information_closebtn:SetActive(true)

				self._map_scroll_view_control.lattice_scroll_view.latticeScrollRect.horizontal = false
				self._map_scroll_view_control.lattice_scroll_view.next_page_btn.image.raycastTarget = false
				self._map_scroll_view_control.lattice_scroll_view.last_page_btn.image.raycastTarget = false

				self._control.small_map_information_closebtn.button.onClick:RemoveAllListeners()
				self._control.small_map_information_closebtn.button.onClick:AddListener(function()
					self._map_scroll_view_control.lattice_scroll_view.latticeScrollRect.horizontal = true
					self._map_scroll_view_control.lattice_scroll_view.next_page_btn.image.raycastTarget = true
					self._map_scroll_view_control.lattice_scroll_view.last_page_btn.image.raycastTarget = true

					iter_31_1.back_image_button:SetActive(false)
					iter_31_1.bg_mask.bg.info_bg:SetActive(false)
				end)
			end
		end
	end

	function arg_1_0.__check_save_pve_condition(arg_33_0, arg_33_1)
		local var_33_0 = true
		local var_33_1 = true
		local var_33_2 = var_0_3:get_map_list()[arg_33_1.id]
		local var_33_3 = {}
		local var_33_4 = {}

		if not var_33_2 then
			if arg_33_1.id >= var_0_5.normal_map_id.end_map then
				var_33_0 = false

				var_0_28:setKeyData("map_is_lock", (var_33_0 or nil) and (var_0_5.map_pve_lock_condition.weak or var_0_5.map_pve_lock_condition.full))
				var_0_3:set_pve_condition((var_33_0 or nil) and (var_0_5.map_pve_lock_condition.weak or var_0_5.map_pve_lock_condition.full))
			end

			return
		end

		for iter_33_0, iter_33_1 in pairs((arg_33_1.temporary_pve_debuff == 0 or nil) and var_33_2.temp_pass_point) do
			for iter_33_2, iter_33_3 in pairs(arg_33_1.replace_conditions) do
				if iter_33_1.id == iter_33_3[1] then
					var_0_18(var_33_4, iter_33_1.id)

					for iter_33_4, iter_33_5 in pairs(iter_33_1.info) do
						if iter_33_5.grade <= 2 and iter_33_5.count >= iter_33_3[2] then
							var_33_3[iter_33_1.id] = true
						end
					end
				end
			end
		end

		if #var_33_4 ~= #arg_33_1.replace_conditions then
			var_33_1 = false
		end

		local var_33_6 = 0

		if var_33_1 then
			if not next(var_33_3) then
				var_33_0 = false
			end

			for iter_33_6, iter_33_7 in pairs(var_33_3) do
				if not iter_33_7 then
					var_33_0 = false

					break
				end

				var_33_6 = var_33_6 + 1
			end
		else
			var_33_0 = false
		end

		if var_33_6 ~= #arg_33_1.replace_conditions then
			var_33_0 = false
		end

		var_0_28:setKeyData("map_is_lock", (var_33_0 or nil) and (var_0_5.map_pve_lock_condition.weak or var_0_5.map_pve_lock_condition.full))
		var_0_3:set_pve_condition((var_33_0 or nil) and (var_0_5.map_pve_lock_condition.weak or var_0_5.map_pve_lock_condition.full))
	end

	function arg_1_0.__show_buff_info(arg_34_0, arg_34_1, arg_34_2)
		arg_34_1.bg_mask.bg.info_bg:SetActive(true)
		arg_34_1.back_image_button:SetActive(true)

		local var_34_0 = var_0_24.find_object_by_id(arg_34_2)

		arg_34_1.bg_mask.bg.info_bg.buff_name.text.text = var_34_0.title
		arg_34_1.bg_mask.bg.info_bg.info_text.text.text = var_0_23.convert_rich_text(var_34_0.desc2)
	end

	function arg_1_0:__create_chapter_item_to_num(arg_35_1)
		self._chapterItemControl_List = self._chapterItemControl_List or {}

		local var_35_0 = arg_35_1 - self:__get_table_length(self._chapterItemControl_List)

		if var_35_0 <= 0 then
			return
		end

		for iter_35_0 = 1, var_35_0 do
			local var_35_1, var_35_2 = self:loadUIPrefab("chapter_scroll_item", self._chapter_scroll_view_control.curve_scroll_rect.viewport.edge_mask.content.transform)

			var_35_1:setVisible(true)
			table.insert(self._chapterItemControl_List, var_35_2)
		end
	end

	function arg_1_0:__load_chapter_scroll_view(arg_36_1)
		local var_36_0 = 3
		local var_36_1 = {}

		for iter_36_0 = 1, 3 do
			var_36_1[#var_36_1 + 1] = "---"
		end

		local var_36_2, var_36_3 = var_0_19.get_sequence()

		for iter_36_1 = 1, var_0_19.find_object_by_sequence_index(var_36_3).pve_id do
			var_36_1[#var_36_1 + 1] = var_0_1:getNowLang(string.format("chapter%s", iter_36_1))
		end

		for iter_36_2 = 1, 3 do
			var_36_1[#var_36_1 + 1] = "---"
		end

		if not self._chapter_scroll_view_control then
			local var_36_4, var_36_5 = self:loadUIPrefab("chapter_scroll_view", self._control.background.transform.parent)

			var_36_4:setVisible(true)

			self._chapter_scroll_view_control = var_36_5
			self._chapter_scroll_view_control.curve_scroll_rect.select_bg_img.select_text.text.text = var_36_1[4]
		end

		self:__create_chapter_item_to_num(#var_36_1)

		for iter_36_3 = 1, #var_36_1 do
			self._chapterItemControl_List[iter_36_3].item_text.text.text = var_36_1[iter_36_3]

			local var_36_6 = false

			if self._current_toggle_index == 3 then
				local var_36_7, var_36_8 = var_0_17.get_sequence()

				for iter_36_4, iter_36_5 in ipairs(var_36_7) do
					local var_36_9, var_36_10 = var_0_3:check_expedition_state(iter_36_5.id)

					if var_36_9 == var_0_5.expedition_state.done and iter_36_5.pve_id + 3 == iter_36_3 then
						var_36_6 = true
					end
				end
			else
				var_36_6 = false
			end

			self._chapterItemControl_List[iter_36_3].select_red:SetActive(var_36_6)

			if var_36_6 then
				if iter_36_3 - 3 <= 0 then
					log.errorlog("远征红点的章数不对")
				end

				self._farfight_finish_red[iter_36_3 - 3] = true
			end
		end

		if self._current_toggle_index == 3 then
			local var_36_12, var_36_13 = var_0_17.get_sequence()

			for iter_36_6, iter_36_7 in ipairs(var_36_12) do
				local var_36_14, var_36_15 = var_0_3:check_expedition_state(iter_36_7.id)

				if var_36_14 == var_0_5.expedition_state.done and iter_36_7.pve_id + 3 == 4 then
					-- block empty
				end
			end
		else
			-- block empty
		end

		self._chapter_scroll_view_control.curve_scroll_rect.curveScrollRect.onItemSelect:RemoveAllListeners()
		self._chapter_scroll_view_control.curve_scroll_rect.curveScrollRect.onItemSelect:AddListener(function(arg_37_0)
			self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.move_map_page))

			if self._ui_current_top_toggle_tag_name == var_0_29.gotofight then
				self._init_chapter_index = arg_37_0
			end

			if self._current_toggle_index == 3 then
				local var_37_1, var_37_2 = var_0_17.get_sequence()

				for iter_37_0, iter_37_1 in ipairs(var_37_1) do
					local var_37_3, var_37_4 = var_0_3:check_expedition_state(iter_37_1.id)

					if var_37_3 == var_0_5.expedition_state.done and iter_37_1.pve_id == arg_37_0 then
						-- block empty
					end
				end
			else
				-- block empty
			end

			self._chapter_scroll_view_control.curve_scroll_rect.select_bg_img.select_text.text.text = var_36_1[arg_37_0 + var_36_0]
			self._chapter_scroll_view_control.curve_scroll_rect.select_bg_img.select_icon.image.sprite = self:loadSprite(string.format("data/ui/pve/pve_chapter_icon%s.png", arg_37_0))
		end)
		self._chapter_scroll_view_control.curve_scroll_rect.curveScrollRect.onItemSelect:AddListener(arg_36_1)

		if self._ui_current_top_toggle_tag_name == var_0_29.gotofight then
			self._chapter_scroll_view_control.curve_scroll_rect.curveScrollRect:Init((self._init_chapter_index - 1) * 85, #var_36_1)
		else
			self._chapter_scroll_view_control.curve_scroll_rect.curveScrollRect:Init((self._current_far_toggle_index - 1) * 85, #var_36_1)
		end

		return self._chapter_scroll_view_control
	end

	function arg_1_0:__preload_map_fragment()
		self._has_loaded_pool = true
		self._obj_pool = {}

		for iter_38_0, iter_38_1 in ipairs({
			{
				preload_count = 15,
				preload_obj_name = "map_node_obj"
			},
			{
				preload_count = 15,
				preload_obj_name = "map_line_obj"
			},
			{
				preload_count = 15,
				preload_obj_name = "map_node_letter_obj"
			}
		}) do
			self._obj_pool[iter_38_1.preload_obj_name] = {}

			for iter_38_2 = 1, iter_38_1.preload_count do
				local var_38_0, var_38_1 = self:loadUIPrefab(iter_38_1.preload_obj_name, self._control.obj_pool_root.transform)

				var_38_0:setVisible(true)

				self._obj_pool[iter_38_1.preload_obj_name][#self._obj_pool[iter_38_1.preload_obj_name] + 1] = {
					using = false,
					prefabObj = var_38_0,
					prefabContorl = var_38_1
				}
			end
		end
	end

	function arg_1_0:__load_map_point_fragment_direct(arg_39_1, arg_39_2)
		local var_39_0, var_39_1 = self:loadUIPrefab(arg_39_1, arg_39_2)

		if var_39_0 then
			var_39_0:setVisible(true)
		end

		return var_39_0, var_39_1
	end

	function arg_1_0:__load_map_fragment_with_pool(arg_40_1, arg_40_2)
		local var_40_0 = false
		local var_40_1

		if not self._obj_pool[arg_40_1] then
			return
		end

		for iter_40_0, iter_40_1 in ipairs(self._obj_pool[arg_40_1]) do
			if iter_40_1.using == false then
				var_40_0 = true
				var_40_1 = self._obj_pool[arg_40_1][iter_40_0]

				break
			end
		end

		if var_40_0 then
			var_40_1.using = true

			var_40_1.prefabObj._panel.transform:SetParent(arg_40_2)

			return var_40_1.prefabObj, var_40_1.prefabContorl
		else
			local var_40_2, var_40_3 = self:loadUIPrefab(arg_40_1, arg_40_2)

			self._obj_pool[arg_40_1][#self._obj_pool[arg_40_1] + 1] = {
				using = true,
				prefabObj = var_40_2,
				prefabContorl = var_40_3
			}

			return var_40_2, var_40_3
		end
	end

	function arg_1_0:__hide_all_map_fragment_to_pool()
		for iter_41_0, iter_41_1 in pairs(self._obj_pool) do
			for iter_41_2, iter_41_3 in ipairs(iter_41_1) do
				if iter_41_3.using and self and self._control then
					iter_41_3.prefabObj._panel.transform:SetParent(self._control.obj_pool_root.transform)

					iter_41_3.using = false
				end
			end
		end
	end

	function arg_1_0:__destroy_map_point_fragments_under_parent(arg_42_1)
		if not arg_42_1 or not self._children then
			return
		end

		local var_42_0 = {}

		for iter_42_0, iter_42_1 in pairs(self._children) do
			if iter_42_1 and iter_42_1.getUIName then
				local var_42_1 = iter_42_1:getUIName()

				if var_42_1 == "map_node_obj" or var_42_1 == "map_node_letter_obj" then
					local var_42_2 = iter_42_1._panel and iter_42_1._panel.transform

					if var_42_2 then
						local var_42_3 = var_42_2

						while var_42_2 do
							if var_42_2 == arg_42_1 then
								var_42_0[iter_42_0] = iter_42_1

								break
							end

							var_42_3 = var_42_2.parent
						end
					end
				end
			end
		end

		for iter_42_2, iter_42_3 in pairs(var_42_0) do
			self._children[iter_42_2] = nil

			iter_42_3:destroy()
		end
	end

	function arg_1_0:__clear_all_map_scroll_item_node_layers(arg_43_1)
		if not arg_43_1 then
			return
		end

		if self._light_seq_list then
			for iter_43_0, iter_43_1 in pairs(self._light_seq_list) do
				if iter_43_1 and iter_43_1.Kill then
					iter_43_1:Kill()
				end
			end

			self._light_seq_list = {}
		end

		for iter_43_2 = 1, #arg_43_1 do
			if arg_43_1[iter_43_2] and arg_43_1[iter_43_2].bg_mask and arg_43_1[iter_43_2].bg_mask.bg and arg_43_1[iter_43_2].bg_mask.bg.map_node_root then
				self:__hide_map_fragment_to_pool_under_parent(arg_43_1[iter_43_2].bg_mask.bg.map_node_root.transform)
				self:__destroy_map_point_fragments_under_parent(arg_43_1[iter_43_2].bg_mask.bg.map_node_root.transform)
			end
		end
	end

	function arg_1_0:__hide_map_fragment_to_pool_under_parent(arg_44_1)
		if not arg_44_1 or not self._obj_pool or not self._control then
			return
		end

		local var_44_0 = self._obj_pool.map_line_obj

		if not self._obj_pool.map_line_obj then
			return
		end

		for iter_44_0, iter_44_1 in ipairs(var_44_0) do
			if iter_44_1.using and iter_44_1.prefabObj and iter_44_1.prefabObj._panel then
				if iter_44_1.prefabObj._panel.transform.parent and arg_44_1 and (iter_44_1.prefabObj._panel.transform.parent == arg_44_1 or tostring(iter_44_1.prefabObj._panel.transform.parent) == tostring(arg_44_1)) then
					iter_44_1.prefabObj._panel.transform:SetParent(self._control.obj_pool_root.transform)

					iter_44_1.using = false
				end
			end
		end
	end

	function arg_1_0.__ensure_gotofight_map_item_hit_order(arg_45_0, arg_45_1)
		if not arg_45_1 or not arg_45_1.bg_mask or not arg_45_1.bg_mask.bg then
			return
		end

		if arg_45_1.bg_mask.image then
			arg_45_1.bg_mask.image.raycastTarget = false
		end
	end

	function arg_1_0:__reset_gotofight_map_scroll_root_canvas_groups()
		if not self._mapItemObjList then
			return
		end

		local var_46_0 = typeof(var_0_8.CanvasGroup)

		for iter_46_0 = 1, #self._mapItemObjList do
			if self._mapItemObjList[iter_46_0]._panel and self._mapItemObjList[iter_46_0]._panel.gameObject then
				local var_46_1 = self._mapItemObjList[iter_46_0]._panel.gameObject:GetComponent(var_46_0)

				if var_46_1 then
					var_46_1.blocksRaycasts = true
				end
			end
		end
	end

	function arg_1_0:__play_top_menu_in_animation()
		if self and self._control then
			self._control.top_menu.top_menu_mask.image.raycastTarget = true

			if self and self._control then
				self._control.top_menu.rectTransform.anchoredPosition = var_0_9(self._control.top_menu.rectTransform.anchoredPosition.x, 100)
				self._control.top_menu.rectTransform:DOAnchorPos(var_0_9(self._control.top_menu.rectTransform.anchoredPosition.x, 0), 0.4):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0.2):SetAutoKill(true).onComplete = function()
					if self and self._control then
						self._control.top_menu.top_menu_mask.image.raycastTarget = false
					end
				end
			end
		end
	end

	function arg_1_0:__play_top_menu_out_animation()
		if self and self._control then
			self._control.top_menu.top_menu_mask.image.raycastTarget = true

			if self and self._control then
				self._control.top_menu.rectTransform.anchoredPosition = var_0_9(self._control.top_menu.rectTransform.anchoredPosition.x, 0)
				self._control.top_menu.rectTransform:DOAnchorPos(var_0_9(self._control.top_menu.rectTransform.anchoredPosition.x, 100), 0.5):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0):SetAutoKill(true).onComplete = function()
					self:__real_destroy_panel()
				end
			end
		end
	end

	function arg_1_0.__check_active_is_open(arg_51_0, arg_51_1)
		local var_51_0 = var_0_2:getInstance("home")

		if not var_51_0 then
			var_51_0 = var_0_2:createInstance("home")

			var_51_0:show()
			var_51_0:setVisible(false)
		end

		return var_51_0:active_is_open(arg_51_1)
	end

	function arg_1_0:__play_gotofight_panel_in_animation(arg_52_1)
		self._control.top_menu.tab_toggle.red_image_tips_root.tab_1_tips.trophy_remain:SetActive(self:__check_active_is_open(var_0_5.pve_active_list.bootyshop))
		self._control.top_menu.tab_toggle.red_image_tips_root.tab_1_tips.character_count:SetActive(true)

		local var_52_0 = var_0_3:get_use_info_data()
		local var_52_1 = var_52_0.ship_drop > 500 and 500 or var_52_0.ship_drop

		self._control.top_menu.tab_toggle.red_image_tips_root.tab_1_tips.trophy_remain.trophy_text.text.text = string.format("%d/50", var_52_0.spoils_limit)
		self._control.top_menu.tab_toggle.red_image_tips_root.tab_1_tips.character_count.character_count_text.text.text = string.format("%d/500", var_52_1)

		self._control.buttom_line.info_text:SetActive(true)

		self._control.buttom_line.info_text.text.text = var_0_1:getNowLang(var_0_6("uihelpinfo_31_%s", (lan_rand(1, 7))))

		if not self._chapter_scroll_view_control then
			return
		end

		if not self._map_scroll_view_control then
			return
		end

		local var_52_2 = 0.3
		local var_52_3 = arg_52_1 and 0.2 or 0

		if self._chapter_scroll_view_control.curve_scroll_rect.rectTransform then
			self._chapter_scroll_view_control.curve_scroll_rect.rectTransform.anchoredPosition = var_0_9(-900, -100)
			self._in_out_tweener1 = self._chapter_scroll_view_control.curve_scroll_rect.rectTransform:DOAnchorPos(var_0_9(-500, -100), var_52_2):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(var_52_3):SetAutoKill(true)
		end

		if self._map_scroll_view_control.lattice_scroll_view.rectTransform then
			self._map_scroll_view_control.lattice_scroll_view.rectTransform.anchoredPosition = var_0_9(1100, -103)
			self._in_out_tweener2 = self._map_scroll_view_control.lattice_scroll_view.rectTransform:DOAnchorPos(var_0_9(151, -103), var_52_2):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(var_52_3):SetAutoKill(true)
		end
	end

	function arg_1_0:__play_gotofight_panel_out_animation(arg_53_1)
		arg_53_1 = arg_53_1 or function()
			return
		end

		if not self._chapter_scroll_view_control then
			arg_53_1()

			return
		end

		if not self._map_scroll_view_control then
			arg_53_1()

			return
		end

		local var_53_0 = 0.3

		if self._chapter_scroll_view_control.curve_scroll_rect.rectTransform then
			self._in_out_tweener1 = self._chapter_scroll_view_control.curve_scroll_rect.rectTransform:DOAnchorPos(var_0_9(-900, -100), var_53_0):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0):SetAutoKill(true)
		end

		if self._map_scroll_view_control.lattice_scroll_view.rectTransform then
			self._map_scroll_view_control.lattice_scroll_view.rectTransform.anchoredPosition = var_0_9(151, -103)
			self._in_out_tweener2 = self._map_scroll_view_control.lattice_scroll_view.rectTransform:DOAnchorPos(var_0_9(1100, -103), var_53_0):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0):SetAutoKill(true)

			function self._in_out_tweener2.onComplete()
				arg_53_1()
			end
		else
			arg_53_1()
		end
	end

	function arg_1_0:__play_exercise_panel_in_animation()
		if not self._exercise then
			return
		end

		self._control.buttom_line.info_text:SetActive(true)

		self._control.buttom_line.info_text.text.text = var_0_1:getNowLang(var_0_6("uihelpinfo_32_%s", (lan_rand(1, 5))))

		if self._exercise._control.scroll_view.transform then
			self._exercise._control.scroll_view.transform.localPosition = var_0_9(1558, -6)
			self._in_out_tweener1 = self._exercise._control.scroll_view.transform:DOLocalMove(var_0_9(16, -6), 0.3):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0):SetAutoKill(true)
		end
	end

	function arg_1_0:__play_exercise_panel_out_animation(arg_57_1)
		arg_57_1 = arg_57_1 or function()
			return
		end

		if not self._exercise then
			arg_57_1()

			return
		end

		if self._exercise._control.scroll_view.rectTransform then
			self._exercise._control.scroll_view.transform.localPosition = var_0_9(7, -6)
			self._in_out_tweener1 = self._exercise._control.scroll_view.transform:DOLocalMove(var_0_9(1558, -6), 0.3):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0):SetAutoKill(true)

			function self._in_out_tweener1.onComplete()
				self:__hide_exercise_panel()
				arg_57_1()
			end
		else
			arg_57_1()
		end
	end

	function arg_1_0:__play_farfight_panel_in_animation(arg_60_1)
		if not self._chapter_scroll_view_control then
			return
		end

		if not self._farfight then
			return
		end

		self._control.buttom_line.info_text:SetActive(true)

		self._control.buttom_line.info_text.text.text = var_0_1:getNowLang(var_0_6("uihelpinfo_34_%s", (lan_rand(1, 5))))

		local var_60_0 = 0.3
		local var_60_1 = arg_60_1 and 0.2 or 0

		if self._chapter_scroll_view_control.curve_scroll_rect.rectTransform then
			self._chapter_scroll_view_control.curve_scroll_rect.rectTransform.anchoredPosition = var_0_9(-900, -100)
			self._in_out_tweener1 = self._chapter_scroll_view_control.curve_scroll_rect.rectTransform:DOAnchorPos(var_0_9(-500, -100), var_60_0):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(var_60_1):SetAutoKill(true)
		end

		if self._farfight._control.scroll_view.rectTransform then
			self._farfight._control.scroll_view.rectTransform.anchoredPosition = var_0_9(950, -20)
			self._in_out_tweener2 = self._farfight._control.scroll_view.rectTransform:DOAnchorPos(var_0_9(-34, -20), var_60_0):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(var_60_1):SetAutoKill(true)
		end
	end

	function arg_1_0:__play_farfight_panel_out_animation(arg_61_1)
		arg_61_1 = arg_61_1 or function()
			return
		end

		if not self._chapter_scroll_view_control then
			arg_61_1()

			return
		end

		if not self._farfight then
			arg_61_1()

			return
		end

		local var_61_0 = 0.3

		if self._chapter_scroll_view_control.curve_scroll_rect.rectTransform then
			self._in_out_tweener1 = self._chapter_scroll_view_control.curve_scroll_rect.rectTransform:DOAnchorPos(var_0_9(-900, -100), var_61_0):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0):SetAutoKill(true)
		end

		if self._farfight._control.scroll_view.rectTransform then
			self._farfight._control.scroll_view.rectTransform.anchoredPosition = var_0_9(-34, -20)
			self._in_out_tweener2 = self._farfight._control.scroll_view.rectTransform:DOAnchorPos(var_0_9(950, -20), var_61_0):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0):SetAutoKill(true)

			function self._in_out_tweener2.onComplete()
				self:__hide_farfight_panel()
				arg_61_1()
			end
		else
			arg_61_1()
		end
	end

	function arg_1_0:__play_campaign_panel_in_animation()
		if not self._campaign then
			return
		end

		self._control.buttom_line.info_text:SetActive(true)

		self._control.buttom_line.info_text.text.text = var_0_1:getNowLang(var_0_6("uihelpinfo_35_%s", (lan_rand(1, 5))))

		if self._campaign._control.scroll_view.rectTransform then
			self._campaign._control.scroll_view.rectTransform.anchoredPosition = var_0_9(1250, -32)
			self._in_out_tweener1 = self._campaign._control.scroll_view.rectTransform:DOAnchorPos(var_0_9(0, -32), 0.3):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0):SetAutoKill(true)
		end
	end

	function arg_1_0:__play_campaign_panel_out_animation(arg_65_1)
		arg_65_1 = arg_65_1 or function()
			return
		end

		if not self._campaign then
			arg_65_1()

			return
		end

		if self._campaign._control.scroll_view.rectTransform then
			self._campaign._control.scroll_view.rectTransform.anchoredPosition = var_0_9(0, -32)
			self._in_out_tweener1 = self._campaign._control.scroll_view.rectTransform:DOAnchorPos(var_0_9(1250, -32), 0.3):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0):SetAutoKill(true)

			function self._in_out_tweener1.onComplete()
				self:__hide_campaign_panel()
				arg_65_1()
			end
		else
			arg_65_1()
		end
	end

	function arg_1_0:__play_active_panel_out_animation(arg_68_1)
		arg_68_1 = arg_68_1 or function()
			return
		end

		if not self._active_info then
			arg_68_1()

			return
		end

		if self._active_info and self._active_info._control.all_active.rectTransform then
			self._active_info._control.all_active.rectTransform.anchoredPosition = var_0_9(-530, -690)
			self._in_out_tweener1 = self._active_info._control.all_active.rectTransform:DOAnchorPos(var_0_9(1250, -690), 0.3):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0):SetAutoKill(true)

			function self._in_out_tweener1.onComplete()
				self:__hide_active_info_panel()
				arg_68_1()
			end
		else
			arg_68_1()
		end
	end

	function arg_1_0:__set_map_data_by_chapter(arg_71_1, arg_71_2, arg_71_3, arg_71_4, arg_71_5, arg_71_6, arg_71_7)
		if self._curr_set_chapter_index == arg_71_1 and arg_71_1 ~= nil and arg_71_1 ~= -1 then
			return
		end

		self:__hide_all_map_fragment_to_pool()
		self:__clear_all_map_scroll_item_node_layers(arg_71_5)
		arg_71_4.lattice_scroll_view.latticeScrollRect.onShowNextItem:RemoveAllListeners()

		local var_71_0

		if self._is_open_init then
			var_71_0 = self._init_map_index - 1 or 0
		end

		self._is_open_init = false
		self._init_map_index = var_71_0 + 1

		arg_71_4.lattice_scroll_view.latticeScrollRect:SetTargetItemIndex(var_71_0)

		local var_71_1 = arg_71_2[arg_71_1]

		arg_71_4.lattice_scroll_view.latticeScrollRect:SetContentWidthWithMapCount(#arg_71_2[arg_71_1])

		for iter_71_0 = 1, #arg_71_2[arg_71_1] do
			local var_71_2 = arg_71_2[arg_71_1][iter_71_0]

			self:__ensure_gotofight_map_item_hit_order(arg_71_5[iter_71_0])
			self:__update_boss_hp(var_71_2, arg_71_2[arg_71_1][iter_71_0].need_pve_level_id, arg_71_5[iter_71_0])

			arg_71_5[iter_71_0].bg_mask.bg.image.sprite = self:loadSprite(string.format(var_0_5.map_path, var_71_2.id, var_71_2.id))
			arg_71_5[iter_71_0].bg_mask.bg.map_title_bg.map_title_text.text.text = var_71_2.title .. "/" .. var_71_2.sub_title

			self:__set_support_info(var_71_2.support_id, var_0_3:is_map_pass(arg_71_2[arg_71_1][iter_71_0].need_pve_level_id), arg_71_5[iter_71_0], var_71_2.id)
			arg_71_5[iter_71_0].bg_mask.bg.map_click_btn.button.onClick:RemoveAllListeners()

			if arg_71_2[arg_71_1][iter_71_0].need_pve_level_id == 0 or var_0_3:is_map_pass(arg_71_2[arg_71_1][iter_71_0].need_pve_level_id) then
				arg_71_5[iter_71_0].bg_mask.bg.map_lock_panel.canvasGroup.alpha = 0
				arg_71_5[iter_71_0].bg_mask.bg.map_lock_panel.canvasGroup.blocksRaycasts = false

				arg_71_5[iter_71_0].bg_mask.bg.map_click_btn.button.onClick:AddListener(function()
					self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.move_map_page))
					self:__check_save_pve_condition(var_71_2)
					self:setVisible(false)
					var_0_2:createInstance("fight_prepare"):show({
						fight_prepare_type = var_0_5.fight_type.gotofight,
						go_to_map_id = var_71_2.id,
						support_id = var_71_2.support_id,
						is_map_pass = var_71_2.is_map_pass,
						init_chapter_index = self._init_chapter_index,
						init_map_index = self._init_map_index
					})
				end)

				if iter_71_0 == var_71_0 + 1 then
					self:__set_node_data_by_map(arg_71_7[var_71_2.map_id], arg_71_5[iter_71_0], var_71_2.map_id)
				end

				arg_71_5[iter_71_0].bg_mask.bg.map_pass_tag.canvasGroup.alpha = var_0_3:is_map_pass(var_71_2.map_id) and 1 or 0

				arg_71_5[iter_71_0].bg_mask.bg.drop_available:SetActive(true)
				arg_71_5[iter_71_0].bg_mask.bg.drop_available.button.onClick:RemoveAllListeners()
				arg_71_5[iter_71_0].bg_mask.bg.drop_available.button.onClick:AddListener(function()
					local var_73_0 = var_0_2:getInstance("ship_available")
					local var_73_1 = var_0_4.drop_available_config.find_object_by_pve_id(var_71_2.id)

					if var_73_0 then
						var_73_0:show(var_0_5.go_to_ship_available.main_go, var_73_1)
					else
						var_0_2:createInstance("ship_available"):show(var_0_5.go_to_ship_available.main_go, var_73_1)
					end
				end)
			else
				arg_71_5[iter_71_0].bg_mask.bg.map_lock_panel.canvasGroup.alpha = 1
				arg_71_5[iter_71_0].bg_mask.bg.map_lock_panel.canvasGroup.blocksRaycasts = true

				local var_71_3 = self:__get_map_data_by_id(arg_71_3, arg_71_2[arg_71_1][iter_71_0].need_pve_level_id)

				arg_71_5[iter_71_0].bg_mask.bg.map_lock_panel.unlock_need_title_bg.unlock_need_text.text.text = string.format("%s %s %s", arg_71_6, var_71_3.title, var_71_3.sub_title)
				arg_71_5[iter_71_0].bg_mask.bg.map_lock_panel.map_title_bg.map_title_text.text.text = var_71_2.title .. "/" .. var_71_2.sub_title

				arg_71_5[iter_71_0].bg_mask.bg.drop_available:SetActive(false)
			end
		end

		local function var_71_4(arg_74_0, arg_74_1)
			if arg_74_0 == nil then
				return
			end

			local var_74_0 = arg_74_0 + (arg_74_1 and 1 or -1)

			self._init_map_index = arg_74_0 + (arg_74_1 and 1 or -1)

			if var_71_1[var_74_0] == nil then
				return
			end

			if not arg_71_5[var_74_0] then
				return
			end

			self:__set_node_data_by_map(arg_71_7[var_71_1[var_74_0].map_id], arg_71_5[var_74_0], var_71_1[var_74_0].map_id)
		end

		arg_71_4.lattice_scroll_view.latticeScrollRect.onShowNextItem:RemoveAllListeners()
		arg_71_4.lattice_scroll_view.latticeScrollRect.onSuccessShowNextItem:RemoveAllListeners()
		arg_71_4.lattice_scroll_view.latticeScrollRect.onShowNextItem:AddListener(function(arg_75_0)
			if not arg_75_0 or arg_75_0 and arg_75_0 < #var_71_1 then
				self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.move_map_page))
			end
		end)
		arg_71_4.lattice_scroll_view.latticeScrollRect.onSuccessShowNextItem:AddListener(function(arg_76_0)
			if not arg_76_0 or arg_76_0 and arg_76_0 < #var_71_1 then
				var_71_4(arg_76_0, true)
			end
		end)
		arg_71_4.lattice_scroll_view.latticeScrollRect.onShowLastItem:RemoveAllListeners()
		arg_71_4.lattice_scroll_view.latticeScrollRect.onSuccessShowLastItem:RemoveAllListeners()
		arg_71_4.lattice_scroll_view.latticeScrollRect.onShowLastItem:AddListener(function(arg_77_0)
			if not arg_77_0 or arg_77_0 and arg_77_0 > 1 then
				self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.move_map_page))
			end
		end)
		arg_71_4.lattice_scroll_view.latticeScrollRect.onSuccessShowLastItem:AddListener(function(arg_78_0)
			if not arg_78_0 or arg_78_0 and arg_78_0 > 1 then
				var_71_4(arg_78_0, false)
			end
		end)

		self._curr_set_chapter_index = arg_71_1

		if #arg_71_2[arg_71_1] > 1 and self._init_map_index < #arg_71_2[arg_71_1] then
			self._map_scroll_view_control.lattice_scroll_view.next_page_btn:SetActive(true)
		else
			self._map_scroll_view_control.lattice_scroll_view.next_page_btn:SetActive(false)
		end

		self:__reset_gotofight_map_scroll_root_canvas_groups()
	end

	function arg_1_0:__set_node_data_by_map(arg_79_1, arg_79_2, arg_79_3)
		if arg_79_2 and arg_79_2.bg_mask and arg_79_2.bg_mask.bg and arg_79_2.bg_mask.bg.map_node_root then
			if self._light_seq_list then
				for iter_79_0, iter_79_1 in pairs(self._light_seq_list) do
					if iter_79_1 and iter_79_1.Kill then
						iter_79_1:Kill()
					end
				end

				self._light_seq_list = {}
			end

			self:__hide_map_fragment_to_pool_under_parent(arg_79_2.bg_mask.bg.map_node_root.transform)
			self:__destroy_map_point_fragments_under_parent(arg_79_2.bg_mask.bg.map_node_root.transform)
		end

		if not arg_79_1 then
			return
		end

		local var_79_0 = false

		if arg_79_3 and arg_79_3 == 704 then
			local var_79_1 = var_0_3:get_map_list()

			if var_79_1 then
				if var_79_1[arg_79_3] then
					for iter_79_2, iter_79_3 in pairs(var_79_1[arg_79_3].node_miss) do
						if iter_79_3.point_id and iter_79_3.point_id == 70405 then
							var_79_0 = true

							break
						end
					end
				end
			end
		end

		local var_79_2 = arg_79_2.bg_mask.bg.map_node_root.rectTransform.rect.width
		local var_79_3 = arg_79_2.bg_mask.bg.map_node_root.rectTransform.rect.height
		local var_79_4 = {}

		for iter_79_4, iter_79_5 in ipairs(arg_79_1) do
			if iter_79_5.node_miss and next(iter_79_5.node_miss) then
				for iter_79_6, iter_79_7 in pairs(iter_79_5.node_miss) do
					var_0_18(var_79_4, {
						hide_start_point = iter_79_5.id,
						hide_end_point = iter_79_6,
						hide_result = iter_79_7
					})
				end
			end
		end

		for iter_79_8, iter_79_9 in ipairs(arg_79_1) do
			local var_79_5, var_79_6 = self:__load_map_point_fragment_direct("map_node_obj", arg_79_2.bg_mask.bg.map_node_root.transform)

			var_79_5:setVisible(true)

			local var_79_7 = var_79_6.node_image.guard_icon

			if var_79_6.node_image.guard_icon then
				var_79_7:SetActive(false)
				var_79_7.button.onClick:RemoveAllListeners()
			end

			var_79_6.node_image.rectTransform.parent.offsetMin = var_0_9(0, 0)
			var_79_6.node_image.rectTransform.parent.offsetMax = var_0_9(0, 0)
			var_79_6.node_image.rectTransform.anchoredPosition = self:__get_real_node_pos(var_79_2, var_79_3, iter_79_9.position.x, iter_79_9.position.y)

			local var_79_8

			if iter_79_9.node_attribute == var_0_5.map_node_finish_type.init then
				var_79_8 = var_0_5.fight_point.pve_start_l
			elseif iter_79_9.node_attribute == var_0_5.map_node_finish_type.boss_finish then
				var_79_8 = var_0_3:is_map_node_pass(iter_79_9.pve_level_id, iter_79_9.id) and var_0_5.fight_point.pve_boss_l or var_0_5.fight_point.pve_boss
			elseif iter_79_9.node_type == var_0_5.map_node_type.reward then
				var_79_8 = var_0_3:is_map_node_pass(iter_79_9.pve_level_id, iter_79_9.id) and var_0_5.fight_point.pve_green or var_0_5.fight_point.pve_white
			elseif iter_79_9.node_type == var_0_5.map_node_type.loss then
				var_79_8 = var_0_3:is_map_node_pass(iter_79_9.pve_level_id, iter_79_9.id) and var_0_5.fight_point.pve_purple or var_0_5.fight_point.pve_white
			elseif iter_79_9.node_type == var_0_5.map_node_type.null then
				var_79_8 = var_0_3:is_map_node_pass(iter_79_9.pve_level_id, iter_79_9.id) and var_0_5.fight_point.pve_blue or var_0_5.fight_point.pve_white
			elseif iter_79_9.node_type == var_0_5.map_node_type.little_boss then
				self._little_boss_point_data = iter_79_9
				var_79_8 = var_0_3:is_map_node_pass(iter_79_9.pve_level_id, iter_79_9.id) and var_0_5.fight_point.pve_small_boss_l or var_0_5.fight_point.pve_small_boss

				local var_79_9, var_79_10 = var_0_3:is_point_stationed(iter_79_9.id)

				self._current_station_team_id = var_79_10

				if var_79_9 then
					local var_79_11 = var_79_6.node_image.transform.localPosition

					var_79_7:SetActive(true)

					if var_79_7.transform and var_79_7.transform.parent then
						var_79_7.transform:SetAsLastSibling()
					end

					var_79_7.button.onClick:RemoveAllListeners()
					var_79_7.button.onClick:AddListener(function()
						local var_80_0 = tonumber((string.sub(tostring(var_79_7.team_id.image.sprite), 16, 16)))
						local var_80_1 = var_80_0 and var_0_3:get_team_by_id(var_80_0)

						if not var_80_1 then
							return
						end

						local var_80_2 = var_0_2:createInstance("captainroom_fleet")

						if not var_80_2 then
							return
						end

						var_80_2:show(var_0_1:getNowLang("ui_activitydefendfleet"), var_80_1.members, var_0_1:getNowLang("ui_activitydefendcancel"), "", function()
							local var_81_0 = var_0_2:getInstance("msgbox") or var_0_2:createInstance("msgbox")

							var_81_0:show(var_0_1:getNowLang("ui_activitydefendcanceltip"), function()
								var_81_0:setVisible(false)

								if self._control and self._control.back_image then
									self._control.back_image:SetActive(false)
								end

								var_0_3:req_StationPointExitReq(var_80_0)
								var_0_2:destroyInstance("captainroom_fleet")
							end, function()
								var_81_0:setVisible(false)
							end, var_0_1:getNowLang("ui_activitydefendcancel"))
						end, true)
					end)

					local var_79_12 = iter_79_9.bubble_icon

					if iter_79_9.bubble_icon == 0 then
						var_79_12 = 1
					end

					var_79_7.image.sprite = self:loadSprite(string.format(var_0_5.guard_point.pve_node_guard, var_79_12))
					var_79_7.team_id.image.sprite = self:loadSprite(string.format(var_0_5.guard_point.pve_fleet_team, self._current_station_team_id))

					if var_79_7.team_id.image then
						var_79_7.team_id.image.raycastTarget = false
					end

					if var_79_7.image then
						var_79_7.image.raycastTarget = true
					end

					if var_79_7.button then
						var_79_7.button.interactable = true
					end

					var_79_7.transform.localScale = var_0_10(1.38, 1.54, 1)

					local var_79_13 = var_0_10.zero
					local var_79_14 = var_0_10.zero

					if var_79_12 == 1 then
						var_79_13 = var_0_9(-10, -142)
						var_79_14 = var_0_9(0, -2.8)
					elseif var_79_12 == 2 then
						var_79_13 = var_0_9(-10, 0)
						var_79_14 = var_0_9(0, 6)
					elseif var_79_12 == 3 then
						var_79_13 = var_0_9(120, 0)
						var_79_14 = var_0_9(0, 6)
					elseif var_79_12 == 4 then
						var_79_13 = var_0_9(120, -142)
						var_79_14 = var_0_9(0, -2.8)
					end

					if (var_79_12 == 1 or var_79_12 == 2) and var_79_11.x < 60 then
						var_79_13.x = 10
					elseif (var_79_12 == 1 or var_79_12 == 4) and var_79_11.y <= -537 then
						var_79_13.y = -104
					end

					var_79_7.transform.anchoredPosition = var_79_13
					var_79_7.team_id.transform.anchoredPosition = var_79_14
				else
					var_79_7:SetActive(false)
					var_79_7.button.onClick:RemoveAllListeners()
				end
			else
				var_79_8 = var_0_3:is_map_node_pass(iter_79_9.pve_level_id, iter_79_9.id) and var_0_5.fight_point.pve_red or var_0_5.fight_point.pve_white
			end

			var_79_6.node_image.image.sprite = self:loadSprite(var_79_8)

			var_79_6.node_image.image:SetNativeSize()

			local var_79_16

			if iter_79_9.roundabout == 1 then
				var_79_16 = var_0_5.pve_g
			elseif iter_79_9.night_atk == 1 then
				var_79_16 = var_0_5.pve_night_atk_l
			elseif iter_79_9.node_type == 10 then
				var_79_16 = var_0_5.pve_air
			elseif iter_79_9.node_type == 11 then
				var_79_16 = var_0_5.pve_special_boss_l
			end

			if var_79_16 then
				local var_79_17 = math.floor(iter_79_9.id / 100)

				if var_79_17 == 902 then
					for iter_79_10, iter_79_11 in pairs(self._light_seq_list) do
						if math.floor(iter_79_10 / 100) ~= var_79_17 then
							self._light_seq_list[iter_79_10]:Kill()
							table.remove(self._light_seq_list, iter_79_10)

							var_79_6.night_atk_point.image.color = var_0_12
						end
					end
				end

				var_79_6.night_atk_point.image.sprite = self:loadSprite(var_79_16)

				var_79_6.night_atk_point.image:SetNativeSize()
				var_79_6.night_atk_point:SetActive(true)

				var_79_6.night_atk_point.rectTransform.parent.offsetMin = var_0_9(0, 0)
				var_79_6.night_atk_point.rectTransform.parent.offsetMax = var_0_9(0, 0)
				var_79_6.night_atk_point.rectTransform.anchoredPosition = self:__get_real_node_pos(var_79_2, var_79_3, iter_79_9.position.x, iter_79_9.position.y)

				if iter_79_9.night_atk == 1 or iter_79_9.node_type == 10 or iter_79_9.node_type == 11 then
					local var_79_18 = true

					if iter_79_9.node_type == 11 and var_0_3:is_map_node_s_pass(iter_79_9.pve_level_id, iter_79_9.id) then
						var_79_6.night_atk_point:SetActive(false)

						var_79_18 = false
					end

					if var_79_18 then
						if self._light_seq_list[iter_79_9.id] then
							self._light_seq_list[iter_79_9.id]:Kill()
							table.remove(self._light_seq_list, iter_79_9.id)
						end

						self._light_seq = self:autoKillDOTween(var_0_21.Sequence())

						self._light_seq:Append(var_79_6.night_atk_point.image:DOFade(0, 0))
						self._light_seq:Append(var_79_6.night_atk_point.image:DOFade(1, 1))
						self._light_seq:Append(var_79_6.night_atk_point.image:DOFade(0, 1))
						self._light_seq:SetLoops(-1)
						self._light_seq:Play()

						self._light_seq_list[iter_79_9.id] = self._light_seq
					end
				end
			else
				var_79_6.night_atk_point:SetActive(false)
			end

			local var_79_19 = {}

			for iter_79_12, iter_79_13 in pairs(var_79_4) do
				if iter_79_13.hide_start_point == iter_79_9.id then
					for iter_79_14, iter_79_15 in pairs(iter_79_13.hide_result) do
						local var_79_21 = var_0_20.find_object_by_id(tonumber(iter_79_14))

						if tonumber(var_79_21.id) ~= 70405 then
							if var_0_3:is_map_node_pass(var_79_21.pve_level_id, var_79_21.id) and iter_79_15 <= var_0_3:get_map_node_pass_count(var_79_21.pve_level_id, tonumber(var_79_21.id)) then
								for iter_79_16, iter_79_17 in pairs(iter_79_9.next_node) do
									if iter_79_17 == tonumber(iter_79_13.hide_end_point) then
										var_0_18(var_79_19, iter_79_17)
									end
								end
							end
						elseif var_79_0 then
							for iter_79_18, iter_79_19 in pairs(iter_79_9.next_node) do
								if iter_79_19 == tonumber(iter_79_13.hide_end_point) then
									var_0_18(var_79_19, iter_79_19)
								end
							end
						end
					end
				end
			end

			local var_79_22 = {}
			local var_79_23 = true

			if iter_79_9.node_hide and next(iter_79_9.node_hide) then
				for iter_79_20, iter_79_21 in pairs(iter_79_9.node_hide) do
					for iter_79_22, iter_79_23 in pairs(iter_79_9.next_node) do
						if tonumber(iter_79_20) == iter_79_23 then
							for iter_79_24, iter_79_25 in pairs(iter_79_21) do
								local var_79_25 = var_0_20.find_object_by_id(tonumber(iter_79_25))

								if not var_0_3:is_map_node_pass(var_79_25.pve_level_id, var_79_25.id) then
									var_79_23 = false
								end
							end

							var_0_18(var_79_22, {
								is_show_true = var_79_23,
								node_flag = var_0_20.find_object_by_id(tonumber(iter_79_20)).flag
							})
						end
					end
				end
			end

			if iter_79_9.garrison_node_open and next(iter_79_9.garrison_node_open) or iter_79_9.garrison_node_close and next(iter_79_9.garrison_node_close) then
				local var_79_26 = {}

				if iter_79_9.garrison_node_open then
					for iter_79_26, iter_79_27 in pairs(iter_79_9.garrison_node_open) do
						var_79_26[iter_79_26] = true
					end
				end

				if iter_79_9.garrison_node_close then
					for iter_79_28, iter_79_29 in pairs(iter_79_9.garrison_node_close) do
						var_79_26[iter_79_28] = true
					end
				end

				for iter_79_30, iter_79_31 in pairs(var_79_26) do
					local var_79_27 = var_0_20.find_object_by_id(tonumber(iter_79_30))

					if var_79_27 then
						local var_79_28 = true
						local var_79_29

						if iter_79_9.garrison_node_open then
							var_79_29 = iter_79_9.garrison_node_open[iter_79_30] or iter_79_9.garrison_node_open[tonumber(iter_79_30)]
						end

						if var_79_29 then
							for iter_79_32, iter_79_33 in pairs(var_79_29) do
								if not var_0_3:is_point_stationed(tonumber(iter_79_33)) then
									var_79_28 = false

									break
								end
							end
						end

						local var_79_30 = true
						local var_79_31

						if iter_79_9.garrison_node_close then
							var_79_31 = iter_79_9.garrison_node_close[iter_79_30] or iter_79_9.garrison_node_close[tonumber(iter_79_30)]
						end

						if var_79_31 then
							for iter_79_34, iter_79_35 in pairs(var_79_31) do
								if var_0_3:is_point_stationed(tonumber(iter_79_35)) then
									var_79_30 = false

									break
								end
							end
						end

						var_0_18(var_79_22, {
							is_show_true = var_79_28 and var_79_30,
							node_flag = var_79_27.flag
						})
					end
				end
			end

			local var_79_32 = {}

			for iter_79_36, iter_79_37 in ipairs(var_79_22) do
				var_79_32[iter_79_37.node_flag] = var_79_32[iter_79_37.node_flag] == nil and iter_79_37.is_show_true or var_79_32[iter_79_37.node_flag] and iter_79_37.is_show_true
			end

			if iter_79_9.next_node_path ~= "{}" then
				for iter_79_38, iter_79_39 in pairs((var_0_7(iter_79_9.next_node_path))) do
					local var_79_34, var_79_35 = self:__load_map_fragment_with_pool("map_line_obj", arg_79_2.bg_mask.bg.map_node_root.transform)

					var_79_34:setVisible(true)

					var_79_35.line_image.rectTransform.parent.offsetMin = var_0_9(0, 0)
					var_79_35.line_image.rectTransform.parent.offsetMax = var_0_9(0, 0)
					var_79_35.line_image.rectTransform.anchoredPosition = self:__get_real_node_pos(var_79_2, var_79_3, iter_79_39.x, iter_79_39.y)
					var_79_35.line_image.image.sprite = self:loadSprite((string.format(var_0_5.mapline_path, arg_79_3, iter_79_38)))

					var_79_35.line_image.image:SetNativeSize()
					var_79_35.line_image:SetActive(true)

					var_79_35.line_image.image.color = var_0_12

					local var_79_36 = lx.split(iter_79_38, "-")[3]

					if var_79_32[var_79_36] ~= nil then
						var_79_35.line_image.image.color = var_79_32[var_79_36] and var_0_12 or var_0_14
					end

					if next(var_79_19) then
						for iter_79_40, iter_79_41 in pairs(var_79_19) do
							if var_0_6("%s-%s-%s", iter_79_9.pve_level_id, iter_79_9.flag, var_0_20.find_object_by_id(iter_79_41).flag) == iter_79_38 then
								var_79_35.line_image:SetActive(false)
							end
						end
					end
				end
			end

			if #iter_79_9.flag > 0 then
				local var_79_37, var_79_38 = self:__load_map_point_fragment_direct("map_node_letter_obj", arg_79_2.bg_mask.bg.map_node_root.transform)

				var_79_37:setVisible(true)

				var_79_38.node_letter_text.rectTransform.parent.offsetMin = var_0_9(0, 0)
				var_79_38.node_letter_text.rectTransform.parent.offsetMax = var_0_9(0, 0)
				var_79_38.node_letter_text.rectTransform.anchoredPosition = var_79_6.node_image.rectTransform.anchoredPosition + var_0_9(0, 26)
				var_79_38.node_letter_text.text.text = iter_79_9.flag
			end
		end

		self:__ensure_gotofight_map_item_hit_order(arg_79_2)
	end

	function arg_1_0:__set_support_info(arg_84_1, arg_84_2, arg_84_3, arg_84_4)
		arg_84_1 = tonumber(arg_84_1)

		local var_84_0 = not not (arg_84_1 ~= 0 and arg_84_2)

		arg_84_3.bg_mask.bg.map_support:SetActive(arg_84_1 ~= 0 and arg_84_2 and true or false)

		if var_84_0 then
			local var_84_1 = var_0_11.find_object_by_id(arg_84_1)
			local var_84_2 = var_0_3:get_supportInfo_data(arg_84_4)

			arg_84_3.bg_mask.bg.map_support.icon_bg.image.sprite = self:loadSprite(not not var_84_2 and var_0_5.pve_support_bg["pve_support_lv_" .. var_84_2.level] or var_0_5.pve_support_bg.pve_support_lv_0)

			arg_84_3.bg_mask.bg.map_support.support_button.button.onClick:RemoveAllListeners()
			arg_84_3.bg_mask.bg.map_support.support_button.button.onClick:AddListener(function()
				var_0_2:createInstance("support_info"):show(var_84_1, arg_84_4)
			end)

			arg_84_3.bg_mask.bg.map_support.support_button.image.sprite = self:loadSprite(var_0_5.support_pve_icon["pve_support_" .. var_84_1.type])
		end
	end

	function arg_1_0.__get_real_node_pos(arg_86_0, arg_86_1, arg_86_2, arg_86_3, arg_86_4)
		return var_0_9(arg_86_3 / 1280 * arg_86_1, -1 * arg_86_4 / 960 * arg_86_2)
	end

	function arg_1_0.__get_map_data(arg_87_0)
		local var_87_0 = {}
		local var_87_1, var_87_2 = var_0_19.get_sequence()

		for iter_87_0, iter_87_1 in pairs(var_87_1) do
			local var_87_3 = tonumber(iter_87_1.pve_id)

			if var_87_3 < 20 then
				if var_87_0[var_87_3] == nil then
					var_87_0[var_87_3] = {}
				end

				var_87_0[var_87_3][#var_87_0[var_87_3] + 1] = iter_87_1
			end
		end

		return var_87_0, var_87_1
	end

	function arg_1_0:get_map_data()
		return self:__get_map_data()
	end

	function arg_1_0.__get_max_mapnum_per_chapter(arg_89_0, arg_89_1)
		local var_89_0 = 0

		if next(arg_89_1) then
			for iter_89_0, iter_89_1 in pairs(arg_89_1) do
				if var_89_0 < #arg_89_1[iter_89_0] then
					var_89_0 = #arg_89_1[iter_89_0]
				end
			end

			return var_89_0
		else
			arg_89_1 = var_0_19.get_sequence()

			for iter_89_2, iter_89_3 in pairs(arg_89_1) do
				if var_89_0 < #arg_89_1[iter_89_2] then
					var_89_0 = #arg_89_1[iter_89_2]
				end
			end

			return var_89_0
		end
	end

	function arg_1_0.__get_map_data_by_id(arg_90_0, arg_90_1, arg_90_2)
		for iter_90_0, iter_90_1 in pairs(arg_90_1) do
			if tonumber(iter_90_1.id) == tonumber(arg_90_2) then
				return iter_90_1
			end
		end
	end

	function arg_1_0.__get_node_data(arg_91_0)
		local var_91_0 = {}
		local var_91_1, var_91_2 = var_0_20.get_sequence()

		for iter_91_0, iter_91_1 in pairs(var_91_1) do
			local var_91_3 = tonumber(iter_91_1.pve_level_id)

			if var_91_3 < 9000 then
				if var_91_0[var_91_3] == nil then
					var_91_0[var_91_3] = {}
				end

				var_91_0[var_91_3][#var_91_0[var_91_3] + 1] = iter_91_1
			end
		end

		return var_91_0, var_91_1
	end

	function arg_1_0:__init_exercise_panel()
		if not self._exercise then
			self._exercise = self:loadUI("exercise")

			self._exercise._panel.transform:SetParent(self._panel.transform, false)

			self._canvas_groups.exercise = var_0_23.add_canvas_group_component_to_panel(self._exercise)
		end

		self._exercise:show()

		self._canvas_groups.exercise.alpha = 1
		self._canvas_groups.exercise.blocksRaycasts = true
	end

	function arg_1_0:__hide_exercise_panel()
		if not self._exercise then
			return
		end

		self._canvas_groups.exercise.alpha = 0
		self._canvas_groups.exercise.blocksRaycasts = false
	end

	function arg_1_0:update_exercise_info()
		if not self._exercise then
			return
		end

		self._exercise:set_panel_info()
	end

	function arg_1_0:update_exercise_item_panel(arg_95_1)
		self._exercise:update_exercise_item_panel(arg_95_1)
	end

	function arg_1_0:__init_farfight_panel()
		self._farfight_finish_red = {}

		if not self._farfight then
			self._farfight = self:loadUI("farfight")

			self._farfight._panel.transform:SetParent(self._control.background.transform.parent, false)

			self._canvas_groups.farfight = var_0_23.add_canvas_group_component_to_panel(self._farfight)
		end

		self._farfight:show()

		self._canvas_groups.farfight.alpha = 1
		self._canvas_groups.farfight.blocksRaycasts = true
		self._chapter_scroll_view_control = self:__load_chapter_scroll_view(function(arg_97_0)
			self._farfight:update_content(arg_97_0)
		end)

		local var_96_0
		local var_96_1 = 0

		for iter_96_0, iter_96_1 in pairs(self._farfight_finish_red) do
			var_96_1 = var_96_1 + 1
		end

		if var_96_1 ~= 0 then
			for iter_96_2, iter_96_3 in pairs(self._farfight_finish_red) do
				if iter_96_3 == true then
					var_96_0 = iter_96_2

					local var_96_2 = self._chapter_scroll_view_control.curve_scroll_rect:GetComponent("CurveScrollRect")

					var_96_2.vertical = false

					var_96_2:JumpToItem(var_96_0)

					var_96_2.vertical = true

					break
				end
			end
		else
			var_96_0 = self._current_far_toggle_index
		end

		self._farfight:update_content(var_96_0)
	end

	function arg_1_0:__hide_farfight_panel()
		if self._chapter_scroll_view_control then
			self._chapter_scroll_view_control.curve_scroll_rect.curveScrollRect.onItemSelect:RemoveAllListeners()
		end

		if not self._farfight then
			return
		end

		self._canvas_groups.farfight.alpha = 0
		self._canvas_groups.farfight.blocksRaycasts = false
		self._curr_set_chapter_index = -1
	end

	function arg_1_0:__init_campaign_panel()
		if not self._campaign then
			self._campaign = self:loadUI("campaign")

			self._campaign._panel.transform:SetParent(self._control.background.transform.parent, false)

			self._canvas_groups.campaign = var_0_23.add_canvas_group_component_to_panel(self._campaign)
		end

		self._campaign:show((var_0_3:get_campaign_difficulty()))

		self._canvas_groups.campaign.alpha = 1
		self._canvas_groups.campaign.blocksRaycasts = true
	end

	function arg_1_0:__update_campaign_panel_type()
		if not self._campaign then
			return
		end

		self._campaign:__update_panel_type()
	end

	function arg_1_0:__hide_campaign_panel()
		if not self._campaign then
			return
		end

		self._campaign:setVisible(false)

		self._canvas_groups.campaign.blocksRaycasts = false
	end

	function arg_1_0:__init_active_panel()
		if not self._active_info then
			self._active_info = self:loadUI("active_info")

			self._active_info._panel.transform:SetParent(self._control.top_menu.transform, false)

			self._canvas_groups.active_info = var_0_23.add_canvas_group_component_to_panel(self._active_info)
		end

		self._active_info:show()

		self._canvas_groups.active_info.alpha = 1
		self._canvas_groups.active_info.blocksRaycasts = true
	end

	function arg_1_0:__play_active_panel_in_animation()
		self._control.buttom_line.info_text:SetActive(false)

		if self._active_info and self._active_info._control.all_active.rectTransform then
			self._active_info._control.all_active.rectTransform.anchoredPosition = var_0_9(1250, -690)
			self._in_out_tweener1 = self._active_info._control.all_active.rectTransform:DOAnchorPos(var_0_9(-530, -690), 0.3):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0):SetAutoKill(true)
		end
	end

	function arg_1_0:__hide_active_info_panel()
		if not self._active_info then
			return
		end

		self._canvas_groups.active_info.alpha = 0
		self._canvas_groups.active_info.blocksRaycasts = false
	end

	function arg_1_0:_play_audio(arg_105_1)
		self:playBackgroundMusic(arg_105_1)
	end

	function arg_1_0:_play_into_se(arg_106_1)
		self:playSE(arg_106_1, false)
	end

	function arg_1_0.get_acticity_time(arg_107_0, arg_107_1)
		if arg_107_1.start_time == 0 or arg_107_1.end_time == 0 then
			return false
		end

		if lx.ServerTime:getUtcTime() > arg_107_1.start_time and lx.ServerTime:getUtcTime() < arg_107_1.end_time then
			return true
		end

		return false
	end

	function arg_1_0:__hide_gotofight_panel()
		if not self._map_scroll_view_control then
			if self._chapter_scroll_view_control then
				self._chapter_scroll_view_control.curve_scroll_rect.curveScrollRect.onItemSelect:RemoveAllListeners()
			end

			return
		end

		self._canvas_groups.gotofight.alpha = 0
		self._canvas_groups.gotofight.blocksRaycasts = false

		if self._chapter_scroll_view_control then
			self._chapter_scroll_view_control.curve_scroll_rect.curveScrollRect.onItemSelect:RemoveAllListeners()
		end

		self._curr_set_chapter_index = -1
	end

	function arg_1_0:__onReset()
		self:__clear_current_chapter_info()

		self._farfight_finish_red = {}
		self._current_toggle_index = 1

		for iter_109_0, iter_109_1 in pairs(self._light_seq_list) do
			iter_109_1:Kill()
		end

		self._light_seq_list = {}
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_110_0)
	local var_110_0 = var_0_2:class("gotofight")

	var_110_0._is_init_gotofight_panel = false
	var_110_0._from_home = nil
	var_110_0._current_toggle_index = 1
	var_110_0._ui_current_top_toggle_tag_name = nil
	var_110_0._in_out_tweener1 = nil
	var_110_0._in_out_tweener2 = nil
	var_110_0._chapter_scroll_view_control = nil
	var_110_0._map_scroll_view_control = nil
	var_110_0._exercise = nil
	var_110_0._farfight = nil
	var_110_0._campaign = nil
	var_110_0._active_info = nil
	var_110_0._obj_pool = {}
	var_110_0._time_execute_task_list = nil
	var_110_0._init_chapter_index = nil
	var_110_0._init_map_index = 1
	var_110_0._curr_set_chapter_index = -1
	var_110_0._mapItemControlList = nil
	var_110_0._current_far_toggle_index = nil
	var_110_0._is_open_init = nil
	var_110_0._difficulty = var_0_5.map_campaign_difficulty.normal
	var_110_0._farfight_finish_red = {}
	var_110_0._light_seq_list = {}

	return var_110_0
end

return var_0_0
