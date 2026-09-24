local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type
local var_0_6 = gamecore.AudioManager
local var_0_7 = string.format
local var_0_8 = table.insert
local var_0_9 = DG.Tweening.DOTween
local var_0_10 = UnityEngine.Vector2
local var_0_11 = UnityEngine.Vector3
local var_0_12 = gamecore.util_func
local var_0_13 = gameconfig.ship_pve_active_config
local var_0_14 = gameconfig.pve_fifth_level_config
local var_0_15 = gameconfig.fifth_map_node_config
local var_0_16 = gameconfig.pve_fifth_award_config

gamecore.UILoader:define("fifth_event", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)

		self._is_draw_joy_map = false

		self:__init_panel()
	end

	function arg_1_0:play_video(arg_3_1)
		self._control.play_video:SetActive(true)

		self._control.play_video.videoPlayer.targetCamera = var_0_12.get_ui_camera()

		self._control.play_video.videoPlayer:SetTargetAudioSource(0, self._control.play_video.audioSource)

		self._control.play_video.videoPlayer.clip = self:loadVideoClip(arg_3_1)

		self._control.play_video.videoPlayer:Play()
		var_0_6:pauseAll()

		self._control.play_video.videoPlayer.loopPointReached = self._control.play_video.videoPlayer.loopPointReached + function(arg_4_0)
			self._control.play_video:SetActive(false)
			var_0_6:resumeAll()
		end
	end

	function arg_1_0:__preload_map_fragment()
		self._obj_pool = {}

		for iter_5_0, iter_5_1 in ipairs({
			{
				preload_count = 15,
				preload_obj_name = "fifth_main_node"
			},
			{
				preload_count = 15,
				preload_obj_name = "fifth_line"
			},
			{
				preload_count = 4,
				preload_obj_name = "fifth_joy_node"
			},
			{
				preload_count = 10,
				preload_obj_name = "fearlessness_sea_enemy_point"
			}
		}) do
			self._obj_pool[iter_5_1.preload_obj_name] = {}

			for iter_5_2 = 1, iter_5_1.preload_count do
				local var_5_0, var_5_1 = self:loadUIPrefab(iter_5_1.preload_obj_name, self._control.obj_pool_root.transform)

				var_5_0:setVisible(true)

				self._obj_pool[iter_5_1.preload_obj_name][#self._obj_pool[iter_5_1.preload_obj_name] + 1] = {
					using = false,
					prefabObj = var_5_0,
					prefabContorl = var_5_1
				}
			end
		end
	end

	function arg_1_0:__load_map_fragment_with_pool(arg_6_1, arg_6_2)
		local var_6_0 = false
		local var_6_1

		for iter_6_0, iter_6_1 in ipairs(self._obj_pool[arg_6_1]) do
			if iter_6_1.using == false then
				var_6_0 = true
				var_6_1 = self._obj_pool[arg_6_1][iter_6_0]

				break
			end
		end

		if var_6_0 then
			var_6_1.using = true

			var_6_1.prefabObj._panel.transform:SetParent(arg_6_2)
			var_6_1.prefabObj:setVisible(true)

			return var_6_1.prefabObj, var_6_1.prefabContorl
		else
			local var_6_2, var_6_3 = self:loadUIPrefab(arg_6_1, arg_6_2)

			self._obj_pool[arg_6_1][#self._obj_pool[arg_6_1] + 1] = {
				using = true,
				prefabObj = var_6_2,
				prefabContorl = var_6_3
			}

			var_6_2:setVisible(true)

			return var_6_2, var_6_3
		end
	end

	function arg_1_0:__hide_all_map_fragment_to_pool()
		for iter_7_0, iter_7_1 in pairs(self._obj_pool) do
			for iter_7_2, iter_7_3 in ipairs(iter_7_1) do
				if iter_7_3.using then
					iter_7_3.prefabObj._panel.transform:SetParent(self._control.obj_pool_root.transform)

					iter_7_3.using = false
				end
			end
		end
	end

	function arg_1_0:__destroy_pool()
		if self._obj_pool and #self._obj_pool > 0 then
			for iter_8_0, iter_8_1 in pairs(self._obj_pool) do
				for iter_8_2, iter_8_3 in pairs(iter_8_1) do
					iter_8_3 = nil
				end
			end

			for iter_8_4, iter_8_5 in pairs(self._obj_pool) do
				iter_8_5 = nil
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
		self:destroyChildren("fifth_main_node")
		self:destroyChildren("fifth_line")
		self:destroyChildren("fifth_joy_node")
	end

	function arg_1_0:__set_node(arg_9_1)
		local var_9_0 = 0.7
		local var_9_1 = 1
		local var_9_2 = 0.5098039215686274
		local var_9_3 = self._control.main.bottom.main.node_left.rectTransform.anchoredPosition.x
		local var_9_4 = self._control.main.bottom.main.node_right.rectTransform.anchoredPosition.x
		local var_9_5 = self._control.main.bg.main
		local var_9_6 = self._control.main.bottom.main.node
		local var_9_7 = self._control.main.bg.main.scrollview.scrollbar_horizontal.scrollbar.value

		if arg_9_1 then
			var_9_7 = arg_9_1
			self._control.main.bg.main.scrollview.viewport.content.rectTransform.anchoredPosition = var_0_10(arg_9_1 * (var_0_4.panel_resolution.x - self._control.main.bg.main.scrollview.viewport.content.map_content.rectTransform.sizeDelta.x), self._control.main.bg.main.scrollview.viewport.content.rectTransform.anchoredPosition.y)
		end

		var_9_5.left:SetActive(var_9_7 > 0.1)
		var_9_5.right:SetActive(var_9_7 < 0.9)

		local var_9_8 = 1

		if var_9_7 <= 0.5 then
			var_9_8 = 1 - var_9_7 * 2
		elseif var_9_7 > 0.5 then
			var_9_8 = var_9_7 * 2 - 1
		end

		var_9_6.rectTransform.localScale = var_0_11.one * (var_9_0 + var_9_8 * (1 - var_9_0))
		var_9_6.rectTransform.anchoredPosition = var_0_10(var_9_3 + (var_9_4 - var_9_3) * var_9_7, var_9_6.rectTransform.anchoredPosition.y)
		var_9_6.image.color = Color.New(1, 1, 1, var_9_2 + var_9_8 * (var_9_1 - var_9_2))
	end

	function arg_1_0:__draw_main_map()
		if self._is_draw_main_map then
			return
		end

		self._is_draw_main_map = true
	end

	function arg_1_0:__draw_joy_map()
		if self._is_draw_joy_map then
			return
		end

		self._is_draw_joy_map = true

		for iter_11_0, iter_11_1 in pairs(self._fifth_event_config.hardLevels) do
			local var_11_0 = var_0_14.find_object_by_id(iter_11_1)
			local var_11_1, var_11_2 = self:__load_map_fragment_with_pool("fifth_joy_node", self._control.main.bg.joy.joy_map.transform)
			local var_11_3 = var_0_3:get_joy_map_data(iter_11_1)

			if var_11_3 then
				var_11_0.hp = var_11_3.hp
				var_11_0.hp2 = var_11_3.hp2
				var_11_0.points_already_get_score = var_11_3.get
				var_11_0.already_get_score = self:__calcu_joy_point_score(var_11_3.get)
				var_11_0.love = var_0_3:get_concerto_info().love
			end

			var_11_2.map.rectTransform.parent.offsetMin = var_0_10(0, 0)
			var_11_2.map.rectTransform.parent.offsetMax = var_0_10(0, 0)
			var_11_2.map.image.sprite = self:loadSprite(var_0_7(var_0_4.fifth_event_const.joy_map_url, var_11_0.map_id))

			var_11_2.map.image:SetNativeSize()

			var_11_2.map.rectTransform.anchoredPosition = var_0_10(var_11_0.position.x, -1 * var_11_0.position.y)

			var_11_2.map.button.onClick:RemoveAllListeners()
			var_11_2.map.button.onClick:AddListener(function()
				self:__enter_preview_map(var_11_0)
			end)
		end
	end

	function arg_1_0.__calcu_joy_point_score(arg_13_0, arg_13_1)
		local var_13_0 = 0

		if arg_13_1 then
			for iter_13_0, iter_13_1 in pairs(arg_13_1) do
				if var_0_15.find_object_by_id(iter_13_1) then
					var_13_0 = var_13_0 + var_0_15.find_object_by_id(iter_13_1).score
				end
			end
		end

		return var_13_0
	end

	function arg_1_0.__set_control_layer(arg_14_0, arg_14_1, arg_14_2)
		arg_14_1.canvasGroup.alpha = arg_14_2 and 1 or 0
		arg_14_1.canvasGroup.interactable = arg_14_2
		arg_14_1.canvasGroup.blocksRaycasts = arg_14_2
	end

	function arg_1_0:__get_real_pos()
		return var_0_10(self._joy_btn_pos.center.x / 1280 * self._control.main.btn.joy_bg.rectTransform.rect.width, self._joy_btn_pos.center.y / 720 * self._control.main.btn.joy_bg.rectTransform.rect.height)
	end

	function arg_1_0:__addlistener_scrollbar_event()
		self._control.main.bg.main.scrollview.scrollbar_horizontal.scrollbar.onValueChanged:RemoveAllListeners()
		self._control.main.bg.main.scrollview.scrollbar_horizontal.scrollbar.onValueChanged:AddListener(function()
			self:__set_node()
		end)
		self:__set_node()
	end

	function arg_1_0:__change_btn_event(arg_18_1)
		self._is_hard = not arg_18_1

		if self._concerto_info.state then
			self._control.main.btn.joy_btn:SetActive(arg_18_1)
			self._control.main.btn.main_btn:SetActive(not arg_18_1)
		end

		local var_18_0

		if arg_18_1 then
			self._story_id = 1005
			var_18_0 = var_0_4.fifth_event_const.main
			var_18_0.money = self._concerto_info.point

			self:__draw_main_map()
		else
			self._story_id = 1008
			var_18_0 = var_0_4.fifth_event_const.joy
			var_18_0.money = self._concerto_info.recreation_point

			self:__draw_joy_map()
		end

		self:__set_control_layer(self._control.main.bg.main, arg_18_1)
		self:__set_control_layer(self._control.main.bg.joy, not arg_18_1)

		self._control.main.top.title_bg.image.sprite = self:loadSprite(var_18_0.title_bg)
		self._control.main.top.title.text.text = var_18_0.title_lan
		self._control.main.top.title.text.text = self._is_hard and self._fifth_event_config.hard_title or self._fifth_event_config.title
		self._control.main.top.money_bg.icon.image.sprite = self:loadSprite(var_18_0.money_icon)
		self._control.main.top.money_bg.count.text.text = tostring(var_18_0.money)

		self:__set_control_layer(self._control.main.bottom.main, arg_18_1)
		self:__set_control_layer(self._control.main.bottom.joy, not arg_18_1)
		self._control.main.top.btns.award:SetActive(arg_18_1)

		if arg_18_1 then
			self:check_main_reward()
		end

		self._now_is_main = arg_18_1
	end

	function arg_1_0:check_main_reward()
		if not self._reward_point_list then
			self._reward_point_list = {}

			for iter_19_0, iter_19_1 in ipairs((var_0_16.get_sequence())) do
				var_0_8(self._reward_point_list, iter_19_1.score)
			end
		end

		local var_19_0 = {}

		for iter_19_2, iter_19_3 in ipairs(self._concerto_info.reward or {}) do
			var_19_0[iter_19_3] = true
		end

		local var_19_1 = false

		for iter_19_4, iter_19_5 in ipairs(self._reward_point_list) do
			if iter_19_5 <= self._concerto_info.point and not var_19_0[iter_19_4] then
				var_19_1 = true

				break
			end
		end

		self._control.main.top.btns.award.tip:SetActive(var_19_1)
	end

	function arg_1_0:__enter_preview_map(arg_20_1)
		arg_20_1.is_main = self._now_is_main

		var_0_3:set_fifth_level_cfg(arg_20_1)
		var_0_2:createInstance("fifth_preview_map"):show()
	end

	function arg_1_0:__show_explain(arg_21_1)
		self._control.main.desc_panel:SetActive(arg_21_1)
	end

	function arg_1_0.__init_language(arg_22_0)
		return
	end

	function arg_1_0:__init_constant()
		self._fifth_event_config = var_0_13.find_object_by_id(var_0_4.pve_active_list.fifth_event)
		self._joy_btn_seq = self._control.main.btn.joy_btn.uITweenSequence
		self._joy_btn_pos = {
			center = var_0_10(640, 410),
			left = var_0_10(92, 124)
		}
		self._control.main.desc_panel.scroll_view.viewport.content.text.text = string.gsub(var_0_1:convert_rich_text(self._fifth_event_config.desc), ";", "\n")
		self._story_id = 1005
	end

	function arg_1_0:__first_unlock_joy()
		self:__set_control_layer(self._control.main.btn, self._concerto_info.state)

		if not self._concerto_info.state then
			return
		end

		local var_24_0 = var_0_3:is_first_open_joy()

		self._control.main.btn.joy_bg:SetActive(var_24_0)

		self._control.main.btn.joy_btn.rectTransform.anchoredPosition = self._joy_btn_pos.left

		if not var_24_0 then
			return
		end

		local var_24_1 = self:__get_real_pos()

		self._control.main.btn.joy_btn.uIMoveTweener.from = var_24_1
		self._control.main.btn.joy_btn.rectTransform.anchoredPosition = var_24_1

		var_0_4:play_in_out_animation(self._joy_btn_seq, true, function()
			var_0_4:play_in_out_animation(self._joy_btn_seq, false, function()
				self._control.main.btn.joy_bg:SetActive(false)
			end)
		end)
	end

	function arg_1_0:__init_panel()
		self._concerto_info = var_0_3:get_concerto_info()
		self._concerto_map_info = var_0_3:get_fifth_map_data()

		if not self._is_already_init then
			self:__init_language()
			self:__init_constant()
			self:__preload_map_fragment()
		end

		self:__first_unlock_joy()
		self:__addlistener_scrollbar_event()
		self:__change_btn_event(true)
		self:__get_map_data(self._fifth_event_config.levels, self._is_hard)
		self:__destroy_pool()
		self:__get_node_data()
		self:__preload_map_fragment()
		self:__set_big_map_position()

		if not self._is_hard then
			self:__set_main_ext_node_data()
		end

		self:__play_boss_ani_rotate()
		self:__play_boss_ani_jelly()

		self._is_already_init = true
	end

	function arg_1_0:__get_map_data(arg_28_1, arg_28_2)
		self._map_levels_table = {}
		self._main_map_ext_node = {}

		local var_28_0, var_28_1 = var_0_14.get_sequence()

		for iter_28_0, iter_28_1 in pairs(var_28_0) do
			for iter_28_2, iter_28_3 in pairs(arg_28_1) do
				if iter_28_3 == iter_28_1.map_id then
					var_0_8(self._map_levels_table, iter_28_1)
				end
			end
		end

		if not arg_28_2 then
			for iter_28_4, iter_28_5 in ipairs(self._map_levels_table) do
				for iter_28_6, iter_28_7 in ipairs(iter_28_5.branch_levels) do
					for iter_28_8, iter_28_9 in pairs(var_28_0) do
						if iter_28_9.map_id == iter_28_7 then
							if self._main_map_ext_node[iter_28_5.map_id] == nil then
								self._main_map_ext_node[iter_28_5.map_id] = {}
							end

							var_0_8(self._main_map_ext_node[iter_28_5.map_id], iter_28_9)
						end
					end
				end
			end
		end
	end

	function arg_1_0.__get_ext_node_in_branch_levels(arg_29_0, arg_29_1, arg_29_2)
		for iter_29_0, iter_29_1 in pairs(arg_29_1) do
			if arg_29_2 == iter_29_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_node_data()
		local var_30_0, var_30_1 = var_0_15.get_sequence()

		for iter_30_0, iter_30_1 in pairs(var_30_0) do
			for iter_30_2, iter_30_3 in pairs(self._map_levels_table) do
				if iter_30_3.id == iter_30_1.pve_level_id then
					if self._map_node_table[iter_30_3.id] == nil then
						self._map_node_table[iter_30_3.id] = {}
					end

					var_0_8(self._map_node_table[iter_30_3.id], iter_30_1)
				end
			end
		end
	end

	function arg_1_0.__set_map_bg_image(arg_31_0)
		return
	end

	function arg_1_0:__check_pass_num()
		self._show_big_map_num = 0

		for iter_32_0, iter_32_1 in pairs(self._fifth_event_config.levels) do
			for iter_32_2, iter_32_3 in pairs(self._map_levels_table) do
				if iter_32_1 == iter_32_3.id then
					self._show_big_map_num = self._show_big_map_num + 1

					break
				end
			end
		end

		return self._show_big_map_num
	end

	function arg_1_0:__set_big_map_position()
		self:__check_pass_num()

		self._big_node_table = {}

		for iter_33_0, iter_33_1 in ipairs(self._map_levels_table) do
			if iter_33_0 > self._show_big_map_num then
				break
			end

			if iter_33_1.position and self:__is_open_map(iter_33_1.id) then
				local var_33_0, var_33_1 = self:__load_map_fragment_with_pool("fearlessness_sea_enemy_point", self._control.main.bg.main.scrollview.viewport.content.map_content.transform)

				var_33_0:setVisible(true)
				var_0_8(self._big_node_table, iter_33_1.id, var_33_1)

				var_33_1.point.rectTransform.parent.offsetMin = var_0_10(0, 0)
				var_33_1.point.rectTransform.parent.offsetMax = var_0_10(0, 0)
				var_33_1.point.rectTransform.parent.anchoredPosition = var_0_10(iter_33_1.position.x, -iter_33_1.position.y)
				var_33_1.btn.button.interactable = true

				var_33_1.btn.button.onClick:RemoveAllListeners()
				var_33_1.btn.button.onClick:AddListener(function()
					self:__enter_preview_map(iter_33_1)
				end)

				var_33_1.enmey_bg.image.sprite = self:loadSprite(var_0_7(var_0_4.fearlessness_sea_big_boss, iter_33_1.boss_id))

				var_33_1.point:SetActive(is_pass)
				var_33_1.point_fail:SetActive(not is_pass)
				var_33_1.blood_bg:SetActive(not is_pass)
			end
		end
	end

	function arg_1_0:__set_main_ext_node_data()
		self._ext_node_table = {}

		for iter_35_0, iter_35_1 in pairs(self._main_map_ext_node) do
			local var_35_0 = {}

			for iter_35_2, iter_35_3 in ipairs(iter_35_1) do
				if iter_35_3.position and self:__is_open_map(iter_35_3.id) then
					local var_35_1, var_35_2 = self:__load_map_fragment_with_pool("fifth_main_node", self._control.main.bg.main.scrollview.viewport.content.map_content.transform)

					var_35_1:setVisible(true)
					var_0_8(var_35_0, var_35_2.bg)
					var_0_8(var_35_0, var_35_2.bg.node)

					var_35_2.bg.rectTransform.parent.offsetMin = var_0_10(0, 0)
					var_35_2.bg.rectTransform.parent.offsetMax = var_0_10(0, 0)
					var_35_2.bg.rectTransform.parent.anchoredPosition = var_0_10(iter_35_3.position.x, -iter_35_3.position.y)
					var_35_2.bg.button.interactable = true

					var_35_2.bg.button.onClick:RemoveAllListeners()
					var_35_2.bg.button.onClick:AddListener(function()
						self:__enter_preview_map(iter_35_3)

						self._current_map_index = iter_35_3.map_id
					end)

					var_35_2.bg.node.image.sprite = self:loadSprite(var_0_7(var_0_4.fifth_event_const.main_map_ext_node_bg, iter_35_3.small_level_icon))

					if #iter_35_3.line_position > 0 then
						local var_35_5, var_35_6 = self:__load_map_fragment_with_pool("fifth_line", self._control.main.bg.main.scrollview.viewport.content.map_content.transform)

						var_35_5:setVisible(true)
						var_0_8(var_35_0, var_35_6.line)

						var_35_6.line.rectTransform.parent.offsetMin = var_0_10(0, 0)
						var_35_6.line.rectTransform.parent.offsetMax = var_0_10(0, 0)
						var_35_6.line.transform.localScale = var_0_11(1, 1, 1)

						local var_35_7 = var_0_10(iter_35_3.line_position[1].x, iter_35_3.line_position[1].y)
						local var_35_8 = var_0_10(iter_35_3.line_position[2].x, iter_35_3.line_position[2].y)

						var_35_6.line.rectTransform.parent.anchoredPosition = var_0_10(var_35_7.x + 15, -var_35_7.y + 22)
						var_35_6.red_img.rectTransform.parent.anchoredPosition = var_0_10(var_35_8.x + 0, -var_35_8.y + 0)

						local var_35_9 = var_0_3:get_fifth_station(iter_35_3.id) ~= nil

						if var_35_9 then
							var_35_6.red_img.image.color = UnityEngine.Color(1, 1, 1, 1)
						end

						local var_35_10 = string.format(var_0_4.fifth_event_const.main_map_line, iter_35_3.title, (var_35_9 or nil) and (var_0_4.fifth_event_const.main_node_line_pass or var_0_4.fifth_event_const.main_node_line))
						local var_35_11 = self:loadSprite(var_35_10)

						var_35_6.line.image.sprite = self:loadSprite(var_35_10)

						var_35_6.line.image:SetNativeSize()

						var_35_5._panel.transform:GetComponent("RectTransform").sizeDelta = var_35_6.line.rectTransform.sizeDelta
					end
				end
			end

			var_0_8(self._ext_node_table, iter_35_0, var_35_0)
		end

		self:refresh_line_list()
	end

	function arg_1_0.__get_cur_map_boss(arg_37_0, arg_37_1)
		local var_37_0 = var_0_3:get_fifth_map_data(arg_37_1)
		local var_37_1 = var_0_14.find_object_by_id(arg_37_1)

		if not var_37_0 or not var_37_1 then
			return
		end

		local var_37_2 = 0

		for iter_37_0, iter_37_1 in pairs(var_0_3:get_fifth_station_info()) do
			var_37_2 = var_37_2 + 1
		end

		local var_37_3 = var_37_1.boss_id
		local var_37_4 = var_37_0.hp
		local var_37_5 = var_37_1.hp
		local var_37_6

		if var_37_1.hiddens then
			for iter_37_2, iter_37_3 in ipairs(var_37_1.hiddens) do
				if iter_37_3[1] == 0 and iter_37_3[2] == var_37_1.boss_id2 then
					if iter_37_3[3] <= var_37_2 then
						var_37_3 = var_37_1.boss_id2
						var_37_4 = var_37_0.hp2
						var_37_5 = var_37_1.hp2

						if iter_37_3[3] == var_37_2 then
							var_37_6 = true
						end

						break
					end
				end
			end
		end

		var_0_3:set_fifth_boss_info(var_37_1.boss_id, var_37_0.hp, var_37_1.hp)
		var_0_3:set_fifth_boss_info(var_37_1.boss_id2, var_37_0.hp2, var_37_1.hp2)
		var_0_3:set_fifth_cur_boss(arg_37_1, var_37_3, var_37_4, var_37_5)

		return var_37_6
	end

	function arg_1_0:__is_open_map(arg_38_1)
		for iter_38_0, iter_38_1 in pairs(self._concerto_map_info) do
			if iter_38_0 == arg_38_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:refresh_line_list()
		for iter_39_0, iter_39_1 in pairs(self._ext_node_table[9423]) do
			if self._current_map_index and iter_39_0 == (self._current_map_index - 9423) * 3 then
				local var_39_0 = var_0_3:get_fifth_station(self._current_map_index) ~= nil

				iter_39_1.transform.parent.transform:Find("red_img").transform:GetComponent("Image").color = not var_39_0 and UnityEngine.Color(1, 1, 1, 0) or UnityEngine.Color(1, 1, 1, 1)
				iter_39_1.image.sprite = self:loadSprite((string.format(var_0_4.fifth_event_const.main_map_line, var_0_14.find_object_by_id(self._current_map_index).title, (var_39_0 or nil) and (var_0_4.fifth_event_const.main_node_line_pass or var_0_4.fifth_event_const.main_node_line))))
			end
		end
	end

	function arg_1_0.__destroy_panel(arg_40_0)
		var_0_2:destroyInstance("fifth_event")
		var_0_2:destroyInstance("fifth_preview_map")
		var_0_2:destroyInstance("fifth_awardbox")
		var_0_2:createInstance("home"):show()
	end

	function arg_1_0:__play_boss_ani_jelly()
		for iter_41_0, iter_41_1 in pairs(self._big_node_table) do
			if var_0_3:is_fifth_new_boss(iter_41_0) then
				iter_41_1.enmey_bg.rectTransform.localScale = var_0_11(0, 0, 0)

				local var_41_0 = self:autoKillDOTween(var_0_9.Sequence())
				local var_41_1 = self:autoKillDOTween(var_0_9.Sequence())

				var_41_0:AppendInterval(0.2)

				for iter_41_2, iter_41_3 in ipairs(self._ext_node_table[iter_41_0]) do
					iter_41_3.image.color = UnityEngine.Color(1, 1, 1, 0)

					var_41_1:Insert(0.3, iter_41_3.image:DOFade(1, 0.3):SetEase(DG.Tweening.Ease.InQuad):SetAutoKill(true))
				end

				var_41_0:Append(iter_41_1.enmey_bg.rectTransform:DOScale(var_0_11(1, 1.5, 1), 0.1):SetEase(DG.Tweening.Ease.InOutBack):SetAutoKill(true))
				var_41_0:Append(iter_41_1.enmey_bg.rectTransform:DOScale(var_0_11(0.9, 0.9, 1), 0.1):SetEase(DG.Tweening.Ease.OutBack):SetAutoKill(true))
				var_41_0:Append(iter_41_1.enmey_bg.rectTransform:DOScale(var_0_11(1.1, 1.1, 1), 0.1):SetEase(DG.Tweening.Ease.OutBack):SetAutoKill(true))
				var_41_0:Append(iter_41_1.enmey_bg.rectTransform:DOScale(var_0_11(0.9, 0.9, 1), 0.1):SetEase(DG.Tweening.Ease.OutBack):SetAutoKill(true))
				var_41_0:Append(iter_41_1.enmey_bg.rectTransform:DOScale(var_0_11(1, 1, 1), 0.2):SetEase(DG.Tweening.Ease.OutBack):SetAutoKill(true))
				var_41_0:AppendCallback(function()
					var_0_3:req_ConcertoReadReq(iter_41_0)
					var_0_3:comp_fifth_new_boss(iter_41_0)
				end)
			end
		end
	end

	function arg_1_0:__play_boss_ani_rotate()
		for iter_43_0, iter_43_1 in pairs(self._big_node_table) do
			if not var_0_3:get_fifth_map_data(iter_43_0) then
				return
			end

			local var_43_0 = flase
			local var_43_2 = self:__get_cur_map_boss(iter_43_0)
			local var_43_3 = var_0_3:get_fifth_cur_boss(iter_43_0)
			local var_43_4 = self:loadSprite(var_0_7(var_0_4.fearlessness_sea_big_boss, var_43_3.id))

			if var_0_3:is_after_station(iter_43_0) and var_43_2 then
				var_43_0 = true
			elseif var_43_3.hp == 0 then
				if var_0_3:is_after_battle(iter_43_0) then
					var_43_0 = true
				end

				var_43_4 = self:loadSprite(var_0_7(var_0_4.fearlessness_sea_big_boss_b, var_43_3.id))
			end

			if var_43_0 then
				local var_43_5 = self:autoKillDOTween(var_0_9.Sequence())

				var_43_5:AppendInterval(0.1)
				var_43_5:Append(iter_43_1.enmey_bg.rectTransform:DOLocalRotate(var_0_11(0, 90, 0), 0.5):SetEase(DG.Tweening.Ease.InQuad):SetAutoKill(true))

				local var_43_6

				if var_43_4 then
					var_43_5:AppendCallback(function()
						iter_43_1.enmey_bg.image.sprite = var_43_4
					end)

					var_43_6 = iter_43_1.enmey_bg.rectTransform:DOLocalRotate(var_0_11(0, 0, 0), 0.5):SetEase(DG.Tweening.Ease.OutQuad)
				end

				var_43_5:Append(var_43_6:SetAutoKill(true))
				var_43_5:Append(iter_43_1.blood_bg.blood_image.image:DOFillAmount(var_43_3.hp / var_43_3.max_hp, 0.5):SetEase(DG.Tweening.Ease.OutQuad):SetAutoKill(true))
			else
				iter_43_1.enmey_bg.image.sprite = var_43_4
				iter_43_1.blood_bg.blood_image.image.fillAmount = math.floor(var_43_3.hp / var_43_3.max_hp)
			end
		end
	end

	function arg_1_0:check_comp_task()
		self._control.task.gameObject:SetActive(true)
		var_0_4:play_in_out_animation(self._control.task.content.uITweenSequence, true, function()
			local var_46_0 = self:autoKillDOTween(var_0_9.Sequence())

			var_46_0:AppendInterval(0.5)
			var_46_0:Append(self._control.task.content.rectTransform:DOScale(var_0_11(1, 0, 1), 0.5):SetAutoKill(true))
			var_46_0:AppendCallback(function()
				self._control.task.gameObject:SetActive(false)
			end)
		end)
	end

	function arg_1_0.__onReset(arg_48_0)
		arg_48_0._current_map_index = 0
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_49_0)
	local var_49_0 = var_0_2:class("fifth_event")

	var_49_0._is_already_init = false
	var_49_0._obj_pool = {}
	var_49_0._fifth_event_config = nil
	var_49_0._active_id = 31
	var_49_0._now_is_main = true
	var_49_0._story_id = nil
	var_49_0._map_node_table = {}
	var_49_0._show_big_map_num = 0
	var_49_0._big_node_table = {}
	var_49_0._ext_node_table = {}
	var_49_0._is_hard = false
	var_49_0._map_levels_table = {}
	var_49_0._main_map_ext_node = {}
	var_49_0._is_draw_joy_map = false
	var_49_0._current_map_index = 0

	gamecore.extend_obj(var_49_0)

	return var_49_0
end

return var_0_0
