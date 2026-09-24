local var_0_0 = {}
local var_0_3 = gameenum.battle_type
local var_0_4 = gamecore.damage_info
local var_0_5 = gamecore.depthcharge_logic
local var_0_6 = gamecore.battle_util

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:antisub_attack(arg_2_1, arg_2_2)
		local var_2_0 = false

		for iter_2_0, iter_2_1 in pairs(self:get_is_not_attack_for_type()) do
			if var_0_6:judge_stage(iter_2_1, self._battlefield._battle_step) then
				var_2_0 = true
			end
		end

		if not self:get_attack_state() then
			var_2_0 = true
		end

		if not self:get_can_attack_if_middle_or_big_break() then
			local var_2_1 = self:get_attribute().skill_num

			if not (var_2_1 and var_2_1.antisub_ignore_broken_hp) then
				var_2_0 = true
			end
		end

		if var_2_0 then
			if self:get_attribute().phase_no_damage_by_phase_attack then
				local var_2_2 = self:get_attribute().phase_no_damage_by_phase_attack

				for iter_2_2, iter_2_3 in pairs(var_2_2.action_stage) do
					if var_0_6:judge_stage(iter_2_3, self._battlefield._battle_step) then
						self:set_attack_step_again_type(var_2_2.buff_stage[1], var_2_2.add_num)
					end
				end
			end

			return
		end

		local var_2_3

		if arg_2_1 == "open_antisub_attack" then
			var_2_3 = "先制反潜"
		end

		if arg_2_1 == "night_attack" then
			var_2_3 = "夜战反潜"
		end

		local var_2_4 = self:get_atk_rate()

		if arg_2_1 == "night_attack" then
			var_2_4 = self:get_ship_cfg().day_atk_rate
		end

		local var_2_5 = self:get_undersea_target(arg_2_1)

		if not var_2_5 then
			return
		end

		if var_2_5:get_attribute().now_hp:get_final_value() == 0 then
			return
		end

		local var_2_6 = var_0_4:create()

		var_2_6:bind(self._battlefield)
		var_2_6:set_atk_rate(var_2_4)
		var_2_6:init({
			type = "antisub_attack",
			source_id = self._id,
			target_id = var_2_5:getID(),
			formation_attack_type = arg_2_1 == "night_attack" and "night_attack" or "antisub_attack"
		})
		self._battlefield:append_result(self._cid, var_2_3, {
			name = var_2_3,
			target_id = var_2_5:get_cid(),
			target_name = var_2_5:get_ship_name(),
			damage_record = var_2_6:get_damage_record()
		})

		self._battlefield._battle_report[arg_2_1] = self._battlefield._battle_report[arg_2_1] or {}

		local var_2_7 = {
			attack_id = self:getID(),
			target_id = var_2_5:getID()
		}

		var_2_7.target_now_hp = var_2_5:get_attribute().now_hp:get_final_value()
		var_2_7.damage_info = var_2_6:get_damageattr()
		var_2_7.depthcharge_id = self._battle_obj_mgr:createObject(var_0_5, {
			owner_id = self:getID()
		}):getID()
		var_2_7.step = arg_2_1
		self._battlefield._battle_report[arg_2_1][arg_2_2] = var_2_7
		self._battlefield._normal_index = self._battlefield._normal_index + 1

		local var_2_8 = var_0_3.obj_side.opposite(self._side)
		local var_2_9 = self._battle_obj_mgr:get_undersea_ships_by_side(var_2_8)
		local var_2_10 = #var_2_9

		if arg_2_1 ~= "night_attack" then
			if var_2_8 == 1 then
				return
			end

			local var_2_11 = var_2_5:get_attribute().now_hp
			local var_2_12 = var_2_5:get_index()

			if var_2_11:get_final_value() == 0 then
				for iter_2_4, iter_2_5 in pairs(var_2_9) do
					if var_2_12 == iter_2_5:get_index() then
						var_2_10 = var_2_10 - 1
					end
				end
			end

			if var_2_10 == 0 then
				return
			end
		end

		self._battlefield._battle_report[arg_2_1][arg_2_2].type = "antisub_attack"

		if var_2_5:get_attribute().now_hp:get_final_value() == 0 then
			var_2_5:set_is_alive(false)
		end

		self:antisub_attack_recovery(var_2_5, arg_2_1, arg_2_2)
	end

	function arg_1_0:antisub_attack_recovery(arg_3_1, arg_3_2, arg_3_3)
		if self._battle_scene:get_fight_type() == var_0_3.fight_type.maneuver then
			return
		end

		local var_3_0 = arg_3_1:get_attribute()
		local var_3_1 = self._battle_scene:get_damage_control_num()

		if arg_3_1:get_side() == var_0_3.obj_side.player and var_3_1 > 0 and var_3_0.now_hp:get_final_value() <= 0 then
			local var_3_2 = var_3_0.hp:get_final_value()

			var_3_0.now_hp:modify_to_value(var_3_2)
			arg_3_1:set_is_alive(true)
			self._battle_scene:set_damage_control_num(var_3_1 - 1)
			self._battle_scene:set_damage_control_last_hp_num(var_3_0.now_hp._damage_control_value, arg_3_1:get_character_id())

			self._battlefield._battle_report[arg_3_2][arg_3_3].recovery = {
				recovery_id = arg_3_1:getID(),
				now_hp = var_3_0.now_hp:get_final_value(),
				max_hp = var_3_2
			}

			arg_3_1:set_is_ignore_damage_protect(false)
		end
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
