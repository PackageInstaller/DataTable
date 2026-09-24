local var_0_0 = {}
local var_0_3 = gamecore.damage_info
local var_0_4 = gamecore.torpedo_logic
local var_0_5 = gameenum.battle_type
local var_0_6 = table.insert
local var_0_7 = gamecore.battle_util
local var_0_8 = tostring
local var_0_9 = string.sub
local var_0_12 = gameconfig.pve_mix_map_config
local var_0_13 = gameconfig.pve_eighth_map_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:torpedo_attack(arg_2_1, arg_2_2)
		local var_2_0 = false

		for iter_2_0, iter_2_1 in pairs(self:get_is_not_attack_for_type()) do
			if var_0_7:judge_stage(iter_2_1, self._battlefield._battle_step) then
				var_2_0 = true
			end
		end

		if not self:get_attack_state() then
			var_2_0 = true
		end

		if not self:get_can_attack_if_middle_or_big_break() then
			var_2_0 = true
		end

		if (not self:hp_more_than_quarter() and not self._battle_scene:get_attack_state_by_hp(nil, self) and not self:get_can_attack_in_broken() or nil) and true then
			if self:get_attribute().phase_no_damage_by_phase_attack then
				local var_2_1 = self:get_attribute().phase_no_damage_by_phase_attack

				for iter_2_2, iter_2_3 in pairs(var_2_1.action_stage) do
					if var_0_7:judge_stage(iter_2_3, self._battlefield._battle_step) then
						self:set_attack_step_again_type(var_2_1.buff_stage[1], var_2_1.add_num)
					end
				end
			end

			return
		end

		local var_2_2
		local var_2_3
		local var_2_4

		if arg_2_1 == "night_attack" then
			var_2_2 = "夜战鱼雷攻击"
			var_2_3 = "night_torpedo_attack"
			var_2_4 = 7
		end

		if arg_2_1 == "torpedo_attack" then
			var_2_2 = "鱼雷战"
			var_2_3 = arg_2_1
			var_2_4 = 6
		end

		if arg_2_1 == "open_torpedo_attack" then
			var_2_2 = "开幕雷击"
			var_2_3 = arg_2_1
			var_2_4 = 4
		end

		local var_2_5 = self:get_atk_rate()
		local var_2_6, var_2_7 = self:__get_torpedo_attack_target(var_2_3)

		if not var_2_6 then
			return
		end

		if not var_2_6[1] then
			return
		end

		local var_2_8
		local var_2_9
		local var_2_11
		local var_2_12
		local var_2_13
		local var_2_14
		local var_2_15
		local var_2_16

		if arg_2_1 == "open_torpedo_attack" and self:get_attribute().couple_by_shipcid then
			for iter_2_4, iter_2_5 in pairs((self._battle_obj_mgr:get_ships_by_side(self._side))) do
				for iter_2_6, iter_2_7 in pairs(self:get_attribute().couple_by_shipcid.couple) do
					for iter_2_8, iter_2_9 in pairs(iter_2_7) do
						local var_2_19, var_2_20, var_2_21

						if iter_2_9 == iter_2_5:get_cid() and iter_2_5:get_is_alive() and not iter_2_5:is_lowhp() then
							if iter_2_5:get_attribute().couple_by_shipcid then
								if iter_2_5:get_cid() ~= self:get_cid() then
									var_2_8 = iter_2_5:get_index()
									var_2_19 = iter_2_5:getID()
									var_2_9 = iter_2_5:get_cid()
									var_2_20 = true
									iter_2_5:get_attribute().couple_by_shipcid.rate = var_2_11

									if var_2_11 then
										if var_2_11 > iter_2_5:get_attribute().couple_by_shipcid.hurt_rate then
											var_2_11 = iter_2_5:get_attribute().couple_by_shipcid.hurt_rate
										end
									else
										var_2_11 = iter_2_5:get_attribute().couple_by_shipcid.hurt_rate
									end
								else
									var_2_21 = true

									if var_2_11 then
										if var_2_11 > iter_2_5:get_attribute().couple_by_shipcid.hurt_rate then
											var_2_11 = iter_2_5:get_attribute().couple_by_shipcid.hurt_rate
										end
									else
										var_2_11 = iter_2_5:get_attribute().couple_by_shipcid.hurt_rate
									end
								end
							end
						elseif iter_2_9 == iter_2_5:get_cid() and (not iter_2_5:get_is_alive() or iter_2_5:is_lowhp()) then
							return
						end
					end
				end
			end

			if false == true and false == true then
				self:get_attribute().skill_num = self:get_attribute().skill_num or {}

				if var_2_8 > self:get_index() then
					var_0_6(var_2_6, self:get_sea_target(nil, nil, arg_2_1))

					self:get_attribute().skill_num.couple_cid_list = {
						self:get_cid(),
						var_2_9
					}
				else
					self:get_attribute().skill_num.couple_cid_list = {
						var_2_9,
						(self:get_cid())
					}
				end

				if var_2_8 < self:get_index() then
					var_2_13 = nil
					var_2_14 = var_2_9
					var_2_15 = 3
					var_2_16 = true
				end

				var_2_12 = var_2_11
			end
		end

		local var_2_22
		local var_2_23

		for iter_2_10, iter_2_11 in pairs(var_2_6) do
			if not var_2_16 then
				var_2_15 = iter_2_10
			end

			self:__init_skill_by_stage(nil, true)
			self:__init_skill_by_stage(var_2_4, nil)

			if self:get_attribute().hit_complex_target and #self._battle_obj_mgr:get_alive_ships_by_side(-self:get_side()) > self:get_attribute().hit_complex_target.num2 then
				var_2_22 = self:get_attribute().hit_complex_target.hurt_rates
			end

			if self:get_attribute().hit_adjacent_complex_target then
				var_2_22 = self:get_attribute().hit_adjacent_complex_target.hurt_rates
			end

			if var_2_22 then
				var_2_23 = var_2_22[iter_2_10]
			end

			if self:get_attribute()._attack_cause_damage and self:__get_ship_ton_type(var_2_6, self:get_attribute()._attack_cause_damage.ship_tons) then
				var_2_23 = self:get_attribute()._attack_cause_damage.hurt_rate
			end

			if self:get_attribute()._attack_rate then
				var_2_5 = self:get_attribute()._attack_rate.rate
			end

			local var_2_24 = var_0_3:create()

			var_2_24:bind(self._battlefield)
			var_2_24:set_atk_rate(var_2_5)
			var_2_24:init({
				type = "torpedo_attack",
				source_id = self._id,
				target_id = iter_2_11:getID(),
				hurt_rate = var_2_23,
				formation_attack_type = arg_2_1 == "night_attack" and "night_attack" or "torpedo_attack",
				syncytium_skill = var_2_12
			})

			local var_2_25 = self._battle_obj_mgr:createObject(var_0_4, {
				owner_id = self:getID()
			})

			if self.skill_num.attach_torpedo then
				var_2_24:get_damageattr().tactics_id = self.skill_num.attach_torpedo

				if iter_2_10 == #var_2_6 then
					self.skill_num.attach_torpedo = nil
				end
			end

			self._battlefield:append_result(self._cid, var_2_2, {
				name = var_2_2,
				target_id = iter_2_11:get_cid(),
				target_name = iter_2_11:get_ship_name(),
				damage_record = var_2_24:get_damage_record()
			})

			self._battlefield._battle_report[arg_2_1] = self._battlefield._battle_report[arg_2_1] or {}
			self._battlefield._battle_report[arg_2_1][arg_2_2] = self._battlefield._battle_report[arg_2_1][arg_2_2] or {}

			local var_2_27 = self._battlefield._battle_report[arg_2_1][arg_2_2]
			local var_2_28 = {
				attack_id = self:getID(),
				target_id = iter_2_11:getID()
			}

			var_2_28.target_now_hp = iter_2_11:get_attribute().now_hp:get_final_value()
			var_2_28.damage_info = var_2_24:get_damageattr()
			var_2_28.torpedo_id = var_2_25 and var_2_25:getID() or nil
			var_2_28.syncytium_skill_id = var_2_13 and var_2_13 or nil
			var_2_28.syncytium_skill_cid = var_2_14 and var_2_14 or nil
			var_2_28.damage_count = var_2_15 and var_2_15 or nil
			var_2_28.damage_delay = arg_2_2
			var_2_28.step = arg_2_1
			var_2_28.target_count = iter_2_10
			var_2_28.side = self._side
			var_2_27[iter_2_10] = var_2_28

			if iter_2_10 == #var_2_6 then
				self._battlefield._normal_index = self._battlefield._normal_index + 1
			end

			if iter_2_11:get_attribute().now_hp:get_final_value() == 0 and arg_2_1 == "night_attack" then
				iter_2_11:set_is_alive(false)

				if iter_2_11:get_side() == var_0_5.obj_side.player then
					self._battlefield:eventOnPlayerDie(iter_2_11:getID())
				else
					self._battlefield:eventOnEnemyDie(iter_2_11:getID())
				end
			end

			if arg_2_1 == "night_attack" then
				self._battlefield._battle_report[arg_2_1][arg_2_2].type = "torpedo_attack"

				self:torpedo_attack_recovery(iter_2_11, arg_2_1, arg_2_2, iter_2_10)
				iter_2_11:set_attack_ropund_type(var_0_5.attack_round_type.night)
			end
		end
	end

	function arg_1_0:torpedo_attack_recovery(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		if self._battle_scene:get_fight_type() == var_0_5.fight_type.maneuver then
			return
		end

		local var_3_0 = arg_3_1:get_attribute()
		local var_3_1 = self._battle_scene:get_damage_control_num()

		if arg_3_1:get_side() == var_0_5.obj_side.player and var_3_1 > 0 and var_3_0.now_hp:get_final_value() <= 0 then
			local var_3_2 = var_3_0.hp:get_final_value()

			var_3_0.now_hp:modify_to_value(var_3_2)
			arg_3_1:set_is_alive(true)
			self._battle_scene:set_damage_control_num(var_3_1 - 1)
			self._battle_scene:set_damage_control_last_hp_num(var_3_0.now_hp._damage_control_value, arg_3_1:get_character_id())

			self._battlefield._battle_report[arg_3_2][arg_3_3][arg_3_4].recovery = {
				recovery_id = arg_3_1:getID(),
				now_hp = var_3_0.now_hp:get_final_value(),
				max_hp = var_3_2
			}

			arg_3_1:set_is_ignore_damage_protect(false)
		end
	end

	function arg_1_0:__get_torpedo_attack_target(arg_4_1)
		local var_4_1 = {}
		local var_4_4 = self:get_sea_target(nil, nil, arg_4_1)

		if var_4_4 then
			var_0_6(var_4_1, var_4_4)
		end

		if self:get_attribute().hit_complex_target and #self._battle_obj_mgr:get_alive_ships_by_side(-self:get_side()) > self:get_attribute().hit_complex_target.num2 then
			var_4_1 = self:get_sea_target(self:get_attribute().hit_complex_target.num, nil, arg_4_1, true)
		end

		if self:get_attribute().hit_adjacent_complex_target then
			var_4_1 = self:get_sea_target(self:get_attribute().hit_adjacent_complex_target.num, nil, arg_4_1, true)
		end

		if self:get_attribute()._attack_cause_damage then
			var_4_1 = self:get_sea_target(self:get_attribute()._attack_cause_damage.num, nil, arg_4_1, true)
		end

		if arg_4_1 == "torpedo_attack" then
			if self:get_attribute().attach_torpedo and self:__get_trigger_persentage(self:get_attribute().attach_torpedo.num * 100) then
				if not self:__ignore_tactics_by_map() then
					self:set_tactics_trigger_count(1, self:get_attribute().attach_torpedo.id)
				end

				var_0_6(var_4_1, (self:get_sea_target(nil, nil, arg_4_1)))

				self.skill_num = self.skill_num or {}
				self.skill_num.attach_torpedo = self:get_attribute().attach_torpedo.id
				self.skill_num.attach_torpedo = self:get_attribute().attach_torpedo.id
			end

			if self:get_attribute().phase_no_damage_by_phase_attack and self:get_attack_step_again_type() and next(self:get_attack_step_again_type()) then
				var_0_6(var_4_1, (self:get_sea_target(nil, nil, arg_4_1)))
			end
		end

		return var_4_1, false
	end

	function arg_1_0:__get_trigger_persentage(arg_5_1)
		if arg_5_1 >= self._battle_random:randRange(1, 100) then
			return true
		end

		return false
	end

	function arg_1_0.__flite_facilities(arg_6_0, arg_6_1)
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in pairs(arg_6_1) do
			if not iter_6_1:is_facilities() then
				var_0_6(var_6_0, iter_6_1)
			end
		end

		return var_6_0
	end

	function arg_1_0:__ignore_tactics_by_map()
		local var_7_0 = self._battle_scene:get_map_id()
		local var_7_1 = self._battle_scene:get_battle_point()
		local var_7_2 = false
		local var_7_3 = var_0_9(var_0_8(var_7_1), 1, 3)
		local var_7_4 = var_0_9(var_0_8(var_7_1), 1, 4)

		if self._battle_scene:get_fight_type() == var_0_5.fight_type.main then
			for iter_7_0, iter_7_1 in pairs(var_0_5.ignore_tactics_maps) do
				if var_7_3 == iter_7_1 then
					var_7_2 = true
				end
			end
		end

		if self._battle_scene:get_fight_type() == var_0_5.fight_type.seventh then
			local var_7_6 = var_0_12.find_object_by_id(var_7_0)

			if var_7_6 then
				return var_7_6.difficulty == 0
			end
		end

		if self._battle_scene:get_fight_type() == var_0_5.fight_type.eighth then
			local var_7_7 = var_0_13.find_object_by_id(var_7_0)

			if var_7_7 then
				return var_7_7.difficulty == 0
			end
		end

		if not var_7_1 then
			return true
		end

		if var_7_1 >= 953601 and var_7_1 <= 953919 then
			return true
		end

		for iter_7_2, iter_7_3 in pairs(var_0_5.ignore_tactics_battle_point) do
			if var_7_4 == iter_7_3 then
				var_7_2 = true
			end
		end

		if self._battle_scene:get_fight_type() == var_0_5.fight_type.score then
			local var_7_8 = var_0_9(var_0_8(var_7_1), 1, 5)

			for iter_7_4, iter_7_5 in pairs(var_0_5.ignore_tactics_score_maps) do
				if var_7_8 == iter_7_5 then
					var_7_2 = true
				end
			end
		end

		if self._battle_scene:get_fight_type() == var_0_5.fight_type.ninth then
			local var_7_9 = var_0_9(var_0_8(var_7_1), 1, 5)

			for iter_7_6, iter_7_7 in pairs(var_0_5.ignore_tactics_ninth_maps) do
				if var_7_9 == iter_7_7 then
					var_7_2 = true
				end
			end
		end

		if self._battle_scene:get_fight_type() == var_0_5.fight_type.campaign then
			return false
		end

		return var_7_2
	end
end

function var_0_0.extend_obj(arg_8_0)
	return
end

return var_0_0
