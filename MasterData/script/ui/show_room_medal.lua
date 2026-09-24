local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameconfig.medal_config
local var_0_5 = gameenum.common_type
local var_0_7 = table.insert
local var_0_8 = table.sort
local var_0_10 = table.remove

gamecore.UILoader:define("show_room_medal", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()

		self._control.scrollview_1.viewport.content.transform.anchoredPosition = Vector2(0, 0)
		self._control.scrollview_2.viewport.content.transform.anchoredPosition = Vector2(0, 0)

		self:play_out_animation_2()
		self._control.cover:SetActive(false)
	end

	function arg_1_0:play_in_animation_1(arg_3_1)
		self._control.bg.uITweenSequence:Play(function()
			if arg_3_1 then
				arg_3_1()
			end
		end)
		self._control.cover:SetActive(true)
	end

	function arg_1_0:play_out_animation_1(arg_5_1)
		self._control.bg.uITweenSequence:PlayReverse(function()
			if arg_5_1 then
				arg_5_1()
			end

			if not self._control or self._control.cover:Equals(nil) then
				return
			end

			self._control.cover:SetActive(false)
		end)
		self:show_scroll_by_index(2)
		self._control.cover:SetActive(true)
	end

	function arg_1_0:play_in_animation_2(arg_7_1)
		self._control.bg.top_menu.line_1.uITweenSequence:Play(function()
			if arg_7_1 then
				arg_7_1()
			end
		end)
		self._control.cover:SetActive(true)
	end

	function arg_1_0:play_out_animation_2(arg_9_1)
		self._control.bg.top_menu.line_1.uITweenSequence:PlayReverse(function()
			if arg_9_1 then
				arg_9_1()
			end

			if not self._control or self._control.cover:Equals(nil) then
				return
			end

			self._control.cover:SetActive(false)
		end)
		self:show_scroll_by_index(1)

		self.show_medal_list = {}
		self.dele_index = nil

		self._control.cover:SetActive(true)
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell_1 then
			self._reusable_cell_1:update()
		end

		if self._reusable_cell_2 then
			self._reusable_cell_2:update()
		end
	end

	function arg_1_0.contrast_tab(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = {}

		for iter_12_0, iter_12_1 in pairs(arg_12_1) do
			local var_12_1 = false

			for iter_12_2, iter_12_3 in pairs(arg_12_2) do
				if iter_12_1.id == iter_12_3.id then
					var_12_1 = true
				end
			end

			if not var_12_1 then
				var_0_7(var_12_0, iter_12_1)
			end
		end

		return var_12_0
	end

	function arg_1_0.sort_rule(arg_13_0, arg_13_1)
		var_0_8(arg_13_1, function(arg_14_0, arg_14_1)
			return arg_14_0.id < arg_14_1.id
		end)

		return arg_13_1
	end

	function arg_1_0:get_cell_by_now_lable()
		local var_15_0

		var_15_0 = self._now_label == 1 and self._reusable_cell_1 or self._now_label == 2 and self._reusable_cell_2 or var_15_0

		return var_15_0
	end

	function arg_1_0:show_scroll_by_index(arg_16_1)
		if arg_16_1 == 1 then
			self._control.show_medal.show_medal_text.text.text = var_0_2:getNowLang("medaltip4")

			self._control.bg.top_menu.tips:SetActive(false)
			self._control.type:SetActive(true)
			self._control.use_medal:SetActive(false)

			self._now_label = 1
		else
			self._control.show_medal.show_medal_text.text.text = var_0_2:getNowLang("medaltip3")

			self._control.bg.top_menu.tips:SetActive(true)
			self._control.type:SetActive(false)
			self._control.use_medal:SetActive(true)

			self._now_label = 2
		end
	end

	function arg_1_0:init_cell()
		if self._already_init then
			return
		end

		self._reusable_cell_1 = gamecore.reusable_cell:create(self, self._control.scrollview_1.viewport.content.endlessScrollView, self._control.scrollview_1.viewport.content, "single_medal_cell_1", "show_room_medal")

		self._reusable_cell_1:init()

		self._reusable_cell_2 = gamecore.reusable_cell:create(self, self._control.scrollview_2.viewport.content.endlessScrollView, self._control.scrollview_2.viewport.content, "single_medal_cell_1", "show_room_medal")

		self._reusable_cell_2:init()

		self._already_init = true
	end

	function arg_1_0:init_medal_cell_list(arg_18_1)
		local var_18_0 = self:get_cell_by_now_lable()
		local var_18_1

		if self._now_label == 1 then
			var_18_1 = self.all_show_medal_list or self.is_have_medal_list

			if arg_18_1 == 1 then
				var_18_1 = self._now_label == 1 and self.all_show_medal_list or self.is_have_medal_list
			elseif arg_18_1 == 2 then
				var_18_1 = self._now_label == 1 and self.is_have_medal_list or self.is_have_medal_list
			elseif arg_18_1 == 3 then
				var_18_1 = self._now_label == 1 and self.not_have_medal_list or self.is_have_medal_list
			end
		end

		local var_18_2 = var_0_1:get_player_unlock_medal_data()

		var_18_0:set_data(var_18_1)

		function var_18_0:_set_func(arg_19_1)
			local var_19_0 = var_18_1[arg_19_1 + 1]

			self.get_btn.txt.text.text = var_0_2:getNowLang("clickfetchmedal")
			self.in_display.txt.text.text = var_0_2:getNowLang("displaying")

			self.in_display:SetActive(false)
			self.get_btn:SetActive(false)
			self.cover:SetActive(false)

			self.medal_progress:GetComponent("Slider").value = 0

			local var_19_1 = var_0_4.find_object_by_id(var_18_1[arg_19_1 + 1].id)
			local var_19_2 = self:sort_rule(var_19_1.sub_title)
			local var_19_3 = self:sort_rule(var_19_1.c_desc_1)
			local var_19_4 = self:sort_rule(var_19_1.c_desc_2)
			local var_19_5 = self:sort_rule(var_19_1.condition)

			self.medal_name:GetComponent("TextHorizonScroller"):SetText(var_19_1.title)

			local var_19_6 = 0

			for iter_19_0 = 1, #self.is_have_medal_list do
				var_19_6 = var_19_6 + self.is_have_medal_list[iter_19_0].level
			end

			self._control.medal_count.medal_count_number.text.text = tostring(var_19_6)

			if var_18_1[arg_19_1 + 1].level == 0 then
				self.bg.image.sprite = self:loadSprite(var_0_5.medal_cell_bg[2])
				self.medal_icon.image.material = self:loadMaterial(var_0_5.common_icon.icon_gray_material)
			end

			if var_18_1[arg_19_1 + 1].level ~= 0 then
				self.bg.image.sprite = self:loadSprite(var_0_5.medal_cell_bg[1])
				self.medal_icon.image.material = nil
			end

			local var_19_7 = var_18_1[arg_19_1 + 1].level

			if var_18_1[arg_19_1 + 1].level == 0 then
				var_19_7 = 1
			end

			self.medal_icon.image.sprite = self:loadSprite(string.format(var_0_5.medal_icon[1], var_18_1[arg_19_1 + 1].id, var_19_7))
			self.lv_text.text.text = "LV." .. var_19_7

			local var_19_8 = self:get_medal_counter(var_19_1.unlock[var_19_7].type, var_19_1.unlock[var_19_7].value1, var_19_1.unlock[var_19_7].value2, var_18_1[arg_19_1 + 1].level, var_19_1.unlock[var_19_7].value4, var_19_1.unlock[var_19_7].value3)

			if var_19_1.unlock[var_19_7].type == 3 then
				var_19_8 = 0

				for iter_19_1 = 1, #var_19_1.unlock do
					var_19_8 = self:get_medal_counter(3, var_19_1.unlock[iter_19_1].value1, var_19_1.unlock[iter_19_1].value2, iter_19_1, iter_19_1, var_19_1.unlock[iter_19_1].value3)
				end
			end

			if var_18_1[arg_19_1 + 1].level == 0 then
				if var_19_8 < var_19_5[var_19_7].value then
					self.get_btn:SetActive(false)

					self.medal_progress:GetComponent("Slider").value = var_19_8 / var_19_5[var_19_7].value
					self.medal_progress_text.text.text = var_19_8 .. "/" .. var_19_5[var_19_7].value
				end

				if var_19_8 >= var_19_5[var_19_7].value then
					self.get_btn:SetActive(true)

					self.medal_progress:GetComponent("Slider").value = 1
					self.medal_progress_text.text.text = var_19_8 .. "/" .. var_19_5[var_19_7].value
				end
			end

			if var_18_1[arg_19_1 + 1].level ~= 0 and var_18_1[arg_19_1 + 1].level < var_19_1.rls_level then
				if var_19_8 >= var_19_5[var_19_7].value and var_19_8 < var_19_5[var_19_7 + 1].value then
					self.get_btn:SetActive(false)

					self.medal_progress:GetComponent("Slider").value = var_19_8 / var_19_5[var_19_7 + 1].value
					self.medal_progress_text.text.text = var_19_8 .. "/" .. var_19_5[var_19_7 + 1].value
				end

				if var_19_8 >= var_19_5[var_19_7 + 1].value then
					self.get_btn:SetActive(true)

					self.medal_progress:GetComponent("Slider").value = 1
					self.medal_progress_text.text.text = var_19_8 .. "/" .. var_19_5[var_19_7 + 1].value
				end
			end

			for iter_19_2, iter_19_3 in pairs(var_18_2) do
				if iter_19_3.id ~= 1 and iter_19_3.id ~= 8 then
					if iter_19_3.level == var_19_7 and iter_19_3.id == var_18_1[arg_19_1 + 1].id then
						self.get_btn:SetActive(true)
					end

					if iter_19_3.level == var_18_1[arg_19_1 + 1].level and iter_19_3.id == var_18_1[arg_19_1 + 1].id then
						self.get_btn:SetActive(true)
					end
				end
			end

			if var_18_1[arg_19_1 + 1].level == var_19_1.rls_level then
				self.get_btn:SetActive(false)

				self.medal_progress:GetComponent("Slider").value = 1
				self.medal_progress_text.text.text = lx.split(lx.Time:getDateString(var_18_1[arg_19_1 + 1].time), " ")[1] .. var_0_2:getNowLang("logget")
			end

			if not self.dele_index then
				self.show_medal_list = {}

				for iter_19_4 = 1, #self.now_use_medal_list do
					self.show_medal_list[iter_19_4] = self.now_use_medal_list[iter_19_4]
				end
			end

			if self._now_label == 1 then
				self.info_btn.button.onClick:RemoveAllListeners()
				self.info_btn.button.onClick:AddListener(function()
					self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.open))
					self:set_medal_info(var_19_0.id, var_19_7, var_19_8)
				end)

				for iter_19_5 = 1, #self.now_use_medal_list do
					if self.now_use_medal_list[iter_19_5].id == var_18_1[arg_19_1 + 1].id then
						self.cover:SetActive(false)
						self.in_display:SetActive(true)
					end
				end

				self.get_btn.button.onClick:RemoveAllListeners()
				self.get_btn.button.onClick:AddListener(function()
					self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.open))
					var_0_1:req_UpgradeMedalReq({
						id = var_19_0.id
					})
					var_0_3:createInstance("reward_tip"):show(nil, 9, var_19_0.id, var_19_0.level)

					if var_19_0.level == 0 and #self.now_use_medal_list < 5 then
						var_0_7(self.show_medal_list, var_19_0)
						self:use_medal()
						self:set_user_madel_data()
						self:init_medal_cell_list()
					end
				end)
			else
				self.get_btn:SetActive(false)
				self.cover:SetActive(false)

				for iter_19_6 = 1, #self.now_use_medal_list do
					if self.now_use_medal_list[iter_19_6].id == var_18_1[arg_19_1 + 1].id then
						self.in_display:SetActive(true)
					end
				end

				for iter_19_7 = 1, #self.show_medal_list do
					if self.show_medal_list[iter_19_7].id == var_18_1[arg_19_1 + 1].id then
						self.cover:SetActive(true)

						self.cover.number.image.sprite = self:loadSprite(var_0_5:get_ship_icon(var_0_5.medal_pos[1], iter_19_7))
						self.now_cover_numbuer = iter_19_7
					end
				end

				self.info_btn.button.onClick:RemoveAllListeners()
				self.info_btn.button.onClick:AddListener(function()
					if #self.show_medal_list < 5 then
						self.cover:SetActive(true)
						var_0_7(self.show_medal_list, var_19_0)

						self.cover.number.image.sprite = self:loadSprite(var_0_5:get_ship_icon(var_0_5.medal_pos[1], #self.show_medal_list))
					end
				end)
				self.cover.button.onClick:RemoveAllListeners()
				self.cover.button.onClick:AddListener(function()
					self.cover:SetActive(false)

					for iter_23_0 = 1, #self.show_medal_list do
						if self.show_medal_list[iter_23_0].id == var_19_0.id then
							self.dele_index = iter_23_0
						end
					end

					var_0_10(self.show_medal_list, self.dele_index)
					self:set_user_madel_data()
					self:init_medal_cell_list()
				end)
			end
		end
	end

	function arg_1_0:supplement_medal(arg_24_1)
		if arg_24_1 then
			for iter_24_0 = 1, #self.is_have_medal_list do
				if #self.show_medal_list < 5 then
					for iter_24_1 = 1, #self.show_medal_list do
						if self.is_have_medal_list[iter_24_0].id == self.show_medal_list[iter_24_1].id then
							goto label_24_0
						end
					end

					var_0_7(self.show_medal_list, self.is_have_medal_list[iter_24_0])
				end

				::label_24_0::
			end
		end

		self:use_medal()
	end

	function arg_1_0.set_medal_info(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
		var_0_3:createInstance("medal_info"):show(arg_25_1, arg_25_2, arg_25_3)
	end

	function arg_1_0:use_medal()
		self.now_use_medal_id_list = {
			0,
			0,
			0,
			0,
			0
		}

		for iter_26_0 = 1, #self.show_medal_list do
			self.now_use_medal_id_list[iter_26_0] = self.show_medal_list[iter_26_0].id
		end

		var_0_1:req_ChangeMedalReq(self.now_use_medal_id_list)

		if var_0_3:getInstance("show_room") then
			-- block empty
		end

		self.show_medal_list = {}
		self._now_label = 1
	end

	function arg_1_0:set_user_madel_data()
		self.medal_config_list, medal_num = var_0_4:get_sequence()
		self.all_medal_list, medal_num = var_0_1:get_player_medal_data()
		self.now_use_medal_id_list, medal_num = var_0_1:get_player_show_medal_data()
		self.all_show_medal_list = {}
		self.is_have_medal_list = {}
		self.now_use_medal_list = {}
		self.not_have_medal_list = {}

		for iter_27_0 = 1, #self.medal_config_list + 10 do
			local var_27_0 = var_0_1:get_all_medal_by_id(iter_27_0)

			if var_27_0[1] then
				var_0_7(self.is_have_medal_list, var_27_0[#var_27_0])
				var_0_7(self.all_show_medal_list, var_27_0[#var_27_0])
			end
		end

		self:sort_rule(self.is_have_medal_list)
		self:sort_rule(self.all_show_medal_list)

		for iter_27_1 = 1, #self.medal_config_list do
			for iter_27_2 = 1, #self.all_show_medal_list do
				if self.medal_config_list[iter_27_1].id == self.all_show_medal_list[iter_27_2].id then
					goto label_27_0
				end
			end

			do
				local var_27_1 = {
					time = 0,
					level = 0,
					id = self.medal_config_list[iter_27_1].id
				}

				var_0_7(self.all_show_medal_list, var_27_1)
				var_0_7(self.not_have_medal_list, var_27_1)
			end

			::label_27_0::
		end

		self:sort_rule(self.all_show_medal_list)
		self:sort_rule(self.not_have_medal_list)

		if self._now_label == 1 then
			for iter_27_3 = 1, #self.now_use_medal_id_list do
				for iter_27_4 = 1, #self.is_have_medal_list do
					if self.now_use_medal_id_list[iter_27_3] == self.is_have_medal_list[iter_27_4].id then
						var_0_7(self.now_use_medal_list, self.is_have_medal_list[iter_27_4])
					end
				end
			end
		else
			for iter_27_5 = 1, #self.is_have_medal_list do
				for iter_27_6 = 1, #self.now_use_medal_id_list do
					if self.is_have_medal_list[iter_27_5].id == self.now_use_medal_id_list[iter_27_6] then
						var_0_7(self.now_use_medal_list, self.is_have_medal_list[iter_27_5])
					end
				end
			end
		end
	end

	function arg_1_0:change_medal_type(arg_28_1)
		self:set_user_madel_data()

		if arg_28_1 == 1 then
			self.now_tyep = 3
		end

		if arg_28_1 == 2 then
			self.now_tyep = 1
		end

		if arg_28_1 == 3 then
			self.now_tyep = 2
		end

		if self.now_tyep == 1 then
			self:init_medal_cell_list(2)

			self._control.type.type_bg.txt.text.text = var_0_2:getNowLang("medaltypegain")
			self.now_tyep = 2

			return
		end

		if self.now_tyep == 2 then
			self:init_medal_cell_list(3)

			self._control.type.type_bg.txt.text.text = var_0_2:getNowLang("medaltypeungain")
			self.now_tyep = 3

			return
		end

		if self.now_tyep == 3 then
			self:init_medal_cell_list(1)

			self._control.type.type_bg.txt.text.text = var_0_2:getNowLang("medaltypeall")
			self.now_tyep = 1

			return
		end
	end

	function arg_1_0.get_medal_counter(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5, arg_29_6)
		local var_29_0 = 0

		if arg_29_1 == 1 then
			if arg_29_2 == 1 then
				var_29_0 = #var_0_1:get_cardbook_ship_list()
			elseif arg_29_2 == 2 then
				var_29_0 = var_0_1:get_player_statistics_data().map_total
			elseif arg_29_2 == 3 then
				var_29_0 = var_0_1:get_player_statistics_data_by_type(11) + var_0_1:get_player_statistics_data_by_type(12) + var_0_1:get_player_statistics_data_by_type(16) + var_0_1:get_player_statistics_data_by_type(23) + var_0_1:get_player_statistics_data_by_type(24)
			elseif arg_29_2 == 4 then
				var_29_0 = var_0_1:get_player_statistics_data_by_type(7) + var_0_1:get_player_statistics_data_by_type(8) + var_0_1:get_player_statistics_data_by_type(9) + var_0_1:get_player_statistics_data_by_type(10) + var_0_1:get_player_statistics_data_by_type(25)
			elseif arg_29_2 == 5 then
				var_29_0 = var_0_1:get_player_statistics_data_by_type(1) + var_0_1:get_player_statistics_data_by_type(3) + var_0_1:get_player_statistics_data_by_type(4) + var_0_1:get_player_statistics_data_by_type(5) + var_0_1:get_player_statistics_data_by_type(6) + var_0_1:get_player_statistics_data_by_type(23)
			elseif arg_29_2 == 6 then
				var_29_0 = var_0_1:get_player_statistics_data_by_type(14) + var_0_1:get_player_statistics_data_by_type(15)
			elseif arg_29_2 == 7 then
				var_29_0 = var_0_1:get_player_statistics_data_by_type(1) + var_0_1:get_player_statistics_data_by_type(2) + var_0_1:get_player_statistics_data_by_type(3)
			elseif arg_29_2 == 8 then
				var_29_0 = var_0_1:get_player_statistics_data().build_ship
			elseif arg_29_2 == 9 then
				var_29_0 = var_0_1:get_player_statistics_data().task_total
			elseif arg_29_2 == 10 then
				var_29_0 = var_0_1:get_player_statistics_data().maneuver_win
			elseif arg_29_2 == 11 then
				var_29_0 = var_0_1:get_player_statistics_data().quick_repair
			elseif arg_29_2 == 12 then
				var_29_0 = var_0_1:get_player_statistics_data().quick_build
			elseif arg_29_2 == 13 then
				var_29_0 = var_0_1:get_player_statistics_data().love_point_100
			elseif arg_29_2 == 14 then
				var_29_0 = var_0_1:get_player_statistics_data().map_not_boss_complete
			elseif arg_29_2 == 15 then
				var_29_0 = var_0_1:get_player_statistics_data().map_flag_supply_ship
			elseif arg_29_2 == 16 then
				var_29_0 = var_0_1:get_player_statistics_data().crop_count
			end
		end

		if arg_29_1 == 2 and var_0_1:find_task_state(arg_29_2) == 2 then
			var_29_0 = 1
		end

		if arg_29_1 == 3 then
			if arg_29_6 == 1 and var_0_1:is_map_pass(arg_29_2, arg_29_3) == true then
				var_29_0 = arg_29_4
			elseif arg_29_6 == 15 and var_0_1:seven_map_is_pass(arg_29_2) == true then
				var_29_0 = 1
			elseif arg_29_6 == 16 and var_0_1:score_map_is_pass(arg_29_2) and var_0_1:score_map_node_pass_boss(nil, arg_29_3) then
				var_29_0 = 1
			elseif arg_29_6 == 17 and var_0_1:eighth_map_is_pass(arg_29_2) == true then
				var_29_0 = 1
			elseif arg_29_6 == 19 and var_0_1:ninth_map_is_pass(arg_29_2) == true then
				var_29_0 = 1
			end
		end

		if arg_29_1 == 4 and var_0_1:get_sixth_point_pass_by_grade(arg_29_2, arg_29_3, arg_29_5) then
			var_29_0 = 1
		end

		if arg_29_1 == 5 then
			if var_0_1:get_strike_map_point_pass_by_state_1(arg_29_2, arg_29_3, arg_29_5) then
				var_29_0 = 1
			end

			if var_0_1:get_strike_map_point_pass_by_state_2(arg_29_2, arg_29_3, arg_29_5) then
				var_29_0 = 1
			end
		end

		return var_29_0
	end

	function arg_1_0:__init_panel()
		self.now_use_medal_list = {}
		self.now_tyep = 1
		self._control.type.type_bg.txt.text.text = var_0_2:getNowLang("medaltypeall")

		self:set_user_madel_data()
		self:show_scroll_by_index(1)
		self:init_cell()
		self:init_medal_cell_list(1)

		self._control.bg.top_menu.medal_list_text.text.text = var_0_2:getNowLang("medallisttitle")
		self._control.medal_count.medal_count_text.text.text = var_0_2:getNowLang("medallistitem")
		self._control.type.type_text.text.text = var_0_2:getNowLang("ui_collectionviewtip")
		self._control.use_medal.use_medal_text.text.text = var_0_2:getNowLang("confirm")
		self._control.bg.top_menu.tips.text.text = var_0_2:getNowLang("selectdisplaymedal")
		self._control.supplement_tips.base_panel.title.text.text = var_0_2:getNowLang("tipmessage")
		self._control.supplement_tips.supplement_btn.txt.text.text = var_0_2:getNowLang("ensure")
		self._control.supplement_tips.cancel_btn.txt.text.text = var_0_2:getNowLang("cancel")
	end

	function arg_1_0:_play_into_se(arg_31_1)
		self:playSE(arg_31_1, false)
	end

	function arg_1_0:__onReset()
		self:play_in_animation_2(self:play_out_animation_2())
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_33_0)
	local var_33_0 = var_0_3:class("show_room_medal")

	var_33_0._is_already_init = false
	var_33_0._reusable_cell_1 = nil
	var_33_0._reusable_cell_2 = nil
	var_33_0._now_label = nil
	var_33_0.medal_config_list = {}
	var_33_0.is_have_medal_list = {}
	var_33_0.not_have_medal_list = {}
	var_33_0.show_medal_list = {}
	var_33_0.all_medal_list = {}
	var_33_0.now_tyep = 1
	var_33_0.now_use_medal_list = {}
	var_33_0.dele_index = nil

	return var_33_0
end

return var_0_0
