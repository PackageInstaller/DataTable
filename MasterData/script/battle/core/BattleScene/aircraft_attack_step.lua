local var_0_0 = {}
local var_0_1 = table.insert
local var_0_2 = gameenum.battle_type
local var_0_3 = gameconfig.equip_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:enter_aircraft_attack()
		local var_2_0 = false

		for iter_2_0, iter_2_1 in pairs((self._battle_obj_mgr:get_all_ships())) do
			var_2_0 = (iter_2_1:hp_more_than_quarter() or iter_2_1:get_can_attack_in_broken()) and iter_2_1:carry_plane() and iter_2_1:get_is_alive() and var_0_2:is_aircraft_attack_type(iter_2_1:get_ship_type()) and true
		end

		self:air_control_state()

		return var_2_0
	end

	function arg_1_0:get_player_air_control_type()
		return self._player_air_control_type
	end

	function arg_1_0:get_enemy_air_control_type()
		return self._enemy_air_control_type
	end

	function arg_1_0:get_player_air_control_value()
		return self._player_air_control_value
	end

	function arg_1_0:get_enemy_air_control_value()
		return self._enemy_air_control_value
	end

	function arg_1_0:air_control_state()
		self:__get_ship_air_control_type(self:__get_ship_left_plane(var_0_2.obj_side.player), (self:__get_ship_left_plane(var_0_2.obj_side.enemy)))
	end

	function arg_1_0:get_air_control_value(arg_8_1, arg_8_2)
		local var_8_0 = 0
		local var_8_1 = 0
		local var_8_2 = "玩家制空值"

		if arg_8_1 == var_0_2.obj_side.enemy then
			var_8_2 = "敌方制空值"
		end

		local var_8_3 = {}
		local var_8_4 = 0

		for iter_8_0, iter_8_1 in pairs((self._battle_obj_mgr:get_ships_by_side(arg_8_1))) do
			if (not iter_8_1:is_lowhp() or iter_8_1._battle_scene:get_attack_state_by_hp(nil, iter_8_1) or not not iter_8_1:get_can_attack_in_broken()) and var_0_2:is_aircraft_attack_type(iter_8_1:get_ship_type()) then
				local var_8_5 = iter_8_1:get_attribute()

				for iter_8_2, iter_8_3 in pairs((iter_8_1:get_equip_list())) do
					if iter_8_3:is_plane() then
						local var_8_6 = var_0_3.find_object_by_cid(iter_8_3:get_equip_cid())
						local var_8_7 = var_8_6.title
						local var_8_8 = iter_8_3:get_fly_num(var_8_5.atk:get_final_value() > 0 and var_8_5.atk:get_final_value() or 0)
						local var_8_9 = iter_8_3:get_equip_attribute("air_def")

						var_8_8 = var_8_8 > 0 and var_8_8 or 0

						local var_8_10 = var_8_9 * math.log((var_8_8 + 1) * 2)

						if iter_8_1:get_attribute().ban_aircraft_attack then
							var_8_8 = 0
						end

						if var_8_8 == 0 then
							var_8_10 = 0
						end

						if next(var_8_6.exclusive_cid) and next(var_8_6.exclusive_buff) then
							for iter_8_4, iter_8_5 in pairs(var_8_6.exclusive_cid) do
								if iter_8_1:get_cid() == iter_8_5 then
									for iter_8_6, iter_8_7 in pairs(var_8_6.exclusive_buff) do
										if iter_8_7.type == 8 then
											var_8_10 = var_8_10 + iter_8_7.num
											var_8_4 = var_8_4 + iter_8_7.num
										end
									end
								end
							end
						elseif not next(var_8_6.exclusive_cid) and next(var_8_6.exclusive_buff) then
							for iter_8_8, iter_8_9 in pairs(var_8_6.exclusive_buff) do
								if iter_8_9.type == 8 then
									var_8_10 = var_8_10 + iter_8_9.num
									var_8_4 = var_8_4 + iter_8_9.num
								end
							end
						end

						var_8_0 = var_8_0 + var_8_10

						if not arg_8_2 then
							table.insert(var_8_3, (string.format("当前总计制空值:%f, 装备名字:%s,本格制空值%f=该格装备对空值%f * ln((飞出去的飞机数量%d+1)*2)", var_8_0, var_8_7, var_8_10, var_8_9, var_8_8)))
						end
					end
				end
			end

			if iter_8_1:get_attribute().change_air_control then
				var_8_0 = var_8_0 + iter_8_1:get_attribute().change_air_control
				var_8_1 = var_8_1 + iter_8_1:get_attribute().change_air_control

				if var_8_0 < 0 then
					var_8_0 = 0
				end

				if not arg_8_2 and var_8_0 > 0 then
					self._battlefield:append_result(iter_8_1:get_cid(), "触发技能效果：增加制空值", (string.format("增加制空值:%s", iter_8_1:get_attribute().change_air_control)))
				elseif not arg_8_2 and var_8_1 < 0 then
					self._battlefield:append_result(iter_8_1:get_cid(), "触发技能效果：减少制空值或者封禁制空", (string.format("对面有减少制空值或者封禁制空的船只:%s", iter_8_1:get_attribute().change_air_control)))
				end
			end

			if var_8_4 ~= 0 then
				self._battlefield:append_result(iter_8_1:get_cid(), "触发特殊装备效果：增加制空值", (string.format("特殊装备增加制空值:%s", var_8_4)))
			end
		end

		if not arg_8_2 then
			self._battlefield:append_result(var_8_2, var_8_2, var_8_3)
		end

		return var_8_0
	end

	function arg_1_0:get_opposite_planes(arg_9_1)
		local var_9_0 = {}

		for iter_9_0, iter_9_1 in pairs((self._battle_obj_mgr:get_ships_by_side((var_0_2.obj_side.opposite(arg_9_1))))) do
			for iter_9_2, iter_9_3 in pairs((iter_9_1:get_equip_list())) do
				if iter_9_3:is_plane() then
					var_0_1(var_9_0, iter_9_1:getID())
				end
			end
		end

		return var_9_0
	end

	function arg_1_0:get_aircraft_ships()
		local var_10_0 = {}

		for iter_10_0, iter_10_1 in pairs((self._battle_obj_mgr:get_all_sea_ships())) do
			if (iter_10_1:hp_more_than_quarter() or iter_10_1:get_can_attack_in_broken()) and iter_10_1:carry_plane() and iter_10_1:get_is_alive() and var_0_2:is_aircraft_attack_type(iter_10_1:get_ship_type()) then
				var_0_1(var_10_0, iter_10_1)
			end
		end

		return var_10_0
	end

	function arg_1_0:__set_ships_air_control(arg_11_1, arg_11_2)
		for iter_11_0, iter_11_1 in pairs((self._battle_obj_mgr:get_ships_by_side(arg_11_1))) do
			iter_11_1:set_air_control_type(arg_11_2)
		end
	end

	function arg_1_0:__get_ship_left_plane(arg_12_1)
		local var_12_0 = 0

		for iter_12_0, iter_12_1 in pairs((self._battle_obj_mgr:get_ships_by_side(arg_12_1))) do
			if (not iter_12_1:is_lowhp() or iter_12_1._battle_scene:get_attack_state_by_hp(nil, iter_12_1) or not not iter_12_1:get_can_attack_in_broken()) and var_0_2:is_aircraft_attack_type(iter_12_1:get_ship_type()) then
				var_12_0 = iter_12_1:get_attribute().ban_aircraft_attack and var_12_0 + 0 or var_12_0 + iter_12_1:left_plane_num()
			end
		end

		return var_12_0
	end

	function arg_1_0:__get_ship_air_control_type(arg_13_1, arg_13_2)
		local var_13_0 = self:get_air_control_value(var_0_2.obj_side.player)
		local var_13_1 = self:get_air_control_value(var_0_2.obj_side.enemy)

		self._player_air_control_value = var_13_0
		self._enemy_air_control_value = var_13_1

		if arg_13_1 == 0 and (var_13_1 > 0 or arg_13_2 > 0) then
			self._player_air_control_type = var_0_2.air_control_type.loss.value
			self._enemy_air_control_type = var_0_2.air_control_type.supremacy.value
		elseif arg_13_1 == 0 and arg_13_2 == 0 then
			self._player_air_control_type = var_0_2.air_control_type.equl.value
			self._enemy_air_control_type = var_0_2.air_control_type.equl.value
		end

		if arg_13_1 > 0 and var_13_0 == 0 then
			if var_13_1 > 0 and arg_13_2 > 0 then
				self._player_air_control_type = var_0_2.air_control_type.loss.value
				self._enemy_air_control_type = var_0_2.air_control_type.supremacy.value
			elseif arg_13_2 > 0 and var_13_1 == 0 then
				self._player_air_control_type = var_0_2.air_control_type.equl.value
				self._enemy_air_control_type = var_0_2.air_control_type.equl.value
			else
				self._player_air_control_type = var_0_2.air_control_type.supremacy.value
				self._enemy_air_control_type = var_0_2.air_control_type.loss.value
			end
		end

		if arg_13_1 >= 0 and var_13_0 > 0 then
			if arg_13_2 >= 0 and var_13_1 > 0 then
				self._player_air_control_type, self._enemy_air_control_type = var_0_2:get_air_control_type(var_13_0, var_13_1)
			else
				self._player_air_control_type = var_0_2.air_control_type.supremacy.value
				self._enemy_air_control_type = var_0_2.air_control_type.loss.value
			end
		end
	end
end

function var_0_0.extend_obj(arg_14_0)
	arg_14_0._player_air_control_type = nil
	arg_14_0._enemy_air_control_type = nil
end

return var_0_0
