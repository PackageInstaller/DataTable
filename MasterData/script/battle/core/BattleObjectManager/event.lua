local var_0_0 = {}
local var_0_4 = gameenum.battle_type
local var_0_8 = gamecore.battle_util
local var_0_9 = gameconfig.skill_config
local var_0_10 = gameconfig.ship_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__eventOnInit(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.player) do
			if iter_2_1.attrs.now_hp ~= 0 then
				self:createObject(gamecore.player_logic, iter_2_1)
			end
		end

		for iter_2_2, iter_2_3 in pairs(arg_2_1.enemy) do
			self:createObject(gamecore.enemy_logic, iter_2_3)

			if iter_2_3.ship_type ~= var_0_4.ship_type_rule.submarine_strategic_carrier.value and iter_2_3.ship_type ~= var_0_4.ship_type_rule.submarine.value then
				self._is_all_dunker = false
			end
		end

		self:__calculate_attr_by_pre_effect()
		self:__calculate_cause_info()
		self:__restore_attr_by_pre_effect()

		if not self._battlefield.is_test then
			self._battle_processor:eventOnShowBattleCourse()
		end
	end

	function arg_1_0:__eventOnDestroy()
		local var_3_0 = {}

		for iter_3_0, iter_3_1 in pairs(self._object_set) do
			var_3_0[iter_3_0] = iter_3_0
		end

		for iter_3_2, iter_3_3 in pairs(var_3_0) do
			self:removeObject(iter_3_2)
		end
	end

	function arg_1_0.__eventOnCreateObject(arg_4_0, arg_4_1, ...)
		arg_4_1:__eventOnInit(...)
	end

	function arg_1_0.__eventOnRemoveObject(arg_5_0, arg_5_1)
		arg_5_1:__eventOnDestroy()
	end

	function arg_1_0:__eventOnFrame(arg_6_1)
		for iter_6_0, iter_6_1 in pairs(self._object_set) do
			iter_6_1:__eventOnFrame(arg_6_1)
		end
	end

	function arg_1_0:__is_cancel_reversal_course()
		for iter_7_0, iter_7_1 in pairs((self:get_ships_by_side(var_0_4.obj_side.player))) do
			local var_7_0 = var_0_9.find_object_by_skill_type_skill_level(iter_7_1._skill_data.skill, iter_7_1._skill_data.skill_level)

			if var_7_0 then
				for iter_7_2, iter_7_3 in pairs(var_7_0.effect or {}) do
					for iter_7_4, iter_7_5 in pairs(iter_7_3.effect or {}) do
						if iter_7_5.type == var_0_4.action_type.cancel_reversal_course and self._battle_scene:__get_skill_conditioin_by_config(iter_7_3, iter_7_1:getID()) then
							return true
						end
					end
				end
			end
		end

		return false
	end

	function arg_1_0:__calculate_cause_info()
		local var_8_0 = self:get_ships_by_side(var_0_4.obj_side.player)
		local var_8_1 = self:get_ships_by_side(var_0_4.obj_side.enemy)

		if not var_8_1 or not next(var_8_1) then
			return
		end

		local var_8_2 = var_8_0[1]:get_attribute().speed
		local var_8_3 = var_8_1[1]:get_attribute().speed
		local var_8_4 = var_0_8:get_avg_speed(var_8_0)
		local var_8_5, var_8_6 = var_0_8:get_fleet_course(self._battle_scene:get_radar_state(), var_8_2:get_final_value() < 0 and 0 or var_8_2:get_final_value(), var_8_4, var_8_3:get_final_value() < 0 and 0 or var_8_3:get_final_value(), var_0_8:get_avg_speed(var_8_1), self._battle_random, (self:__is_cancel_reversal_course()))

		self._battle_scene:set_player_course(var_8_5.value)
		self._battle_scene:set_enemy_course(var_8_5.opposite)

		if self._battle_scene:get_fix_player_course() then
			local var_8_7 = self._battle_scene:get_player_course()

			if var_8_7 == var_0_4.course_type_rule.reversal.value then
				self._battle_scene:set_player_course(var_0_4.course_type_rule.same.value)
				self._battle_scene:set_enemy_course(var_0_4.course_type_rule.same.value)

				var_8_5 = var_0_4.course_type_rule.same
			elseif var_8_7 == var_0_4.course_type_rule.t_disadvantage.value then
				self._battle_scene:set_player_course(var_0_4.course_type_rule.t_advantage.value)
				self._battle_scene:set_enemy_course(var_0_4.course_type_rule.t_disadvantage.value)

				var_8_5 = var_0_4.course_type_rule.t_advantage
			end
		end

		self._battle_scene:set_player_speed(var_8_4)

		var_8_6.玩家航向 = var_8_5.value

		self._battlefield:append_result(var_8_0[1]:get_cid(), "玩家航向计算", var_8_6)
	end

	function arg_1_0:__calculate_attr_by_pre_effect()
		local var_9_0 = self:get_ships_by_side(var_0_4.obj_side.player)

		for iter_9_0, iter_9_1 in pairs(var_9_0) do
			self:__set_buff_data_by_skill(iter_9_1, var_9_0)
		end
	end

	function arg_1_0:__restore_attr_by_pre_effect()
		local var_10_0 = self:get_ships_by_side(var_0_4.obj_side.player)

		for iter_10_0, iter_10_1 in pairs(var_10_0) do
			self:__set_buff_data_by_skill(iter_10_1, var_10_0, true)
		end
	end

	function arg_1_0:__set_buff_data_by_skill(arg_11_1, arg_11_2, arg_11_3)
		local var_11_0 = var_0_9.find_object_by_skill_type_skill_level(arg_11_1._skill_data.skill, arg_11_1._skill_data.skill_level)

		if not var_11_0 then
			return
		end

		if not var_11_0.pre_effect[1] then
			return
		end

		for iter_11_0, iter_11_1 in pairs(var_11_0.pre_effect) do
			local var_11_1 = false

			if iter_11_1.condition then
				for iter_11_2, iter_11_3 in pairs(iter_11_1.condition) do
					if iter_11_3.type == 43 then
						local var_11_2 = true

						for iter_11_4, iter_11_5 in pairs(arg_11_2) do
							if iter_11_5._index ~= arg_11_1._index then
								for iter_11_6, iter_11_7 in pairs(iter_11_3.shipTypes) do
									if iter_11_5._ship_type == iter_11_7 then
										var_11_2 = false
									end
								end
							end
						end

						var_11_1 = var_11_2
					elseif iter_11_3.type == 26 then
						for iter_11_8, iter_11_9 in pairs(arg_11_2) do
							if iter_11_9._index == arg_11_1._index and iter_11_8 == 1 then
								var_11_1 = true
							end
						end
					end
				end
			else
				var_11_1 = true
			end

			if var_11_1 == false then
				return
			end

			for iter_11_10, iter_11_11 in pairs(iter_11_1.target) do
				if iter_11_11.type == 2 then
					local var_11_3 = 0

					for iter_11_12, iter_11_13 in pairs(arg_11_2) do
						if iter_11_13._index == arg_11_1._index then
							var_11_3 = iter_11_12
						end
					end

					for iter_11_14, iter_11_15 in pairs(iter_11_11.shipTypes) do
						if arg_11_2[var_11_3 - 1] and arg_11_2[var_11_3 - 1]._ship_type == iter_11_15 then
							self:__set_buff_data_by_skill_by_effect(arg_11_2[var_11_3 - 1], iter_11_1.effect, arg_11_3)
						end

						if arg_11_2[var_11_3 + 1] and arg_11_2[var_11_3 + 1]._ship_type == iter_11_15 then
							self:__set_buff_data_by_skill_by_effect(arg_11_2[var_11_3 + 1], iter_11_1.effect, arg_11_3)
						end
					end
				elseif iter_11_11.type == 4 then
					local var_11_4 = 0

					for iter_11_16, iter_11_17 in pairs(arg_11_2) do
						if iter_11_17._index == arg_11_1._index then
							var_11_4 = iter_11_16
						end
					end

					for iter_11_18, iter_11_19 in pairs(arg_11_2) do
						if iter_11_18 < var_11_4 and iter_11_18 >= var_11_4 - iter_11_11.num then
							self:__set_buff_data_by_skill_by_effect(iter_11_19, iter_11_1.effect, arg_11_3)
						end
					end
				elseif iter_11_11.type == 8 then
					for iter_11_20, iter_11_21 in pairs(arg_11_2) do
						self:__set_buff_data_by_skill_by_effect(iter_11_21, iter_11_1.effect, arg_11_3)
					end
				elseif iter_11_11.type == 7 then
					self:__set_buff_data_by_skill_by_effect(arg_11_1, iter_11_1.effect, arg_11_3)
				elseif iter_11_11.type == 10 then
					for iter_11_22, iter_11_23 in pairs(arg_11_2) do
						local var_11_5 = var_0_10.find_object_by_cid(iter_11_23:get_cid())

						if var_11_5 then
							for iter_11_24, iter_11_25 in pairs(iter_11_11.country) do
								if var_11_5.country == iter_11_25 then
									self:__set_buff_data_by_skill_by_effect(iter_11_23, iter_11_1.effect, arg_11_3)

									break
								end
							end
						end
					end
				elseif iter_11_11.type == 11 or iter_11_11.type == 12 then
					for iter_11_26, iter_11_27 in pairs(arg_11_2) do
						local var_11_6 = var_0_10.find_object_by_cid(iter_11_27:get_cid())

						if var_11_6 then
							local var_11_7 = false

							for iter_11_28, iter_11_29 in pairs(iter_11_11.shipTypes or {}) do
								if var_11_6.type == iter_11_29 then
									var_11_7 = true

									break
								end
							end

							if not var_11_7 then
								for iter_11_30, iter_11_31 in pairs(iter_11_11.shipTons or {}) do
									if var_11_6.ship_ton == iter_11_31 then
										var_11_7 = true

										break
									end
								end
							end

							if not var_11_7 then
								for iter_11_32, iter_11_33 in pairs(iter_11_11.guardTypes or {}) do
									if var_11_6.guard_type == iter_11_33 then
										var_11_7 = true

										break
									end
								end
							end

							local var_11_10 = true

							if iter_11_11.type == 12 then
								var_11_10 = false

								for iter_11_34, iter_11_35 in pairs(iter_11_11.country or {}) do
									if var_11_6.country == iter_11_35 then
										var_11_10 = true

										break
									end
								end
							end

							if var_11_7 and var_11_10 then
								self:__set_buff_data_by_skill_by_effect(iter_11_27, iter_11_1.effect, arg_11_3)
							end
						end
					end
				end
			end
		end
	end

	function arg_1_0.__set_buff_data_by_skill_by_effect(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		local var_12_0 = arg_12_1:get_attribute()

		for iter_12_0, iter_12_1 in pairs(arg_12_2) do
			if iter_12_1.type == 3 then
				for iter_12_2, iter_12_3 in pairs(iter_12_1) do
					if iter_12_2 ~= "type" and var_12_0[iter_12_2] then
						local var_12_1 = var_12_0[iter_12_2]:get_final_value()

						if not arg_12_3 then
							var_12_0[iter_12_2]:modify_to_value(var_12_1 + iter_12_3)
						else
							var_12_0[iter_12_2]:modify_to_value(var_12_1 - iter_12_3)
						end
					end
				end
			end
		end
	end
end

function var_0_0.extend_obj(arg_13_0)
	return
end

return var_0_0
