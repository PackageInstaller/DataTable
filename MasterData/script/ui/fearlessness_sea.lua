local var_0_0 = {}
local var_0_1 = lx.json_decode
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.Language
local var_0_4 = gamecore.UserDataManager
local var_0_5 = gamecore.user
local var_0_6 = gameconfig
local var_0_7 = gameenum.common_type
local var_0_8 = UnityEngine.Vector2
local var_0_9 = UnityEngine.Vector3
local var_0_10 = DG.Tweening.DOTween
local var_0_11 = gamecore.util_func
local var_0_12 = table.insert
local var_0_14 = string.format
local var_0_17 = gameconfig.ship_rule_config
local var_0_18 = gameconfig.equip_config
local var_0_20 = gameconfig.ship_pve_active_config
local var_0_21 = gameconfig.pve_active_map_config
local var_0_22 = gameconfig.pve_active_map_node_config
local var_0_23 = gameconfig.pevent_task_config
local var_0_24 = gameconfig.ship_config
local var_0_25 = gameconfig.chat_head_config
local var_0_26 = gameconfig.item_config
local var_0_27 = gameconfig.ship_cg_config

gamecore.UILoader:define("fearlessness_sea", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		if var_0_5:get_save_now_fear() then
			arg_2_2 = true
		end

		if arg_2_1 then
			self._active_id = arg_2_1
			self._active_config = var_0_20.find_object_by_id(self._active_id)
		else
			local var_2_0 = var_0_17.find_object_by_id(var_0_7.pve_init_active_id.fearlessness_event).content

			if var_2_0 and next(var_2_0) then
				self._active_id = var_2_0.activeId
				self._active_config = var_0_20.find_object_by_id(self._active_id)
			end
		end

		if arg_2_2 then
			self._is_hard = arg_2_2
		end

		var_0_5:set_fearlessness_is_hard(self._is_hard)
		var_0_5:set_goto_fear_sea(true)
		self:setVisible(true)
		self:__init_panel()
		self:__init_language()
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end

		if self._opean_random_buff == true then
			local var_3_0 = var_0_5:get_random_buff_time()
			local var_3_1 = lx.ServerTime:getUtcTime()

			if var_3_0 <= var_3_1 then
				self._control.map_preview.map_bg.random_buff_btn.Text:SetActive(false)

				self._control.map_preview.map_bg.random_buff_btn:GetComponent("Button").enabled = true
				self._control.map_preview.map_bg.random_buff_btn.image.sprite = self:loadSprite(var_0_7.push_refresh_random_white_image)
			else
				self._control.map_preview.map_bg.random_buff_btn.Text:SetActive(true)

				self._control.map_preview.map_bg.random_buff_btn:GetComponent("Button").enabled = false
				self._control.map_preview.map_bg.random_buff_btn.image.sprite = self:loadSprite(var_0_7.push_refresh_random_red_image)
				self._control.map_preview.map_bg.random_buff_btn.Text.text.text = var_0_11.secondsToTime_not_hour(var_3_0 - var_3_1)
			end
		end
	end

	function arg_1_0:pass_big_node(arg_4_1)
		self:__pass_big_node(arg_4_1)
	end

	function arg_1_0:open_hard_mode()
		self:__open_hard_mode()
	end

	function arg_1_0:__init_panel()
		if var_0_5:get_push_guide_state() == 0 then
			self:__onClick_bg_btns_explain_talk_btn()
		end

		self._control.bg.btns.special_task_btn:SetActive(false)

		self._user_data = var_0_5:get_use_info_data()

		if not self._alreay_init then
			self:_play_audio(var_0_7:get_audio_url(var_0_7.common_icon.music_path, self._active_config.bgm))

			self._alreay_init = true
		end

		self._control.push_guide.guidecontent.guidetext.text.text = string.gsub(var_0_3:convert_rich_text(self._active_config.desc), ";", "\n")
		self._control.push_guide.tip_layer.bg_container.title.text.text = var_0_3:getNowLang("activityinstruction")

		if self._active_config.movie_group_id and self._active_config.movie_group_id > 0 then
			self._control.bg.btns.story_btn:SetActive(true)
		else
			self._control.bg.btns.story_btn:SetActive(false)
		end

		self._control.obj_pool_root.canvasGroup.interactable = true
		self._open_hard = not self._is_hard and self:__pass_all_normal_map() or true

		if not self._is_hard then
			self._control.bg.title.text.text = self._active_config.title or self._active_config.hard_title
		end

		if not self._is_hard then
			self:__get_map_data()
		else
			self:__get_hard_map_data()
		end

		self._control.bg.mode_panel:SetActive(self._open_hard)

		local var_6_0

		for iter_6_0, iter_6_1 in pairs(self._map_levels_table) do
			var_6_0 = var_0_5:is_map_pass(iter_6_1.map_id)
		end

		if var_6_0 and self._open_hard then
			self._control.bg.mode_panel.normal_image:SetActive(self._is_hard)
			self._control.bg.mode_panel.hard_image:SetActive(not self._is_hard)
			self._control.bg.btns.special_task_btn:SetActive(self._is_hard)
		end

		self._control.bg.btns.special_task_btn:SetActive(self._is_hard)

		local var_6_1 = var_0_5:get_battle_info()
		local var_6_2 = 0

		if var_6_1 and next(var_6_1) and var_6_1.id then
			var_6_2 = var_6_1.id
		end

		if var_6_2 > 9000 then
			local var_6_4 = var_0_11.have_data(self._active_config.hardLevels, var_6_2)
		end

		if not var_0_5:get_clear_map_reward() and var_0_5:get_now_common_panel_state() == 2 then
			self:__onClick_bg_mode_panel_hard_image()
		end

		if var_0_5:get_save_now_fear() then
			self._control.bg.mode_panel.normal_image:SetActive(true)
			self._control.bg.mode_panel.hard_image:SetActive(false)
		end

		self:__destroy_pool()
		self:__set_map_bg_image()

		if self._map_init_lock < 0 then
			self:__get_node_data()

			self._map_init_lock = 0
		end

		self:__preload_map_fragment()
		self:__set_big_map_position()
		self:__first_enter_active()
	end

	function arg_1_0:__show_panel_buff_btn(arg_7_1)
		local var_7_0 = var_0_5:get_push_buff_list(arg_7_1)

		if var_7_0 and next(var_7_0) then
			local var_7_1 = 0

			for iter_7_0, iter_7_1 in pairs(var_7_0) do
				var_7_1 = iter_7_1.count + var_7_1
			end

			if var_7_1 >= 1 then
				self._control.bg.info_icon_btn:SetActive(true)
			else
				self._control.bg.info_icon_btn:SetActive(false)
			end
		end
	end

	function arg_1_0:__init_override()
		self._control.map_preview.map_bg.map_panel.map_node_root.transform:GetComponent("Canvas").sortingOrder = self._control.map_preview.transform:GetComponent("Canvas").sortingOrder + 1
	end

	function arg_1_0:__init_language()
		if self._init_language then
			return
		end

		self._control.map_preview.map_bg.confirm_btn.title.text.text = var_0_3:getNowLang("ui_4th_prepare")
		self._control.msg_panel.hard_tips.hard_tips_txt.text.text = var_0_3:getNowLang("ui_activityhardmodeopen")
		self._control.special_task_panel.special_task_bg.left.left_title_panel.title_txt.text.text = var_0_3:getNowLang("crrentownstar")
		self._control.special_task_panel.special_task_bg.right.task_bg_title_txt.text.text = var_0_3:getNowLang("taskdestitle")
		self._control.special_task_panel.special_task_bg.right.task_aim_title_txt.text.text = var_0_3:getNowLang("tasktargettitle")
		self._control.special_task_panel.special_task_bg.right.task_reward_title_txt.text.text = var_0_3:getNowLang("taskrewardtitle")
		self._control.special_task_panel.special_task_bg.right.task_reward_txt.text.text = var_0_3:getNowLang("taskstar")
		self._control.special_task_panel.special_task_bg.right.task_reward_text.text.text = "(" .. var_0_3:getNowLang("questfinished") .. ")"
		self._init_language = true
	end

	function arg_1_0:__set_big_map_position()
		local var_10_0 = self:__check_pass_num()

		self._big_node_table = {}

		self:__set_big_arrow_position(var_10_0)

		for iter_10_0, iter_10_1 in ipairs(self._map_levels_table) do
			if var_10_0 < iter_10_0 then
				break
			end

			if iter_10_1.position then
				if iter_10_1.position[1].name == "y" then
					-- block empty
				else
					iter_10_1.position[1], iter_10_1.position[2] = iter_10_1.position[2], iter_10_1.position[1]
				end

				local var_10_1, var_10_2 = self:__load_map_fragment_with_pool("fearlessness_sea_enemy_point", self._control.point_panel.transform)

				var_10_1:setVisible(true)
				var_0_12(self._big_node_table, var_10_2)

				var_10_2.point.rectTransform.parent.offsetMin = var_0_8(0, 0)
				var_10_2.point.rectTransform.parent.offsetMax = var_0_8(0, 0)
				var_10_2.point.rectTransform.parent.anchoredPosition = self:__get_big_real_node_pos(self._control.bg.rectTransform.rect.width, self._control.bg.rectTransform.rect.height, iter_10_1.position[2].value, -iter_10_1.position[1].value, true)
				var_10_2.btn.button.interactable = true

				var_10_2.btn.button.onClick:RemoveAllListeners()
				var_10_2.btn.button.onClick:AddListener(function()
					self:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.open))
					self:show_map_info(iter_10_1)
				end)

				local var_10_3 = var_0_5:is_map_pass(iter_10_1.map_id)

				var_10_2.enmey_bg.image.sprite = not var_10_3 and self:loadSprite(var_0_14(var_0_7.fearlessness_sea_big_boss, iter_10_1.boss_id)) or self:loadSprite(var_0_14(var_0_7.fearlessness_sea_big_boss_b, iter_10_1.boss_id))

				var_10_2.point:SetActive(not var_10_3)
				var_10_2.point_fail:SetActive(var_10_3)
				var_10_2.blood_bg:SetActive(not var_10_3)

				if not var_10_3 then
					local var_10_4 = var_0_5:get_map_list()[iter_10_1.id]

					if var_10_4 then
						var_10_2.blood_bg.blood_image.image.fillAmount = (var_10_4.hp + var_10_4.hp2) / (iter_10_1.hp + iter_10_1.hp2) or 1
					end
				end
			end
		end
	end

	function arg_1_0:show_map_info(arg_12_1)
		self._curr_tmp_map_data = arg_12_1

		self:__set_mini_map_data(arg_12_1)
		self:__set_node_data_by_map(self._map_node_table[arg_12_1.id], nil, arg_12_1.id)
		var_0_5:set_map_random_buff_info(self._map_node_table[arg_12_1.id], arg_12_1.id)
		self._control.map_preview:SetActive(true)
		self._control.back_image:SetActive(true)
		self:_have_random_buff_btn(arg_12_1)

		local var_12_0 = self:autoKillDOTween(var_0_10.Sequence())

		var_12_0:Append(self._control.map_preview.map_bg.transform:DOScale(0, 0))
		var_12_0:Append(self._control.map_preview.map_bg.transform:DOScale(1, 0.3):SetEase(DG.Tweening.Ease.OutBack)):OnComplete(function()
			local var_13_0 = var_0_5:get_account_id()
			local var_13_1 = tonumber(var_0_4:getDataByID(var_0_14("is_first_station_%d", arg_12_1.map_id), var_13_0))

			if var_13_1 and arg_12_1.map_id == var_13_1 then
				var_0_2:destroyInstance("suppress_msg")
				var_0_2:createInstance("suppress_msg"):show("suppressed", nil, 1.5, true)
				var_0_4:setDataByID(var_0_14("is_first_station_%d", arg_12_1.map_id), var_13_0, "have_show")
			end
		end)

		self._now_little_map_id = arg_12_1.id
	end

	function arg_1_0:__set_big_arrow_position(arg_14_1)
		for iter_14_0, iter_14_1 in ipairs(self._map_levels_table) do
			if arg_14_1 < iter_14_0 then
				break
			end

			for iter_14_2, iter_14_3 in pairs(iter_14_1.arrow) do
				local var_14_0, var_14_1 = self:__load_map_fragment_with_pool("map_line_obj", self._control.point_line_panel.transform)

				var_14_0:setVisible(true)

				var_14_1.line_image.rectTransform.parent.offsetMin = var_0_8(0, 0)
				var_14_1.line_image.rectTransform.parent.offsetMax = var_0_8(0, 0)
				var_14_1.line_image.transform.localScale = var_0_9(1, 1, 1)

				local var_14_2 = self:__get_big_real_node_pos(self._control.bg.rectTransform.rect.width, self._control.bg.rectTransform.rect.height, iter_14_1.arrow[iter_14_2].x, -iter_14_1.arrow[iter_14_2].y, true)

				var_14_1.line_image.rectTransform.parent.anchoredPosition = var_0_8(var_14_2.x, var_14_2.y)
				var_14_1.line_image.image.sprite = self:loadSprite((string.format(var_0_7.fearlessness_sea_big_map, string.lower(iter_14_1.id), tostring(iter_14_2))))

				var_14_1.line_image.image:SetNativeSize()
			end
		end
	end

	function arg_1_0:__set_mini_map_data(arg_15_1)
		local var_15_0 = self._control.map_preview.map_bg

		self._control.map_preview.map_bg.map_panel.map_image.image.sprite = self:loadSprite(string.format(var_0_7.map_path, arg_15_1.id, arg_15_1.id))
		var_15_0.title_bg.title_txt.text.text = arg_15_1.title .. " " .. arg_15_1.sub_title
		var_15_0.boss_panel.boss_bg.image.sprite = self:loadSprite(var_0_14(var_0_7.fearlessness_sea_enemy_bg, arg_15_1.boss_bg))

		local var_15_1 = var_0_5:is_map_pass(arg_15_1.map_id)

		var_15_0.boss_panel.boss_image.image.sprite = not var_15_1 and self:loadSprite(var_0_14(var_0_7.fearlessness_sea_node_boss, arg_15_1.boss_id)) or self:loadSprite(var_0_14(var_0_7.fearlessness_sea_node_boss_b, arg_15_1.boss_id))

		var_15_0.reward_panel.reward_icon.get_icon:SetActive(var_15_1)

		var_15_0.map_panel.pass_icon.pass_txt.text.text = var_0_3:getNowLang("ui_pvepassed")
		var_15_0.map_panel.buff_all_count.num_txt.text.text = var_0_5:get_push_info_coin()

		var_15_0.map_panel.pass_icon:SetActive(var_15_1)

		var_15_0.bottom_tips.tips_txt.text.text = var_0_3:convert_rich_text(arg_15_1.tips)

		if arg_15_1.award[1].id >= 10000000 then
			if arg_15_1.award[1].id % 100 == 21 then
				var_15_0.reward_panel.reward_icon_bg.image.sprite = self:loadSprite(var_0_14(var_0_7.equip_back.equip_back_normal, var_0_18.find_object_by_cid(arg_15_1.award[1].id).star))
				var_15_0.reward_panel.reward_icon.image.sprite = self:loadSprite(var_0_14(var_0_7.icon.item_icon, arg_15_1.award[1].id))
			elseif arg_15_1.award[1].id % 100 == 61 then
				var_15_0.reward_panel.reward_icon_bg.image.sprite = self:loadSprite(var_0_7.equip_quality_frame_s[5])
				var_15_0.reward_panel.reward_icon.image.sprite = self:loadSprite(var_0_14(var_0_7.icon.item_icon, arg_15_1.award[1].id))
			elseif arg_15_1.award[1].id % 100 ~= 11 and arg_15_1.award[1].id % 100 ~= 12 then
				if arg_15_1.award[1].id % 100 == 13 then
					var_15_0.reward_panel.reward_icon_bg.image.sprite = self:loadSprite(var_0_14(var_0_7.equip_back.equip_back_normal, var_0_24.find_object_by_cid(arg_15_1.award[1].id).star))
					var_15_0.reward_panel.reward_icon.image.sprite = self:loadSprite(var_0_14(var_0_7.icon.item_icon, arg_15_1.award[1].id))

					goto label_15_0
				end
			end
		end

		var_15_0.reward_panel.reward_icon_bg.image.sprite = self:loadSprite(var_0_7.equip_back_ground)
		var_15_0.reward_panel.reward_icon.image.sprite = self:loadSprite(var_0_14(var_0_7.icon.item_icon, arg_15_1.award[1].id))

		::label_15_0::

		self._current_reward_id = arg_15_1.award[1].id
		self._current_reward_count = arg_15_1.award[1].value
		var_15_0.reward_panel.reward_title.text.text = var_0_3:getNowLang("pveeventitemcanget")

		local var_15_2 = self:__update_boss_hp(arg_15_1)

		self._control.map_preview.map_bg.boss_panel.boss_head:SetActive(true)
		self._control.map_preview.map_bg.boss_panel.boss_hp_black:SetActive(var_15_2 ~= 0)
	end

	function arg_1_0:__set_node_data_by_map(arg_16_1, arg_16_2, arg_16_3)
		arg_16_2 = self._control.map_preview.map_bg.map_panel.map_node_root

		local var_16_0 = self._control.map_preview.map_bg.map_panel.rectTransform.rect.width
		local var_16_1 = self._control.map_preview.map_bg.map_panel.rectTransform.rect.height
		local var_16_2 = {}

		for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
			if iter_16_1.node_miss and next(iter_16_1.node_miss) then
				for iter_16_2, iter_16_3 in pairs(iter_16_1.node_miss) do
					var_0_12(var_16_2, {
						hide_start_point = iter_16_1.id,
						hide_end_point = iter_16_2,
						hide_result = iter_16_3
					})
				end
			end
		end

		for iter_16_4, iter_16_5 in ipairs(arg_16_1) do
			local var_16_3, var_16_4 = self:__load_map_fragment_with_pool("map_node_obj", arg_16_2.transform)

			var_16_3:setVisible(true)

			var_16_4.node_image.rectTransform.parent.offsetMin = var_0_8(0, 0)
			var_16_4.node_image.rectTransform.parent.offsetMax = var_0_8(0, 0)
			var_16_4.node_image.rectTransform.anchoredPosition = self:__get_real_node_pos(var_16_0, var_16_1, iter_16_5.position.x, iter_16_5.position.y)

			local var_16_5
			local var_16_6 = 1
			local var_16_7 = false
			local var_16_8
			local var_16_9

			if iter_16_5.support_icon ~= 0 then
				local var_16_10 = var_0_6.support_atk_config.find_object_by_id(iter_16_5.support_icon)

				var_16_8 = var_0_5:get_map_node_pass_count(iter_16_5.pve_level_id, iter_16_5.id)
				var_16_5 = string.format((var_16_8 ~= 0 or nil) and (var_0_7.fight_point.support_icon_path_red or var_0_7.fight_point.support_icon_path_white), var_16_10.type)
				var_16_7 = true
			elseif iter_16_5.node_attribute == var_0_7.map_node_finish_type.init then
				var_16_5 = var_0_7.fight_point.pve_start_l
				var_16_6 = 2
			elseif iter_16_5.node_attribute == var_0_7.map_node_finish_type.boss_finish then
				if var_0_5:is_map_node_pass(iter_16_5.pve_level_id, iter_16_5.id) then
					var_16_5 = var_0_7.fight_point.pve_boss_l
					var_16_6 = 2
				else
					var_16_5 = var_0_7.fight_point.pve_boss
					var_16_6 = 1
				end
			elseif iter_16_5.node_type == var_0_7.map_node_type.reward then
				var_16_5 = var_0_5:is_map_node_pass(iter_16_5.pve_level_id, iter_16_5.id) and var_0_7.fight_point.pve_green or var_0_7.fight_point.pve_white
			elseif iter_16_5.node_type == var_0_7.map_node_type.loss then
				var_16_5 = var_0_5:is_map_node_pass(iter_16_5.pve_level_id, iter_16_5.id) and var_0_7.fight_point.pve_purple or var_0_7.fight_point.pve_white
			elseif iter_16_5.node_type == var_0_7.map_node_type.null then
				var_16_5 = var_0_5:is_map_node_pass(iter_16_5.pve_level_id, iter_16_5.id) and var_0_7.fight_point.pve_blue or var_0_7.fight_point.pve_white
			elseif iter_16_5.node_type == var_0_7.map_node_type.little_boss then
				self._little_boss_point_data = iter_16_5
				var_16_5 = var_0_5:is_map_node_pass(iter_16_5.pve_level_id, iter_16_5.id) and var_0_7.fight_point.pve_small_boss_l or var_0_7.fight_point.pve_small_boss

				local var_16_11 = var_16_4.node_image.guard_icon
				local var_16_12, var_16_13 = var_0_5:is_point_stationed(iter_16_5.id)

				self._current_station_team_id = var_16_13

				if var_16_12 then
					local var_16_14 = var_16_4.node_image.transform.localPosition

					var_16_11:SetActive(true)
					var_16_11.button.onClick:AddListener(function()
						local var_17_0 = string.sub(tostring(var_16_11.team_id.image.sprite), 16, 16)
						local var_17_1 = var_0_2:createInstance("captainroom_fleet")

						if not var_17_1 then
							return
						end

						var_17_1:show(var_0_3:getNowLang("ui_activitydefendfleet"), var_0_5:get_team_by_id(tonumber(var_17_0)).members, var_0_3:getNowLang("ui_activitydefendcancel"), "", function()
							local var_18_0 = var_0_2:getInstance("msgbox") or var_0_2:createInstance("msgbox")

							var_18_0:show(var_0_3:getNowLang("ui_activitydefendcanceltip"), function()
								var_18_0:setVisible(false)
								self._control.back_image:SetActive(false)
								var_0_5:req_StationPointExitReq(tonumber(var_17_0))
								var_0_2:destroyInstance("captainroom_fleet")
							end, function()
								var_18_0:setVisible(false)
							end, var_0_3:getNowLang("ui_activitydefendcancel"))
						end, true)
					end)

					local var_16_15 = iter_16_5.bubble_icon

					if iter_16_5.bubble_icon == 0 then
						var_16_15 = 1
					end

					var_16_11.image.sprite = self:loadSprite(string.format(var_0_7.guard_point.pve_node_guard, var_16_15))
					var_16_11.team_id.image.sprite = self:loadSprite(string.format(var_0_7.guard_point.pve_fleet_team, self._current_station_team_id))
					var_16_11.transform.localScale = var_0_9(1.38, 1.54, 1)

					local var_16_16 = var_0_9.zero
					local var_16_17 = var_0_9.zero

					if var_16_15 == 1 then
						var_16_16 = var_0_8(-10, -142)
						var_16_17 = var_0_8(0, -2.8)
					elseif var_16_15 == 2 then
						var_16_16 = var_0_8(-10, 0)
						var_16_17 = var_0_8(0, 6)
					elseif var_16_15 == 3 then
						var_16_16 = var_0_8(120, 0)
						var_16_17 = var_0_8(0, 6)
					elseif var_16_15 == 4 then
						var_16_16 = var_0_8(120, -142)
						var_16_17 = var_0_8(0, -2.8)
					end

					if (var_16_15 == 1 or var_16_15 == 2) and var_16_14.x < 60 then
						var_16_16.x = 10
					elseif (var_16_15 == 1 or var_16_15 == 4) and var_16_14.y <= -537 then
						var_16_16.y = -104
					end

					var_16_11.transform.anchoredPosition = var_16_16
					var_16_11.team_id.transform.anchoredPosition = var_16_17
				end
			else
				local var_16_18 = var_0_5:is_map_node_pass(iter_16_5.pve_level_id, iter_16_5.id)

				if var_16_18 and iter_16_5.node_type ~= 13 then
					var_16_5 = var_0_7.fight_point.pve_red
					var_16_9 = var_0_7.push_random_red_image
					var_16_6 = 2
				elseif var_16_18 == false and iter_16_5.node_type ~= 13 then
					var_16_5 = var_0_7.fight_point.pve_white
					var_16_9 = var_0_7.push_random_white_image
					var_16_6 = 1
				elseif var_16_18 and iter_16_5.node_type == 13 then
					var_16_5 = var_0_7.pve_buff_red
					var_16_9 = var_0_7.push_random_red_image
					var_16_6 = 1
				elseif var_16_18 == false and iter_16_5.node_type == 13 then
					var_16_5 = var_0_7.pve_buff_white
					var_16_9 = var_0_7.push_random_white_image
					var_16_6 = 1
				else
					var_16_9 = var_0_7.push_random_white_image
					var_16_5 = var_0_7.fight_point.pve_white
					var_16_6 = 1
				end
			end

			var_16_4.node_image.image.sprite = self:loadSprite(var_16_5)
			var_16_4.node_image.random_buff_icon.image.sprite = self:loadSprite(var_16_9)

			if var_16_7 then
				var_16_4.node_image.transform.gameObject:AddComponent(typeof(UnityEngine.UI.Button))

				var_16_4.node_image.image.raycastTarget = true

				var_16_4.node_image:GetComponent("Button").onClick:RemoveAllListeners()
				var_16_4.node_image:GetComponent("Button").onClick:AddListener(function()
					local var_21_0 = var_0_2:getInstance("suppress_msg")

					if not var_21_0 then
						var_21_0 = var_0_2:createInstance("suppress_msg")
					else
						var_0_2:destroyInstance("suppress_msg")

						var_21_0 = var_0_2:createInstance("suppress_msg")
					end

					if var_16_8 ~= 0 then
						var_21_0:show("suppressed", iter_16_5.pve_level_id, 1.5)
					else
						var_21_0:show("suppress", iter_16_5.pve_level_id, 1.5)
					end
				end)
			end

			var_16_4.node_image.image:SetNativeSize()

			local var_16_20

			if iter_16_5.flag and var_16_6 then
				var_16_20 = var_0_14(var_0_7.fearlessness_sea_node_letter, iter_16_5.flag .. var_16_6)
			end

			local var_16_22

			if iter_16_5.roundabout == 1 then
				var_16_22 = var_0_7.pve_g
			elseif iter_16_5.night_atk == 1 then
				var_16_22 = var_0_7.pve_night_atk_l
			elseif iter_16_5.node_type == 10 then
				var_16_22 = var_0_7.pve_air
			elseif iter_16_5.node_type == 11 then
				var_16_22 = var_0_7.pve_special_boss_l
			end

			if var_16_22 then
				var_16_4.night_atk_point.image.sprite = self:loadSprite(var_16_22)

				var_16_4.night_atk_point.image:SetNativeSize()
				var_16_4.night_atk_point:SetActive(true)

				var_16_4.night_atk_point.rectTransform.parent.offsetMin = var_0_8(0, 0)
				var_16_4.night_atk_point.rectTransform.parent.offsetMax = var_0_8(0, 0)
				var_16_4.night_atk_point.rectTransform.anchoredPosition = self:__get_real_node_pos(var_16_0, var_16_1, iter_16_5.position.x, iter_16_5.position.y)

				if iter_16_5.night_atk == 1 or iter_16_5.node_type == 10 or iter_16_5.node_type == 11 then
					local var_16_23 = true

					if iter_16_5.node_type == 11 then
						for iter_16_6, iter_16_7 in pairs(var_0_5:get_map_list()[iter_16_5.pve_level_id].pass_point) do
							if iter_16_5.id == iter_16_7.id then
								for iter_16_8, iter_16_9 in ipairs(iter_16_7.info) do
									if iter_16_9.grade > 2 then
										var_16_23 = false

										break
									end
								end
							end
						end
					end

					if var_16_23 then
						self._light_seq = self:autoKillDOTween(var_0_10.Sequence())

						self._light_seq:Append(var_16_4.night_atk_point.image:DOFade(0, 1))
						self._light_seq:Append(var_16_4.night_atk_point.image:DOFade(1, 1))
						self._light_seq:Append(var_16_4.night_atk_point.image:DOFade(1, 0))
						self._light_seq:SetLoops(-1)
						self._light_seq:Play()
					end
				end
			else
				var_16_4.night_atk_point:SetActive(false)
			end

			var_16_4.node_image.random_buff_icon:SetActive(false)

			local var_16_24 = {}

			for iter_16_10, iter_16_11 in pairs(var_16_2) do
				if iter_16_11.hide_start_point == iter_16_5.id then
					for iter_16_12, iter_16_13 in pairs(iter_16_11.hide_result) do
						local var_16_26 = var_0_22.find_object_by_id(tonumber(iter_16_12))

						if var_0_5:is_map_node_pass_b_and_b_up(var_16_26.pve_level_id, var_16_26.id) and iter_16_13 <= var_0_5:get_map_node_pass_count(var_16_26.pve_level_id, var_16_26.id) then
							for iter_16_14, iter_16_15 in pairs(iter_16_5.next_node) do
								if iter_16_15 == tonumber(iter_16_11.hide_end_point) then
									var_0_12(var_16_24, iter_16_15)
								end
							end
						end
					end
				end
			end

			local var_16_27 = {}
			local var_16_28 = true

			if iter_16_5.node_hide and next(iter_16_5.node_hide) then
				for iter_16_16, iter_16_17 in pairs(iter_16_5.node_hide) do
					for iter_16_18, iter_16_19 in pairs(iter_16_5.next_node) do
						if tonumber(iter_16_16) == iter_16_19 then
							for iter_16_20, iter_16_21 in pairs(iter_16_17) do
								local var_16_30 = var_0_22.find_object_by_id(tonumber(iter_16_21))
								local var_16_31 = var_0_5:is_map_node_pass_b_and_b_up(var_16_30.pve_level_id, var_16_30.id)
								local var_16_32

								if not var_16_31 then
									var_16_28 = false
									var_16_32 = {
										is_show_true = var_16_28
									}
								end

								var_16_32.node_flag = var_0_22.find_object_by_id(tonumber(iter_16_16)).flag
								var_16_32.is_pass = var_16_31

								var_0_12(var_16_27, var_16_32)
							end
						end
					end
				end
			end

			if iter_16_5.next_node_path ~= "{}" then
				for iter_16_22, iter_16_23 in pairs((var_0_1(iter_16_5.next_node_path))) do
					local var_16_34, var_16_35 = self:__load_map_fragment_with_pool("map_line_obj", arg_16_2.transform)

					var_16_34:setVisible(true)

					var_16_35.line_image.rectTransform.parent.offsetMin = var_0_8(0, 0)
					var_16_35.line_image.rectTransform.parent.offsetMax = var_0_8(0, 0)
					var_16_35.line_image.rectTransform.anchoredPosition = self:__get_real_node_pos(var_16_0, var_16_1, iter_16_23.x, iter_16_23.y)
					var_16_35.line_image.image.sprite = self:loadSprite((string.format(var_0_7.mapline_path, string.lower(arg_16_3), iter_16_22)))
					var_16_35.line_image.transform.localScale = var_0_9(0.75, 0.75, 1)

					var_16_35.line_image.image:SetNativeSize()
					var_16_35.line_image:SetActive(true)

					var_16_35.line_image.image.color = UnityEngine.Color(1, 1, 1, 1)

					local var_16_36 = lx.split(iter_16_22, "-")

					if next(var_16_27) then
						if #var_16_27 == 1 then
							for iter_16_24, iter_16_25 in pairs(var_16_27) do
								if var_16_27[iter_16_24].node_flag == var_16_36[3] then
									var_16_35.line_image.image.color = var_16_27[iter_16_24].is_show_true and UnityEngine.Color(1, 1, 1, 1) or UnityEngine.Color(1, 1, 1, 0.2)
								end
							end
						else
							for iter_16_26, iter_16_27 in pairs(var_16_27) do
								if var_16_27[iter_16_26].node_flag == var_16_36[3] then
									var_16_35.line_image.image.color = var_16_27[iter_16_26].is_pass and UnityEngine.Color(1, 1, 1, 1) or UnityEngine.Color(1, 1, 1, 0.2)
								end
							end
						end
					end

					if next(var_16_24) then
						for iter_16_28, iter_16_29 in pairs(var_16_24) do
							if var_0_14("%s-%s-%s", iter_16_5.pve_level_id, iter_16_5.flag, var_0_22.find_object_by_id(iter_16_29).flag) == iter_16_22 then
								var_16_35.line_image:SetActive(false)
							end
						end
					end
				end
			end

			for iter_16_30, iter_16_31 in pairs((var_0_5:get_push_random_buff())) do
				if iter_16_31.point_id == iter_16_5.id then
					var_16_4.node_image.random_buff_icon:SetActive(true)
				end
			end

			if #iter_16_5.flag > 0 then
				local var_16_37, var_16_38 = self:__load_map_fragment_with_pool("fearlessness_sea_letter_obj", arg_16_2.transform)

				var_16_37:setVisible(true)

				var_16_38.node_letter_image.rectTransform.parent.offsetMin = var_0_8(0, 0)
				var_16_38.node_letter_image.rectTransform.parent.offsetMax = var_0_8(0, 0)
				var_16_38.node_letter_image.rectTransform.anchoredPosition = var_16_4.node_image.rectTransform.anchoredPosition + var_0_8(18, 30)
				var_16_38.node_letter_image.image.sprite = self:loadSprite(var_16_20)
			end
		end
	end

	function arg_1_0:__update_boss_hp(arg_22_1)
		local var_22_0 = self._control.map_preview.map_bg.boss_panel.boss_hp_black
		local var_22_1 = var_0_5:get_map_list()[arg_22_1.id]
		local var_22_2

		if var_22_1 then
			var_22_2 = (var_22_1.hp + var_22_1.hp2) / (arg_22_1.hp + arg_22_1.hp2) or 1
		end

		var_22_0.boss_hp_bar.image.fillAmount = var_22_2

		if var_22_2 > 0 and var_22_2 < 0.01 and var_22_1.hp > 0 then
			var_22_2 = 0.01
		end

		var_22_0.hp_percent_num.text.text = var_0_14("%0.0f%s", var_22_2 * 100, "%")

		if var_22_2 == 0 then
			return 0
		end
	end

	function arg_1_0:__open_hard_mode()
		local var_23_0 = self._control.msg_panel.hard_tips

		self._control.msg_panel.hard_tips:SetActive(true)

		local var_23_1 = self:autoKillDOTween(var_0_10.Sequence())

		var_23_1:Append(self._control.msg_panel.hard_tips.bg.image:DOFade(0, 0))
		var_23_1:Insert(0, self._control.msg_panel.hard_tips.hard_tips_txt.transform:DOBlendableLocalMoveBy(var_0_9(700, 0, 0), 0))
		var_23_1:Insert(0, self._control.msg_panel.hard_tips.mode_start_pos.transform:DOBlendableLocalMoveBy(var_0_9(700, 0, 0), 0))
		var_23_1:Append(self._control.msg_panel.hard_tips.bg.image:DOFade(1, 1))
		var_23_1:Insert(0, self._control.msg_panel.hard_tips.hard_tips_txt.transform:DOBlendableLocalMoveBy(var_0_9(-700, 0, 0), 1))
		var_23_1:Insert(0, self._control.msg_panel.hard_tips.mode_start_pos.transform:DOBlendableLocalMoveBy(var_0_9(-700, 0, 0), 1))
		var_23_1:AppendInterval(2)
		var_23_1:Append(self._control.msg_panel.hard_tips.bg.image:DOFade(0, 1))
		var_23_1:Insert(3, self._control.msg_panel.hard_tips.hard_tips_txt.text:DOFade(0, 1))
		var_23_1:Insert(3, self._control.msg_panel.hard_tips.mode_start_pos.transform:DOMove(self._control.bg.mode_panel.hard_image.transform.position, 1):SetEase(DG.Tweening.Ease.Linear))
		var_23_1:OnComplete(function()
			self._control.bg.mode_panel:SetActive(true)
			self._control.bg.mode_panel.hard_image:SetActive(true)
			self._control.bg.mode_panel.normal_image:SetActive(false)
			var_23_0:SetActive(false)

			self._open_hard = true
			self._is_hard = true
		end)

		self._hard_tips_seq = var_23_1

		var_0_5:set_is_first_open_fearlessness_hard(false)
	end

	function arg_1_0:__change_hard_map(arg_25_1)
		self:__destroy_pool()

		if arg_25_1 then
			self:__get_hard_map_data()

			if self._map_init_lock < 1 then
				self:__get_node_data()

				self._map_init_lock = 1
			end
		else
			self:__get_map_data()
			self:__get_node_data()

			self._map_init_lock = 0
		end

		self._is_hard = arg_25_1

		if self._is_hard then
			self._control.bg.mode_panel.normal_image:SetActive(true)
			self._control.bg.mode_panel.hard_image:SetActive(false)
		else
			self._control.bg.mode_panel.normal_image:SetActive(false)
			self._control.bg.mode_panel.hard_image:SetActive(true)
		end

		self._control.bg.btns.special_task_btn:SetActive(self._is_hard)

		if not self._is_hard then
			self._control.bg.title.text.text = self._active_config.title or self._active_config.hard_title
		end

		self:__set_map_bg_image()
		self:__preload_map_fragment()
		self:__set_big_map_position()
		var_0_5:set_fearlessness_is_hard(self._is_hard)
	end

	function arg_1_0:__finish_special_task(arg_26_1)
		local var_26_0 = var_0_23.find_object_by_cid(arg_26_1)

		if not var_26_0 then
			return
		end

		local var_26_1 = self._control.msg_panel.finish_special_mission

		self._control.msg_panel.finish_special_mission:SetActive(true)

		var_26_1.map_title.text.text = var_26_0.sub_title
		var_26_1.task_title.text.text = var_26_0.title
		var_26_1.coin_num.text.text = var_26_0.award

		local var_26_2 = self:autoKillDOTween(var_0_10.Sequence())

		var_26_2:Append(var_26_1.transform:DOScaleY(0, 0))
		var_26_2:Append(var_26_1.transform:DOScaleY(1, 0.5))
		var_26_2:AppendInterval(3)
		var_26_2:Append(var_26_1.transform:DOScaleY(0, 0.5))
		var_26_2:OnKill(function()
			var_26_1:SetActive(false)
		end)

		self._special_task_seq = var_26_2

		var_0_5:set_open_fearless_sea_panel(false, nil)
	end

	function arg_1_0:__destroy_seq()
		if self._hard_tips_seq and self._hard_tips_seq:IsPlaying() then
			self._hard_tips_seq:Kill()
		end

		if self._special_task_seq and self._special_task_seq:IsPlaying() then
			self._special_task_seq:Kill()
		end
	end

	function arg_1_0:__preload_map_fragment()
		self._obj_pool = {}

		for iter_29_0, iter_29_1 in ipairs({
			{
				preload_count = 10,
				preload_obj_name = "fearlessness_sea_enemy_point"
			},
			{
				preload_count = 10,
				preload_obj_name = "map_line_obj"
			},
			{
				preload_count = 10,
				preload_obj_name = "map_node_obj"
			},
			{
				preload_count = 10,
				preload_obj_name = "fearlessness_sea_letter_obj"
			}
		}) do
			self._obj_pool[iter_29_1.preload_obj_name] = {}

			for iter_29_2 = 1, iter_29_1.preload_count do
				local var_29_0, var_29_1 = self:loadUIPrefab(iter_29_1.preload_obj_name, self._control.obj_pool_root.transform)

				var_29_0:setVisible(true)

				self._obj_pool[iter_29_1.preload_obj_name][#self._obj_pool[iter_29_1.preload_obj_name] + 1] = {
					using = false,
					prefabObj = var_29_0,
					prefabContorl = var_29_1
				}
			end
		end
	end

	function arg_1_0:__load_map_fragment_with_pool(arg_30_1, arg_30_2)
		local var_30_0 = false
		local var_30_1

		for iter_30_0, iter_30_1 in ipairs(self._obj_pool[arg_30_1]) do
			if iter_30_1.using == false then
				var_30_0 = true
				var_30_1 = self._obj_pool[arg_30_1][iter_30_0]

				break
			end
		end

		if var_30_0 and var_30_1.prefabObj._panel then
			var_30_1.using = true

			var_30_1.prefabObj._panel.transform:SetParent(arg_30_2)

			return var_30_1.prefabObj, var_30_1.prefabContorl
		else
			local var_30_2, var_30_3 = self:loadUIPrefab(arg_30_1, arg_30_2)

			self._obj_pool[arg_30_1][#self._obj_pool[arg_30_1] + 1] = {
				using = true,
				prefabObj = var_30_2,
				prefabContorl = var_30_3
			}

			return var_30_2, var_30_3
		end
	end

	function arg_1_0:__return_pool(arg_31_1)
		for iter_31_0 = 0, arg_31_1.childCount - 1 do
			arg_31_1:GetChild(0):SetParent(self._control.obj_pool_root.transform)
		end
	end

	function arg_1_0:__hide_all_mini_map_fragment_to_pool()
		for iter_32_0, iter_32_1 in pairs(self._obj_pool) do
			for iter_32_2, iter_32_3 in ipairs(iter_32_1) do
				if iter_32_3.using and iter_32_0 ~= "fearlessness_sea_enemy_point" and iter_32_3.prefabContorl.node_image then
					iter_32_3.prefabContorl.node_image.guard_icon:SetActive(false)
					iter_32_3.prefabObj._panel.transform:SetParent(self._control.obj_pool_root.transform, false)

					iter_32_3.using = false
				end
			end
		end
	end

	function arg_1_0:__destroy_pool()
		if self._obj_pool and #self._obj_pool > 0 then
			for iter_33_0, iter_33_1 in pairs(self._obj_pool) do
				for iter_33_2, iter_33_3 in pairs(iter_33_1) do
					iter_33_3 = nil
				end
			end

			for iter_33_4, iter_33_5 in pairs(self._obj_pool) do
				iter_33_5 = nil
			end
		end

		self._obj_pool = nil
		self._showedMapIndexTb = nil

		if self._chapter_scroll_view_control then
			self._chapter_scroll_view_control.curve_scroll_rect.curveScrollRect.onItemSelect:RemoveAllListeners()
		end

		self._chapter_scroll_view_control = nil
		self._map_scroll_view_control = nil
		self._curr_set_chapter_index = -1

		self:destroyChildren("fearlessness_sea_enemy_point")
		self:destroyChildren("map_line_obj")
		self:destroyChildren("map_node_obj")
		self:destroyChildren("fearlessness_sea_letter_obj")
	end

	function arg_1_0:__get_map_data()
		self._map_levels_table = {}

		local var_34_0, var_34_1 = var_0_21.get_sequence()

		for iter_34_0, iter_34_1 in pairs(var_34_0) do
			for iter_34_2, iter_34_3 in pairs(self._active_config.levels) do
				if iter_34_3 == iter_34_1.map_id then
					var_0_12(self._map_levels_table, iter_34_1)
				end
			end
		end
	end

	function arg_1_0:__get_hard_map_data()
		self._map_levels_table = {}

		local var_35_0, var_35_1 = var_0_21.get_sequence()

		for iter_35_0, iter_35_1 in pairs(var_35_0) do
			for iter_35_2, iter_35_3 in pairs(self._active_config.hardLevels) do
				if iter_35_3 == iter_35_1.map_id then
					var_0_12(self._map_levels_table, iter_35_1)
				end
			end
		end
	end

	function arg_1_0:__get_node_data()
		self._map_node_table = {}

		local var_36_0, var_36_1 = var_0_22.get_sequence()

		for iter_36_0, iter_36_1 in pairs(var_36_0) do
			for iter_36_2, iter_36_3 in pairs(self._map_levels_table) do
				if iter_36_3.id == iter_36_1.pve_level_id then
					if self._map_node_table[iter_36_3.id] == nil then
						self._map_node_table[iter_36_3.id] = {}
					end

					var_0_12(self._map_node_table[iter_36_3.id], iter_36_1)
				end
			end
		end
	end

	function arg_1_0:__set_map_bg_image()
		if self._is_hard then
			self._control.big_map_bg.image.sprite = self:loadSprite(var_0_7.fearlessness_sea_back_ground_hard)
			self._control.bg.title_bg.image.sprite = self:loadSprite(var_0_7.fearlessness_sea_top_bg.hard)
		else
			self._control.big_map_bg.image.sprite = self:loadSprite(var_0_7.fearlessness_sea_back_ground)
			self._control.bg.title_bg.image.sprite = self:loadSprite(var_0_7.fearlessness_sea_top_bg.normal)
		end
	end

	function arg_1_0.__get_real_node_pos(arg_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4, arg_38_5)
		return var_0_8(arg_38_3 / 1280 * arg_38_1, not arg_38_5 and -1 * arg_38_4 / 720 * arg_38_2 or arg_38_4 / 960 * arg_38_2)
	end

	function arg_1_0.__get_big_real_node_pos(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4, arg_39_5)
		return var_0_8(arg_39_3 / 1280 * 1280, not arg_39_5 and -1 * arg_39_4 / 720 * 960 or arg_39_4 / 960 * 960)
	end

	function arg_1_0:__check_pass_num()
		self._show_big_map_num = self._is_hard and 0 or 1
		self._show_big_map_num = 1

		if not self._is_hard then
			for iter_40_0, iter_40_1 in ipairs(self._active_config.levels) do
				if var_0_5:is_quickly_map_pass(iter_40_1) and self._show_big_map_num < #self._active_config.levels then
					self._show_big_map_num = self._show_big_map_num + 1
				end
			end
		else
			for iter_40_2, iter_40_3 in ipairs(self._active_config.hardLevels) do
				if var_0_5:is_quickly_map_pass(iter_40_3) and self._show_big_map_num < #self._active_config.hardLevels then
					self._show_big_map_num = self._show_big_map_num + 1
				end
			end
		end

		if var_0_5:get_clear_map_reward() and self._is_first_open == -1 and not self.cur_open_hard and not self.cur_last_boss then
			self._is_first_open = 0
		end

		if self._is_first_open == 0 then
			self._show_big_map_num = self._show_big_map_num - 1
			self._is_first_open = 1
		elseif self._is_first_open == 1 then
			self._is_first_open = -1
		end

		return self._show_big_map_num
	end

	function arg_1_0:__pass_big_node(arg_41_1)
		local var_41_0

		for iter_41_0, iter_41_1 in ipairs((not self._is_hard or nil) and (self._active_config.levels or self._active_config.hardLevels)) do
			if iter_41_1 == arg_41_1 then
				var_41_0 = iter_41_0

				break
			end
		end

		if not var_41_0 then
			return
		end

		local var_41_1 = var_0_5:get_clear_map_reward()

		if not var_41_1 then
			return
		end

		self._control.reward_mask:SetActive(true)

		local var_41_2 = self:__get_award_type(arg_41_1)

		self._point_seq = self:autoKillDOTween(var_0_10.Sequence())

		if self._big_node_table[var_41_0] then
			self._big_node_table[var_41_0].enmey_bg.image.sprite = self:loadSprite(var_0_14(var_0_7.fearlessness_sea_big_boss, self._map_levels_table[var_41_0].boss_id))

			self._point_seq:Append(self._big_node_table[var_41_0].blood_bg.blood_image.image:DOFillAmount(0, 1))
			self._point_seq:InsertCallback(1, function()
				self._big_node_table[var_41_0].blood_bg:SetActive(false)
			end)

			if var_41_1 ~= nil then
				self._point_seq:Append(self._big_node_table[var_41_0].enmey_bg.transform:DOLocalRotate(var_0_9(0, 90, 0), 1))
				self._point_seq:InsertCallback(2, function()
					self._big_node_table[var_41_0].enmey_bg.image.sprite = self:loadSprite(var_0_14(var_0_7.fearlessness_sea_big_boss_b, self._map_levels_table[var_41_0].boss_id))

					var_0_2:createInstance("reward_tip"):show_map_pass(var_0_3:getNowLang("ui_activityworldpasstip"), self._map_levels_table[var_41_0].sub_title)
				end)
				self._point_seq:Append(self._big_node_table[var_41_0].enmey_bg.transform:DOBlendableLocalRotateBy(var_0_9(0, -90, 0), 1))
				self._point_seq:InsertCallback(3, function()
					self:__return_pool(self._control.point_panel.transform)
					self:__return_pool(self._control.point_panel.transform)
					self:__set_big_map_position()

					if not self._is_hard and self._show_big_map_num <= 6 then
						self._big_node_table[self._show_big_map_num].enmey_bg.transform:DOScale(0, 0)
						self._big_node_table[self._show_big_map_num].blood_bg.transform:DOScale(0, 0)
						self._big_node_table[self._show_big_map_num].enmey_bg.transform:DOScale(1, 1):SetEase(DG.Tweening.Ease.OutBounce)
						self._big_node_table[self._show_big_map_num].blood_bg.transform:DOScale(1, 1):SetEase(DG.Tweening.Ease.OutBounce)
					end

					if self._is_hard then
						self._big_node_table[self._show_big_map_num].enmey_bg.transform:DOScale(0, 0)
						self._big_node_table[self._show_big_map_num].blood_bg.transform:DOScale(0, 0)
						self._big_node_table[self._show_big_map_num].enmey_bg.transform:DOScale(1, 1):SetEase(DG.Tweening.Ease.OutBounce)
						self._big_node_table[self._show_big_map_num].blood_bg.transform:DOScale(1, 1):SetEase(DG.Tweening.Ease.OutBounce)
					end
				end)
			end

			self._point_seq:AppendInterval(3.5)
		end

		local var_41_3 = var_0_20.find_object_by_id((var_0_5:get_fearlessness_id()))

		self._point_seq:AppendCallback(function()
			self._control.reward_mask:SetActive(false)

			local var_45_0 = var_0_2:createInstance("reward_tip")

			if var_41_2 == var_0_7.reward_type.item then
				var_45_0:show_map_pass(var_0_3:getNowLang("logget"), (var_0_26.find_object_by_cid(self._current_reward_id) and var_0_26.find_object_by_cid(self._current_reward_id).title or " ") .. "*" .. self._current_reward_count)
			elseif var_41_2 == var_0_7.reward_type.cg then
				var_45_0:show_map_pass(var_0_3:getNowLang("logget"), var_0_27.find_object_by_cid(self._current_reward_id).title .. "*" .. self._current_reward_count)
			elseif var_41_2 == var_0_7.reward_type.head_icon then
				var_45_0:show_by_enter_type(var_0_25.find_object_by_cid(self._current_reward_id).icon, var_0_7.enter_get_ship_type.mail_new_head_award, function()
					if arg_41_1 == var_41_3.levels[#var_41_3.levels] then
						self:open_hard_mode()
					end
				end)
			elseif var_41_2 == var_0_7.reward_type.equipment or var_41_2 == var_0_7.reward_type.ship then
				self:setVisible(false)
				self:setVisible(true)

				local var_45_2 = var_0_5:get_clear_map_reward()

				if var_45_2 then
					var_0_2:createInstance("new_ship_or_equip"):show(true, var_45_2[1], var_0_7.enter_get_ship_type.up_award, function()
						var_0_5:set_clear_map_reward(nil)

						if arg_41_1 == var_41_3.levels[#var_41_3.levels] then
							self:open_hard_mode()
						end
					end)
				end
			end

			var_0_5:set_clear_map_reward(nil)
		end)

		if var_41_2 == var_0_7.reward_type.item then
			self._point_seq:AppendInterval(3.5)
			self._point_seq:AppendCallback(function()
				if arg_41_1 == var_41_3.levels[#var_41_3.levels] then
					self:open_hard_mode()
				end
			end)
		end
	end

	function arg_1_0:__pass_all_normal_map()
		for iter_49_0, iter_49_1 in pairs(self._active_config.levels) do
			if not var_0_5:is_map_pass(iter_49_1) then
				return false
			end
		end

		return true
	end

	function arg_1_0:__kill_all_tween()
		if self._point_seq then
			self._point_seq:Kill()

			self._point_seq = nil
		end
	end

	function arg_1_0:__show_special_task(arg_51_1)
		self._control.special_task_panel:SetActive(arg_51_1)

		if not arg_51_1 then
			return
		end

		self._control.special_task_panel.special_task_bg.left.left_title_panel.coin_num.text.text = self._user_data.exploit

		self:__init_cell()
		self:__update_cell_list()

		self._already_init = true
	end

	function arg_1_0:__init_cell()
		if self._already_init then
			return
		end

		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.special_task_panel.special_task_bg.left.all_task.viewport.content.endlessScrollView, self._control.special_task_panel.special_task_bg.left.all_task.viewport.content, "single_special_task", "fearlessness_sea")

		self._reusable_cell:init()
	end

	function arg_1_0:__update_cell_list()
		local var_53_0, var_53_1 = var_0_23.get_sequence()

		self._control.special_task_panel.special_task_bg.right.right_title_txt.text.text = var_53_0[1].title
		self._control.special_task_panel.special_task_bg.right.task_bg_txt.text.text = var_53_0[1].story
		self._control.special_task_panel.special_task_bg.right.task_aim_txt.text.text = var_0_3:convert_rich_text(var_53_0[1].condition_desc)
		self._control.special_task_panel.special_task_bg.right.task_reward_num.text.text = "X" .. var_53_0[1].award

		if var_0_5:get_special_task_by_id(var_53_0[1].cid).state == var_0_7.task_state.complete then
			self._control.special_task_panel.special_task_bg.right.task_reward_image:SetActive(true)
			self._control.special_task_panel.special_task_bg.right.task_reward_text:SetActive(true)
		else
			self._control.special_task_panel.special_task_bg.right.task_reward_image:SetActive(false)
			self._control.special_task_panel.special_task_bg.right.task_reward_text:SetActive(false)
		end

		self._reusable_cell:set_data(var_53_0)

		function self._reusable_cell:_set_func(arg_54_1)
			local var_54_0 = var_0_5:get_special_task_by_id(var_53_0[arg_54_1 + 1].cid)
			local var_54_1 = ""

			if var_54_0.state == var_0_7.task_state.complete then
				self.info_layer.complete_image:SetActive(true)

				var_54_1 = "_complete"
			else
				self.info_layer.complete_image:SetActive(false)
			end

			self.info_layer.bg.image.sprite = self:loadSprite(var_0_14(var_0_7.special_task_bg, var_54_1))
			self.info_layer.map_title_txt.text.text = var_53_0[arg_54_1 + 1].sub_title
			self.info_layer.task_txt.task_txt_1.text.text = var_53_0[arg_54_1 + 1].title

			self.info_layer.task_txt:GetComponent("TextHorizonScroller"):SetText(var_53_0[arg_54_1 + 1].title)
			self.select_layer.takeoff_btn.button.onClick:RemoveAllListeners()
			self.select_layer.takeoff_btn.button.onClick:AddListener(function()
				self._control.special_task_panel.special_task_bg.right.right_title_txt.text.text = var_53_0[arg_54_1 + 1].title
				self._control.special_task_panel.special_task_bg.right.task_bg_txt.text.text = var_53_0[arg_54_1 + 1].story
				self._control.special_task_panel.special_task_bg.right.task_aim_txt.text.text = var_0_3:convert_rich_text(var_53_0[arg_54_1 + 1].condition_desc)
				self._control.special_task_panel.special_task_bg.right.task_reward_num.text.text = "X" .. var_53_0[arg_54_1 + 1].award
				var_54_0 = var_0_5:get_special_task_by_id(var_53_0[arg_54_1 + 1].cid)

				if var_54_0.state == var_0_7.task_state.complete then
					self._control.special_task_panel.special_task_bg.right.task_reward_image:SetActive(true)
					self._control.special_task_panel.special_task_bg.right.task_reward_text:SetActive(true)
				else
					self._control.special_task_panel.special_task_bg.right.task_reward_image:SetActive(false)
					self._control.special_task_panel.special_task_bg.right.task_reward_text:SetActive(false)
				end
			end)
		end
	end

	function arg_1_0:__show_award_detail()
		local var_56_0 = self:__get_award_type()

		if var_56_0 == var_0_7.reward_type.equipment then
			self:__show_equip_mask(true)

			self._equip_attr = self._equip_attr or self:loadUI("equip_attr")

			self._equip_attr._panel.transform:SetParent(self._panel.transform)
			self._equip_attr:show((var_0_18.find_object_by_cid(self._current_reward_id)))
		elseif var_56_0 == var_0_7.reward_type.ship then
			var_0_2:createInstance("ship_detail"):show(var_0_7.enter_ship_detail_type.bootyshop, (var_0_24.find_object_by_cid(self._current_reward_id)))
		elseif var_56_0 == var_0_7.reward_type.item then
			var_0_2:createInstance("specificdetails"):show(self._current_reward_id, var_0_7.enter_icon_detail_type.bootyshop_item)
		elseif var_56_0 == var_0_7.reward_type.cg then
			var_0_2:createInstance("specificdetails"):show(self._current_reward_id, var_0_7.enter_icon_detail_type.bootyshop_cg)

			return
		elseif var_56_0 == var_0_7.reward_type.head_icon then
			return
		end
	end

	function arg_1_0:__get_award_type(arg_57_1)
		if arg_57_1 then
			local var_57_0 = var_0_21.find_object_by_id(arg_57_1)

			self._current_reward_id = var_57_0.award[1].id
			self._current_reward_count = var_57_0.award[1].value
		end

		if self._current_reward_id >= 10000000 then
			if self._current_reward_id % 100 == 21 then
				return var_0_7.reward_type.equipment
			elseif self._current_reward_id % 100 == 11 or self._current_reward_id % 100 == 12 or self._current_reward_id % 100 == 13 then
				return var_0_7.reward_type.ship
			elseif self._current_reward_id % 100 == 61 then
				return var_0_7.reward_type.head_icon
			elseif self._current_reward_id % 100 == 71 then
				return var_0_7.reward_type.furniture
			end
		elseif self._current_reward_id % 100 == 81 then
			return var_0_7.reward_type.cg
		else
			return var_0_7.reward_type.item
		end
	end

	function arg_1_0:__show_equip_mask(arg_58_1)
		self._control.equip_mask:SetActive(arg_58_1)

		if self._equip_attr then
			self._equip_attr._panel:SetActive(arg_58_1)
		end
	end

	function arg_1_0.get_map_station_node(arg_59_0, arg_59_1)
		for iter_59_0, iter_59_1 in pairs((var_0_22.get_sequence())) do
			if iter_59_1.pve_level_id == arg_59_1 and iter_59_1.node_type == 7 then
				return iter_59_1.id
			end
		end

		return 0
	end

	function arg_1_0:close_map_preview()
		local var_60_0 = var_0_2:getInstance("suppress_msg")

		if var_60_0 then
			var_60_0:setVisible(false)
		end

		self:__hide_all_mini_map_fragment_to_pool()
		self._control.map_preview:SetActive(false)
	end

	function arg_1_0:_play_into_se(arg_61_1)
		self:playSE(arg_61_1, false)
	end

	function arg_1_0:__first_enter_active()
		if var_0_5:is_map_pass(self._map_levels_table[1].id) then
			return
		end

		local var_62_0 = var_0_5:get_account_id()
		local var_62_1 = var_0_4:getDataByID("is_first_enter_fearlessness_sea", var_62_0)

		if not var_62_1 or var_62_1 == "" then
			self._big_node_table[1].enmey_bg.transform:DOScale(0, 0)
			self._big_node_table[1].blood_bg.transform:DOScale(0, 0)
			self._big_node_table[1].enmey_bg.transform:DOScale(1, 1):SetEase(DG.Tweening.Ease.OutBounce)
			self._big_node_table[1].blood_bg.transform:DOScale(1, 1):SetEase(DG.Tweening.Ease.OutBounce)
			var_0_4:setDataByID("is_first_enter_fearlessness_sea", var_62_0, "1")
		end
	end

	function arg_1_0:_play_audio(arg_63_1)
		self:playBackgroundMusic(arg_63_1)
	end

	function arg_1_0:_have_random_buff_btn(arg_64_1)
		self.map_id = arg_64_1.id

		if next(var_0_21.find_object_by_id(arg_64_1.id).rand_node) then
			self._control.map_preview.map_bg.random_buff_btn:SetActive(true)
		else
			self._control.map_preview.map_bg.random_buff_btn:SetActive(false)
		end

		local var_64_0 = var_0_5:get_fearlessness_update_buff_time()

		if var_64_0 and var_64_0 ~= 0 then
			self._control.map_preview.map_bg.random_buff_btn:SetActive(true)

			self._opean_random_buff = true
		else
			self._control.map_preview.map_bg.random_buff_btn:SetActive(false)

			self._opean_random_buff = false
		end
	end

	function arg_1_0:show_panel_special_task_btn()
		self._control.bg.btns.special_task_btn:SetActive((var_0_5:get_fearlessness_is_hard()))
	end

	function arg_1_0:__onReset()
		self._open_hard = false
		self._is_hard = false

		self._control.bg.mode_panel:SetActive(false)
		self._control.bg.mode_panel.hard_image:SetActive(false)
		self._control.bg.mode_panel.normal_image:SetActive(false)

		self._alreay_init = false
		self._little_boss_point_data = nil

		if self._light_seq then
			self._light_seq:Kill()

			self._light_seq = nil
		end
	end

	function arg_1_0:__tween_score_guide_ainimation_2(arg_67_1)
		local var_67_0 = self:autoKillDOTween(var_0_10.Sequence())
		local var_67_1 = self._control.push_guide

		if arg_67_1 then
			self._control.push_guide:SetActive(true)

			self._control.push_guide.transform.localScale = var_0_8.New(0.1, 0.1)

			var_67_0:Append(self._control.push_guide.transform:DOScale(1.1, 0.15)):SetEase(DG.Tweening.Ease.InOutElastic)
			var_67_0:Append(self._control.push_guide.transform:DOScale(1, 0.05)):SetEase(DG.Tweening.Ease.InOutQuad)
		else
			var_67_0:Append(self._control.push_guide.transform:DOScale(0.3, 0.2)):SetEase(DG.Tweening.Ease.InExpo)
			var_67_0:AppendCallback(function()
				var_67_1:SetActive(false)
			end)
			var_0_5:req_PushGuideReq()
		end

		var_67_0:Play()
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_69_0)
	local var_69_0 = var_0_2:class("fearlessness_sea")

	var_69_0._alreay_init = false
	var_69_0._showedMapIndexTb = {}
	var_69_0._init_language = false
	var_69_0._curr_tmp_map_data = nil
	var_69_0._show_big_map_num = 1
	var_69_0._active_id = 61
	var_69_0._active_config = nil
	var_69_0._open_hard = false
	var_69_0._is_hard = false
	var_69_0._reusable_cell = nil
	var_69_0._map_levels_table = {}
	var_69_0._map_node_table = {}
	var_69_0._big_node_table = {}
	var_69_0._current_reward_id = 0
	var_69_0._current_reward_count = 0
	var_69_0._equip_attr = nil
	var_69_0._map_init_lock = -1
	var_69_0._first_open_hard = false
	var_69_0._little_boss_point_data = nil
	var_69_0._current_station_team_id = 0
	var_69_0._is_first_open = -1
	var_69_0.cur_open_hard = false
	var_69_0.cur_last_boss = false
	var_69_0._opean_random_buff = false
	var_69_0.map_id = nil

	return var_69_0
end

return var_0_0
