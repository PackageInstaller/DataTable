local var_0_0 = {}
local var_0_2 = table.insert
local var_0_3 = gameenum.battle_type
local var_0_4 = gamecore.battle_util

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__on_func_increase_all_ship_attrs(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		if arg_2_4 ~= "init_attr" then
			return
		end

		if arg_2_2:get_side() == var_0_3.obj_side.enemy then
			return
		end

		if arg_2_3 then
			return
		end

		self:__update_ship_attr_by_effect(arg_2_1, false, false, arg_2_2)
	end

	function arg_1_0:__on_func_increase_some_fleet_ship_attrs(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		if arg_3_4 ~= "init_attr" then
			return
		end

		if arg_3_2:get_side() == var_0_3.obj_side.player then
			return
		end

		if arg_3_3 then
			return
		end

		local var_3_0 = {}

		for iter_3_0, iter_3_1 in pairs(arg_3_1) do
			var_3_0[iter_3_0] = iter_3_1
		end

		var_3_0.num = arg_3_1.num / 100

		self:__update_ship_attr_by_effect(var_3_0, true, false, arg_3_2)
	end

	function arg_1_0:__on_func_increase_some_country_ship_attrs(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		if arg_4_4 ~= "init_attr" then
			return
		end

		if arg_4_2:get_side() == var_0_3.obj_side.enemy then
			return
		end

		if arg_4_3 then
			return
		end

		self:__update_ship_attr_by_effect(arg_4_1, false, false, arg_4_2)
	end

	function arg_1_0:__on_func_increase_some_ship_attrs(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
		if arg_5_4 ~= "init_attr" then
			return
		end

		if arg_5_2:get_side() == var_0_3.obj_side.enemy then
			return
		end

		if arg_5_3 then
			return
		end

		if arg_5_2:get_cid() == arg_5_1.shipCid then
			self:__update_ship_attr_by_effect(arg_5_1, false, false, arg_5_2)
		end
	end

	function arg_1_0:__on_func_increase_this_side_ship_power(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
		if arg_6_4 == "init_attr" then
			return
		end

		if arg_6_2:get_side() == var_0_3.obj_side.enemy then
			return
		end

		for iter_6_0, iter_6_1 in pairs((self:__get_ship_hit_state_by_effect(arg_6_1, arg_6_2))) do
			local var_6_0 = self._battle_obj_mgr:findObject(iter_6_1)

			if not var_6_0:get_attribute().is_increase_this_side_ship_power then
				var_6_0:get_attribute().change_final_damage = var_6_0:get_attribute().change_final_damage or 0
				var_6_0:get_attribute().change_final_damage = (1 + var_6_0:get_attribute().change_final_damage) * (1 + arg_6_1.num / 100) - 1
			end

			var_6_0:get_attribute().is_increase_this_side_ship_power = true
		end
	end

	function arg_1_0:__on_func_reduce_this_ship_damage(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
		if arg_7_4 == "init_attr" then
			return
		end

		if arg_7_2:get_side() == var_0_3.obj_side.enemy then
			return
		end

		if not arg_7_3 then
			return
		end

		for iter_7_0, iter_7_1 in pairs((self:__get_ship_hit_state_by_effect(arg_7_1, arg_7_3))) do
			local var_7_0 = self._battle_obj_mgr:findObject(iter_7_1)

			if not var_7_0:get_attribute().is_reduce_this_ship_damage then
				var_7_0:get_attribute().change_final_be_damage = var_7_0:get_attribute().change_final_be_damage or 0
				var_7_0:get_attribute().change_final_damage = (1 + var_7_0:get_attribute().change_final_damage) * (1 + arg_7_1.num / 100) - 1
			end

			var_7_0:get_attribute().is_increase_this_side_ship_power = true
		end
	end

	function arg_1_0:__on_func_increase_some_stage_power(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
		if arg_8_4 == "init_attr" then
			return
		end

		if arg_8_2:get_side() == var_0_3.obj_side.enemy then
			return
		end

		for iter_8_0, iter_8_1 in pairs((self:__get_ship_hit_state_by_effect(arg_8_1, arg_8_2))) do
			self._battle_obj_mgr:findObject(iter_8_1):get_attribute().change_final_damage_by_stage = {
				effect_stage = arg_8_1.num5,
				num = arg_8_1.num / 100
			}
		end
	end

	function arg_1_0:__on_func_reduce_some_stage_power(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
		if arg_9_4 == "init_attr" then
			return
		end

		if arg_9_2:get_side() == var_0_3.obj_side.player then
			return
		end

		if not arg_9_3 then
			return
		end

		for iter_9_0, iter_9_1 in pairs((self:__get_ship_hit_state_by_effect(arg_9_1, arg_9_3))) do
			self._battle_obj_mgr:findObject(iter_9_1):get_attribute().change_final_be_damage_by_stage = {
				effect_stage = arg_9_1.num5,
				num = -arg_9_1.num / 100
			}
		end
	end

	function arg_1_0:__on_func_increase_attack_ship_power(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
		if arg_10_4 == "init_attr" then
			return
		end

		if arg_10_2:get_side() == var_0_3.obj_side.enemy then
			return
		end

		if not arg_10_3 then
			return
		end

		for iter_10_0, iter_10_1 in pairs((self:__get_ship_hit_state_by_effect(arg_10_1, arg_10_2))) do
			local var_10_0 = self._battle_obj_mgr:findObject(iter_10_1)
			local var_10_1 = false

			if arg_10_1.shipType_enemy then
				var_10_1 = arg_10_3:get_ship_type() == arg_10_1.shipType_enemy
			elseif arg_10_1.shipTon_enemy then
				var_10_1 = arg_10_3:get_ship_ton() == arg_10_1.shipTon_enemy
			end

			if var_10_1 then
				var_10_0:get_attribute().change_final_damage = var_10_0:get_attribute().change_final_damage or 0
				var_10_0:get_attribute().change_final_damage = (1 + var_10_0:get_attribute().change_final_damage) * (1 + arg_10_1.num / 100) - 1
			end
		end
	end

	function arg_1_0:__on_func_reduce_attack_my_ship_power(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
		if arg_11_4 == "init_attr" then
			return
		end

		if arg_11_2:get_side() == var_0_3.obj_side.player then
			return
		end

		if not arg_11_3 then
			return
		end

		for iter_11_0, iter_11_1 in pairs((self:__get_ship_hit_state_by_effect(arg_11_1, arg_11_3))) do
			local var_11_0 = self._battle_obj_mgr:findObject(iter_11_1)
			local var_11_1 = false

			if arg_11_1.shipType_enemy then
				var_11_1 = arg_11_2:get_ship_type() == arg_11_1.shipType_enemy
			elseif arg_11_1.shipTon_enemy then
				var_11_1 = arg_11_2:get_ship_ton() == arg_11_1.shipTon_enemy
			end

			if var_11_1 then
				var_11_0:get_attribute().change_final_be_damage = var_11_0:get_attribute().change_final_be_damage or 0
				var_11_0:get_attribute().change_final_be_damage = (1 + var_11_0:get_attribute().change_final_be_damage) * (1 - arg_11_1.num / 100) - 1
			end
		end
	end

	function arg_1_0:__on_func_increase_ship_power(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
		if arg_12_4 == "init_attr" then
			return
		end

		if arg_12_2:get_side() == var_0_3.obj_side.enemy then
			return
		end

		if not arg_12_3 then
			return
		end

		for iter_12_0, iter_12_1 in pairs((self:__get_ship_hit_state_by_effect(arg_12_1, arg_12_2))) do
			local var_12_0 = self._battle_obj_mgr:findObject(iter_12_1)

			if var_12_0:get_cid() == arg_12_1.shipCid then
				var_12_0:get_attribute().change_final_damage = var_12_0:get_attribute().change_final_damage or 0
				var_12_0:get_attribute().change_final_damage = (1 + var_12_0:get_attribute().change_final_damage) * (1 + arg_12_1.num / 100) - 1
			end
		end
	end

	function arg_1_0:__on_func_reduce_ship_damage(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
		if arg_13_4 == "init_attr" then
			return
		end

		if arg_13_2:get_side() == var_0_3.obj_side.player then
			return
		end

		if not arg_13_3 then
			return
		end

		for iter_13_0, iter_13_1 in pairs((self:__get_ship_hit_state_by_effect(arg_13_1, arg_13_3))) do
			local var_13_0 = self._battle_obj_mgr:findObject(iter_13_1)

			if var_13_0:get_cid() == arg_13_1.shipCid then
				var_13_0:get_attribute().change_final_be_damage = var_13_0:get_attribute().change_final_be_damage or 0
				var_13_0:get_attribute().change_final_be_damage = (1 + var_13_0:get_attribute().change_final_be_damage) * (1 - arg_13_1.num / 100) - 1
			end
		end
	end

	function arg_1_0:__on_func_all_team_attr_enhance(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
		if arg_14_4 ~= "init_attr" or self._count > 0 then
			return
		end

		if arg_14_2:get_side() == var_0_3.obj_side.enemy then
			return
		end

		local var_14_0 = arg_14_2:get_attribute()

		if var_14_0[var_0_3.skil_attribute_type[arg_14_1.num4]] then
			local var_14_1 = var_14_0[var_0_3.skil_attribute_type[arg_14_1.num4]]:get_final_value()

			var_14_0[var_0_3.skil_attribute_type[arg_14_1.num4]]:modify_to_value(var_14_1 + arg_14_1.num)
			self._battlefield:append_result("buff全体属性提高", arg_14_2:get_ship_name(), (string.format("buff:%s, 属性名字%s, 前:%f, 后:%f", self._buff_data.title, var_0_3.skil_attribute_type[arg_14_1.num4], var_14_1, var_14_1 + arg_14_1.num)))
		end
	end

	function arg_1_0:__on_func_all_team_attr_reduce(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
		if arg_15_4 ~= "init_attr" or self._count > 0 then
			return
		end

		if arg_15_2:get_side() == var_0_3.obj_side.enemy then
			return
		end

		local var_15_0 = arg_15_2:get_attribute()

		if var_15_0[var_0_3.skil_attribute_type[arg_15_1.num4]] then
			local var_15_1 = var_15_0[var_0_3.skil_attribute_type[arg_15_1.num4]]:get_final_value()

			var_15_0[var_0_3.skil_attribute_type[arg_15_1.num4]]:modify_to_value(var_15_1 - arg_15_1.num)
			self._battlefield:append_result("buff全体属性降低", arg_15_2:get_ship_name(), (string.format("buff:%s, 属性名字%s, 前:%f, 后:%f", self._buff_data.title, var_0_3.skil_attribute_type[arg_15_1.num4], var_15_1, var_15_1 - arg_15_1.num)))
		end
	end

	function arg_1_0:__on_func_team_by_ship_type_attr_enhance(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
		if arg_16_4 ~= "init_attr" or self._count > 0 then
			return
		end

		if arg_16_2:get_side() == var_0_3.obj_side.enemy then
			return
		end

		local var_16_0 = arg_16_2:get_attribute()
		local var_16_1 = arg_16_1.guardType or 0
		local var_16_2 = arg_16_1.shipType or 0
		local var_16_3 = arg_16_1.shipTon or 0

		if (var_16_1 == 0 or var_16_1[1] == arg_16_2:get_ship_guard_type()) and (var_16_2 == 0 or var_16_2[1] == arg_16_2:get_ship_type()) and (var_16_3 == 0 or var_16_3[1] == arg_16_2:get_ship_ton()) then
			local var_16_4 = var_0_3.skil_attribute_type[arg_16_1.num4]

			if var_16_0[var_0_3.skil_attribute_type[arg_16_1.num4]] then
				local var_16_5 = var_16_0[var_16_4]:get_final_value()

				var_16_0[var_16_4]:modify_to_value(arg_16_1.num + var_16_5)
				self._battlefield:append_result("buff属性提高", arg_16_2:get_ship_name(), (string.format("buff:%s, 属性名字%s, 前:%f, 后:%f", self._buff_data.title, var_16_4, var_16_5, arg_16_1.num + var_16_5)))
			end
		end
	end

	function arg_1_0:__on_func_team_by_ship_type_attr_reduce(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
		if arg_17_4 ~= "init_attr" or self._count > 0 then
			return
		end

		if arg_17_2:get_side() == var_0_3.obj_side.enemy then
			return
		end

		local var_17_0 = arg_17_2:get_attribute()
		local var_17_1 = arg_17_1.guardType or 0
		local var_17_2 = arg_17_1.shipType or 0
		local var_17_3 = arg_17_1.shipTon or 0

		if (var_17_1 == 0 or var_17_1[1] == arg_17_2:get_ship_guard_type()) and (var_17_2 == 0 or var_17_2[1] == arg_17_2:get_ship_type()) and (var_17_3 == 0 or var_17_3[1] == arg_17_2:get_ship_ton()) then
			local var_17_4 = var_0_3.skil_attribute_type[arg_17_1.num4]

			if var_17_0[var_0_3.skil_attribute_type[arg_17_1.num4]] then
				local var_17_5 = var_17_0[var_17_4]:get_final_value()

				var_17_0[var_17_4]:modify_to_value(var_17_5 - arg_17_1.num)
				self._battlefield:append_result("buff属性降低", arg_17_2:get_ship_name(), (string.format("buff:%s, 属性名字%s, 前:%f, 后:%f", self._buff_data.title, var_17_4, var_17_5, var_17_5 - arg_17_1.num)))
			end
		end
	end

	function arg_1_0:__on_func_team_by_country_attr_enhance(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
		if arg_18_4 ~= "init_attr" or self._count > 0 then
			return
		end

		if arg_18_2:get_side() == var_0_3.obj_side.enemy then
			return
		end

		local var_18_0 = arg_18_2:get_attribute()
		local var_18_1 = arg_18_1.country or 0

		if arg_18_2:get_country() == var_18_1 or var_18_1 == 0 then
			local var_18_2 = var_0_3.skil_attribute_type[arg_18_1.num4]

			if var_18_0[var_0_3.skil_attribute_type[arg_18_1.num4]] then
				local var_18_3 = var_18_0[var_18_2]:get_final_value()

				var_18_0[var_18_2]:modify_to_value(var_18_3 + arg_18_1.num)
				self._battlefield:append_result("buff属性提高", arg_18_2:get_ship_name(), (string.format("buff:%s, 属性名字%s, 前:%f, 后:%f", self._buff_data.title, var_18_2, var_18_3, var_18_3 + arg_18_1.num)))
			end
		end
	end

	function arg_1_0:__on_func_team_by_country_attr_reduce(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
		if arg_19_4 ~= "init_attr" or self._count > 0 then
			return
		end

		if arg_19_2:get_side() == var_0_3.obj_side.enemy then
			return
		end

		local var_19_0 = arg_19_2:get_attribute()
		local var_19_1 = arg_19_1.country or 0

		if arg_19_2:get_country() == var_19_1 or var_19_1 == 0 then
			local var_19_2 = var_0_3.skil_attribute_type[arg_19_1.num4]

			if var_19_0[var_0_3.skil_attribute_type[arg_19_1.num4]] then
				local var_19_3 = var_19_0[var_19_2]:get_final_value()

				var_19_0[var_19_2]:modify_to_value(var_19_3 - arg_19_1.num)
				self._battlefield:append_result("buff属性降低", arg_19_2:get_ship_name(), (string.format("buff:%s, 属性名字%s, 前:%f, 后:%f", self._buff_data.title, var_19_2, var_19_3, var_19_3 - arg_19_1.num)))
			end
		end
	end

	function arg_1_0:__on_func_enemy_ship_attr_enhance(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
		if arg_20_4 ~= "init_attr" then
			return
		end

		if arg_20_2:get_side() ~= var_0_3.obj_side.enemy then
			return
		end

		local var_20_0 = arg_20_2:get_attribute()

		if self:__is_the_ship_type(arg_20_2:get_ship_type(), arg_20_1.shipTypes) and self:__is_the_ship_type(arg_20_2:get_ship_ton(), arg_20_1.shipTons) and self:__is_the_ship_type(arg_20_2:get_ship_guard_type(), arg_20_1.guardTypes) then
			if var_20_0[var_0_3.skil_attribute_type[arg_20_1.num4]] then
				local var_20_1 = var_20_0[var_0_3.skil_attribute_type[arg_20_1.num4]]:get_final_value()

				var_20_0[var_0_3.skil_attribute_type[arg_20_1.num4]]:modify_to_value(var_20_1 + arg_20_1.num)
				self._battlefield:append_result("敌方buff属性提高", arg_20_2:get_ship_name(), (string.format("buff:%s, 属性名字%s, 前:%f, 后:%f", self._buff_data.title, var_0_3.skil_attribute_type[arg_20_1.num4], var_20_1, var_20_1 + arg_20_1.num)))
			end
		end
	end

	function arg_1_0:__on_func_enemy_ship_range_enhance(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
		if arg_21_4 ~= "init_attr" then
			return
		end

		if arg_21_2:get_side() ~= var_0_3.obj_side.enemy then
			return
		end

		local var_21_0 = arg_21_2:get_attribute()

		if self:__is_the_ship_type(arg_21_2:get_ship_type(), arg_21_1.shipTypes) and self:__is_the_ship_type(arg_21_2:get_ship_ton(), arg_21_1.shipTons) and self:__is_the_ship_type(arg_21_2:get_ship_guard_type(), arg_21_1.guardTypes) then
			local var_21_1 = var_21_0.range:get_final_value()
			local var_21_2

			if var_21_1 < arg_21_1.num then
				var_21_2 = arg_21_1.num or var_21_1
			end

			var_21_0.range:modify_to_value(var_21_2)
			self._battlefield:append_result("敌方buff属性提高", arg_21_2:get_ship_name(), (string.format("buff:%s, 属性名字:射程, 前:%f, 后:%f", self._buff_data.title, var_21_1, var_21_2)))
		end
	end

	function arg_1_0:__on_func_enemy_ship_hit_enhance(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
		if arg_22_4 == "init_attr" then
			return self._damage
		end

		if arg_22_2:get_side() ~= var_0_3.obj_side.enemy then
			return self._damage
		end

		if self:__is_the_ship_type(arg_22_3:get_ship_type(), arg_22_1.shipTypes) and self:__is_the_ship_type(arg_22_3:get_ship_ton(), arg_22_1.shipTons) and self:__is_the_ship_type(arg_22_3:get_ship_guard_type(), arg_22_1.guardTypes) then
			arg_22_2:get_attribute().change_final_damage = arg_22_2:get_attribute().change_final_damage or 0
			arg_22_2:get_attribute().change_final_damage = (1 + arg_22_2:get_attribute().change_final_damage) * (1 + arg_22_1.num / 100) - 1

			return after_damage
		end

		return self._damage
	end

	function arg_1_0:__on_func_enemy_ship_hit_reduce(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
		if arg_23_4 == "init_attr" then
			return self._damage
		end

		if not arg_23_3 then
			return
		end

		if arg_23_3:get_side() ~= var_0_3.obj_side.enemy then
			return self._damage
		end

		if self:__is_the_ship_type(arg_23_2:get_ship_type(), arg_23_1.shipTypes) and self:__is_the_ship_type(arg_23_2:get_ship_ton(), arg_23_1.shipTons) and self:__is_the_ship_type(arg_23_2:get_ship_guard_type(), arg_23_1.guardTypes) then
			arg_23_3:get_attribute().change_final_be_damage = arg_23_3:get_attribute().change_final_be_damage or 0
			arg_23_3:get_attribute().change_final_be_damage = (1 + arg_23_3:get_attribute().change_final_be_damage) * (1 - arg_23_1.num / 100) - 1

			return self._damage
		end

		return self._damage
	end

	function arg_1_0.__on_func_enemy_ship_stage_hit_enhance(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
		if arg_24_4 == "init_attr" then
			return
		end

		if arg_24_2:get_side() ~= var_0_3.obj_side.enemy then
			return
		end

		local var_24_0 = arg_24_2:get_attribute()

		arg_24_2:get_attribute().change_final_damage_by_stage = {
			effect_stage = arg_24_1.num5,
			num = arg_24_1.num / 100
		}
	end

	function arg_1_0.__on_func_enemy_ship_stage_hit_reduce(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
		if arg_25_4 == "init_attr" then
			return
		end

		if not arg_25_3 then
			return
		end

		if arg_25_3:get_side() ~= var_0_3.obj_side.enemy then
			return
		end

		local var_25_0 = arg_25_3:get_attribute()

		arg_25_3:get_attribute().change_final_be_damage_by_stage = {
			effect_stage = arg_25_1.num5,
			num = arg_25_1.num / 100
		}
	end

	function arg_1_0:__on_func_enemy_ship_night_fight(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
		if arg_26_4 ~= "init_attr" then
			return
		end

		if arg_26_2:get_side() ~= var_0_3.obj_side.enemy then
			return
		end

		local var_26_0 = arg_26_2:get_ship_type()

		if var_26_0 == var_0_3.ship_type_rule.aircraft_carrier.value or var_26_0 == var_0_3.ship_type_rule.light_aircraft_carrier.value or var_26_0 == var_0_3.ship_type_rule.seaplane_tender.value then
			local var_26_1 = {}

			table.insert(var_26_1, arg_26_2:getID())
			self._battle_scene:set_attend_night_fight_ship({
				ship_list = var_26_1
			})
		end
	end

	function arg_1_0:__on_func_enemy_ship_broken_fight(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
		if arg_27_4 ~= "init_attr" then
			return
		end

		if arg_27_2:get_side() ~= var_0_3.obj_side.enemy then
			return
		end

		local var_27_0 = arg_27_2:get_ship_type()

		if var_27_0 == var_0_3.ship_type_rule.aircraft_carrier.value or var_27_0 == var_0_3.ship_type_rule.light_aircraft_carrier.value or var_27_0 == var_0_3.ship_type_rule.seaplane_tender.value or var_27_0 == var_0_3.ship_type_rule.airport.value then
			local var_27_1 = {}

			table.insert(var_27_1, arg_27_2:getID())
			self._battle_scene:set_attend_fight_by_broken({
				ship_list = var_27_1
			})
		end
	end

	function arg_1_0:__on_func_enemy_ship_open_torpedo(arg_28_1, arg_28_2, arg_28_3, arg_28_4)
		if arg_28_4 ~= "init_attr" then
			return
		end

		if arg_28_2:get_side() ~= var_0_3.obj_side.enemy then
			return
		end

		if self:__is_the_ship_type(arg_28_2:get_ship_type(), arg_28_1.shipTypes) and self:__is_the_ship_type(arg_28_2:get_ship_ton(), arg_28_1.shipTons) and self:__is_the_ship_type(arg_28_2:get_ship_guard_type(), arg_28_1.guardTypes) then
			arg_28_2:set_can_open_torpedo_attack(true)
			self._battlefield:append_result("可以开幕鱼雷", arg_28_2:get_ship_name(), (string.format("buff:%s", self._buff_data.title)))
		end
	end

	function arg_1_0:__on_func_enemy_ship_must_hit(arg_29_1, arg_29_2, arg_29_3, arg_29_4)
		if arg_29_4 == "init_attr" then
			return
		end

		if arg_29_2:get_side() ~= var_0_3.obj_side.enemy then
			return
		end

		if self:__is_the_ship_type(arg_29_2:get_ship_type(), arg_29_1.shipTypes) and self:__is_the_ship_type(arg_29_2:get_ship_ton(), arg_29_1.shipTons) and self:__is_the_ship_type(arg_29_2:get_ship_guard_type(), arg_29_1.guardTypes) then
			arg_29_2:get_attribute().sure_to_hit = true
		end
	end

	function arg_1_0:__on_func_every_enemy_ship_add_attr(arg_30_1, arg_30_2, arg_30_3, arg_30_4)
		if arg_30_4 == "init_attr" then
			return
		end

		if arg_30_3:get_side() == var_0_3.obj_side.player or not arg_30_3:is_flag() then
			return
		end

		if not arg_30_3 then
			return
		end

		local var_30_0 = #self._battle_obj_mgr:get_alive_ships_by_side(arg_30_3:get_side()) - 1
		local var_30_1 = {}

		table.insert(var_30_1, arg_30_3:getID())
		self._battle_scene:set_hit_rate_reduce_data({
			stage_list = 0,
			ship_list = var_30_1,
			hit_rate = -arg_30_1.num / 100 * var_30_0,
			type = arg_30_1.type
		})
	end

	function arg_1_0.__on_func_enemy_flag_ship_add_attr(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4)
		if arg_31_4 == "init_attr" then
			return
		end

		if arg_31_3:get_side() ~= var_0_3.obj_side.enemy or arg_31_3:is_flag() then
			return
		end

		if not arg_31_3 then
			return
		end

		local var_31_0 = arg_31_3:get_attribute()

		arg_31_3:get_attribute().change_final_be_damage = arg_31_3:get_attribute().change_final_be_damage or 0
		arg_31_3:get_attribute().change_final_be_damage = (1 + arg_31_3:get_attribute().change_final_be_damage) * (1 - arg_31_1.num / 100) - 1
	end

	function arg_1_0.__is_the_ship_type(arg_32_0, arg_32_1, arg_32_2)
		if not arg_32_2 then
			return true
		end

		for iter_32_0, iter_32_1 in pairs(arg_32_2) do
			if iter_32_1 == arg_32_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_hit_state_by_effect(arg_33_1, arg_33_2)
		local var_33_0
		local var_33_1
		local var_33_2
		local var_33_3

		for iter_33_0, iter_33_1 in pairs(arg_33_1) do
			if iter_33_0 == "country" then
				var_33_0 = iter_33_1
			elseif iter_33_0 == "shipType" or iter_33_0 == "shipTypes" then
				var_33_1 = iter_33_1
			elseif iter_33_0 == "shipTon" or iter_33_0 == "shipTons" then
				var_33_2 = iter_33_1
			elseif iter_33_0 == "guardType" or iter_33_0 == "guardTypes" then
				var_33_3 = iter_33_1
			end
		end

		local var_33_4 = {}
		local var_33_5 = {}

		table.insert(var_33_5, arg_33_2)

		for iter_33_2, iter_33_3 in pairs(var_33_5) do
			if var_33_0 then
				if self:__get_ship_data_by_countrys(iter_33_3, var_33_0) and self:__get_ship_data_by_screen(iter_33_3, var_33_1, var_33_2, var_33_3) then
					var_0_2(var_33_4, iter_33_3:getID())
				end
			elseif self:__get_ship_data_by_screen(iter_33_3, var_33_1, var_33_2, var_33_3) then
				var_0_2(var_33_4, iter_33_3:getID())
			end
		end

		return var_33_4
	end

	function arg_1_0:__update_ship_attr_by_effect(arg_34_1, arg_34_2, arg_34_3, arg_34_4)
		local var_34_0 = {}

		table.insert(var_34_0, arg_34_4)

		local var_34_1
		local var_34_2
		local var_34_3
		local var_34_4

		for iter_34_0, iter_34_1 in pairs(arg_34_1) do
			if iter_34_0 == "country" then
				var_34_1 = iter_34_1
			elseif iter_34_0 == "shipType" or iter_34_0 == "shipTypes" then
				var_34_2 = iter_34_1
			elseif iter_34_0 == "shipTon" or iter_34_0 == "shipTons" then
				var_34_3 = iter_34_1
			elseif iter_34_0 == "guardType" or iter_34_0 == "guardTypes" then
				var_34_4 = iter_34_1
			end
		end

		local var_34_5 = arg_34_1.num

		if arg_34_3 then
			var_34_5 = -var_34_5
		end

		for iter_34_2, iter_34_3 in pairs(var_34_0) do
			if var_34_1 then
				if self:__get_ship_data_by_countrys(iter_34_3, var_34_1) and self:__get_ship_data_by_screen(iter_34_3, var_34_2, var_34_3, var_34_4) then
					var_0_4:update_target_attr(iter_34_3, var_0_3.skil_attribute_type[arg_34_1.num4], var_34_5, arg_34_2)
				end
			elseif self:__get_ship_data_by_screen(iter_34_3, var_34_2, var_34_3, var_34_4) then
				var_0_4:update_target_attr(iter_34_3, var_0_3.skil_attribute_type[arg_34_1.num4], var_34_5, arg_34_2)
			end
		end
	end

	function arg_1_0.__number_to_table(arg_35_0, arg_35_1)
		local var_35_0 = {}

		if type(arg_35_1) == "number" then
			var_0_2(var_35_0, arg_35_1)

			return var_35_0
		end

		return arg_35_1
	end

	function arg_1_0:__get_ship_data_by_countrys(arg_36_1, arg_36_2)
		arg_36_2 = self:__number_to_table(arg_36_2)

		for iter_36_0, iter_36_1 in pairs(arg_36_2) do
			if arg_36_1:get_country() == iter_36_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_types(arg_37_1, arg_37_2)
		arg_37_2 = self:__number_to_table(arg_37_2)

		for iter_37_0, iter_37_1 in pairs(arg_37_2) do
			if arg_37_1:get_ship_type() == iter_37_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_tons(arg_38_1, arg_38_2)
		arg_38_2 = self:__number_to_table(arg_38_2)

		for iter_38_0, iter_38_1 in pairs(arg_38_2) do
			if arg_38_1:get_ship_ton() == iter_38_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_guards(arg_39_1, arg_39_2)
		arg_39_2 = self:__number_to_table(arg_39_2)

		for iter_39_0, iter_39_1 in pairs(arg_39_2) do
			if arg_39_1:get_ship_guard_type() == iter_39_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_ship_data_by_screen(arg_40_1, arg_40_2, arg_40_3, arg_40_4)
		if arg_40_2 then
			if self:__get_ship_data_by_types(arg_40_1, arg_40_2) then
				return self:__get_target_by_ship_ton(arg_40_1, arg_40_3, arg_40_4)
			end
		elseif arg_40_3 then
			return self:__get_target_by_ship_ton(arg_40_1, arg_40_3, arg_40_4)
		elseif arg_40_4 then
			return self:__get_ship_data_by_guards(arg_40_1, arg_40_4)
		else
			return true
		end
	end

	function arg_1_0:__get_target_by_ship_ton(arg_41_1, arg_41_2, arg_41_3)
		if arg_41_2 then
			if self:__get_ship_data_by_tons(arg_41_1, arg_41_2) then
				return self:__get_target_by_ship_guard(arg_41_1, arg_41_3)
			else
				return false
			end
		else
			return self:__get_target_by_ship_guard(arg_41_1, arg_41_3)
		end
	end

	function arg_1_0:__get_target_by_ship_guard(arg_42_1, arg_42_2)
		if arg_42_2 then
			if self:__get_ship_data_by_guards(arg_42_1, arg_42_2) then
				return true
			else
				return false
			end
		else
			return true
		end
	end
end

function var_0_0.extend_obj(arg_43_0)
	return
end

return var_0_0
