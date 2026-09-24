local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.user
local var_0_3 = gamecore.Language
local var_0_4 = gameenum.common_type
local var_0_6 = gameconfig.ship_research_config
local var_0_7 = gamecore.util_func
local var_0_8 = table.insert
local var_0_9 = string.format
local var_0_10 = gameconfig.research_equip_config
local var_0_11 = gamecore.PreloadManager
local var_0_12 = gamecore.prompt
local var_0_13 = UnityEngine.Vector2

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onScaleButtonClick_research_bureau_bg_top_return_btn()
		var_0_2:set_come_in(true)
		var_0_1:destroyInstance("research_development")
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))

		local var_2_0 = var_0_1:getInstance("research_bureau")

		if var_2_0 then
			var_2_0:show()
		else
			var_0_1:createInstance("research_bureau"):show()
		end
	end

	function arg_1_0.__onClick_research_bureau_bg_right_equip_show_equip_bg_equip_finish_get_btn(arg_3_0)
		return
	end

	function arg_1_0:__onClick_research_bureau_bg_right_ship_show_ship_research_1_select_btn_1()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
		self._control.research_bureau_bg.right.ship_show.ship_research:SetActive(true)
		self:update_set_research_ship_task_info(self._now_ship_info[1].id)
		self:_update_now_stage_info()
		self.__ship_task_list[1]:SetActive(false)
		self.__ship_task_list[2]:SetActive(true)
		self.__ship_task_list[3]:SetActive(true)

		self.__ship_task_list[2].gameObject.rectTransform.anchoredPosition = var_0_13(self.research_stage_1_x, self.research_stage_1_y - 498)
		self.__ship_task_list[3].gameObject.rectTransform.anchoredPosition = var_0_13(self.research_stage_1_x, self.research_stage_1_y - 65 - 498)
		self.__ship_task_list[4].gameObject.rectTransform.anchoredPosition = var_0_13(self.research_stage_1_x, self.research_stage_1_y - 130 - 498)
		self._control.research_bureau_bg.right.ship_show.ship_research.rectTransform.anchoredPosition = var_0_13(-8.5, self.research_stage_1_y - 215)
	end

	function arg_1_0:__onClick_research_bureau_bg_right_ship_show_ship_research_2_select_btn_2()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
		self._control.research_bureau_bg.right.ship_show.ship_research:SetActive(true)
		self:update_set_research_ship_task_info(self._now_ship_info[2].id)
		self:_update_now_stage_info()
		self.__ship_task_list[1]:SetActive(true)
		self.__ship_task_list[2]:SetActive(false)
		self.__ship_task_list[3]:SetActive(true)

		self.__ship_task_list[1].gameObject.rectTransform.anchoredPosition = var_0_13(self.research_stage_1_x, self.research_stage_1_y + 10)
		self._control.research_bureau_bg.right.ship_show.ship_research.rectTransform.anchoredPosition = var_0_13(-8.5, self.research_stage_1_y - 270)
		self.__ship_task_list[3].gameObject.rectTransform.anchoredPosition = var_0_13(self.research_stage_1_x, self.research_stage_1_y - 65 - 485)
		self.__ship_task_list[4].gameObject.rectTransform.anchoredPosition = var_0_13(self.research_stage_1_x, self.research_stage_1_y - 130 - 485)
	end

	function arg_1_0:__onClick_research_bureau_bg_right_ship_show_ship_research_3_select_btn_3()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
		self.__ship_task_list[1]:SetActive(true)
		self.__ship_task_list[2]:SetActive(true)
		self.__ship_task_list[3]:SetActive(false)
		self._control.research_bureau_bg.right.ship_show.ship_research:SetActive(true)
		self:update_set_research_ship_task_info(self._now_ship_info[3].id)
		self:_update_now_stage_info()

		self.__ship_task_list[1].gameObject.rectTransform.anchoredPosition = var_0_13(self.research_stage_1_x, self.research_stage_1_y + 20)
		self.__ship_task_list[2].gameObject.rectTransform.anchoredPosition = var_0_13(self.research_stage_1_x, self.research_stage_1_y + 20 - 65)
		self._control.research_bureau_bg.right.ship_show.ship_research.rectTransform.anchoredPosition = var_0_13(-8.5, self.research_stage_1_y - 65 - 263)
		self.__ship_task_list[4].gameObject.rectTransform.anchoredPosition = var_0_13(self.research_stage_1_x, self.research_stage_1_y - 195 - 415)
	end

	function arg_1_0:__onClick_research_bureau_bg_right_ship_show_ship_research_4_select_btn_4()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
		self._control.research_bureau_bg.right.ship_show.ship_research:SetActive(true)
		self:update_set_research_ship_task_info(self._now_ship_info[4].id)
		self:_update_now_stage_info()
		self.__ship_task_list[1]:SetActive(true)
		self.__ship_task_list[2]:SetActive(true)
		self.__ship_task_list[3]:SetActive(true)
		self.__ship_task_list[4]:SetActive(false)

		self.__ship_task_list[2].gameObject.rectTransform.anchoredPosition = var_0_13(self.research_stage_1_x, self.research_stage_1_y - 65)
		self.__ship_task_list[3].gameObject.rectTransform.anchoredPosition = var_0_13(self.research_stage_1_x, self.research_stage_1_y - 130)
		self.__ship_task_list[4].gameObject.rectTransform.anchoredPosition = var_0_13(self.research_stage_1_x, self.research_stage_1_y - 195)
		self._control.research_bureau_bg.right.ship_show.ship_research.rectTransform.anchoredPosition = var_0_13(-8.5, self.research_stage_1_y - 195 - 215)
	end

	function arg_1_0:__onClick_research_bureau_bg_left_ship_research_aquip_bg_1_select_btn_1()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))

		self.equip_stage = 1

		for iter_8_0 = 1, 4 do
			if iter_8_0 == 1 then
				self.__aquip_choose_list[iter_8_0].gameObject:SetActive(true)
			else
				self.__aquip_choose_list[iter_8_0].gameObject:SetActive(false)
			end
		end

		self:update_equip_task_info((var_0_10.find_object_by_id(var_0_6.find_object_by_id(self._now_ship_id).equipment[1])))

		self._control.research_bureau_bg.state.state_image_2.image.sprite = self:loadSprite(var_0_4.research_stage.stage_1)
		self._click_stage = 2
	end

	function arg_1_0:__onClick_research_bureau_bg_left_ship_research_aquip_bg_2_select_btn_2()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))

		local var_9_0 = var_0_6.find_object_by_id(self._now_ship_id)
		local var_9_1 = var_0_10.find_object_by_id(var_9_0.equipment[2])
		local var_9_2 = false

		if var_9_1.condition.stage == var_9_0.stage then
			for iter_9_0, iter_9_1 in pairs((var_0_2:get_ship_task_info())) do
				if iter_9_1.id == self._now_ship_id and iter_9_1.status == 0 then
					var_9_2 = true
				end
			end
		end

		if var_9_1.condition.stage <= var_9_0.stage and (var_9_1.condition.stage <= var_9_0.stage or var_9_0.status == 1) then
			if var_9_2 then
				var_0_12:show(var_0_9(var_0_3:getNowLang("research_equipment_not_open"), self.__ship_research_title[var_9_1.condition.stage].text.text))

				return
			end
		end

		self.equip_stage = 2

		for iter_9_2 = 1, 4 do
			if iter_9_2 == 2 then
				self.__aquip_choose_list[iter_9_2].gameObject:SetActive(true)
			else
				self.__aquip_choose_list[iter_9_2].gameObject:SetActive(false)
			end
		end

		self:update_equip_task_info(var_9_1)

		self._control.research_bureau_bg.state.state_image_2.image.sprite = self:loadSprite(var_0_4.research_stage.stage_1)
		self._click_stage = 2
	end

	function arg_1_0:__onClick_research_bureau_bg_left_ship_research_aquip_bg_3_select_btn_3()
		local var_10_0 = self:get_ship_research_max_info(self._now_ship_id)

		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))

		local var_10_1 = var_0_6.find_object_by_id(var_10_0)
		local var_10_2 = var_0_10.find_object_by_id(var_10_1.equipment[3])
		local var_10_3 = false

		if var_10_2.condition.stage == var_10_1.stage then
			for iter_10_0, iter_10_1 in pairs((var_0_2:get_ship_task_info())) do
				if iter_10_1.id == var_10_0 and iter_10_1.status == 0 then
					var_10_3 = true
				end
			end
		end

		if var_10_2.condition.stage <= var_10_1.stage and (var_10_2.condition.stage <= var_10_1.stage or var_10_1.status == 1) then
			if var_10_3 then
				var_0_12:show(var_0_9(var_0_3:getNowLang("research_equipment_not_open"), self.__ship_research_title[var_10_2.condition.stage].text.text))

				return
			end
		end

		self.equip_stage = 3

		for iter_10_2 = 1, 4 do
			if iter_10_2 == 3 then
				self.__aquip_choose_list[iter_10_2].gameObject:SetActive(true)
			else
				self.__aquip_choose_list[iter_10_2].gameObject:SetActive(false)
			end
		end

		self:update_equip_task_info(var_10_2)

		self._control.research_bureau_bg.state.state_image_2.image.sprite = self:loadSprite(var_0_4.research_stage.stage_1)
		self._click_stage = 2
	end

	function arg_1_0:__onClick_research_bureau_bg_left_ship_research_aquip_bg_4_select_btn_4()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))

		local var_11_0 = self:get_ship_research_max_info(self._now_ship_id)
		local var_11_1 = var_0_6.find_object_by_id(var_11_0)
		local var_11_2 = var_0_10.find_object_by_id(var_11_1.equipment[4])
		local var_11_3 = false

		if var_11_2.condition.stage == var_11_1.stage then
			for iter_11_0, iter_11_1 in pairs((var_0_2:get_ship_task_info())) do
				if iter_11_1.id == var_11_0 and iter_11_1.status == 0 then
					var_11_3 = true
				end
			end
		end

		if var_11_2.condition.stage <= var_11_1.stage and (var_11_2.condition.stage <= var_11_1.stage or var_11_1.status == 1) then
			if var_11_3 then
				var_0_12:show(var_0_9(var_0_3:getNowLang("research_equipment_not_open"), self.__ship_research_title[var_11_2.condition.stage].text.text))

				return
			end
		end

		self.equip_stage = 4

		for iter_11_2 = 1, 4 do
			if iter_11_2 == 4 then
				self.__aquip_choose_list[iter_11_2].gameObject:SetActive(true)
			else
				self.__aquip_choose_list[iter_11_2].gameObject:SetActive(false)
			end
		end

		self:update_equip_task_info(var_11_2)

		self._control.research_bureau_bg.state.state_image_2.image.sprite = self:loadSprite(var_0_4.research_stage.stage_1)
		self._click_stage = 2
	end

	function arg_1_0:__onClick_research_bureau_bg_right_ship_show_ship_research_ship_task_ship_task_1_ship_start_btn_1()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))

		self.start_type = 1

		var_0_2:set_research_ship_id(1)

		for iter_12_0, iter_12_1 in pairs((var_0_2:get_ship_task_info())) do
			if iter_12_1.id == self._now_ship_id then
				var_0_2:set_research_ship_select_ship_num(iter_12_1.task_num_1)
			end
		end

		self:to_ship_task_panel(self._research_ship_info.task1, self._research_ship_info.task1_desc)
	end

	function arg_1_0:__onClick_research_bureau_bg_right_ship_show_ship_research_ship_task_ship_task_2_ship_start_btn_2()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))

		self._is_open_select_member = true

		var_0_2:set_research_ship_id(2)

		self.start_type = 2

		for iter_13_0, iter_13_1 in pairs((var_0_2:get_ship_task_info())) do
			if iter_13_1.id == self._now_ship_id then
				var_0_2:set_research_ship_select_ship_num(iter_13_1.task_num_2)
			end
		end

		self:to_ship_task_panel(self._research_ship_info.task2, self._research_ship_info.task2_desc)
	end

	function arg_1_0:__onClick_research_bureau_bg_right_ship_show_ship_research_ship_task_ship_task_3_ship_start_btn_3()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))

		self.start_type = 3

		var_0_2:set_research_ship_id(3)

		for iter_14_0, iter_14_1 in pairs((var_0_2:get_ship_task_info())) do
			if iter_14_1.id == self._now_ship_id then
				var_0_2:set_research_ship_select_ship_num(iter_14_1.task_num_3)
			end
		end

		self:to_ship_task_panel(self._research_ship_info.task3, self._research_ship_info.task3_desc)
	end

	function arg_1_0:set_score_btn_state()
		self._control.submit_core_bg:SetActive(true)

		if self._sum_score_num == 0 then
			self._control.submit_core_bg.start_btn.image.sprite = self:loadSprite(var_0_4.ship_detail_switch.close)
			self._control.submit_core_bg.start_btn:GetComponent("Button").interactable = false
		else
			self._control.submit_core_bg.start_btn.image.sprite = self:loadSprite(var_0_4.ship_detail_switch.open)
			self._control.submit_core_bg.start_btn:GetComponent("Button").interactable = true
		end
	end

	function arg_1_0:set_equip_drawing_btn_state()
		self._control.submit_core_bg:SetActive(true)

		if self._sum_equip_drawing_num == 0 then
			self._control.submit_core_bg.start_btn.image.sprite = self:loadSprite(var_0_4.ship_detail_switch.close)
			self._control.submit_core_bg.start_btn:GetComponent("Button").interactable = false
		else
			self._control.submit_core_bg.start_btn.image.sprite = self:loadSprite(var_0_4.ship_detail_switch.open)
			self._control.submit_core_bg.start_btn:GetComponent("Button").interactable = true
		end
	end

	function arg_1_0:set_blueprint_btn_state()
		if self._sum_blueprint_num == 0 then
			self._control.submit_core_bg.start_btn.image.sprite = self:loadSprite(var_0_4.ship_detail_switch.close)
			self._control.submit_core_bg.start_btn:GetComponent("Button").interactable = false
		else
			self._control.submit_core_bg.start_btn.image.sprite = self:loadSprite(var_0_4.ship_detail_switch.open)
			self._control.submit_core_bg.start_btn:GetComponent("Button").interactable = true
		end
	end

	function arg_1_0:set_ship_build_btn_state()
		self._control.submit_core_bg:SetActive(true)

		if self._sum_ship_build_num == 0 then
			self._control.submit_core_bg.start_btn.image.sprite = self:loadSprite(var_0_4.ship_detail_switch.close)
			self._control.submit_core_bg.start_btn:GetComponent("Button").interactable = false
		else
			self._control.submit_core_bg.start_btn.image.sprite = self:loadSprite(var_0_4.ship_detail_switch.open)
			self._control.submit_core_bg.start_btn:GetComponent("Button").interactable = true
		end
	end

	function arg_1_0:set_item_btn_state()
		self._control.submit_core_bg:SetActive(true)

		if self._sum_item_num == 0 then
			self._control.submit_core_bg.start_btn.image.sprite = self:loadSprite(var_0_4.ship_detail_switch.close)
			self._control.submit_core_bg.start_btn:GetComponent("Button").interactable = false
		else
			self._control.submit_core_bg.start_btn.image.sprite = self:loadSprite(var_0_4.ship_detail_switch.open)
			self._control.submit_core_bg.start_btn:GetComponent("Button").interactable = true
		end
	end

	function arg_1_0:to_ship_task_panel(arg_20_1, arg_20_2)
		local function var_20_0()
			self._control.detail_shadow.gameObject:SetActive(false)

			self._is_open_select_member = false
		end

		if arg_20_1.type == 1 then
			self._type_layer = 1

			self:set_score_btn_state()
			self:update_core_task_info(arg_20_1, arg_20_2)
			self:__update_reusable_cell(1, arg_20_1, arg_20_1.type)
		elseif arg_20_1.type == 2 then
			self._control.submit_core_bg:SetActive(true)

			self._type_layer = 2

			self:set_blueprint_btn_state()
			self:update_blueprint_task_info(arg_20_1, arg_20_2)
			self:__update_reusable_cell(2, arg_20_1, arg_20_1.type)
		elseif arg_20_1.type == 3 then
			var_0_2:set_need_research_ship_task_info(arg_20_1)

			self._is_open_select_member = true

			self._control.detail_shadow.gameObject:SetActive(true)

			local var_20_1 = var_0_1:getInstance("select_member")

			if var_20_1 then
				var_20_1:show_by_type(var_0_4.enter_select_member_type.research_ship, nil, nil, nil, nil, nil, var_20_0)
				var_20_1:update_research_info()
			else
				local var_20_2 = var_0_1:createInstance("select_member")

				var_20_2:show_by_type(var_0_4.enter_select_member_type.research_ship, nil, nil, nil, nil, nil, var_20_0)
				var_20_2:update_research_info()
			end
		elseif arg_20_1.type == 4 then
			var_0_2:set_need_research_ship_task_info(arg_20_1)

			self._is_open_select_member = true

			self._control.detail_shadow.gameObject:SetActive(true)

			local var_20_3 = var_0_1:getInstance("select_member")

			if var_20_3 then
				var_20_3:show_by_type(var_0_4.enter_select_member_type.research_ship, nil, nil, nil, nil, nil, var_20_0)
			else
				var_0_1:createInstance("select_member"):show_by_type(var_0_4.enter_select_member_type.research_ship, nil, nil, nil, nil, nil, var_20_0)
			end
		elseif arg_20_1.type == 5 then
			local var_20_4 = var_0_1:createInstance("gotofight")
			local var_20_5 = {
				is_open_init = true
			}
			local var_20_6 = var_20_4:get_map_data()
			local var_20_7 = 0
			local var_20_8 = 0

			for iter_20_0, iter_20_1 in pairs(var_20_6) do
				for iter_20_2, iter_20_3 in pairs(iter_20_1) do
					var_20_8 = var_20_8 + 1
				end
			end

			local function var_20_9()
				var_20_7 = var_20_7 + 1

				if var_20_7 == var_20_8 then
					var_20_4:show(var_20_5, nil, function()
						self:setVisible(false)
					end)
				end
			end

			for iter_20_4, iter_20_5 in pairs(var_20_6) do
				for iter_20_6, iter_20_7 in pairs(iter_20_5) do
					var_0_11:preload_gotofight_map_asset(iter_20_7, var_20_9)
				end
			end
		elseif arg_20_1.type == 6 then
			self._type_layer = 6

			self:set_item_btn_state()

			if arg_20_1.item_id and type(arg_20_1.item_id) == "number" then
				self:_update_item_task_info(arg_20_1, arg_20_2)
				self:__update_item_cell(arg_20_1)
			end
		end
	end

	function arg_1_0:__onClick_submit_core_bg_submit_core_bg_1_right_colse_btn()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
		self:__initia_lize()
		self._control.submit_core_bg:SetActive(false)
	end

	function arg_1_0:__onClick_submit_core_bg_submit_core_bg_1_start_btn()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))

		self._sum_blueprint_info = {}

		if self._type_layer == 1 then
			local var_25_0 = {}

			for iter_25_0, iter_25_1 in pairs(self._sum_score_info) do
				if iter_25_1.num ~= 0 then
					var_0_8(var_25_0, iter_25_1)
				end
			end

			self._sum_score_info = var_25_0

			if self._click_stage == 1 then
				var_0_2:req_ResearchTaskSubmitReq(self._now_ship_id, var_0_2:get_research_ship_id(), self._sum_score_info)
			elseif self._click_stage == 2 then
				var_0_2:req_ResearchEquipSubmitReq(self._now_equip_id, var_0_2:get_research_equip_stage(), self._sum_score_info)
			end
		elseif self._type_layer == 2 then
			if self.blueprint_1 > 0 then
				var_0_8(self._sum_blueprint_info, {
					cid = 20141,
					num = self.blueprint_1
				})
			end

			if self.blueprint_2 > 0 then
				var_0_8(self._sum_blueprint_info, {
					cid = 20241,
					num = self.blueprint_2
				})
			end

			if self.blueprint_3 > 0 then
				var_0_8(self._sum_blueprint_info, {
					cid = 20341,
					num = self.blueprint_3
				})
			end

			local var_25_1 = var_0_2:get_research_ship_id()
			local var_25_2 = {}

			for iter_25_2, iter_25_3 in pairs(self._sum_blueprint_info) do
				if iter_25_3.num ~= 0 then
					var_0_8(var_25_2, iter_25_3)
				end
			end

			self._sum_blueprint_info = var_25_2

			if self._click_stage == 1 then
				var_0_2:req_ResearchTaskSubmitReq(self._now_ship_id, var_25_1, self._sum_blueprint_info)
			elseif self._click_stage == 2 then
				var_0_2:req_ResearchEquipSubmitReq(self._now_equip_id, var_0_2:get_research_equip_stage(), self._sum_blueprint_info)
			end
		elseif self._type_layer == 3 then
			if self.blueprint_1 and self.blueprint_1 > 0 then
				var_0_8(self._sum_blueprint_info, {
					cid = 20141,
					num = self.blueprint_1
				})
			end

			if self.blueprint_2 and self.blueprint_2 > 0 then
				var_0_8(self._sum_blueprint_info, {
					cid = 20241,
					num = self.blueprint_2
				})
			end

			if self.blueprint_3 and self.blueprint_3 > 0 then
				var_0_8(self._sum_blueprint_info, {
					cid = 20341,
					num = self.blueprint_3
				})
			end

			if self.score_1 and self.score_1 > 0 then
				var_0_8(self._sum_blueprint_info, {
					cid = 10141,
					num = self.score_1
				})
			end

			if self.score_2 and self.score_2 > 0 then
				var_0_8(self._sum_blueprint_info, {
					cid = 10241,
					num = self.score_2
				})
			end

			if self.score_3 and self.score_3 > 0 then
				var_0_8(self._sum_blueprint_info, {
					cid = 10341,
					num = self.score_3
				})
			end

			if self.score_4 and self.score_4 > 0 then
				var_0_8(self._sum_blueprint_info, {
					cid = 10441,
					num = self.score_4
				})
			end

			if self.score_5 and self.score_5 > 0 then
				var_0_8(self._sum_blueprint_info, {
					cid = 10541,
					num = self.score_5
				})
			end

			local var_25_3 = var_0_2:get_research_equip_stage()
			local var_25_4 = {}

			for iter_25_4, iter_25_5 in pairs(self._sum_blueprint_info) do
				if iter_25_5.num ~= 0 then
					var_0_8(var_25_4, iter_25_5)
				end
			end

			self._sum_blueprint_info = var_25_4

			if self._click_stage == 1 then
				var_0_2:req_ResearchTaskSubmitReq(self._now_ship_id, var_0_2:get_research_ship_id(), self._sum_blueprint_info)
			elseif self._click_stage == 2 then
				var_0_2:req_ResearchEquipSubmitReq(self._now_equip_id, var_25_3, self._sum_blueprint_info)
			end
		elseif self._type_layer == 4 then
			local var_25_5 = {}

			for iter_25_6, iter_25_7 in pairs(self._sum_item_info) do
				if iter_25_7.num ~= 0 then
					var_0_8(var_25_5, iter_25_7)
				end
			end

			self._sum_blueprint_info = var_25_5

			if self._click_stage == 1 then
				var_0_2:req_ResearchTaskSubmitReq(self._now_ship_id, var_0_2:get_research_ship_id(), self._sum_item_info)
			elseif self._click_stage == 2 then
				var_0_2:req_ResearchEquipSubmitReq(self._now_equip_id, var_0_2:get_research_equip_stage(), self._sum_item_info)
			end
		elseif self._type_layer == 6 then
			local var_25_6 = {}

			for iter_25_8, iter_25_9 in pairs(self._sum_item_info) do
				if iter_25_9.num ~= 0 then
					var_0_8(var_25_6, iter_25_9)
				end
			end

			self._sum_blueprint_info = var_25_6

			if self._click_stage == 1 then
				var_0_2:req_ResearchTaskSubmitReq(self._now_ship_id, var_0_2:get_research_ship_id(), self._sum_item_info)
			elseif self._click_stage == 2 then
				var_0_2:req_ResearchEquipSubmitReq(self._now_equip_id, var_0_2:get_research_equip_stage(), self._sum_item_info)
			end
		end
	end

	function arg_1_0:__onClick_research_bureau_bg_right_ship_show_ship_research_ship_finish_ship_get_btn()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))

		local var_26_0 = var_0_7.dict_lenght(var_0_2:get_character_list())
		local var_26_1 = var_0_2:get_use_info_data()

		if var_26_0 and var_26_0 < var_26_1.max_ship then
			var_0_2:req_GetResearchShipRewardReq(var_0_6.find_object_by_id(self._now_ship_id).ship_id)
		elseif var_26_0 >= var_26_1.max_ship then
			var_0_12:show(var_0_3:getNowLang("errorcode_187"))

			return
		end
	end

	function arg_1_0:__onClick_research_bureau_bg_right_equip_show_equip_bg_equip_1_start_btn_1()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))

		local var_27_0 = var_0_6.find_object_by_id(self._now_ship_id)
		local var_27_2

		var_0_2:set_research_equip_stage(1)

		if self.equip_stage == 1 then
			var_27_2 = var_0_10.find_object_by_id(var_27_0.equipment[1])

			var_0_2:set_research_equip_id(var_27_2.id)
		elseif self.equip_stage == 2 then
			var_27_2 = var_0_10.find_object_by_id(var_27_0.equipment[2])

			var_0_2:set_research_equip_id(var_27_2.id)
		elseif self.equip_stage == 3 then
			var_27_2 = var_0_10.find_object_by_id(var_27_0.equipment[3])

			var_0_2:set_research_equip_id(var_27_2.id)
		elseif self.equip_stage == 4 then
			var_27_2 = var_0_10.find_object_by_id(var_27_0.equipment[4])

			var_0_2:set_research_equip_id(var_27_2.id)
		end

		self:to_equip_task_panel(var_27_2.task1, var_27_2.task1_desc, 1)
	end

	function arg_1_0:__onClick_research_bureau_bg_right_equip_show_equip_bg_equip_2_start_btn_2()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))

		local var_28_0 = var_0_6.find_object_by_id(self._now_ship_id)
		local var_28_2

		var_0_2:set_research_equip_stage(2)

		if self.equip_stage == 1 then
			var_28_2 = var_0_10.find_object_by_id(var_28_0.equipment[1])

			var_0_2:set_research_equip_id(var_28_2.id)
		elseif self.equip_stage == 2 then
			var_28_2 = var_0_10.find_object_by_id(var_28_0.equipment[2])

			var_0_2:set_research_equip_id(var_28_2.id)
		elseif self.equip_stage == 3 then
			var_28_2 = var_0_10.find_object_by_id(var_28_0.equipment[3])

			var_0_2:set_research_equip_id(var_28_2.id)
		elseif self.equip_stage == 4 then
			var_28_2 = var_0_10.find_object_by_id(var_28_0.equipment[4])

			var_0_2:set_research_equip_id(var_28_2.id)
		end

		self:to_equip_task_panel(var_28_2.task2, var_28_2.task2_desc, 2)
	end

	function arg_1_0:__onClick_research_bureau_bg_right_equip_show_equip_bg_equip_3_start_btn_3()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))

		local var_29_0 = var_0_6.find_object_by_id(self._now_ship_id)
		local var_29_2

		var_0_2:set_research_equip_stage(3)

		if self.equip_stage == 1 then
			var_29_2 = var_0_10.find_object_by_id(var_29_0.equipment[1])

			var_0_2:set_research_equip_id(var_29_2.id)
		elseif self.equip_stage == 2 then
			var_29_2 = var_0_10.find_object_by_id(var_29_0.equipment[2])

			var_0_2:set_research_equip_id(var_29_2.id)
		elseif self.equip_stage == 3 then
			var_29_2 = var_0_10.find_object_by_id(var_29_0.equipment[3])

			var_0_2:set_research_equip_id(var_29_2.id)
		elseif self.equip_stage == 4 then
			var_29_2 = var_0_10.find_object_by_id(var_29_0.equipment[4])

			var_0_2:set_research_equip_id(var_29_2.id)
		end

		self:to_equip_task_panel(var_29_2.task3, var_29_2.task3_desc, 3)
	end

	function arg_1_0:to_equip_task_panel(arg_30_1, arg_30_2, arg_30_3)
		if arg_30_1.type == 1 then
			local var_30_0 = var_0_1:createInstance("research_ship_equip")

			if var_30_0 then
				var_30_0:show(arg_30_1, arg_30_3)
			end
		elseif arg_30_1.type == 2 then
			local var_30_1 = var_0_1:createInstance("research_ship_equip")

			if var_30_1 then
				var_30_1:show(arg_30_1, arg_30_3)
			end
		elseif arg_30_1.type == 3 then
			local var_30_2 = var_0_1:createInstance("gotofight")
			local var_30_3 = {
				is_open_init = true
			}
			local var_30_4 = var_30_2:get_map_data()
			local var_30_5 = 0
			local var_30_6 = 0

			for iter_30_0, iter_30_1 in pairs(var_30_4) do
				for iter_30_2, iter_30_3 in pairs(iter_30_1) do
					var_30_6 = var_30_6 + 1
				end
			end

			local function var_30_7()
				var_30_5 = var_30_5 + 1

				if var_30_5 == var_30_6 then
					var_30_2:show(var_30_3, nil, function()
						self:setVisible(false)
					end)
				end
			end

			for iter_30_4, iter_30_5 in pairs(var_30_4) do
				for iter_30_6, iter_30_7 in pairs(iter_30_5) do
					var_0_11:preload_gotofight_map_asset(iter_30_7, var_30_7)
				end
			end
		elseif arg_30_1.type == 4 and var_0_7.have_index(arg_30_1, "item_id") then
			self._type_layer = 4

			self:set_item_btn_state()

			if arg_30_1.item_id and type(arg_30_1.item_id) == "number" then
				self:__update_item_cell(arg_30_1)
				self:_update_item_task_info(arg_30_1, arg_30_2)
			end
		end
	end

	function arg_1_0:__onClick_research_bureau_bg_right_equip_show_equip_bg_equip_finish_equip_get_btn()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))

		if self._equip_task_id > 10 then
			var_0_2:req_GetResearchEquipRewardReq(self._equip_task_id)
		end
	end

	function arg_1_0:__onClick_research_bureau_bg_state_state_select_btn()
		if self._click_stage == 1 then
			return
		end

		self._control.research_bureau_bg.state.state_image_2.image.sprite = self:loadSprite(var_0_4.research_stage.stage_2)
		self._click_stage = 1

		self._control.research_bureau_bg.right.ship_show:SetActive(true)
		self._control.research_bureau_bg.right.equip_show:SetActive(false)

		for iter_34_0, iter_34_1 in pairs(self.__aquip_choose_list) do
			iter_34_1:SetActive(false)
		end

		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
	end

	function arg_1_0.__onClick_research_bureau_bg_right_ship_show_ship_research_select_research_ship_task_btn(arg_35_0)
		return
	end

	function arg_1_0:close_all_ship_task_info(arg_36_1)
		self._control.research_bureau_bg.right.ship_show.ship_research:SetActive(false)
	end

	function arg_1_0.get_ship_research_max_info(arg_37_0, arg_37_1)
		local var_37_0 = arg_37_1 and arg_37_1 or var_0_2:get_now_research_ship_id()
		local var_37_1 = {}
		local var_37_2 = var_0_6.find_object_by_id(var_37_0)
		local var_37_3 = var_0_2:get_ship_task_info()

		if var_37_3 and next(var_37_3) then
			for iter_37_0, iter_37_1 in ipairs(var_37_3) do
				if var_37_2.num == var_0_6.find_object_by_id(iter_37_1.id).num then
					var_0_8(var_37_1, iter_37_1)
				end
			end
		end

		if var_37_1 and next(var_37_1) then
			for iter_37_2, iter_37_3 in pairs(var_37_1) do
				if iter_37_2 == 3 and iter_37_3.status == 1 then
					return iter_37_3.id
				end
			end

			for iter_37_4, iter_37_5 in pairs(var_37_1) do
				if iter_37_4 == 2 and iter_37_5.status == 1 then
					return iter_37_5.id
				end
			end

			for iter_37_6, iter_37_7 in pairs(var_37_1) do
				if iter_37_6 == 1 and iter_37_7.status == 1 then
					return iter_37_7.id
				end
			end
		end

		return var_37_0
	end

	function arg_1_0:research_ship_is_finish(arg_38_1)
		local var_38_1 = arg_38_1 and arg_38_1 or self:get_now_research_ship_id()
	end

	function arg_1_0:__onLongClick_research_bureau_bg_left_ship_research_aquip_bg_1_select_btn_1()
		self:__click_show_equip_att(1)
	end

	function arg_1_0:__onLongClick_research_bureau_bg_left_ship_research_aquip_bg_2_select_btn_2()
		self:__click_show_equip_att(2)
	end

	function arg_1_0:__onLongClick_research_bureau_bg_left_ship_research_aquip_bg_3_select_btn_3()
		self:__click_show_equip_att(3)
	end

	function arg_1_0:__onLongClick_research_bureau_bg_left_ship_research_aquip_bg_4_select_btn_4()
		self:__click_show_equip_att(4)
	end

	function arg_1_0:__click_show_equip_att(arg_43_1)
		local var_43_0 = var_0_6.find_object_by_id(self._now_ship_id).equipment[arg_43_1]
		local var_43_1 = var_0_10.find_object_by_id(var_43_0)

		self:__show_equip_att(var_43_0)
	end

	function arg_1_0:__onClick_detail_shadow()
		if self._is_open_select_member then
			return
		end

		self._control.detail_shadow.gameObject:SetActive(false)

		if self._equip_attr then
			self._equip_attr:setVisible(false)
		end
	end

	function arg_1_0.__onPointerUp_research_bureau_bg_left_ship_research_aquip_bg_1_select_btn_1(arg_45_0)
		return
	end

	function arg_1_0.__onPointerUp_research_bureau_bg_left_ship_research_aquip_bg_2_select_btn_2(arg_46_0)
		return
	end

	function arg_1_0.__onPointerUp_research_bureau_bg_left_ship_research_aquip_bg_3_select_btn_3(arg_47_0)
		return
	end

	function arg_1_0.__onPointerUp_research_bureau_bg_left_ship_research_aquip_bg_4_select_btn_4(arg_48_0)
		return
	end
end

function var_0_0.extend_obj(arg_49_0)
	return
end

return var_0_0
