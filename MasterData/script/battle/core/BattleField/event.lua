local var_0_0 = {}
local var_0_2 = gameenum.battle_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:set_battle_result()
		if self.is_test then
			return
		end

		self._battle_result = self._battle_result or {}
		self._battle_result.team_state = self._battle_result.team_state or {}
		self._battle_result.enemy_state = self._battle_result.enemy_state or {}
		self._battle_result.boss_state = self._battle_result.boss_state or {}
		self._battle_result.damage_ctrl_state = self._battle_result.damage_ctrl_state or {}
		self._battle_result.kill_flag_ship_id = self._battle_result.kill_flag_ship_id or 0

		local var_2_0 = self._battle_obj_mgr:get_ships_by_side(var_0_2.obj_side.enemy)

		self:__set_ships_result(self._battle_obj_mgr:get_ships_by_side(var_0_2.obj_side.player), "team_state")
		self:__set_ships_result(var_2_0, "enemy_state")

		self._battle_result.boss_state = self:__get_boss_hp(var_2_0)
		self._battle_result.damage_ctrl_state = self._battle_scene:get_damage_control_last_hp_num()
		self._battle_result.kill_flag_ship_id = self._battle_scene:get_kill_flag_ship_id()
		self._battle_result.random = self._battle_random:getRandomCount()
	end

	function arg_1_0:eventOnFinishBattle()
		self:set_battle_result()

		self._battle_end = true

		self._battle_processor:eventOnBattleFinish(self._battle_result)
	end

	function arg_1_0:eventOnDayWarFinish()
		if self.is_test then
			return
		end

		self._battle_result = self._battle_result or {}
		self._battle_result.team_state = self._battle_result.team_state or {}
		self._battle_result.enemy_state = self._battle_result.enemy_state or {}
		self._battle_result.boss_state = self._battle_result.boss_state or {}
		self._battle_result.damage_ctrl_state = self._battle_result.damage_ctrl_state or {}
		self._battle_result.kill_flag_ship_id = self._battle_result.kill_flag_ship_id or 0

		local var_4_0 = self._battle_obj_mgr:get_ships_by_side(var_0_2.obj_side.enemy)

		self:__set_ships_result(self._battle_obj_mgr:get_ships_by_side(var_0_2.obj_side.player), "team_state")
		self:__set_ships_result(var_4_0, "enemy_state")

		self._battle_result.boss_state = self:__get_boss_hp(var_4_0)
		self._battle_result.damage_ctrl_state = self._battle_scene:get_damage_control_last_hp_num()
		self._battle_result.kill_flag_ship_id = self._battle_scene:get_kill_flag_ship_id()
	end

	function arg_1_0:eventOnPlayerDie(arg_5_1)
		if not self:__check_players_num() then
			return
		end

		self._battle_end = true
	end

	function arg_1_0:eventOnEnemyDie(arg_6_1)
		if not self:__check_enemys_num() then
			return
		end

		self._battle_end = true
	end

	function arg_1_0:__check_players_num()
		return self:__check_last_ship((self._battle_obj_mgr:get_ships_by_side(var_0_2.obj_side.player)))
	end

	function arg_1_0:__check_enemys_num()
		return self:__check_last_ship((self._battle_obj_mgr:get_ships_by_side(var_0_2.obj_side.enemy)))
	end

	function arg_1_0.__check_last_ship(arg_9_0, arg_9_1)
		for iter_9_0, iter_9_1 in pairs(arg_9_1) do
			iter_9_1:get_attribute().skill_num = iter_9_1:get_attribute().skill_num or {}

			if iter_9_1:get_is_alive() or iter_9_1:get_attribute().skill_num.have_recover_life then
				return false
			end
		end

		return true
	end

	function arg_1_0:__get_boss_hp(arg_10_1)
		local var_10_0 = {
			hp = 0,
			max_hp = 0
		}
		local var_10_1 = self._battle_scene:get_boss_info()

		if not next(var_10_1) then
			return var_10_0
		end

		var_10_0.hp = var_10_1.boss_now_hp
		var_10_0.max_hp = var_10_1.boss_max_hp

		for iter_10_0, iter_10_1 in pairs(arg_10_1) do
			if iter_10_1:is_flag() and iter_10_1:get_now_hp() > 0 and var_10_1.init_hp > 0 and var_10_1.boss_now_hp == 0 then
				var_10_0.hp = 1
			end
		end

		return var_10_0
	end

	function arg_1_0:__set_ships_result(arg_11_1, arg_11_2)
		for iter_11_0, iter_11_1 in pairs(arg_11_1) do
			local var_11_0 = iter_11_1:get_cid()
			local var_11_1 = 0
			local var_11_2 = 0
			local var_11_3
			local var_11_4

			if arg_11_2 == "team_state" then
				var_11_0 = iter_11_1:get_character_id()
				var_11_1 = iter_11_1:get_learning_tactic()

				if var_11_1 then
					local var_11_5 = string.sub(var_11_1, 1, #tostring(var_11_1) - 1)

					for iter_11_2, iter_11_3 in pairs((iter_11_1:get_tactics_trigger_count())) do
						if iter_11_2 == tonumber(var_11_5) then
							var_11_2 = iter_11_3
						end
					end
				end

				var_11_3 = iter_11_1:get_init_hp()
				var_11_4 = iter_11_1:get_attribute().hp:get_final_value()

				if var_11_4 < var_11_3 then
					var_11_3 = var_11_4
				end
			end

			if arg_11_2 == "enemy_state" then
				var_11_3 = iter_11_1:get_init_hp()
				var_11_4 = iter_11_1:get_attribute().hp:get_final_value()
			end

			self._battle_result[arg_11_2][iter_11_0] = {
				id = var_11_0,
				hp = iter_11_1:get_now_hp(),
				hurt = iter_11_1:get_total_damage(),
				miss = iter_11_1:get_total_miss(),
				sink = iter_11_1:get_total_sink(),
				equips = iter_11_1:get_equips_data(),
				kill_npc = iter_11_1:get_kill_npc(),
				init_hp = var_11_3,
				max_hp = var_11_4,
				level = iter_11_1:get_level()
			}

			if arg_11_2 == "team_state" then
				self._battle_result[arg_11_2][iter_11_0].tactic = {
					id = var_11_1,
					count = var_11_2
				}
			end
		end
	end
end

function var_0_0.extend_obj(arg_12_0)
	return
end

return var_0_0
