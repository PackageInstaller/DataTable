local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:show_cannon_attack_cutting(arg_2_1)
		self[string.format("show_%s", (self:__get_support_attack_name(arg_2_1.type)))](self, arg_2_1)
	end

	function arg_1_0.show_cannon_attack(arg_3_0, arg_3_1)
		local var_3_0 = var_0_1:getInstance(var_0_2:get_battle_name())

		var_3_0:show_support_attack(arg_3_1.type, function()
			var_3_0:show_cannon_damage(function()
				for iter_5_0, iter_5_1 in pairs(arg_3_1.info) do
					arg_3_0:find_visual(iter_5_1.target_id):show_damage(iter_5_1)
				end
			end)
			arg_3_0:delay(3000, function()
				arg_3_0:next_step("air_attack")
			end)
		end)
	end

	function arg_1_0:show_bombs_attack(arg_7_1)
		local var_7_1 = self:__split_bomb_attack_info(arg_7_1)

		var_0_1:getInstance(var_0_2:get_battle_name()):show_support_attack(arg_7_1.type, function()
			for iter_8_0, iter_8_1 in pairs(var_7_1) do
				self:schedule((iter_8_0 - 1) * 50, 50, 1, function()
					local var_9_0 = self:find_visual(iter_8_1.bomb_id)

					var_9_0:create_bomb()
					var_9_0:set_speed(8)
					var_9_0:set_pos(Vector3.New(-3, 15, 1))
					var_9_0:set_target(iter_8_1.target_id, false)
					var_9_0:set_call_func(function()
						self:find_visual(iter_8_1.target_id):show_damage(iter_8_1)
					end)
				end)
			end

			self:delay(3000 + (#var_7_1 - 1) * 50, function()
				self:next_step("air_attack")
			end)
		end)
	end

	function arg_1_0.show_water_attack(arg_12_0, arg_12_1)
		local var_12_0 = UnityEngine.GameObject.Find("undersea/unit")

		var_0_1:getInstance(var_0_2:get_battle_name()):show_support_attack(arg_12_1.type, function()
			for iter_13_0, iter_13_1 in pairs(arg_12_1.info) do
				arg_12_0:schedule((iter_13_0 - 1) * 50, 50, 1, function()
					local var_14_0 = arg_12_0:find_visual(iter_13_1.torpedo_id)

					var_14_0:create_seaeffect(iter_13_1.target_id, Vector3.New(-4.3, -3.7, -0.86))
					var_14_0:set_call_func(function()
						arg_12_0:find_visual(iter_13_1.target_id):show_damage(iter_13_1)
					end)
				end)
			end

			arg_12_0:delay(3000 + (#arg_12_1.info - 1) * 50, function()
				arg_12_0:next_step("air_attack")
			end)
		end)
	end

	function arg_1_0.show_aircontrol(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
		local var_17_0 = var_0_1:getInstance(var_0_2:get_battle_name())

		if not var_17_0 then
			return
		end

		local var_17_1, var_17_2 = var_0_2:get_aircontrol_buff_cid(arg_17_1)

		var_17_0:attach_aircontrol_tip(arg_17_1, nil, {
			delta_y = 0,
			wait_time = 1,
			time = 0.5,
			move_y = 250
		})
		var_17_0:attach_buff("player", var_17_1, arg_17_2)
		var_17_0:attach_buff("enemy", var_17_2, arg_17_3)
	end

	function arg_1_0.__get_support_attack_name(arg_18_0, arg_18_1)
		local var_18_0 = "cannon_attack"

		for iter_18_0, iter_18_1 in pairs(var_0_2.support_spine) do
			if iter_18_1.value == arg_18_1 then
				var_18_0 = iter_18_0
			end
		end

		return var_18_0
	end

	function arg_1_0:__split_bomb_attack_info(arg_19_1)
		local var_19_0 = {}
		local var_19_1 = 1

		for iter_19_0, iter_19_1 in pairs(arg_19_1.info) do
			local var_19_2 = iter_19_1.damage_info.damage
			local var_19_3 = 0

			if #iter_19_1.bomb_id == 1 then
				var_19_0[var_19_1] = {
					bomb_id = iter_19_1.bomb_id[1],
					target_id = iter_19_1.target_id,
					damage_info = iter_19_1.damage_info,
					target_now_hp = iter_19_1.target_now_hp
				}
				var_19_1 = var_19_1 + 1
			else
				for iter_19_2, iter_19_3 in pairs(iter_19_1.bomb_id) do
					local var_19_5 = self._battle_random:visualRandRange(0, iter_19_1.damage_info.damage)

					var_19_3 = var_19_3 + var_19_5

					local var_19_6, var_19_7

					if var_19_2 <= var_19_3 then
						var_19_6 = 0
						var_19_7 = 0
					elseif var_19_3 >= var_19_2 - var_19_3 then
						var_19_6 = var_19_2 - var_19_3
						var_19_7 = var_19_2 - var_19_3
					else
						var_19_7 = var_19_2 - var_19_3
					end

					if iter_19_2 == #iter_19_1.bomb_id - 1 and var_19_3 <= var_19_2 then
						var_19_6 = var_19_2 - var_19_3
						var_19_7 = var_19_2 - var_19_3
					end

					local var_19_8 = {}

					if iter_19_1.damage_info.boss_info then
						for iter_19_4, iter_19_5 in pairs(iter_19_1.damage_info.boss_info) do
							var_19_8[iter_19_4] = iter_19_5
						end

						var_19_8.damage = var_19_5
					end

					local var_19_9 = {
						is_miss = false,
						damage_type = 1,
						is_crit = false,
						damage = var_19_5,
						boss_info = var_19_8
					}

					if var_19_5 == 0 then
						var_19_9.damage_type = 2
						var_19_9.is_miss = true
					end

					var_19_0[var_19_1] = {
						bomb_id = iter_19_1.bomb_id[iter_19_2],
						target_id = iter_19_1.target_id,
						damage_info = var_19_9,
						target_now_hp = iter_19_1.target_now_hp
					}
					var_19_1 = var_19_1 + 1
				end
			end
		end

		return var_19_0
	end
end

function var_0_0.extend_obj(arg_20_0)
	return
end

return var_0_0
