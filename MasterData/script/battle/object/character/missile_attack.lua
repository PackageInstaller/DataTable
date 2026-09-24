local var_0_0 = {}
local var_0_1 = table.insert
local var_0_2 = table.sort
local var_0_3 = gameconfig.equip_config
local var_0_4 = gameenum.battle_type
local var_0_5 = gamecore.damage_info
local var_0_6 = gamecore.missile_logic
local var_0_7 = gamecore.booster_logic
local var_0_8 = gamecore.battle_util

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:missile_attack(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		local var_2_0 = false

		for iter_2_0, iter_2_1 in pairs(self:get_is_not_attack_for_type()) do
			if var_0_8:judge_stage(iter_2_1, self._battlefield._battle_step) then
				var_2_0 = true
			end
		end

		local var_2_1 = self:get_atk_rate()
		local var_2_3

		if arg_2_1 == "open_missile_attack" then
			var_2_3 = 8
		end

		if arg_2_1 == "close_missile_attack" then
			var_2_3 = 15
		end

		if arg_2_1 == "night_attack" then
			var_2_3 = 7
		end

		local var_2_7 = self:__get_missiles(arg_2_1)

		if #var_2_7 == 0 then
			var_2_0 = true
		end

		if not self:get_attack_state() then
			var_2_0 = true
		end

		if not self:get_can_attack_if_middle_or_big_break() and (not self._battle_scene:get_cur_ship_can_attend_fight_by_broken(arg_2_2) or self:get_side() == var_0_4.obj_side.enemy) then
			var_2_0 = true
		end

		if (not self:hp_more_than_quarter() and (not self._battle_scene:get_cur_ship_can_attend_fight_by_broken(arg_2_2) or self:get_side() == var_0_4.obj_side.enemy) and not self:get_can_attack_in_broken() or nil) and true then
			if self:get_attribute().phase_no_damage_by_phase_attack then
				local var_2_8 = self:get_attribute().phase_no_damage_by_phase_attack

				for iter_2_2, iter_2_3 in pairs(var_2_8.action_stage) do
					if var_0_8:judge_stage(iter_2_3, self._battlefield._battle_step) then
						self:set_attack_step_again_type(var_2_8.buff_stage[1], var_2_8.add_num)
					end
				end
			end

			return
		end

		local var_2_9, var_2_10 = self:__get_target_tmd_missiles(arg_2_1)

		self.skill_num.tmd_value = var_2_10

		if arg_2_3 and arg_2_3 > 0 and self:get_side() == 1 then
			self.skill_num.tmd_value = arg_2_3
		end

		if arg_2_4 and arg_2_4 > 0 and self:get_side() == -1 then
			self.skill_num.tmd_value = arg_2_4
		end

		for iter_2_4, iter_2_5 in pairs(var_2_7) do
			local var_2_11 = self:get_sea_target()
			local var_2_12

			if not var_2_11 then
				if iter_2_4 > 1 and arg_2_1 == "night_attack" then
					self._battlefield._normal_index = self._battlefield._normal_index + 1
				end

				return
			end

			self:__init_skill_by_stage(nil, true)
			self:__init_skill_by_stage(var_2_3, nil)

			local var_2_13, var_2_14 = self:__get_target_tmd_missiles(arg_2_1)
			local var_2_16 = self.skill_num.tmd_value >= iter_2_5.missile_hit

			self.skill_num.tmd_value = self.skill_num.tmd_value - iter_2_5.missile_hit

			if not var_2_13[1] then
				var_2_16 = false
			end

			local var_2_17
			local var_2_18 = self._battle_obj_mgr:createObject(var_0_6, {
				owner_id = self:getID()
			})
			local var_2_19
			local var_2_20

			if var_2_16 then
				self.tmd_value = self.skill_num.tmd_value - iter_2_5.missile_hit
				var_2_20 = var_2_13[1]:get_owner():getID()
				var_2_19 = self._battle_obj_mgr:createObject(var_0_6, {
					owner_id = var_2_20
				})
			else
				var_2_17 = self._battle_obj_mgr:createObject(var_0_7, {
					owner_id = self:getID()
				})
			end

			self:__consume_missile_num(iter_2_5.equip)

			if var_2_16 then
				self:__consume_missile_num(var_2_13[1])
			else
				var_2_12 = var_0_5:create()

				var_2_12:bind(self._battlefield)
				var_2_12:set_atk_rate(var_2_1)
				var_2_12:set_missile_atk(iter_2_5.atk)
				var_2_12:init({
					type = "missile_attack",
					source_id = self._id,
					target_id = var_2_11:getID(),
					formation_attack_type = arg_2_1 == "night_attack" and "night_attack" or "missile_attack"
				})
			end

			local var_2_22 = {
				name = arg_2_1,
				target_cid = var_2_11:get_cid(),
				target_name = var_2_11:get_ship_name()
			}

			var_2_22.damage_record = var_2_12 and var_2_12:get_damage_record() or nil
			var_2_22.tmd = var_2_16
			self.can_show_it = false

			self._battlefield:append_result(self._cid, "missile_attack", var_2_22)

			self._battlefield._battle_report[arg_2_1] = self._battlefield._battle_report[arg_2_1] or {}
			self._battlefield._battle_report[arg_2_1][arg_2_2] = self._battlefield._battle_report[arg_2_1][arg_2_2] or {}

			local var_2_23 = self._battlefield._battle_report[arg_2_1][arg_2_2]
			local var_2_24 = {
				attack_id = self:getID(),
				target_id = var_2_11:getID()
			}

			var_2_24.target_now_hp = var_2_11:get_attribute().now_hp:get_final_value()
			var_2_24.intercept = var_2_16
			var_2_24.tmd_target_id = var_2_20
			var_2_24.damage_info = var_2_12 and var_2_12:get_damageattr() or nil
			var_2_24.atk_missile_id = var_2_18:getID()
			var_2_24.tmd_id = var_2_19 and var_2_19:getID() or nil
			var_2_24.booster_id = var_2_17 and var_2_17:getID() or nil
			var_2_24.step = arg_2_1
			var_2_24.can_show_it = self.can_show_it
			var_2_24.target_count = iter_2_4
			var_2_23[iter_2_4] = var_2_24

			if not var_2_11:get_is_alive() then
				var_2_11:set_is_alive(true)
			end

			if iter_2_4 == #var_2_7 then
				self._battlefield._normal_index = self._battlefield._normal_index + 1
			end

			if arg_2_1 == "night_attack" then
				self.skill_num = self.skill_num or {}
				self.skill_num._missile_target = self.skill_num._missile_target or {}

				table.insert(self.skill_num._missile_target, var_2_11)

				self._battlefield._battle_report[arg_2_1][arg_2_2].type = "missile_attack"

				if var_2_11:get_attribute().now_hp:get_final_value() == 0 then
					var_2_11:set_is_alive(false)
				end
			end
		end

		self.skill_num = self.skill_num or {}

		if self.skill_num._missile_target then
			for iter_2_6, iter_2_7 in pairs(self.skill_num._missile_target) do
				self:missile_attack_recovery(iter_2_7, arg_2_1, arg_2_2, iter_2_6)

				iter_2_7:get_attribute().skill_num = iter_2_7:get_attribute().skill_num or {}

				if iter_2_7:get_attribute().skill_num.have_recover_life then
					iter_2_7:get_attribute().now_hp:modify_to_value(iter_2_7:get_attribute().skill_num.have_recover_life)
					iter_2_7:set_is_alive(true)

					iter_2_7:get_attribute().skill_num.have_recover_life = nil
				end

				if iter_2_7:get_attribute().now_hp:get_final_value() == 0 then
					iter_2_7:set_is_alive(false)

					if iter_2_7:get_side() == var_0_4.obj_side.player then
						self._battlefield:eventOnPlayerDie(iter_2_7:getID())
					else
						self._battlefield:eventOnEnemyDie(iter_2_7:getID())
					end
				end

				iter_2_7:set_attack_ropund_type(var_0_4.attack_round_type.night)
			end

			self.skill_num._missile_target = nil
		end

		if self.skill_num.tmd_value and self:get_side() == 1 then
			if self.skill_num.tmd_value < 0 then
				return 0
			else
				return self.skill_num.tmd_value
			end
		end

		if self.skill_num.tmd_value and self:get_side() == -1 then
			if self.skill_num.tmd_value < 0 then
				return 0, 0
			else
				return 0, self.skill_num.tmd_value
			end
		else
			return 0, 0
		end
	end

	function arg_1_0:missile_attack_recovery(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		if self._battle_scene:get_fight_type() == var_0_4.fight_type.maneuver then
			return
		end

		local var_3_0 = arg_3_1:get_attribute()
		local var_3_1 = self._battle_scene:get_damage_control_num()

		if arg_3_1:get_side() == var_0_4.obj_side.player and arg_3_1:get_cid() % 100 ~= 18 and var_3_1 > 0 and var_3_0.now_hp:get_final_value() <= 0 then
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
	end

	function arg_1_0:__get_missiles(arg_4_1)
		local var_4_0 = {}

		for iter_4_0, iter_4_1 in pairs(self._equip_list) do
			if arg_4_1 == "close_missile_attack" then
				if iter_4_1:get_equip_type() == var_0_4.equip_type.air_defense_missile and iter_4_1:get_tmd_missile_num() > 0 then
					local var_4_1 = iter_4_1:get_equip_attrs()

					var_0_1(var_4_0, {
						missile_hit = var_4_1.missile_hit,
						equip = iter_4_1,
						atk = var_4_1.atk
					})
				end
			elseif arg_4_1 == "open_missile_attack" then
				if iter_4_1:get_equip_type() == var_0_4.equip_type.anti_ship_missile and iter_4_1:get_missile_num() > 0 then
					local var_4_2 = iter_4_1:get_equip_attrs()

					var_0_1(var_4_0, {
						missile_hit = var_4_2.missile_hit,
						equip = iter_4_1,
						atk = var_4_2.atk
					})
				end
			elseif (iter_4_1:get_equip_type() == var_0_4.equip_type.air_defense_missile or iter_4_1:get_equip_type() == var_0_4.equip_type.anti_ship_missile) and iter_4_1:get_night_missile_num() > 0 then
				local var_4_3 = iter_4_1:get_equip_attrs()

				var_0_1(var_4_0, {
					missile_hit = var_4_3.missile_hit,
					equip = iter_4_1,
					atk = var_4_3.atk
				})
			end
		end

		var_0_2(var_4_0, function(arg_5_0, arg_5_1)
			return arg_5_0.missile_hit < arg_5_1.missile_hit
		end)

		return var_4_0
	end

	function arg_1_0:__get_target_tmd_missiles(arg_6_1)
		local var_6_0 = 0
		local var_6_1 = {}

		if arg_6_1 == "close_missile_attack" or arg_6_1 == "night_attack" then
			return var_6_1, var_6_0
		end

		for iter_6_0, iter_6_1 in pairs((self._battle_obj_mgr:get_tmd_ships(var_0_4.obj_side.opposite(self._side)))) do
			if iter_6_1:get_is_alive() and iter_6_1:hp_more_than_quarter() then
				local var_6_2 = iter_6_1:get_equip_list()
				local var_6_3 = false

				for iter_6_2, iter_6_3 in pairs(var_6_2) do
					if iter_6_3:get_equip_type() == var_0_4.equip_type.air_defense_missile_launcher then
						var_6_3 = true
					end
				end

				if var_6_3 then
					for iter_6_4, iter_6_5 in pairs(var_6_2) do
						if iter_6_5:get_equip_type() == var_0_4.equip_type.air_defense_missile and iter_6_5._is_shout == false and iter_6_5:get_equip_num() > 0 then
							var_6_0 = var_6_0 + var_0_3.find_object_by_cid(iter_6_5:get_equip_cid()).missile_tmd

							var_0_1(var_6_1, iter_6_5)
						end
					end
				end
			end
		end

		return var_6_1, var_6_0
	end

	function arg_1_0.__consume_missile_num(arg_7_0, arg_7_1)
		arg_7_1:set_equip_num(arg_7_1:get_equip_num() - 1)

		arg_7_1._is_shout = true
	end
end

function var_0_0.extend_obj(arg_8_0)
	return
end

return var_0_0
