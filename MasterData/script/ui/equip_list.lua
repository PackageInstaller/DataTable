local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gameconfig.equip_config
local var_0_4 = gameconfig.ship_config
local var_0_5 = gameenum.common_type
local var_0_6 = gamecore.util_func
local var_0_7 = string.format
local var_0_8 = table.sort
local var_0_9 = table.insert
local var_0_10 = table.remove
local var_0_11 = gamecore.user
local var_0_12 = gamecore.prompt
local var_0_13 = string.find

gamecore.UILoader:define("equip_list", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3)
		self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.open))
		self:setVisible(true)

		self._ship_data = arg_2_1
		self._ship_conf = var_0_4.find_object_by_cid(arg_2_1.cid)
		self._data = arg_2_2
		self._index = arg_2_3

		self:__init_panel()
	end

	function arg_1_0:hide()
		self:setVisible(false)

		local var_3_0 = var_0_2:getInstance("ship_detail")

		if var_3_0 then
			var_3_0:setVisible(true)
			var_3_0:update_data()
		end
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:update_data(arg_5_1)
		self:init_equip_data()
		self:__show_capacity()
		self:__update_cell_list(arg_5_1)
	end

	function arg_1_0:get_new_equip_list(arg_6_1, arg_6_2)
		local var_6_0 = {}

		self._no_load_list = {}

		for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
			for iter_6_2, iter_6_3 in pairs(self._type_toggle_data) do
				local var_6_1 = false
				local var_6_2 = var_0_3.find_object_by_cid(iter_6_1.id)

				if var_6_2 then
					if iter_6_2 == "all" and iter_6_3 then
						var_6_1 = true
					elseif iter_6_2 == "missile_launcher" then
						if var_0_5.equip_type.anti_ship_missile_launcher == var_6_2.type or var_0_5.equip_type.air_defense_missile_launcher == var_6_2.type then
							var_6_1 = true
						end
					elseif iter_6_2 == "missile" then
						if var_0_5.equip_type.anti_ship_missile == var_6_2.type or var_0_5.equip_type.air_defense_missile == var_6_2.type then
							var_6_1 = true
						end
					elseif var_0_5.equip_type[iter_6_2] == var_6_2.type then
						var_6_1 = true
					end

					local var_6_3 = var_0_4.find_object_by_cid(self._ship_data.cid)
					local var_6_4 = var_0_6.have_data(var_6_2.ship_type, self._ship_data.type) and var_0_6.have_data(var_6_3.equipment_type, var_6_2.bore_type)
					local var_6_5 = 0
					local var_6_6

					if var_0_5.equip_plane_type[var_6_2.type] then
						var_6_5 = self._ship_conf.capacity_slot[self._index] or 0
						var_6_6 = true
					elseif var_0_5.equip_missile_type[var_6_2.type] then
						var_6_5 = self._ship_conf.missile_slot[self._index] or 0
						var_6_6 = true
					end

					if var_6_1 then
						if var_6_4 or arg_6_2 then
							if var_6_6 then
								if var_6_5 > 0 or not var_6_4 and arg_6_2 then
									var_0_9(var_6_0, iter_6_1)
								else
									var_0_9(self._no_load_list, iter_6_1)
								end
							elseif (var_6_2.ship_country and next(var_6_2.ship_country) and not var_0_6.have_data(var_6_2.ship_country, var_6_3.country) or nil) and true then
								var_0_9(self._no_load_list, iter_6_1)
							else
								var_0_9(var_6_0, iter_6_1)
							end
						else
							var_0_9(self._no_load_list, iter_6_1)
						end
					end
				end
			end
		end

		return var_6_0
	end

	function arg_1_0:_add_new_not_ship_equip(arg_7_1)
		local var_7_0 = {}
		local var_7_1 = var_0_2:getInstance("equip_sort_layer")

		if var_7_1 then
			for iter_7_0, iter_7_1 in pairs(self._no_load_list) do
				local var_7_2 = var_0_3.find_object_by_cid(iter_7_1.id)

				var_7_2.num = iter_7_1.num
				var_7_2.lock = iter_7_1.lock
				var_7_2.id = iter_7_1.id

				table.insert(var_7_0, var_7_2)
			end

			var_7_1:sort_ship_equip_info_list(var_7_0)
		else
			for iter_7_2, iter_7_3 in pairs(self._no_load_list) do
				table.insert(var_7_0, iter_7_3)
			end

			self:__init_equip_sort(var_7_0)
		end

		for iter_7_4, iter_7_5 in pairs(var_7_0) do
			var_0_9(arg_7_1, iter_7_5)
		end

		var_0_11:set_now_equip_list(arg_7_1)
	end

	function arg_1_0:__sort_table_by_rule(arg_8_1)
		if not arg_8_1 then
			return
		end

		local var_8_0 = var_0_2:getInstance("equip_type_layer")

		if self._sort_type_num and var_8_0 then
			return var_8_0:sort_table_by_rule(var_8_0._sort_type_num)
		else
			return arg_8_1
		end
	end

	function arg_1_0:get_equip_effect_list(arg_9_1)
		local var_9_0 = {}

		for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
			local var_9_1 = false

			for iter_9_2, iter_9_3 in pairs(self._effect_toggle_data) do
				local var_9_2 = var_0_3.find_object_by_cid(iter_9_1.id)

				if iter_9_2 == "all" and iter_9_3 then
					var_9_1 = true
				elseif iter_9_2 == "attack" then
					if var_0_6.have_data(var_9_2.effect_type, 1) then
						var_9_1 = true
					end
				elseif iter_9_2 == "extra_damage" then
					if var_0_6.have_data(var_9_2.effect_type, 2) then
						var_9_1 = true
					end
				elseif iter_9_2 == "exp_up" then
					if var_0_6.have_data(var_9_2.effect_type, 3) then
						var_9_1 = true
					end
				elseif iter_9_2 == "armor_pene" then
					if var_0_6.have_data(var_9_2.effect_type, 4) then
						var_9_1 = true
					end
				elseif iter_9_2 == "expedition_resource" then
					if var_0_6.have_data(var_9_2.effect_type, 5) then
						var_9_1 = true
					end
				elseif iter_9_2 == "hit_rate" then
					if var_0_6.have_data(var_9_2.effect_type, 6) then
						var_9_1 = true
					end
				elseif iter_9_2 == "miss" then
					if var_0_6.have_data(var_9_2.effect_type, 7) then
						var_9_1 = true
					end
				elseif iter_9_2 == "critical_rate" then
					if var_0_6.have_data(var_9_2.effect_type, 8) then
						var_9_1 = true
					end
				elseif iter_9_2 == "anti_air" then
					if var_0_6.have_data(var_9_2.effect_type, 9) then
						var_9_1 = true
					end
				elseif iter_9_2 == "atk_top" and var_0_6.have_data(var_9_2.effect_type, 10) then
					var_9_1 = true
				end
			end

			if var_9_1 then
				var_0_9(var_9_0, iter_9_1)
			end
		end

		return var_9_0
	end

	function arg_1_0:init_equip_data()
		local var_10_0 = {}

		for iter_10_0, iter_10_1 in pairs((var_0_11:get_equipment_list())) do
			var_0_9(var_10_0, iter_10_1)
		end

		self:__init_equip_sort(var_10_0)

		self._equip_data = var_10_0
	end

	function arg_1_0.__equip_data_sort(arg_11_0, arg_11_1)
		var_0_8(arg_11_1, function(arg_12_0, arg_12_1)
			return var_0_3.find_object_by_cid(arg_12_0.id).type < var_0_3.find_object_by_cid(arg_12_1.id).type
		end)
		var_0_8(arg_11_1, function(arg_13_0, arg_13_1)
			return var_0_3.find_object_by_cid(arg_13_0.id).star > var_0_3.find_object_by_cid(arg_13_1.id).star
		end)
		var_0_8(arg_11_1, function(arg_14_0, arg_14_1)
			return var_0_3.find_object_by_cid(arg_14_0.id).cid < var_0_3.find_object_by_cid(arg_14_1.id).cid
		end)
	end

	function arg_1_0:__filter_table_by_name(arg_15_1)
		local var_15_0 = {}

		if not self._filter_name then
			return arg_15_1
		end

		for iter_15_0, iter_15_1 in pairs(arg_15_1) do
			if var_0_6.name_filter_match(var_0_3.find_object_by_cid(iter_15_1.id).title, self._filter_name) then
				var_0_9(var_15_0, iter_15_1)
			end
		end

		if self._filter_name ~= nil then
			for iter_15_2, iter_15_3 in pairs(self._equiped_list) do
				if var_0_6.name_filter_match(var_0_3.find_object_by_cid(iter_15_3.id).title, self._filter_name) then
					var_0_9(var_15_0, iter_15_3)
				end
			end
		end

		self._equiped_list = {}

		local var_15_1 = var_0_2:getInstance("equip_sort_layer")

		if var_15_0 and next(var_15_0) then
			for iter_15_4, iter_15_5 in pairs(var_15_0) do
				local var_15_2 = var_0_3.find_object_by_cid(iter_15_5.id)

				iter_15_5.type = var_15_2.type
				iter_15_5.star = var_15_2.star
				iter_15_5.hp = var_15_2.hp
				iter_15_5.atk = var_15_2.atk
				iter_15_5.def = var_15_2.def
				iter_15_5.torpedo = var_15_2.torpedo
				iter_15_5.miss = var_15_2.miss
				iter_15_5.air_def = var_15_2.air_def
				iter_15_5.antisub = var_15_2.antisub
				iter_15_5.aircraft_atk = var_15_2.aircraft_atk
				iter_15_5.radar = var_15_2.radar
				iter_15_5.luck = var_15_2.luck
				iter_15_5.hit = var_15_2.hit
				iter_15_5.missile_hit = var_15_2.missile_hit
				iter_15_5.missile_tmd = var_15_2.missile_tmd
				iter_15_5.aluminium_use = var_15_2.aluminium_use
				iter_15_5.air_def_correct = var_15_2.air_def_correct
				iter_15_5.air_def_rate = var_15_2.air_def_rate
				iter_15_5.cid = iter_15_5.id
			end
		end

		if var_15_1 and self._sort_type_num ~= 1 and self._sort_type ~= 2 then
			var_15_1:sort_ship_equip_info_list(var_15_0)
		end

		return var_15_0
	end

	function arg_1_0:__filter_table(arg_16_1)
		local var_16_0 = {}

		if arg_16_1 and (self._equip_type_set and self._equip_type_set == 0 or not self._equip_type_set) and not self._filter_name then
			for iter_16_0, iter_16_1 in pairs(arg_16_1) do
				local var_16_1 = var_0_3.find_object_by_cid(iter_16_1.id)

				var_0_9(var_16_0, iter_16_1)
			end
		elseif arg_16_1 and self._equip_type_set and self._equip_type_set ~= 0 and not self._filter_name then
			for iter_16_2, iter_16_3 in pairs(arg_16_1) do
				if iter_16_3.id > 0 then
					local var_16_2 = var_0_3.find_object_by_cid(iter_16_3.id)

					if var_0_5.equip_type.anti_ship_missile_launcher == self._equip_type_set then
						if var_16_2.type == self._equip_type_set then
							var_0_9(var_16_0, iter_16_3)
						end

						if var_16_2.type == var_0_5.equip_type.air_defense_missile_launcher then
							var_0_9(var_16_0, iter_16_3)
						end
					elseif var_0_5.equip_type.anti_ship_missile == self._equip_type_set then
						if var_16_2.type == self._equip_type_set then
							var_0_9(var_16_0, iter_16_3)
						end

						if var_16_2.type == var_0_5.equip_type.air_defense_missile then
							var_0_9(var_16_0, iter_16_3)
						end
					elseif var_16_2.type == self._equip_type_set then
						var_0_9(var_16_0, iter_16_3)
					end
				end
			end
		elseif arg_16_1 and not self._equip_type_set and self._filter_name then
			if self._filter_name ~= nil then
				for iter_16_4, iter_16_5 in pairs(arg_16_1) do
					if var_0_6.name_filter_match(var_0_3.find_object_by_cid(iter_16_5.id).title, self._filter_name) then
						var_0_9(var_16_0, iter_16_5)
					end
				end
			end
		elseif arg_16_1 and self._equip_type_set and self._equip_type_set ~= 0 and self._filter_name then
			for iter_16_6, iter_16_7 in pairs(arg_16_1) do
				if iter_16_7.id > 0 then
					local var_16_3 = var_0_3.find_object_by_cid(iter_16_7.id)

					if var_16_3.type == self._equip_type_set and var_0_6.name_filter_match(var_16_3.title, self._filter_name) then
						var_0_9(var_16_0, iter_16_7)
					end
				end
			end
		end

		self._equiped_list = {}

		local var_16_4 = var_0_2:getInstance("equip_sort_layer")

		if var_16_0 and next(var_16_0) then
			for iter_16_8, iter_16_9 in pairs(var_16_0) do
				local var_16_5 = var_0_3.find_object_by_cid(iter_16_9.id)

				iter_16_9.type = var_16_5.type
				iter_16_9.star = var_16_5.star
				iter_16_9.hp = var_16_5.hp
				iter_16_9.atk = var_16_5.atk
				iter_16_9.def = var_16_5.def
				iter_16_9.torpedo = var_16_5.torpedo
				iter_16_9.miss = var_16_5.miss
				iter_16_9.air_def = var_16_5.air_def
				iter_16_9.antisub = var_16_5.antisub
				iter_16_9.aircraft_atk = var_16_5.aircraft_atk
				iter_16_9.radar = var_16_5.radar
				iter_16_9.luck = var_16_5.luck
				iter_16_9.hit = var_16_5.hit
				iter_16_9.missile_hit = var_16_5.missile_hit
				iter_16_9.missile_tmd = var_16_5.missile_tmd
				iter_16_9.aluminium_use = var_16_5.aluminium_use
				iter_16_9.air_def_correct = var_16_5.air_def_correct
				iter_16_9.air_def_rate = var_16_5.air_def_rate
				iter_16_9.cid = iter_16_9.id
			end
		end

		if var_16_4 and self._sort_type_num ~= 1 and self._sort_type ~= 2 then
			var_16_4:sort_ship_equip_info_list(var_16_0)
		end

		return var_16_0
	end

	function arg_1_0.type_layer_listener(arg_17_0, arg_17_1)
		arg_17_0._type_layer_callback = arg_17_1
	end

	function arg_1_0.set_can_lock_seq(arg_18_0)
		arg_18_0._can_lock_seq = true
	end

	function arg_1_0:__update_search_name()
		self._filter_name = nil
		self._control.equip_content.search.inputField.text = ""
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
			self:__init_cell()
		end

		self._need_revert = true
		self._filter_name = nil
		self._control.equip_content.search.inputField.text = ""
		self._is_change = true
		self._control.equip_content.change_lock_btn.title.text.text = var_0_1:getNowLang("clockequip")

		self:update_data()
		self:set_can_lock_seq()
		var_0_5:play_in_out_animation(self._control.bg_container.uITweenSequence, true)

		self._is_already_init = true
		self._equiped_list = {}

		self:update_equip_input_field()

		local var_20_0 = var_0_11:get_show_panel_equip_state()

		if var_20_0 then
			self:_show_already_use_equip(var_20_0)
		end
	end

	function arg_1_0:update_equip_input_field()
		self._control.equip_content.search.inputField.onEndEdit:AddListener(function()
			self._filter_name = self._control.equip_content.search.inputField.text

			if self._filter_name ~= "" then
				local var_22_0, var_22_1 = var_0_13(self._filter_name, "%(")

				if var_22_0 ~= nil and var_22_1 ~= nil then
					self._filter_name = var_0_6._str_insert(self._filter_name, var_22_0, "%")
				end

				local var_22_2, var_22_3 = var_0_13(self._filter_name, "%%")

				if var_22_2 ~= nil and var_22_3 ~= nil then
					self._filter_name = var_0_6._str_insert(self._filter_name, var_22_2, "%")
				end

				local var_22_4, var_22_5 = var_0_13(self._filter_name, "%[")

				if var_22_4 ~= nil and var_22_5 ~= nil then
					self._filter_name = var_0_6._str_insert(self._filter_name, var_22_4, "%")
				end

				local var_22_6, var_22_7 = var_0_13(self._filter_name, "%]")

				if var_22_6 ~= nil and var_22_7 ~= nil then
					self._filter_name = var_0_6._str_insert(self._filter_name, var_22_6, "%")
				end

				local var_22_8, var_22_9 = var_0_13(self._filter_name, "%-")

				if var_22_8 ~= nil and var_22_9 ~= nil then
					self._filter_name = var_0_6._str_insert(self._filter_name, var_22_8, "%")
				end

				if self._is_use_equip then
					self:set_ship_equip_info(true)
					self:_show_already_use_equip(true)
				else
					self:__update_cell_list()
				end
			elseif self._is_use_equip then
				self:_show_already_use_equip(true)
			else
				self:__update_cell_list()
			end
		end)
	end

	function arg_1_0:set_ship_equip_info(arg_23_1)
		for iter_23_0, iter_23_1 in pairs((var_0_11:get_character_list())) do
			for iter_23_2, iter_23_3 in ipairs(iter_23_1.equips) do
				if iter_23_3.id ~= 0 then
					local var_23_0 = var_0_3.find_object_by_cid(iter_23_3.id)

					if self._equip_type_set and self._equip_type_set ~= 0 then
						if self._equip_type_set == var_0_5.equip_type.anti_ship_missile then
							if (var_23_0.type == var_0_5.equip_type.anti_ship_missile or var_23_0.type == var_0_5.equip_type.air_defense_missile) and var_0_6.name_filter_match(var_23_0.title, self._filter_name) then
								local var_23_1 = iter_23_3 and var_0_6.little_clone(iter_23_3) or {}

								var_23_1.ship_id = iter_23_1.id
								var_23_1.equip_index = iter_23_2
								var_23_1.lock = false

								var_0_9(self._equiped_list, var_23_1)
							end
						elseif self._equip_type_set == var_0_5.equip_type.anti_ship_missile_launcher then
							if (var_23_0.type == var_0_5.equip_type.anti_ship_missile_launcher or var_23_0.type == var_0_5.equip_type.air_defense_missile_launcher) and var_0_6.name_filter_match(var_23_0.title, self._filter_name) then
								local var_23_2 = iter_23_3 and var_0_6.little_clone(iter_23_3) or {}

								var_23_2.ship_id = iter_23_1.id
								var_23_2.equip_index = iter_23_2
								var_23_2.lock = false

								var_0_9(self._equiped_list, var_23_2)
							end
						elseif var_23_0.type == self._equip_type_set and var_0_6.name_filter_match(var_23_0.title, self._filter_name) then
							local var_23_3 = iter_23_3 and var_0_6.little_clone(iter_23_3) or {}

							var_23_3.ship_id = iter_23_1.id
							var_23_3.equip_index = iter_23_2
							var_23_3.lock = false

							var_0_9(self._equiped_list, var_23_3)
						end
					elseif arg_23_1 then
						if var_0_6.name_filter_match(var_23_0.title, self._filter_name) then
							local var_23_4 = iter_23_3 and var_0_6.little_clone(iter_23_3) or {}

							var_23_4.ship_id = iter_23_1.id
							var_23_4.equip_index = iter_23_2
							var_23_4.lock = false

							var_0_9(self._equiped_list, var_23_4)
						end
					else
						local var_23_5 = iter_23_3 and var_0_6.little_clone(iter_23_3) or {}

						var_23_5.ship_id = iter_23_1.id
						var_23_5.equip_index = iter_23_2
						var_23_5.lock = false

						var_0_9(self._equiped_list, var_23_5)
					end
				end
			end
		end

		return self._equiped_list
	end

	function arg_1_0:show_input_equip()
		if self._filter_name and self._filter_name ~= "" then
			local var_24_0, var_24_1 = var_0_13(self._filter_name, "%(")

			if var_24_0 ~= nil and var_24_1 ~= nil then
				self._filter_name = var_0_6._str_insert(self._filter_name, var_24_0, "%")
			end

			local var_24_2, var_24_3 = var_0_13(self._filter_name, "%%")

			if var_24_2 ~= nil and var_24_3 ~= nil then
				self._filter_name = var_0_6._str_insert(self._filter_name, var_24_2, "%")
			end

			local var_24_4, var_24_5 = var_0_13(self._filter_name, "%[")

			if var_24_4 ~= nil and var_24_5 ~= nil then
				self._filter_name = var_0_6._str_insert(self._filter_name, var_24_4, "%")
			end

			local var_24_6, var_24_7 = var_0_13(self._filter_name, "%]")

			if var_24_6 ~= nil and var_24_7 ~= nil then
				self._filter_name = var_0_6._str_insert(self._filter_name, var_24_6, "%")
			end

			local var_24_8, var_24_9 = var_0_13(self._filter_name, "%-")

			if var_24_8 ~= nil and var_24_9 ~= nil then
				self._filter_name = var_0_6._str_insert(self._filter_name, var_24_8, "%")
			end

			if self._is_use_equip then
				self:set_ship_equip_info(true)
			end

			self:__update_cell_list()
		elseif self._is_use_equip then
			self:_show_already_use_equip(true)
		else
			self:__update_cell_list()
		end
	end

	function arg_1_0:set_equip_input_fidle()
		if self._filter_name and self._filter_name ~= "" then
			for iter_25_0, iter_25_1 in pairs((var_0_11:get_character_list())) do
				for iter_25_2, iter_25_3 in ipairs(iter_25_1.equips) do
					if iter_25_3.id ~= 0 and var_0_6.name_filter_match(var_0_3.find_object_by_cid(iter_25_3.id).title, self._filter_name) then
						local var_25_0 = iter_25_3 and var_0_6.little_clone(iter_25_3) or {}

						var_25_0.ship_id = iter_25_1.id
						var_25_0.equip_index = iter_25_2
						var_25_0.lock = false

						var_0_9(self._equiped_list, var_25_0)
					end
				end
			end

			local var_25_1 = var_0_2:getInstance("equip_sort_layer")

			self:__init_equip_sort(self._equiped_list)
		end

		self:__update_cell_list()
	end

	function arg_1_0:set_equip_input_fidle_type_out()
		if self._filter_name and self._filter_name ~= "" then
			if self._is_use_equip then
				self:set_ship_equip_info(true)
			end

			local var_26_0 = var_0_2:getInstance("equip_sort_layer")

			self:__init_equip_sort(self._equiped_list)
		end
	end

	function arg_1_0:__init_language()
		gamecore.util_func.setTextHorizonInfo(self._control.desc.desc_text_mask, var_0_1:getNowLang("equipment_lock_tip1"))

		self._control.bg_container.tip_title.text.text = var_0_1:getNowLang("changeequip")
		self._control.equip_content.equip_capacity.dockcapacity.text.text = var_0_1:getNowLang("ui_equipcounttip")
		self._control.equip_content.type_btn.type.text.text = var_0_1:getNowLang("ui_collectionviewtip")
		self._control.equip_content.type_btn.type_txt.text.text = var_0_1:getNowLang("equip0")
		self._control.equip_content.sort_type_btn.type.text.text = var_0_1:getNowLang("sorttype")
		self._control.equip_content.sort_type_btn.type_txt.text.text = var_0_1:getNowLang("type") .. var_0_1:getNowLang("arrow_up")
		self._control.equip_content.show_use_btn.show_use_btn_btn.text.text = self._is_use_equip and var_0_1:getNowLang("display_use") or var_0_1:getNowLang("hidden_use")
	end

	function arg_1_0:__init_cell()
		if self._already_init then
			return
		end

		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.equip_content.all_equip.viewport.content.endlessScrollView, self._control.equip_content.all_equip.viewport.content, "single_equip", "equip_list")

		self._reusable_cell:init()

		self._already_init = true
	end

	function arg_1_0:reset_scroll_view()
		self._control.equip_content.all_equip.viewport.content.rectTransform.anchoredPosition = Vector2(0, 0)
	end

	function arg_1_0:__update_cell_list(arg_30_1)
		if self._equip_data[1] == " " then
			var_0_10(self._equip_data, 1)
		end

		self:update_sort_info()

		local var_30_0 = {}
		local var_30_2 = var_0_2:getInstance("equip_sort_layer")

		for iter_30_0, iter_30_1 in pairs((self:get_new_equip_list(self._equip_data))) do
			local var_30_3 = var_0_3.find_object_by_cid(iter_30_1.id)

			var_30_3.num = iter_30_1.num
			var_30_3.lock = iter_30_1.lock
			var_30_3.id = iter_30_1.id

			table.insert(var_30_0, var_30_3)
		end

		if var_30_2 and var_30_2._equip_list and next(var_30_2._equip_list) then
			var_30_2:sort_ship_equip_info_list(var_30_0)
		end

		self:_add_new_not_ship_equip(var_30_0)

		local var_30_4 = self:get_equip_effect_list(var_30_0)

		if self._filter_name then
			var_30_4 = self:__filter_table_by_name(var_30_4)

			if #var_30_4 == 0 and #self._equiped_list == 0 then
				var_0_12:show(var_0_1:getNowLang("noequipsearched"))
			end
		end

		if self._data and self._is_change and var_30_4[1] ~= " " then
			var_0_9(var_30_4, 1, " ")
		end

		if arg_30_1 then
			self._reusable_cell:set_data(var_30_4, true)
		else
			self._reusable_cell:set_data(var_30_4)
		end

		function self._reusable_cell:_set_func(arg_31_1)
			local var_31_0 = var_0_3.find_object_by_cid(var_30_4[arg_31_1 + 1].id)
			local var_31_2 = false

			if var_30_4[arg_31_1 + 1] ~= " " then
				for iter_31_0, iter_31_1 in pairs(var_30_4[arg_31_1 + 1]) do
					if iter_31_0 == "ship_id" then
						var_31_2 = true

						break
					end
				end
			end

			local var_31_3 = self:__have_data(self._no_load_list, var_30_4[arg_31_1 + 1].id)

			if var_31_2 then
				self.info_layer.gray_bg:SetActive(true)
				self.info_layer.equip_bg:SetActive(true)

				self.info_layer.equip_bg.ship_name.shipname.text.text = var_0_11:find_character_by_id(var_30_4[arg_31_1 + 1].ship_id).name

				self.info_layer.equip_bg.ship_name.textHorizonScroller:SetText(var_0_11:find_character_by_id(var_30_4[arg_31_1 + 1].ship_id).name)

				self.info_layer.icon_layer.count.text.text = ""

				self.info_layer.detail_btn:SetActive(true)
				self.info_layer.detail_btn.button.onClick:RemoveAllListeners()
				self.info_layer.detail_btn.button.onClick:AddListener(function()
					self:__show_equip_att(self.info_layer, var_31_0)
				end)
			else
				self.info_layer.icon_layer.count.text.text = var_30_4[arg_31_1 + 1].num

				self.info_layer.gray_bg:SetActive(var_31_3)
				self.info_layer.equip_bg:SetActive(false)
				self.info_layer.detail_btn:SetActive(true)
				self.info_layer.detail_btn.button.onClick:RemoveAllListeners()
				self.info_layer.detail_btn.button.onClick:AddListener(function()
					self:__show_equip_att(self.info_layer, var_31_0)
				end)
			end

			if arg_31_1 == 0 and var_30_4[1] == " " then
				self.select_layer:SetActive(true)

				self.select_layer.takeoff_btn.image.sprite = self:loadSprite(var_0_5.equip_list.ship_equip_take_off)

				self.info_layer:SetActive(false)
				self.select_layer.takeoff_btn.button.onClick:RemoveAllListeners()
				self.select_layer.takeoff_btn.button.onClick:AddListener(function()
					if self:__station_state_return() then
						return
					end

					local var_34_0 = {
						id = self._ship_data.id,
						pos = self._index
					}
					local var_34_1 = var_0_3.find_object_by_cid(self._ship_data.equips[self._index].id)

					local function var_34_2()
						var_0_11:set_remove_equip_temp(1)
						var_0_11:req_ShipRemoveEquip(var_34_0)
					end

					if var_34_1 then
						if var_34_1.type == 32 or var_34_1.type == 33 then
							var_0_2:createInstance("msgbox"):show(var_0_1:getNowLang("tipunequipmissile"), var_34_2, nil, var_0_1:getNowLang("tipmessage"))
						else
							var_34_2()
						end
					else
						var_34_2()
					end
				end)
			else
				self.select_layer:SetActive(false)
				self.info_layer:SetActive(true)

				self.info_layer.lock_effect.title.text.text = var_0_1:getNowLang("ui_equip_lock")

				self.info_layer.lock:SetActive(var_30_4[arg_31_1 + 1].lock)
				self.info_layer.lock_effect:SetActive(not self._is_change and var_30_4[arg_31_1 + 1].lock)

				self.info_layer.icon_layer.icon_bg.image.sprite = self:loadSprite(var_0_7(var_0_5.equip_back.equip_back_normal, var_31_0.star))
				self.info_layer.icon_layer.icon.image.sprite = self:loadSprite(var_0_7(var_0_5.equip_icon.large, var_31_0.pic_id))

				local var_31_5 = app:getSystem():getChannel()

				self.info_layer.name_layer.equip_name.text.text = var_0_6.limit_omit_string(var_31_0.title, (var_31_5 == "hm_android_jp" or var_31_5 == "hm_ios_jp" or nil) and var_0_5.equip_utf8_constant.japanese)

				local var_31_6 = {
					self.info_layer.detail_layer.attrib_1,
					self.info_layer.detail_layer.attrib_2
				}
				local var_31_7 = var_0_5:get_equip_attribute(var_30_4[arg_31_1 + 1].id)

				for iter_31_2 = 1, #var_31_6 do
					if not var_31_7[iter_31_2] then
						var_31_6[iter_31_2]:SetActive(false)
					else
						var_31_6[iter_31_2].count.text.text = var_0_5.equip_attribute[var_31_7[iter_31_2].index] == "range" and var_31_7[iter_31_2].count or var_31_7[iter_31_2].count > 0 and "+" .. var_31_7[iter_31_2].count or var_31_7[iter_31_2].count
						var_31_6[iter_31_2].title.text.text = var_0_5:get_equip_attribute_name(var_0_5.equip_attribute[var_31_7[iter_31_2].index])

						var_31_6[iter_31_2]:SetActive(true)
					end
				end
			end

			if var_31_2 then
				self.info_layer.add_btn:SetActive(false)
				self.info_layer.take_off_other_btn:SetActive(true)
				self.info_layer.take_off_other_btn.button.onClick:RemoveAllListeners()
				self.info_layer.take_off_other_btn.button.onClick:AddListener(function()
					if self:__station_state_return() then
						return
					end

					var_0_2:createInstance("msgbox"):show(var_0_7(var_0_1:convert_rich_text(var_0_1:getNowLang("equipdowntip")), var_31_0.title, var_0_11:find_character_by_id(var_30_4[arg_31_1 + 1].ship_id).name), function()
						var_0_11:req_ShipRemoveEquip({
							id = var_30_4[arg_31_1 + 1].ship_id,
							pos = var_30_4[arg_31_1 + 1].equip_index
						})
						var_0_11:set_remove_equip_temp(2)
					end, nil, var_0_1:getNowLang("unequiptitle"))
				end)
				self.info_layer.detail_btn:SetActive(true)
				self.info_layer.detail_btn.button.onClick:RemoveAllListeners()
				self.info_layer.detail_btn.button.onClick:AddListener(function()
					self:__show_equip_att(self.info_layer, var_31_0)
				end)
			else
				self.info_layer.take_off_other_btn:SetActive(false)
				self.info_layer.add_btn:SetActive(true)
			end

			self.info_layer.add_btn.button.onClick:RemoveAllListeners()
			self.info_layer.add_btn.button.onClick:AddListener(function()
				self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.task_goto))

				if self._is_change then
					if self:__station_state_return() then
						return
					end

					if var_31_3 then
						var_0_12:show(var_0_1:getNowLang("cannot_equip"))

						return
					end

					local var_39_0 = {
						id = self._ship_data.id,
						pos = self._index,
						equip_id = var_30_4[arg_31_1 + 1].id
					}
					local var_39_1 = self._ship_data.equips[self._index] and var_0_3.find_object_by_cid(self._ship_data.equips[self._index].id) or var_0_3.find_object_by_cid(var_30_4[arg_31_1 + 1].id)

					local function var_39_2()
						var_0_11:req_ShipEquip(var_39_0)
					end

					if select_equip then
						if select_equip.type == 32 or select_equip.type == 33 then
							var_0_2:createInstance("msgbox"):show(var_0_1:getNowLang("tipunequipmissile"), var_39_2, nil, var_0_1:getNowLang("tipmessage"))
						else
							var_39_2()
						end
					else
						var_39_2()
					end
				elseif not self._is_change and self._can_lock_seq then
					var_0_11:req_EquipLock({
						id = var_30_4[arg_31_1 + 1].id
					})

					self._can_lock_seq = false
				end
			end)

			if var_31_0 == nil then
				var_31_0 = self._data
			end

			if next(var_31_0.ship_cid) and not var_0_6.have_data(var_31_0.ship_cid, self._ship_data.cid) then
				self.info_layer.gray_bg:SetActive(true)
				self.info_layer.add_btn:SetActive(true)
				self.info_layer.detail_btn:SetActive(true)

				if self._is_change then
					self.info_layer.add_btn.button.onClick:RemoveAllListeners()
					self.info_layer.add_btn.button.onClick:AddListener(function()
						if self:__station_state_return() then
							return
						end

						var_0_12:show(var_0_1:getNowLang("cannot_equip"))
					end)
				end

				self.info_layer.detail_btn.button.onClick:RemoveAllListeners()
				self.info_layer.detail_btn.button.onClick:AddListener(function()
					self:__show_equip_att(self.info_layer, var_31_0)
				end)
			end
		end
	end

	function arg_1_0:update_sort_info()
		local var_43_0 = var_0_2:createInstance("equip_type_layer")

		self._type_toggle_data = var_43_0._type_toggle_data
		self._effect_toggle_data = var_43_0._effect_toggle_data
		self._control.equip_content.type_btn.type_txt.text.text = var_43_0._type_toggle_txt ~= "" and var_43_0._type_toggle_txt or var_0_1:getNowLang("equip0")
	end

	function arg_1_0:__show_capacity()
		local var_44_0 = 0

		for iter_44_0, iter_44_1 in pairs(self._equip_data) do
			var_44_0 = var_44_0 + iter_44_1.num
		end

		self._control.equip_content.equip_capacity.amount_txt.text.text = var_44_0 .. "/" .. var_0_11:get_use_info_data().max_equip
	end

	function arg_1_0:switch_btn()
		self._is_change = not self._is_change

		if self._is_change then
			gamecore.util_func.setTextHorizonInfo(self._control.desc.desc_text_mask, var_0_1:getNowLang("equipment_lock_tip1"))

			self._control.equip_content.change_lock_btn.title.text.text = var_0_1:getNowLang("clockequip")
			self._control.bg_container.tip_title.text.text = var_0_1:getNowLang("changeequip")
		else
			gamecore.util_func.setTextHorizonInfo(self._control.desc.desc_text_mask, var_0_1:getNowLang("equipment_lock_tip2"))

			self._control.equip_content.change_lock_btn.title.text.text = var_0_1:getNowLang("changeequip")
			self._control.bg_container.tip_title.text.text = var_0_1:getNowLang("clockequip")
		end

		if self._filter_name and self._filter_name ~= "" then
			self:set_equip_input_fidle_type_out()
			self:__update_cell_list()
		elseif not var_0_11:get_show_panel_equip_state() then
			self:__update_cell_list(true)
		else
			self:_show_already_use_equip(true)
		end
	end

	function arg_1_0:__show_equip_att(arg_46_1, arg_46_2)
		self._equip_attr = self._equip_attr or self:loadUI("equip_attr")

		self:__show_equip_attr_panel(true)
		self._equip_attr._panel.transform:SetParent(arg_46_1.rectTransform, false)

		self._equip_attr._panel.transform.anchoredPosition = Vector2.New(51, -230)

		self._equip_attr._panel.transform:SetParent(self._control.equip_content.rectTransform)

		if self._equip_attr._panel.transform.anchoredPosition.y < -253 then
			self._equip_attr._panel.transform.anchoredPosition = Vector2.New(self._equip_attr._panel.transform.anchoredPosition.x, -253)
		end

		self._equip_attr._panel.transform:SetParent(arg_46_1.rectTransform)
		self._equip_attr:show(arg_46_2)
	end

	function arg_1_0:__show_equip_attr_panel(arg_47_1)
		if not self._equip_attr then
			return
		end

		self._control.tip_layer:SetActive(arg_47_1)
		self._equip_attr:setVisible(arg_47_1)
	end

	function arg_1_0:__station_state_return()
		if self._ship_data.state == var_0_5.ship_state.station then
			var_0_12:show(var_0_1:getNowLang("noticeshipisinguard"))

			return true
		end
	end

	function arg_1_0.__init_equip_sort(arg_49_0, arg_49_1)
		if arg_49_1 and next(arg_49_1) then
			var_0_8(arg_49_1, function(arg_50_0, arg_50_1)
				local var_50_0 = var_0_3.find_object_by_cid(arg_50_0.id)
				local var_50_1 = var_0_3.find_object_by_cid(arg_50_1.id)

				if var_50_0.type == var_50_1.type then
					if var_50_0.star == var_50_1.star then
						return var_50_0.cid > var_50_1.cid
					else
						return var_50_0.star > var_50_1.star
					end
				else
					return var_50_0.type < var_50_1.type
				end
			end)
		end
	end

	function arg_1_0:_show_already_use_equip(arg_51_1)
		self._already_ship_equip = {}

		self:update_sort_info()

		self._equiped_list = {}
		self._ship_equip = {}

		if arg_51_1 then
			for iter_51_0, iter_51_1 in pairs((var_0_11:get_character_list())) do
				for iter_51_2, iter_51_3 in ipairs(iter_51_1.equips) do
					if iter_51_3.id ~= 0 then
						local var_51_0 = var_0_3.find_object_by_cid(iter_51_3.id)
						local var_51_1 = iter_51_3 and var_0_6.little_clone(iter_51_3) or {}

						var_51_1.ship_id = iter_51_1.id
						var_51_1.equip_index = iter_51_2
						var_51_1.lock = false
						var_51_1.type = var_51_0.type
						var_51_1.star = var_51_0.star
						var_51_1.hp = var_51_0.hp
						var_51_1.atk = var_51_0.atk
						var_51_1.def = var_51_0.def
						var_51_1.torpedo = var_51_0.torpedo
						var_51_1.miss = var_51_0.miss
						var_51_1.air_def = var_51_0.air_def
						var_51_1.antisub = var_51_0.antisub
						var_51_1.aircraft_atk = var_51_0.aircraft_atk
						var_51_1.radar = var_51_0.radar
						var_51_1.luck = var_51_0.luck
						var_51_1.hit = var_51_0.hit
						var_51_1.missile_hit = var_51_0.missile_hit
						var_51_1.missile_tmd = var_51_0.missile_tmd
						var_51_1.aluminium_use = var_51_0.aluminium_use
						var_51_1.air_def_correct = var_51_0.air_def_correct
						var_51_1.air_def_rate = var_51_0.air_def_rate
						var_51_1.cid = iter_51_3.id

						var_0_9(self._equiped_list, var_51_1)
					end
				end
			end
		end

		local var_51_2 = var_0_2:getInstance("equip_sort_layer")
		local var_51_3 = self:get_equip_effect_list((self:get_new_equip_list(self._equiped_list, true)))

		if var_51_2 then
			var_51_2:sort_ship_equip_info_list(var_51_3)
		else
			self:__init_equip_sort(var_51_3)
		end

		local var_51_4 = self:__filter_table(var_51_3)
		local var_51_5 = {}

		for iter_51_4, iter_51_5 in ipairs(self._equip_data) do
			if iter_51_5 and iter_51_5.id then
				local var_51_6 = var_0_3.find_object_by_cid(iter_51_5.id)

				var_51_6.num = iter_51_5.num
				var_51_6.lock = iter_51_5.lock
				var_51_6.id = iter_51_5.id

				var_0_9(var_51_5, var_51_6)
			end
		end

		local var_51_7 = self:get_equip_effect_list((self:get_new_equip_list(var_51_5)))

		if var_51_2 then
			var_51_2:sort_ship_equip_info_list(var_51_7)
		else
			self:__init_equip_sort(var_51_7)
		end

		local var_51_8 = self:__filter_table(var_51_7)
		local var_51_9 = self:get_equip_effect_list(self._no_load_list)

		if var_51_2 then
			var_51_2:sort_ship_equip_info_list(var_51_9)
		else
			self:__init_equip_sort(var_51_9)
		end

		local var_51_10 = self:__filter_table(var_51_9)

		if var_51_9 and next(var_51_9) then
			for iter_51_6, iter_51_7 in ipairs(var_51_9) do
				var_0_9(var_51_8, iter_51_7)
			end
		end

		if var_51_4 and next(var_51_4) and var_51_8 and next(var_51_8) then
			for iter_51_8, iter_51_9 in ipairs(var_51_4) do
				var_0_9(var_51_8, iter_51_9)
			end
		elseif var_51_4 and next(var_51_4) then
			var_51_8 = var_51_4
		end

		if self._filter_name and self._filter_name ~= "" then
			var_51_8 = self:__filter_table_by_name(var_51_8)

			if #var_51_8 == 0 or #var_51_8 == 0 then
				var_0_12:show(var_0_1:getNowLang("noequipsearched"))
			end
		end

		local var_51_11 = var_51_8

		if self._data and self._is_change and var_51_11[1] ~= " " then
			var_0_9(var_51_11, 1, " ")
		end

		self._reusable_cell:set_data(var_51_11)

		function self._reusable_cell:_set_func(arg_52_1)
			local var_52_0 = var_0_3.find_object_by_cid(var_51_11[arg_52_1 + 1].id)
			local var_52_2 = false

			if var_51_11[arg_52_1 + 1] ~= " " then
				for iter_52_0, iter_52_1 in pairs(var_51_11[arg_52_1 + 1]) do
					if iter_52_0 == "ship_id" then
						var_52_2 = true

						break
					end
				end
			end

			local var_52_3 = var_0_6.have_data(self._no_load_list, var_51_11[arg_52_1 + 1])

			if var_52_2 then
				self.info_layer.gray_bg:SetActive(true)
				self.info_layer.equip_bg:SetActive(true)

				self.info_layer.equip_bg.ship_name.shipname.text.text = var_0_11:find_character_by_id(var_51_11[arg_52_1 + 1].ship_id).name

				self.info_layer.equip_bg.ship_name.textHorizonScroller:SetText(var_0_11:find_character_by_id(var_51_11[arg_52_1 + 1].ship_id).name)

				self.info_layer.icon_layer.count.text.text = ""

				self.info_layer.detail_btn:SetActive(true)
				self.info_layer.detail_btn.button.onClick:RemoveAllListeners()
				self.info_layer.detail_btn.button.onClick:AddListener(function()
					self:__show_equip_att(self.info_layer, var_52_0)
				end)
			else
				self.info_layer.icon_layer.count.text.text = var_51_11[arg_52_1 + 1].num

				self.info_layer.gray_bg:SetActive(var_52_3)
				self.info_layer.equip_bg:SetActive(false)
				self.info_layer.detail_btn:SetActive(true)
				self.info_layer.detail_btn.button.onClick:RemoveAllListeners()
				self.info_layer.detail_btn.button.onClick:AddListener(function()
					self:__show_equip_att(self.info_layer, var_52_0)
				end)
			end

			if arg_52_1 == 0 and var_51_11[1] == " " then
				self.select_layer:SetActive(true)

				self.select_layer.takeoff_btn.image.sprite = self:loadSprite(var_0_5.equip_list.ship_equip_take_off)

				self.info_layer:SetActive(false)
				self.select_layer.takeoff_btn.button.onClick:RemoveAllListeners()
				self.select_layer.takeoff_btn.button.onClick:AddListener(function()
					if self:__station_state_return() then
						return
					end

					local var_55_0 = {
						id = self._ship_data.id,
						pos = self._index
					}
					local var_55_1 = var_0_3.find_object_by_cid(self._ship_data.equips[self._index].id)

					local function var_55_2()
						var_0_11:set_remove_equip_temp(1)
						var_0_11:req_ShipRemoveEquip(var_55_0)
					end

					if var_55_1 then
						if var_55_1.type == 32 or var_55_1.type == 33 then
							var_0_2:createInstance("msgbox"):show(var_0_1:getNowLang("tipunequipmissile"), var_55_2, nil, var_0_1:getNowLang("tipmessage"))
						else
							var_55_2()
						end
					else
						var_55_2()
					end
				end)
			else
				self.select_layer:SetActive(false)
				self.info_layer:SetActive(true)

				self.info_layer.lock_effect.title.text.text = var_0_1:getNowLang("ui_equip_lock")

				self.info_layer.lock:SetActive(var_51_11[arg_52_1 + 1].lock)
				self.info_layer.lock_effect:SetActive(not self._is_change and var_51_11[arg_52_1 + 1].lock)

				self.info_layer.icon_layer.icon_bg.image.sprite = self:loadSprite(var_0_7(var_0_5.equip_back.equip_back_normal, var_52_0.star))
				self.info_layer.icon_layer.icon.image.sprite = self:loadSprite(var_0_7(var_0_5.equip_icon.large, var_52_0.pic_id))

				local var_52_5 = app:getSystem():getChannel()

				self.info_layer.name_layer.equip_name.text.text = var_0_6.limit_omit_string(var_52_0.title, (var_52_5 == "hm_android_jp" or var_52_5 == "hm_ios_jp" or nil) and var_0_5.equip_utf8_constant.japanese)

				local var_52_6 = {
					self.info_layer.detail_layer.attrib_1,
					self.info_layer.detail_layer.attrib_2
				}
				local var_52_7 = var_0_5:get_equip_attribute(var_51_11[arg_52_1 + 1].id)

				for iter_52_2 = 1, #var_52_6 do
					if not var_52_7[iter_52_2] then
						var_52_6[iter_52_2]:SetActive(false)
					else
						var_52_6[iter_52_2].count.text.text = var_0_5.equip_attribute[var_52_7[iter_52_2].index] == "range" and var_52_7[iter_52_2].count or var_52_7[iter_52_2].count > 0 and "+" .. var_52_7[iter_52_2].count or var_52_7[iter_52_2].count
						var_52_6[iter_52_2].title.text.text = var_0_5:get_equip_attribute_name(var_0_5.equip_attribute[var_52_7[iter_52_2].index])

						var_52_6[iter_52_2]:SetActive(true)
					end
				end
			end

			if var_52_2 then
				self.info_layer.add_btn:SetActive(false)
				self.info_layer.take_off_other_btn:SetActive(true)
				self.info_layer.take_off_other_btn.button.onClick:RemoveAllListeners()
				self.info_layer.take_off_other_btn.button.onClick:AddListener(function()
					if self:__station_state_return() then
						return
					end

					var_0_2:createInstance("msgbox"):show(var_0_7(var_0_1:convert_rich_text(var_0_1:getNowLang("equipdowntip")), var_52_0.title, var_0_11:find_character_by_id(var_51_11[arg_52_1 + 1].ship_id).name), function()
						var_0_11:req_ShipRemoveEquip({
							id = var_51_11[arg_52_1 + 1].ship_id,
							pos = var_51_11[arg_52_1 + 1].equip_index
						})
						var_0_11:set_remove_equip_temp(2)
					end, nil, var_0_1:getNowLang("unequiptitle"))
				end)
				self.info_layer.detail_btn:SetActive(true)
				self.info_layer.detail_btn.button.onClick:RemoveAllListeners()
				self.info_layer.detail_btn.button.onClick:AddListener(function()
					self:__show_equip_att(self.info_layer, var_52_0)
				end)
			else
				self.info_layer.take_off_other_btn:SetActive(false)
				self.info_layer.add_btn:SetActive(true)
			end

			self.info_layer.add_btn.button.onClick:RemoveAllListeners()
			self.info_layer.add_btn.button.onClick:AddListener(function()
				self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.task_goto))

				if self._is_change then
					if self:__station_state_return() then
						return
					end

					if var_52_3 then
						var_0_12:show(var_0_1:getNowLang("cannot_equip"))

						return
					end

					local var_60_0 = {
						id = self._ship_data.id,
						pos = self._index,
						equip_id = var_51_11[arg_52_1 + 1].id
					}
					local var_60_1 = self._ship_data.equips[self._index] and var_0_3.find_object_by_cid(self._ship_data.equips[self._index].id) or var_0_3.find_object_by_cid(var_51_11[arg_52_1 + 1].id)

					local function var_60_2()
						var_0_11:req_ShipEquip(var_60_0)
					end

					if var_60_1 then
						if var_60_1.type == 32 or var_60_1.type == 33 then
							var_0_2:createInstance("msgbox"):show(var_0_1:getNowLang("tipunequipmissile"), var_60_2, nil, var_0_1:getNowLang("tipmessage"))
						else
							var_60_2()
						end
					else
						var_60_2()
					end
				elseif not self._is_change and self._can_lock_seq then
					var_0_11:req_EquipLock({
						id = var_51_11[arg_52_1 + 1].id
					})

					self._can_lock_seq = false
				end
			end)

			if var_52_0 == nil then
				var_52_0 = self._data
			end

			if next(var_52_0.ship_cid) and not var_0_6.have_data(var_52_0.ship_cid, self._ship_data.cid) then
				self.info_layer.gray_bg:SetActive(true)
				self.info_layer.add_btn:SetActive(true)
				self.info_layer.detail_btn:SetActive(true)

				if self._is_change then
					self.info_layer.add_btn.button.onClick:RemoveAllListeners()
					self.info_layer.add_btn.button.onClick:AddListener(function()
						if self:__station_state_return() then
							return
						end

						var_0_12:show(var_0_1:getNowLang("cannot_equip"))
					end)
				end

				self.info_layer.detail_btn.button.onClick:RemoveAllListeners()
				self.info_layer.detail_btn.button.onClick:AddListener(function()
					self:__show_equip_att(self.info_layer, var_52_0)
				end)
			end
		end
	end

	function arg_1_0.__have_data(arg_64_0, arg_64_1, arg_64_2)
		local var_64_0 = false

		if arg_64_1 and next(arg_64_1) then
			for iter_64_0, iter_64_1 in pairs(arg_64_1) do
				if iter_64_1.id == arg_64_2 then
					var_64_0 = true
				end
			end
		end

		return var_64_0
	end

	function arg_1_0:_play_into_se(arg_65_1)
		self:playSE(arg_65_1, false)
	end

	function arg_1_0.__onReset(arg_66_0)
		arg_66_0._is_already_init = false
		arg_66_0._data = nil
		arg_66_0._ship_data = nil
		arg_66_0._ship_conf = nil
		arg_66_0._index = nil
		arg_66_0._is_change = true
		arg_66_0._equip_data = {}
		arg_66_0._can_lock_seq = false
		arg_66_0._type_toggle_data = {
			all = true
		}
		arg_66_0._effect_toggle_data = {
			all = true
		}
		arg_66_0._type_layer_callback = nil
		arg_66_0._equip_attr = nil
		arg_66_0._no_load_list = nil
		arg_66_0._filter_name = nil
		arg_66_0._equip_type_set = nil
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_67_0)
	local var_67_0 = var_0_2:class("equip_list")

	var_67_0._is_already_init = false
	var_67_0._data = nil
	var_67_0._ship_data = nil
	var_67_0._ship_conf = nil
	var_67_0._index = nil
	var_67_0._reusable_cell = nil
	var_67_0._is_change = true
	var_67_0._equip_data = {}
	var_67_0._can_lock_seq = false
	var_67_0._type_toggle_data = {
		all = true
	}
	var_67_0._effect_toggle_data = {
		all = true
	}
	var_67_0._need_revert = false
	var_67_0._type_layer_callback = nil
	var_67_0._equip_attr = nil
	var_67_0._no_load_list = nil
	var_67_0._filter_name = nil
	var_67_0._already_init = false
	var_67_0._equip_type_set = nil
	var_67_0._is_use_equip = false
	var_67_0._sort_type_num = 1
	var_67_0._sort_type = 2
	var_67_0._ship_equip = {}

	gamecore.extend_obj(var_67_0)

	return var_67_0
end

return var_0_0
