local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = table.sort
local var_0_3 = gamecore.prompt
local var_0_4 = table.remove
local var_0_5 = table.insert
local var_0_6 = gamecore.UILoader
local var_0_7 = gamecore.Language
local var_0_8 = DG.Tweening.DOTween
local var_0_9 = string.format
local var_0_10 = gamecore.util_func
local var_0_11 = gameenum.common_type
local var_0_12 = gameconfig.equip_config

gamecore.UILoader:define("research_ship_equip", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:show(arg_3_1, arg_3_2)
		self:setVisible(true)
		self:__init_language()

		self._need_equip_type = arg_3_1.type
		self._need_equip_num = arg_3_1.num
		self._need_research_type = arg_3_1.equip_types
		self._need_research_cids = arg_3_1.equip_cids
		self._task_id = arg_3_2

		self:__init_panel(arg_3_1)
	end

	function arg_1_0:__init_panel(arg_4_1)
		if not self._is_already_init then
			self:__init_language()
			self:__init_cell()
		end

		local var_4_0 = var_0_6:getInstance("equip_type_layer")

		if var_4_0 then
			var_4_0:reset_sort_info()
		end

		self:update_data()
	end

	function arg_1_0:update_data(arg_5_1)
		self:get_need_equip_num()
		self:init_equip_data()
		self:__show_capacity()
		self:__update_cell_list(arg_5_1)
	end

	function arg_1_0:__init_language()
		self._control.bg_container.tip_title.text.text = var_0_7:getNowLang("selectequiptitle")
		self._control.bg_container.tip_title.desc_text.text.text = var_0_7:getNowLang("research_equipment_desc")
		self._control.equip_content.equip_capacity.dockcapacity.text.text = var_0_7:getNowLang("equipdockcapacity")
		self._control.equip_content.equip_num.research_need_txt.text.text = var_0_7:getNowLang("research_need")
		self._control.equip_content.equip_num.research_select_txt.text.text = var_0_7:getNowLang("research_choose")
		self._control.equip_content.ok_btn.title.text.text = var_0_7:getNowLang("confirm")
		self._control.equip_content.type_btn.type.text.text = var_0_7:getNowLang("ui_collectionviewtip")
		self._control.equip_content.type_btn.type_txt.text.text = var_0_7:getNowLang("equip0")
	end

	function arg_1_0:init_equip_data()
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in pairs((var_0_1:get_equipment_list())) do
			if not iter_7_1.lock then
				local var_7_1 = var_0_12.find_object_by_cid(iter_7_1.id)

				if self._need_equip_type == 1 then
					if self._need_research_type and next(self._need_research_type) then
						for iter_7_2, iter_7_3 in pairs(self._need_research_type) do
							if var_7_1.type == iter_7_3 then
								var_0_5(var_7_0, iter_7_1)
							end
						end
					end
				elseif self._need_equip_type == 2 and self._need_research_cids and next(self._need_research_cids) then
					for iter_7_4, iter_7_5 in pairs(self._need_research_cids) do
						if var_7_1.cid == iter_7_5 then
							var_0_5(var_7_0, iter_7_1)
						end
					end
				end
			end
		end

		var_0_2(var_7_0, function(arg_8_0, arg_8_1)
			local var_8_0 = var_0_12.find_object_by_cid(arg_8_0.id)
			local var_8_1 = var_0_12.find_object_by_cid(arg_8_1.id)

			if var_8_0.star == var_8_1.star then
				if var_8_0.type == var_8_1.type then
					return var_8_0.cid > var_8_1.cid
				else
					return var_8_0.type < var_8_1.type
				end
			else
				return var_8_0.star < var_8_1.star
			end
		end)

		self._equip_data = var_7_0
	end

	function arg_1_0:__show_capacity()
		local var_9_0 = 0

		for iter_9_0, iter_9_1 in pairs(var_0_1:get_equipment_list()) do
			var_9_0 = var_9_0 + iter_9_1.num
		end

		self._control.equip_content.equip_capacity.amount_txt.text.text = var_9_0 .. "/" .. var_0_1:get_use_info_data().max_equip
		self._control.equip_content.equip_num.research_need_txt.need_equip.text.text = self._need_equip_num - self._finish_num
	end

	function arg_1_0:get_new_equip_list(arg_10_1)
		local var_10_0 = {}

		for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
			for iter_10_2, iter_10_3 in pairs(self._type_toggle_data) do
				local var_10_1 = false
				local var_10_2 = var_0_12.find_object_by_cid(iter_10_1.id)

				if iter_10_2 == "all" and iter_10_3 then
					var_10_1 = true
				elseif iter_10_2 == "missile_launcher" then
					if var_0_11.equip_type.anti_ship_missile_launcher == var_10_2.type or var_0_11.equip_type.air_defense_missile_launcher == var_10_2.type then
						var_10_1 = true
					end
				elseif iter_10_2 == "missile" then
					if var_0_11.equip_type.anti_ship_missile == var_10_2.type or var_0_11.equip_type.air_defense_missile == var_10_2.type then
						var_10_1 = true
					end
				elseif var_0_11.equip_type[iter_10_2] == var_10_2.type then
					var_10_1 = true
				end

				if var_10_1 then
					var_0_5(var_10_0, iter_10_1)
				end
			end
		end

		return var_10_0
	end

	function arg_1_0:get_equip_effect_list(arg_11_1)
		local var_11_0 = {}

		for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
			local var_11_1 = false

			for iter_11_2, iter_11_3 in pairs(self._effect_toggle_data) do
				local var_11_2 = var_0_12.find_object_by_cid(iter_11_1.id)

				if iter_11_2 == "all" and iter_11_3 then
					var_11_1 = true
				elseif iter_11_2 == "attack" then
					if var_0_10.have_data(var_11_2.effect_type, 1) then
						var_11_1 = true
					end
				elseif iter_11_2 == "extra_damage" then
					if var_0_10.have_data(var_11_2.effect_type, 2) then
						var_11_1 = true
					end
				elseif iter_11_2 == "exp_up" then
					if var_0_10.have_data(var_11_2.effect_type, 3) then
						var_11_1 = true
					end
				elseif iter_11_2 == "armor_pene" then
					if var_0_10.have_data(var_11_2.effect_type, 4) then
						var_11_1 = true
					end
				elseif iter_11_2 == "expedition_resource" then
					if var_0_10.have_data(var_11_2.effect_type, 5) then
						var_11_1 = true
					end
				elseif iter_11_2 == "hit_rate" then
					if var_0_10.have_data(var_11_2.effect_type, 6) then
						var_11_1 = true
					end
				elseif iter_11_2 == "miss" then
					if var_0_10.have_data(var_11_2.effect_type, 7) then
						var_11_1 = true
					end
				elseif iter_11_2 == "critical_rate" then
					if var_0_10.have_data(var_11_2.effect_type, 8) then
						var_11_1 = true
					end
				elseif iter_11_2 == "anti_air" then
					if var_0_10.have_data(var_11_2.effect_type, 9) then
						var_11_1 = true
					end
				elseif iter_11_2 == "atk_top" and var_0_10.have_data(var_11_2.effect_type, 10) then
					var_11_1 = true
				end
			end

			if var_11_1 then
				var_0_5(var_11_0, iter_11_1)
			end
		end

		return var_11_0
	end

	function arg_1_0:__init_cell()
		if self._already_init then
			return
		end

		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.all_equip.viewport.content.endlessScrollView, self._control.all_equip.viewport.content, "single_equip", "research_ship_equip")

		self._reusable_cell:init()

		self._already_init = true
	end

	function arg_1_0:__update_cell_list(arg_13_1)
		self.sum_num = 0

		local var_13_0 = var_0_6:createInstance("equip_type_layer")

		self._type_toggle_data = var_13_0._type_toggle_data
		self._effect_toggle_data = var_13_0._effect_toggle_data

		if var_13_0._type_toggle_txt ~= "" then
			self._control.equip_content.type_btn.type_txt.text.text = var_13_0._type_toggle_txt
		end

		local var_13_1 = self:get_equip_effect_list((self:get_new_equip_list(self._equip_data)))

		if arg_13_1 then
			self._reusable_cell:set_data(var_13_1, true)
		else
			self._reusable_cell:set_data(var_13_1)
		end

		self._dispose_already_selected = 0

		local var_13_2 = 0

		if #self._dispose_data then
			for iter_13_0, iter_13_1 in pairs(self._dispose_data) do
				var_13_2 = var_13_2 + iter_13_1.num
			end
		end

		self._control.equip_content.equip_num.research_select_txt.select_equip.text.text = var_13_2

		function self._reusable_cell:_set_func(arg_14_1)
			self.dismantle_layer.gameObject:SetActive(false)

			self._data_index = 0

			local var_14_0 = var_0_12.find_object_by_cid(var_13_1[arg_14_1 + 1].id)

			for iter_14_0, iter_14_1 in pairs(self._dispose_data) do
				if iter_14_1.cid == var_14_0.cid then
					self._data_index = iter_14_0
				end
			end

			if self._dispose_data[self._data_index] and self._dispose_data[self._data_index].num and self._dispose_data[self._data_index].num > 0 then
				self.dismantle_layer.gameObject:SetActive(true)

				self.dismantle_layer.num.text.text = self._dispose_data[self._data_index].num
			end

			self.info_layer.equip_bg.ship_name.shipname.text.text = var_14_0.title

			self.info_layer.equip_bg.ship_name.textHorizonScroller:SetText(var_14_0.title)

			self.info_layer.icon_layer.icon_bg.image.sprite = self:loadSprite(var_0_9(var_0_11.equip_back.equip_back_normal, var_14_0.star))
			self.info_layer.icon_layer.icon.image.sprite = self:loadSprite(var_0_9(var_0_11.equip_icon.large, var_14_0.pic_id))

			local var_14_2 = var_13_1[arg_14_1 + 1].num

			self.info_layer.icon_layer.count.text.text = var_13_1[arg_14_1 + 1].num

			local var_14_3 = app:getSystem():getChannel()

			self.info_layer.name_layer.equip_name.text.text = var_0_10.limit_omit_string(var_14_0.title, (var_14_3 == "hm_android_jp" or var_14_3 == "hm_ios_jp" or nil) and var_0_11.equip_utf8_constant.japanese)

			local var_14_4 = {
				self.info_layer.detail_layer.attrib_1,
				self.info_layer.detail_layer.attrib_2
			}
			local var_14_5 = var_0_11:get_equip_attribute(var_13_1[arg_14_1 + 1].id)

			for iter_14_2 = 1, #var_14_4 do
				if not var_14_5[iter_14_2] then
					var_14_4[iter_14_2]:SetActive(false)
				else
					var_14_4[iter_14_2].count.text.text = var_0_11.equip_attribute[var_14_5[iter_14_2].index] == "range" and var_14_5[iter_14_2].count or var_14_5[iter_14_2].count > 0 and "+" .. var_14_5[iter_14_2].count or var_14_5[iter_14_2].count
					var_14_4[iter_14_2].title.text.text = var_0_11:get_equip_attribute_name(var_0_11.equip_attribute[var_14_5[iter_14_2].index])

					var_14_4[iter_14_2]:SetActive(true)
				end
			end

			self.info_layer.research_add_btn:SetActive(true)
			self.info_layer.add_btn:SetActive(false)
			self.info_layer.detail_btn.button.onClick:RemoveAllListeners()
			self.info_layer.detail_btn.button.onClick:AddListener(function()
				self:__show_equip_att(self.info_layer, var_14_0)
			end)

			self._now_equip_num = 1

			self.info_layer.research_add_btn.button.onClick:RemoveAllListeners()
			self.info_layer.research_add_btn.button.onClick:AddListener(function()
				if self._need_equip_num - self._finish_num == self.sum_num then
					var_0_3:show(var_0_7:getNowLang("number_max"))

					return
				end

				if self.sum_num >= self._need_equip_num - self._finish_num then
					var_0_3:show(var_0_7:getNowLang("number_max"))

					return
				end

				local var_16_0 = 0

				if self._dispose_data and next(self._dispose_data) then
					for iter_16_0, iter_16_1 in pairs(self._dispose_data) do
						var_16_0 = var_16_0 + iter_16_1.num
					end
				end

				if var_16_0 >= self._need_equip_num - self._finish_num then
					var_0_3:show(var_0_7:getNowLang("number_max"))

					return
				end

				if self._dispose_data and next(self._dispose_data) then
					for iter_16_2, iter_16_3 in pairs(self._dispose_data) do
						if var_14_0.cid ~= iter_16_3.cid then
							self._now_equip_num = 1
						end
					end
				end

				if var_14_2 + self.sum_num > self._need_equip_num - self._finish_num then
					var_14_2 = self._need_equip_num - self._finish_num - self.sum_num
				else
					for iter_16_4, iter_16_5 in pairs(var_0_1:get_equipment_list()) do
						if var_14_0.cid == iter_16_5.id then
							var_14_2 = iter_16_5.num

							local var_16_1 = 0

							for iter_16_6, iter_16_7 in pairs(self._dispose_data) do
								var_16_1 = var_16_1 + iter_16_7.num
							end

							if var_14_2 + var_16_1 > self._need_equip_num - self._finish_num then
								var_14_2 = self._need_equip_num - self._finish_num - var_16_1
							end
						end
					end
				end

				if self._dispose_data then
					table.insert(self._dispose_data, {
						num = var_14_2,
						cid = var_14_0.cid
					})
				end

				self.dismantle_layer.gameObject:SetActive(true)
				self.dismantle_layer.bg.gameObject:SetActive(true)

				self.dismantle_layer.num.text.text = var_14_2
				self._dispose_already_selected = var_14_2

				local var_16_2 = 0

				for iter_16_8, iter_16_9 in pairs(self._dispose_data) do
					var_16_2 = var_16_2 + iter_16_9.num
				end

				self.sum_num = var_16_2
				self._control.equip_content.equip_num.research_select_txt.select_equip.text.text = var_16_2

				if #self._dispose_data <= 0 then
					self._control.equip_content.ok_btn:GetComponent("Button").interactable = false
					self._control.equip_content.ok_btn.image.sprite = self:loadSprite(var_0_11.ship_detail_switch.close)
				else
					self._control.equip_content.ok_btn:GetComponent("Button").interactable = true
					self._control.equip_content.ok_btn.image.sprite = self:loadSprite(var_0_11.ship_detail_switch.open)
				end
			end)
			self.dismantle_layer.minus_btn.pointerDownUpEvent.onPointerDown:RemoveAllListeners()
			self.dismantle_layer.minus_btn.pointerDownUpEvent.onPointerDown:AddListener(function()
				for iter_17_0, iter_17_1 in pairs(self._dispose_data) do
					if iter_17_1.cid == var_14_0.cid then
						self._data_index = iter_17_0
						self._dispose_data[iter_17_0].num = self._dispose_data[iter_17_0].num - 1

						self.dismantle_layer.gameObject:SetActive(true)

						self.dismantle_layer.num.text.text = iter_17_1.num

						if self._dispose_data[iter_17_0].num <= 0 then
							self.dismantle_layer.gameObject:SetActive(false)
							var_0_4(self._dispose_data, iter_17_0)
						end
					end
				end

				local var_17_0 = 0

				for iter_17_2, iter_17_3 in pairs(self._dispose_data) do
					var_17_0 = var_17_0 + iter_17_3.num
				end

				self.sum_num = var_17_0
				self._control.equip_content.equip_num.research_select_txt.select_equip.text.text = var_17_0

				if #self._dispose_data <= 0 then
					self._control.equip_content.ok_btn:GetComponent("Button").interactable = false
					self._control.equip_content.ok_btn.image.sprite = self:loadSprite(var_0_11.ship_detail_switch.close)
				else
					self._control.equip_content.ok_btn:GetComponent("Button").interactable = true
					self._control.equip_content.ok_btn.image.sprite = self:loadSprite(var_0_11.ship_detail_switch.open)
				end
			end)
			self.dismantle_layer.minus_btn.clickAndLongClickEvent.onLongClick:RemoveAllListeners()
			self.dismantle_layer.minus_btn.clickAndLongClickEvent.onLongClick:AddListener(function()
				self.minus_seq = self:autoKillDOTween(var_0_8.Sequence())

				if self._dispose_data and self._dispose_data[self._data_index] then
					for iter_18_0 = 1, self._dispose_data[self._data_index].num do
						self.minus_seq:AppendCallback(function()
							if self._dispose_data[self._data_index].num > 1 then
								self._dispose_data[self._data_index].num = self._dispose_data[self._data_index].num - 1
								self.dismantle_layer.num.text.text = self._dispose_data[self._data_index].num
								self._dispose_data[self._data_index].num = self._dispose_data[self._data_index].num
							else
								self._dispose_data[self._data_index].num = 0
								self._dispose_already_selected = self._dispose_already_selected - 1

								self.dismantle_layer.gameObject:SetActive(false)
								self.minus_seq:Kill()
							end

							local var_19_0 = 0

							for iter_19_0, iter_19_1 in pairs(self._dispose_data) do
								var_19_0 = var_19_0 + iter_19_1.num
							end

							self.sum_num = var_19_0
							self._control.equip_content.equip_num.research_select_txt.select_equip.text.text = var_19_0
						end)
						self.minus_seq:AppendInterval(0.1)
					end
				end

				self.minus_seq:Play()
			end)
			self.dismantle_layer.minus_btn.pointerDownUpEvent.onPointerUp:RemoveAllListeners()
			self.dismantle_layer.minus_btn.pointerDownUpEvent.onPointerUp:AddListener(function()
				if self.minus_seq then
					self.minus_seq:Kill()
				end
			end)
			self.dismantle_layer.minus_btn.pointerDownUpEvent.onPointerDown:RemoveAllListeners()
			self.dismantle_layer.minus_btn.pointerDownUpEvent.onPointerDown:AddListener(function()
				for iter_21_0, iter_21_1 in pairs(self._dispose_data) do
					if iter_21_1.cid == var_14_0.cid then
						self._data_index = iter_21_0
					end
				end

				if self._dispose_data[self._data_index].num > 1 then
					self.dismantle_layer.num.text.text = self._dispose_data[self._data_index].num - 1
					self._dispose_data[self._data_index].num = self._dispose_data[self._data_index].num - 1
				else
					self._dispose_data[self._data_index].num = 0
					self._dispose_already_selected = self._dispose_already_selected - 1

					self.dismantle_layer.gameObject:SetActive(false)
				end

				local var_21_0 = 0

				for iter_21_2, iter_21_3 in pairs(self._dispose_data) do
					var_21_0 = var_21_0 + iter_21_3.num
				end

				self.sum_num = var_21_0
				self._control.equip_content.equip_num.research_select_txt.select_equip.text.text = var_21_0
			end)
			self.dismantle_layer.bg.button.onClick:RemoveAllListeners()
			self.dismantle_layer.bg.button.onClick:AddListener(function()
				local var_22_0 = {}

				for iter_22_0, iter_22_1 in pairs(self._dispose_data) do
					if iter_22_1.cid ~= var_14_0.cid then
						var_0_5(var_22_0, iter_22_1)
					end
				end

				self._dispose_data = var_22_0

				local var_22_1 = 0

				for iter_22_2, iter_22_3 in pairs(self._dispose_data) do
					var_22_1 = var_22_1 + iter_22_3.num
				end

				self.sum_num = var_22_1
				self._control.equip_content.equip_num.research_select_txt.select_equip.text.text = var_22_1
				self._dispose_already_selected = self._dispose_already_selected - 1

				self.dismantle_layer.gameObject:SetActive(false)
			end)

			if #self._dispose_data <= 0 then
				self._control.equip_content.ok_btn:GetComponent("Button").interactable = false
				self._control.equip_content.ok_btn.image.sprite = self:loadSprite(var_0_11.ship_detail_switch.close)
			else
				self._control.equip_content.ok_btn:GetComponent("Button").interactable = true
				self._control.equip_content.ok_btn.image.sprite = self:loadSprite(var_0_11.ship_detail_switch.open)
			end
		end
	end

	function arg_1_0:__show_equip_att(arg_23_1, arg_23_2)
		self._equip_attr = self._equip_attr or self:loadUI("equip_attr")

		self:__show_equip_attr_panel(true)
		self._equip_attr._panel.transform:SetParent(arg_23_1.rectTransform, false)

		self._equip_attr._panel.transform.anchoredPosition = Vector2.New(51, -230)

		self._equip_attr._panel.transform:SetParent(self._control.equip_content.rectTransform)

		if self._equip_attr._panel.transform.anchoredPosition.y < -253 then
			self._equip_attr._panel.transform.anchoredPosition = Vector2.New(self._equip_attr._panel.transform.anchoredPosition.x, -253)
		end

		self._equip_attr._panel.transform:SetParent(arg_23_1.rectTransform)
		self._equip_attr:show(arg_23_2)
	end

	function arg_1_0:__show_equip_attr_panel(arg_24_1)
		if not self._equip_attr then
			return
		end

		self._control.tip_layer:SetActive(arg_24_1)
		self._equip_attr:setVisible(arg_24_1)
	end

	function arg_1_0:__station_state_return()
		if self._ship_data.state == var_0_11.ship_state.station then
			var_0_3:show(var_0_7:getNowLang("noticeshipisinguard"))

			return true
		end
	end

	function arg_1_0:get_need_equip_num()
		local var_26_0 = var_0_1:get_equip_task_info()
		local var_26_1 = var_0_1:get_research_equip_id()

		if var_26_0 and next(var_26_0) then
			for iter_26_0, iter_26_1 in pairs(var_26_0) do
				if iter_26_1.id == var_26_1 then
					if self._task_id == 1 then
						self._finish_num = iter_26_1.task_num_1
					elseif self._task_id == 2 then
						self._finish_num = iter_26_1.task_num_2
					elseif self._task_id == 3 then
						self._finish_num = iter_26_1.task_num_3
					end
				end
			end
		end

		return self._finish_num
	end

	function arg_1_0.__onReset(arg_27_0)
		arg_27_0._is_already_init = false
		arg_27_0._data = nil
		arg_27_0._ship_data = nil
		arg_27_0._ship_conf = nil
		arg_27_0._index = nil
		arg_27_0._is_change = true
		arg_27_0._equip_data = {}
		arg_27_0._dispose_data = {}
		arg_27_0._can_lock_seq = false
		arg_27_0._type_toggle_data = {
			all = true
		}
		arg_27_0._effect_toggle_data = {
			all = true
		}
		arg_27_0._type_layer_callback = nil
		arg_27_0._equip_attr = nil
		arg_27_0._no_load_list = nil
		arg_27_0._need_research_cids = {}
		arg_27_0._finish_num = 0
	end

	function arg_1_0.__initia_lize(arg_28_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_29_0)
	local var_29_0 = var_0_6:class("research_ship_equip")

	var_29_0._need_equip_num = 0
	var_29_0._equip_attr = nil
	var_29_0._dispose_data = {}
	var_29_0._need_equip_type = 1
	var_29_0._type_toggle_data = {
		all = true
	}
	var_29_0._effect_toggle_data = {
		all = true
	}
	var_29_0._need_research_type = {}
	var_29_0._need_research_cids = {}
	var_29_0._finish_num = 0
	var_29_0._task_id = nil

	var_29_0:__initia_lize()

	return var_29_0
end

return var_0_0
