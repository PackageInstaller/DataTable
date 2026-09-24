local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = string.sub
local var_0_4 = table.insert
local var_0_5 = gamecore.Language
local var_0_6 = gamecore.UILoader
local var_0_7 = string.format
local var_0_8 = gamecore.util_func
local var_0_9 = gameenum.common_type
local var_0_10 = gameconfig.ship_rule_config
local var_0_11 = gameconfig.strike_map_config
local var_0_12 = gameconfig.strike_buff_config
local var_0_13 = gameconfig.strike_award_config
local var_0_14 = gameconfig.ship_pve_active_config
local var_0_15 = gameconfig.strike_map_node_config
local var_0_16 = gameconfig.strike_intensify_buff_config
local var_0_17 = lx.Time
local var_0_18 = DG.Tweening.DOTween

gamecore.UILoader:define("strike_main", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self:setVisible(true)

		self._enter_index = arg_2_1

		if arg_2_2 then
			self._map_id = arg_2_2
		end

		var_0_1:set_to_strike(true)
		self:_init_panel()
		self:_init_move()
		var_0_6:createInstance("strike_weather"):show()
	end

	function arg_1_0:_init_panel()
		self:__initial_func()
		self:__init_data()
		self:update_content()
	end

	function arg_1_0:_init_move()
		self._control.main.top.title_bg.title.left_light.rectTransform.anchoredPosition = Vector2(-203, 0)

		if not self._signin_seq then
			self._signin_seq = self:autoKillDOTween(var_0_18.Sequence())

			self._signin_seq:Append(self._control.main.top.title_bg.title.left_light.transform:DOBlendableLocalMoveBy(Vector3.New(500, 0), 2):SetEase(DG.Tweening.Ease.Linear))
			self._signin_seq:SetLoops(-1)
			self._signin_seq:Play()
		end
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:__init_data()
		self._panel.transform:GetComponent("Canvas").sortingOrder = 500
		self._user_data = var_0_1:get_strike_data()

		var_0_1:reset_strike_enter_battle_nunber()

		local var_6_0 = var_0_14.find_object_by_id(var_0_10.find_object_by_id(17).content.activeId).levels
		local var_6_1 = 0

		for iter_6_0, iter_6_1 in pairs(self._user_data) do
			for iter_6_2, iter_6_3 in pairs(var_6_0) do
				if iter_6_0 == iter_6_3 then
					var_6_1 = var_6_1 + iter_6_1.score
				end
			end
		end

		self._user_score = var_6_1

		var_0_1:set_strike_user_money(var_6_1)

		self._active_config = var_0_14.find_object_by_id(self._map_id)

		self:_play_audio(var_0_9:get_audio_url(var_0_9.common_icon.music_path, self._active_config.bgm), true)
		var_0_1:set_strike_config(self._active_config)

		if not self._active_config then
			return
		end

		self:__init_main()

		if not self._init_already then
			self:__init_page()
		end
	end

	function arg_1_0:__init_main()
		self._control.main.top.title_bg.title.image.sprite = self:loadSprite(var_0_7(var_0_9.strike_title, self._map_id))

		self._control.main.bottom.btns.story_btn:SetActive(true)

		self._control.main.bottom.point_bg.point_text.text.text = self._user_score
		self._control.main.bottom.active_time.title_text.text.text = var_0_7("%s~%s", var_0_2(var_0_17:getDateString(self._active_config.start_time), 1, 10), var_0_2(var_0_17:getDateString(self._active_config.end_time), 1, 10))
		self._control.strike_guide.main.guidecontent.guide_text.text.text = string.gsub(self._active_config.desc, "\\n", "\n")
	end

	function arg_1_0:__init_page()
		self.__page_data = {}

		for iter_8_0, iter_8_1 in ipairs(self._active_config.levels) do
			var_0_4(self.__page_data, var_0_11.find_object_by_id(iter_8_1))
		end

		self._init_already = true

		self:__init_scroll_panel()
	end

	function arg_1_0:__init_scroll_panel()
		self.__page_scroll_panel = {}

		local var_9_0 = self._control.main.middle.page_main.latticeScrollRect
		local var_9_1 = 0

		for iter_9_0, iter_9_1 in ipairs(self.__page_data) do
			local var_9_2, var_9_3 = self:loadUIPrefab("strike_page_item", self._control.main.middle.page_main.viewport.content.transform)

			var_9_2:setVisible(true)

			var_9_3.page_bg.image.sprite = self:loadSprite(var_0_7(var_0_9.strike_bg, iter_9_1.id))
			self.__page_scroll_panel[iter_9_0] = {}
			self.__page_scroll_panel[iter_9_0].item = var_9_2
			self.__page_scroll_panel[iter_9_0].control = var_9_3
			var_9_1 = iter_9_0
		end

		if var_9_1 > 0 then
			self._control.main.middle.page_main.latticeScrollRect:InitItemWidth(self.__page_scroll_panel[1].item._panel)
			self._control.main.middle.page_main.latticeScrollRect:SetContentWidthWithMapCount(var_9_1)
			self._control.main.middle.page_main.latticeScrollRect:SetTargetItemIndex(0)

			self._max_page_num = var_9_1
			self._now_page_num = 1

			self._control.main.middle.page_main.latticeScrollRect.onDrag:RemoveAllListeners()
			self._control.main.middle.page_main.latticeScrollRect.onDrag:AddListener(function()
				self._now_page_num = var_9_0.m_ShowItemIndex + 1

				self:init_weather()
				self:update_page()
			end)
			self._control.main.middle.page_main.latticeScrollRect.onNext:RemoveAllListeners()
			self._control.main.middle.page_main.latticeScrollRect.onNext:AddListener(function()
				self:__push_page_btn(var_9_0.m_ShowItemIndex)
			end)
			self._control.main.middle.page_main.latticeScrollRect.onLast:RemoveAllListeners()
			self._control.main.middle.page_main.latticeScrollRect.onLast:AddListener(function()
				self:__push_page_btn(var_9_0.m_ShowItemIndex)
			end)
		end

		if self._enter_index and self._enter_index > 0 and self._enter_index <= self._max_page_num then
			self._now_page_num = self._enter_index

			self._control.main.middle.page_main.latticeScrollRect:SetTargetItemIndex(self._now_page_num - 1)
		end
	end

	function arg_1_0:__init_reusable_cell()
		if self._init_already then
			self._reusable_cell = gamecore.reusable_cell:create(self, self._control.strike_whole_buff.main.scrollview.viewport.content.endlessScrollView, self._control.strike_whole_buff.main.scrollview.viewport.content, "single_strike_whole_buff", "strike_main")

			self._reusable_cell:init()
		end

		self:update_cell()

		self._init_already = false
	end

	function arg_1_0:update_cell()
		local var_14_0 = var_0_16.get_sequence()
		local var_14_1 = var_0_1:get_whole_buff_number()

		self._control.strike_whole_buff.main.now_buff.desc_text.text.text = var_0_5:getNowLang("solidintensify_buff")
		self._control.strike_whole_buff.main.active_btn.open_text.text.text = var_0_5:getNowLang("ui_support_on")
		self._control.strike_whole_buff.main.active_btn.close_text.text.text = var_0_5:getNowLang("notopen")

		self._reusable_cell:set_data(var_14_0)

		function self._reusable_cell:_set_func(arg_15_1)
			self.active_bg.buff_desc.text.text.text = var_14_0[arg_15_1 + 1].number < 99 and var_0_5:getNowLang("solidintensify_buff_desc") .. " " .. tostring(var_14_0[arg_15_1 + 1].number) .. "  " .. var_0_5:getNowLang("solidintensify_buff_number") or var_0_5:getNowLang("solidintensify_buff_desc") .. tostring(var_14_0[arg_15_1 + 1].number) .. var_0_5:getNowLang("solidintensify_buff_number")
			self.active_bg.buff_effect.text.text.text = var_14_0[arg_15_1 + 1].effect_desc

			if var_14_0[arg_15_1 + 1].number <= var_14_1 and var_0_1:get_whole_buff_state() then
				self.active_bg.buff_desc.text.text.color = Color.New(0.403921568627451, 0.9725490196078431, 1)
				self.active_bg.buff_effect.text.text.color = Color.New(0.403921568627451, 0.9725490196078431, 1)
			else
				self.active_bg.buff_desc.text.text.color = Color.New(0.2, 0.38823529411764707, 0.5137254901960784)
				self.active_bg.buff_effect.text.text.color = Color.New(0.2, 0.38823529411764707, 0.5137254901960784)
			end
		end
	end

	function arg_1_0:__push_page_btn(arg_16_1)
		self:_play_into_se(var_0_9:get_audio_url(var_0_9.common_icon.music_path, var_0_9.move_map_page))

		self._now_page_num = arg_16_1 + 1

		self:update_page()
	end

	function arg_1_0:update_content()
		self:update_page()
		self:update_reward()
	end

	function arg_1_0:update_page()
		if not self._now_page_num or self._now_page_num < 1 or self._now_page_num > #self.__page_data or not self.__page_data then
			return
		end

		local var_18_0 = self.__page_data[self._now_page_num]

		var_0_1:set_strike_page_id(self.__page_data[self._now_page_num].id)

		self.__now_page = var_18_0.id

		local var_18_1 = self.__page_scroll_panel[self._now_page_num]

		if not var_18_0 or not var_18_1 then
			return
		end

		self._user_cur_page_data = var_0_1:get_strike_data_by_level(var_18_0.id)

		if not self._user_cur_page_data or not next(self._user_cur_page_data) then
			local var_18_2 = {
				id = var_18_0.id
			}

			var_18_2.state = 1
			var_18_2.state_hard = 1
			var_18_2.score = 0
			self._user_cur_page_data = lx.clone_table(var_18_2)
		end

		local var_18_3 = {}
		local var_18_5 = 1

		while true do
			var_18_5 = var_18_5 + 1

			local var_18_6 = var_0_15.find_object_by_id(tonumber(var_18_0.id) * 100 + var_18_5)

			if var_18_6 then
				var_0_4(var_18_3, var_18_6.id)
			else
				break
			end
		end

		if not var_18_3 or not next(var_18_3) then
			return
		end

		self.__five_state = true
		self.__six_state = true
		self._cur_page_not_open = false

		if self._now_page_num == 5 then
			local var_18_7 = var_0_11.find_object_by_id(var_18_0.id)

			if var_18_7.pre_ids and next(var_18_7.pre_ids) then
				for iter_18_0, iter_18_1 in pairs(var_18_7.pre_ids) do
					if iter_18_1 ~= var_18_0.id and (not self._user_data or not self._user_data[iter_18_1] or self._user_data[iter_18_1].score <= 0) then
						self._cur_page_not_open = true
						self.__five_state = false

						break
					end
				end
			end
		elseif self._now_page_num == 6 then
			local var_18_8 = var_0_11.find_object_by_id(var_18_0.id)

			if var_18_8.pre_ids and next(var_18_8.pre_ids) then
				for iter_18_2, iter_18_3 in pairs(var_18_8.pre_ids) do
					if iter_18_3 ~= var_18_0.id and (not self._user_data or not self._user_data[iter_18_3] or self._user_data[iter_18_3].score <= 0) then
						self._cur_page_not_open = true
						self.__six_state = false

						break
					end
				end
			end
		end

		self._cur_page_hard_open = not self._cur_page_not_open and (self._user_cur_page_data and self._user_cur_page_data.score >= var_18_0.hard_score or false) or false
		self._cur_page_clear = false

		if self._user_data[var_18_0.id] and not self._cur_page_hard_open then
			self._cur_page_clear = self._user_data[var_18_0.id].score > 0 and self._user_data[var_18_0.id].score < var_18_0.hard_score
		end

		if self._cur_page_hard_open then
			self._cur_page_clear = false
		end

		var_0_1:set_strike_now_state(self._cur_page_hard_open)

		self._control.main.middle.page_main.title_bg.title_text1.text.text = var_18_0.sub_title
		self._control.main.middle.page_main.title_bg.title_text2.text.text = var_18_0.title

		if self._now_page_num >= 5 then
			self._control.main.middle.page_main.lock_text.text.text = var_18_0.desc3
		end

		self._control.main.middle.bottom.introducecontent.introduce_text.text.text = var_18_0.desc
		self._control.main.middle.bottom.boss_bg.boss_spine.image.sprite = self:loadSprite(var_0_7(var_0_9.fearlessness_sea_node_boss, var_18_0.id))

		if self._cur_page_not_open then
			self._control.main.middle.bottom.warning.text.text.text = var_18_0.desc2
			self._cur_point_total_money = var_18_0.point1
			self._control.main.middle.bottom.allreward.point_text.text.text = var_0_7("%s/%s", 0, var_18_0.point1)

			self._control.main.middle.page_main.lock_img.gameObject:SetActive(true)
			self._control.main.middle.page_main.lock_text.gameObject:SetActive(true)
			self._control.main.middle.page_main.pass_img.gameObject:SetActive(false)
			var_18_1.control.page_shadow.gameObject:SetActive(true)
			self._control.main.middle.page_main.mode_img.gameObject:SetActive(false)

			self._cur_page_weather = var_18_0.weather
		else
			if self._cur_page_hard_open then
				self._control.main.middle.bottom.warning.text.text.text = var_18_0.desc4
				self._cur_point_total_money = var_18_0.point2
				self._control.main.middle.bottom.allreward.point_text.text.text = var_0_7("%s/%s", self._user_cur_page_data.score, var_18_0.point2)

				local var_18_9 = var_0_1:get_strike_data_by_level(var_18_0.id)

				if self._cur_point_total_money > 0 and var_18_9 and next(var_18_9) and var_18_9.state_hard == 2 then
					self._control.main.middle.bottom.boss_bg.boss_spine.image.sprite = self:loadSprite(var_0_7(var_0_9.fearlessness_sea_node_boss_b, var_18_0.id))
				end

				self._control.main.middle.page_main.mode_img.gameObject:SetActive(true)

				self._cur_page_weather = var_18_0.weather2
			else
				self._control.main.middle.bottom.warning.text.text.text = var_18_0.desc2
				self._cur_point_total_money = var_18_0.point1
				self._control.main.middle.bottom.allreward.point_text.text.text = self._user_cur_page_data and var_0_7("%s/%s", self._user_cur_page_data.score, var_18_0.point1) or var_0_7("%s/%s", 0, var_18_0.point1)

				self._control.main.middle.page_main.mode_img.gameObject:SetActive(false)

				self._cur_page_weather = var_18_0.weather
			end

			self._control.main.middle.page_main.lock_img.gameObject:SetActive(false)
			self._control.main.middle.page_main.lock_text.gameObject:SetActive(false)
			var_18_1.control.page_shadow.gameObject:SetActive(false)

			if self._cur_page_clear then
				self._control.main.middle.page_main.pass_img.gameObject:SetActive(true)
			else
				self._control.main.middle.page_main.pass_img.gameObject:SetActive(false)
			end
		end

		if not self._user_cur_page_data then
			self._control.main.middle.page_main.pass_img.gameObject:SetActive(false)
		end

		if self.__five_state and self._now_page_num == 5 or self.__six_state and self._now_page_num == 6 then
			self._control.main.middle.page_main.lock_img.gameObject:SetActive(false)
			self._control.main.middle.page_main.lock_text.gameObject:SetActive(false)
			var_18_1.control.page_shadow.gameObject:SetActive(false)
		end

		if self._cur_page_weather ~= 0 then
			self._control.main.middle.weather_bg:SetActive(true)

			self._control.main.middle.weather_bg.weather_anim.animator.runtimeAnimatorController = self:loadRuntimeAnimatorController((var_0_7(var_0_9.strike_weather_anim, self._cur_page_weather)))
		else
			self._control.main.middle.weather_bg:SetActive(false)
		end

		self:__update_strike_detail()
	end

	function arg_1_0:__update_strike_detail()
		local var_19_0
		local var_19_1
		local var_19_2
		local var_19_5
		local var_19_6 = self.__page_data[self._now_page_num]

		if self.__five_state and self._now_page_num == 5 or self.__six_state and self._now_page_num == 6 then
			for iter_19_0, iter_19_1 in pairs(self._user_data) do
				if iter_19_0 == self.__now_page and iter_19_1.score >= var_0_11.find_object_by_id(iter_19_1.id).point1 then
					var_19_0 = var_0_12.find_object_by_id(var_19_6.emergent_buff[1])
					var_19_1 = var_19_6.emergent_title
					var_19_2 = var_19_6.emergent_score

					local var_19_8 = var_0_8.convert_rich_text(var_19_0.desc)

					var_19_5 = var_19_6.emergent_desc
				else
					var_19_0 = var_0_12.find_object_by_id(var_19_6.emergent_buff[1])
					var_19_1 = var_19_6.emergent_title
					var_19_2 = var_19_6.emergent_score

					local var_19_10 = var_0_8.convert_rich_text(var_19_0.desc)

					var_19_5 = var_19_6.emergent_desc
				end
			end

			self._control.strike_detail.main.point.text_scroller:GetComponent("TextHorizonScroller"):SetText(var_19_1)

			self._control.strike_detail.main.point.point_num.text.text = var_19_2
			self._control.strike_detail.main.nodebg.buffdesc.text.text = var_19_5
			self._cur_page_buff = var_19_0
		end

		if not self._now_page_num or not self._user_cur_page_data then
			return
		end

		if not var_19_6 then
			return
		end

		if not self._cur_page_hard_open then
			var_19_0 = var_0_12.find_object_by_id(var_19_6.emergent_buff[1])
			var_19_1 = var_19_6.emergent_title
			var_19_2 = var_19_6.emergent_score

			local var_19_12 = var_0_8.convert_rich_text(var_19_0.desc)

			var_19_5 = var_19_6.emergent_desc
		else
			var_19_0 = var_0_12.find_object_by_id(var_19_6.emergent_buff2[1])
			var_19_1 = var_19_6.emergent_title2
			var_19_2 = var_19_6.emergent_score2

			local var_19_14 = var_0_8.convert_rich_text(var_19_0.desc)

			var_19_5 = var_19_6.emergent_desc2
		end

		self._control.strike_detail.main.point.text_scroller:GetComponent("TextHorizonScroller"):SetText(var_19_1)

		self._control.strike_detail.main.point.point_num.text.text = var_19_2
		self._control.strike_detail.main.nodebg.buffdesc.text.text = var_19_5
		self._cur_page_buff = var_19_0
	end

	function arg_1_0:update_reward()
		if not self._user_score then
			return
		end

		for iter_20_0, iter_20_1 in ipairs((var_0_13.get_sequence())) do
			if self._user_score >= iter_20_1.score and not var_0_1:get_strike_award_data_by_level(iter_20_1.id) then
				self._control.main.middle.reward_event.gameObject:SetActive(true)

				return
			end
		end

		self._control.main.middle.reward_event.gameObject:SetActive(false)
	end

	function arg_1_0:return_to_home()
		var_0_6:destroyInstance("strike_main")
		var_0_6:destroyInstance("strike_weather")
		var_0_1:set_to_strike(false)

		local var_21_0 = var_0_6:createInstance("home")

		if var_21_0 then
			var_21_0:show()
			self:_play_into_se(var_0_9:get_audio_url(var_0_9.common_icon.music_path, var_0_9.back))
			var_21_0:into_home_bgm()
		end
	end

	function arg_1_0.show_reward_box(arg_22_0)
		var_0_6:createInstance("strike_awardbox"):show(true)
	end

	function arg_1_0:show_strike_guide()
		self._control.strike_guide.gameObject:SetActive(true)
	end

	function arg_1_0:close_strike_guide()
		self._control.strike_guide.gameObject:SetActive(false)
	end

	function arg_1_0:show_strike_whole_buff()
		self:__init_reusable_cell()

		if var_0_1:get_whole_buff_state() then
			self._control.strike_whole_buff.main.active_btn.image.sprite = self:loadSprite(var_0_9.strike_whole_open)

			self._control.strike_whole_buff.main.active_btn.open_text.gameObject:SetActive(true)
			self._control.strike_whole_buff.main.active_btn.close_text.gameObject:SetActive(false)
		else
			self._control.strike_whole_buff.main.active_btn.image.sprite = self:loadSprite(var_0_9.strike_whole_close)

			self._control.strike_whole_buff.main.active_btn.open_text.gameObject:SetActive(false)
			self._control.strike_whole_buff.main.active_btn.close_text.gameObject:SetActive(true)
		end

		self._control.strike_whole_buff.gameObject:SetActive(true)
	end

	function arg_1_0:close_strike_whole_buff()
		self._control.strike_whole_buff.gameObject:SetActive(false)
	end

	function arg_1_0:show_story_record()
		var_0_6:createInstance("cinema_story_node"):show(self._active_config.movie_group_id, true)
	end

	function arg_1_0:show_strike_detail()
		local var_28_0 = self._control.strike_detail.main.nodebg.desc_scroller:GetComponent("TextHorizonScroller")
		local var_28_1 = self._control.strike_detail.main.nodebg.scroller:GetComponent("TextHorizonScroller")

		if self._cur_page_hard_open then
			self._control.strike_detail.main.nodebg.titlebg.image.sprite = self:loadSprite(var_0_7(var_0_9.strike_situation_bg, tostring("s_" .. var_0_12.find_object_by_id(self.__page_data[self._now_page_num].emergent_buff2[1]).type)))
			var_28_0.isRich = true

			var_28_0:SetText(var_0_8.convert_rich_text(var_0_12.find_object_by_id(self.__page_data[self._now_page_num].emergent_buff2[1]).desc .. "     "))
			var_28_1:SetText(self.__page_data[self._now_page_num].emergent_title2)
		else
			self._control.strike_detail.main.nodebg.titlebg.image.sprite = self:loadSprite(var_0_7(var_0_9.strike_situation_bg, tostring(var_0_12.find_object_by_id(self.__page_data[self._now_page_num].emergent_buff[1]).type)))
			var_28_0.isRich = true

			var_28_0:SetText(var_0_8.convert_rich_text(var_0_12.find_object_by_id(self.__page_data[self._now_page_num].emergent_buff[1]).desc .. "     "))
			var_28_1:SetText(self.__page_data[self._now_page_num].emergent_title)
		end

		if self._cur_page_clear == nil then
			self._cur_page_clear = false
		end

		if not self._cur_page_not_open then
			self._is_loading = false

			self._control.strike_detail.gameObject:SetActive(true)
		end

		if self.__five_state and self._now_page_num == 5 then
			self._is_loading = false

			self._control.strike_detail.gameObject:SetActive(true)
		end

		if self.__six_state and self._now_page_num == 6 then
			self._is_loading = false

			self._control.strike_detail.gameObject:SetActive(true)
		end
	end

	function arg_1_0:close_strike_detail()
		self._control.strike_detail.gameObject:SetActive(false)
	end

	function arg_1_0:get_page_data()
		return self.__page_data, self._now_page_num
	end

	function arg_1_0:init_weather(arg_31_1)
		local var_31_0 = var_0_6:createInstance("strike_weather")

		if not arg_31_1 then
			var_31_0:weather_update()
		else
			var_31_0:weather_update(self._now_page_num + arg_31_1)
		end
	end

	function arg_1_0:show_weather(arg_32_1)
		self._panel.transform:GetComponent("Canvas").sortingOrder = 500

		if self._cur_page_hard_open then
			var_0_6:destroyInstance("strike_weather")
			var_0_6:createInstance("strike_weather"):show()
		end
	end

	function arg_1_0:strike_set_active(arg_33_1)
		if arg_33_1 then
			self._panel:SetActive(arg_33_1)

			self._panel.transform:GetComponent("Canvas").sortingOrder = 500
		else
			self._control.strike_detail.gameObject:SetActive(arg_33_1)
			self._panel:SetActive(arg_33_1)
		end
	end

	function arg_1_0:strike_execute(arg_34_1)
		self._is_loading = true
		self._get_buff = arg_34_1

		var_0_1:set_strike_cur_page_index(self._now_page_num)
		var_0_1:set_strike_cur_map_total_money(self._cur_point_total_money)
		self:strike_set_active(false)

		local var_34_0 = {
			go_to_map_id = self.__now_page,
			fight_type = var_0_9.fight_type.strike,
			fight_prepare_type = var_0_9.fight_type.strike,
			init_map_index = self.__now_page - self._active_config.pve_id * 100,
			strike_is_deal = arg_34_1 or false,
			hard_open = self._cur_page_hard_open
		}

		var_0_1:set_save_weather(self._cur_page_weather)
		var_0_1:set_save_buff()
		var_0_1:set_strike_map_panel_buff()
		var_0_1:set_strike_flag(arg_34_1)
		var_0_1:set_strike_first_get_in(true)
		var_0_1:set_fight_info_for_strike(var_34_0)
		var_0_6:createInstance("fight_prepare"):show(var_34_0)
	end

	function arg_1_0:get_strike_whole_buff()
		return self._control.strike_whole_buff.gameObject.activeSelf
	end

	function arg_1_0:_play_audio(arg_36_1, arg_36_2)
		self:playBackgroundMusic(arg_36_1, arg_36_2)
	end

	function arg_1_0:_play_into_se(arg_37_1)
		self:playSE(arg_37_1, false)
	end

	function arg_1_0:__initial_func()
		if self._init_already then
			return
		end

		local var_38_0 = {
			{
				nodetext = "ui_4th_shop",
				node = self._control.main.bottom.point_bg.title_text
			},
			{
				nodetext = "ui_4th_shop",
				node = self._control.strike_guide.main.guidetitle_text
			},
			{
				nodetext = "ui_4th_shop",
				node = self._control.strike_detail.main.tip.text
			}
		}
		local var_38_1 = {
			{
				state = false,
				node = self._control.main.middle.reward_event
			},
			{
				state = false,
				node = self._control.main.middle.page_main.last_btn
			},
			{
				state = false,
				node = self._control.main.middle.page_main.next_btn
			},
			{
				state = false,
				node = self._control.main.middle.page_main.mode_img
			},
			{
				state = false,
				node = self._control.strike_guide
			},
			{
				state = false,
				node = self._control.strike_detail
			}
		}
		local var_38_2 = {
			init_language = function(self, arg_39_1)
				self.text.text = var_0_5:getNowLang(arg_39_1)
			end,
			init_active = function(self, arg_40_1)
				self.gameObject:SetActive(arg_40_1)
			end
		}

		for iter_38_0 = 1, #var_38_0 do
			var_38_2.init_language(var_38_0[iter_38_0].node, var_38_0[iter_38_0].nodetext)
		end

		for iter_38_1 = 1, #var_38_1 do
			var_38_2.init_active(var_38_1[iter_38_1].node, var_38_1[iter_38_1].state)
		end
	end

	function arg_1_0.__onReset(arg_41_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_42_0)
	local var_42_0 = var_0_6:class("strike_main")

	var_42_0._user_score = nil
	var_42_0._normal_data = {}
	var_42_0._hard_data = {}
	var_42_0.page_list = {}
	var_42_0.__data_list = {}
	var_42_0.__now_content = nil
	var_42_0.__now_data = nil
	var_42_0.__five_state = false
	var_42_0.__six_state = false
	var_42_0.__init_buff_id = nil
	var_42_0._get_buff = false
	var_42_0.buff_btn_state = true

	gamecore.extend_obj(var_42_0)

	return var_42_0
end

return var_0_0
