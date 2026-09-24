local var_0_0 = {}
local var_0_1 = table.insert
local var_0_3 = gameenum.battle_type
local var_0_6 = gameconfig.equip_config
local var_0_7 = gamecore.damage_info
local var_0_8 = gamecore.battle_util

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:aircraft_attack(arg_2_1)
		local var_2_0 = false

		for iter_2_0, iter_2_1 in pairs(self:get_is_not_attack_for_type()) do
			if var_0_8:judge_stage(iter_2_1, self._battlefield._battle_step) then
				var_2_0 = true
			end
		end

		if not self:get_attack_state() then
			var_2_0 = true
		end

		if (not self:get_can_attack_if_middle_or_big_break() or nil) and true then
			if self:get_attribute().phase_no_damage_by_phase_attack then
				local var_2_1 = self:get_attribute().phase_no_damage_by_phase_attack

				for iter_2_2, iter_2_3 in pairs(var_2_1.action_stage) do
					if var_0_8:judge_stage(iter_2_3, self._battlefield._battle_step) then
						self:set_attack_step_again_type(var_2_1.buff_stage[1], var_2_1.add_num)
					end
				end
			end

			return
		end

		local var_2_2 = self:get_atk_rate()
		local var_2_3 = self:get_ship_cfg()

		self:__get_fly_num()

		local var_2_4, var_2_5 = self:drop_by_fighter()
		local var_2_6 = self:__get_planes()

		if #var_2_6 == 0 then
			return
		end

		for iter_2_4, iter_2_5 in pairs(var_2_6) do
			local var_2_7 = self:get_sea_target()

			if not var_2_7 then
				return
			end

			self:__init_skill_by_stage(nil, true)
			self:__init_skill_by_stage(2, nil)

			local var_2_8
			local var_2_9

			if iter_2_5:is_bomber_or_torpedoplane() then
				var_2_7:set_attack_times_in_aircraft_attack()
			end

			local var_2_12 = self:drop_to_each_equip(iter_2_5, var_2_7, var_2_4, var_2_5)

			if iter_2_5:get_equip_num() == 0 then
				var_2_9 = true
			end

			if (self._battle_scene:get_player_formation() == 3 and var_2_7:get_side() == var_0_3.obj_side.player or self._battle_scene:get_enemy_formation() == 3 and var_2_7:get_side() == var_0_3.obj_side.enemy) and (var_2_7:get_ship_type() == 7 or var_2_7:get_ship_type() == 10 or var_2_7:get_ship_type() == 12) then
				var_2_8 = var_2_7:getID()
			end

			local var_2_13 = {
				owner_id = self:getID(),
				cid = iter_2_5:get_equip_cid()
			}
			local var_2_14 = self._battle_scene:get_aircraft_ships()
			local var_2_15 = var_0_6.find_object_by_cid(iter_2_5:get_equip_cid())
			local var_2_16 = var_0_7:create()

			var_2_16:bind(self._battlefield)

			if iter_2_5:is_bomber_or_torpedoplane() then
				var_2_16:set_atk_rate(var_2_3.day_atk_rate)
				var_2_16:set_plane_type(iter_2_5:get_equip_type())
				var_2_16:set_equip_aircraft_atk(iter_2_5:get_equip_attribute("aircraft_atk"))
				var_2_16:set_equip_torpedo(iter_2_5:get_equip_attribute("torpedo"))

				local var_2_17 = iter_2_5:get_fly_num()

				var_2_16:set_fly_num(var_2_12)
				var_2_16:init({
					type = "aircraft_attack",
					formation_attack_type = "aircraft_attack",
					source_id = self._id,
					target_id = var_2_7:getID()
				})

				local var_2_18 = self._battle_obj_mgr:createObject(gamecore.aircraft_logic, var_2_13)
				local var_2_19 = self._battle_obj_mgr:createObject(gamecore.bomb_logic, var_2_13)
				local var_2_20 = self._battle_obj_mgr:createObject(gamecore.torpedo_logic, var_2_13)

				self._battlefield:append_result(self._cid, "aircraft_attack", {
					name = "航空战",
					target_id = var_2_7:get_cid(),
					target_name = var_2_7:get_ship_name(),
					damage_record = var_2_16:get_damage_record()
				})

				self.can_show_it = false
				self._battlefield._battle_report.aircraft_attack = self._battlefield._battle_report.aircraft_attack or {}
				self._battlefield._battle_report.aircraft_attack[arg_2_1] = self._battlefield._battle_report.aircraft_attack[arg_2_1] or {}

				local var_2_21 = self._battlefield._battle_report.aircraft_attack[arg_2_1]
				local var_2_22 = {
					step = "aircraft_attack",
					attack_id = self:getID(),
					target_id = var_2_7:getID()
				}

				var_2_22.target_now_hp = var_2_7:get_attribute().now_hp:get_final_value()
				var_2_22.plane_type = var_2_3.plane_img_type
				var_2_22.plane_idx = iter_2_4
				var_2_22.aircraft_id = var_2_18:getID()
				var_2_22.type = iter_2_5:get_equip_type()
				var_2_22.bomb_id = var_2_19:getID()
				var_2_22.damage_info = var_2_16:get_damageattr()
				var_2_22.attack_type = self:__get_plane_attack_type(iter_2_5:get_equip_type())
				var_2_22.torpedo_id = var_2_20:getID()
				var_2_22.can_show_it = self.can_show_it
				var_2_22.side = self._side
				var_2_22.show_aircraft_effect = var_2_8 and var_2_8 or nil
				var_2_22.show_aircraft_explosion = var_2_9 and var_2_9 or nil
				var_2_22.fighter_should_shot = var_2_10 and var_2_10 or nil
				var_2_21[iter_2_4] = var_2_22
			end

			if iter_2_5:is_fighter() then
				local var_2_23 = self._battle_obj_mgr:createObject(gamecore.aircraft_logic, var_2_13)

				self._battlefield._battle_report.aircraft_attack = self._battlefield._battle_report.aircraft_attack or {}
				self._battlefield._battle_report.aircraft_attack[arg_2_1] = self._battlefield._battle_report.aircraft_attack[arg_2_1] or {}

				local var_2_24 = self._battlefield._battle_report.aircraft_attack[arg_2_1]
				local var_2_25 = {
					attack_id = self:getID(),
					target_id = var_2_7:getID()
				}

				var_2_25.target_now_hp = var_2_7:get_attribute().now_hp:get_final_value()
				var_2_25.aircraft_id = var_2_23:getID()
				var_2_25.plane_type = var_2_3.plane_img_type
				var_2_25.plane_idx = iter_2_4
				var_2_25.attack_type = var_0_3.plane_attack_type.none
				var_2_25.can_show_it = self.can_show_it
				var_2_25.side = self._side
				var_2_25.show_aircraft_effect = var_2_8 and var_2_8 or nil
				var_2_25.show_aircraft_explosion = var_2_9 and var_2_9 or nil
				var_2_25.fighter_should_shot = var_2_10 and var_2_10 or nil
				var_2_24[iter_2_4] = var_2_25
			end

			var_2_7:set_is_alive(true)
		end

		self._battlefield._normal_index = self._battlefield._normal_index + 1
	end

	function arg_1_0:drop_by_fighter()
		local var_3_0 = self._battle_scene:get_enemy_air_control_value()
		local var_3_1 = self._battle_scene:get_enemy_air_control_type()
		local var_3_2

		if self._side == var_0_3.obj_side.enemy then
			var_3_0 = self._battle_scene:get_player_air_control_value()
			var_3_1 = self._battle_scene:get_player_air_control_type()
			var_3_2 = 0
		end

		for iter_3_0, iter_3_1 in pairs((self._battle_obj_mgr:get_alive_ships_by_side(self._side))) do
			var_3_2 = var_3_2 + iter_3_1:left_plane_num()
		end

		local var_3_3, var_3_4 = var_0_3:get_drop_rate(var_3_1)
		local var_3_5 = self._battle_random:randRange(var_3_3 * var_3_0, var_3_0 * var_3_4)

		self._battlefield:append_result(self._cid, "战斗机造成的击落", (string.format("攻击方的制空值:%f, 被攻击方的飞机总数:%d, A*r1=%f, A*r2=%f, drop:%f", var_3_0, var_3_2, var_3_3 * var_3_0, var_3_0 * var_3_4, var_3_5)))

		return var_3_5, var_3_2
	end

	function arg_1_0:drop_to_each_equip(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		local var_4_0 = arg_4_1:get_fly_num()

		if not var_0_6.find_object_by_cid((arg_4_1:get_equip_cid())) then
			return var_4_0
		end

		if var_4_0 == 0 then
			return var_4_0
		end

		local var_4_1 = 1

		if self:get_ship_aircraft_loss() then
			var_4_1 = 1 - self:get_ship_aircraft_loss()

			self._battlefield:append_result(self._cid, "发动技能：减少飞机被击落", self:get_ship_aircraft_loss())
		end

		local var_4_2 = arg_4_1:get_equip_num()
		local var_4_3 = math.floor(var_4_2 * arg_4_3 / arg_4_4)

		if arg_4_1:is_fighter() then
			var_4_0 = var_4_2
		end

		var_4_3 = var_4_0 <= var_4_3 and var_4_0 or var_4_3

		local var_4_4 = math.floor(var_4_3)

		arg_4_1:set_equip_num(var_4_2 - var_4_4)
		self._battlefield:append_result(self._cid, "每个格子的飞机数量", string.format("飞机:%s, 放飞数量:%d", var_4_2, var_4_0))

		local var_4_5 = 0

		if not arg_4_1:is_fighter() then
			var_4_5 = self:double_drop(arg_4_1, arg_4_2, var_4_0)
		end

		self._battlefield:append_result(self._cid, "击坠计算", string.format("制空击坠%s+防空击坠%s", var_4_4, var_4_5))

		local var_4_6 = var_4_4 + var_4_5

		self._battlefield:append_result(self._cid, "击坠计算", string.format("合计击坠%s", var_4_4 + var_4_5))

		var_4_6 = var_4_0 <= var_4_6 and var_4_0 or var_4_6

		self._battlefield:append_result(self._cid, "击坠计算", string.format("最后击坠%s", var_4_6))
		self._battlefield:append_result(self._cid, "计算减少击坠技能", string.format("计算前击坠%s*损耗系数%s", var_4_6, var_4_1))

		local var_4_7 = math.floor(var_4_6 * var_4_1)

		self._battlefield:append_result(self._cid, "最后放飞", string.format("放飞数量%s-实际击坠%s=最后放飞%s", var_4_0, var_4_7, var_4_0 - var_4_7))
		arg_4_1:set_equip_num(var_4_2 - var_4_7)

		return var_4_0 - var_4_7
	end

	function arg_1_0:double_drop(arg_5_1, arg_5_2, arg_5_3)
		if arg_5_3 <= 0 then
			do return 0 end

			local var_5_0 = self._battle_obj_mgr:get_all_ships(self._side)
		end

		local var_5_1 = self:__get_fleet_air_def((self._battle_obj_mgr:get_ships_by_side((var_0_3.obj_side.opposite(self._side)))))
		local var_5_2 = arg_5_2:get_attribute()
		local var_5_3 = 1

		if self:get_attribute().change_drop_air_def_by_shiptype then
			local var_5_4 = self:get_attribute().change_drop_air_def_by_shiptype.type
			local var_5_5

			if var_5_4 == "shipTypes" then
				var_5_5 = arg_5_2:get_ship_type()
			elseif var_5_4 == "shipTons" then
				var_5_5 = arg_5_2:get_ship_ton()
			elseif var_5_4 == "guardTypes" then
				var_5_5 = arg_5_2:get_ship_guard_type()
			end

			for iter_5_0, iter_5_1 in pairs(self:get_attribute().change_drop_air_def_by_shiptype.type_num) do
				if var_5_5 == iter_5_1 then
					var_5_3 = self:get_attribute().change_drop_air_def_by_shiptype.rate

					self._battlefield:append_result(self._cid, "被攻击xx舰种/大中小型船/主力护卫舰计算防空击坠的本体对空降低到X%,降低到", self:get_attribute().change_drop_air_def_by_shiptype.rate)
				end
			end
		end

		local var_5_6 = (var_5_2.ship_air_def:get_final_value() > 0 and var_5_2.ship_air_def:get_final_value() or 0) * var_5_3 + arg_5_2:get_all_equip_attr_by_name("air_def")
		local var_5_7 = self:__get_double_airdef_correction_by_formation()
		local var_5_8 = self._battle_random:randomRangeDouble(0, 1)
		local var_5_9 = math.floor((var_5_6 + var_5_1 * var_5_7) * 0.1 * var_5_8)
		local var_5_10 = arg_5_2:get_attack_times_in_aircraft_attack()
		local var_5_11 = math.floor(var_5_9 * math.pow(0.6, var_5_10 - 1))

		if arg_5_3 < var_5_11 and not arg_5_3 then
			-- block empty
		end

		self._battlefield:append_result(self._cid, "防空击坠", (string.format("被攻击的战舰:%f, 舰队的对空:%f, 阵型补正:%f, 复合对空:%f, 损伤数量:%d, n:%d, 修正后的损伤数量:%d, 随机数:%f", var_5_6, var_5_1, var_5_7, var_5_6 + var_5_1 * var_5_7, var_5_9, var_5_10, var_5_11, var_5_8)))

		return var_5_11
	end

	function arg_1_0:__get_planes()
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in pairs(self._equip_list) do
			if iter_6_1:is_plane() then
				var_0_1(var_6_0, iter_6_1)
			end
		end

		return var_6_0
	end

	function arg_1_0.__get_plane_attack_type(arg_7_0, arg_7_1)
		if arg_7_1 == var_0_3.equip_type.torpedo_plane then
			return var_0_3.plane_attack_type.throw_torpedo
		end

		if arg_7_1 == var_0_3.equip_type.bomber then
			return var_0_3.plane_attack_type.throw_bomb
		end

		if arg_7_1 == var_0_3.equip_type.fighter then
			return var_0_3.plane_attack_type.none
		end

		return var_0_3.plane_attack_type.none
	end

	function arg_1_0:__get_fly_num()
		self._fly_num = 0

		for iter_8_0, iter_8_1 in pairs(self._equip_list) do
			if iter_8_1:is_plane() then
				self._fly_num = self._fly_num + iter_8_1:get_fly_num()
			end
		end
	end

	function arg_1_0:__is_attacker_has_fighter()
		for iter_9_0, iter_9_1 in pairs((self._battle_obj_mgr:get_sea_ships_by_side(var_0_3.obj_side.opposite(self._side)))) do
			if iter_9_1:is_carry_fighter() then
				return true
			end
		end

		return false
	end

	function arg_1_0:__consume_airplane_num(arg_10_1)
		if self._side == var_0_3.obj_side.enemy then
			return
		end

		local var_10_0 = self._fly_num

		for iter_10_0, iter_10_1 in pairs(self._equip_list) do
			if iter_10_1:is_plane() then
				local var_10_1 = iter_10_1:get_equip_num()

				iter_10_1:set_real_equip_num(var_10_1 - math.floor(var_10_1 * arg_10_1 / var_10_0))
			end
		end
	end

	function arg_1_0.__get_fleet_air_def(arg_11_0, arg_11_1)
		local var_11_0 = 0

		for iter_11_0, iter_11_1 in pairs(arg_11_1) do
			var_11_0 = var_11_0 + iter_11_1:get_all_equip_attr_by_name("air_def") * iter_11_1:get_max_air_def_correction()
		end

		return var_11_0
	end

	function arg_1_0:__get_double_airdef_correction_by_formation()
		local var_12_0 = self._battle_scene:get_enemy_formation()

		if self._side == var_0_3.obj_side.enemy then
			var_12_0 = self._battle_scene:get_player_formation()
		end

		local var_12_1 = 1

		for iter_12_0, iter_12_1 in pairs(var_0_3.formation_type_rule) do
			if var_12_0 == iter_12_1.value then
				var_12_1 = iter_12_1.double_air_def_correct
			end
		end

		return var_12_1
	end

	function arg_1_0:__init_skill_by_stage(arg_13_1, arg_13_2)
		for iter_13_0, iter_13_1 in pairs((self._battle_obj_mgr:get_all_ships())) do
			if iter_13_1:get_init_hp() ~= 0 then
				iter_13_1:init_skill(arg_13_1, arg_13_2)
			end
		end
	end
end

function var_0_0.extend_obj(arg_14_0)
	arg_14_0._fly_num = 0
	arg_14_0._attacked_planes_num = 0
	arg_14_0.fighter_should_shot = nil
end

return var_0_0
