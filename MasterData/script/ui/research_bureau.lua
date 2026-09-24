local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.user
local var_0_3 = gamecore.Language
local var_0_4 = gameenum.common_type
local var_0_5 = gameconfig.ship_config
local var_0_8 = DG.Tweening.DOTween
local var_0_9 = gameconfig.ship_research_config
local var_0_10 = gamecore.util_func
local var_0_11 = table.insert
local var_0_12 = lx.UserData
local var_0_14 = {
	"E",
	"D",
	"C",
	"B",
	"A",
	"S",
	"SS"
}

gamecore.UILoader:define("research_bureau", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end

		if self._set_down_btn then
			self:_set_left_ship_down_pos()
		end

		if self._set_up_btn then
			self:_set_left_ship_up_pos()
		end
	end

	function arg_1_0:show()
		self:setVisible(true)
		self:__update_edge_mask()
		self:_init_language()
		self:__init_panel()
	end

	function arg_1_0:__init_panel()
		self:_init_ship_list()
		self:__update_reusable_cell()

		local var_4_0 = self:autoKillDOTween(var_0_8.Sequence())

		var_4_0:AppendInterval(0.025)
		var_4_0:AppendCallback(function()
			self:__init_data()
			self:__set_btn_state(self._ship_all_info[1])
		end)
		var_4_0:Play()

		self._is_already_init = true
	end

	function arg_1_0:_init_language()
		self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.research))

		self._control.top.title_txt.text.text = var_0_3:getNowLang("research_name")
		self._control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_1.type_txt_1.text.text = var_0_3:getNowLang("cardattribute1")
		self._control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_2.type_txt_2.text.text = var_0_3:getNowLang("cardattribute2")
		self._control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_3.type_txt_3.text.text = var_0_3:getNowLang("cardattribute3")
		self._control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_4.type_txt_4.text.text = var_0_3:getNowLang("cardattribute5")
		self._control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_5.type_txt_5.text.text = var_0_3:getNowLang("cardattribute6")
		self._control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_6.type_txt_6.text.text = var_0_4.ship_map_special_attr_str
		self._control.research_bureau_bg.right.ship_layer.intro_txt.text.text = var_0_3:getNowLang("shipdesctitle")

		self._control.research_bureau_bg.left.up_image:SetActive(false)
		self._control.research_bureau_bg.left.down_image:SetActive(true)
	end

	function arg_1_0:_init_ship_list()
		local var_7_0 = var_0_2:get_now_research_ship_id()
		local var_7_2 = var_0_2:get_account_id()

		if self:is_have_research_data() then
			local var_7_3 = var_0_12:getKeyData("first_research_ship_id")

			self.now_ship_info = var_7_3 and (string.sub(var_7_2, -5) == string.sub(var_7_3, -5) and not var_0_2:get_now_research_ship_id() and tonumber((string.sub(var_7_3, 1, 6))) or var_0_2:get_now_research_ship_id() and var_0_2:get_now_research_ship_id() or 100001) or var_0_2:get_now_research_ship_id() and var_0_2:get_now_research_ship_id() or 100001
		else
			local var_7_4 = var_0_12:getKeyData("first_research_ship_id")

			self.now_ship_info = var_7_4 and (string.sub(var_7_2, -5) == string.sub(var_7_4, -5) and tonumber((string.sub(var_7_4, 1, 6))) or var_0_2:get_now_research_ship_id() and var_0_2:get_now_research_ship_id() or 100001) or 100001
		end

		if not self._reusable_cell then
			self._reusable_cell = gamecore.reusable_cell:create(self, self._control.research_bureau_bg.left.left_scrollview.viewport.content.endlessScrollView, self._control.research_bureau_bg.left.left_scrollview.viewport.content, "research_development_item", "research_bureau", true)

			self._reusable_cell:init()
		end

		local var_7_6 = var_0_2:get_ship_task_info()

		if var_7_6 and next(var_7_6) then
			self.down_pos = (#var_7_6 / 3 - 4 + 1) * 136
		end
	end

	function arg_1_0.is_have_research_data(arg_8_0)
		local var_8_0 = var_0_2:get_ship_task_info()
		local var_8_1 = var_0_2:get_equip_task_info()

		if var_8_0 and next(var_8_0) then
			for iter_8_0, iter_8_1 in ipairs(var_8_0) do
				if iter_8_1.task_num_1 > 0 then
					return true
				end
			end
		end

		if var_8_1 and next(var_8_1) then
			for iter_8_2, iter_8_3 in ipairs(var_8_1) do
				if iter_8_3.task_num_1 > 0 then
					return true
				end
			end
		end
	end

	function arg_1_0:__set_first_come_in(arg_9_1)
		if self._come_in_state == 1 then
			if self._ship_all_info[1] and self._ship_all_info[1] ~= 10000113 then
				local var_9_0 = var_0_9.find_object_by_id(self._ship_all_info[1])

				self._now_click_icon = arg_9_1
			end
		end

		self._come_in_state = 2
	end

	function arg_1_0:__update_reusable_cell()
		self._ship_all_info = {}
		self._now_ship_all_info = {}
		self._ship_info = {}
		self._ship_all_info = self:get_research_ship_finish_info()

		if not var_0_10.have_data(self._ship_all_info, 10000113) then
			var_0_11(self._ship_all_info, 10000113)
		end

		local var_10_0 = var_0_2:get_now_research_ship_id()
		local var_10_1 = 1

		if var_10_0 and #self._ship_all_info > 2 then
			local var_10_3 = var_0_9.find_object_by_id(var_10_0)

			for iter_10_0, iter_10_1 in pairs(self._ship_all_info) do
				if var_10_3.ship_id == iter_10_1 then
					var_10_1 = iter_10_0
				end
			end
		end

		self._ship_all_info[1] = self._ship_all_info[var_10_1]
		self._ship_all_info[var_10_1] = self._ship_all_info[1]

		self._reusable_cell:set_data(self._ship_all_info)

		function self._reusable_cell:_set_func(arg_11_1)
			if self._ship_info and next(self._ship_info) then
				if not var_0_10.have_index(self._ship_info, self._ship_all_info[arg_11_1 + 1]) then
					self._ship_info[self._ship_all_info[arg_11_1 + 1]] = self
				end
			else
				self._ship_info[self._ship_all_info[arg_11_1 + 1]] = self
			end

			local var_11_0 = var_0_2:get_unlock_ship_info()
			local var_11_1 = var_0_2:get_ship_task_info()

			self:__set_first_come_in(self)
			self:__set_ship_list_info(self, self._ship_all_info[arg_11_1 + 1])

			if self._now_click_ship_id == 0 then
				self._now_click_ship_id = self._ship_all_info[1]
			end

			self:show(self._ship_all_info[arg_11_1 + 1], arg_11_1, self:__is_have_unget_equip_or_ship(self._ship_all_info[arg_11_1 + 1]), self._now_click_ship_id, self._ship_all_info, (self:set_all_ship_state(self, self._ship_all_info[arg_11_1 + 1])))
		end
	end

	function arg_1_0:__set_choose_bg_state(arg_12_1)
		if arg_12_1 == nil then
			return
		end

		for iter_12_0, iter_12_1 in pairs(self._ship_info) do
			if iter_12_0 == arg_12_1 and arg_12_1 == self._now_click_ship_id then
				self._ship_info[iter_12_0].item_bg.choose_bg:SetActive(true)
			else
				iter_12_1.item_bg.choose_bg:SetActive(false)
			end
		end
	end

	function arg_1_0:__init_data()
		if self._now_click_icon then
			local var_13_0 = self._ship_all_info[1]

			self:now_research_id(self._ship_all_info[1])
			self:__set_now_ship_info(self.now_ship_info, self._now_click_icon)

			local var_13_3 = var_0_2:get_now_research_ship_id() or self._ship_all_info[1]
			local var_13_4 = self:now_research_id(var_13_3)

			self.now_click_ship_info = var_13_4 and var_13_4 or var_13_3
			self._now_click_ship_id = var_13_0
		end
	end

	function arg_1_0.__is_have_research_data(arg_14_0, arg_14_1)
		local var_14_0 = false

		if var_0_9.find_object_by_id(arg_14_1.id).stage == 3 and arg_14_1.status == 1 then
			var_14_0 = true

			return true
		end

		return var_14_0
	end

	function arg_1_0.__is_can_receive_research_data(arg_15_0, arg_15_1)
		local var_15_0 = false
		local var_15_1 = var_0_9.find_object_by_id(arg_15_1.id)

		for iter_15_0, iter_15_1 in pairs((var_0_2:get_ship_task_info())) do
			if var_15_1.stage == 3 and arg_15_1.task_num_1 >= var_15_1.task1.num and arg_15_1.task_num_2 >= var_15_1.task2.num and arg_15_1.task_num_3 >= var_15_1.task3.num then
				var_15_0 = true

				return true
			end
		end

		return var_15_0
	end

	function arg_1_0:is_have_data_in_research(arg_16_1)
		for iter_16_0, iter_16_1 in pairs((var_0_2:get_ship_task_info())) do
			if iter_16_1.id == arg_16_1 then
				local var_16_0 = var_0_9.find_object_by_id(arg_16_1)

				if var_16_0.stage == 1 then
					if iter_16_1.task_num_1 > 0 or iter_16_1.task_num_2 > 0 or iter_16_1.task_num_3 > 0 then
						return true
					elseif self:__first_common_in_panel() then
						return true
					else
						return false
					end
				elseif var_16_0.stage >= 2 then
					return true
				end
			end
		end

		return false
	end

	function arg_1_0:now_research_id(arg_17_1)
		local var_17_0 = var_0_9.find_object_by_id(arg_17_1)
		local var_17_1 = {}

		for iter_17_0, iter_17_1 in pairs((var_0_2:get_ship_task_info())) do
			if var_17_0.num == var_0_9.find_object_by_id(iter_17_1.id).num then
				var_0_11(var_17_1, iter_17_1)
			end
		end

		local var_17_2 = self:now_ship_task_info(var_17_1)

		if var_17_2 then
			self.now_click_ship_info = var_17_2
		end
	end

	function arg_1_0:__set_ship_list_info(arg_18_1, arg_18_2)
		if arg_18_2 and arg_18_2 == 10000113 then
			self:__set_choose_bg_state()
		elseif arg_18_2 then
			-- block empty
		end
	end

	function arg_1_0:set_all_ship_state(arg_19_1, arg_19_2)
		if arg_19_2 == 10000113 then
			return
		end

		local var_19_0 = var_0_9.find_object_by_id(arg_19_2)
		local var_19_1 = var_0_9.find_object_by_id(self.now_click_ship_info)
		local var_19_2 = var_0_9.find_object_by_id(self.now_ship_info)
		local var_19_3 = ""

		if self.now_click_ship_info and var_19_1.ship_id ~= var_19_2.ship_id then
			self:__set_choose_bg_state()

			local var_19_4 = self:is_have_data_in_research(arg_19_2)

			var_19_3 = self:__is_finish_all_equip_and_finish_ship_task(arg_19_2) and (var_19_1.num == var_19_0.num and var_0_3:getNowLang("not_research") or var_19_2.num == var_19_0.num and var_0_3:getNowLang("research_now") or var_0_3:getNowLang("not_research")) or var_0_3:getNowLang("research_complete")
		else
			var_19_3 = self:__is_finish_all_equip_and_finish_ship_task(arg_19_2) and (var_0_9.find_object_by_id(self.now_ship_info).ship_id == var_19_0.ship_id and (self:__first_common_in_panel() or self:is_have_research_data()) and var_0_3:getNowLang("research_now") or var_0_3:getNowLang("not_research")) or var_0_3:getNowLang("research_complete")
		end

		return var_19_3
	end

	function arg_1_0.now_ship_task_info_1(arg_20_0, arg_20_1)
		for iter_20_0, iter_20_1 in pairs(arg_20_1) do
			if iter_20_1.status == 0 and iter_20_1.complete_time == 0 then
				return iter_20_1.id
			end
		end

		return arg_20_1[#arg_20_1].id
	end

	function arg_1_0:now_ship_task_info(arg_21_1)
		local var_21_0 = var_0_2:get_ship_task_info()
		local var_21_1 = var_0_9.find_object_by_id((self:now_ship_task_info_1(arg_21_1)))

		if var_21_1.stage == 1 then
			return var_21_1.id
		elseif var_21_1.stage == 2 then
			local var_21_2 = 0

			for iter_21_0, iter_21_1 in pairs(var_21_0) do
				if iter_21_1.id == var_21_1.id - 1 then
					var_21_2 = iter_21_1.complete_time
				end
			end

			if lx.ServerTime:getUtcTime() >= var_21_2 + var_0_4.research_ship_time then
				return var_21_1.id
			else
				return var_21_1.id - 1
			end
		elseif var_21_1.stage == 3 then
			local var_21_3 = 0

			for iter_21_2, iter_21_3 in pairs(var_21_0) do
				if iter_21_3.id == var_21_1.id - 1 then
					var_21_3 = iter_21_3.complete_time
				end
			end

			if lx.ServerTime:getUtcTime() >= var_21_3 + var_0_4.research_ship_time then
				return var_21_1.id
			else
				return var_21_1.id - 1
			end
		end
	end

	function arg_1_0:__set_now_ship_info(arg_22_1, arg_22_2, arg_22_3)
		self._control.research_bureau_bg.right.ship_research.transform.localScale = Vector3.New(1, 1, 1)

		local var_22_0 = var_0_2:get_ship_task_info()
		local var_22_1

		if arg_22_3 then
			var_22_1 = var_0_9.find_object_by_id(arg_22_3)

			self:__set_btn_state(arg_22_3)
		else
			var_22_1 = var_0_9.find_object_by_id(self.now_click_ship_info)

			self:__set_btn_state(self.now_click_ship_info)
		end

		local var_22_3 = var_0_5.find_object_by_cid(var_22_1.ship_id)
		local var_22_4 = var_0_10:use_big_break_painting(var_22_3, var_0_4.ship_icon_type.model_l, false)
		local var_22_5, var_22_6 = self:loadSprite(var_0_4:get_ship_icon(var_22_4, var_22_3.pic_id))

		if var_22_6 then
			self._control.research_bureau_bg.right.ship_research.transform.localScale = Vector3.New(0.5, 0.5, 1)
			self._control.research_bureau_bg.right.ship_research.rectTransform.anchoredPosition = Vector3(var_22_1.position[1] - 390, var_22_1.position[2], 0)
		else
			self._control.research_bureau_bg.right.ship_research.transform.localScale = Vector3.New(1, 1, 1)
			self._control.research_bureau_bg.right.ship_research.rectTransform.anchoredPosition = Vector3(var_22_1.position[1] - 390, var_22_1.position[2], 0)
		end

		self._control.research_bureau_bg.right.ship_research.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_22_4, var_22_3.pic_id))
		self._control.research_bureau_bg.right.ship_layer.ship_name_image.ship_type_txt.text.text = var_0_3:getNowLang("shiptypedetail" .. var_22_3.type)
		self._control.research_bureau_bg.right.ship_layer.ship_name_txt.text.text = var_22_3.title

		self:set_ship_attr(var_22_3)

		self._control.research_bureau_bg.right.ship_layer.intro_scrollview.intro_content.intro_info_txt.text.text = var_22_3.desc

		local var_22_7 = self:__now_ship_stage(var_22_1.id)

		if var_22_7 == 1 then
			self._control.research_bureau_bg.right.ship_layer.progress_bg.finish_1:SetActive(true)
			self._control.research_bureau_bg.right.ship_layer.progress_bg.finish_2:SetActive(false)
			self._control.research_bureau_bg.right.ship_layer.progress_bg.finish_3:SetActive(false)
		elseif var_22_7 == 2 then
			self._control.research_bureau_bg.right.ship_layer.progress_bg.finish_1:SetActive(true)
			self._control.research_bureau_bg.right.ship_layer.progress_bg.finish_2:SetActive(true)
			self._control.research_bureau_bg.right.ship_layer.progress_bg.finish_3:SetActive(false)
		elseif var_22_7 == 3 then
			self._control.research_bureau_bg.right.ship_layer.progress_bg.finish_1:SetActive(true)
			self._control.research_bureau_bg.right.ship_layer.progress_bg.finish_2:SetActive(true)
			self._control.research_bureau_bg.right.ship_layer.progress_bg.finish_3:SetActive(true)
		end
	end

	function arg_1_0:__now_ship_stage(arg_23_1)
		local var_23_0 = var_0_2:get_ship_task_info()
		local var_23_2
		local var_23_3 = var_0_9.find_object_by_id(arg_23_1)

		var_23_2 = var_23_3.stage == 3 and var_23_3.id - 2 or var_23_3.stage == 2 and var_23_3.id - 1 or var_23_3.id

		local var_23_4 = self:_have_data(var_23_0, var_23_2)
		local var_23_5 = lx.ServerTime:getUtcTime()

		if var_23_4 == 2 then
			for iter_23_0, iter_23_1 in ipairs(var_23_0) do
				if iter_23_1.id == var_23_2 + 1 and iter_23_1.status == 1 then
					var_23_4 = 3

					return 3
				end
			end
		end

		if var_23_4 == 1 then
			for iter_23_2, iter_23_3 in ipairs(var_23_0) do
				if iter_23_3.id == var_23_2 and iter_23_3.status == 1 then
					var_23_4 = 2

					return 2
				end
			end
		end

		return var_23_4
	end

	function arg_1_0._have_data(arg_24_0, arg_24_1, arg_24_2)
		local var_24_0 = 1

		if arg_24_1 and next(arg_24_1) then
			for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
				if iter_24_1.id == arg_24_2 + 2 and (iter_24_1.task_num_1 > 0 or iter_24_1.task_num_2 > 0 or iter_24_1.task_num_3 > 0) then
					var_24_0 = 3

					return 3
				end
			end

			for iter_24_2, iter_24_3 in ipairs(arg_24_1) do
				if iter_24_3.id == arg_24_2 + 1 and (iter_24_3.task_num_1 > 0 or iter_24_3.task_num_2 > 0 or iter_24_3.task_num_3 > 0) then
					var_24_0 = 2

					return 2
				end
			end
		end

		return var_24_0
	end

	function arg_1_0:set_ship_attr(arg_25_1)
		self._control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_1.level_txt_1.text.text = var_0_14[arg_25_1.show_attribute[1]]
		self._control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_2.level_txt_2.text.text = var_0_14[arg_25_1.show_attribute[2]]
		self._control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_3.level_txt_3.text.text = var_0_14[arg_25_1.show_attribute[3]]
		self._control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_4.level_txt_4.text.text = var_0_14[arg_25_1.show_attribute[5]]
		self._control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_5.level_txt_5.text.text = var_0_14[arg_25_1.show_attribute[6]]
		self._control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_6.level_txt_6.text.text = var_0_14[arg_25_1.show_attribute[4]]
	end

	function arg_1_0:get_research_ship_finish_info()
		local var_26_0 = {}
		local var_26_1 = var_0_2:get_ship_task_info()

		if var_26_1 and next(var_26_1) then
			for iter_26_0, iter_26_1 in pairs(var_26_1) do
				if math.fmod(iter_26_1.id, 3) == 1 then
					var_0_11(var_26_0, iter_26_1.id - 2)
				end
			end
		end

		local var_26_2 = self:__first_one_and_other_select(var_26_1, var_26_0)

		self:__have_finish_but_not_get(var_26_1, var_26_2)
		self:__have_need_get_info(var_26_2)

		local var_26_3 = self:__init_table_research_id(var_26_1, var_26_2)
		local var_26_4 = {}
		local var_26_5 = {}
		local var_26_6 = {}

		for iter_26_2, iter_26_3 in pairs(var_26_1) do
			for iter_26_4, iter_26_5 in pairs(var_26_3) do
				local var_26_7 = var_0_9.find_object_by_id(iter_26_5)

				if iter_26_3.id == var_26_7.id + 2 and iter_26_3.status == 1 and not self:__is_finish_all_equip_and_finish_ship_task(iter_26_5) then
					table.insert(var_26_5, iter_26_4)
					table.insert(var_26_6, iter_26_3.id)
				end

				if not var_0_10.have_data(var_26_4, iter_26_3.id) and iter_26_3.id == var_26_7.id then
					table.insert(var_26_4, iter_26_3.id)
				end
			end
		end

		if #var_26_5 >= 1 and next(var_26_3) and next(var_26_6) then
			local var_26_8 = {}

			if #var_26_3 > #var_26_6 then
				for iter_26_6, iter_26_7 in pairs(var_26_6) do
					for iter_26_8, iter_26_9 in pairs(var_26_3) do
						if var_0_9.find_object_by_id(iter_26_7).num == var_0_9.find_object_by_id(iter_26_9).num then
							var_0_11(var_26_8, iter_26_9)
							table.remove(var_26_3, iter_26_8)
						end
					end
				end

				for iter_26_10, iter_26_11 in pairs(var_26_8) do
					var_0_11(var_26_3, #var_26_3 + 1, iter_26_11)
				end
			end
		end

		if #var_26_5 == #var_26_4 and not next(var_26_3) then
			return var_26_4
		elseif #var_26_5 == #var_26_4 then
			return var_26_3
		else
			for iter_26_12, iter_26_13 in pairs(var_26_4) do
				if not var_0_10.have_data(var_26_3, iter_26_13) then
					table.insert(var_26_3, iter_26_13)
				end
			end
		end

		return var_26_3
	end

	function arg_1_0.__init_table_research_id(arg_27_0, arg_27_1, arg_27_2)
		if #arg_27_2 > #arg_27_1 / 3 then
			arg_27_2 = {}

			for iter_27_0, iter_27_1 in pairs(arg_27_2) do
				var_0_11(arg_27_2, iter_27_1)
			end
		end

		return arg_27_2
	end

	function arg_1_0:__have_need_get_info(arg_28_1)
		local var_28_0 = var_0_2:get_now_research_ship_id()

		if not var_28_0 or var_28_0 == nil then
			return
		end

		if self:__is_have_unget_equip_or_ship(var_28_0) then
			local var_28_1 = 0

			for iter_28_0, iter_28_1 in ipairs(arg_28_1) do
				if var_28_0 == iter_28_1 then
					var_28_1 = iter_28_0
				end
			end

			if var_28_1 > 1 then
				for iter_28_2, iter_28_3 in ipairs(arg_28_1) do
					if var_28_0 == arg_28_1 then
						table.remove(arg_28_1, iter_28_2)
					end
				end

				var_0_11(arg_28_1, 1, var_28_0)
			end
		end
	end

	function arg_1_0.select_max_stage(arg_29_0, arg_29_1)
		if arg_29_1 then
			local var_29_0 = var_0_9.find_object_by_id(arg_29_1)

			if not var_29_0 then
				return nil
			end

			if var_29_0.stage == 1 then
				return arg_29_1 + 2
			elseif var_29_0.stage == 2 then
				return arg_29_1 + 1
			elseif var_29_0.stage == 3 then
				return arg_29_1
			end
		end
	end

	function arg_1_0.select_min_stage(arg_30_0, arg_30_1)
		if arg_30_1 then
			local var_30_0 = var_0_9.find_object_by_id(arg_30_1)

			if not var_30_0 then
				return nil
			end

			if var_30_0.stage == 1 then
				return arg_30_1
			elseif var_30_0.stage == 2 then
				return arg_30_1 - 1
			elseif var_30_0.stage == 3 then
				return arg_30_1 - 2
			end
		end
	end

	function arg_1_0:__first_one_and_other_select(arg_31_1, arg_31_2)
		local var_31_1 = var_0_2:get_now_research_ship_id() or 100001
		local var_31_2 = self:select_max_stage(var_31_1)
		local var_31_5
		local var_31_6 = 1

		if self:__is_finish_all_equip_and_finish_ship_task(var_31_1) then
			local var_31_7 = var_0_10.little_clone(arg_31_2)

			for iter_31_0, iter_31_1 in pairs(var_31_7) do
				local var_31_8 = var_0_9.find_object_by_id(var_31_1)

				if not var_31_8 then
					return arg_31_2
				end

				if var_31_8.stage == 1 then
					var_31_5 = var_31_1
				elseif var_31_8.stage == 2 then
					var_31_6 = 2
					var_31_5 = var_31_1 - 1
				elseif var_31_8.stage == 3 then
					var_31_6 = 3
					var_31_5 = var_31_1 - 2
				end

				if iter_31_1 == var_31_5 then
					table.remove(var_31_7, iter_31_0)
					table.insert(var_31_7, 1, var_31_5)

					return var_31_7
				elseif var_31_6 == 2 and iter_31_1 == var_31_5 then
					table.remove(var_31_7, iter_31_0)
					table.insert(var_31_7, 1, var_31_5)

					return var_31_7
				elseif var_31_6 == 3 and iter_31_1 - 2 == var_31_5 then
					table.remove(var_31_7, iter_31_0)
					table.insert(var_31_7, 1, var_31_5)

					return var_31_7
				end
			end
		else
			return arg_31_2
		end
	end

	function arg_1_0:__ship_finish_but_equip_not_finish(arg_32_1, arg_32_2)
		local var_32_1 = {}
		local var_32_2 = {}
		local var_32_3 = var_0_2:get_unlock_ship_info()

		if var_32_3 and next(var_32_3) then
			for iter_32_0, iter_32_1 in ipairs(var_32_3) do
				if self:__is_finish_all_equip_and_finish_ship_task(iter_32_1) then
					var_0_11(var_32_1, iter_32_1)
					var_0_11(var_32_2, iter_32_1)
				end
			end
		end

		if var_32_1 and next(var_32_1) and #arg_32_2 >= 2 and #var_32_2 >= 1 then
			for iter_32_2 = #var_32_2, 1, -1 do
				for iter_32_3, iter_32_4 in ipairs(arg_32_2) do
					if var_32_2[iter_32_2] == iter_32_4 then
						table.remove(arg_32_2, iter_32_3)
					end
				end
			end

			for iter_32_5, iter_32_6 in pairs(arg_32_1) do
				for iter_32_7, iter_32_8 in pairs(var_32_1) do
					if iter_32_6.id == iter_32_8 then
						table.insert(arg_32_2, 2, iter_32_8)
					end
				end
			end
		end
	end

	function arg_1_0:__have_finish_but_not_get(arg_33_1, arg_33_2)
		local var_33_0 = {}
		local var_33_1 = {}

		for iter_33_0, iter_33_1 in ipairs(arg_33_2) do
			if self:__is_have_unget_equip_or_ship(iter_33_1) then
				var_0_11(var_33_0, iter_33_1)
				var_0_11(var_33_1, iter_33_1)
			end
		end

		local var_33_2 = var_0_2:get_now_research_ship_id()

		if var_33_0 and next(var_33_0) and #arg_33_2 >= 2 then
			for iter_33_2 = #var_33_1, 1, -1 do
				for iter_33_3, iter_33_4 in ipairs(arg_33_2) do
					local var_33_3 = var_0_9.find_object_by_id(var_33_2)
					local var_33_4 = var_0_9.find_object_by_id(iter_33_4)
					local var_33_5 = self:__is_finish_all_equip_and_finish_ship_task(iter_33_4)

					if var_33_1[iter_33_2] == iter_33_4 and var_33_3.ship_id ~= var_33_4.ship_id then
						table.remove(arg_33_2, iter_33_3)
					elseif var_33_1[iter_33_2] == iter_33_4 and var_33_3.ship_id == var_33_4.ship_id and not var_33_5 then
						table.remove(arg_33_2, iter_33_3)
					end
				end
			end

			for iter_33_5, iter_33_6 in pairs(arg_33_1) do
				for iter_33_7, iter_33_8 in pairs(var_33_0) do
					local var_33_6 = var_0_9.find_object_by_id(var_33_2)
					local var_33_7 = var_0_9.find_object_by_id(iter_33_8)
					local var_33_8 = self:__is_finish_all_equip_and_finish_ship_task(iter_33_8)

					if iter_33_6.id == iter_33_8 and var_33_6.ship_id ~= var_33_7.ship_id then
						table.insert(arg_33_2, 2, iter_33_8)
					elseif iter_33_6.id == iter_33_8 and var_33_6.ship_id == var_33_7.ship_id and not var_33_8 then
						table.insert(arg_33_2, 2, iter_33_8)
					end
				end
			end
		end
	end

	function arg_1_0:__set_btn_state(arg_34_1)
		if arg_34_1 == 10000113 then
			return
		end

		self._control.start_btn.start_btn_text.text.text = self:__is_finish_all_equip_and_finish_ship_task(arg_34_1) and var_0_3:getNowLang("research") or var_0_3:getNowLang("research_end")
	end

	function arg_1_0.__is_finish_all_equip_and_finish_ship_task(arg_35_0, arg_35_1)
		local var_35_0 = false
		local var_35_1 = var_0_9.find_object_by_id(arg_35_1)
		local var_35_2 = var_0_2:get_equip_task_info()
		local var_35_3 = var_0_2:get_ship_task_info()

		if not var_35_3 or not var_35_2 then
			return var_35_0
		end

		if var_35_2 and next(var_35_2) then
			for iter_35_0, iter_35_1 in pairs(var_35_2) do
				for iter_35_2, iter_35_3 in ipairs(var_35_1.equipment) do
					if iter_35_1.id == iter_35_3 and iter_35_1.status == 0 then
						var_35_0 = true

						return true
					end
				end
			end
		end

		if var_35_3 and next(var_35_3) then
			if var_35_1.stage == 1 then
				for iter_35_4, iter_35_5 in pairs(var_35_3) do
					if iter_35_5.id == arg_35_1 + 2 and iter_35_5.status == 0 then
						var_35_0 = true

						return true
					end
				end
			elseif var_35_1.stage == 2 then
				for iter_35_6, iter_35_7 in pairs(var_35_3) do
					if iter_35_7.id == arg_35_1 + 1 and iter_35_7.status == 0 then
						var_35_0 = true

						return true
					end
				end
			elseif var_35_1.stage == 3 then
				for iter_35_8, iter_35_9 in pairs(var_35_3) do
					if iter_35_9.id == arg_35_1 and iter_35_9.status == 0 then
						var_35_0 = true

						return true
					end
				end
			end
		end

		return var_35_0
	end

	function arg_1_0:__is_have_unget_equip_or_ship(arg_36_1)
		if arg_36_1 == 10000113 then
			return
		end

		local var_36_1 = false
		local var_36_2 = var_0_2:get_unlock_ship_info()
		local var_36_3 = var_0_2:get_unlock_equips_info()
		local var_36_4 = var_0_2:get_equip_task_info()
		local var_36_5 = var_0_2:get_ship_task_info()
		local var_36_6 = self:select_min_stage(arg_36_1)
		local var_36_7 = self:select_max_stage(arg_36_1)

		if not var_0_9.find_object_by_id(arg_36_1) or not var_36_6 or not var_36_7 then
			return false
		end

		if var_36_2 and next(var_36_2) then
			if var_0_10.have_data(var_36_2, var_36_6) or var_0_10.have_data(var_36_2, var_36_7) then
				var_36_1 = false
			else
				for iter_36_0, iter_36_1 in ipairs(var_36_5) do
					if iter_36_1.id == var_36_7 and iter_36_1.status == 1 and (not var_0_10.have_data(var_36_2, var_36_7) or not var_0_10.have_data(var_36_2, var_36_6)) then
						var_36_1 = true
					end
				end
			end
		else
			for iter_36_2, iter_36_3 in pairs(var_36_5) do
				if iter_36_3.id == var_36_7 and iter_36_3.status == 1 then
					var_36_1 = true
				end
			end
		end

		if var_36_1 then
			return var_36_1
		else
			return (self:__is_have_finish_equip(arg_36_1))
		end
	end

	function arg_1_0.__is_have_finish_equip(arg_37_0, arg_37_1)
		if not arg_37_1 then
			return
		end

		local var_37_0 = false
		local var_37_1 = {}
		local var_37_2 = var_0_2:get_equip_task_info()
		local var_37_3 = var_0_9.find_object_by_id(arg_37_1)
		local var_37_4 = var_0_2:get_unlock_ship_info()
		local var_37_5 = var_0_2:get_unlock_equips_info()

		if var_37_5 and next(var_37_5) then
			for iter_37_0, iter_37_1 in pairs(var_37_2) do
				for iter_37_2, iter_37_3 in pairs(var_37_3.equipment) do
					if iter_37_1.id == iter_37_3 and iter_37_1.status == 1 then
						var_0_11(var_37_1, iter_37_1.id)
					end
				end
			end

			if var_37_1 and next(var_37_1) then
				if #var_37_1 == 1 then
					if not var_0_10.have_data(var_37_5, var_37_1[1]) then
						var_37_0 = true

						return true
					end
				elseif #var_37_1 == 2 then
					if not var_0_10.have_data(var_37_5, var_37_1[2]) and not var_0_10.have_data(var_37_5, var_37_1[2]) then
						var_37_0 = true

						return true
					end
				elseif #var_37_1 == 3 then
					if not var_0_10.have_data(var_37_5, var_37_1[3]) or not var_0_10.have_data(var_37_5, var_37_1[2]) or not var_0_10.have_data(var_37_5, var_37_1[1]) then
						var_37_0 = true

						return true
					end
				elseif #var_37_1 == 4 and (not var_0_10.have_data(var_37_5, var_37_1[4]) or not var_0_10.have_data(var_37_5, var_37_1[3]) or not var_0_10.have_data(var_37_5, var_37_1[2]) or not var_0_10.have_data(var_37_5, var_37_1[1])) then
					var_37_0 = true

					return true
				end
			end
		else
			for iter_37_4, iter_37_5 in pairs(var_37_2) do
				for iter_37_6, iter_37_7 in pairs(var_37_3.equipment) do
					if iter_37_5.id == iter_37_7 and iter_37_5.status == 1 then
						var_37_0 = true

						return true
					end
				end
			end
		end

		return var_37_0
	end

	function arg_1_0:__update_edge_mask()
		self._control.research_bureau_bg.left.left_scrollview.viewport.content.transform.anchoredPosition = Vector2(-7, 0)
	end

	function arg_1_0:_play_audio(arg_39_1)
		self:playBackgroundMusic(arg_39_1)
	end

	function arg_1_0:_play_into_se(arg_40_1)
		self:playSE(arg_40_1, false)
	end

	function arg_1_0.__first_common_in_panel(arg_41_0)
		local var_41_0 = false
		local var_41_1 = var_0_12:getKeyData("first_research_ship_id")

		if var_41_1 then
			local var_41_3 = string.sub(var_41_1, -5)
			local var_41_4 = tonumber(var_41_3)

			if string.sub(var_0_2:get_account_id(), -5) == var_41_3 then
				var_41_0 = true
			end
		end

		return var_41_0
	end

	function arg_1_0.get_research_max_status(arg_42_0, arg_42_1)
		local var_42_0

		if not arg_42_1 then
			do return end

			var_42_0 = {}
		end

		for iter_42_0, iter_42_1 in ipairs((var_0_2:get_ship_task_info())) do
			var_0_11(var_42_0, iter_42_1)
		end

		local var_42_1 = var_0_9.find_object_by_id(arg_42_1)

		table.sort(var_42_0, function(arg_43_0, arg_43_1)
			return arg_43_0.id > arg_43_1.id
		end)

		if var_42_0 and next(var_42_0) then
			local var_42_2 = lx.ServerTime:getUtcTime()

			for iter_42_2, iter_42_3 in ipairs(var_42_0) do
				local var_42_3 = var_0_9.find_object_by_id(iter_42_3.id)

				if var_42_1.stage == var_42_3.stage and var_42_3.stage == 3 and var_42_1.ship_id == var_42_3.ship_id and iter_42_3.status == 1 then
					return arg_42_1
				elseif var_42_1.stage == var_42_3.stage and var_42_3.stage == 2 and var_42_1.ship_id == var_42_3.ship_id and iter_42_3.status == 1 then
					if var_42_2 >= iter_42_3.complete_time + var_0_4.research_ship_time then
						return arg_42_1 + 1
					else
						return arg_42_1
					end
				elseif var_42_1.stage == var_42_3.stage and var_42_3.stage == 1 and var_42_1.ship_id == var_42_3.ship_id and iter_42_3.status == 1 then
					if var_42_2 >= iter_42_3.complete_time + var_0_4.research_ship_time then
						return arg_42_1 + 1
					else
						return arg_42_1
					end
				end
			end
		end

		return arg_42_1
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0.__initia_lize(arg_45_0)
		arg_45_0._now_click_icon = nil
		arg_45_0._reusable_cell = nil
		arg_45_0._ship_info = {}
		arg_45_0.now_ship_info = nil
		arg_45_0._old_click_icon = nil
		arg_45_0._is_already_init = false
		arg_45_0._come_in_state = 1
		arg_1_0.now_click_ship_info = nil
		arg_45_0._now_click_ship_id = 0
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_46_0)
	local var_46_0 = var_0_1:class("research_bureau")

	var_46_0:__initia_lize()

	var_46_0._reusable_cell = nil
	var_46_0._ship_info = {}
	var_46_0.now_ship_info = nil
	var_46_0._now_click_icon = nil
	var_46_0._old_click_icon = nil
	var_46_0._is_already_init = false
	var_46_0._come_in_state = 1
	var_46_0.now_click_ship_info = nil
	var_46_0._now_click_ship_id = 0
	var_46_0._left_ship_pos = 0
	var_46_0.down_pos = 0

	return var_46_0
end

return var_0_0
