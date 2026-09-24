local var_0_0 = {}
local var_0_3 = gameenum.battle_type
local var_0_4 = gamecore.battle_util
local var_0_5 = table.insert

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:get_sea_target(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		local var_2_0 = var_0_3.obj_side.opposite(self._side)
		local var_2_1 = self._battle_obj_mgr:get_sea_ships_by_side(var_2_0)

		if arg_2_3 == "torpedo_attack" or arg_2_3 == "open_torpedo_attack" or arg_2_3 == "night_torpedo_attack" then
			var_2_1 = self._battle_obj_mgr:get_not_facilities_ships(var_2_0)
		end

		self:get_attribute().skill_num = self:get_attribute().skill_num or {}

		if self:get_attribute().skill_num.can_not_shout_and_shout_with_teammate_save_list and self:get_attribute().skill_num.can_not_shout_and_shout_with_teammate.can_shout then
			var_2_1 = self:get_attribute().skill_num.can_not_shout_and_shout_with_teammate_save_list.ship_list
			self:get_attribute().skill_num.can_not_shout_and_shout_with_teammate_save_list.ship_list = {}
			self:get_attribute().skill_num.can_not_shout_and_shout_with_teammate.can_shout = false
		end

		if self._side == -1 and self._battle_scene:get_ship_range_limit_data() and (self._battlefield._battle_step == 9 or self._battlefield._battle_step == 10) then
			local var_2_3 = {}

			if self._battle_scene:get_ship_range_limit_data().num >= self:get_attribute().range:get_final_value() then
				for iter_2_0, iter_2_1 in pairs(var_2_1) do
					local var_2_4 = false

					for iter_2_2, iter_2_3 in pairs(self._battle_scene:get_ship_range_limit_data().ship_list) do
						if iter_2_1:getID() == iter_2_3 then
							var_2_4 = true
						end
					end

					if var_2_4 == false then
						var_0_5(var_2_3, iter_2_1)
					end
				end

				var_2_1 = var_2_3
			end
		end

		local var_2_5 = #var_2_1

		if #var_2_1 == 0 then
			return nil
		end

		if arg_2_1 and not arg_2_2 and arg_2_4 then
			local var_2_7 = {}

			for iter_2_4 = 1, arg_2_1 do
				var_0_5(var_2_7, (self:get_sea_target(nil, nil, arg_2_3)))
			end

			return var_2_7
		end

		if arg_2_1 and not arg_2_2 then
			local var_2_9 = {}
			local var_2_10 = {}

			while #var_2_9 ~= arg_2_1 do
				self.can_add = true

				local var_2_11 = self:get_sea_target(nil, nil, arg_2_3)

				for iter_2_5, iter_2_6 in pairs(var_2_9) do
					if iter_2_6:getID() == var_2_11:getID() then
						self.can_add = false
					end
				end

				if self.can_add == true then
					var_0_5(var_2_9, var_2_11)
					var_0_5(var_2_10, var_2_11:getID())
				end

				if #var_2_9 == var_2_5 then
					return var_2_9
				end
			end

			return var_2_9
		end

		if arg_2_2 then
			return self:get_hit_complex_targets(var_2_1, arg_2_1, arg_2_3)
		end

		if not arg_2_1 then
			local var_2_12 = {}
			local var_2_13 = {}

			for iter_2_7, iter_2_8 in pairs(var_2_1) do
				if iter_2_8:get_attribute().ridicule then
					for iter_2_9, iter_2_10 in pairs(iter_2_8:get_attribute().ridicule.shipTypes) do
						if self:get_ship_type() == iter_2_10 then
							if iter_2_8:get_attribute().ridicule.atked_weight > 0 then
								var_2_12[iter_2_7] = iter_2_8:get_attribute().ridicule.atked_weight

								self._battlefield:append_result(iter_2_8._cid, "技能效果", (string.format("增加被攻击概率:%s", iter_2_8:get_attribute().ridicule.atked_weight)))
							end

							if iter_2_8:get_attribute().ridicule.atked_weight < 0 then
								var_2_13[iter_2_7] = iter_2_8:get_attribute().ridicule.atked_weight

								self._battlefield:append_result(iter_2_8._cid, "技能效果", (string.format("减少被攻击概率:%s", iter_2_8:get_attribute().ridicule.atked_weight)))
							end
						end
					end
				end

				if iter_2_8:get_attribute().atked_weight and iter_2_8:get_attribute().atked_weight > 0 then
					var_2_12[iter_2_7] = not var_2_12[iter_2_7] and iter_2_8:get_attribute().atked_weight or var_2_12[iter_2_7] + iter_2_8:get_attribute().atked_weight

					self._battlefield:append_result(iter_2_8._cid, "技能效果", (string.format("增加被攻击概率:%s", iter_2_8:get_attribute().atked_weight)))
				end

				if iter_2_8:get_attribute().atked_weight and iter_2_8:get_attribute().atked_weight < 0 then
					var_2_13[iter_2_7] = not var_2_13[iter_2_7] and iter_2_8:get_attribute().atked_weight or iter_2_8:get_attribute().atked_weight + var_2_13[iter_2_7]

					self._battlefield:append_result(iter_2_8._cid, "技能效果", (string.format("减少被攻击概率:%s", iter_2_8:get_attribute().atked_weight)))
				end
			end

			local var_2_15 = self._battle_random:randRange(1, var_2_5)
			local var_2_16 = var_2_1[var_2_15]
			local var_2_17 = {}

			for iter_2_11, iter_2_12 in pairs(var_2_12) do
				var_0_5(var_2_17, {
					index = iter_2_11,
					value = iter_2_12
				})
			end

			table.sort(var_2_17, function(arg_3_0, arg_3_1)
				return arg_3_0.value > arg_3_1.value
			end)

			if #var_2_17 > 0 then
				-- block empty
			end

			for iter_2_13, iter_2_14 in pairs(var_2_17) do
				if self._battle_random:randomRangeDouble(0, 1) <= iter_2_14.value then
					var_2_16 = var_2_1[iter_2_14.index]

					break
				end
			end

			local var_2_19 = {}

			for iter_2_15, iter_2_16 in pairs(var_2_13) do
				var_0_5(var_2_19, {
					index = iter_2_15,
					value = iter_2_16
				})
			end

			for iter_2_17, iter_2_18 in pairs(var_2_19) do
				if var_2_15 == iter_2_18.index and self._battle_random:randomRangeDouble(0, 1) <= -iter_2_18.value then
					var_2_15 = self._battle_random:randRange(1, var_2_5)
					var_2_16 = var_2_1[var_2_15]
				end
			end

			return (self:__get_special_target(false, var_2_16))
		end
	end

	function arg_1_0:get_undersea_target(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		local var_4_0 = self._battle_obj_mgr:get_undersea_ships_by_side((var_0_3.obj_side.opposite(self._side)))

		if self._side == -1 and self._battle_scene:get_ship_range_limit_data() and (self._battlefield._battle_step == 9 or self._battlefield._battle_step == 10) then
			local var_4_1 = {}

			if self._battle_scene:get_ship_range_limit_data().num >= self:get_attribute().range:get_final_value() then
				for iter_4_0, iter_4_1 in pairs(var_4_0) do
					local var_4_2 = false

					for iter_4_2, iter_4_3 in pairs(self._battle_scene:get_ship_range_limit_data().ship_list) do
						if iter_4_1:getID() == iter_4_3 then
							var_4_2 = true
						end
					end

					if var_4_2 == false then
						var_0_5(var_4_1, iter_4_1)
					end
				end

				var_4_0 = var_4_1
			end
		end

		local var_4_3 = #var_4_0

		if #var_4_0 == 0 then
			return nil
		end

		if arg_4_2 and not arg_4_3 then
			local var_4_5 = {}
			local var_4_6 = {}

			while #var_4_5 ~= arg_4_2 do
				self.can_add = true

				local var_4_7 = self:get_undersea_target(arg_4_1, nil, nil)

				if var_4_7 then
					for iter_4_4, iter_4_5 in pairs(var_4_5) do
						if iter_4_5:getID() == var_4_7:getID() then
							self.can_add = false
						end
					end

					if self.can_add == true then
						var_0_5(var_4_5, var_4_7)
						var_0_5(var_4_6, var_4_7:getID())
					end

					if #var_4_5 == var_4_3 then
						return var_4_5
					end
				end
			end

			return var_4_5
		end

		local var_4_8 = {}

		for iter_4_6, iter_4_7 in pairs(var_4_0) do
			if iter_4_7:get_attribute().ridicule then
				for iter_4_8, iter_4_9 in pairs(iter_4_7:get_attribute().ridicule.shipTypes) do
					if iter_4_7:get_ship_type() == iter_4_9 then
						iter_4_7:get_attribute().atked_weight = iter_4_7:get_attribute().ridicule.atked_weight
					end
				end
			end

			if iter_4_7:get_attribute().atked_weight and iter_4_7:get_attribute().atked_weight > 0 then
				var_4_8[iter_4_6] = iter_4_7:get_attribute().atked_weight

				self._battlefield:append_result(iter_4_7._cid, "技能效果", (string.format("增加被攻击概率:%s", iter_4_7:get_attribute().atked_weight)))
			end
		end

		local var_4_9 = {}

		for iter_4_10, iter_4_11 in pairs(var_4_8) do
			var_0_5(var_4_9, {
				index = iter_4_10,
				value = iter_4_11
			})
		end

		table.sort(var_4_9, function(arg_5_0, arg_5_1)
			return arg_5_0.value > arg_5_1.value
		end)

		local var_4_10 = var_4_0[self._battle_random:randRange(1, var_4_3)]

		for iter_4_12, iter_4_13 in pairs(var_4_9) do
			if self._battle_random:randomRangeDouble(0, 1) <= iter_4_13.value then
				var_4_10 = var_4_0[iter_4_13.index]

				break
			end
		end

		return (self:__get_special_target(true, var_4_10))
	end

	function arg_1_0:get_atk_rate()
		local var_6_0 = self:get_ship_cfg()

		if self._battle_scene:get_day_or_night_attack() == var_0_3.day_or_night.day then
			return var_6_0.day_atk_rate
		end

		return var_6_0.night_atk_rate
	end

	function arg_1_0:can_antisub()
		local var_7_0 = var_0_3:can_antisub(self._ship_type)

		if not self:get_undersea_target() or not var_7_0 then
			return false
		end

		if var_7_0 then
			return true
		end
	end

	function arg_1_0:is_can_antisub_ship(arg_8_1)
		local var_8_0 = var_0_3:is_normal_antisub_type(self._ship_type)

		if arg_8_1 == "normal_attack2" then
			local var_8_1 = self:get_attribute().skill_num.save_hit_complex_sub_target

			if var_8_1 and var_8_1.mixattack and var_8_1.use_attack then
				return false
			end

			var_8_0 = var_0_3:is_normal2_antisub_type(self._ship_type)

			if self._ship_type == var_0_3.ship_type_rule.aviation_battle_ship.value and not self:have_bomber_torpedoplane_or_spyplane() then
				var_8_0 = false
			end
		end

		if self._ship_type == var_0_3.ship_type_rule.light_aircraft_carrier.value then
			local var_8_2 = self:get_attribute().skill_num

			if not (self:hp_more_than_half() or var_8_2 and var_8_2.antisub_ignore_broken_hp or self:get_can_attack_in_broken()) or not self:have_bomber_torpedoplane_or_spyplane() then
				var_8_0 = false
			end
		end

		return var_8_0
	end

	function arg_1_0:can_normal_antisub(arg_9_1)
		if self:get_sea_target() and self._target_by_skill and (self:get_attribute().first_hit_by_type or self._can_normal_turn_to_torpedo or self:get_attribute().attack_scoure_index_target) then
			return false
		end

		if not self:get_undersea_target() or not self:is_can_antisub_ship(arg_9_1) then
			return false
		end

		if self:get_ship_type() == var_0_3.ship_type_rule.aadg.value and arg_9_1 == "night_attack" then
			return false
		end

		return true
	end

	function arg_1_0:can_night_antisub()
		if not self:get_undersea_target() or not var_0_3:can_night_antisub(self._ship_type) then
			return false
		end

		if self:get_sea_target() and self._target_by_skill and (self:get_attribute().first_hit_by_type or self._can_normal_turn_to_torpedo or self:get_attribute().attack_scoure_index_target) then
			return false
		end

		return true
	end

	function arg_1_0:can_night_missile()
		local var_11_0 = false
		local var_11_1 = false

		for iter_11_0, iter_11_1 in pairs(self._equip_list) do
			var_11_0 = (iter_11_1:equip_tmd_missile_launcher() or iter_11_1:equip_missile_launcher()) and true

			if iter_11_1:get_missile_num() > 0 or iter_11_1:get_tmd_missile_num() > 0 then
				var_11_1 = true
			end
		end

		return var_11_0 and var_11_1
	end

	function arg_1_0:normal_can_air_attack()
		local var_12_0 = 0

		for iter_12_0, iter_12_1 in pairs(self._equip_list) do
			if iter_12_1:is_bomber_or_torpedoplane() then
				var_12_0 = var_12_0 + iter_12_1:get_equip_num()
			end
		end

		return var_12_0 > 0
	end

	function arg_1_0:__get_special_target(arg_13_1, arg_13_2)
		local var_13_0 = var_0_3.obj_side.opposite(self._side)
		local var_13_1 = {}

		if arg_13_1 then
			local var_13_2 = self:get_skill_target()
			local var_13_3 = self:get_fight_back_target()

			if var_13_3 then
				var_13_2 = var_13_3

				self:set_fight_back_target(nil)
			end

			if var_13_2 and var_13_2:is_submarine() then
				arg_13_2 = var_13_2
			end

			var_13_1 = self._battle_obj_mgr:get_undersea_ships_by_side(var_13_0)
		else
			local var_13_4 = self:get_skill_target()
			local var_13_5 = self:get_fight_back_target()

			if var_13_5 then
				var_13_4 = var_13_5

				self:set_fight_back_target(nil)
			end

			if var_13_4 and not var_13_4:is_submarine() then
				arg_13_2 = var_13_4
			end

			var_13_1 = self._battle_obj_mgr:get_sea_ships_by_side(var_13_0)
		end

		local var_13_6 = false

		if self:get_attribute().first_hit_by_type then
			local var_13_8 = var_0_4:get_first_hit_targets(self, var_13_1)

			if #var_13_8 > 0 then
				var_13_1 = var_13_8
				arg_13_2 = var_13_8[self._battle_random:randRange(1, #var_13_8)]
				var_13_6 = true
			end
		end

		if self:get_attribute().first_hit_by_type_by_num then
			var_13_1 = self._battle_obj_mgr:get_alive_ships_by_side(var_13_0)

			local var_13_10 = {}

			table.insert(var_13_10, var_0_4:first_hit_by_type_by_num_targets(self, var_13_1)[1])

			if #var_13_10 > 0 then
				var_13_1 = var_13_10
				arg_13_2 = var_13_10[1]
				var_13_6 = true
			end
		end

		if self:get_attribute().limited_attack_by_flag then
			local var_13_12 = var_0_4:first_hit_by_flag_targets(self, var_13_1)

			if #var_13_12 > 0 then
				var_13_1 = var_13_12
				arg_13_2 = var_13_12[1]
				var_13_6 = true
			end
		end

		if self:get_attribute().limited_attack_by_not_flag then
			local var_13_14 = var_0_4:first_hit_by_not_flag_targets(self, var_13_1)

			if #var_13_14 > 0 then
				var_13_1 = var_13_14
				arg_13_2 = var_13_14[1]
				var_13_6 = true
			end
		end

		if self:get_attribute().attack_scoure_index_target then
			local var_13_16 = var_0_4:attack_scoure_index_target(self, var_13_1)

			if #var_13_16 > 0 then
				var_13_1 = var_13_16
				arg_13_2 = var_13_16[1]
				var_13_6 = true
			end
		end

		if self:get_attribute().first_hit_by_max_attr then
			local var_13_18 = var_0_4:first_hit_by_max_attr_targets(self, var_13_1)

			if #var_13_18 > 0 then
				var_13_1 = var_13_18
				arg_13_2 = var_13_18[1]
				var_13_6 = true
			end
		end

		if self:get_attribute().first_hit_by_min_attr then
			local var_13_20 = var_0_4:first_hit_by_min_attr_targets(self, var_13_1)

			if #var_13_20 > 0 then
				arg_13_2 = var_13_20[1]
				var_13_6 = true
			end
		end

		self._target_by_skill = var_13_6

		return arg_13_2
	end

	function arg_1_0:get_hit_complex_targets(arg_14_1, arg_14_2, arg_14_3)
		local var_14_0 = self:get_sea_target(nil, nil, arg_14_3)
		local var_14_1 = {}
		local var_14_2
		local var_14_3

		var_0_5(var_14_1, var_14_0)

		local var_14_4 = var_14_0:get_index()

		for iter_14_0, iter_14_1 in pairs(arg_14_1) do
			if iter_14_1:get_index() == var_14_4 + 1 then
				var_14_2 = iter_14_1
			end

			if iter_14_1:get_index() == var_14_4 - 1 then
				var_14_3 = iter_14_1
			end
		end

		if arg_14_2 == 3 then
			if var_14_2 then
				var_0_5(var_14_1, var_14_2)
			end

			if var_14_3 then
				var_0_5(var_14_1, var_14_3)
			end
		end

		if arg_14_2 == 2 then
			if var_14_2 and not var_14_3 then
				var_0_5(var_14_1, var_14_2)
			end

			if var_14_3 and not var_14_2 then
				var_0_5(var_14_1, var_14_3)
			end

			if var_14_3 and var_14_2 then
				local var_14_5 = self._battle_random:randRange(1, 2)

				if var_14_5 == 1 then
					var_0_5(var_14_1, var_14_3)
				elseif var_14_5 == 2 then
					var_0_5(var_14_1, var_14_3)
				end
			end
		end

		return var_14_1
	end
end

function var_0_0.extend_obj(arg_15_0)
	return
end

return var_0_0
