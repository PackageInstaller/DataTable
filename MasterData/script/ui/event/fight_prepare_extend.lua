local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_3 = table.insert
local var_0_6 = string.format
local var_0_7 = gamecore.util_func
local var_0_9 = gameenum.common_type
local var_0_12 = gameconfig.ship_config
local var_0_13 = gameconfig.skill_config
local var_0_16 = gameconfig.strike_buff_config
local var_0_18 = gameconfig.strike_weather_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:select_ship_by_pvebuff(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		if not arg_2_2 or not arg_2_2.type then
			return true
		end

		local var_2_1

		if arg_2_3 == var_0_9.fight_type.tower_fight then
			var_2_1 = var_0_6("__on_func_%s", (var_0_9:get_tower_buffs_type(arg_2_2.type)))
		elseif arg_2_3 == var_0_9.fight_type.ocean_attack then
			-- block empty
		elseif arg_2_3 == var_0_9.fight_type.strike then
			if arg_2_4 and (arg_2_2.type == 7 or arg_2_2.type == 8 or arg_2_2.type == 9 or arg_2_2.type == 10 or arg_2_2.type == 19 or arg_2_2.type == 20 or arg_2_2.type == 31) then
				return true
			end

			var_2_1 = var_0_6("__onConditionFunc_%s", (var_0_9:get_strike_buffs_type(arg_2_2.type)))
		end

		if arg_2_3 == var_0_9.fight_type.strike and not next(arg_2_1) then
			return false
		end

		if not self[var_2_1] or not next(arg_2_1) then
			return true
		end

		return self[var_2_1](self, arg_2_1, arg_2_2)
	end

	function arg_1_0:select_ship_attrs_by_pvebuff(arg_3_1, arg_3_2, arg_3_3)
		if not arg_3_2 or not arg_3_2.type then
			return true
		end

		local var_3_1

		if arg_3_3 == var_0_9.fight_type.tower_fight then
			var_3_1 = var_0_6("__on_func_%s", (var_0_9:get_tower_buffs_type(arg_3_2.type)))
		elseif arg_3_3 == var_0_9.fight_type.ocean_attack then
			-- block empty
		elseif arg_3_3 == var_0_9.fight_type.strike then
			var_3_1 = var_0_6("__onConditionFunc_%s", (var_0_9:get_strike_buffs_type(arg_3_2.type)))
		end

		if not self[var_3_1] or not next(arg_3_1) then
			return true
		end

		return self[var_3_1](self, arg_3_1, arg_3_2)
	end

	function arg_1_0:select_ship_attr_by_pre_effect(arg_4_1)
		local var_4_0 = {}

		for iter_4_0, iter_4_1 in pairs(arg_4_1) do
			local var_4_1 = var_0_1:find_character_by_id(iter_4_1)

			table.insert(var_4_0, {
				data = var_4_1,
				ship_conf = var_0_12.find_object_by_cid(var_4_1.cid)
			})
		end

		for iter_4_2, iter_4_3 in pairs(var_4_0) do
			local var_4_2 = not iter_4_3.data.now_skill and var_0_13.find_object_by_skill_id(iter_4_3.data.skill_id) or var_0_13.find_object_by_skill_type_skill_level(iter_4_3.data.now_skill, iter_4_3.data.skill_level)

			if var_4_2 and var_4_2.pre_effect and next(var_4_2.pre_effect) then
				for iter_4_4, iter_4_5 in pairs(var_4_2.pre_effect) do
					local var_4_3 = false

					if iter_4_5.condition then
						for iter_4_6, iter_4_7 in pairs(iter_4_5.condition) do
							if iter_4_7.type == 43 then
								local var_4_4 = true

								for iter_4_8, iter_4_9 in pairs(var_4_0) do
									if iter_4_2 ~= iter_4_8 then
										for iter_4_10, iter_4_11 in pairs(iter_4_7.shipTypes) do
											if iter_4_9.ship_conf.type == iter_4_11 then
												var_4_4 = false
											end
										end
									end
								end

								var_4_3 = var_4_4
							elseif iter_4_7.type == 26 and iter_4_2 == 1 then
								var_4_3 = true
							end
						end
					else
						var_4_3 = true
					end

					if var_4_3 then
						for iter_4_12, iter_4_13 in pairs(iter_4_5.target) do
							if iter_4_13.type == 2 then
								for iter_4_14, iter_4_15 in pairs(iter_4_13.shipTypes) do
									if var_4_0[iter_4_2 - 1] and var_4_0[iter_4_2 - 1].ship_conf.type == iter_4_15 then
										self._attr_by_pre_effect_list[iter_4_2 - 1] = self._attr_by_pre_effect_list[iter_4_2 - 1] or {}

										table.insert(self._attr_by_pre_effect_list[iter_4_2 - 1], iter_4_5.effect)
									end

									if var_4_0[iter_4_2 + 1] and var_4_0[iter_4_2 + 1].ship_conf.type == iter_4_15 then
										self._attr_by_pre_effect_list[iter_4_2 + 1] = self._attr_by_pre_effect_list[iter_4_2 + 1] or {}

										table.insert(self._attr_by_pre_effect_list[iter_4_2 + 1], iter_4_5.effect)
									end
								end
							elseif iter_4_13.type == 4 then
								for iter_4_16, iter_4_17 in pairs(var_4_0) do
									if iter_4_16 < iter_4_2 and iter_4_16 >= iter_4_2 - iter_4_13.num then
										self._attr_by_pre_effect_list[iter_4_16] = self._attr_by_pre_effect_list[iter_4_16] or {}

										table.insert(self._attr_by_pre_effect_list[iter_4_16], iter_4_5.effect)
									end
								end
							elseif iter_4_13.type == 7 then
								self._attr_by_pre_effect_list[iter_4_2] = self._attr_by_pre_effect_list[iter_4_2] or {}

								table.insert(self._attr_by_pre_effect_list[iter_4_2], iter_4_5.effect)
							elseif iter_4_13.type == 8 then
								for iter_4_18, iter_4_19 in pairs(var_4_0) do
									self._attr_by_pre_effect_list[iter_4_18] = self._attr_by_pre_effect_list[iter_4_18] or {}

									table.insert(self._attr_by_pre_effect_list[iter_4_18], iter_4_5.effect)
								end
							elseif iter_4_13.type == 10 then
								for iter_4_20, iter_4_21 in pairs(var_4_0) do
									local var_4_6 = var_0_12.find_object_by_cid(iter_4_21.data.cid)

									if var_4_6 then
										for iter_4_22, iter_4_23 in pairs(iter_4_13.country) do
											if var_4_6.country == iter_4_23 then
												self._attr_by_pre_effect_list[iter_4_20] = self._attr_by_pre_effect_list[iter_4_20] or {}

												table.insert(self._attr_by_pre_effect_list[iter_4_20], iter_4_5.effect)
											end
										end
									end
								end
							elseif iter_4_13.type == 11 or iter_4_13.type == 12 then
								for iter_4_24, iter_4_25 in pairs(var_4_0) do
									local var_4_7 = var_0_12.find_object_by_cid(iter_4_25.data.cid)

									if var_4_7 then
										local var_4_8 = false

										for iter_4_26, iter_4_27 in pairs(iter_4_13.shipTypes or {}) do
											if var_4_7.type == iter_4_27 then
												var_4_8 = true

												break
											end
										end

										if not var_4_8 then
											for iter_4_28, iter_4_29 in pairs(iter_4_13.shipTons or {}) do
												if var_4_7.ship_ton == iter_4_29 then
													var_4_8 = true

													break
												end
											end
										end

										if not var_4_8 then
											for iter_4_30, iter_4_31 in pairs(iter_4_13.guardTypes or {}) do
												if var_4_7.guard_type == iter_4_31 then
													var_4_8 = true

													break
												end
											end
										end

										local var_4_11 = true

										if iter_4_13.type == 12 then
											var_4_11 = false

											for iter_4_32, iter_4_33 in pairs(iter_4_13.country or {}) do
												if var_4_7.country == iter_4_33 then
													var_4_11 = true

													break
												end
											end
										end

										if var_4_8 and var_4_11 then
											self._attr_by_pre_effect_list[iter_4_24] = self._attr_by_pre_effect_list[iter_4_24] or {}

											table.insert(self._attr_by_pre_effect_list[iter_4_24], iter_4_5.effect)
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	function arg_1_0:__get_ship_counter_by_buff_data(arg_5_1, arg_5_2, arg_5_3)
		local var_5_0
		local var_5_1
		local var_5_2
		local var_5_3

		for iter_5_0, iter_5_1 in pairs(arg_5_2) do
			if iter_5_0 == "country" or iter_5_0 == "countrys" then
				var_5_0 = iter_5_1
			elseif iter_5_0 == "shipType" or iter_5_0 == "shipTypes" then
				var_5_1 = iter_5_1
			elseif iter_5_0 == "shipTon" or iter_5_0 == "shipTons" then
				var_5_2 = iter_5_1
			elseif iter_5_0 == "guardType" or iter_5_0 == "guardTypes" then
				var_5_3 = iter_5_1
			end
		end

		if not var_5_0 and not var_5_1 and not var_5_2 and not var_5_3 then
			return arg_5_1
		end

		local var_5_4 = {}

		for iter_5_2, iter_5_3 in pairs(arg_5_1) do
			local var_5_5

			if not arg_5_3 then
				var_5_5 = var_0_12.find_object_by_cid(var_0_1:find_character_by_id(iter_5_3).cid)
			elseif type(iter_5_3) == "number" then
				var_5_5 = var_0_12.find_object_by_cid(var_0_1:find_character_by_id(iter_5_3).cid)
			end

			if var_5_0 then
				if self:__get_ship_data_by_countrys(var_5_5, var_5_0) and self:__get_ship_data_by_screen(var_5_5, var_5_1, var_5_2, var_5_3) then
					var_0_3(var_5_4, (arg_5_3 or nil) and (var_5_5.cid or iter_5_3))
				end
			elseif self:__get_ship_data_by_screen(var_5_5, var_5_1, var_5_2, var_5_3) then
				var_0_3(var_5_4, (arg_5_3 or nil) and (var_5_5.cid or iter_5_3))
			end
		end

		return var_5_4
	end

	function arg_1_0.__number_to_table(arg_6_0, arg_6_1)
		local var_6_0 = {}

		if type(arg_6_1) == "number" then
			var_0_3(var_6_0, arg_6_1)

			return var_6_0
		end

		return arg_6_1
	end

	function arg_1_0:__get_ship_data_by_countrys(arg_7_1, arg_7_2)
		arg_7_2 = self:__number_to_table(arg_7_2)

		for iter_7_0, iter_7_1 in pairs(arg_7_2) do
			if arg_7_1.country == iter_7_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_types(arg_8_1, arg_8_2)
		arg_8_2 = self:__number_to_table(arg_8_2)

		for iter_8_0, iter_8_1 in pairs(arg_8_2) do
			if arg_8_1.type == iter_8_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_tons(arg_9_1, arg_9_2)
		arg_9_2 = self:__number_to_table(arg_9_2)

		for iter_9_0, iter_9_1 in pairs(arg_9_2) do
			if type(arg_9_1) ~= "number" and arg_9_1.ship_ton == iter_9_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_guards(arg_10_1, arg_10_2)
		arg_10_2 = self:__number_to_table(arg_10_2)

		for iter_10_0, iter_10_1 in pairs(arg_10_2) do
			if arg_10_1.guard_type == iter_10_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_screen(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
		if arg_11_2 and arg_11_2 ~= 0 then
			if self:__get_ship_data_by_types(arg_11_1, arg_11_2) then
				return self:__get_target_by_ship_ton(arg_11_1, arg_11_3, arg_11_4)
			end
		elseif arg_11_3 and arg_11_3 ~= 0 then
			return self:__get_target_by_ship_ton(arg_11_1, arg_11_3, arg_11_4)
		elseif arg_11_4 and arg_11_4 ~= 0 then
			return self:__get_ship_data_by_guards(arg_11_1, arg_11_4)
		else
			return true
		end
	end

	function arg_1_0:__get_target_by_ship_ton(arg_12_1, arg_12_2, arg_12_3)
		if arg_12_2 then
			if self:__get_ship_data_by_tons(arg_12_1, arg_12_2) then
				return self:__get_target_by_ship_guard(arg_12_1, arg_12_3)
			else
				return false
			end
		else
			return self:__get_target_by_ship_guard(arg_12_1, arg_12_3)
		end
	end

	function arg_1_0:__get_target_by_ship_guard(arg_13_1, arg_13_2)
		if arg_13_2 then
			if self:__get_ship_data_by_guards(arg_13_1, arg_13_2) then
				return true
			else
				return false
			end
		else
			return true
		end
	end

	function arg_1_0:check_for_speed()
		if self._fight_prepare_type ~= var_0_9.fight_type.strike then
			return 0
		end

		local var_14_0 = lx.clone_table(self._current_strike_buffs)

		for iter_14_0, iter_14_1 in pairs(var_14_0) do
			if iter_14_1.replace then
				table.remove(var_14_0, iter_14_0)
			end
		end

		local var_14_1 = 0

		for iter_14_2, iter_14_3 in pairs(var_14_0) do
			local var_14_2

			if iter_14_3.id < 1000 then
				var_14_2 = var_0_18.find_object_by_id(iter_14_3.id)

				if iter_14_3.state then
					var_14_2 = var_0_18.find_object_by_id(iter_14_3.change_id)
				end
			else
				var_14_2 = var_0_16.find_object_by_id(iter_14_3.id)

				if iter_14_3.state then
					var_14_2 = var_0_16.find_object_by_id(iter_14_3.change_id)
				end
			end

			if var_14_2.pre_effect and next(var_14_2.pre_effect) then
				for iter_14_4, iter_14_5 in pairs(var_14_2.pre_effect) do
					if iter_14_5.num4 == 10 then
						var_14_1 = iter_14_5.type == 7 and var_14_1 + iter_14_5.num or var_14_1 - iter_14_5.num
					end
				end
			end
		end

		return var_14_1
	end

	function arg_1_0:check_for_seeking()
		if self._fight_prepare_type ~= var_0_9.fight_type.strike then
			return 0
		end

		local var_15_0 = lx.clone_table(self._current_strike_buffs)

		for iter_15_0, iter_15_1 in pairs(var_15_0) do
			if iter_15_1.replace then
				table.remove(var_15_0, iter_15_0)
			end
		end
	end

	function arg_1_0:get_skill_equip_add_prop(arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
		local var_16_0 = {
			"hp",
			"atk",
			"def",
			"torpedo",
			"miss",
			"air_def",
			nil,
			nil,
			"antisub",
			"speed",
			"radar",
			"range",
			"luck",
			"hit_repair",
			"miss_repair",
			"crit_repair",
			"hit",
			"now_hp",
			"ship_air_def"
		}
		local var_16_1 = var_0_7:get_ship_attr(arg_16_2, (var_0_12.find_object_by_cid(arg_16_2.cid)))
		local var_16_3 = not arg_16_2.now_skill and var_0_13.find_object_by_skill_id(arg_16_2.skill_id) or var_0_13.find_object_by_skill_type_skill_level(arg_16_2.now_skill, arg_16_2.skill_level)
		local var_16_4 = {}

		table.insert(var_16_4, arg_16_3)

		self._attr_buff_list = self._attr_buff_list or {}

		for iter_16_0, iter_16_1 in pairs(self._attr_buff_list) do
			if next((self:__get_ship_counter_by_buff_data(var_16_4, iter_16_1))) then
				if iter_16_1.type == 31 then
					for iter_16_2, iter_16_3 in pairs(self._attr_buff_list) do
						if iter_16_3.type ~= 31 then
							local var_16_6 = -1

							if iter_16_3.type == 8 or iter_16_3.type == 10 or iter_16_3.type == 20 then
								var_16_6 = 1
							end

							var_16_1[var_16_0[iter_16_3.num4]] = var_16_1[var_16_0[iter_16_3.num4]] or 0
							var_16_1[var_16_0[iter_16_3.num4]] = var_16_1[var_16_0[iter_16_3.num4]] + iter_16_3.num * var_16_6
						end
					end
				else
					local var_16_7 = 1

					if iter_16_1.type == 8 or iter_16_1.type == 10 or iter_16_1.type == 20 then
						var_16_7 = -1
					end

					var_16_1[var_16_0[iter_16_1.num4]] = var_16_1[var_16_0[iter_16_1.num4]] or 0
					var_16_1[var_16_0[iter_16_1.num4]] = var_16_1[var_16_0[iter_16_1.num4]] + iter_16_1.num * var_16_7
				end
			end
		end

		self._attr_by_pre_effect_list = self._attr_by_pre_effect_list or {}

		if self._attr_by_pre_effect_list[arg_16_4] then
			for iter_16_4, iter_16_5 in ipairs(self._attr_by_pre_effect_list[arg_16_4]) do
				if iter_16_5 then
					for iter_16_6, iter_16_7 in pairs(iter_16_5) do
						for iter_16_8, iter_16_9 in pairs(iter_16_7) do
							for iter_16_10, iter_16_11 in pairs(var_16_0) do
								if iter_16_8 == iter_16_11 then
									var_16_1[iter_16_11] = (var_16_1[iter_16_11] or 0) + iter_16_9
								end
							end
						end
					end
				end
			end
		end

		return var_16_1
	end
end

function var_0_0.extend_obj(arg_17_0)
	return
end

return var_0_0
