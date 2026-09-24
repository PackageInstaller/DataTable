local var_0_0 = {}
local var_0_1 = gameenum.battle_type
local var_0_2 = gamecore.damage_info
local var_0_3 = gamecore.projectile_logic
local var_0_4 = gamecore.aircraft_logic
local var_0_5 = gamecore.bomb_logic
local var_0_6 = gamecore.depthcharge_logic
local var_0_9 = gamecore.torpedo_logic
local var_0_10 = gameconfig.skill_config
local var_0_11 = gamecore.battle_util
local var_0_12 = table.insert

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:normal_attack(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		local var_2_0 = {}

		if arg_2_3 == nil then
			arg_2_3 = false
		end

		local var_2_3 = false

		self:get_attribute().skill_num = self:get_attribute().skill_num or {}

		if arg_2_1 == "normal_attack" then
			if self:get_attribute().skill_num.can_not_shout_and_shout_with_teammate_save_list and not self:get_attribute().skill_num.can_not_shout_and_shout_with_teammate.can_shout then
				var_2_3 = true
			end
		elseif arg_2_1 == "night_attack" and self:get_attribute().skill_num.can_not_shout_and_shout_with_teammate_save_list and next(self:get_attribute().skill_num.can_not_shout_and_shout_with_teammate_save_list.ship_list) then
			self:get_attribute().skill_num.can_not_shout_and_shout_with_teammate_save_list.ship_list = {}
			self:get_attribute().skill_num.can_not_shout_and_shout_with_teammate.can_shout = false
		end

		if not self:get_can_attack_if_middle_or_big_break() and not arg_2_3 then
			var_2_3 = true
		end

		if not self:get_attack_state() then
			var_2_3 = true
		end

		if (self._ship_type == var_0_1.ship_type.aircraft_carrier or self._ship_type == var_0_1.ship_type.light_aircraft_carrier) and not self:hp_more_than_half() and not self._battle_scene:get_attack_state_by_hp(nil, self) and not arg_2_3 and not self:get_can_attack_in_broken() then
			local var_2_4 = self:get_attribute().skill_num
			local var_2_5

			if var_2_4 then
				::label_2_0::

				var_2_5 = var_2_4.antisub_ignore_broken_hp and self._ship_type == var_0_1.ship_type.light_aircraft_carrier
			end

			local var_2_6 = false

			if var_2_5 then
				local var_2_7 = self._battle_obj_mgr:get_undersea_ships_by_side(var_0_1.obj_side.opposite(self._side))

				var_2_6 = var_2_7 and #var_2_7 > 0
			end

			if not var_2_6 then
				var_2_3 = true
			end
		end

		if self._ship_type == var_0_1.ship_type.seaplane_tender and not self:hp_more_than_quarter() and not self._battle_scene:get_attack_state_by_hp(nil, self) and not self:get_can_attack_in_broken() then
			var_2_3 = true
		end

		for iter_2_0, iter_2_1 in pairs(self:get_is_not_attack_for_type()) do
			if var_0_11:judge_stage(iter_2_1, self._battlefield._battle_step) then
				var_2_3 = true
			end
		end

		if var_2_3 then
			if self:get_attribute().phase_no_damage_by_phase_attack then
				local var_2_8 = self:get_attribute().phase_no_damage_by_phase_attack

				for iter_2_2, iter_2_3 in pairs(var_2_8.action_stage) do
					if var_0_11:judge_stage(iter_2_3, self._battlefield._battle_step) then
						self:set_attack_step_again_type(var_2_8.buff_stage[1], var_2_8.add_num)
					end
				end
			end

			return var_2_0
		end

		local var_2_10
		local var_2_11

		if arg_2_1 == "normal_attack" then
			var_2_10 = "首轮炮击"
			var_2_11 = 9
		end

		if arg_2_1 == "normal_attack2" then
			var_2_10 = "次轮炮击"
			var_2_11 = 10
		end

		if arg_2_1 == "night_attack" then
			var_2_10 = "夜战炮击"
			var_2_11 = 7
		end

		self:__init_skill_by_stage(nil, true)
		self:__init_skill_by_stage(var_2_11, nil)

		local var_2_12 = self:get_atk_rate()
		local var_2_13 = self:get_ship_cfg()
		local var_2_14 = {
			owner_id = self:getID()
		}
		local var_2_15
		local var_2_16
		local var_2_17
		local var_2_18
		local var_2_19
		local var_2_20
		local var_2_22
		local var_2_23
		local var_2_24
		local var_2_25
		local var_2_26
		local var_2_27
		local var_2_31 = self:__get_normal_attack_type()

		if var_2_31 == var_0_1.normal_attack_type.aircraft and not self:normal_can_air_attack() then
			return var_2_0
		end

		local var_2_32, var_2_33, var_2_34 = self:__get_normal_attack_target(arg_2_1)

		if arg_2_4 then
			local var_2_35 = self._battle_obj_mgr:findObject(arg_2_4)

			if var_2_35 then
				if var_2_35:is_submarine() then
					if self:is_can_antisub_ship(arg_2_1) then
						var_2_32 = {
							var_2_35
						}
						var_2_33 = true
					else
						var_2_32 = {}
						var_2_33 = false
					end
				else
					var_2_32 = {
						var_2_35
					}
					var_2_33 = false
				end
			end

			var_2_34 = nil
		end

		if self:get_attribute().one_more_attack_and_not_shout_by_stage then
			table.insert(var_2_32, var_2_32[1])

			self:get_attribute().is_show_cutin = true

			self:set_is_not_attack_for_type(self:get_attribute().one_more_attack_and_not_shout_by_stage)
		end

		if not var_2_32 then
			return var_2_0
		end

		if not var_2_32[1] then
			return var_2_0
		end

		for iter_2_4, iter_2_5 in pairs(var_2_32) do
			if iter_2_4 ~= 1 then
				var_2_26 = true
			end

			if self and self:get_attribute().probability then
				self:get_attribute().probability.determine = self._battle_random:randomRangeDouble(0, 1) <= self:get_attribute().probability.rate
				self:get_attribute().probability.is_random = true
			end

			if iter_2_5:get_attribute().more_probability_save then
				local var_2_36 = {}
				local var_2_37 = self._battle_random:randomRangeDouble(0, 1)

				for iter_2_6, iter_2_7 in pairs(iter_2_5:get_attribute().more_probability_save) do
					if var_2_37 <= iter_2_7.rate then
						iter_2_7.determine = true

						var_0_12(var_2_36, iter_2_7)
					end
				end

				if not next(var_2_36) then
					if iter_2_5:get_attribute().probability then
						local var_2_38 = self._battle_random:randomRangeDouble(0, 1)

						if var_2_38 > iter_2_5:get_attribute().probability.rate then
							iter_2_5:get_attribute().probability.determine = false
						elseif var_2_38 <= iter_2_5:get_attribute().probability.rate then
							iter_2_5:get_attribute().probability.determine = true
						elseif iter_2_5:get_attribute().probability.rate == 1 then
							iter_2_5:get_attribute().probability.determine = true
						end
					end
				else
					iter_2_5:get_attribute().probability = var_2_36[1]

					for iter_2_8, iter_2_9 in pairs(var_2_36) do
						if iter_2_9.rate == 1 then
							iter_2_5:get_attribute().probability = iter_2_9
						end
					end
				end

				iter_2_5:get_attribute().probability.is_random = true
			end

			if (not iter_2_5:get_attribute().probability or iter_2_5:get_attribute().probability.determine == true) and iter_2_5:get_attribute().replace_target_damage then
				for iter_2_10, iter_2_11 in pairs(iter_2_5:get_attribute().replace_target_damage) do
					if iter_2_10 == iter_2_5:get_attribute().probability.guardianer_pos then
						var_2_23 = self._battle_obj_mgr:findObject(iter_2_11)

						if var_2_23:get_is_alive() and var_2_23:get_attribute().skill_num.guardian.num > 0 then
							local var_2_39

							if iter_2_5:get_attribute().probability then
								iter_2_5:get_attribute().probability.determine = self._battle_random:randomRangeDouble(0, 1) <= iter_2_5:get_attribute().probability.rate

								for iter_2_12, iter_2_13 in pairs(iter_2_5:get_attribute().probability.num) do
									if iter_2_13 == 2 then
										var_2_39 = true
									end
								end
							end

							if not iter_2_5:get_attribute().probability or var_2_39 then
								var_2_22 = iter_2_5
								iter_2_5 = var_2_23
								var_2_23:get_attribute().in_guardian = true
								iter_2_5:get_attribute().skill_num.guardian.num = var_2_23:get_attribute().skill_num.guardian.num - 1

								break
							end
						end
					end
				end
			end

			if iter_2_5:get_fight_target() == iter_2_5 and not iter_2_5:get_attack_state() then
				return var_2_0
			end

			local var_2_40
			local var_2_41
			local var_2_42

			if self:get_attribute().hit_complex_target then
				local var_2_43 = self._battle_obj_mgr:get_alive_ships_by_side(-self:get_side())

				var_2_40 = self:get_attribute().hit_complex_target.hurt_rates

				if self:get_attribute().skill_num.save_hit_complex_sub_target and self:get_attribute().skill_num.save_hit_complex_sub_target.use_attack and not self:get_attribute().skill_num.save_hit_complex_sub_target.mixattack then
					if iter_2_4 == 1 and #var_2_43 > self:get_attribute().hit_complex_target.num2 then
						var_2_42 = true
					end

					if iter_2_4 ~= 1 then
						var_2_42 = true
					end

					self:get_attribute().skill_num.save_hit_complex_sub_target.mixattack = true
				elseif self:get_attribute().skill_num.save_hit_complex_sub_target.mixattack then
					-- block empty
				else
					if iter_2_4 == 1 and #var_2_43 > self:get_attribute().hit_complex_target.num2 then
						var_2_42 = true
					end

					if iter_2_4 ~= 1 then
						var_2_42 = true
					end
				end
			end

			if self:get_attribute().hit_adjacent_complex_target and not iter_2_5:is_submarine() then
				var_2_40 = self:get_attribute().hit_adjacent_complex_target.hurt_rates
			end

			if var_2_40 then
				var_2_41 = var_2_40[iter_2_4]
			end

			if self:get_attribute()._attack_cause_damage and self:__get_ship_ton_type(iter_2_5, self:get_attribute()._attack_cause_damage.ship_tons) then
				var_2_41 = self:get_attribute()._attack_cause_damage.hurt_rate
			end

			if self:get_attribute()._attack_rate then
				var_2_12 = self:get_attribute()._attack_rate.rate
			end

			if var_2_34 then
				var_2_41 = 1 + self:get_attribute().couple_attack_by_shipcid.hurt_rate
			end

			if self:get_attribute().atk_type == 2 then
				if not (self:get_attribute().add_fix_damage_by_index and self:get_index() ~= iter_2_5:get_index()) then
					var_2_24 = {}

					for iter_2_14, iter_2_15 in pairs((self._battle_obj_mgr:get_ships_by_side((var_0_1.obj_side.opposite(self._side))))) do
						if iter_2_15:getID() ~= iter_2_5:getID() then
							var_0_12(var_2_24, iter_2_15:getID())
						end
					end
				end
			end

			local var_2_45 = self:get_attribute().animation_type
			local var_2_46 = self:get_attribute().is_show_cutin

			if self:get_attribute().atk_type and self:get_attribute().atk_type ~= 0 or var_2_46 or var_2_34 then
				var_2_25 = var_0_10.find_object_by_skill_id(self:get_skill()).skill_type

				if self.show_skill_type then
					var_2_25 = self.show_skill_type
				end
			end

			local var_2_48 = arg_2_1 == "night_attack" and "night_attack" or var_2_33 and "antisub_attack" or "normal_attack"
			local var_2_49 = var_2_34 and self:get_attribute().couple_attack_by_shipcid

			if var_2_49 then
				self:get_attribute().sure_to_hit, self:get_attribute().sure_to_crit = var_2_49.hit == 1, var_2_49.crit == 1
			end

			local var_2_50 = var_0_2:create()

			var_2_50:bind(self._battlefield)
			var_2_50:set_normal_attack_type(var_2_31, arg_2_3)
			var_2_50:set_atk_rate(var_2_12)
			var_2_50:set_is_antisub(var_2_33)
			var_2_50:init({
				type = "normal_attack",
				source_id = self._id,
				target_id = iter_2_5:getID(),
				hurt_rate = var_2_41,
				formation_attack_type = var_2_48
			})

			if var_2_49 then
				self:get_attribute().sure_to_hit, self:get_attribute().sure_to_crit = nil
			end

			if var_2_31 == var_0_1.normal_attack_type.aircraft then
				for iter_2_16, iter_2_17 in pairs(self._equip_list) do
					if iter_2_17:is_plane_or_spyplane(var_2_33) and iter_2_17:get_equip_num() > 0 then
						local var_2_51 = {
							owner_id = self:getID(),
							cid = iter_2_17:get_equip_cid()
						}

						if var_2_33 then
							var_2_17 = self._battle_obj_mgr:createObject(var_0_6, var_2_51)
						end

						var_2_18 = self._battle_obj_mgr:createObject(var_0_4, var_2_51)
						var_2_19 = self._battle_obj_mgr:createObject(var_0_5, var_2_51)
					end
				end

				if (self._battle_scene:get_player_formation() == 3 and iter_2_5:get_side() == var_0_1.obj_side.player or self._battle_scene:get_enemy_formation() == 3 and iter_2_5:get_side() == var_0_1.obj_side.enemy) and (iter_2_5:get_ship_type() == 7 or iter_2_5:get_ship_type() == 10 or iter_2_5:get_ship_type() == 12) then
					var_2_27 = iter_2_5:getID()
				end
			elseif var_2_31 == var_0_1.normal_attack_type.torpedo then
				var_2_20 = self._battle_obj_mgr:createObject(var_0_9, {
					owner_id = self:getID()
				})
			elseif var_2_33 then
				if self:carry_antisub_plane() and (self:get_ship_type() == 2 or self:get_ship_type() == 5) then
					local var_2_52 = 0

					for iter_2_18, iter_2_19 in pairs(self._equip_list) do
						if iter_2_19:is_bomber_torpedoplane_or_spyplane() and iter_2_19:get_equip_num() > 0 then
							var_2_52 = iter_2_19:get_equip_cid()
						end
					end

					var_2_18 = self._battle_obj_mgr:createObject(var_0_4, {
						owner_id = self:getID(),
						cid = var_2_52
					})
				end

				var_2_17 = self._battle_obj_mgr:createObject(var_0_6, var_2_14)
			else
				var_2_15 = self._battle_obj_mgr:createObject(var_0_3, var_2_14)
			end

			if var_2_50:get_damageattr().is_double then
				var_2_16 = self._battle_obj_mgr:createObject(var_0_3, var_2_14)
			end

			self._battlefield._battle_report[arg_2_1] = self._battlefield._battle_report[arg_2_1] or {}
			self._battlefield._battle_report[arg_2_1][arg_2_2] = self._battlefield._battle_report[arg_2_1][arg_2_2] or {}

			local var_2_53 = self._battlefield._battle_report[arg_2_1][arg_2_2]
			local var_2_54 = {
				attack_id = self:getID(),
				target_id = iter_2_5:getID()
			}

			var_2_54.target_now_hp = iter_2_5:get_attribute().now_hp:get_final_value()
			var_2_54.target_max_hp = iter_2_5:get_attribute().hp:get_final_value()
			var_2_54.damage_info = var_2_50:get_damageattr()
			var_2_54.projectile_id = var_2_15 and var_2_15:getID() or nil
			var_2_54.projectile_second_id = var_2_16 and var_2_16:getID() or nil
			var_2_54.depthcharge_id = var_2_17 and var_2_17:getID() or nil
			var_2_54.aircraft_id = var_2_18 and var_2_18:getID() or nil
			var_2_54.bomb_id = var_2_19 and var_2_19:getID() or nil
			var_2_54.plane_type = var_2_13.plane_img_type
			var_2_54.attack_type = var_2_33 and 4 or 2
			var_2_54.torpedo_id = var_2_20 and var_2_20:getID() or nil
			var_2_54.be_guardian_man_id = var_2_22 and var_2_22:getID() or nil
			var_2_54.guardian_man_id = var_2_23 and var_2_23:getID() or nil
			var_2_54.mallet_id = var_2_24 and var_2_24 or nil
			var_2_54.show_skill = var_2_25 and var_2_25 or nil
			var_2_54.show_skill_2 = var_2_26 and var_2_26 or nil
			var_2_54.show_aircraft_effect = var_2_27 and var_2_27 or nil
			var_2_54.animation_type = var_2_45 and var_2_45 or nil
			var_2_54.is_show_cutin = var_2_46 and var_2_46 or nil
			var_2_54.is_hit_complex_target = var_2_42 and var_2_42 or nil
			var_2_54.step = arg_2_1 and arg_2_1 or nil
			var_2_54.target_count = iter_2_4
			var_2_54.couple_cid_list = var_2_34 and self:get_attribute().skill_num.couple_cid_list or nil
			var_2_53[iter_2_4] = var_2_54
			self._battlefield._battle_report[arg_2_1][arg_2_2].type = "normal_attack"

			self._battlefield:append_result(self._cid, arg_2_1, {
				name = var_2_10,
				target_id = iter_2_5:get_cid(),
				target_name = iter_2_5:get_ship_name(),
				source_id = self:get_cid(),
				damage_record = var_2_50:get_damage_record()
			})

			if iter_2_4 == #var_2_32 then
				self._battlefield._normal_index = self._battlefield._normal_index + 1
			end

			self:normal_attack_recovery(iter_2_5, arg_2_1, arg_2_2, iter_2_4)

			if iter_2_5:get_attribute().now_hp:get_final_value() == 0 then
				iter_2_5:set_is_alive(false)

				if iter_2_5:get_side() == var_0_1.obj_side.player then
					self._battlefield:eventOnPlayerDie(iter_2_5:getID())
				else
					self._battlefield:eventOnEnemyDie(iter_2_5:getID())
				end
			end

			if arg_2_1 == "night_attack" then
				iter_2_5:set_attack_ropund_type(var_0_1.attack_round_type.night)
			end

			if not var_2_50:get_damageattr().is_miss then
				var_0_12(var_2_0, iter_2_5)
			end
		end

		return var_2_0
	end

	function arg_1_0:normal_attack_recovery(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		if self._battle_scene:get_fight_type() == var_0_1.fight_type.maneuver then
			return
		end

		local var_3_0 = arg_3_1:get_attribute()
		local var_3_1 = self._battle_scene:get_damage_control_num()

		if arg_3_1:get_side() == var_0_1.obj_side.player and arg_3_1:get_cid() % 100 ~= 18 and var_3_1 > 0 and var_3_0.now_hp:get_final_value() <= 0 then
			local var_3_2 = var_3_0.hp:get_final_value()

			var_3_0.now_hp:modify_to_value(var_3_2)
			self._battle_scene:set_damage_control_num(var_3_1 - 1)
			self._battle_scene:set_damage_control_last_hp_num(var_3_0.now_hp._damage_control_value, arg_3_1:get_character_id())

			self._battlefield._battle_report[arg_3_2][arg_3_3][arg_3_4].recovery = {
				recovery_id = arg_3_1:getID(),
				now_hp = var_3_0.now_hp:get_final_value(),
				max_hp = var_3_2
			}

			arg_3_1:set_is_ignore_damage_protect(false)
		end

		arg_3_1:get_attribute().skill_num = arg_3_1:get_attribute().skill_num or {}

		if arg_3_1:get_attribute().skill_num.have_recover_life then
			arg_3_1:get_attribute().now_hp:modify_to_value(arg_3_1:get_attribute().skill_num.have_recover_life)
			arg_3_1:set_is_alive(true)

			arg_3_1:get_attribute().skill_num.have_recover_life = nil
		end
	end

	function arg_1_0:__get_normal_attack_type()
		local var_4_0 = var_0_1.normal_attack_type.normal

		if var_0_1:is_normal_aircraft_attack_type(self._ship_type) then
			var_4_0 = var_0_1.normal_attack_type.aircraft
		end

		if var_0_1:is_normal_or_aircraft_by_have_aircraft(self._ship_type) and self:normal_can_air_attack() then
			var_4_0 = var_0_1.normal_attack_type.aircraft
		end

		if self._can_normal_turn_to_torpedo then
			var_4_0 = var_0_1.normal_attack_type.torpedo

			self:set_is_not_attack_for_type(self._can_normal_turn_to_torpedo)
		end

		return var_4_0
	end

	function arg_1_0:__get_normal_attack_target(arg_5_1)
		local var_5_0 = {}
		local var_5_1 = {}

		var_0_12(var_5_1, self:get_sea_target())

		local var_5_3 = self:get_attribute().skill_num.save_hit_complex_sub_target

		if self:can_normal_antisub(arg_5_1) then
			if self:get_undersea_target() then
				local var_5_4 = #self._battle_obj_mgr:get_undersea_ships_by_side((var_0_1.obj_side.opposite(self._side)))
				local var_5_5

				if self:get_attribute().hit_complex_target then
					if var_5_4 > 1 then
						var_5_5 = self:get_undersea_target(arg_5_1, self:get_attribute().hit_complex_target.num, nil)
					elseif #var_5_1 > 0 and var_5_4 == 1 then
						var_5_5 = self:get_undersea_target()

						if var_5_3 then
							var_5_3.use_attack = true
						end
					elseif var_5_4 == 1 and #var_5_1 == 0 then
						var_5_5 = self:get_undersea_target()
					end

					if var_5_4 == 1 then
						var_0_12(var_5_0, var_5_5)
					else
						for iter_5_0, iter_5_1 in pairs(var_5_5) do
							var_0_12(var_5_0, iter_5_1)
						end
					end
				else
					local var_5_6 = self:get_undersea_target()

					var_0_12(var_5_0, self:get_undersea_target())
				end
			end

			return var_5_0, not not var_5_0[1]:is_submarine()
		end

		local var_5_7, var_5_8 = self:__get_couple_attack_target()

		if var_5_7 then
			local var_5_9 = self:get_cid()
			local var_5_10 = var_5_8:get_cid()

			if var_5_8:get_index() < self:get_index() then
				var_5_10 = var_5_9
				var_5_9 = var_5_10
			end

			self:get_attribute().skill_num.couple_cid_list = {
				var_5_9,
				var_5_10
			}

			return self:get_sea_target(var_5_7.num or 3), false, true
		end

		if self:get_attribute().hit_complex_target then
			local var_5_11 = self._battle_obj_mgr:get_alive_ships_by_side(-self:get_side())

			if var_5_3 and var_5_3.mixattack and var_5_3.use_attack then
				if #var_5_11 > self:get_attribute().hit_complex_target.num2 then
					return self:get_sea_target(self:get_attribute().hit_complex_target.num - 1), false
				end
			elseif #var_5_11 > self:get_attribute().hit_complex_target.num2 then
				return self:get_sea_target(self:get_attribute().hit_complex_target.num), false
			end
		end

		if self:get_attribute().hit_adjacent_complex_target then
			return self:get_sea_target(self:get_attribute().hit_adjacent_complex_target.num, true), false
		end

		if self:get_attribute()._attack_cause_damage then
			return self:get_sea_target(self:get_attribute()._attack_cause_damage.num), false
		end

		return var_5_1, false
	end

	function arg_1_0:__get_couple_attack_target()
		local var_6_0 = self:get_attribute().couple_attack_by_shipcid

		if not var_6_0 or not var_6_0.shipCids then
			return
		end

		for iter_6_0, iter_6_1 in pairs(self._battle_obj_mgr:get_ships_by_side(self._side)) do
			if iter_6_1 ~= self and iter_6_1:get_is_alive() then
				for iter_6_2, iter_6_3 in pairs(var_6_0.shipCids) do
					if iter_6_3 == iter_6_1:get_cid() then
						return var_6_0, iter_6_1
					end
				end
			end
		end
	end

	function arg_1_0.__get_ship_ton_type(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_7_1:get_ship_ton()

		for iter_7_0, iter_7_1 in pairs(arg_7_2) do
			if var_7_0 == iter_7_1 then
				return true
			end
		end

		return false
	end
end

function var_0_0.extend_obj(arg_8_0)
	return
end

return var_0_0
