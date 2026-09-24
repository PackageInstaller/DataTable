local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_5 = gameenum.common_type
local var_0_6 = string.format
local var_0_7 = table.insert
local var_0_9 = gameconfig.ship_config
local var_0_10 = gameconfig.equip_config
local var_0_11 = gameconfig.ship_pve_active_config
local var_0_12 = DG.Tweening.DOTween
local var_0_13 = lx.json_decode
local var_0_14 = gameconfig
local var_0_15 = UnityEngine.Vector2
local var_0_16 = UnityEngine.Vector3
local var_0_18 = gamecore.util_func
local var_0_19 = UnityEngine.Handheld
local var_0_20 = gamecore.UserDataManager
local var_0_21 = UnityEngine.FullScreenMovieControlMode
local var_0_22 = UnityEngine.Color
local var_0_23 = gameconfig.pve_score_level_config
local var_0_24 = gameconfig.score_map_node_config
local var_0_25 = gameconfig.pve_guide_config
local var_0_26 = gameconfig.pve_score_task_config
local var_0_27 = gameconfig.pve_score_buff_config
local var_0_28 = gameconfig.pve_score_award_config
local var_0_29 = gameconfig.ship_rule_config

gamecore.UILoader:define("score_push_map", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		if var_0_2:getInstance("combat_result") then
			var_0_2:destroyInstance("combat_result")
		end

		if arg_2_1 then
			self._active_id = arg_2_1
		else
			local var_2_0 = var_0_29.find_object_by_id(var_0_5.pve_init_active_id.score_event).content

			if var_2_0 and next(var_2_0) then
				self._active_id = var_2_0.activeId
			end
		end

		self:setVisible(true)
		var_0_3:set_to_score(true)
		self:_init_panel()
		self:get_answer_all_score()
		self:__finish_special_task()

		self._panel.transform:GetComponent("Canvas").sortingOrder = 500
	end

	function arg_1_0:__init_map_num()
		if self._have_map_num == 4 then
			self._control.main.middle.map:SetActive(true)
			self._control.main.middle.map_2:SetActive(true)
			self._control.main.middle.map_3:SetActive(false)
			self._control.main.middle.map_4:SetActive(false)
		elseif self._have_map_num == 6 then
			self._control.main.middle.map:SetActive(false)
			self._control.main.middle.map_2:SetActive(false)
			self._control.main.middle.map_3:SetActive(true)
			self._control.main.middle.map_4:SetActive(true)
		end
	end

	function arg_1_0:_set_init_panel()
		local var_4_0 = var_0_3:get_come_in_score_panel_id()

		if var_4_0 then
			if var_4_0 >= self.map_fight_prepare_id + self._have_map_num and var_0_3:is_score_map_pass(self._default_map_id - 1) then
				self:__switch_map_state()
			end
		end
	end

	function arg_1_0:_init_panel()
		var_0_3:req_AnswerGuideReq()

		self._active_config = var_0_11.find_object_by_id(self._active_id)
		self.map_fight_prepare_id = self._active_config.map_id
		self._active_map_id = self._active_config.map_id
		self._default_map_id = self._active_config.hardLevels[1]
		self._have_init_num = self._default_map_id - 10207

		if not self._is_init then
			self:__initial_func()
			self:__init_data()
			self:__init_active()
			self:__init_position(self._big_normal_map_data)

			self._is_init = true
		end

		self:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, self._active_config.bgm))
		self:__init_anim()

		self.__now_state = self:__pass_all_normal_map() and 2 or 1

		local var_5_0 = var_0_3:get_battle_info()

		if var_5_0 and next(var_5_0) then
			if var_5_0.id >= self.map_fight_prepare_id and var_5_0.id <= self._default_map_id - 1 then
				self.__now_state = 1
			elseif var_5_0.id >= self.map_fight_prepare_id + self._have_map_num - 1 and var_5_0.id <= self._default_map_id + self._have_map_num - 1 then
				self.__now_state = 2
			end
		end

		self:__normal_or_hard()
		self:__destroy_pool()
		self:__preload_map_fragment()
		self:__show_next_map()
		self:__show_answer_award_tips()
	end

	function arg_1_0:__normal_or_hard()
		if self.__now_state == 1 then
			self:__init_content(self._big_normal_map_data)

			self._control.main.top.title_bg.image.sprite = self:loadSprite(var_0_5.forth_title_bg.normal)
		else
			self:__init_content(self._big_hard_map_data)

			self._control.main.top.title_bg.image.sprite = self:loadSprite(var_0_5.forth_title_bg.hard)
		end

		self._control.active_bg.gameObject:SetActive(self.__now_state == 1)
		self._control.active_hard_bg.gameObject:SetActive(self.__now_state == 2)
		self._control.main.bottom.hard_btn.gameObject:SetActive(false)

		if var_0_3:is_score_map_pass(self._default_map_id - 1) then
			self._control.main.bottom.hard_btn.gameObject:SetActive(self.__now_state == 1)
		end

		self._control.main.bottom.normal_btn.gameObject:SetActive(self.__now_state == 2)
	end

	function arg_1_0:__init_data()
		self._control.pass_map:SetActive(false)

		self._user_data = var_0_3:get_score_map_data()
		self.__map_list = {
			self._control.main.middle.map._10201,
			self._control.main.middle.map._10202,
			self._control.main.middle.map._10203,
			self._control.main.middle.map._10204
		}
		self.__map_list_max = {
			self._control.main.middle.map_4._10201,
			self._control.main.middle.map_4._10202,
			self._control.main.middle.map_4._10203,
			self._control.main.middle.map_4._10204,
			self._control.main.middle.map_4._10205,
			self._control.main.middle.map_4._10206
		}
		self.__map_list_2_max = {
			self._control.main.middle.map_3._10201_,
			self._control.main.middle.map_3._10202_,
			self._control.main.middle.map_3._10203_,
			self._control.main.middle.map_3._10204_,
			self._control.main.middle.map_3._10205_,
			self._control.main.middle.map_3._10206_
		}
		self.__map_list_2 = {
			self._control.main.middle.map_2._10201_,
			self._control.main.middle.map_2._10202_,
			self._control.main.middle.map_2._10203_,
			self._control.main.middle.map_2._10204_
		}
		self.__map_btn_list = {
			self._control.main.middle.btns._10201_btn1,
			self._control.main.middle.btns._10202_btn1,
			self._control.main.middle.btns._10203_btn1,
			self._control.main.middle.btns._10204_btn1,
			self._control.main.middle.btns._10205_btn1,
			self._control.main.middle.btns._10206_btn1
		}
		self.__map_name_bg_list = {
			self._control.main.middle.map_name1.map_name_bg_1,
			self._control.main.middle.map_name1.map_name_bg_2,
			self._control.main.middle.map_name1.map_name_bg_3,
			self._control.main.middle.map_name1.map_name_bg_4,
			self._control.main.middle.map_name1.map_name_bg_5,
			self._control.main.middle.map_name1.map_name_bg_6
		}
		self.__map_name2_list = {
			self._control.main.middle.map_name2._10201_2,
			self._control.main.middle.map_name2._10202_2,
			self._control.main.middle.map_name2._10203_2,
			self._control.main.middle.map_name2._10204_2,
			self._control.main.middle.map_name2._10205_2,
			self._control.main.middle.map_name2._10206_2
		}
		self.__map_score_list = {
			self._control.main.middle.map_score.score1,
			self._control.main.middle.map_score.score2,
			self._control.main.middle.map_score.score3,
			self._control.main.middle.map_score.score4,
			self._control.main.middle.map_score.score5,
			self._control.main.middle.map_score.score6
		}
		self._node_data = var_0_24.get_sequence()
		self._big_normal_map_data = {}
		self._big_hard_map_data = {}
		self._normal_node_data = {}
		self._hard_node_data = {}

		self:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, self._active_config.bgm))

		for iter_7_0, iter_7_1 in pairs(self._active_config.levels) do
			var_0_7(self._big_normal_map_data, var_0_23.find_object_by_id(iter_7_1))

			for iter_7_2 = 1, #self._node_data do
				if self._node_data[iter_7_2].pve_level_id == iter_7_1 then
					if self._normal_node_data[iter_7_1] == nil then
						self._normal_node_data[iter_7_1] = {}
					end

					var_0_7(self._normal_node_data[iter_7_1], self._node_data[iter_7_2])
				end
			end
		end

		for iter_7_3, iter_7_4 in pairs(self._active_config.hardLevels) do
			var_0_7(self._big_hard_map_data, var_0_23.find_object_by_id(iter_7_4))

			for iter_7_5 = 1, #self._node_data do
				if self._node_data[iter_7_5].pve_level_id == iter_7_4 then
					if self._hard_node_data[iter_7_4] == nil then
						self._hard_node_data[iter_7_4] = {}
					end

					var_0_7(self._hard_node_data[iter_7_4], self._node_data[iter_7_5])
				end
			end
		end

		self.__btn_state = 1

		self._control.score_map_detail:SetActive(false)
	end

	function arg_1_0:__tween_score_guide_ainimation(arg_8_1)
		arg_8_1 = arg_8_1 or 1

		local var_8_0 = var_0_25.find_object_by_guide_id(self._active_config.guide_id * 100 + arg_8_1)
		local var_8_1 = tonumber(var_0_18.utf8sub(var_8_0.pic_id, 2, 2))

		self._control.instructions.page.page_1.text.text = arg_8_1

		self._control.instructions.prev:SetActive(arg_8_1 ~= 1)
		self._control.instructions.next:SetActive(arg_8_1 ~= 5)

		self._control.instructions.main.main_tip.main_pic.image.sprite = self:loadSprite(var_0_6(var_0_5.score_instructions_pic, var_8_1))
		self._control.instructions.score_guide_txt.text.text = var_0_1:convert_rich_text(var_8_0.desc, true)
		self._control.instructions.main.main_instructions_title.text.text = var_0_1:convert_rich_text(var_8_0.title, true)
	end

	function arg_1_0:__tween_score_guide_ainimation_2(arg_9_1)
		local var_9_0 = self:autoKillDOTween(var_0_12.Sequence())
		local var_9_1 = self._control.score_guide

		if arg_9_1 then
			self._control.score_guide:SetActive(true)
			self._control.shadow:SetActive(true)

			self._control.score_guide.transform.localScale = var_0_15.New(0.1, 0.1)

			var_9_0:Append(self._control.score_guide.transform:DOScale(1.1, 0.15)):SetEase(DG.Tweening.Ease.InOutElastic)
			var_9_0:Append(self._control.score_guide.transform:DOScale(1, 0.05)):SetEase(DG.Tweening.Ease.InOutQuad)
		else
			var_9_0:Append(self._control.score_guide.transform:DOScale(0.3, 0.2)):SetEase(DG.Tweening.Ease.InExpo)
			var_9_0:AppendCallback(function()
				var_9_1:SetActive(false)
				self._control.shadow:SetActive(false)
			end)
			var_0_3:req_AnswerRemindReq()
		end

		var_9_0:Play()
	end

	function arg_1_0:__init_active()
		if self._have_map_num == 4 then
			for iter_11_0 = 1, #self.__map_name2_list do
				self.__map_name2_list[iter_11_0].gameObject:SetActive(self.__map_list[iter_11_0].gameObject.activeSelf)
			end

			for iter_11_1 = 1, #self.__map_btn_list do
				self.__map_btn_list[iter_11_1].gameObject:SetActive(self.__map_list[iter_11_1].gameObject.activeSelf)
			end
		elseif self._have_map_num == 6 then
			for iter_11_2 = 1, #self.__map_name2_list do
				self.__map_name2_list[iter_11_2].gameObject:SetActive(self.__map_list_max[iter_11_2].gameObject.activeSelf)
			end

			for iter_11_3 = 1, #self.__map_btn_list do
				self.__map_btn_list[iter_11_3].gameObject:SetActive(self.__map_list_max[iter_11_3].gameObject.activeSelf)
			end
		end
	end

	function arg_1_0:__show_next_map()
		local var_12_0 = {}
		local var_12_1 = {}

		if self._have_map_num == 4 then
			for iter_12_0, iter_12_1 in pairs(self.__map_list) do
				iter_12_1.gameObject:SetActive(true)
			end

			for iter_12_2, iter_12_3 in pairs(self.__map_list_2) do
				iter_12_3.gameObject:SetActive(false)
			end
		elseif self._have_map_num == 6 then
			for iter_12_4, iter_12_5 in pairs(self.__map_list_max) do
				iter_12_5.gameObject:SetActive(true)
			end

			for iter_12_6, iter_12_7 in pairs(self.__map_list_2_max) do
				iter_12_7.gameObject:SetActive(false)
			end
		end

		for iter_12_8, iter_12_9 in pairs(self.__map_btn_list) do
			iter_12_9.gameObject:SetActive(false)
		end

		if self.__now_state == 1 then
			for iter_12_10, iter_12_11 in pairs(self._user_data) do
				for iter_12_12, iter_12_13 in pairs(iter_12_11.boss_hp) do
					if iter_12_10 >= self._default_map_id - self._have_map_num and iter_12_10 < self._default_map_id and iter_12_13.hp == 0 then
						table.insert(var_12_0, iter_12_13.id)
					end
				end

				for iter_12_14, iter_12_15 in pairs(iter_12_11.start_point) do
					if iter_12_11.id < self._default_map_id and iter_12_11.id >= self._default_map_id - self._have_map_num then
						local var_12_2 = var_0_23.find_object_by_id(iter_12_11.id)

						if var_12_2.line[tostring(iter_12_15)] then
							var_12_1[iter_12_15] = var_12_2.line[tostring(iter_12_15)]
						end
					end
				end
			end
		else
			for iter_12_16, iter_12_17 in pairs(self._user_data) do
				for iter_12_18, iter_12_19 in pairs(iter_12_17.boss_hp) do
					if iter_12_16 >= self._default_map_id - 1 and iter_12_19.hp == 0 then
						table.insert(var_12_0, iter_12_19.id)
					end
				end

				for iter_12_20, iter_12_21 in pairs(iter_12_17.start_point) do
					if iter_12_17.id >= self._default_map_id then
						local var_12_3 = var_0_23.find_object_by_id(iter_12_17.id)

						if var_12_3.line[tostring(iter_12_21)] then
							var_12_1[iter_12_21] = var_12_3.line[tostring(iter_12_21)]
						end
					end
				end
			end
		end

		for iter_12_22, iter_12_23 in ipairs(self.__map_name_bg_list) do
			iter_12_23:SetActive(false)
		end

		if self._have_map_num == 4 then
			self.__map_list[1].gameObject:SetActive(false)
			self.__map_list_2[1].gameObject:SetActive(true)
			self.__map_name_bg_list[1].gameObject:SetActive(true)
		elseif self._have_map_num == 6 then
			self.__map_list_max[1].gameObject:SetActive(false)
			self.__map_list_2_max[1].gameObject:SetActive(true)
			self.__map_name_bg_list[1].gameObject:SetActive(true)
		end

		self.__map_btn_list[1].gameObject:SetActive(true)

		for iter_12_24, iter_12_25 in pairs(var_12_0) do
			local var_12_4 = string.sub(var_0_24.find_object_by_id_start_node_id(iter_12_25, (var_0_24.get_start_node_id_by_id(iter_12_25))).next_level_node, 1, 5)

			if self.__now_state == 1 then
				-- block empty
			else
				var_12_4 = var_12_4 - (self._have_init_num + 6)
			end

			if self._have_map_num == 4 then
				for iter_12_26, iter_12_27 in ipairs(self.__map_list) do
					if self.__now_state == 1 then
						if "_" .. var_12_4 == iter_12_27.gameObject.name then
							iter_12_27.gameObject:SetActive(false)
						end
					elseif "_" .. var_12_4 - 4 == iter_12_27.gameObject.name then
						iter_12_27.gameObject:SetActive(false)
					end
				end

				for iter_12_28, iter_12_29 in ipairs(self.__map_list_2) do
					if self.__now_state == 1 then
						if "_" .. var_12_4 .. "_" == iter_12_29.gameObject.name then
							self.__map_name_bg_list[iter_12_28]:SetActive(true)
							iter_12_29.gameObject:SetActive(true)
						end
					elseif "_" .. var_12_4 - 4 .. "_" == iter_12_29.gameObject.name then
						self.__map_name_bg_list[iter_12_28]:SetActive(true)
						iter_12_29.gameObject:SetActive(true)
					end
				end
			elseif self._have_map_num == 6 then
				for iter_12_30, iter_12_31 in ipairs(self.__map_list_max) do
					if self.__now_state == 1 then
						if "_" .. var_12_4 - self._have_init_num == iter_12_31.gameObject.name then
							iter_12_31.gameObject:SetActive(false)
						end
					elseif "_" .. var_12_4 == iter_12_31.gameObject.name then
						iter_12_31.gameObject:SetActive(false)
					end
				end

				for iter_12_32, iter_12_33 in ipairs(self.__map_list_2_max) do
					if self.__now_state == 1 then
						if "_" .. var_12_4 - self._have_init_num .. "_" == iter_12_33.gameObject.name then
							self.__map_name_bg_list[iter_12_32]:SetActive(true)
							iter_12_33.gameObject:SetActive(true)
						end
					elseif "_" .. var_12_4 .. "_" == iter_12_33.gameObject.name then
						self.__map_name_bg_list[iter_12_32]:SetActive(true)
						iter_12_33.gameObject:SetActive(true)
					end
				end
			end

			for iter_12_34, iter_12_35 in ipairs(self.__map_btn_list) do
				if self.__now_state == 1 then
					if "_" .. var_12_4 - self._have_init_num .. "_" .. "btn1" == iter_12_35.gameObject.name then
						iter_12_35.gameObject:SetActive(true)
					end
				elseif "_" .. var_12_4 .. "_" .. "btn1" == iter_12_35.gameObject.name then
					iter_12_35.gameObject:SetActive(true)
				end
			end
		end

		for iter_12_36, iter_12_37 in pairs(var_12_1) do
			local var_12_6, var_12_7 = self:__load_map_fragment_with_pool("score_map_line_obj", self._control.score_main_line.transform)

			var_12_6:setVisible(true)

			var_12_7.line_image.rectTransform.parent.offsetMin = var_0_15(0, 0)
			var_12_7.line_image.rectTransform.parent.offsetMax = var_0_15(0, 0)
			var_12_7.line_image.rectTransform.anchoredPosition = var_0_15(iter_12_37[1], -iter_12_37[2])
			var_12_7.line_image.image.sprite = self:loadSprite((string.format(self.__now_state == 1 and var_0_5.score_normal_mapline_path or var_0_5.score_hard_mapline_path, iter_12_36)))

			var_12_7.line_image.image:SetNativeSize()
			var_12_7.line_image:SetActive(true)
			self:__shining_line(var_12_7)
		end
	end

	function arg_1_0:__shining_line(arg_13_1)
		local var_13_0 = self:autoKillDOTween(var_0_12.Sequence())

		var_13_0:Append(arg_13_1.line_image.image:DOFade(0.25, 1))
		var_13_0:Append(arg_13_1.line_image.image:DOFade(1, 1))
		var_13_0:Append(arg_13_1.line_image.image:DOFade(1, 0.25))
		var_13_0:SetLoops(-1)
		var_13_0:Play()
		var_0_7(self._light_seq, var_13_0)
	end

	function arg_1_0:__init_position(arg_14_1)
		if self._have_map_num == 4 then
			for iter_14_0 = 1, #self.__map_list do
				self.__map_list[iter_14_0].rectTransform.anchoredPosition = var_0_15(arg_14_1[iter_14_0].position.x, -arg_14_1[iter_14_0].position.y)
			end

			for iter_14_1 = 1, #self.__map_list_2 do
				self.__map_list_2[iter_14_1].rectTransform.anchoredPosition = var_0_15(arg_14_1[iter_14_1].map.x, -arg_14_1[iter_14_1].map.y)
			end
		elseif self._have_map_num == 6 then
			for iter_14_2 = 1, #self.__map_list_max do
				self.__map_list_max[iter_14_2].rectTransform.anchoredPosition = var_0_15(arg_14_1[iter_14_2].position.x, -arg_14_1[iter_14_2].position.y)
				self.__map_list_max[iter_14_2].image.alphaHitTestMinimumThreshold = 0.1
			end

			for iter_14_3 = 1, #self.__map_list_2_max do
				self.__map_list_2_max[iter_14_3].rectTransform.anchoredPosition = var_0_15(arg_14_1[iter_14_3].map.x, -arg_14_1[iter_14_3].map.y)
			end
		end

		for iter_14_4 = 1, #self.__map_btn_list do
			self.__map_btn_list[iter_14_4].rectTransform.anchoredPosition = var_0_15(arg_14_1[iter_14_4].position.x, -arg_14_1[iter_14_4].position.y)
			self.__map_btn_list[iter_14_4].image.alphaHitTestMinimumThreshold = 0.1
		end

		for iter_14_5 = 1, #self.__map_name_bg_list do
			self.__map_name_bg_list[iter_14_5].rectTransform.anchoredPosition = var_0_15(arg_14_1[iter_14_5].name_position.x, -arg_14_1[iter_14_5].name_position.y)
		end

		for iter_14_6 = 1, #self.__map_score_list do
			self.__map_score_list[iter_14_6].rectTransform.anchoredPosition = var_0_15(arg_14_1[iter_14_6].name_position.x, -arg_14_1[iter_14_6].name_position.y)
		end
	end

	function arg_1_0:__init_content(arg_15_1)
		for iter_15_0 = 1, #arg_15_1 do
			-- block empty
		end

		local var_15_1 = 0

		for iter_15_1 = 1, #arg_15_1 do
			var_15_1 = var_15_1 + arg_15_1[iter_15_1].total_treasure
		end

		self._control.score_guide.guidecontent.guidetext.text.text = string.gsub(var_0_1:convert_rich_text(self._active_config.desc), ";", "\n")
		self._control.main.top.title_bg.title_text.text.text = self._active_config.title

		for iter_15_2 = 1, #self.__map_name_bg_list do
			self.__map_name_bg_list[iter_15_2].scroller:GetComponent("TextHorizonScroller"):SetText(arg_15_1[iter_15_2].title .. "  " .. arg_15_1[iter_15_2].sub_title)
		end

		for iter_15_3 = 1, #self.__map_name2_list do
			self.__map_name2_list[iter_15_3].text.text = arg_15_1[iter_15_3].sub_title2
		end

		local var_15_3 = var_0_3:get_score_map_box_list()
		local var_15_4 = 0

		if next(var_15_3) then
			for iter_15_4, iter_15_5 in pairs(var_15_3) do
				if iter_15_4 == arg_15_1[1].map_id then
					var_15_4 = var_15_4 + 1
				end

				if iter_15_4 == arg_15_1[2].map_id then
					var_15_4 = var_15_4 + 1
				end

				if iter_15_4 == arg_15_1[3].map_id then
					var_15_4 = var_15_4 + 1
				end

				if iter_15_4 == arg_15_1[4].map_id then
					var_15_4 = var_15_4 + 1
				end

				if self._have_map_num == 6 then
					if iter_15_4 == arg_15_1[5].map_id then
						var_15_4 = var_15_4 + 1
					end

					if iter_15_4 == arg_15_1[6].map_id then
						var_15_4 = var_15_4 + 1
					end
				end
			end
		end

		self._control.box_num.box_num_text.text.text = var_15_4 .. "/" .. var_15_1

		local var_15_5
		local var_15_6

		if self.__now_state == 1 then
			var_15_5 = self._big_normal_map_data
			var_15_6 = self._default_map_id - self._have_map_num
		else
			var_15_5 = self._big_hard_map_data
			var_15_6 = self._default_map_id
		end

		self.user_point_list = {
			cur_point = {},
			total_score = {}
		}

		for iter_15_6, iter_15_7 in pairs(var_15_5) do
			table.insert(self.user_point_list.total_score, iter_15_7.total_score)
		end

		local var_15_7 = var_0_3:get_score_map_point_list()

		for iter_15_8 = var_15_6, var_15_6 + 5 do
			if var_15_7[iter_15_8] then
				table.insert(self.user_point_list.cur_point, var_15_7[iter_15_8])
			else
				table.insert(self.user_point_list.cur_point, 0)
			end
		end

		self.user_box_list = {
			cur_box = {},
			total_treasure = {}
		}

		for iter_15_9, iter_15_10 in pairs(var_15_5) do
			table.insert(self.user_box_list.total_treasure, iter_15_10.total_treasure)
		end

		local var_15_8 = var_0_3:get_score_map_box_list()

		for iter_15_11 = var_15_6, var_15_6 + 5 do
			if var_15_8[iter_15_11] then
				table.insert(self.user_box_list.cur_box, var_15_8[iter_15_11])
			else
				table.insert(self.user_box_list.cur_box, 0)
			end
		end

		for iter_15_12 = 1, #self.__map_score_list do
			self.__map_score_list[iter_15_12].point_num.text.text = (self.user_point_list.cur_point[iter_15_12] ~= self.user_point_list.total_score[iter_15_12] and self.user_point_list.cur_point[iter_15_12] or var_0_6("<color=#%s>%s</color>", "A4FF79", self.user_point_list.cur_point[iter_15_12])) .. "/" .. self.user_point_list.total_score[iter_15_12]
			self.__map_score_list[iter_15_12].box_num.text.text = (self.user_box_list.cur_box[iter_15_12] ~= self.user_box_list.total_treasure[iter_15_12] and self.user_box_list.cur_box[iter_15_12] or var_0_6("<color=#%s>%s</color>", "A4FF79", self.user_box_list.cur_box[iter_15_12])) .. "/" .. self.user_box_list.total_treasure[iter_15_12]
		end
	end

	function arg_1_0:__init_map_detail_content(arg_16_1, arg_16_2)
		self._control.score_map_detail.main.map_panel.map_image.image.sprite = self:loadSprite(var_0_6(var_0_5.map_path_score, arg_16_1[arg_16_2].map_id, arg_16_1[arg_16_2].map_id))

		self._control.score_map_detail.main.title_bg:GetComponent("TextHorizonScroller"):SetText(arg_16_1[arg_16_2].title .. "  " .. arg_16_1[arg_16_2].sub_title)

		self._control.score_map_detail.main.right.icon_box.icon_box_num_1.text.text = var_0_6("<color=#%s>%s</color>", "0099FF", self.user_point_list.cur_point[arg_16_2])
		self._control.score_map_detail.main.right.icon_box.icon_box_num_2.text.text = "/" .. arg_16_1[arg_16_2].score_max
		self._control.score_map_detail.main.right.score_num.score_num_1.text.text = var_0_6("<color=#%s>%s</color>", "0099FF", self.user_box_list.cur_box[arg_16_2])
		self._control.score_map_detail.main.right.score_num.score_num_2.text.text = "/" .. arg_16_1[arg_16_2].total_treasure
		self._control.score_map_detail.main.right.point_bg.select_1.text.text = var_0_6(var_0_1:getNowLang("ui_4th_enter_button_title"), var_0_24.find_object_by_id_start_node_id(arg_16_1[arg_16_2].init_nodes[1], arg_16_1[arg_16_2].init_nodes[1]).flag)
		self._control.score_map_detail.main.right.point_bg.point_icon.image.sprite = self:loadSprite(var_0_5.score_bg_path.active)

		local var_16_0 = {}

		for iter_16_0, iter_16_1 in pairs(self._normal_node_data) do
			for iter_16_2, iter_16_3 in pairs(iter_16_1) do
				if iter_16_3.next_level_node ~= 0 and var_0_3:score_map_node_pass_boss(iter_16_3.start_node_id, iter_16_3.id) then
					table.insert(var_16_0, iter_16_3.next_level_node)
				end
			end
		end

		for iter_16_4, iter_16_5 in pairs(self._hard_node_data) do
			for iter_16_6, iter_16_7 in pairs(iter_16_5) do
				if iter_16_7.next_level_node ~= 0 and var_0_3:score_map_node_pass_boss(iter_16_7.start_node_id, iter_16_7.id) then
					table.insert(var_16_0, iter_16_7.next_level_node)
				end
			end
		end

		local var_16_1 = self._control.score_map_detail.main.right.point_bg.point_bg_2
		local var_16_2 = self._control.score_map_detail.main.right.point_bg

		self._control.lock_1:SetActive(false)
		self._control.lock_2:SetActive(false)

		if #arg_16_1[arg_16_2].init_nodes > 1 then
			local var_16_5 = false
			local var_16_6 = false
			local var_16_7
			local var_16_8
			local var_16_9
			local var_16_10

			table.sort(arg_16_1[arg_16_2].init_nodes)

			if var_0_18.have_data(var_16_0, arg_16_1[arg_16_2].init_nodes[1]) then
				var_16_5 = true
			end

			if var_0_18.have_data(var_16_0, arg_16_1[arg_16_2].init_nodes[2]) then
				var_16_6 = true
			end

			if not var_16_5 and not var_16_6 then
				var_16_9 = self:loadSprite(var_0_5.score_bg_path.unselected)
				var_16_10 = var_0_23.find_object_by_id(arg_16_1[arg_16_2].map_id).nodes_desc[2]
				var_16_8 = var_0_23.find_object_by_id(arg_16_1[arg_16_2].map_id).nodes_desc[1]
			elseif var_16_5 and not var_16_6 then
				var_16_9 = self:loadSprite(var_0_5.score_bg_path.unselected)
				var_16_10 = var_0_23.find_object_by_id(arg_16_1[arg_16_2].map_id).nodes_desc[2]
				var_16_7 = self:loadSprite(var_0_5.score_bg_path.active)
				var_16_8 = var_0_6(var_0_1:getNowLang("ui_4th_enter_button_title"), var_0_24.find_object_by_id_start_node_id(arg_16_1[arg_16_2].init_nodes[1], arg_16_1[arg_16_2].init_nodes[1]).flag)
			elseif var_16_6 and not var_16_5 then
				var_16_9 = self:loadSprite(var_0_5.score_bg_path.active)
				var_16_10 = var_0_6(var_0_1:getNowLang("ui_4th_enter_button_title"), var_0_24.find_object_by_id_start_node_id(arg_16_1[arg_16_2].init_nodes[2], arg_16_1[arg_16_2].init_nodes[1]).flag)
				var_16_7 = self:loadSprite(var_0_5.score_bg_path.unselected)
				var_16_8 = var_0_23.find_object_by_id(arg_16_1[arg_16_2].map_id).nodes_desc[1]
			else
				var_16_9 = self:loadSprite(var_0_5.score_bg_path.unselected)
				var_16_10 = var_0_6(var_0_1:getNowLang("ui_4th_enter_button_title"), var_0_24.find_object_by_id_start_node_id(arg_16_1[arg_16_2].init_nodes[2], arg_16_1[arg_16_2].init_nodes[1]).flag)
				var_16_7 = self:loadSprite(var_0_5.score_bg_path.active)
				var_16_8 = var_0_6(var_0_1:getNowLang("ui_4th_enter_button_title"), var_0_24.find_object_by_id_start_node_id(arg_16_1[arg_16_2].init_nodes[1], arg_16_1[arg_16_2].init_nodes[1]).flag)
			end

			var_16_1.image.sprite = var_16_9

			if var_16_10 == "" or var_16_10 == " " then
				var_16_1.select_2.text.text = "---"
			else
				self._control.lock_2:SetActive(var_16_6 == false)

				var_16_1.select_2.text.text = var_16_10
			end

			if var_16_8 == "" or var_16_8 == " " then
				var_16_2.select_1.text.text = "---"
			else
				self._control.lock_1:SetActive(var_16_5 == false)

				var_16_2.select_1.text.text = var_16_8
			end

			var_16_2.point_icon.image.sprite = var_16_7
			var_16_2.point_icon.button.interactable = var_16_5
			var_16_1.button.interactable = var_16_6
			self._is_unlocked_1 = var_16_5
			self._is_unlocked_2 = var_16_6

			if var_16_5 == false and var_16_6 == true then
				self:__switch_enter_point(2)
			end
		else
			var_16_2.point_icon.button.interactable = true
			var_16_1.image.sprite = self:loadSprite(var_0_5.score_bg_path.unselected)
			var_16_1.select_2.text.text = "---"
		end

		self._control.score_map_detail.main.bottom.desc.text.text = var_0_18.convert_rich_text(arg_16_1[arg_16_2].tips)

		for iter_16_8, iter_16_9 in ipairs(arg_16_1[arg_16_2].boss) do
			local var_16_11, var_16_12 = self:__load_map_fragment_with_pool("score_boss_node_obj", self._control.score_map_detail.main.map_panel.map_node_root.transform)

			var_16_11:setVisible(true)

			var_16_12.boss_icon.rectTransform.parent.offsetMin = var_0_15(0, 0)
			var_16_12.boss_icon.rectTransform.parent.offsetMax = var_0_15(0, 0)
			var_16_12.boss_icon.rectTransform.anchoredPosition = self:__get_real_node_pos(self._control.score_map_detail.main.map_panel.rectTransform.rect.width, self._control.score_map_detail.main.map_panel.rectTransform.rect.height, iter_16_9[4], iter_16_9[5])
			var_16_12.boss_icon.image.sprite = self:loadSprite(var_0_5.score_boss_unknow_icon)
			self._opean_boss_img = {}

			local var_16_14 = var_0_23.find_object_by_id(arg_16_1[arg_16_2].map_id)
			local var_16_16 = iter_16_9[1]

			if iter_16_9[1] == var_16_14.boss[1][1] then
				for iter_16_10, iter_16_11 in pairs(self._user_data) do
					if iter_16_11.id == var_16_14.id then
						if iter_16_11.boss_hp[1].id == var_16_16 and iter_16_11.boss_hp[1].hp ~= 0 and iter_16_11.boss_hp[1].hp < var_16_14.boss[1][2] then
							var_16_12.boss_icon.image.sprite = self:loadSprite(var_0_6(var_0_5.score_boss_icon, iter_16_9[3]))

							if iter_16_11.boss_hp[1].hp / var_16_14.boss[1][2] <= 0.01 then
								var_16_12.boss_icon.boss_hp_bar.image.fillAmount = 0.01
							end

							var_16_12.boss_icon.boss_hp_bar:SetActive(true)
							var_16_12.boss_icon.boss_hp_bg:SetActive(true)
							var_16_12.boss_icon.boss_hp_die:SetActive(false)
						elseif iter_16_11.boss_hp[1].id == var_16_16 and iter_16_11.boss_hp[1].hp == 0 then
							var_16_12.boss_icon.image.sprite = self:loadSprite(var_0_6(var_0_5.score_boss_icon, iter_16_9[3]))

							var_16_12.boss_icon.boss_hp_bar:SetActive(false)
							var_16_12.boss_icon.boss_hp_die:SetActive(true)
						end

						if #iter_16_11.boss_hp > 1 then
							if iter_16_11.boss_hp[2].id == var_16_16 and iter_16_11.boss_hp[2].hp ~= 0 and iter_16_11.boss_hp[2].hp < var_16_14.boss[1][2] then
								var_16_12.boss_icon.image.sprite = self:loadSprite(var_0_6(var_0_5.score_boss_icon, iter_16_9[3]))

								if iter_16_11.boss_hp[2].hp / var_16_14.boss[1][2] <= 0.01 then
									var_16_12.boss_icon.boss_hp_bar.image.fillAmount = 0.01
								end

								var_16_12.boss_icon.boss_hp_bar:SetActive(true)
								var_16_12.boss_icon.boss_hp_bg:SetActive(true)
							elseif iter_16_11.boss_hp[2].id == var_16_16 and iter_16_11.boss_hp[2].hp == 0 then
								var_16_12.boss_icon.image.sprite = self:loadSprite(var_0_6(var_0_5.score_boss_icon, iter_16_9[3]))

								var_16_12.boss_icon.boss_hp_bar:SetActive(false)
								var_16_12.boss_icon.boss_hp_die:SetActive(true)
							end
						end
					end
				end
			end

			if #var_16_14.boss > 1 and var_16_16 == var_16_14.boss[2][1] then
				for iter_16_12, iter_16_13 in pairs(self._user_data) do
					if iter_16_13.id == var_16_14.id then
						if iter_16_13.boss_hp[1].id == var_16_16 and iter_16_13.boss_hp[1].hp ~= 0 and iter_16_13.boss_hp[1].hp < var_16_14.boss[2][2] then
							var_16_12.boss_icon.image.sprite = self:loadSprite(var_0_6(var_0_5.score_boss_icon, iter_16_9[3]))

							if iter_16_13.boss_hp[1].hp / var_16_14.boss[2][2] <= 0.01 then
								var_16_12.boss_icon.boss_hp_bar.image.fillAmount = 0.01
							end

							var_16_12.boss_icon.boss_hp_bar:SetActive(true)
							var_16_12.boss_icon.boss_hp_bg:SetActive(true)
						elseif iter_16_13.boss_hp[1].id == var_16_16 and iter_16_13.boss_hp[1].hp == 0 then
							var_16_12.boss_icon.image.sprite = self:loadSprite(var_0_6(var_0_5.score_boss_icon, iter_16_9[3]))

							var_16_12.boss_icon.boss_hp_bar:SetActive(false)
							var_16_12.boss_icon.boss_hp_die:SetActive(true)
						end

						if iter_16_13.boss_hp[2].id == var_16_16 and iter_16_13.boss_hp[2].hp ~= 0 and iter_16_13.boss_hp[2].hp < var_16_14.boss[2][2] then
							var_16_12.boss_icon.image.sprite = self:loadSprite(var_0_6(var_0_5.score_boss_icon, iter_16_9[3]))

							if iter_16_13.boss_hp[2].hp / var_16_14.boss[2][2] <= 0.01 then
								var_16_12.boss_icon.boss_hp_bar.image.fillAmount = 0.01
							end

							var_16_12.boss_icon.boss_hp_bar:SetActive(true)
							var_16_12.boss_icon.boss_hp_bg:SetActive(true)
						elseif iter_16_13.boss_hp[2].id == var_16_16 and iter_16_13.boss_hp[2].hp == 0 then
							var_16_12.boss_icon.image.sprite = self:loadSprite(var_0_6(var_0_5.score_boss_icon, iter_16_9[3]))

							var_16_12.boss_icon.boss_hp_bar:SetActive(false)
							var_16_12.boss_icon.boss_hp_die:SetActive(true)
						end
					end
				end
			end

			var_16_12.boss_icon.image:SetNativeSize()
		end

		for iter_16_14, iter_16_15 in ipairs(arg_16_1[arg_16_2].boss) do
			local var_16_21, var_16_22 = self:__load_map_fragment_with_pool("score_boss_node_obj", self._control.score_map_detail.main.map_panel.map_node_root_1.transform)

			var_16_21:setVisible(true)

			var_16_22.boss_icon.rectTransform.parent.offsetMin = var_0_15(0, 0)
			var_16_22.boss_icon.rectTransform.parent.offsetMax = var_0_15(0, 0)
			var_16_22.boss_icon.rectTransform.anchoredPosition = self:__get_real_node_pos(self._control.score_map_detail.main.map_panel.rectTransform.rect.width, self._control.score_map_detail.main.map_panel.rectTransform.rect.height, iter_16_15[4], iter_16_15[5])
			var_16_22.boss_icon.image.sprite = self:loadSprite(var_0_5.score_boss_unknow_icon)
			self._opean_boss_img = {}

			local var_16_24 = var_0_23.find_object_by_id(arg_16_1[arg_16_2].map_id)
			local var_16_26 = iter_16_15[1]

			if iter_16_15[1] == var_16_24.boss[1][1] then
				for iter_16_16, iter_16_17 in pairs(self._user_data) do
					if iter_16_17.id == var_16_24.id then
						if iter_16_17.boss_hp[1].id == var_16_26 and iter_16_17.boss_hp[1].hp ~= 0 and iter_16_17.boss_hp[1].hp < var_16_24.boss[1][2] then
							var_16_22.boss_icon.image.sprite = self:loadSprite(var_0_6(var_0_5.score_boss_icon, iter_16_15[3]))

							if iter_16_17.boss_hp[1].hp / var_16_24.boss[1][2] <= 0.01 then
								var_16_22.boss_icon.boss_hp_bar.image.fillAmount = 0.01
							end

							var_16_22.boss_icon.boss_hp_bar:SetActive(true)
							var_16_22.boss_icon.boss_hp_bg:SetActive(true)
							var_16_22.boss_icon.boss_hp_die:SetActive(false)
						elseif iter_16_17.boss_hp[1].id == var_16_26 and iter_16_17.boss_hp[1].hp == 0 then
							var_16_22.boss_icon.image.sprite = self:loadSprite(var_0_6(var_0_5.score_boss_icon, iter_16_15[3]))

							var_16_22.boss_icon.boss_hp_bar:SetActive(false)
							var_16_22.boss_icon.boss_hp_die:SetActive(true)
						end

						if #iter_16_17.boss_hp > 1 then
							if iter_16_17.boss_hp[2].id == var_16_26 and iter_16_17.boss_hp[2].hp ~= 0 and iter_16_17.boss_hp[2].hp < var_16_24.boss[1][2] then
								var_16_22.boss_icon.image.sprite = self:loadSprite(var_0_6(var_0_5.score_boss_icon, iter_16_15[3]))

								if iter_16_17.boss_hp[2].hp / var_16_24.boss[1][2] <= 0.01 then
									var_16_22.boss_icon.boss_hp_bar.image.fillAmount = 0.01
								end

								var_16_22.boss_icon.boss_hp_die:SetActive(false)
								var_16_22.boss_icon.boss_hp_bar:SetActive(true)
								var_16_22.boss_icon.boss_hp_bg:SetActive(true)
							elseif iter_16_17.boss_hp[2].id == var_16_26 and iter_16_17.boss_hp[2].hp == 0 then
								var_16_22.boss_icon.image.sprite = self:loadSprite(var_0_6(var_0_5.score_boss_icon, iter_16_15[3]))

								var_16_22.boss_icon.boss_hp_bar:SetActive(false)
								var_16_22.boss_icon.boss_hp_die:SetActive(true)
							end
						end
					end
				end
			end

			if #var_16_24.boss > 1 and var_16_26 == var_16_24.boss[2][1] then
				for iter_16_18, iter_16_19 in pairs(self._user_data) do
					if iter_16_19.id == var_16_24.id then
						if iter_16_19.boss_hp[1].id == var_16_26 and iter_16_19.boss_hp[1].hp ~= 0 and iter_16_19.boss_hp[1].hp < var_16_24.boss[2][2] then
							var_16_22.boss_icon.image.sprite = self:loadSprite(var_0_6(var_0_5.score_boss_icon, iter_16_15[3]))

							if iter_16_19.boss_hp[1].hp / var_16_24.boss[2][2] <= 0.01 then
								var_16_22.boss_icon.boss_hp_bar.image.fillAmount = 0.01
							end

							var_16_22.boss_icon.boss_hp_bar:SetActive(true)
							var_16_22.boss_icon.boss_hp_bg:SetActive(true)
							var_16_22.boss_icon.boss_hp_die:SetActive(false)
						elseif iter_16_19.boss_hp[1].id == var_16_26 and iter_16_19.boss_hp[1].hp == 0 then
							var_16_22.boss_icon.image.sprite = self:loadSprite(var_0_6(var_0_5.score_boss_icon, iter_16_15[3]))

							var_16_22.boss_icon.boss_hp_bar:SetActive(false)
							var_16_22.boss_icon.boss_hp_die:SetActive(true)
						end

						if iter_16_19.boss_hp[2].id == var_16_26 and iter_16_19.boss_hp[2].hp ~= 0 and iter_16_19.boss_hp[2].hp < var_16_24.boss[2][2] then
							var_16_22.boss_icon.image.sprite = self:loadSprite(var_0_6(var_0_5.score_boss_icon, iter_16_15[3]))

							if iter_16_19.boss_hp[2].hp / var_16_24.boss[2][2] <= 0.01 then
								var_16_22.boss_icon.boss_hp_bar.image.fillAmount = 0.01
							end

							var_16_22.boss_icon.boss_hp_die:SetActive(false)
							var_16_22.boss_icon.boss_hp_bar:SetActive(true)
							var_16_22.boss_icon.boss_hp_bg:SetActive(true)
						elseif iter_16_19.boss_hp[2].id == var_16_26 and iter_16_19.boss_hp[2].hp == 0 then
							var_16_22.boss_icon.image.sprite = self:loadSprite(var_0_6(var_0_5.score_boss_icon, iter_16_15[3]))

							var_16_22.boss_icon.boss_hp_bar:SetActive(false)
							var_16_22.boss_icon.boss_hp_die:SetActive(true)
						end
					end
				end
			end

			var_16_22.boss_icon.image:SetNativeSize()
		end
	end

	function arg_1_0:__init_map_detail_node(arg_17_1, arg_17_2, arg_17_3)
		if arg_17_3 and arg_17_3 == 0 then
			self:__set_node_data_by_map(arg_17_1, arg_17_2, arg_17_3)
		else
			self:__set_node_data_by_map(arg_17_1, arg_17_2, arg_17_3)
		end
	end

	function arg_1_0:__set_mini_map_data(arg_18_1)
		local var_18_0 = self._control.score_map_detail.main

		self._control.score_map_detail.main.map_panel.map_image.image.sprite = self:loadSprite(string.format(var_0_5.map_path, arg_18_1.id, arg_18_1.id))
		var_18_0.title_bg.title_txt.text.text = arg_18_1.title .. " " .. arg_18_1.sub_title
		var_18_0.boss_panel.boss_bg.image.sprite = self:loadSprite(var_0_6(var_0_5.fearlessness_sea_enemy_bg, arg_18_1.boss_bg))

		local var_18_1 = var_0_3:is_map_pass(arg_18_1.map_id)

		var_18_0.boss_panel.boss_image.image.sprite = not var_18_1 and self:loadSprite(var_0_6(var_0_5.fearlessness_sea_node_boss, arg_18_1.boss_id)) or self:loadSprite(var_0_6(var_0_5.fearlessness_sea_node_boss_b, arg_18_1.boss_id))

		var_18_0.reward_panel.reward_icon.get_icon:SetActive(var_18_1)
		var_18_0.map_panel.pass_icon:SetActive(var_18_1)

		var_18_0.bottom_tips.tips_txt.text.text = var_0_1:convert_rich_text(arg_18_1.tips)

		local var_18_2 = var_0_10.find_object_by_cid(arg_18_1.award[1].id)

		var_18_0.reward_panel.reward_title.text.text = var_0_1:getNowLang("pveeventitemcanget")

		if var_18_2 then
			var_18_0.reward_panel.reward_icon_bg.image.sprite = self:loadSprite(var_0_5.equip_quality_frame_s[var_18_2.star])
			var_18_0.reward_panel.reward_icon.image.sprite = self:loadSprite(var_0_6(var_0_5.equip_icon.equip, var_18_2.pic_id))
		else
			log.print_r(arg_18_1.id .. " not have equip with cid " .. arg_18_1.award[1].id)
		end

		self:__update_boss_hp(arg_18_1)
	end

	function arg_1_0:__update_boss_hp(arg_19_1)
		local var_19_0 = self._control.map_preview.map_bg.boss_panel.boss_hp_black
		local var_19_1 = var_0_3:get_score_map_data()[arg_19_1.id]
		local var_19_2

		if var_19_1 then
			var_19_2 = var_19_1.hp / arg_19_1.hp or 1
		end

		var_19_0.boss_hp_bar.image.fillAmount = var_19_2
		var_19_0.hp_percent_num.text.text = var_0_6("%0.0f%s", var_19_2 * 100, "%")
	end

	function arg_1_0:__set_node_data_by_map(arg_20_1, arg_20_2, arg_20_3)
		local var_20_0 = arg_20_3 == 0 and self._control.score_map_detail.main.map_panel.map_node_root or self._control.score_map_detail.main.map_panel.map_node_root_1
		local var_20_1 = self._control.score_map_detail.main.map_panel.rectTransform.rect.width
		local var_20_2 = self._control.score_map_detail.main.map_panel.rectTransform.rect.height
		local var_20_3 = {}

		self._light_seq_list = {}

		local var_20_4 = {}

		for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
			if iter_20_1.node_miss and next(iter_20_1.node_miss) then
				for iter_20_2, iter_20_3 in pairs(iter_20_1.node_miss) do
					var_0_7(var_20_3, {
						hide_start_point = iter_20_1.id,
						hide_end_point = iter_20_2,
						hide_result = iter_20_3
					})
				end
			end

			if iter_20_1.node_miss_2 and next(iter_20_1.node_miss_2) then
				for iter_20_4, iter_20_5 in pairs(iter_20_1.node_miss_2) do
					var_0_7(var_20_4, {
						hide_start_point = iter_20_1.id,
						hide_end_point = iter_20_4,
						hide_result = iter_20_5
					})
				end
			end
		end

		self:__destroy_seq()

		self._light_seq = {}
		self.now_line_list = {}

		for iter_20_6, iter_20_7 in ipairs(arg_20_1) do
			local var_20_5, var_20_6 = self:__load_map_fragment_with_pool("map_node_obj", var_20_0.transform)

			var_20_5:setVisible(true)

			var_20_6.node_image.rectTransform.parent.offsetMin = var_0_15(0, 0)
			var_20_6.node_image.rectTransform.parent.offsetMax = var_0_15(0, 0)
			var_20_6.node_image.rectTransform.anchoredPosition = self:__get_real_node_pos(var_20_1, var_20_2, iter_20_7.position.x, iter_20_7.position.y)

			if iter_20_7.id == iter_20_7.start_node_id then
				local var_20_7 = arg_20_3 == 0 and self._control.score_map_detail.main.map_panel.arrow_icon or self._control.score_map_detail.main.map_panel.arrow_icon_1

				var_20_7.rectTransform.anchoredPosition = self:__get_real_node_pos(var_20_1, var_20_2, iter_20_7.position.x, iter_20_7.position.y)

				local var_20_8 = self:__get_arrow_pos_offset(iter_20_7.arrow, arg_20_3)

				var_20_7.rectTransform.anchoredPosition = var_0_15(var_20_7.rectTransform.anchoredPosition.x + var_20_8.x, var_20_7.rectTransform.anchoredPosition.y + var_20_8.y)
			end

			self._control.score_map_detail.main.map_panel.arrow_icon_1:SetActive(false)
			self._control.score_map_detail.main.map_panel.arrow_icon:SetActive(false)

			local var_20_9
			local var_20_10 = 1

			if iter_20_7.node_attribute == var_0_5.map_node_finish_type.init then
				var_20_9 = var_0_5.fight_point.pve_start_l
				var_20_10 = 2
			elseif iter_20_7.node_attribute == var_0_5.map_node_finish_type.boss_finish then
				if var_0_3:is_score_map_node_pass(iter_20_7.start_node_id, iter_20_7.id) then
					var_20_9 = var_0_5.fight_point.pve_boss_l
					var_20_10 = 2
				else
					var_20_9 = var_0_5.fight_point.pve_boss
					var_20_10 = 1
				end
			elseif iter_20_7.node_type == var_0_5.map_node_type.reward then
				var_20_9 = var_0_3:is_score_map_node_pass(iter_20_7.start_node_id, iter_20_7.id) and var_0_5.fight_point.pve_green or var_0_5.fight_point.pve_white
			elseif iter_20_7.node_type == var_0_5.map_node_type.loss then
				var_20_9 = var_0_3:is_score_map_node_pass(iter_20_7.start_node_id, iter_20_7.id) and var_0_5.fight_point.pve_purple or var_0_5.fight_point.pve_white
			elseif iter_20_7.node_type == var_0_5.map_node_type.null then
				var_20_9 = var_0_3:is_score_map_node_pass(iter_20_7.start_node_id, iter_20_7.id) and var_0_5.fight_point.pve_blue or var_0_5.fight_point.pve_white
			else
				if var_0_3:is_score_map_node_pass(iter_20_7.start_node_id, iter_20_7.id) then
					var_20_9 = var_0_5.fight_point.pve_red
					var_20_10 = 2
				else
					var_20_9 = var_0_5.fight_point.pve_white
					var_20_10 = 1
				end

				var_20_9 = var_0_3:is_score_map_node_pass(iter_20_7.start_node_id, iter_20_7.id) and var_0_5.fight_point.pve_red or var_0_5.fight_point.pve_white
			end

			local var_20_11

			if iter_20_7.flag and var_20_10 then
				var_20_11 = var_0_6(var_0_5.fearlessness_sea_node_letter, iter_20_7.flag .. var_20_10)
			end

			var_20_6.node_image.rectTransform:GetComponent("Image").enabled = true

			local var_20_14

			var_20_6.night_atk_point_2:SetActive(false)

			if iter_20_7.roundabout == 1 then
				var_20_14 = var_0_5.pve_g
				var_20_6.night_atk_point_2.image.sprite = self:loadSprite(var_0_5.pve_g)

				var_20_6.night_atk_point_2.image:SetNativeSize()
				var_20_6.night_atk_point_2:SetActive(true)

				var_20_6.night_atk_point_2.rectTransform.parent.offsetMin = var_0_15(0, 0)
				var_20_6.night_atk_point_2.rectTransform.parent.offsetMax = var_0_15(0, 0)
				var_20_6.night_atk_point_2.rectTransform.anchoredPosition = self:__get_real_node_pos(var_20_1, var_20_2, iter_20_7.position.x, iter_20_7.position.y)
			end

			local var_20_15 = {}

			if iter_20_7.night_atk == 1 then
				var_20_14 = var_0_5.pve_night_atk_l

				var_0_7(var_20_15, var_0_5.pve_night_atk_l)
			end

			if iter_20_7.node_type == 10 then
				var_20_14 = var_0_5.pve_air

				var_0_7(var_20_15, var_0_5.pve_air)
			elseif iter_20_7.node_type == 11 then
				var_20_14 = var_0_5.pve_special_boss_l

				var_0_7(var_20_15, var_0_5.pve_special_boss_l)
			elseif iter_20_7.node_type == 14 and self:check_node_enemy(iter_20_7) then
				var_20_14 = var_0_5.pve_special_boss_l

				var_0_7(var_20_15, var_0_5.pve_special_boss_l)
			end

			if iter_20_7.node_type == 7 then
				var_20_14 = var_0_5.pve_garrison

				var_20_6.night_atk_point:SetActive(false)

				self._little_boss_point_data = iter_20_7
				var_20_9 = var_0_3:is_score_map_node_pass(iter_20_7.start_node_id, iter_20_7.id) and var_0_5.fight_point.pve_small_boss_l or var_0_5.fight_point.pve_small_boss

				local var_20_16 = var_20_6.node_image.guard_icon
				local var_20_17, var_20_18 = var_0_3:is_point_stationed(iter_20_7.id)

				if var_20_17 then
					self._current_station_team_id = var_20_18
					self.map_data = self._user_data[iter_20_7.map_id]

					local var_20_19 = var_0_3:get_account_id()
					local var_20_20 = tonumber(var_0_20:getDataByID(var_0_6("is_first_station_%d", self.map_data.id), var_20_19))

					if var_20_20 and self.map_data.id == var_20_20 then
						var_0_2:destroyInstance("suppress_msg")
						var_0_2:createInstance("suppress_msg"):show("suppressed", nil, 1.5, true)
						var_0_20:setDataByID(var_0_6("is_first_station_%d", self.map_data.id), var_20_19, "have_show")
					end

					local var_20_21 = var_20_6.node_image.transform.localPosition

					var_20_16:SetActive(true)
					var_20_16.button.onClick:AddListener(function()
						local var_21_0 = string.sub(tostring(var_20_16.team_id.image.sprite), 16, 16)
						local var_21_1 = var_0_2:createInstance("captainroom_fleet")

						if not var_21_1 then
							return
						end

						var_21_1:show(var_0_1:getNowLang("ui_activitydefendfleet"), var_0_3:get_team_by_id(tonumber(var_21_0)).members, var_0_1:getNowLang("ui_activitydefendcancel"), "", function()
							local var_22_0 = var_0_2:createInstance("msgbox")

							if not var_22_0 then
								return
							end

							var_22_0:show(var_0_1:getNowLang("ui_activitydefendcanceltip"), function()
								var_22_0:setVisible(false)
								var_0_3:req_StationPointExitReq(tonumber(var_21_0))
								self:__onClick_score_map_detail_main_close_btn()
								var_0_2:destroyInstance("captainroom_fleet")

								local var_23_0 = var_0_2:getInstance("cover")

								if var_23_0 then
									var_23_0:setVisible(false)
								end
							end, function()
								var_22_0:setVisible(false)
							end, var_0_1:getNowLang("ui_activitydefendcancel"))
						end, true)
						var_21_1:disallowed_clicking()
					end)

					local var_20_22 = iter_20_7.bubble_icon

					if iter_20_7.bubble_icon == 0 then
						var_20_22 = 1
					end

					var_20_16.image.sprite = self:loadSprite(string.format(var_0_5.guard_point.pve_node_guard, var_20_22))
					var_20_16.team_id.image.sprite = self:loadSprite(string.format(var_0_5.guard_point.pve_fleet_team, self._current_station_team_id))
					var_20_16.transform.localScale = var_0_16(1.38, 1.54, 1)

					local var_20_23 = var_0_16.zero
					local var_20_24 = var_0_16.zero

					if var_20_22 == 1 then
						var_20_23 = var_0_15(-10, -142)
						var_20_24 = var_0_15(0, -2.8)
					elseif var_20_22 == 2 then
						var_20_23 = var_0_15(-10, 0)
						var_20_24 = var_0_15(0, 6)
					elseif var_20_22 == 3 then
						var_20_23 = var_0_15(120, 0)
						var_20_24 = var_0_15(0, 6)
					elseif var_20_22 == 4 then
						var_20_23 = var_0_15(120, -142)
						var_20_24 = var_0_15(0, -2.8)
					end

					if (var_20_22 == 1 or var_20_22 == 2) and var_20_21.x < 60 then
						var_20_23.x = 10
					elseif (var_20_22 == 1 or var_20_22 == 4) and var_20_21.y <= -537 then
						var_20_23.y = -104
					end

					var_20_16.transform.anchoredPosition = var_20_23
					var_20_16.team_id.transform.anchoredPosition = var_20_24
				else
					var_20_16:SetActive(false)
				end
			end

			if iter_20_7.treasure_icon == 1 then
				var_20_14 = var_0_5.pve_box
			end

			local var_20_25 = false
			local var_20_26

			if iter_20_7.support_icon ~= 0 then
				local var_20_27 = var_0_14.support_atk_config.find_object_by_id(iter_20_7.support_icon)

				var_20_26 = var_0_3:is_score_map_node_pass(iter_20_7.start_node_id, iter_20_7.id)
				var_20_9 = var_0_6((var_20_26 or nil) and (var_0_5.fight_point.support_icon_path_red or var_0_5.fight_point.support_icon_path_white), var_20_27.type)
				var_20_25 = true
			elseif var_20_6.node_image:GetComponent("Button") then
				var_20_6.node_image:GetComponent("Button").enabled = false
			end

			if var_20_25 then
				var_20_6.node_image.transform.gameObject:AddComponent(typeof(UnityEngine.UI.Button))

				var_20_6.node_image.image.raycastTarget = true
				var_20_6.node_image:GetComponent("Button").enabled = true

				var_20_6.node_image:GetComponent("Button").onClick:RemoveAllListeners()
				var_20_6.node_image:GetComponent("Button").onClick:AddListener(function()
					local var_25_0 = var_0_2:getInstance("suppress_msg")

					if not var_25_0 then
						var_25_0 = var_0_2:createInstance("suppress_msg")
					else
						var_0_2:destroyInstance("suppress_msg")

						var_25_0 = var_0_2:createInstance("suppress_msg")
					end

					if var_20_26 then
						var_25_0:show("suppressed", iter_20_7.pve_level_id, 1.5, nil, var_0_5.fight_type.score_attack)
					else
						var_25_0:show("suppress", iter_20_7.pve_level_id, 1.5, nil, var_0_5.fight_type.score_attack)
					end
				end)
			end

			var_20_6.night_atk_point:SetActive(false)

			if var_20_14 then
				var_20_6.night_atk_point.image.sprite = self:loadSprite(var_20_14)

				var_20_6.night_atk_point.image:SetNativeSize()

				var_20_6.night_atk_point.rectTransform.parent.offsetMin = var_0_15(0, 0)
				var_20_6.night_atk_point.rectTransform.parent.offsetMax = var_0_15(0, 0)
				var_20_6.night_atk_point.rectTransform.anchoredPosition = self:__get_real_node_pos(var_20_1, var_20_2, iter_20_7.position.x, iter_20_7.position.y)

				if iter_20_7.night_atk == 1 or iter_20_7.node_type == 10 or iter_20_7.node_type == 11 or iter_20_7.node_type == 14 then
					local var_20_30 = true

					var_20_6.night_atk_point:SetActive(true)

					if iter_20_7.node_type == 11 then
						local var_20_31 = var_0_3:get_map_list()[iter_20_7.pve_level_id]

						if var_20_31 then
							for iter_20_8, iter_20_9 in pairs(var_20_31.pass_point) do
								if iter_20_7.id == iter_20_9.id then
									for iter_20_10, iter_20_11 in pairs(iter_20_9.info) do
										if iter_20_11.grade > 2 then
											var_20_30 = false

											break
										end
									end
								end
							end
						end
					end
				end

				if iter_20_7.treasure_icon == 1 then
					local var_20_33 = self:autoKillDOTween(var_0_12.Sequence())

					if not var_0_3:is_score_map_node_s_up_pass(iter_20_7.start_node_id, iter_20_7.id) then
						var_20_6.night_atk_point:SetActive(true)
						table.insert(var_20_15, var_0_5.pve_box)
						var_0_7(self._light_seq_list, var_20_33)
						var_20_33:Append(var_20_6.night_atk_point.image:DOFade(0, 0))

						for iter_20_14, iter_20_15 in pairs(var_20_15) do
							var_20_33:Append(var_20_6.night_atk_point.image:DOFade(0, 0.0001):OnStepComplete(function()
								if var_20_6 and var_20_6.night_atk_point then
									var_20_6.night_atk_point.image.sprite = self:loadSprite(iter_20_15)
								end
							end))
							var_20_33:Append(var_20_6.night_atk_point.image:DOFade(1, 1))
							var_20_33:Append(var_20_6.night_atk_point.image:DOFade(0, 1))
						end

						var_20_33:SetLoops(-1)
						var_20_33:Play()
					else
						var_20_6.night_atk_point:SetActive(false)
					end
				end
			else
				var_20_6.night_atk_point:SetActive(false)
			end

			var_20_6.node_image.image.sprite = self:loadSprite(var_20_9)

			var_20_6.node_image.image:SetNativeSize()
			var_20_6.node_image.random_buff_icon:SetActive(false)

			local var_20_34 = {}

			for iter_20_16, iter_20_17 in pairs(var_20_3) do
				if iter_20_17.hide_start_point == iter_20_7.id then
					for iter_20_18, iter_20_19 in pairs(iter_20_17.hide_result) do
						local var_20_35 = var_0_3:get_score_map_node_pass_count(iter_20_7.start_node_id, tonumber(iter_20_18))

						if var_20_35 and iter_20_19 <= var_20_35 then
							for iter_20_20, iter_20_21 in pairs(iter_20_7.next_node) do
								if iter_20_21 == tonumber(iter_20_17.hide_end_point) then
									var_0_7(var_20_34, iter_20_21)
								end
							end
						end
					end
				end
			end

			for iter_20_22, iter_20_23 in pairs(var_20_4) do
				if iter_20_23.hide_start_point == iter_20_7.id then
					local var_20_36, var_20_37 = self:_is_have_pass_node(iter_20_23.hide_result, iter_20_23.hide_end_point)

					if not var_20_36 then
						var_0_7(var_20_34, var_20_37)
					end
				end
			end

			local var_20_38 = {}

			if iter_20_7.node_type == var_0_5.map_node_type.air_attack then
				var_0_7(var_20_38, var_0_5.pve_air)
			end

			if iter_20_7.treasure_icon then
				if iter_20_7.treasure_icon == var_0_5.ocean_map_node_type.point then
					var_0_7(var_20_38, var_0_5.pve_point)
				elseif iter_20_7.treasure_icon == var_0_5.ocean_map_node_type.box then
					var_0_7(var_20_38, var_0_5.pve_box)
				elseif iter_20_7.treasure_icon == var_0_5.ocean_map_node_type.point_and_box then
					var_0_7(var_20_38, var_0_5.pve_point)
					var_0_7(var_20_38, var_0_5.pve_box)
				end
			end

			if iter_20_7.unlock_buy_cid and iter_20_7.unlock_buy_cid[1] then
				var_0_7(var_20_38, var_0_5.pve_buff)
			end

			var_0_3:set_score_map_tmp_icon_list(iter_20_6, var_20_38)

			local var_20_39 = {}
			local var_20_40 = {}
			local var_20_41 = true

			if iter_20_7.node_hide and next(iter_20_7.node_hide) then
				for iter_20_24, iter_20_25 in pairs(iter_20_7.node_hide) do
					for iter_20_26, iter_20_27 in pairs(iter_20_7.next_node) do
						if tonumber(iter_20_24) == iter_20_27 then
							for iter_20_28, iter_20_29 in pairs(iter_20_25) do
								if not var_0_3:is_score_map_node_pass(iter_20_7.start_node_id, iter_20_29) or var_0_3:get_score_map_node_pass_count(iter_20_7.start_node_id, iter_20_29) <= 0 then
									var_20_41 = false
								end
							end

							var_0_7(var_20_39, {
								is_show_true = var_20_41,
								node_flag = var_0_24.find_object_by_id_start_node_id(iter_20_27, iter_20_7.start_node_id).flag
							})
						end
					end
				end
			end

			if iter_20_7.node_hide_2 and next(iter_20_7.node_hide_2) then
				for iter_20_30, iter_20_31 in pairs(iter_20_7.node_hide_2) do
					local var_20_43 = {}

					for iter_20_32, iter_20_33 in pairs(iter_20_7.next_node) do
						if tonumber(iter_20_30) == iter_20_33 then
							for iter_20_34, iter_20_35 in pairs(iter_20_31) do
								table.insert(var_20_43, (var_0_3:score_map_is_pass(iter_20_35) or nil) and 1)
							end

							local var_20_46 = var_0_23.find_object_by_id_start_node_id(iter_20_33, iter_20_7.start_node_id)

							if var_20_43 and next(var_20_43) then
								var_0_7(var_20_40, {
									is_show_true = (self:_have_data_2(var_20_43, 0) or nil) and false,
									node_flag = var_20_46.flag
								})
							end
						end
					end
				end
			end

			if iter_20_7.garrison_node_open and next(iter_20_7.garrison_node_open) or iter_20_7.garrison_node_close and next(iter_20_7.garrison_node_close) then
				local var_20_48 = {}

				if iter_20_7.garrison_node_open then
					for iter_20_36, iter_20_37 in pairs(iter_20_7.garrison_node_open) do
						var_20_48[iter_20_36] = true
					end
				end

				if iter_20_7.garrison_node_close then
					for iter_20_38, iter_20_39 in pairs(iter_20_7.garrison_node_close) do
						var_20_48[iter_20_38] = true
					end
				end

				for iter_20_40, iter_20_41 in pairs(var_20_48) do
					local var_20_49 = var_0_24.find_object_by_id_start_node_id(tonumber(iter_20_40), iter_20_7.start_node_id)

					if var_20_49 then
						local var_20_50 = true
						local var_20_51

						if iter_20_7.garrison_node_open then
							var_20_51 = iter_20_7.garrison_node_open[iter_20_40] or iter_20_7.garrison_node_open[tonumber(iter_20_40)]
						end

						if var_20_51 then
							for iter_20_42, iter_20_43 in pairs(var_20_51) do
								if not var_0_3:is_point_stationed(tonumber(iter_20_43)) then
									var_20_50 = false

									break
								end
							end
						end

						local var_20_52 = true
						local var_20_53

						if iter_20_7.garrison_node_close then
							var_20_53 = iter_20_7.garrison_node_close[iter_20_40] or iter_20_7.garrison_node_close[tonumber(iter_20_40)]
						end

						if var_20_53 then
							for iter_20_44, iter_20_45 in pairs(var_20_53) do
								if var_0_3:is_point_stationed(tonumber(iter_20_45)) then
									var_20_52 = false

									break
								end
							end
						end

						var_0_7(var_20_39, {
							is_show_true = var_20_50 and var_20_52,
							node_flag = var_20_49.flag
						})
					end
				end
			end

			local var_20_54 = {}

			for iter_20_46, iter_20_47 in ipairs(var_20_39) do
				var_20_54[iter_20_47.node_flag] = var_20_54[iter_20_47.node_flag] == nil and iter_20_47.is_show_true or var_20_54[iter_20_47.node_flag] and iter_20_47.is_show_true
			end

			for iter_20_48, iter_20_49 in ipairs(var_20_40) do
				var_20_54[iter_20_49.node_flag] = var_20_54[iter_20_49.node_flag] == nil and iter_20_49.is_show_true or var_20_54[iter_20_49.node_flag] and iter_20_49.is_show_true
			end

			if iter_20_7.next_node_path ~= "{}" then
				for iter_20_50, iter_20_51 in pairs((var_0_13(iter_20_7.next_node_path))) do
					local var_20_57, var_20_58 = self:__load_map_fragment_with_pool("map_line_obj", var_20_0.transform)

					var_20_57:setVisible(true)

					var_20_58.line_image.rectTransform.parent.offsetMin = var_0_15(0, 0)
					var_20_58.line_image.rectTransform.parent.offsetMax = var_0_15(0, 0)
					var_20_58.line_image.rectTransform.anchoredPosition = self:__get_real_node_pos(var_20_1, var_20_2, iter_20_51.x, iter_20_51.y)
					var_20_58.line_image.image.sprite = self:loadSprite((string.format(var_0_5.mapline_path, string.lower(arg_20_2), iter_20_50)))
					var_20_58.line_image.transform.localScale = var_0_16(0.75, 0.75, 1)

					var_20_58.line_image.image:SetNativeSize()
					var_20_58.line_image:SetActive(true)

					var_20_58.line_image.image.color = UnityEngine.Color(1, 1, 1, 1)

					local var_20_59 = lx.split(iter_20_50, "-")[3]

					if var_20_54[var_20_59] ~= nil then
						var_20_58.line_image.image.color = var_20_54[var_20_59] and UnityEngine.Color(1, 1, 1, 1) or UnityEngine.Color(1, 1, 1, 0.2)
					end

					if next(var_20_34) then
						for iter_20_52, iter_20_53 in pairs(var_20_34) do
							local var_20_60

							for iter_20_54, iter_20_55 in pairs((var_0_24.get_start_node_id_set_by_id(iter_20_53))) do
								var_20_60 = var_0_24.find_object_by_id_start_node_id(iter_20_53, iter_20_54)
							end

							if var_0_6("%s-%s-%s", iter_20_7.pve_level_id, iter_20_7.flag, var_20_60.flag) == iter_20_50 then
								var_20_58.line_image:SetActive(false)
							end
						end
					end
				end
			end

			if #iter_20_7.flag > 0 then
				local var_20_61, var_20_62 = self:__load_map_fragment_with_pool("score_sea_letter_obj", var_20_0.transform)

				var_20_61:setVisible(true)

				var_20_62.node_letter_image.rectTransform.parent.offsetMin = var_0_15(0, 0)
				var_20_62.node_letter_image.rectTransform.parent.offsetMax = var_0_15(0, 0)
				var_20_62.node_letter_image.rectTransform.anchoredPosition = var_20_6.node_image.rectTransform.anchoredPosition + var_0_15(0, 30)
				var_20_62.node_letter_image.image.sprite = self:loadSprite(var_20_11)
			end
		end
	end

	function arg_1_0.__get_real_node_pos(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4, arg_28_5)
		return var_0_15(arg_28_3 / 1280 * arg_28_1, not arg_28_5 and -1 * arg_28_4 / 720 * arg_28_2 or arg_28_4 / 960 * arg_28_2)
	end

	function arg_1_0:__get_arrow_pos_offset(arg_29_1, arg_29_2)
		local var_29_0 = arg_29_2 == 0 and self._control.score_map_detail.main.map_panel.arrow_icon or self._control.score_map_detail.main.map_panel.arrow_icon_1

		if arg_29_1 == 270 then
			var_29_0.transform.eulerAngles = var_0_16(0, 0, arg_29_1)

			return var_0_15(0, 0)
		elseif arg_29_1 == 90 then
			var_29_0.transform.eulerAngles = var_0_16(0, 0, arg_29_1)

			return var_0_15(0, 200)
		elseif arg_29_1 == 180 then
			var_29_0.transform.eulerAngles = var_0_16(0, 0, 0)

			return var_0_15(96.5, 89.6)
		elseif arg_29_1 == 0 then
			var_29_0.transform.eulerAngles = var_0_16(0, 0, 180)

			return var_0_15(-97, 87)
		end
	end

	function arg_1_0:_is_have_pass_node(arg_30_1, arg_30_2)
		local var_30_1 = {}

		for iter_30_0, iter_30_1 in ipairs(arg_30_1) do
			var_0_7(var_30_1, var_0_3:score_map_is_pass(iter_30_1) and 1 or 0)
		end

		return self:_have_data_2(var_30_1, 0), arg_30_2
	end

	function arg_1_0:__destroy_seq(arg_31_1)
		if self._light_seq_2 then
			for iter_31_0, iter_31_1 in pairs(self._light_seq_2) do
				iter_31_1:Kill()
			end
		end

		if self._light_seq and arg_31_1 ~= "detail_close" then
			for iter_31_2, iter_31_3 in pairs(self._light_seq) do
				iter_31_3:Kill()
			end
		end

		if self._light_seq_list then
			for iter_31_4, iter_31_5 in pairs(self._light_seq_list) do
				iter_31_5:Kill()
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

		for iter_33_0, iter_33_1 in ipairs({
			{
				preload_count = 10,
				preload_obj_name = "map_line_obj"
			},
			{
				preload_count = 10,
				preload_obj_name = "map_node_obj"
			},
			{
				preload_count = 2,
				preload_obj_name = "score_boss_node_obj"
			},
			{
				preload_count = 10,
				preload_obj_name = "score_sea_letter_obj"
			},
			{
				preload_count = 10,
				preload_obj_name = "score_map_line_obj"
			}
		}) do
			self._obj_pool[iter_33_1.preload_obj_name] = {}

			for iter_33_2 = 1, iter_33_1.preload_count do
				local var_33_0, var_33_1 = self:loadUIPrefab(iter_33_1.preload_obj_name, self._control.obj_pool_root.transform)

				var_33_0:setVisible(true)

				self._obj_pool[iter_33_1.preload_obj_name][#self._obj_pool[iter_33_1.preload_obj_name] + 1] = {
					using = false,
					prefabObj = var_33_0,
					prefabContorl = var_33_1
				}
			end
		end

		self._control.obj_pool_root:GetComponent("CanvasGroup").interactable = true
	end

	function arg_1_0:__load_map_fragment_with_pool(arg_34_1, arg_34_2)
		local var_34_0 = false
		local var_34_1

		if self._obj_pool and next(self._obj_pool) then
			for iter_34_0, iter_34_1 in ipairs(self._obj_pool[arg_34_1]) do
				if iter_34_1.using == false then
					var_34_0 = true
					var_34_1 = self._obj_pool[arg_34_1][iter_34_0]

					break
				end
			end

			if var_34_0 then
				var_34_1.using = true

				var_34_1.prefabObj._panel.transform:SetParent(arg_34_2)

				return var_34_1.prefabObj, var_34_1.prefabContorl
			else
				local var_34_2, var_34_3 = self:loadUIPrefab(arg_34_1, arg_34_2)

				self._obj_pool[arg_34_1][#self._obj_pool[arg_34_1] + 1] = {
					using = true,
					prefabObj = var_34_2,
					prefabContorl = var_34_3
				}

				return var_34_2, var_34_3
			end
		else
			self:__preload_map_fragment()

			for iter_34_2, iter_34_3 in ipairs(self._obj_pool[arg_34_1]) do
				if iter_34_3.using == false then
					var_34_0 = true
					var_34_1 = self._obj_pool[arg_34_1][iter_34_2]

					break
				end
			end

			if var_34_0 then
				var_34_1.using = true

				var_34_1.prefabObj._panel.transform:SetParent(arg_34_2)

				return var_34_1.prefabObj, var_34_1.prefabContorl
			else
				local var_34_4, var_34_5 = self:loadUIPrefab(arg_34_1, arg_34_2)

				self._obj_pool[arg_34_1][#self._obj_pool[arg_34_1] + 1] = {
					using = true,
					prefabObj = var_34_4,
					prefabContorl = var_34_5
				}

				return var_34_4, var_34_5
			end
		end
	end

	function arg_1_0:__hide_all_mini_map_fragment_to_pool()
		if not self._obj_pool then
			return
		end

		for iter_35_0, iter_35_1 in pairs(self._obj_pool) do
			if iter_35_1 then
				for iter_35_2, iter_35_3 in ipairs(iter_35_1) do
					if iter_35_3.using and iter_35_0 ~= "score_map_line_obj" then
						iter_35_3.prefabObj._panel.transform:SetParent(self._control.obj_pool_root.transform, false)

						iter_35_3.using = false
					end
				end
			end
		end
	end

	function arg_1_0:__destroy_pool()
		if self._obj_pool and #self._obj_pool > 0 then
			for iter_36_0, iter_36_1 in pairs(self._obj_pool) do
				for iter_36_2, iter_36_3 in pairs(iter_36_1) do
					iter_36_3 = nil
				end
			end

			for iter_36_4, iter_36_5 in pairs(self._obj_pool) do
				iter_36_5 = nil
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

		self:destroyChildren("map_line_obj")
		self:destroyChildren("map_node_obj")
		self:destroyChildren("score_boss_node_obj")
		self:destroyChildren("score_sea_letter_obj")
		self:destroyChildren("score_map_line_obj")
	end

	function arg_1_0:__pass_all_normal_map()
		for iter_37_0, iter_37_1 in pairs(self._active_config.levels) do
			if not var_0_3:is_score_map_pass(iter_37_1) then
				return false
			end
		end

		return true
	end

	function arg_1_0.__play_video(arg_38_0, arg_38_1)
		var_0_19.PlayFullScreenMovie(arg_38_1, var_0_22.black, var_0_21.Hidden)
	end

	function arg_1_0:_play_into_se(arg_39_1)
		self:playSE(arg_39_1, false)
	end

	function arg_1_0:__initial_func()
		local var_40_0 = {
			{
				nodetext = "activityinstruction",
				node = self._control.score_guide.tip_layer.bg_container.title
			},
			{
				nodetext = "activityinstruction",
				node = self._control.score_guide.guidecontent.guidetext
			},
			{
				nodetext = "ui_4th_zhankuang",
				node = self._control.score_map_detail.main.right.awardtitle_text
			},
			{
				nodetext = "ui_4th_enter_select",
				node = self._control.score_map_detail.main.right.supplytitle_text
			},
			{
				nodetext = "ui_4th_prepare",
				node = self._control.score_map_detail.main.bottom.fight_prepare_btn.text
			}
		}
		local var_40_1 = {
			{
				state = false,
				node = self._control.score_guide
			},
			{
				state = false,
				node = self._control.score_map_detail
			},
			{
				state = false,
				node = self._control.main.middle.map._10201
			},
			{
				state = false,
				node = self._control.active_result_bg
			},
			{
				state = false,
				node = self._control.active_hard_bg
			},
			{
				state = false,
				node = self._control.active_bg
			},
			{
				state = false,
				node = self._control.score_map_detail.main.map_panel.pass_icon
			},
			{
				state = false,
				node = self._control.main.middle.map_score
			},
			{
				state = false,
				node = self._control.main.bottom.hard_btn
			},
			{
				state = false,
				node = self._control.main.bottom.normal_btn
			},
			{
				state = false,
				node = self._control.shadow
			}
		}
		local var_40_2 = {
			init_language = function(self, arg_41_1)
				self.text.text = var_0_1:getNowLang(arg_41_1)
			end,
			init_active = function(self, arg_42_1)
				self.gameObject:SetActive(arg_42_1)
			end
		}

		for iter_40_0 = 1, #var_40_0 do
			var_40_2.init_language(var_40_0[iter_40_0].node, var_40_0[iter_40_0].nodetext)
		end

		if self._have_map_num == 4 then
			for iter_40_1 = 1, #var_40_1 do
				var_40_2.init_active(var_40_1[iter_40_1].node, var_40_1[iter_40_1].state)
			end
		elseif self._have_map_num == 6 then
			for iter_40_2 = 1, #{
				{
					state = false,
					node = self._control.score_guide
				},
				{
					state = false,
					node = self._control.score_map_detail
				},
				{
					state = false,
					node = self._control.main.middle.map_4._10201
				},
				{
					state = false,
					node = self._control.active_result_bg
				},
				{
					state = false,
					node = self._control.active_hard_bg
				},
				{
					state = false,
					node = self._control.active_bg
				},
				{
					state = false,
					node = self._control.score_map_detail.main.map_panel.pass_icon
				},
				{
					state = false,
					node = self._control.main.middle.map_score
				},
				{
					state = false,
					node = self._control.main.bottom.hard_btn
				},
				{
					state = false,
					node = self._control.main.bottom.normal_btn
				},
				{
					state = false,
					node = self._control.shadow
				}
			} do
				var_40_2.init_active(var_40_1[iter_40_2].node, var_40_1[iter_40_2].state)
			end
		end

		self._control.instructions.prev.prev_text.text.text = var_0_1:getNowLang("ui_new_guide_last")
		self._control.instructions.next.next_text.text.text = var_0_1:getNowLang("ui_new_guide_next")
	end

	function arg_1_0:__init_anim()
		self._control.main.top.rectTransform.anchoredPosition = var_0_16.New(0, 50)
		self._control.main.bottom.rectTransform.anchoredPosition = var_0_16.New(0, -60)

		self._control.main.top.transform:DOBlendableLocalMoveBy(var_0_16.New(0, -100), 0.3)
		self._control.main.bottom.transform:DOBlendableLocalMoveBy(var_0_16.New(0, 120), 0.3)
	end

	function arg_1_0:__get_award_type()
		if self._current_reward_id >= 10000000 then
			if self._current_reward_id % 100 == 21 then
				return var_0_5.reward_type.equipment
			elseif self._current_reward_id % 100 == 11 or self._current_reward_id % 100 == 12 or self._current_reward_id % 100 == 13 then
				return var_0_5.reward_type.ship
			elseif self._current_reward_id % 100 == 61 then
				return var_0_5.reward_type.head_icon
			elseif self._current_reward_id % 100 == 71 then
				return var_0_5.reward_type.furniture
			end
		elseif self._current_reward_id % 100 == 81 then
			return var_0_5.reward_type.cg
		else
			return var_0_5.reward_type.item
		end
	end

	function arg_1_0:__show_score_award_detail()
		local var_45_0 = self:__get_award_type()

		if var_45_0 == var_0_5.reward_type.equipment then
			self:__show_equip_mask(true)

			self._equip_attr = self._equip_attr or self:loadUI("equip_attr")

			self._equip_attr._panel.transform:SetParent(self._panel.transform)
			self._equip_attr:show((var_0_10.find_object_by_cid(self._current_reward_id)))
		elseif var_45_0 == var_0_5.reward_type.ship then
			var_0_2:createInstance("ship_detail"):show(var_0_5.enter_ship_detail_type.bootyshop, (var_0_9.find_object_by_cid(self._current_reward_id)))
		elseif var_45_0 == var_0_5.reward_type.item then
			var_0_2:createInstance("specificdetails"):show(self._current_reward_id, var_0_5.enter_icon_detail_type.bootyshop_item)
		elseif var_45_0 == var_0_5.reward_type.cg then
			var_0_2:createInstance("specificdetails"):show(self._current_reward_id, var_0_5.enter_icon_detail_type.bootyshop_cg)

			return
		elseif var_45_0 == var_0_5.reward_type.head_icon then
			return
		end
	end

	function arg_1_0:__show_equip_mask(arg_46_1)
		self._control.equip_mask:SetActive(arg_46_1)

		if self._equip_attr then
			self._equip_attr._panel:SetActive(arg_46_1)
		end
	end

	function arg_1_0:__is_have_answer_question_panel()
		self._control.main.top.btns.answer_entrance_btn.not_finish_image:SetActive(true)

		if var_0_3:get_player_answer_num().guide then
			-- block empty
		else
			var_0_3:req_AnswerRemindReq()
		end
	end

	function arg_1_0:__show_answer_question_panel()
		self._control.main.top.btns.answer_entrance_btn.not_finish_image:SetActive(true)
		var_0_2:createInstance("msgbox"):show(var_0_1:getNowLang("whether_answer"), function()
			local var_49_0 = var_0_2:getInstance("score_push")

			if var_49_0 then
				self:setVisible(false)
				var_49_0:show()
			else
				var_0_2:createInstance("score_push"):show()
			end
		end, nil, var_0_1:getNowLang("confirm_answer"))
	end

	function arg_1_0:__show_answer_award_tips()
		self._answer_award_info = var_0_3:get_answer_award_info()
		self._award_data, self._award_num = var_0_28.get_sequence()

		local var_50_0 = lx.clone_table(self._award_data)
		local var_50_1 = lx.clone_table(self._answer_award_info.reward)

		if var_50_1 and next(var_50_1) then
			for iter_50_0, iter_50_1 in pairs(var_50_1) do
				for iter_50_2, iter_50_3 in pairs(var_50_0) do
					if iter_50_3.id == iter_50_1 then
						table.remove(var_50_0, iter_50_2)
					end
				end
			end
		end

		local var_50_2 = var_0_3:get_score_map_buff_list()
		local var_50_4 = var_0_3:get_score_cia_num().coin
		local var_50_5 = false

		if var_50_0 and next(var_50_0) then
			for iter_50_4, iter_50_5 in pairs(var_50_0) do
				if var_50_4 >= iter_50_5.score then
					if iter_50_5.level_id == 0 then
						var_50_5 = true
					else
						local var_50_6 = var_0_3:get_score_map_data()

						if var_50_6 and next(var_50_6) and var_50_6[iter_50_5.level_id] and var_50_6[iter_50_5.level_id].state == 2 then
							var_50_5 = true
						end
					end
				end
			end
		end

		if var_50_5 then
			self._control.main.top.btns.integral_task_btn.not_finish_task:SetActive(true)
		else
			self._control.main.top.btns.integral_task_btn.not_finish_task:SetActive(false)
		end
	end

	function arg_1_0:__show_answer_question_point()
		local var_51_0 = var_0_3:get_score_question_team()

		self._say_num = 0

		for iter_51_0, iter_51_1 in ipairs(var_51_0) do
			if iter_51_1.state == 2 then
				self._say_num = self._say_num + 1
			end
		end

		if self._say_num == #var_51_0 then
			self._control.main.top.btns.answer_entrance_btn.not_finish_image:SetActive(false)
		else
			self._control.main.top.btns.answer_entrance_btn.not_finish_image:SetActive(true)
		end
	end

	function arg_1_0:is_pass_opean_big_map()
		self._pass_map = {}

		for iter_52_0, iter_52_1 in pairs(self._user_data) do
			if iter_52_1.state == 2 then
				if iter_52_1.boss_hp[1].hp == 0 then
					self._pass_map[iter_52_1.boss_hp[1].id] = iter_52_1.boss_hp[1].id
				end

				if iter_52_1.boss_hp[2].hp == 0 then
					self._pass_map[iter_52_1.boss_hp[2].id] = iter_52_1.boss_hp[2].id
				end
			end
		end
	end

	function arg_1_0:show_panel_pass(arg_53_1)
		local var_53_0 = var_0_3:get_battle_info().id

		self._info_move_seq = {}

		local var_53_1 = self:autoKillDOTween(var_0_12.Sequence())

		var_0_7(self._info_move_seq, var_53_1)

		if var_0_3:get_score_map_pass() then
			self._control.pass_map:SetActive(true)
			self._control.pass_map.all:SetActive(false)
			self._control.pass_map.score_move:SetActive(true)

			local var_53_2 = var_0_23.find_object_by_id(var_53_0)

			self._control.pass_map.score_move.text.text.text = var_0_6("<color=#%s>%s</color>" .. "         " .. "<color=#%s>%s%s%s</color>", "FFFFFF", var_0_1:getNowLang("logget"), "F0ED86", var_0_1:getNowLang("score"), "*", (var_53_2 or nil) and var_53_2.boss_score)

			var_53_1:Append(self._control.pass_map.score_move.rectTransform:DOLocalMoveX(-1280, 1.5))
			var_53_1:AppendInterval(0.5)
			var_53_1:Append(self._control.pass_map.score_move.rectTransform:DOLocalMoveX(-1280 + -1280, 1.5))
			var_53_1:AppendInterval(0.5)
			var_53_1:AppendCallback(function()
				self._control.pass_map:SetActive(false)
			end)
			var_53_1:SetLoops(1)
		else
			self._control.pass_map:SetActive(true)
			self._control.pass_map.all:SetActive(true)
			self._control.pass_map.score_move:SetActive(true)

			local var_53_6 = var_0_23.find_object_by_id(var_53_0)
			local var_53_7 = ""
			local var_53_8 = 0

			if var_53_6 then
				var_53_8 = var_53_6.boss_score
				var_53_7 = var_53_6.sub_title
			end

			self._control.pass_map.all.text.text.text = var_0_6(var_0_1:getNowLang("ui_activityworldpasstip") .. " " .. var_53_7)
			self._control.pass_map.score_move.text.text.text = var_0_6("<color=#%s>%s</color>" .. "         " .. "<color=#%s>%s%s%s</color>", "FFFFFF", var_0_1:getNowLang("logget"), "F0ED86", var_0_1:getNowLang("score"), "*", var_53_8)

			var_53_1:Append(self._control.pass_map.all.rectTransform:DOLocalMoveX(-1280, 1.5))
			var_53_1:AppendInterval(0.5)
			var_53_1:Append(self._control.pass_map.all.rectTransform:DOLocalMoveX(-1280 + -1280, 1.5))
			var_53_1:AppendInterval(0.5)
			var_53_1:Append(self._control.pass_map.score_move.rectTransform:DOLocalMoveX(-1280, 1.5))
			var_53_1:AppendInterval(0.5)
			var_53_1:Append(self._control.pass_map.score_move.rectTransform:DOLocalMoveX(-1280 + -1280, 1.5))
			var_53_1:AppendInterval(0.5)
			var_53_1:AppendCallback(function()
				self._control.pass_map:SetActive(false)
			end)
			var_53_1:SetLoops(1)
		end

		var_0_3:set_score_map_pass(false)
	end

	function arg_1_0:__finish_special_task()
		local var_56_0 = var_0_3:_get_now_task_data()
		local var_56_1 = var_0_3:get_first_answer_task_id()

		if var_56_0 then
			local var_56_2 = var_0_26.find_object_by_id(var_56_0)

			self._control.msg_panel.finish_special_mission:SetActive(true)

			self._control.msg_panel.finish_special_mission.map_title.text.text = var_56_2.sub_title
			self._control.msg_panel.finish_special_mission.task_title.text.text = var_56_2.title
			self._control.msg_panel.finish_special_mission.coin_num.text.text = var_56_2.award

			local var_56_3 = self:autoKillDOTween(var_0_12.Sequence())

			var_56_3:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(0, 0))
			var_56_3:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(1, 1))

			self._special_task_seq = var_56_3

			var_0_3:_clear_now_task_data(nil)
		end

		if var_56_1 and #var_56_1 == 1 then
			local var_56_4 = var_0_26.find_object_by_id(var_56_1[1])

			self._control.msg_panel.finish_special_mission:SetActive(true)

			self._control.msg_panel.finish_special_mission.map_title.text.text = var_56_4.sub_title
			self._control.msg_panel.finish_special_mission.task_title.text.text = var_56_4.title
			self._control.msg_panel.finish_special_mission.coin_num.text.text = var_56_4.award

			local var_56_5 = self:autoKillDOTween(var_0_12.Sequence())

			var_56_5:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(0, 0))
			var_56_5:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(1, 1))

			self._special_task_seq = var_56_5

			var_0_3:_clear_now_task_data(nil)
			var_0_3:set_first_answer_task_id()
		end
	end

	function arg_1_0:_play_audio(arg_57_1, arg_57_2)
		self:playBackgroundMusic(arg_57_1, arg_57_2)
	end

	function arg_1_0:get_answer_all_score()
		self._control.point_num_1.point_num_1_text.text.text = var_0_3:get_score_cia_num().coin
	end

	function arg_1_0.check_node_enemy(arg_59_0, arg_59_1)
		for iter_59_0, iter_59_1 in pairs(var_0_3:get_score_map_buff_list().ids) do
			for iter_59_2, iter_59_3 in pairs(var_0_27.find_object_by_id(iter_59_1).effect) do
				if iter_59_3.type == 9 and iter_59_3.node_id[1] == arg_59_1.id then
					return false
				end
			end
		end

		return true
	end

	function arg_1_0:show_small_panel()
		local var_60_0 = 0
		local var_60_1 = var_0_3:get_answer_task_info()

		if var_60_1 and next(var_60_1) then
			for iter_60_0, iter_60_1 in pairs(var_60_1) do
				local var_60_2 = var_0_26.find_object_by_id(iter_60_1)

				if var_60_2.level_id == self.map_fight_prepare_id then
					var_60_0 = var_60_0 + var_60_2.award
				end
			end
		end

		for iter_60_2, iter_60_3 in pairs((var_0_3:get_score_map_data())) do
			local var_60_3 = var_0_23.find_object_by_id(self.map_fight_prepare_id)

			if iter_60_3.boss_hp[1].id == var_60_3.boss[1][1] and iter_60_3.boss_hp[1].hp == 0 then
				var_60_0 = var_60_0 + var_60_3.boss_score
			end

			if #iter_60_3.boss_hp > 1 and #var_60_3.boss > 1 then
				if iter_60_3.boss_hp[1].id == var_60_3.boss[2][1] and iter_60_3.boss_hp[1].hp == 0 then
					var_60_0 = var_60_0 + var_60_3.boss_score
				end

				if iter_60_3.boss_hp[2].id == var_60_3.boss[2][1] and iter_60_3.boss_hp[2].hp == 0 then
					var_60_0 = var_60_0 + var_60_3.boss_score
				end

				if iter_60_3.boss_hp[2].id == var_60_3.boss[1][1] and iter_60_3.boss_hp[2].hp == 0 then
					var_60_0 = var_60_0 + var_60_3.boss_score
				end
			end
		end

		self._control.score_map_detail.main.right.icon_box.icon_box_num_1.text.text = var_60_0
	end

	function arg_1_0:__onReset()
		self.map_fight_prepare_id = nil
		self._have_map_num = 6
		self._have_init_num = 0
		self._default_map_id = nil
		self._current_station_team_id = 0
		self._control.main.top.rectTransform.anchoredPosition = var_0_16.New(0, 50)
		self._control.main.bottom.rectTransform.anchoredPosition = var_0_16.New(0, -60)

		self._control.score_map_detail:SetActive(false)

		if self._light_seq_2 then
			for iter_61_0, iter_61_1 in pairs(self._light_seq_2) do
				if iter_61_1 and iter_61_1:IsPlaying() then
					iter_61_1:Kill()
				end
			end
		end

		if self._light_seq then
			for iter_61_2, iter_61_3 in pairs(self._light_seq) do
				if iter_61_3 and iter_61_3:IsPlaying() then
					iter_61_3:Kill()
				end
			end
		end

		if self._light_seq_list then
			for iter_61_4, iter_61_5 in pairs(self._light_seq_list) do
				iter_61_5:Kill()
			end
		end
	end

	function arg_1_0:show_score_panel_mix_panel(arg_62_1, arg_62_2)
		if arg_62_2 then
			if next(self._active_config.hardLevels) then
				for iter_62_0, iter_62_1 in pairs(self._active_config.hardLevels) do
					if iter_62_1 == arg_62_1 then
						if iter_62_0 == 1 then
							self:__onClick_main_middle_btns__10201_btn1()
						else
							self._btn_index = iter_62_0
							self.__now_state = 2

							var_0_3:set_now_level_state(self.__now_state)
							self:__enter_map_func()
							self:show_small_panel()
						end
					end
				end
			end
		elseif next(self._active_config.levels) then
			for iter_62_2, iter_62_3 in pairs(self._active_config.levels) do
				if iter_62_3 == arg_62_1 then
					if iter_62_2 == 1 then
						self:__onClick_main_middle_btns__10201_btn1()
					else
						self._btn_index = iter_62_2
						self.__now_state = 1

						var_0_3:set_now_level_state(self.__now_state)
						self:__enter_map_func()
						self:show_small_panel()
					end
				end
			end
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_63_0)
	local var_63_0 = var_0_2:class("score_push_map")

	var_63_0._active_id = nil
	var_63_0._is_init = false
	var_63_0._active_config = nil
	var_63_0._big_normal_map_data = {}
	var_63_0._big_hard_map_data = {}
	var_63_0._hard_node_data = {}
	var_63_0.__map_list = {}
	var_63_0.__map_list_2 = {}
	var_63_0.__map_name_list = {}
	var_63_0.__now_state = nil
	var_63_0.__btn_state = nil
	var_63_0._light_seq = {}
	var_63_0._light_seq_2 = {}
	var_63_0.user_point_list = {}
	var_63_0.user_box_list = {}
	var_63_0._btn_index = 0
	var_63_0._current_reward_id = 0
	var_63_0._equip_attr = nil
	var_63_0._page_move = 1
	var_63_0._is_unlocked_1 = true
	var_63_0._is_unlocked_2 = false
	var_63_0.map_fight_prepare_id = nil
	var_63_0._have_map_num = 6
	var_63_0._have_init_num = 0
	var_63_0._default_map_id = nil
	var_63_0._active_map_id = nil

	gamecore.extend_obj(var_63_0)

	return var_63_0
end

return var_0_0
