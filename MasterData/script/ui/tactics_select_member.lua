local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_6 = table.insert
local var_0_7 = gamecore.Language
local var_0_8 = gamecore.UILoader
local var_0_11 = gamecore.util_func
local var_0_12 = gameenum.common_type
local var_0_13 = gameconfig.ship_config
local var_0_14 = gameconfig.item_config
local var_0_15 = gameconfig.skill_config
local var_0_16 = gameconfig.equip_config
local var_0_17 = gameconfig.workshop_config
local var_0_19 = gameconfig.cook_book_config

gamecore.UILoader:define("tactics_select_member", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if var_0_1:get_guide_state() and self._reusable_cell then
			self._reusable_cell:update()
		elseif self._reusable_cell and var_0_1:get_is_preload_completed() then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:show(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		self:setVisible(true)

		if self._sort_layer then
			self._sort_layer:reset_tactics_select_state()
		end

		self._data = arg_3_1
		self._data_by_type = arg_3_2
		self._now_teacher = arg_3_3
		self._now_class = arg_3_4

		self:__init_panel(arg_3_1)
	end

	function arg_1_0:__init_language()
		self._control.bg_container.tip_title.text.text = self._data.title
		self._control.bg_container.desc.desc_text.text.text = var_0_7:getNowLang("tactics_record_tips")
		self._control.strengthen_info.level_3.title.text.text = "Lv.3:"
		self._control.strengthen_info.level_2.title.text.text = "Lv.2:"
		self._control.strengthen_info.level_1.title.text.text = "Lv.1:"
		self._control.strengthen_info.level_0.title.text.text = "Lv.0:"
		self._control.detail_btn.pvpdetailbtn.text.text = var_0_7:getNowLang("pvpdetailbtn")
		self._control.sort_order_btn.sorttype.text.text = var_0_7:getNowLang("sorttype")
		self._control.sort_type_btn.type.text.text = var_0_7:getNowLang("type")
		self._control.sort_order_btn.sort_txt.text.text = var_0_7:getNowLang("tactics_level") .. var_0_7:getNowLang("arrow_down")
		self._control.sort_type_btn.sort_txt.text.text = var_0_7:getNowLang("questall")
	end

	function arg_1_0:__init_ship_list()
		if not self._reusable_cell then
			self._reusable_cell = gamecore.reusable_cell:create(self, self._control.all_ship.Viewport.edge_mask.Content.endlessScrollView, self._control.all_ship.Viewport.edge_mask.Content, "single_select_team", "select_member", true)

			self._reusable_cell:init()
		end
	end

	function arg_1_0:__init_panel(arg_6_1)
		self:__init_language()
		self:__init_ship_list()
		self:_init_data()
		self:get_sort_layer()
		self:get_type_layer()
		self:__update_reusable_cell()
		self._type_layer:set_tactics_group_visible(true)
	end

	function arg_1_0:__get_select_data()
		local var_7_1 = {}
		local var_7_2 = 90

		if self._data_by_type then
			if self._data_by_type <= 3 then
				var_7_2 = var_0_12.college_const.attack_level
			elseif self._data_by_type <= 6 then
				var_7_2 = var_0_12.college_const.defense_level
			elseif self._data_by_type <= 9 then
				var_7_2 = var_0_12.college_const.special_level
			end
		end

		for iter_7_0, iter_7_1 in pairs((var_0_1:get_character_list())) do
			local var_7_3 = var_0_13.find_object_by_cid(iter_7_1.cid)

			if iter_7_1.all_tactics ~= nil and var_7_2 <= iter_7_1.level and next(iter_7_1.all_tactics) then
				for iter_7_2, iter_7_3 in ipairs(iter_7_1.all_tactics) do
					if iter_7_3.id == self._data.cid or iter_7_3.id == self._data.cid + 1 or iter_7_3.id == self._data.cid + 2 or iter_7_3.id == self._data.cid + 3 then
						var_0_6(var_7_1, iter_7_1)
					end
				end
			end
		end

		return var_7_1
	end

	function arg_1_0:_init_data()
		local var_8_0 = 0
		local var_8_1 = 0
		local var_8_2 = 0
		local var_8_3 = 0

		for iter_8_0, iter_8_1 in ipairs((self:__get_select_data())) do
			if iter_8_1.all_tactics ~= nil and next(iter_8_1.all_tactics) then
				for iter_8_2, iter_8_3 in ipairs(iter_8_1.all_tactics) do
					if iter_8_3.id == self._data.cid then
						var_8_0 = var_8_0 + 1
					elseif iter_8_3.id == self._data.cid + 1 then
						var_8_1 = var_8_1 + 1
					elseif iter_8_3.id == self._data.cid + 2 then
						var_8_2 = var_8_2 + 1
					elseif iter_8_3.id == self._data.cid + 3 then
						var_8_3 = var_8_3 + 1
					end
				end
			end
		end

		self._control.strengthen_info.level_3.title.num.text.text = var_8_3
		self._control.strengthen_info.level_2.title.num.text.text = var_8_2
		self._control.strengthen_info.level_1.title.num.text.text = var_8_1
		self._control.strengthen_info.level_0.title.num.text.text = var_8_0
	end

	function arg_1_0:__update_reusable_cell()
		local var_9_0 = self:__get_select_data()

		if not var_9_0 and not next(var_9_0) then
			return
		end

		local var_9_1 = self:__sort_table_by_rule((self:__sort_table_by_type(var_9_0)))
		local var_9_2 = {}

		for iter_9_0, iter_9_1 in pairs(var_9_1) do
			if iter_9_1 and iter_9_1.id then
				var_0_6(var_9_2, iter_9_1.id)
			end
		end

		var_0_1:set_tactics_all_select_member_list(var_9_2)
		self._reusable_cell:set_data(var_9_1)

		function self._reusable_cell:_set_func(arg_10_1)
			local var_10_0 = var_0_1:get_character_attribute(var_9_1[arg_10_1 + 1].id)
			local var_10_1 = var_10_0 and var_0_11.little_clone(var_10_0)

			self:__calculate_attribute_by_intensify(var_9_1[arg_10_1 + 1], var_10_1)
			self:__calculate_attribute_by_equips(var_9_1[arg_10_1 + 1], var_10_1)
			self:__add_collections_attr(var_9_1[arg_10_1 + 1], var_10_1)
			self:__add_skill_attr(var_9_1[arg_10_1 + 1], var_10_1)
			self:__add_restaurant_attr(var_9_1[arg_10_1 + 1], var_10_1)
			self:__add_workshop_attr(var_9_1[arg_10_1 + 1], var_10_1)

			var_9_1[arg_10_1 + 1].attrs = var_10_1

			self:set_enter_type(var_0_12.enter_select_member_type.tactics_type, false, nil)
			self:show(var_9_1[arg_10_1 + 1], var_0_12.dock_team_toggle_type.tactics_type, nil, nil, nil, nil, nil)
			self:show_tactics_detail_layer(self._detail_index, var_9_1[arg_10_1 + 1].tactics_exp, self._data.icon)
		end
	end

	function arg_1_0:show_static_study_panel(arg_11_1)
		if not arg_11_1 then
			return
		end

		local var_11_0 = {}
		local var_11_1 = 0

		if arg_11_1.all_tactics and next(arg_11_1.all_tactics) then
			if self:_have_data(arg_11_1.all_tactics, self._data.cid) then
				for iter_11_0, iter_11_1 in ipairs(arg_11_1.all_tactics) do
					if iter_11_1.id == self._data.cid then
						var_11_1 = iter_11_1.exp
					end
				end

				var_11_0 = {
					cid = self._data.cid,
					sid = arg_11_1.id,
					exp = var_11_1,
					state = 0,
					id = self._data.cid
				}
			elseif self:_have_data(arg_11_1.all_tactics, self._data.cid + 1) then
				for iter_11_2, iter_11_3 in ipairs(arg_11_1.all_tactics) do
					if iter_11_3.id == self._data.cid + 1 then
						var_11_1 = iter_11_3.exp
					end
				end

				var_11_0 = {
					cid = self._data.cid + 1,
					sid = arg_11_1.id,
					exp = var_11_1,
					state = 0,
					id = self._data.cid
				}
			elseif self:_have_data(arg_11_1.all_tactics, self._data.cid + 2) then
				for iter_11_4, iter_11_5 in ipairs(arg_11_1.all_tactics) do
					if iter_11_5.id == self._data.cid + 2 then
						var_11_1 = iter_11_5.exp
					end
				end

				var_11_0 = {
					cid = self._data.cid + 2,
					sid = arg_11_1.id,
					exp = var_11_1,
					state = 0,
					id = self._data.cid
				}
			elseif self:_have_data(arg_11_1.all_tactics, self._data.cid + 3) then
				var_11_0 = {
					exp = 500,
					cid = self._data.cid + 3,
					sid = arg_11_1.id,
					state = 0,
					id = self._data.cid
				}
			end
		else
			var_11_0 = {
				cid = self._data.cid,
				sid = self._ship_data.id,
				exp = var_11_1
			}
		end

		var_0_8:createInstance("class_info_view"):show(var_11_0, "tactics_panel", self._now_class, arg_11_1, self._now_teacher)
	end

	function arg_1_0:update_content(arg_12_1)
		self._temporary_data = {}

		self:__load_info_list((self._enter_type == var_0_12.enter_select_member_type.strengthen or self._enter_type == var_0_12.enter_select_member_type.evo or self._enter_type == var_0_12.enter_select_member_type.restaurant or self._enter_type == var_0_12.enter_select_member_type.skill or self._enter_type == var_0_12.enter_select_member_type.six_year_map_select or self._enter_type == var_0_12.enter_select_member_type.abyss_dock_team_formation or self._enter_type == var_0_12.enter_select_member_type.strike_map_select) and self:__filter_fast_all_character_list() or self:__filter_fast_all_character_list(true, arg_12_1))

		if self._enter_type ~= nil and self._enter_type ~= var_0_12.enter_select_member_type.dock_team and self._enter_type ~= var_0_12.enter_select_member_type.dock_team_empty and self._enter_type ~= var_0_12.enter_select_member_type.fight then
			if not var_0_8:getInstance("school") and not var_0_8:getInstance("restaurant") then
				self:__update_edge_mask()
			end
		end

		self:__update_reusable_cell()
	end

	function arg_1_0._have_data(arg_13_0, arg_13_1, arg_13_2)
		for iter_13_0, iter_13_1 in pairs(arg_13_1) do
			if iter_13_1.id == arg_13_2 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__sort_table_by_rule(arg_14_1)
		if self._sort_layer then
			if arg_14_1 and next(arg_14_1) then
				for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
					iter_14_1.ship_index = var_0_13.find_object_by_cid(iter_14_1.cid).ship_index

					for iter_14_2, iter_14_3 in ipairs(iter_14_1.all_tactics) do
						if iter_14_3.id == self._data.cid then
							iter_14_1.tactics_exp = iter_14_3.exp
						elseif iter_14_3.id == self._data.cid + 1 then
							iter_14_1.tactics_exp = iter_14_3.exp + 100
						elseif iter_14_3.id == self._data.cid + 2 then
							iter_14_1.tactics_exp = iter_14_3.exp + 400
						elseif iter_14_3.id == self._data.cid + 3 then
							iter_14_1.tactics_exp = iter_14_3.exp + 900
						end
					end
				end
			end

			return self._sort_layer:sort_table_by_rule(arg_14_1)
		end
	end

	function arg_1_0:sort_layer_toggle_on(arg_15_1, arg_15_2)
		self._sort_layer:change_sort_text(self._control.sort_order_btn.sort_txt, arg_15_1)
		self:__update_reusable_cell()
		self:__update_edge_mask()
	end

	function arg_1_0:type_layer_confirm_btn_on()
		self._type_layer:change_type_text(self._control.sort_type_btn.sort_txt)
		self:__update_reusable_cell()
		self:__update_edge_mask()
	end

	function arg_1_0:get_sort_layer()
		self._sort_layer = self._sort_layer or self:loadUI("sort_layer_2")

		self._sort_layer:show(false)
		self._sort_layer._panel.transform:SetParent(self._control.sort_layer.rectTransform, false)
		self._sort_layer:set_listener(self, self.sort_layer_toggle_on)
	end

	function arg_1_0:__sort_table_by_type(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
		if self._type_layer then
			self._type_layer:set_sort_exclude(arg_18_2)
			self._type_layer:set_target_type_group_state(arg_18_3, arg_18_4)

			if arg_18_1 and next(arg_18_1) and arg_18_1 and next(arg_18_1) then
				for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
					iter_18_1.ship_index = var_0_13.find_object_by_cid(iter_18_1.cid).ship_index

					for iter_18_2, iter_18_3 in ipairs(iter_18_1.all_tactics) do
						if iter_18_3.id == self._data.cid then
							iter_18_1.tactics_exp = iter_18_3.exp
						elseif iter_18_3.id == self._data.cid + 1 then
							iter_18_1.tactics_exp = iter_18_3.exp + 100
						elseif iter_18_3.id == self._data.cid + 2 then
							iter_18_1.tactics_exp = iter_18_3.exp + 400
						elseif iter_18_3.id == self._data.cid + 3 then
							iter_18_1.tactics_exp = iter_18_3.exp + 900
						end
					end
				end
			end

			return self._type_layer:sort_table_by_type(arg_18_1)
		end
	end

	function arg_1_0.is_state(arg_19_0, arg_19_1)
		arg_19_0._is_type = arg_19_1
	end

	function arg_1_0:get_type_layer()
		self._type_layer = self._type_layer or self:loadUI("type_layer")

		self._type_layer:show(false)
		self._type_layer._panel.transform:SetParent(self._control.type_layer.rectTransform, false)
		self._type_layer:set_listener(self, self.type_layer_confirm_btn_on)
	end

	function arg_1_0:__update_edge_mask()
		self._control.all_ship.Viewport.edge_mask.Content.transform.anchoredPosition = Vector2(0, 0)
	end

	function arg_1_0.__calculate_attribute_by_intensify(arg_22_0, arg_22_1, arg_22_2)
		if not arg_22_1.id then
			return
		end

		local var_22_0 = var_0_13.find_object_by_cid(var_0_1:find_character_by_id(arg_22_1.id).cid)
		local var_22_1 = var_0_1:get_character_intensify(arg_22_1.id)

		if var_22_1 then
			for iter_22_0, iter_22_1 in pairs(var_22_1) do
				arg_22_2[iter_22_1.attr] = iter_22_1.attr == "range" and iter_22_1.exp / var_22_0.strengthen_level_up_exp or arg_22_2[iter_22_1.attr] + iter_22_1.exp / var_22_0.strengthen_level_up_exp
			end
		end
	end

	function arg_1_0.__calculate_attribute_by_equips(arg_23_0, arg_23_1, arg_23_2)
		if not arg_23_1.id then
			return
		end

		for iter_23_0, iter_23_1 in pairs(arg_23_1.equips or {}) do
			local var_23_0 = var_0_16.find_object_by_cid(iter_23_1.id)

			if var_23_0 then
				for iter_23_2, iter_23_3 in pairs(var_0_12.equip_attribute) do
					var_23_0[iter_23_3] = var_23_0[iter_23_3] or 0
					arg_23_2[iter_23_3] = arg_23_2[iter_23_3] or 0

					if iter_23_3 == "range" then
						if var_23_0[iter_23_3] > arg_23_2[iter_23_3] then
							arg_23_2[iter_23_3] = var_23_0[iter_23_3] or arg_23_2[iter_23_3]
						end
					else
						arg_23_2[iter_23_3] = arg_23_2[iter_23_3] + var_23_0[iter_23_3]
					end
				end
			end
		end
	end

	function arg_1_0:__add_collections_attr(arg_24_1, arg_24_2)
		if not arg_24_1.id then
			return
		end

		local var_24_0 = var_0_13.find_object_by_cid(arg_24_1.cid)

		if not self._collection_data and not next(self._collection_data) then
			local var_24_1 = var_0_1:get_player_desk_collection_data()

			self._collection_data = var_24_1 and var_0_11.little_clone(var_24_1) or {}
		end

		for iter_24_0, iter_24_1 in pairs(self._collection_data) do
			local var_24_2 = var_0_14.find_object_by_cid(iter_24_1.id)

			if var_24_2 then
				local var_24_3 = string.lower(var_24_2.buff_effect.attr)

				if (var_24_2.buff_effect.ship_type == 0 or var_24_2.buff_effect.ship_type == var_24_0.type) and (var_24_2.buff_effect.country == 0 or var_24_2.buff_effect.country == var_24_0.country) and arg_24_2[var_24_3] then
					arg_24_2[var_24_3] = arg_24_2[var_24_3] + var_24_2.buff_effect.val
				end
			end
		end
	end

	function arg_1_0:__add_restaurant_attr(arg_25_1, arg_25_2)
		if not arg_25_1.id then
			return
		end

		if not next(self._restaurant_buff) then
			local var_25_0 = var_0_1:get_restaurant_cookbook_buff()

			self._restaurant_buff = var_25_0 and var_0_11.little_clone(var_25_0) or {}
		end

		if not self._restaurant_buff.end_time then
			return
		end

		local var_25_1

		if lx.ServerTime:getUtcTime() < self._restaurant_buff.end_time then
			var_25_1 = var_0_19.find_object_by_cid(self._restaurant_buff.id)
		end

		if not var_25_1 then
			return
		end

		local var_25_2 = var_0_13.find_object_by_cid(arg_25_1.cid)

		if not var_25_2 then
			return
		end

		local var_25_3 = var_25_1.effect.attr

		if arg_25_2[var_25_1.effect.attr] and self._restaurant_buff.end_time >= lx.ServerTime:getUtcTime() and (var_25_1.effect.type == 5 or var_25_1.effect.type == 6) then
			local var_25_5 = var_25_1.effect.country or 0
			local var_25_6 = var_25_1.effect.ship_type or 0
			local var_25_7 = var_25_1.effect.ship_ton or 0

			if (var_25_6 == 0 or var_25_6 == var_25_2.type) and (var_25_5 == 0 or var_25_5 == var_25_2.country) and (var_25_7 == 0 or var_25_7 == var_25_2.ship_ton) then
				arg_25_2[var_25_3] = arg_25_2[var_25_3] + var_25_1.effect.value
			end
		end
	end

	function arg_1_0:__add_skill_attr(arg_26_1, arg_26_2)
		if not arg_26_1.id then
			return
		end

		local var_26_0 = var_0_1:get_character_attribute_by_calculate_no_equips(arg_26_1.id)
		local var_26_1 = not arg_26_1.now_skill and var_0_15.find_object_by_skill_id(arg_26_1.skill_id) or var_0_15.find_object_by_skill_type_skill_level(arg_26_1.now_skill, arg_26_1.skill_level)

		if not var_26_1 then
			return
		end

		self._detail_attr_table = {
			"hp",
			"atk",
			"def",
			"torpedo",
			"miss",
			"air_def",
			"capacity",
			nil,
			"antisub",
			"speed",
			"radar",
			"range",
			"luck",
			nil,
			nil,
			"crit",
			"hit",
			nil,
			"ext"
		}

		local var_26_2
		local var_26_3

		if var_26_1.effect[1] then
			for iter_26_0, iter_26_1 in pairs(var_26_1.effect) do
				if var_26_1.effect[iter_26_0].type == 1 and var_26_1.effect[iter_26_0].stage[1] == 1 then
					for iter_26_2, iter_26_3 in pairs(var_26_1.effect[iter_26_0].effect) do
						if iter_26_3.type == 3 then
							for iter_26_4, iter_26_5 in pairs(self._detail_attr_table) do
								if iter_26_3[self._detail_attr_table[iter_26_4]] then
									var_26_2 = self._detail_attr_table[iter_26_4]
									var_26_3 = iter_26_3[self._detail_attr_table[iter_26_4]]
								end
							end

							if var_26_2 and var_26_3 and arg_26_2[var_26_2] then
								var_26_3 = var_26_3 * var_0_11.get_attr_multiple_by_config(var_26_1, arg_26_1, iter_26_0)
								arg_26_2[var_26_2] = arg_26_2[var_26_2] + var_26_3
							end
						elseif iter_26_3.type == 4 then
							for iter_26_6, iter_26_7 in pairs(iter_26_3) do
								if iter_26_6 ~= "type" then
									arg_26_2[iter_26_6] = arg_26_2[iter_26_6] or 1
									arg_26_2[iter_26_6] = arg_26_2[iter_26_6] + arg_26_2[iter_26_6] * iter_26_7
								end
							end
						elseif iter_26_3.type == 5 then
							if arg_26_2[self._detail_attr_table[iter_26_3.attribute]] and arg_26_2[self._detail_attr_table[iter_26_3.attribute2]] then
								arg_26_2[self._detail_attr_table[iter_26_3.attribute2]] = arg_26_2[self._detail_attr_table[iter_26_3.attribute2]] + arg_26_2[self._detail_attr_table[iter_26_3.attribute]] * iter_26_3.rate
							end
						elseif iter_26_3.type == 94 then
							if arg_26_2.range >= iter_26_3.num then
								arg_26_2.range = arg_26_2.range or iter_26_3.num
							end
						elseif iter_26_3.type == 49 then
							for iter_26_8, iter_26_9 in ipairs(arg_26_1.equips) do
								local var_26_5 = var_0_16.find_object_by_cid(iter_26_9.id)

								if var_26_5 then
									for iter_26_10, iter_26_11 in pairs(var_26_5) do
										if arg_26_2[iter_26_10] and iter_26_11 ~= 0 and iter_26_10 ~= "range" and iter_26_10 ~= "hp" then
											arg_26_2[iter_26_10] = arg_26_2[iter_26_10] + iter_26_11 * iter_26_3.rate
										end
									end
								end
							end
						elseif iter_26_3.type == 50 then
							for iter_26_12, iter_26_13 in ipairs(arg_26_1.equips) do
								if iter_26_13.id > 0 then
									local var_26_6 = var_0_16.find_object_by_cid(iter_26_13.id)

									if arg_26_2[self._detail_attr_table[iter_26_3.attribute]] and var_26_6[self._detail_attr_table[iter_26_3.attribute]] and arg_26_2[self._detail_attr_table[iter_26_3.attribute2]] then
										arg_26_2[self._detail_attr_table[iter_26_3.attribute2]] = arg_26_2[self._detail_attr_table[iter_26_3.attribute2]] + var_26_6[self._detail_attr_table[iter_26_3.attribute]] * iter_26_3.rate
									end
								end
							end
						elseif iter_26_3.type == 51 then
							local var_26_7 = 0

							for iter_26_14, iter_26_15 in ipairs(arg_26_1.equips) do
								for iter_26_16, iter_26_17 in pairs(iter_26_3.equipment_type) do
									if iter_26_15.id > 0 and var_0_16.find_object_by_cid(iter_26_15.id).type == iter_26_17 then
										var_26_7 = var_26_7 + 1
									end
								end
							end

							for iter_26_18, iter_26_19 in pairs(iter_26_3) do
								if arg_26_2[iter_26_18] then
									arg_26_2[iter_26_18] = arg_26_2[iter_26_18] + iter_26_19 * var_26_7

									break
								end
							end
						elseif iter_26_3.type == 52 then
							for iter_26_20, iter_26_21 in ipairs(arg_26_1.equips) do
								for iter_26_22, iter_26_23 in pairs(iter_26_3.equipment_type) do
									local var_26_8 = var_0_16.find_object_by_cid(iter_26_21.id)

									if iter_26_21.id > 0 and var_26_8.type == iter_26_23 then
										for iter_26_24, iter_26_25 in pairs(iter_26_3) do
											if arg_26_2[iter_26_24] and var_26_8[iter_26_24] then
												arg_26_2[iter_26_24] = arg_26_2[iter_26_24] + var_26_8[iter_26_24] * iter_26_3[iter_26_24]
											end
										end
									end
								end
							end
						elseif iter_26_3.type == 54 then
							for iter_26_26, iter_26_27 in ipairs(arg_26_1.equips) do
								if iter_26_27.id > 0 then
									for iter_26_28, iter_26_29 in pairs(iter_26_3.equipment_type) do
										local var_26_9 = var_0_16.find_object_by_cid(iter_26_27.id)

										if iter_26_27.id > 0 and var_26_9.type == iter_26_3.equipment_type then
											for iter_26_30, iter_26_31 in pairs(iter_26_3) do
												if arg_26_2[self._detail_attr_table[iter_26_3.attribute]] and var_26_9[self._detail_attr_table[iter_26_3.attribute]] and arg_26_2[self._detail_attr_table[iter_26_3.attribute2]] then
													arg_26_2[self._detail_attr_table[iter_26_3.attribute2]] = arg_26_2[self._detail_attr_table[iter_26_3.attribute2]] + var_26_9[self._detail_attr_table[iter_26_3.attribute]] * iter_26_3.rate

													break
												end
											end
										end
									end
								end
							end
						elseif iter_26_3.type == 131 then
							local var_26_10

							if var_26_0[self._detail_attr_table[iter_26_3.attribute]] then
								var_26_10 = var_0_11.attr_impact_by_speed(var_26_0.speed, var_26_0[self._detail_attr_table[iter_26_3.attribute]], iter_26_3.num1, iter_26_3.num2) - var_26_0[self._detail_attr_table[iter_26_3.attribute]]
							end

							if var_26_10 then
								arg_26_2[self._detail_attr_table[iter_26_3.attribute]] = arg_26_2[self._detail_attr_table[iter_26_3.attribute]] + var_26_10
							end
						end
					end
				end
			end
		end
	end

	function arg_1_0:__add_workshop_attr(arg_27_1, arg_27_2)
		if not arg_27_1.id then
			return
		end

		if not next(self._workdata) then
			local var_27_0 = var_0_1:get_workshop_data()

			self._workdata = var_27_0 and var_0_11.little_clone(var_27_0) or {}
		end

		local var_27_1 = var_0_13.find_object_by_cid(arg_27_1.cid)

		for iter_27_0, iter_27_1 in pairs(self._workdata) do
			local var_27_2 = var_0_17.find_object_by_id(iter_27_1.id).effect[1]

			if var_27_2.shipTypes then
				for iter_27_2, iter_27_3 in pairs(var_27_2.shipTypes) do
					if var_27_2.shipTypes[iter_27_2] == var_27_1.type then
						local var_27_3 = var_0_12:get_attr_name(var_27_2.num4)

						if var_27_2.type == var_0_12.workshop_const.work_type.add_attribute and arg_27_2[var_27_3] then
							if var_27_2.countrys then
								for iter_27_4, iter_27_5 in pairs(var_27_2.countrys) do
									if iter_27_5 == var_27_1.country then
										arg_27_2[var_27_3] = arg_27_2[var_27_3] + var_27_2.num
									end
								end
							else
								arg_27_2[var_27_3] = arg_27_2[var_27_3] + var_27_2.num
							end
						elseif var_27_2.type == var_0_12.workshop_const.work_type.add_torpedo_damage and arg_27_2[var_27_3] and var_27_1[var_27_3] ~= 0 then
							arg_27_2[var_27_3] = arg_27_2[var_27_3] + var_27_2.num
						end
					end
				end
			end
		end
	end

	function arg_1_0.__get_study_show_state(arg_28_0, arg_28_1)
		local var_28_0 = 0

		if arg_28_1 >= var_0_12.college_const.attack_level then
			var_28_0 = 1
		end

		if arg_28_1 >= var_0_12.college_const.defense_level then
			var_28_0 = 2
		end

		return (arg_28_1 >= var_0_12.college_const.special_level or nil) and 3
	end

	function arg_1_0:_play_into_se(arg_29_1)
		self:playSE(arg_29_1, false)
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0:__initia_lize()
		arg_1_0._data = nil
		arg_1_0._reusable_cell = nil
		arg_1_0._data_by_type = nil
		arg_1_0._workdata = {}
		arg_1_0._collection_data = {}
		arg_1_0._restaurant_buff = {}
		arg_1_0._detail_index = 1

		if self._sort_layer then
			self._sort_layer:destroy()
		end

		if self._type_layer then
			self._type_layer:destroy()
		end

		self._sort_layer = nil
		self._type_layer = nil
		arg_1_0._now_teacher = 1
		arg_1_0._now_class = 1
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_32_0)
	local var_32_0 = var_0_8:class("tactics_select_member")

	var_32_0:__initia_lize()

	var_32_0._data = nil
	var_32_0._reusable_cell = nil
	var_32_0._data_by_type = nil
	var_32_0._workdata = {}
	var_32_0._collection_data = {}
	var_32_0._restaurant_buff = {}
	var_32_0._detail_index = 1
	var_32_0._now_teacher = 1
	var_32_0._now_class = 1

	return var_32_0
end

return var_0_0
