local var_0_0 = {}
local var_0_1 = gameenum.battle_type
local var_0_2 = gamecore.projectile_logic
local var_0_3 = gamecore.torpedo_logic
local var_0_4 = gamecore.damage_info
local var_0_5 = gamecore.battle_util

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:night_attack(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(self:get_is_not_attack_for_type()) do
			if var_0_5:judge_stage(iter_2_1, self._battlefield._battle_step) then
				return
			end
		end

		self:set_attack_state(true)

		local var_2_0 = self:get_atk_rate()

		if self._night_attack_type == var_0_1.night_attack_type.none then
			return
		end

		if self:can_night_antisub() then
			self:antisub_attack("night_attack", arg_2_1)

			return
		end

		if self._night_attack_type == var_0_1.night_attack_type.normal then
			self:normal_attack("night_attack", arg_2_1)

			return
		end

		if self._night_attack_type == var_0_1.night_attack_type.torpedo then
			self:torpedo_attack("night_attack", arg_2_1)

			return
		end

		if self._night_attack_type == var_0_1.night_attack_type.mix then
			self:mix_attack("night_attack", arg_2_1)

			return
		end

		if self._night_attack_type == var_0_1.night_attack_type.missile then
			if self:can_night_missile() then
				self:missile_attack("night_attack", arg_2_1)
			else
				self:normal_attack("night_attack", arg_2_1)
			end

			return
		end
	end

	function arg_1_0:mix_attack(arg_3_1, arg_3_2)
		local var_3_0 = self:get_sea_target()

		if not var_3_0 then
			return
		end

		if not self:get_can_attack_if_middle_or_big_break() then
			return
		end

		local var_3_1 = {
			owner_id = self:getID(),
			target_id = var_3_0:getID()
		}
		local var_3_2 = var_0_4:create()

		var_3_2:bind(self._battlefield)
		var_3_2:set_atk_rate((self:get_atk_rate()))
		var_3_2:init({
			type = "night_mix_attack",
			formation_attack_type = "night_attack",
			source_id = self._id,
			target_id = var_3_0:getID()
		})
		self._battlefield:append_result(self._cid, "夜战混合攻击", {
			name = "夜战混合攻击",
			target_id = var_3_0:get_cid(),
			target_name = var_3_0:get_ship_name(),
			damage_record = var_3_2:get_damage_record()
		})

		self._battlefield._battle_report[arg_3_1] = self._battlefield._battle_report[arg_3_1] or {}

		local var_3_3 = {
			attack_id = self:getID(),
			target_id = var_3_0:getID()
		}

		var_3_3.target_now_hp = var_3_0:get_attribute().now_hp:get_final_value()
		var_3_3.target_max_hp = var_3_0:get_attribute().hp:get_final_value()
		var_3_3.target_befor_hp = var_3_0:get_attribute().now_hp:get_final_value()
		var_3_3.damage_info = var_3_2:get_damageattr()
		var_3_3.projectile_id = self._battle_obj_mgr:createObject(var_0_2, var_3_1):getID()
		var_3_3.torpedo_id = self._battle_obj_mgr:createObject(var_0_3, var_3_1):getID()
		var_3_3.step = arg_3_1
		self._battlefield._battle_report[arg_3_1][arg_3_2] = var_3_3
		self._battlefield._battle_report[arg_3_1][arg_3_2].type = "mix_attack"

		self:mix_attack_recovery(var_3_0, arg_3_1, arg_3_2)

		if var_3_0:get_attribute().now_hp:get_final_value() == 0 then
			var_3_0:set_is_alive(false)

			if var_3_0:get_side() == var_0_1.obj_side.player then
				self._battlefield:eventOnPlayerDie(var_3_0:getID())
			else
				self._battlefield:eventOnEnemyDie(var_3_0:getID())
			end
		end

		if arg_3_1 == "night_attack" then
			var_3_0:set_attack_ropund_type(var_0_1.attack_round_type.night)
		end

		self._battlefield._normal_index = self._battlefield._normal_index + 1
	end

	function arg_1_0:mix_attack_recovery(arg_4_1, arg_4_2, arg_4_3)
		if self._battle_scene:get_fight_type() == var_0_1.fight_type.maneuver then
			return
		end

		local var_4_0 = arg_4_1:get_attribute()
		local var_4_1 = self._battle_scene:get_damage_control_num()

		if arg_4_1:get_side() == var_0_1.obj_side.player and arg_4_1:get_cid() % 100 ~= 18 and var_4_1 > 0 and var_4_0.now_hp:get_final_value() <= 0 then
			local var_4_2 = var_4_0.hp:get_final_value()

			var_4_0.now_hp:modify_to_value(var_4_2)
			arg_4_1:set_is_alive(true)
			self._battle_scene:set_damage_control_num(var_4_1 - 1)
			self._battle_scene:set_damage_control_last_hp_num(var_4_0.now_hp._damage_control_value, arg_4_1:get_character_id())

			self._battlefield._battle_report[arg_4_2][arg_4_3].recovery = {
				recovery_id = arg_4_1:getID(),
				now_hp = var_4_0.now_hp:get_final_value(),
				max_hp = var_4_2
			}

			arg_4_1:set_is_ignore_damage_protect(false)
		end
	end
end

function var_0_0.extend_obj(arg_5_0)
	return
end

return var_0_0
