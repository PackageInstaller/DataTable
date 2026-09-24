local var_0_0 = {}
local var_0_1 = next
local var_0_2 = gamecore.user
local var_0_3 = table.sort
local var_0_4 = table.insert
local var_0_5 = gamecore.Language
local var_0_6 = gamecore.UILoader
local var_0_7 = string.format
local var_0_8 = DG.Tweening.DOTween
local var_0_9 = UnityEngine.Vector2
local var_0_10 = gamecore.util_func
local var_0_11 = gameenum.common_type
local var_0_12 = gameconfig.ship_rule_config
local var_0_13 = gameconfig.strike_map_config
local var_0_14 = gameconfig.strike_buff_config
local var_0_15 = gameconfig.ship_pve_active_config
local var_0_16 = gameconfig.strike_map_node_config
local var_0_17 = gameconfig.cinema_story_id_list_config

gamecore.UILoader:define("strike_map", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3)
		self._pass_map = arg_2_3

		self:setVisible(true)
		self:_init_panel(arg_2_1, arg_2_2)
	end

	function arg_1_0:_init_panel(arg_3_1, arg_3_2)
		self:__initial_func()
		self:__init_data(arg_3_1, arg_3_2)
		self:__init_show(arg_3_1, arg_3_2)

		local var_3_0 = var_0_13.find_object_by_id(arg_3_1 or 0)

		if not self._already_init then
			if var_3_0 then
				self:_play_audio(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_3_0.music1))

				self._already_init = true
			else
				self:_play_audio(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_3_0.battle_event_twenty_two))

				self._already_init = true
			end
		end

		self._control.main.bottom.import_btn.text.text.text = var_0_5:getNowLang("pvecontinue")

		self._control.main.bottom.import_btn:SetActive(true)

		if not self._obj_pool or not var_0_1(self._obj_pool) then
			self:__preload_map_fragment()
			self:__set_node_data_by_map(self._strike_node_data[arg_3_1], arg_3_1)
			self:__set_node_path_visible()
		end

		if self.__btn_state == 1 then
			self:__init_buff_pos()
		end

		self:__init_ship_pos()
		var_0_2:set_strike_map_start_point(arg_3_1)
		self:__init_lock()
		self._control.strike_difficult:SetActive(false)
		self._control.npc:SetActive(false)
	end

	function arg_1_0.set_last_battle_grade(arg_4_0, arg_4_1)
		arg_4_0._last_battle_grade = arg_4_1
	end

	function arg_1_0.set_show_lock(arg_5_0, arg_5_1)
		arg_5_0._is_show_lock = arg_5_1
	end

	function arg_1_0.set_can_click(arg_6_0, arg_6_1)
		arg_6_0._can_click = arg_6_1
	end

	function arg_1_0:__init_data(arg_7_1, arg_7_2)
		self._map_id = arg_7_1
		self._map_data = var_0_13.find_object_by_id(arg_7_1)
		self._now_map_info = var_0_16.find_object_by_id(self._map_data.init_node_id)
		self._strike_info = var_0_2:get_strike_point_info()
		self.page_id = var_0_2:get_strike_page_id()
		self.config = var_0_2:get_strike_config()
		self.flag = var_0_2:get_strike_flag()

		var_0_2:set_strike_pass_buff(self._strike_info)

		self._hard_mode = var_0_2:get_strike_data_by_level(self._map_id).score >= self._map_data.hard_score

		self._control.main.top.return_btn:SetActive(true)
		self._control.main.back_image:SetActive(false)

		self._strike_map_finish = false

		if self._strike_info and var_0_1(self._strike_info) then
			var_0_2:set_user_strike_map_data(self._strike_info, self._hard_mode)
		else
			local var_7_0, var_7_1 = var_0_2:get_user_strike_map_data()

			self._strike_info = var_7_0
			self._hard_mode = var_7_1

			self._control.main.top.return_btn:SetActive(false)

			self._strike_map_finish = true
		end

		var_0_2:set_now_strike_first_node(self._map_data.init_node_id)
		var_0_2:set_now_strike_fight_node(self._strike_info.point_id)

		self._strike_node_data = {}
		self._node_data = var_0_16.get_sequence()

		for iter_7_0, iter_7_1 in pairs(self._node_data) do
			if iter_7_1.strike_id == arg_7_1 then
				if self._strike_node_data[arg_7_1] == nil then
					self._strike_node_data[arg_7_1] = {}
				end

				var_0_4(self._strike_node_data[arg_7_1], iter_7_1)
			end
		end

		self._active_config = var_0_15.find_object_by_id(var_0_11.pve_active_list.strike_event)

		self._control.strongattack.gameObject:SetActive(false)
	end

	function arg_1_0:__init_show(arg_8_1, arg_8_2)
		local var_8_0 = 0
		local var_8_1 = var_0_2:get_strike_map_panel_buff()

		if self._strike_info.buffs then
			for iter_8_0, iter_8_1 in pairs(self._strike_info.buffs) do
				var_8_0 = var_8_0 + iter_8_1.score
			end
		end

		if var_8_1 then
			for iter_8_2, iter_8_3 in pairs(var_8_1) do
				local var_8_2 = false

				if self._strike_info.buffs then
					for iter_8_4, iter_8_5 in pairs(self._strike_info.buffs) do
						if iter_8_5.id == iter_8_3.id then
							var_8_2 = true
						end
					end
				end

				if not var_8_2 then
					var_8_0 = var_8_0 + iter_8_3.score
				end
			end
		end

		local var_8_3 = var_0_13.find_object_by_id(arg_8_1)

		self._control.main.top.title_bg.title_text.text.text = var_8_3.sub_title2
		self._control.main.top.title_bg.title_text2.text.text = var_8_3.title
		self._control.main.bottom.point.point_text.text.text = var_8_0 .. "/" .. ((self._hard_mode or nil) and (self._map_data.point2 or self._map_data.point1))

		self._control.main.bottom.import_btn:SetActive(true)

		self._control.bg.image.sprite = self._hard_mode and self:loadSprite(var_0_7(var_0_11.strike_hard_map_bg, tostring(arg_8_1), tostring(arg_8_1))) or self:loadSprite(var_0_7(var_0_11.strike_map_bg, tostring(arg_8_1), tostring(arg_8_1)))
	end

	function arg_1_0:__set_node_data_by_map(arg_9_1, arg_9_2)
		local var_9_0 = self._control.main.middle.map_panel.map_node_root

		self._light_seq = {}

		for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
			local var_9_3, var_9_4 = self:__load_map_fragment_with_pool("strike_map_node_obj", var_9_0.transform)

			var_9_3:setVisible(false)

			var_9_4.icon.rectTransform.parent.offsetMin = var_0_9(0, 0)
			var_9_4.icon.rectTransform.parent.offsetMax = var_0_9(0, 0)
			var_9_4.icon.rectTransform.anchoredPosition = self:__get_real_node_pos(iter_9_1.position.x, iter_9_1.position.y)

			var_0_4(self._map_node, iter_9_1.id, var_9_3)

			local var_9_5

			if iter_9_1.node_attribute == var_0_11.map_node_finish_type.init then
				var_9_5 = var_0_11.fight_point.pve_white
			elseif iter_9_1.node_attribute == var_0_11.map_node_finish_type.normal then
				var_9_5 = var_0_11.fight_point.pve_red
			elseif iter_9_1.node_attribute == var_0_11.map_node_finish_type.boss_finish then
				var_9_5 = var_0_11.fight_point.pve_boss
			end

			var_9_4.icon.image.sprite = self:loadSprite(var_9_5)

			var_9_4.icon.image:SetNativeSize()

			if iter_9_1.line and iter_9_1.next_node_path[1] then
				local var_9_6, var_9_7 = self:__load_map_fragment_with_pool("strike_map_line_obj", var_9_0.transform)

				var_9_6:setVisible(false)

				local var_9_8 = var_0_16.find_object_by_id(iter_9_1.next_node_id)

				var_9_7.icon.rectTransform.parent.offsetMin = var_0_9(0, 0)
				var_9_7.icon.rectTransform.parent.offsetMax = var_0_9(0, 0)
				var_9_7.icon.rectTransform.anchoredPosition = var_0_9(iter_9_1.line.x, -1 * iter_9_1.line.y)
				var_9_7.icon.image.sprite = self:loadSprite((var_0_7(var_0_11.strike_mapline_path, arg_9_2, iter_9_1.next_node_path[1])))

				var_9_7.icon.image:SetNativeSize()
				var_0_4(self._map_node_path, iter_9_1.id, var_9_6)
			end

			if iter_9_1.arrow[1] then
				local var_9_9, var_9_10 = self:__load_map_fragment_with_pool("strike_arrow_obj", var_9_0.transform)

				var_9_9:setVisible(true)

				var_9_10.icon.rectTransform.parent.offsetMin = var_0_9(0, 0)
				var_9_10.icon.rectTransform.parent.offsetMax = var_0_9(0, 0)
				var_9_10.icon.rectTransform.anchoredPosition = self:__get_real_node_pos(iter_9_1.arrow[1].x, iter_9_1.arrow[1].y)
				var_9_10.icon.image.sprite = self:loadSprite((var_0_7(var_0_11.strike_arrow_path, iter_9_1.id, 0)))

				var_9_10.icon.image:SetNativeSize()

				self._map_object_obj[iter_9_1.id] = self._map_object_obj[iter_9_1.id] or {}

				var_0_4(self._map_object_obj[iter_9_1.id], var_9_9)

				local var_9_11, var_9_12 = self:__load_map_fragment_with_pool("strike_gear_obj", var_9_0.transform)

				var_9_11:setVisible(true)

				var_9_12.icon.rectTransform.parent.offsetMin = var_0_9(0, 0)
				var_9_12.icon.rectTransform.parent.offsetMax = var_0_9(0, 0)
				var_9_12.icon.rectTransform.anchoredPosition = self:__get_real_node_pos(iter_9_1.arrow[2].x, iter_9_1.arrow[2].y)
				var_9_12.icon.rectTransform.pivot = var_0_9(0.5, 0.5)
				var_9_12.icon.image.sprite = self:loadSprite((var_0_7(var_0_11.strike_arrow_path, iter_9_1.id, 1)))

				var_9_12.icon.image:SetNativeSize()
				var_0_4(self._map_object_obj[iter_9_1.id], var_9_11)

				if iter_9_1.arrow[3] then
					local var_9_13, var_9_14 = self:__load_map_fragment_with_pool("strike_gear_obj", var_9_0.transform)

					var_9_13:setVisible(true)

					var_9_14.icon.rectTransform.parent.offsetMin = var_0_9(0, 0)
					var_9_14.icon.rectTransform.parent.offsetMax = var_0_9(0, 0)
					var_9_14.icon.rectTransform.anchoredPosition = self:__get_real_node_pos(iter_9_1.arrow[3].x, iter_9_1.arrow[3].y)
					var_9_14.icon.rectTransform.pivot = var_0_9(0, 1)
					var_9_14.icon.image.sprite = self:loadSprite((var_0_7(var_0_11.strike_arrow_path, iter_9_1.id, 2)))

					var_9_14.icon.image:SetNativeSize()
					var_0_4(self._map_object_obj[iter_9_1.id], var_9_13)
				end
			end
		end

		if self._strike_map_finish then
			for iter_9_2 = 1, self._control.main.middle.map_panel.map_node_root.transform.childCount do
				self._control.main.middle.map_panel.map_node_root.transform:GetChild(iter_9_2 - 1).gameObject:SetActive(true)
			end
		end
	end

	function arg_1_0:__hide_all_map_fragment_to_pool()
		for iter_10_0, iter_10_1 in pairs(self._obj_pool) do
			for iter_10_2, iter_10_3 in ipairs(iter_10_1) do
				if iter_10_3.using then
					iter_10_3.prefabObj._panel.transform:SetParent(self._control.obj_pool_root.transform)

					iter_10_3.using = false
				end
			end
		end
	end

	function arg_1_0:__set_node_path_visible()
		local var_11_0 = self._strike_info.point_id and self._strike_info.point_id ~= 0 and (self:__is_last_battle_win() and self._strike_info.point_id or self._strike_info.next_point_id) or self._map_data.init_node_id

		for iter_11_0, iter_11_1 in pairs(self._map_node) do
			if iter_11_0 <= var_11_0 then
				iter_11_1:setVisible(true)
			else
				iter_11_1:setVisible(false)
			end
		end

		for iter_11_2, iter_11_3 in pairs(self._map_object_obj) do
			if iter_11_2 <= var_11_0 then
				for iter_11_4, iter_11_5 in pairs(iter_11_3) do
					local var_11_1 = self:autoKillDOTween(var_0_8.Sequence())

					var_11_1:Append(iter_11_5._control.icon.image:DOFade(1, 0.1))
					var_11_1:Play()
				end
			else
				for iter_11_6, iter_11_7 in pairs(iter_11_3) do
					local var_11_2 = self:autoKillDOTween(var_0_8.Sequence())

					var_11_2:Append(iter_11_7._control.icon.image:DOFade(0, 0.1))
					var_11_2:Play()
				end
			end
		end

		for iter_11_8, iter_11_9 in pairs(self._map_node_path) do
			if var_11_0 ~= self._map_data.init_node_id then
				if iter_11_8 == var_11_0 - 1 then
					iter_11_9:setVisible(true)
				else
					iter_11_9:setVisible(false)
				end
			end
		end
	end

	function arg_1_0:__init_buff_pos()
		local var_12_0 = self._control.main.middle.map_panel.map_node_root

		self._strike_info = var_0_2:get_strike_point_info()

		if self._strike_info and var_0_1(self._strike_info) then
			if self.__btn_state == 1 then
				local var_12_1 = lx.clone_table(self._strike_info.buffs)
				local var_12_2 = var_0_2:get_strike_map_panel_buff()

				if var_12_2 then
					if var_12_1 and #var_12_1 > 0 then
						for iter_12_0 = 1, #var_12_1 do
							for iter_12_1, iter_12_2 in pairs(var_12_1) do
								if iter_12_2.point_id == self._strike_info.next_point_id then
									table.remove(var_12_1, iter_12_1)
								end
							end
						end
					end

					for iter_12_3, iter_12_4 in pairs(var_12_2) do
						local var_12_3 = false

						if var_12_1 then
							for iter_12_5, iter_12_6 in pairs(var_12_1) do
								if iter_12_6.id == iter_12_4.id then
									var_12_3 = true
								end
							end
						end

						if not var_12_3 then
							var_0_4(var_12_1, iter_12_4)
						end
					end
				end

				local var_12_4 = 0

				if var_0_1(var_12_1) then
					for iter_12_7, iter_12_8 in ipairs(var_12_1) do
						local var_12_5 = var_0_14.find_object_by_id(iter_12_8.id)

						if iter_12_8.state then
							var_12_5 = var_0_14.find_object_by_id(iter_12_8.change_id)
						end

						local var_12_6 = iter_12_8.point_id == self._map_data.init_node_id and var_0_16.find_object_by_id(iter_12_8.point_id + 1) or var_0_16.find_object_by_id(iter_12_8.point_id)

						if var_12_6 then
							local var_12_7, var_12_8 = self:__load_map_fragment_with_pool("strike_buff_obj", var_12_0.transform)

							if var_12_7 then
								var_12_7:setVisible(true)

								var_12_8.icon.rectTransform.parent.offsetMin = var_0_9(0, 0)
								var_12_8.icon.rectTransform.parent.offsetMax = var_0_9(0, 0)

								if var_12_4 ~= 0 and var_12_4 == iter_12_8.point_id then
									var_12_8.icon.rectTransform.anchoredPosition = var_0_9(var_12_6.position.x + 10, -1 * (var_12_6.position.y - 60 - var_12_8.icon.rectTransform.rect.height))
									var_12_8.title_scroller.rectTransform.anchoredPosition = var_0_9(var_12_8.icon.rectTransform.anchoredPosition.x - 20, var_12_8.icon.rectTransform.anchoredPosition.y + 25)
									var_12_8.text_scroller.rectTransform.anchoredPosition = var_0_9(var_12_8.icon.rectTransform.anchoredPosition.x - 95, var_12_8.icon.rectTransform.anchoredPosition.y + 9)
									var_12_8.placed.rectTransform.anchoredPosition = var_0_9(var_12_8.icon.rectTransform.anchoredPosition.x + 75, var_12_8.icon.rectTransform.anchoredPosition.y + 26)
								else
									var_12_8.icon.rectTransform.anchoredPosition = var_0_9(var_12_6.position.x + 10, -1 * (var_12_6.position.y - 60))
									var_12_8.title_scroller.rectTransform.anchoredPosition = var_0_9(var_12_8.icon.rectTransform.anchoredPosition.x - 20, var_12_8.icon.rectTransform.anchoredPosition.y + 25)
									var_12_8.text_scroller.rectTransform.anchoredPosition = var_0_9(var_12_8.icon.rectTransform.anchoredPosition.x - 95, var_12_8.icon.rectTransform.anchoredPosition.y + 9)
									var_12_8.placed.rectTransform.anchoredPosition = var_0_9(var_12_8.icon.rectTransform.anchoredPosition.x + 75, var_12_8.icon.rectTransform.anchoredPosition.y + 26)
								end

								if var_12_8.icon.rectTransform.anchoredPosition.y > -170 then
									var_12_8.icon.rectTransform.localRotation = {
										z = -180,
										x = 0,
										y = 0
									}
									var_12_8.icon.rectTransform.anchoredPosition = var_0_9(var_12_8.icon.rectTransform.anchoredPosition.x, var_12_8.icon.rectTransform.anchoredPosition.y - 235)
									var_12_8.title_scroller.rectTransform.anchoredPosition = var_0_9(var_12_8.title_scroller.rectTransform.anchoredPosition.x, var_12_8.title_scroller.rectTransform.anchoredPosition.y - 250)
									var_12_8.text_scroller.rectTransform.anchoredPosition = var_0_9(var_12_8.text_scroller.rectTransform.anchoredPosition.x, var_12_8.text_scroller.rectTransform.anchoredPosition.y - 250)
									var_12_8.placed.rectTransform.anchoredPosition = var_0_9(var_12_8.placed.rectTransform.anchoredPosition.x, var_12_8.placed.rectTransform.anchoredPosition.y - 250)
								end

								var_12_8.icon.image.sprite = self:loadSprite(var_0_11.strike_buff_path)

								var_12_8.title_scroller:GetComponent("TextHorizonScroller"):SetText(var_12_5.title)

								var_12_8.text_scroller.text.text.text = var_0_5:convert_rich_text(var_12_5.desc)

								if iter_12_8.replace then
									var_12_8.placed:SetActive(true)
								else
									var_12_8.placed:SetActive(false)
								end
							end
						end

						var_12_4 = iter_12_8.point_id
					end
				end
			elseif self.__btn_state == 2 then
				self:destroyChildren("strike_buff_obj")
			end
		end
	end

	function arg_1_0:__get_real_node_pos(arg_13_1, arg_13_2)
		return var_0_9(arg_13_1 / 1280 * self._control.bg.rectTransform.rect.width, -1 * (arg_13_2 / 960 * self._control.bg.rectTransform.rect.height))
	end

	function arg_1_0:__destroy_seq()
		if self._hard_tips_seq and self._hard_tips_seq:IsPlaying() then
			self._hard_tips_seq:Kill()
		end

		for iter_14_0, iter_14_1 in pairs(self._light_seq) do
			if iter_14_1 and iter_14_1:IsPlaying() then
				iter_14_1:Kill()
			end
		end
	end

	function arg_1_0:__kill_all_tween()
		if self._point_seq then
			self._point_seq:Kill()

			self._point_seq = nil
		end
	end

	function arg_1_0:__preload_map_fragment()
		self._obj_pool = {}

		for iter_16_0, iter_16_1 in ipairs({
			{
				preload_count = 6,
				preload_obj_name = "strike_map_node_obj"
			},
			{
				preload_count = 1,
				preload_obj_name = "strike_buff_obj"
			},
			{
				preload_count = 6,
				preload_obj_name = "strike_map_line_obj"
			},
			{
				preload_count = 6,
				preload_obj_name = "strike_arrow_obj"
			},
			{
				preload_count = 6,
				preload_obj_name = "strike_gear_obj"
			},
			{
				preload_count = 6,
				preload_obj_name = "strike_box_obj"
			}
		}) do
			self._obj_pool[iter_16_1.preload_obj_name] = {}

			for iter_16_2 = 1, iter_16_1.preload_count do
				local var_16_0, var_16_1 = self:loadUIPrefab(iter_16_1.preload_obj_name, self._control.obj_pool_root.transform)

				var_16_0:setVisible(true)

				self._obj_pool[iter_16_1.preload_obj_name][#self._obj_pool[iter_16_1.preload_obj_name] + 1] = {
					using = false,
					prefabObj = var_16_0,
					prefabContorl = var_16_1
				}
			end
		end
	end

	function arg_1_0:__load_map_fragment_with_pool(arg_17_1, arg_17_2)
		local var_17_0 = false
		local var_17_1

		if self._obj_pool and var_0_1(self._obj_pool) then
			for iter_17_0, iter_17_1 in ipairs(self._obj_pool[arg_17_1]) do
				if iter_17_1.using == false then
					var_17_0 = true
					var_17_1 = self._obj_pool[arg_17_1][iter_17_0]

					break
				end
			end
		end

		if var_17_0 then
			var_17_1.using = true

			if var_0_1(var_17_1.prefabObj) then
				var_17_1.prefabObj._panel.transform:SetParent(arg_17_2)

				return var_17_1.prefabObj, var_17_1.prefabContorl
			end
		else
			local var_17_2, var_17_3 = self:loadUIPrefab(arg_17_1, arg_17_2)

			self._obj_pool[arg_17_1][#self._obj_pool[arg_17_1] + 1] = {
				using = true,
				prefabObj = var_17_2,
				prefabContorl = var_17_3
			}

			return var_17_2, var_17_3
		end
	end

	function arg_1_0:__return_pool(arg_18_1)
		for iter_18_0 = 0, arg_18_1.childCount - 1 do
			arg_18_1:GetChild(0):SetParent(self._control.obj_pool_root.transform)
		end
	end

	function arg_1_0:__destroy_pool()
		if self._obj_pool and #self._obj_pool > 0 then
			for iter_19_0, iter_19_1 in pairs(self._obj_pool) do
				for iter_19_2, iter_19_3 in pairs(iter_19_1) do
					iter_19_3 = nil
				end
			end

			for iter_19_4, iter_19_5 in pairs(self._obj_pool) do
				iter_19_5 = nil
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

		self:destroyChildren("strike_map_node_obj")
		self:destroyChildren("strike_map_line_obj")
		self:destroyChildren("strike_arrow_obj")
		self:destroyChildren("strike_gear_obj")
		self:destroyChildren("strike_box_obj")
		self:destroyChildren("strike_buff_obj")
	end

	function arg_1_0:__init_ship_pos()
		local var_20_0 = self._strike_info.point_id and self._strike_info.point_id ~= 0 and (self:__is_last_battle_win() and (self._pass_map and self._strike_info.next_point_id or self._strike_info.point_id) or self._strike_info.next_point_id) or self._map_data.init_node_id

		var_0_2:set_now_ship_point(var_20_0)
		var_0_2:set_next_ship_point(self._strike_info.next_point_id)

		local var_20_1 = var_0_16.find_object_by_id(var_20_0)
		local var_20_2 = var_0_16.find_object_by_id(self._strike_info.next_point_id)

		self._control.main.middle.map_panel.ship.ship_layer.rectTransform.anchoredPosition = self:__get_real_node_pos(var_20_1.position.x, var_20_1.position.y)
		self._control.main.middle.map_panel.ship.ship_layer.transform.localRotation = ((var_20_2 or nil) and var_20_2.position.x - var_20_1.position.x) > 0 and var_0_9(0, 0) or var_0_9(0, 180)
	end

	function arg_1_0:__is_last_battle_win()
		return (self._last_battle_grade or nil) and 2 >= self._last_battle_grade
	end

	function arg_1_0:_is_have_change_buff(arg_22_1, arg_22_2)
		local var_22_0 = var_0_16.find_object_by_id(arg_22_2)

		self.__map_point_info = var_22_0

		local var_22_2 = {}
		local var_22_3 = {}
		local var_22_4 = {}
		local var_22_5 = {}

		if self._hard_mode then
			var_22_4 = var_22_0.buff_high2 or {}
			var_22_5 = var_22_0.buff_low2 or {}

			if var_22_0.replace_conditions2 and var_0_1(var_22_0.replace_conditions2) then
				local var_22_6 = {}

				for iter_22_0, iter_22_1 in pairs(var_22_0.replace_conditions2) do
					for iter_22_2, iter_22_3 in pairs(self._strike_info.buffs) do
						if iter_22_3.id == iter_22_1 then
							var_0_4(var_22_6, iter_22_3.id)
						end
					end
				end

				if #var_22_6 == #var_22_0.replace_conditions2 then
					var_22_4 = var_22_0.replace_buff_high2 or {}
					var_22_5 = var_22_0.replace_buff_low2 or {}
				end
			end
		else
			var_22_4 = var_22_0.buff_high or {}
			var_22_5 = var_22_0.buff_low or {}

			if var_22_0.replace_conditions and var_0_1(var_22_0.replace_conditions) then
				local var_22_7 = {}

				for iter_22_4, iter_22_5 in pairs(var_22_0.replace_conditions) do
					for iter_22_6, iter_22_7 in pairs(self._strike_info.buffs) do
						if iter_22_7.id == iter_22_5 then
							var_0_4(var_22_7, iter_22_7.id)
						end
					end
				end

				if #var_22_7 == #var_22_0.replace_conditions then
					var_22_4 = var_22_0.replace_buff_high or {}
					var_22_5 = var_22_0.replace_buff_low or {}
				end
			end
		end

		self._buff_select_limit = var_22_0.buff_num == 2 and 2 or 1
		self._replace_node = var_22_0.replace_node_id ~= 0

		if var_22_0.replace_node_id ~= 0 and var_22_0.replace_node_id == self._map_data.init_node_id then
			self._replace_node = not not self.flag
		end

		if #var_22_4 ~= 0 and #var_22_5 ~= 0 then
			var_0_2:set_have_buff_point(true)
			self._control.strongattack.gameObject:SetActive(true)

			if self._replace_node then
				self._control.strongattack.replace_bg:SetActive(true)

				self._control.strongattack.replace_bg.replace_dsc.text.text = var_22_0.replace_node_desc
			else
				self._control.strongattack.replace_bg:SetActive(false)
			end

			for iter_22_8, iter_22_9 in pairs(var_22_4) do
				var_0_4(var_22_2, iter_22_9)
			end

			for iter_22_10, iter_22_11 in pairs(var_22_5) do
				var_0_4(var_22_3, iter_22_11)
			end

			for iter_22_12, iter_22_13 in pairs(var_22_3) do
				var_0_4(var_22_2, iter_22_13)
			end

			var_0_3(var_22_2, function(arg_23_0, arg_23_1)
				return arg_23_0.id < arg_23_1.id
			end)

			self._data_buff_num = var_22_0.buff_num

			self:_change_buff_info(var_22_2, var_22_0.buff_num)

			self._buff_one = var_22_2
		elseif #var_22_4 ~= 0 then
			var_0_2:set_have_buff_point(true)
			self._control.strongattack.gameObject:SetActive(true)

			if self._replace_node then
				self._control.strongattack.replace_bg:SetActive(true)

				self._control.strongattack.replace_bg.replace_dsc.text.text = var_22_0.replace_node_desc
			else
				self._control.strongattack.replace_bg:SetActive(false)
			end

			for iter_22_14, iter_22_15 in pairs(var_22_4) do
				var_0_4(var_22_2, iter_22_15)
			end

			var_0_3(var_22_2, function(arg_24_0, arg_24_1)
				return arg_24_0.id < arg_24_1.id
			end)

			self._data_buff_num = var_22_0.buff_num

			self:_change_buff_info(var_22_2, var_22_0.buff_num)

			self._buff_one = var_22_2
		else
			var_0_2:set_have_buff_point(false)

			if arg_22_1 == self._map_data.init_node_id and not self:__is_last_battle_win() then
				self:__fight_prepare_show(self.page_id, self.config, self.flag)
			else
				self:__play_move_ship(arg_22_1, arg_22_2, true)
			end
		end
	end

	function arg_1_0:_change_buff_info(arg_25_1, arg_25_2)
		self._control.strongattack.titlebg.title.image.sprite = self:loadSprite(var_0_7(var_0_11.strike_title_bg, arg_25_2))

		self._control.strongattack.titlebg.title.image:SetNativeSize()

		local var_25_0 = {
			self._control.strongattack.string_node1,
			self._control.strongattack.string_node2,
			self._control.strongattack.string_node3,
			self._control.strongattack.string_node4,
			self._control.strongattack.string_node5
		}

		for iter_25_0 = 1, #arg_25_1 do
			var_25_0[iter_25_0].transform.localPosition = var_0_11.transform_list[#arg_25_1][iter_25_0]
		end

		self._control.strongattack.confirm.gameObject:SetActive(false)

		for iter_25_1 = 1, 5 do
			var_25_0[iter_25_1].float_bg.gameObject:SetActive(false)

			var_25_0[iter_25_1].button.interactable = true
		end

		self._buff_content = var_25_0
		self._buff_flag = false
		self._save_buff_num = 0
		self._save_buff_data = {}
		self._save_buff_change_num = {}
		self._save_buff = {}

		for iter_25_2, iter_25_3 in pairs(var_25_0) do
			if arg_25_1[iter_25_2] then
				iter_25_3:SetActive(true)

				iter_25_3.icon_num.num.text.text = arg_25_1[iter_25_2].value

				local var_25_2 = var_0_14.find_object_by_id(arg_25_1[iter_25_2].id)

				iter_25_3.buffname_scroller:GetComponent("TextHorizonScroller"):SetText(var_25_2.title)

				if #var_0_10.only_extract_word(var_25_2.desc) < 90 then
					iter_25_3.attr_scroller:GetComponent("TextHorizonScroller").enabled = false
					iter_25_3.attr_scroller.attr_info.text.text = var_0_10.convert_rich_text(var_25_2.desc)
					iter_25_3.attr_scroller.attr_info2.text.text = ""
					iter_25_3.attr_scroller.attr_info.text.fontSize = 18
					iter_25_3.attr_scroller.attr_info.rectTransform.rect.width = 306
				else
					iter_25_3.attr_scroller:GetComponent("TextHorizonScroller").enabled = true

					local var_25_3 = iter_25_3.attr_scroller:GetComponent("TextHorizonScroller")

					var_25_3.isRich = true

					var_25_3:SetText(var_0_10.convert_rich_text(var_25_2.desc))

					iter_25_3.attr_scroller.attr_info.text.fontSize = 20
					iter_25_3.attr_scroller.attr_info2.text.fontSize = 20
				end

				iter_25_3.info_text.text.text = var_25_2.effect_desc
				iter_25_3.title_bg.image.sprite = self:loadSprite(var_0_7(var_0_11.strike_buff_bg, var_25_2.type))
				iter_25_3.image.sprite = self:loadSprite(var_0_7(var_0_11.strike_strong_node_bg, var_25_2.buff_bg))

				iter_25_3.img_replace:SetActive(false)

				if self._replace_node then
					iter_25_3.float_bg:SetActive(true)

					iter_25_3.float_bg.canvasGroup.alpha = 0

					local var_25_4 = self:autoKillDOTween(var_0_8.Sequence())

					var_25_4:AppendInterval(0.5)
					var_25_4:Append(iter_25_3.float_bg.canvasGroup:DOFade(1, 1))
					var_25_4:AppendInterval(0.5)
					var_25_4:Append(iter_25_3.float_bg.canvasGroup:DOFade(0, 1))
					var_25_4:AppendInterval(0.5)
					var_25_4:SetLoops(-1)
					var_25_4:Play()
					iter_25_3.img_replace:SetActive(true)

					iter_25_3.img_replace.image.sprite = self:loadSprite(var_0_11.strike_buff_circle)

					var_0_4(self._tween_list, var_25_4)
				end

				if var_25_2.change_condition ~= 0 and var_0_1(var_25_2.change_condition) then
					iter_25_3.img_replace:SetActive(true)

					iter_25_3.img_replace.image.sprite = self:loadSprite(var_0_11.strike_buff_tan)
				end
			else
				iter_25_3:SetActive(false)
			end
		end

		if arg_25_2 == 2 then
			self._control.strongattack.confirm.gameObject:SetActive(true)
		end
	end

	function arg_1_0:_buff_button_move(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
		local var_26_0 = self:autoKillDOTween(var_0_8.Sequence())
		local var_26_1 = self._buff_content

		if arg_26_4 == 1 then
			local var_26_2 = {}

			if self._replace_node then
				self._save_buff_num = arg_26_1

				self:__show_replace_buff_page(true)
			else
				self._buff_content[arg_26_1].float_bg.gameObject:SetActive(true)
				var_26_0:AppendCallback(function()
					if not var_26_0:Equals(nil) then
						var_26_0:Append(var_26_1[arg_26_1].transform:DOBlendableLocalMoveBy(Vector3.New(0, 5), 0.05):SetEase(DG.Tweening.Ease.Linear))
					end
				end)
				var_26_0:AppendInterval(0.05)
				var_26_0:AppendCallback(function()
					if not var_26_0:Equals(nil) then
						var_26_0:Append(var_26_1[arg_26_1].transform:DOBlendableLocalMoveBy(Vector3.New(0, -5), 0.05):SetEase(DG.Tweening.Ease.Linear))
					end
				end)
				var_26_0:AppendInterval(0.01)
				var_26_0:AppendCallback(function()
					var_0_4(var_26_2, {
						id = self._buff_one[arg_26_1].id,
						point_id = arg_26_3,
						score = self._buff_one[arg_26_1].value
					})
					var_0_2:set_save_buff(var_26_2)
					self._control.strongattack.gameObject:SetActive(false)
					self:__fight_prepare_show(self.page_id, self.config, self.flag)

					var_26_1[arg_26_1].button.interactable = false

					var_0_2:req_SoildChooseBuffReq({
						self._buff_one[arg_26_1].id
					})
				end)
			end
		elseif arg_26_4 == 2 then
			if self._save_buff_change_num[1] == nil and self._save_buff_change_num[2] == nil then
				self._buff_content[arg_26_1].float_bg.gameObject:SetActive(true)
				var_26_0:AppendCallback(function()
					if not var_26_0:Equals(nil) then
						var_26_0:Append(var_26_1[arg_26_1].transform:DOBlendableLocalMoveBy(Vector3.New(0, 5), 0.05):SetEase(DG.Tweening.Ease.Linear))
					end
				end)
				var_26_0:AppendInterval(0.05)
				var_26_0:AppendCallback(function()
					if not var_26_0:Equals(nil) then
						var_26_0:Append(var_26_1[arg_26_1].transform:DOBlendableLocalMoveBy(Vector3.New(0, -5), 0.05):SetEase(DG.Tweening.Ease.Linear))
					end
				end)
				var_26_0:AppendInterval(0.01)

				self._save_buff_change_num[1] = arg_26_1
				self._save_buff_data[1] = self._buff_one[arg_26_1]
			elseif self._save_buff_change_num[1] and not self._save_buff_change_num[2] then
				if arg_26_1 ~= self._save_buff_change_num[1] then
					self._buff_content[arg_26_1].float_bg.gameObject:SetActive(true)
					var_26_0:AppendCallback(function()
						if not var_26_0:Equals(nil) then
							var_26_0:Append(var_26_1[arg_26_1].transform:DOBlendableLocalMoveBy(Vector3.New(0, 5), 0.05):SetEase(DG.Tweening.Ease.Linear))
						end
					end)
					var_26_0:AppendInterval(0.05)
					var_26_0:AppendCallback(function()
						if not var_26_0:Equals(nil) then
							var_26_0:Append(var_26_1[arg_26_1].transform:DOBlendableLocalMoveBy(Vector3.New(0, -5), 0.05):SetEase(DG.Tweening.Ease.Linear))
						end
					end)
					var_26_0:AppendInterval(0.01)

					self._save_buff_change_num[2] = arg_26_1

					for iter_26_0 = 1, 5 do
						self._buff_content[iter_26_0].button.interactable = false

						for iter_26_1, iter_26_2 in pairs(self._save_buff_change_num) do
							if iter_26_2 == iter_26_0 then
								self._buff_content[iter_26_0].button.interactable = true
							end
						end
					end

					self._save_buff_data[2] = self._buff_one[arg_26_1]
				else
					self._buff_content[arg_26_1].float_bg.gameObject:SetActive(false)

					self._save_buff_change_num[1] = nil
					self._save_buff_data[1] = nil
				end
			elseif self._save_buff_change_num[1] == nil and self._save_buff_change_num[2] then
				if arg_26_1 ~= self._save_buff_change_num[2] then
					self._buff_content[arg_26_1].float_bg.gameObject:SetActive(true)
					var_26_0:AppendCallback(function()
						if not var_26_0:Equals(nil) then
							var_26_0:Append(var_26_1[arg_26_1].transform:DOBlendableLocalMoveBy(Vector3.New(0, 5), 0.05):SetEase(DG.Tweening.Ease.Linear))
						end
					end)
					var_26_0:AppendInterval(0.05)
					var_26_0:AppendCallback(function()
						if not var_26_0:Equals(nil) then
							var_26_0:Append(var_26_1[arg_26_1].transform:DOBlendableLocalMoveBy(Vector3.New(0, -5), 0.05):SetEase(DG.Tweening.Ease.Linear))
						end
					end)
					var_26_0:AppendInterval(0.01)

					self._save_buff_change_num[1] = arg_26_1

					for iter_26_3 = 1, 5 do
						self._buff_content[iter_26_3].button.interactable = false

						for iter_26_4, iter_26_5 in pairs(self._save_buff_change_num) do
							if iter_26_5 == iter_26_3 then
								self._buff_content[iter_26_3].button.interactable = true
							end
						end
					end

					self._save_buff_data[1] = self._buff_one[arg_26_1]
				else
					self._buff_content[arg_26_1].float_bg.gameObject:SetActive(false)

					self._save_buff_change_num[2] = nil
					self._save_buff_data[2] = nil
				end
			elseif self._save_buff_change_num[2] and not self._save_buff_change_num[3] then
				for iter_26_6 = 1, #self._save_buff_change_num do
					if arg_26_1 == self._save_buff_change_num[iter_26_6] then
						self._save_buff_change_num[iter_26_6] = nil
						self._save_buff_data[iter_26_6] = nil

						self._buff_content[arg_26_1].float_bg.gameObject:SetActive(false)
					end
				end

				for iter_26_7 = 1, 5 do
					self._buff_content[iter_26_7].button.interactable = true
				end
			end

			local var_26_3 = {}

			for iter_26_8, iter_26_9 in pairs(self._save_buff_change_num) do
				var_0_4(var_26_3, {
					id = self._buff_one[iter_26_9].id,
					point_id = arg_26_3,
					score = self._buff_one[iter_26_9].value
				})
			end

			var_0_2:set_save_buff(var_26_3)
		end

		var_26_0:SetLoops(1)
		var_26_0:Play()
	end

	function arg_1_0:__show_replace_buff_page(arg_36_1)
		self._control.strongattack.replace:SetActive(arg_36_1)

		local var_36_0 = self._control.strongattack.replace.replace_node

		if arg_36_1 and self.__map_point_info.replace_node_id ~= 0 then
			var_36_0:SetActive(true)

			local var_36_1 = {}

			for iter_36_0, iter_36_1 in pairs(self._strike_info.buffs) do
				if iter_36_1.point_id == self.__map_point_info.replace_node_id then
					var_36_1 = iter_36_1
				end
			end

			var_36_0.icon_num.num.text.text = var_36_1.score

			local var_36_2 = var_0_14.find_object_by_id(var_36_1.id)

			var_36_0.buffname_scroller:GetComponent("TextHorizonScroller"):SetText(var_36_2.title)

			if #var_36_2.desc < 150 then
				var_36_0.attr_scroller:GetComponent("TextHorizonScroller").enabled = false
				var_36_0.attr_scroller.attr_info.text.text = var_0_10.convert_rich_text(var_36_2.desc)
				var_36_0.attr_scroller.attr_info2.text.text = ""
				var_36_0.attr_scroller.attr_info.text.fontSize = 18
				var_36_0.attr_scroller.attr_info.rectTransform.rect.width = 306
			else
				var_36_0.attr_scroller:GetComponent("TextHorizonScroller").enabled = true

				local var_36_3 = var_36_0.attr_scroller:GetComponent("TextHorizonScroller")

				var_36_3.isRich = true

				var_36_3:SetText(var_0_10.convert_rich_text(var_36_2.desc))

				var_36_0.attr_scroller.attr_info.text.fontSize = 20
				var_36_0.attr_scroller.attr_info2.text.fontSize = 20
			end

			var_36_0.info_text.text.text = var_36_2.effect_desc
			var_36_0.title_bg.image.sprite = self:loadSprite(var_0_7(var_0_11.strike_buff_bg, var_36_2.type))
		else
			var_36_0:SetActive(false)
		end
	end

	function arg_1_0:__show_not_selected_all_buff_page(arg_37_1, arg_37_2)
		self._control.strongattack.not_selected_all:SetActive(arg_37_1)

		local var_37_0 = self._control.strongattack.not_selected_all.replace_node

		if arg_37_1 and self.__map_point_info.buff_num == 2 then
			var_37_0:SetActive(true)

			local var_37_1 = var_0_14.find_object_by_id(arg_37_2.id)

			var_37_0.icon_num.num.text.text = arg_37_2.value

			var_37_0.buffname_scroller:GetComponent("TextHorizonScroller"):SetText(var_37_1.title)

			if #var_37_1.desc < 150 then
				var_37_0.attr_scroller:GetComponent("TextHorizonScroller").enabled = false
				var_37_0.attr_scroller.attr_info.text.text = var_0_10.convert_rich_text(var_37_1.desc)
				var_37_0.attr_scroller.attr_info2.text.text = ""
				var_37_0.attr_scroller.attr_info.text.fontSize = 18
				var_37_0.attr_scroller.attr_info.rectTransform.rect.width = 306
			else
				var_37_0.attr_scroller:GetComponent("TextHorizonScroller").enabled = true

				local var_37_2 = var_37_0.attr_scroller:GetComponent("TextHorizonScroller")

				var_37_2.isRich = true

				var_37_2:SetText(var_0_10.convert_rich_text(var_37_1.desc))

				var_37_0.attr_scroller.attr_info.text.fontSize = 20
				var_37_0.attr_scroller.attr_info2.text.fontSize = 20
			end

			var_37_0.info_text.text.text = var_37_1.effect_desc
			var_37_0.title_bg.image.sprite = self:loadSprite(var_0_7(var_0_11.strike_buff_bg, var_37_1.type))
		else
			var_37_0:SetActive(false)
		end
	end

	function arg_1_0:__confirm_replace_buff()
		self:__show_replace_buff_page(false)

		local var_38_0 = {}

		var_0_4(var_38_0, {
			id = self._buff_one[self._save_buff_num].id,
			point_id = self._strike_info.next_point_id,
			score = self._buff_one[self._save_buff_num].value
		})
		var_0_2:set_save_buff(var_38_0)
		var_0_2:req_SoildChooseBuffReq({
			self._buff_one[self._save_buff_num].id
		})

		for iter_38_0, iter_38_1 in pairs(self._strike_info.buffs) do
			if iter_38_1.point_id == self.__map_point_info.replace_node_id then
				iter_38_1.replace = true
			end
		end

		local var_38_1 = var_0_2:get_strike_point_info()

		var_38_1.buffs = self._strike_info.buffs

		var_0_2:set_strike_point_info(var_38_1)
		self._control.strongattack.gameObject:SetActive(false)
		self:__clear_tween_anim()
		self:__fight_prepare_show(self.page_id, self.config, self.flag)
	end

	function arg_1_0:__confirm_not_selected_all_buff(arg_39_1)
		self:__show_not_selected_all_buff_page(false)

		local var_39_0 = var_0_14.find_object_by_id(arg_39_1.id)
		local var_39_1 = {}

		var_0_4(var_39_1, {
			id = arg_39_1.id,
			point_id = self._strike_info.next_point_id,
			score = arg_39_1.value
		})
		var_0_2:set_save_buff(var_39_1)
		var_0_2:req_SoildChooseBuffReq({
			arg_39_1.id
		})

		local var_39_2 = var_0_2:get_strike_point_info()

		var_39_2.buffs = self._strike_info.buffs

		var_0_2:set_strike_point_info(var_39_2)
		self._control.strongattack.gameObject:SetActive(false)
		self:__clear_tween_anim()
		self:__fight_prepare_show(self.page_id, self.config, self.flag)
	end

	function arg_1_0:__play_move_ship(arg_40_1, arg_40_2, arg_40_3, arg_40_4)
		self._control.main.top.return_btn.button.enabled = false

		if arg_40_1 ~= arg_40_2 then
			self._can_click = false

			local var_40_0 = var_0_16.find_object_by_id(arg_40_1)
			local var_40_1 = var_0_16.find_object_by_id(arg_40_2)

			if var_40_0.movie[1] and var_40_0.movie[1][1] ~= 0 and not arg_40_3 then
				local var_40_2 = var_0_17.find_object_by_id(arg_40_1.movie[1][1])

				var_0_6:createInstance("cinema_dialog"):show(var_40_2.movie_group_id, var_40_2.movie_id[1], var_40_2.movie_id[2], 1, {
					start_node = var_40_0,
					next_node = var_40_1
				})

				return
			end

			self._control.main.middle.map_panel.ship.ship_layer.rectTransform.anchoredPosition = self:__get_real_node_pos(var_40_0.position.x, var_40_0.position.y)
			self._control.main.middle.map_panel.ship.ship_layer.rectTransform:DOAnchorPos(self:__get_real_node_pos(var_40_1.position.x, var_40_1.position.y), 1):SetEase(DG.Tweening.Ease.Linear):SetDelay(0):SetAutoKill(true).onComplete = function()
				if not arg_40_4 then
					var_0_2:req_SolidEnterPointReq()
				else
					var_0_2:req_SolidEnterPointReq()
				end
			end

			self._control.main.middle.map_panel.ship.ship_layer.encounter_effect.encounter_spine.skeletonGraphic.AnimationState:ClearTracks()
			self._control.main.middle.map_panel.ship.ship_layer.encounter_effect.encounter_spine.skeletonGraphic.AnimationState:SetAnimation(0, "Cable_enemy", false)

			for iter_40_0, iter_40_1 in pairs(self._map_node_path) do
				if iter_40_0 == arg_40_1 then
					iter_40_1:setVisible(true)
				else
					iter_40_1:setVisible(false)
				end
			end
		elseif not arg_40_4 then
			var_0_2:req_SolidEnterPointReq()
		else
			var_0_2:req_SolidEnterPointReq()
		end
	end

	function arg_1_0:get_map_info()
		return self._map_data, self._map_id - var_0_15.find_object_by_id(var_0_12.find_object_by_id(17).content.activeId).levels[1] + 1
	end

	function arg_1_0:__init_lock()
		local var_43_0
		local var_43_1

		if self._strike_info.point_id and self._strike_info.point_id ~= 0 then
			var_43_0 = self._strike_info.point_id
			var_43_1 = self._strike_info.next_point_id
		else
			var_43_0 = self._map_data.init_node_id
			var_43_1 = self._now_map_info.next_node_id
		end

		self:__play_move_lock(var_43_0, var_43_1)
	end

	function arg_1_0:__play_move_lock(arg_44_1, arg_44_2)
		if arg_44_1 == arg_44_2 then
			return
		end

		if not self:__is_last_battle_win() then
			return
		end

		if not self._is_show_lock then
			return
		end

		self._control.main.shadow_circle:SetActive(true)
		self._control.main.middle.map_panel.map_lock:SetActive(true)

		local var_44_0, var_44_1 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self._panel.transform, self._control.main.middle.map_panel.ship.ship_layer.transform.position, nil, nil)

		self._control.main.middle.map_panel.map_lock.rectTransform.anchoredPosition = var_44_1

		self._control.main.shadow_circle.image.material:SetVector("_Center", Vector4(var_44_1.x, var_44_1.y, 0, 0))

		local var_44_2 = var_0_16.find_object_by_id(arg_44_2)
		local var_44_3 = self:__get_real_node_pos(var_44_2.position.x, var_44_2.position.y)
		local var_44_4 = var_0_9(var_44_3.x - 640, var_44_3.y + 480)
		local var_44_5 = self:autoKillDOTween(var_0_8.Sequence())
		local var_44_6 = self:autoKillDOTween(var_0_8.Sequence())

		var_44_5:Append(self._control.main.middle.map_panel.map_lock.rectTransform:DOAnchorPos(var_44_4, 1.333):SetEase(DG.Tweening.Ease.OutSine):SetAutoKill(true))
		var_44_6:Append(self._control.main.shadow_circle.image.material:DOVector(var_44_4, "_Center", 1.333):SetEase(DG.Tweening.Ease.OutSine):SetAutoKill(true))
		var_44_5:AppendInterval(0.8)
		var_44_6:AppendInterval(0.8)
		var_44_5:AppendCallback(function()
			self._control.main.middle.map_panel.map_lock:SetActive(false)

			for iter_45_0, iter_45_1 in pairs(self._map_node) do
				if iter_45_0 == arg_44_2 then
					iter_45_1:setVisible(true)
				end
			end

			for iter_45_2, iter_45_3 in pairs(self._map_object_obj) do
				if iter_45_2 == arg_44_2 then
					for iter_45_4, iter_45_5 in pairs(iter_45_3) do
						local var_45_0 = self:autoKillDOTween(var_0_8.Sequence())

						var_45_0:Append(iter_45_5._control.icon.image:DOFade(1, 1.333))
						var_45_0:Play()
					end
				end
			end
		end)
		var_44_6:AppendCallback(function()
			self._control.main.shadow_circle:SetActive(false)
		end)
	end

	function arg_1_0:_play_into_se(arg_47_1)
		self:playSE(arg_47_1, false)
	end

	function arg_1_0:__initial_func()
		local var_48_0 = {
			{
				nodetext = "confirmquit",
				node = self._control.msgbox.main.title
			},
			{
				nodetext = "confirmquitornot",
				node = self._control.msgbox.main.main_text
			},
			{
				nodetext = "space_confirm",
				node = self._control.msgbox.main.confirmbtn.text
			},
			{
				nodetext = "space_cancel",
				node = self._control.msgbox.main.cancelbtn.text
			},
			{
				nodetext = "selectchangesituation",
				node = self._control.strongattack.replace.replace_hint.replace_hint_dsc
			},
			{
				nodetext = "solid_buff_tip",
				node = self._control.strongattack.not_selected_all.replace_hint.replace_hint_dsc
			}
		}
		local var_48_1 = {
			{
				state = false,
				node = self._control.hard_bg
			},
			{
				state = false,
				node = self._control.msgbox
			}
		}
		local var_48_2 = {
			init_language = function(self, arg_49_1)
				self.text.text = var_0_5:getNowLang(arg_49_1)
			end,
			init_active = function(self, arg_50_1)
				self.gameObject:SetActive(arg_50_1)
			end
		}

		for iter_48_0 = 1, #var_48_0 do
			var_48_2.init_language(var_48_0[iter_48_0].node, var_48_0[iter_48_0].nodetext)
		end

		for iter_48_1 = 1, #var_48_1 do
			var_48_2.init_active(var_48_1[iter_48_1].node, var_48_1[iter_48_1].state)
		end
	end

	function arg_1_0:__fight_prepare_show(arg_51_1, arg_51_2, arg_51_3)
		local var_51_1

		if arg_51_1 and arg_51_2 then
			var_51_1 = {
				go_to_map_id = arg_51_1,
				fight_type = var_0_11.fight_type.strike,
				fight_prepare_type = var_0_11.fight_type.strike,
				init_map_index = arg_51_1 - arg_51_2.pve_id * 100,
				strike_is_deal = var_0_2:get_strike_flag()
			}
		end

		var_0_2:set_fight_info_for_strike(var_51_1)
		var_0_6:createInstance("fight_prepare"):show(var_51_1)
		self:setVisible(false)
	end

	function arg_1_0:__clear_tween_anim()
		for iter_52_0, iter_52_1 in pairs(self._tween_list) do
			iter_52_1:Kill()
		end

		self._tween_list = {}
	end

	function arg_1_0:show_new_result(arg_53_1, arg_53_2, arg_53_3)
		self._control.npc:SetActive(true)
		self._control.main.back_image:SetActive(true)
		self._control.main.bottom.import_btn:SetActive(false)
		self._control.main.back_main_btn:SetActive(false)

		self._control.bg.image.sprite = arg_53_2 and self:loadSprite(var_0_7(var_0_11.strike_hard_map_bg, tostring(self._map_id), tostring(self._map_id))) or self:loadSprite(var_0_7(var_0_11.strike_map_bg, tostring(self._map_id), tostring(self._map_id)))

		if arg_53_3 then
			self._control.main.back_main_btn:SetActive(true)
		end

		self._score_num = arg_53_1
		self.easy_or_hard = arg_53_2

		if arg_53_1 then
			local var_53_0 = self:autoKillDOTween(var_0_8.Sequence())

			var_53_0:AppendInterval(2)
			var_53_0:AppendCallback(function()
				self._control.main.back_difficult_btn:SetActive(true)
			end)
			var_53_0:Play()
			var_0_10.role_talk(self._control.npc.painting.talk, var_0_7(var_0_5:getNowLang("strongattackgotscore"), arg_53_1), 300, 400, nil, false)

			return
		end

		if not self.easy_or_hard then
			var_0_10.role_talk(self._control.npc.painting.talk, var_0_5:getNowLang("strongattackhardopen"), 400, 300, nil, false)
		else
			var_0_10.role_talk(self._control.npc.painting.talk, var_0_5:getNowLang("strongattackhardopen"), 400, 300, nil, false)
		end
	end

	function arg_1_0:_play_audio(arg_55_1, arg_55_2)
		self:playBackgroundMusic(arg_55_1, arg_55_2)
	end

	function arg_1_0:__onDestroy()
		self:__clear_tween_anim()
	end

	function arg_1_0:__onReset()
		self:__destroy_pool()

		self.__btn_state = 1
		self._strike_info = nil
		self._map_id = nil
		self._buff_one = {}
		self._save_buff_num = 0
		self._save_buff_data = {}
		self._save_buff_change_num = {}
		self._buff_flag = false
		self._now_map_info = nil
		self.__map_point_info = nil
		self._last_battle_grade = nil
		self._is_show_lock = nil
		self._map_object_obj = {}
		self._hard_mode = false
		self._can_click = true
		self._replace_node = false
		self._buff_select_limit = 1
		self.page_id = nil
		self.config = nil
		self.flag = nil
		self._map_node = {}
		self._map_node_path = {}

		self:__clear_tween_anim()
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_58_0)
	local var_58_0 = var_0_6:class("strike_map")

	var_58_0.__btn_state = 1
	var_58_0._strike_info = nil
	var_58_0._map_id = nil
	var_58_0._buff_one = {}
	var_58_0._buff_content = {}
	var_58_0._save_buff_num = 0
	var_58_0._save_buff_data = {}
	var_58_0._save_buff_change_num = {}
	var_58_0._buff_flag = false
	var_58_0._now_map_info = nil
	var_58_0.__select_buff = nil
	var_58_0.__map_point_info = nil
	var_58_0._last_battle_grade = nil
	var_58_0._is_show_lock = nil
	var_58_0._map_node = {}
	var_58_0._map_node_path = {}
	var_58_0._map_object_obj = {}
	var_58_0._hard_mode = false
	var_58_0._can_click = true
	var_58_0._tween_list = {}
	var_58_0._replace_node = false
	var_58_0.page_id = nil
	var_58_0.config = nil
	var_58_0.flag = nil
	var_58_0.easy_or_hard = false
	var_58_0._strike_map_finish = false
	var_58_0._pass_map = nil
	var_58_0._already_init = false

	gamecore.extend_obj(var_58_0)

	return var_58_0
end

return var_0_0
