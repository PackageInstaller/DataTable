local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = math
local var_0_3 = next
local var_0_4 = string.format
local var_0_5 = gameenum.battle_type
local var_0_7 = gamecore.battle_util
local var_0_8 = string.sub
local var_0_9 = tostring
local var_0_12 = gameconfig.pve_mix_map_config
local var_0_13 = gameconfig.pve_eighth_map_config
local var_0_14 = gameconfig.equip_config

lx.define_class("damage_info", function(arg_1_0)
	function arg_1_0.bind(arg_2_0, arg_2_1)
		arg_2_0._battlefield = arg_2_1
		arg_2_0._battle_obj_mgr = arg_2_1:getBattleObjectManager()
		arg_2_0._battle_random = arg_2_1:getBattleRandom()
		arg_2_0._battle_scene = arg_2_1:getBattleScene()
	end

	function arg_1_0:set_damage_record(arg_3_1, arg_3_2)
		self._record_index = self._record_index or 1
		self._damage_record[self._record_index] = self._damage_record[self._record_index] or {}
		self._damage_record[self._record_index][arg_3_1] = self._damage_record[self._record_index][arg_3_1] or {}
		self._damage_record[self._record_index][arg_3_1] = arg_3_2
		self._record_index = self._record_index + 1
	end

	function arg_1_0:get_damage_record()
		return self._damage_record
	end

	function arg_1_0:get_damageattr()
		return self._damage_attr
	end

	function arg_1_0.set_equip_torpedo(arg_6_0, arg_6_1)
		arg_6_0._torpedo = arg_6_1
	end

	function arg_1_0.set_plane_type(arg_7_0, arg_7_1)
		arg_7_0._plane_type = arg_7_1
	end

	function arg_1_0.set_equip_aircraft_atk(arg_8_0, arg_8_1)
		arg_8_0._aircraft_atk = arg_8_1
	end

	function arg_1_0.set_fly_num(arg_9_0, arg_9_1)
		arg_9_0._fly_num = arg_9_1
	end

	function arg_1_0.set_atk_rate(arg_10_0, arg_10_1)
		arg_10_0._atk_rate = var_0_1.clone_table(arg_10_1)
	end

	function arg_1_0.set_missile_atk(arg_11_0, arg_11_1)
		arg_11_0._missile_atk = arg_11_1
	end

	function arg_1_0:set_normal_attack_type(arg_12_1, arg_12_2)
		self._normal_attack_type = arg_12_1
		self._damage_attr = self._damage_attr or {}
		self._damage_attr.is_aircraft = true
		self._is_beat_back = arg_12_2
	end

	function arg_1_0:set_is_antisub(arg_13_1)
		self._damage_attr = self._damage_attr or {}
		self._damage_attr.is_antisub = arg_13_1
	end

	function arg_1_0.set_support_power(arg_14_0, arg_14_1, arg_14_2)
		arg_14_0._support_atk_min = arg_14_1
		arg_14_0._support_atk_max = arg_14_2
	end

	function arg_1_0.set_target_is_full_hp(arg_15_0, arg_15_1)
		if not arg_15_1 then
			arg_15_0._is_full_hp_before_attack = false
		end

		local var_15_0 = arg_15_1:get_attribute()

		arg_15_0._is_full_hp_before_attack = var_15_0.now_hp:get_final_value() >= var_15_0.hp:get_final_value()
	end

	function arg_1_0:init(arg_16_1)
		self._source_id = arg_16_1.source_id
		self._target_id = arg_16_1.target_id
		self._attack_type = arg_16_1.formation_attack_type
		self._round_type = arg_16_1.type
		self._damage_attr = self._damage_attr or {}
		self._damage_record = self._damage_record or {}
		self._damage_attr = {
			is_ricochet = false,
			damage = 0,
			is_immune = false,
			is_dodging = false,
			is_double = false,
			is_immune_pool_used = false,
			is_miss = false,
			is_recover_life = false,
			is_crit = false,
			damage_type = var_0_5.damage_type.normal,
			syncytium_skill = arg_16_1.syncytium_skill
		}

		local var_16_0 = var_0_4("__calculate_%s", arg_16_1.type)

		if not self[var_16_0] then
			return
		end

		local var_16_1 = self._battle_obj_mgr:findObject(self._source_id)
		local var_16_2 = self._battle_obj_mgr:findObject(self._target_id)
		local var_16_3
		local var_16_4

		if var_16_1 then
			var_16_3 = var_16_1:get_attribute()
		end

		if var_16_2 then
			var_16_4 = var_16_2:get_attribute()

			var_16_2:set_total_attack(1)
		end

		if var_16_1 and var_16_1:get_attribute().probability and not var_16_1:get_attribute().probability.is_random then
			var_16_1:get_attribute().probability.determine = self._battle_random:randomRangeDouble(0, 1) <= var_16_1:get_attribute().probability.rate
		end

		if var_16_2:get_attribute().probability and not var_16_2:get_attribute().probability.is_random then
			local var_16_5 = self._battle_random:randomRangeDouble(0, 1)

			if var_16_5 > var_16_2:get_attribute().probability.rate then
				var_16_2:get_attribute().probability.determine = false
			elseif var_16_5 <= var_16_2:get_attribute().probability.rate then
				var_16_2:get_attribute().probability.determine = true
			end
		end

		if var_16_1 and var_16_1:get_attribute().change_attr then
			for iter_16_0, iter_16_1 in pairs(var_16_1:get_attribute().change_attr) do
				if iter_16_1.before ~= iter_16_1.after then
					self:set_damage_record(var_0_5:get_attr_name_cn(iter_16_1.attr_type) .. "触发技能效果:", iter_16_1.desc .. "。之前为:" .. iter_16_1.before .. "。之后为:" .. iter_16_1.after)
				end
			end
		end

		if var_16_2 and var_16_2:get_attribute().change_attr then
			for iter_16_2, iter_16_3 in pairs(var_16_2:get_attribute().change_attr) do
				if iter_16_3.before ~= iter_16_3.after then
					self:set_damage_record(var_0_5:get_attr_name_cn(iter_16_3.attr_type) .. "触发技能效果:敌方", iter_16_3.desc .. "。之前为:" .. iter_16_3.before .. "。之后为:" .. iter_16_3.after)
				end
			end
		end

		local var_16_6 = self._battle_scene:get_buff_list()

		if var_16_6 then
			for iter_16_4, iter_16_5 in pairs(var_16_6) do
				if var_16_1 and var_16_2 then
					iter_16_5:do_buff_logic(var_16_1, var_16_2, nil, self._battlefield._battle_step)
				end
			end
		end

		self:set_atk_type_by_data_type(var_16_1, var_16_2, arg_16_1.type)

		if not var_16_2:is_submarine() then
			self:set_direction_correct(var_16_1)
		end

		self:set_damage_correct(var_16_1, var_16_2)
		self:set_formation_correct(var_16_1, arg_16_1.formation_attack_type)
		self:set_radar_correct(var_16_1, var_16_2)
		self:set_target_is_full_hp(var_16_2)

		self.skill_replace_hit = false

		self:set_final_damage_by_skil(var_16_1, var_16_2, arg_16_1.type)
		self:set_add_attribute_by_attr_skill(var_16_1, var_16_2, arg_16_1.type)

		if self.skill_replace_hit_without_buff then
			return
		end

		if not self.skill_replace_hit then
			self[var_16_0](self, var_16_1, var_16_2, var_16_3, var_16_4)
		end

		self:set_fixed_damage_by_skil(var_16_1, var_16_2, arg_16_1.hurt_rate)
		self:__reset_attribute(var_16_1, var_16_2)
	end

	function arg_1_0:set_atk_type_by_data_type(arg_17_1, arg_17_2, arg_17_3)
		if arg_17_3 == "normal_attack" then
			if self._normal_attack_type == var_0_5.normal_attack_type.aircraft and not arg_17_2:is_submarine() then
				arg_17_1:set_atk_type(var_0_5.attack_round.aircraft)
			elseif self._normal_attack_type == var_0_5.normal_attack_type.torpedo then
				arg_17_1:set_atk_type(var_0_5.attack_round.torpedo)
			elseif arg_17_2:is_submarine() then
				arg_17_1:set_atk_type(var_0_5.attack_round.antisub)
			else
				arg_17_1:set_atk_type(var_0_5.attack_round.normal)
			end
		elseif arg_17_3 == "torpedo_attack" then
			arg_17_1:set_atk_type(var_0_5.attack_round.torpedo)
		elseif arg_17_3 == "aircraft_attack" then
			arg_17_1:set_atk_type(var_0_5.attack_round.aircraft)

			if self._plane_type and self._plane_type == var_0_5.equip_type.torpedo_plane then
				arg_17_1:set_atk_type(var_0_5.attack_round.aircraft_torpedo)
			end
		elseif arg_17_3 == "missile_attack" then
			arg_17_1:set_atk_type(var_0_5.attack_round.missile)
		end
	end

	function arg_1_0:__calculate_support_attack(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
		local var_18_0 = self._battle_random:randRange(self._support_atk_min, self._support_atk_max)

		self:set_damage_record("伤害", var_0_4("%d", var_18_0))

		self._damage_attr.damage = var_18_0

		local var_18_1 = arg_18_4.now_hp:get_final_value() - var_18_0

		var_18_1 = var_18_1 > 0 and var_18_1 or 0

		arg_18_4.now_hp:modify_to_value(var_18_1)

		if var_18_1 <= 0 then
			arg_18_2:set_is_alive(false)
			self:__process_unit_die(arg_18_2)
		end

		if arg_18_2:get_side() == var_0_5.obj_side.enemy and arg_18_2:is_flag() then
			self._damage_attr.boss_info = {}

			local var_18_2 = arg_18_4.now_hp:get_final_value()

			self._battle_scene:update_boss_hp(var_0_2.abs(arg_18_4.now_hp:get_next_value() - var_18_2), arg_18_2:getID(), var_18_2)

			self._damage_attr.boss_info = var_0_1.clone_table(self._battle_scene:get_boss_info())
		end
	end

	function arg_1_0:__calculate_normal_attack(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
		if not arg_19_1 or not arg_19_2 then
			return
		end

		if self._normal_attack_type == var_0_5.normal_attack_type.aircraft and not arg_19_2:is_submarine() then
			self:__aircraft_damage(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
		elseif self._normal_attack_type == var_0_5.normal_attack_type.torpedo then
			arg_19_1:get_attribute().in_torpedo = true

			self:__calculate_torpedo_attack(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
		elseif arg_19_2:is_submarine() then
			if arg_19_1:get_ship_type() == var_0_5.ship_type.light_aircraft_carrier or arg_19_1:get_ship_type() == var_0_5.ship_type.aviation_battle_ship then
				self:__lac_damage(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
			else
				self:__destroyer_damage(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
			end
		else
			self:__nomal_damage(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
		end
	end

	function arg_1_0:__change_damage_atke(arg_20_1, arg_20_2, arg_20_3)
		if arg_20_1:get_attribute().set_atk_by_attr then
			local var_20_0 = arg_20_1:get_attribute().set_atk_by_attr.attr_type
			local var_20_1 = arg_20_1:get_attribute().set_atk_by_attr.rate

			arg_20_3 = arg_20_1:get_attribute()[var_20_0]:get_final_value() * var_20_1

			self:set_damage_record("发动技能：将基础攻击力变为自身xx%属性", var_0_4("基本攻击力变为自身%s属性的%s倍=%s", var_0_5:get_attr_name_cn(var_20_0), var_20_1, arg_20_3))
		end

		if arg_20_1:get_attribute().set_atk_by_percent then
			local var_20_2 = arg_20_1:get_attribute().set_atk_by_percent.rate

			arg_20_3 = arg_20_3 * var_20_2

			self:set_damage_record("发动技能：基础攻击力乘以XX%，多个来源叠乘", var_0_4("基本攻击力变为%s倍=%s", var_20_2, arg_20_3))
		end

		if arg_20_1:get_attribute().set_atk_by_percent_by_lose_hp then
			local var_20_3 = arg_20_1:get_attribute().set_atk_by_percent_by_lose_hp.rate

			arg_20_3 = arg_20_3 * var_20_3

			self:set_damage_record("发动技能：随血量减少提升攻击力，与基础攻击力系数叠乘", var_0_4("基本攻击力变为%s倍=%s", var_20_3, arg_20_3))
		end

		return arg_20_3
	end

	function arg_1_0:__calculate_missile_attack(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
		if not arg_21_1 or not arg_21_2 then
			return
		end

		self:hit_division_half_miss(arg_21_1, arg_21_2, 0.5)

		if self:__before_damage(arg_21_1, arg_21_2, arg_21_4) then
			return
		end

		if self._damage_attr.is_miss then
			arg_21_2:set_total_miss(1)

			self._damage_attr.damage_type = var_0_5.damage_type.miss

			return
		end

		local var_21_0 = self:get_crit_value(arg_21_1, arg_21_3, arg_21_2)
		local var_21_1 = arg_21_3.atk:get_final_value() - arg_21_1:get_all_equip_attr_by_name("atk")

		var_21_1 = var_21_1 < 0 and 0 or var_21_1

		local var_21_2 = arg_21_3.ship_atk:get_final_value()
		local var_21_3 = self:__change_damage_atke(arg_21_1, arg_21_2, self._missile_atk * 3 + var_21_1)

		self:set_damage_record("基础攻击力", var_0_4("导弹火力%d*3 + 船只火力(不包括装备，但吃到技能加成)%d=%d", self._missile_atk, var_21_1, var_21_3))

		local var_21_4 = self:get_equip_correct(arg_21_1)

		if var_21_4 ~= 1 then
			var_21_3 = var_21_3 * var_21_4

			self:set_damage_record("特殊装备效果，百分比增加攻击力(多件乘算):", var_0_4("提升比例%.6f，基本攻击力%.2f→%.2f", var_21_4 - 1, var_21_3 / var_21_4, var_21_3))
		end

		local var_21_5 = arg_21_4.def:get_final_value()

		if var_21_5 < 0 then
			var_21_5 = 0
		end

		local var_21_6 = 0
		local var_21_7 = self:get_atk_rate(arg_21_1)
		local var_21_8 = self:get_bullet_correct(arg_21_1)
		local var_21_9 = self:get_before_bottleneck_correct(arg_21_1)
		local var_21_10 = arg_21_3.ap:get_final_value()

		if self._attack_type == "night_attack" then
			var_21_6 = self:def_rate_by_armor(arg_21_2, var_21_3 * var_21_9 * var_21_0 * var_21_7, 1, arg_21_1, nil, "基本攻击力*瓶颈前的补正值*暴击补正值*伤害浮动系数")
		else
			if arg_21_1:get_attribute().armor_penetration and arg_21_1:get_attribute().armor_penetration > 0 then
				var_21_10 = var_21_10 + arg_21_1:get_attribute().armor_penetration

				self:set_damage_record("触发技能:导弹伤害阶段护甲穿透效果增加", "护甲穿透效果增加" .. arg_21_1:get_attribute().armor_penetration)
			end

			if var_21_5 <= 50 then
				if arg_21_1:get_attribute().ignore_rate_by_armor_in_crit and self._damage_attr.is_crit or arg_21_1:is_medhp() and arg_21_1:get_attribute().ignore_rate_by_armor_in_special_ship or arg_21_1:is_lowhp() and arg_21_1:get_attribute().ignore_rate_by_armor_in_special_ship then
					var_21_6 = 1 + var_21_10

					self:set_damage_record("护甲小于50的情况下无视护甲加穿透", var_0_4("1 + 护甲穿透%.2f=%.2f", var_21_10, 1 + var_21_10))
				else
					var_21_6 = 1 - var_0_2.pow(var_21_5, 2) / 12500 + var_21_10

					self:set_damage_record("减伤", var_0_4("1-pow(目标防御%d,2)/12500 + 护甲穿透%.2f=%.2f", var_21_5, var_21_10, var_21_6))
				end
			elseif arg_21_1:get_attribute().ignore_rate_by_armor_in_crit and self._damage_attr.is_crit or arg_21_1:is_medhp() and arg_21_1:get_attribute().ignore_rate_by_armor_in_special_ship or arg_21_1:is_lowhp() and arg_21_1:get_attribute().ignore_rate_by_armor_in_special_ship then
				var_21_6 = 1 + var_21_10

				self:set_damage_record("护甲大于50的情况下无视护甲加穿透", var_0_4("1 + 护甲穿透%.2f=%.2f", var_21_10, 1 + var_21_10))
			else
				var_21_6 = (var_21_5 - 150) * (8e-05 * var_21_5 - 0.012) + var_21_10

				self:set_damage_record("减伤", var_0_4("(目标防御%d-150)*(0.00008*目标防御%d-0.012) + 护甲穿透%.2f=%.2f", var_21_5, var_21_5, var_21_10, (var_21_5 - 150) * (8e-05 * var_21_5 - 0.012) + var_21_10))
			end
		end

		local var_21_11 = self:get_sixth_year_ship_buff(arg_21_1)
		local var_21_13, var_21_14 = var_0_2.modf(var_21_3 * var_21_9 * var_21_0 * var_21_6 * var_21_7)
		local var_21_15 = var_0_2.ceil(((var_21_14 and var_21_14 > 0.001 or nil) and var_21_13 + 1) * var_21_11)

		self:set_damage_record("伤害", var_0_4("math.ceil(math.ceil(基本攻击力%d*瓶颈前的补正值%.2f*暴击补正值%.2f*减伤%.6f*伤害浮动系数%.2f)*六周年加成%.6f)=%d", var_21_3, var_21_9, var_21_0, var_21_6, var_21_7, var_21_11, var_21_15))

		local var_21_16 = self:__min_damage(var_21_15, arg_21_4.now_hp:get_final_value(), var_0_2.ceil(var_21_3 * var_21_9 * var_21_0 * var_21_7), true)

		self._damage_attr.damage = var_21_16

		if var_21_16 > arg_21_4.now_hp:get_final_value() then
			var_21_16 = arg_21_4.now_hp:get_final_value()
		end

		arg_21_4.now_hp:modify_to_value(arg_21_4.now_hp:get_final_value() - var_21_16)
		self:__after_damage(arg_21_1, arg_21_2, not self._damage_attr.is_miss)
	end

	function arg_1_0:__calculate_torpedo_attack(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
		if not arg_22_1 or not arg_22_2 then
			return
		end

		self:__get_immune_state_by_tactics(arg_22_1, arg_22_2)

		if self._damage_attr.is_miss then
			return
		end

		self:hit_division_half_miss(arg_22_1, arg_22_2)

		if self:__before_damage(arg_22_1, arg_22_2, arg_22_4) then
			return
		end

		if self._damage_attr.is_miss then
			arg_22_2:set_total_miss(1)

			self._damage_attr.damage_type = var_0_5.damage_type.miss

			return
		end

		local var_22_0 = self:get_crit_value(arg_22_1, arg_22_3, arg_22_2)
		local var_22_1 = arg_22_3.torpedo:get_final_value() < 0 and 0 or arg_22_3.torpedo:get_final_value()
		local var_22_2 = self:get_addition_atk_by_day_or_night()
		local var_22_3 = var_22_1 + var_22_2

		self:set_damage_record("基本攻击力", string.format("船只鱼雷%s+%d=%d", var_22_1, var_22_2, var_22_1 + var_22_2))

		if self._damage_attr.syncytium_skill then
			var_22_3 = var_0_2.ceil(var_22_3 * self._damage_attr.syncytium_skill)

			self:set_damage_record("触发合体技能", var_0_4("船只鱼雷 * 技能系数%f = %d", self._damage_attr.syncytium_skill, var_22_3))
		end

		local var_22_4 = self:__change_damage_atke(arg_22_1, arg_22_2, var_22_3)
		local var_22_5 = self:get_equip_correct(arg_22_1)

		if var_22_5 ~= 1 then
			var_22_4 = var_22_4 * var_22_5

			self:set_damage_record("特殊装备效果，百分比增加攻击力(多件乘算):", var_0_4("提升比例%.6f，基本攻击力%.2f→%.2f", var_22_5 - 1, var_22_4 / var_22_5, var_22_4))
		end

		local var_22_6 = self:get_atk_rate(arg_22_1)
		local var_22_7 = self:get_bullet_correct(arg_22_1)
		local var_22_8 = self:get_before_bottleneck_correct(arg_22_1)
		local var_22_9 = self:def_rate_by_armor(arg_22_2, var_22_4 * var_22_8 * var_22_0 * var_22_7 * var_22_6, var_0_5.reduce_injury_type.torpedo_rate, arg_22_1, nil, "基本攻击力*瓶颈前的补正值*暴击补正值*弹药量补正*伤害浮动系数")
		local var_22_10 = self:get_sixth_year_ship_buff(arg_22_1)
		local var_22_11 = var_0_2.ceil(var_0_2.ceil(var_22_4 * var_22_8 * var_22_0 * var_22_9 * var_22_7 * var_22_6) * var_22_10)

		self:set_damage_record("伤害", var_0_4("math.ceil(math.ceil(基本攻击力%d*瓶颈前的补正值%.2f*暴击补正值%.2f*减伤%.6f*弹药量补正%.2f*伤害浮动系数%.2f)*六周年加成%.6f)=%d", var_22_4, var_22_8, var_22_0, var_22_9, var_22_7, var_22_6, var_22_10, var_22_11))

		local var_22_12 = self:__min_damage(var_22_11, arg_22_4.now_hp:get_final_value(), var_22_4)

		self._damage_attr.damage = var_22_12

		if var_22_12 > arg_22_4.now_hp:get_final_value() then
			var_22_12 = arg_22_4.now_hp:get_final_value()
		end

		arg_22_4.now_hp:modify_to_value(arg_22_4.now_hp:get_final_value() - var_22_12)
		self:__after_damage(arg_22_1, arg_22_2, not self._damage_attr.is_miss)
	end

	function arg_1_0:__calculate_antisub_attack(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
		if not arg_23_1 or not arg_23_2 then
			return
		end

		if arg_23_1:get_ship_type() == var_0_5.ship_type.light_aircraft_carrier then
			self:__lac_damage(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
		else
			self:__destroyer_damage(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
		end
	end

	function arg_1_0:__calculate_aircraft_attack(arg_24_1, arg_24_2, arg_24_3, arg_24_4)
		if not arg_24_1 or not arg_24_2 then
			return
		end

		self:__get_immune_state_by_tactics(arg_24_1, arg_24_2)

		if self._damage_attr.is_miss then
			return
		end

		self:set_aircontrol_correct(arg_24_1)

		self._damage_attr.is_miss = self:__roll_hit_rate((self:__get_aircraft_hit_rate(arg_24_1, arg_24_2, arg_24_3, arg_24_4)))

		if arg_24_3.sure_to_hit then
			self._damage_attr.is_miss = false

			self:set_damage_record("触发技能:此次攻击必定命中", "此次攻击必定命中")
		end

		local var_24_0 = arg_24_3.sure_to_hit_by_shiptype

		if arg_24_3.sure_to_hit_by_shiptype then
			local var_24_1

			if var_24_0.type == "shipTypes" then
				var_24_1 = arg_24_2:get_ship_type()
			elseif var_24_0.type == "shipTons" then
				var_24_1 = arg_24_2:get_ship_ton()
			elseif var_24_0.type == "guardTypes" then
				var_24_1 = arg_24_2:get_ship_guard_type()
			end

			for iter_24_0, iter_24_1 in pairs(var_24_0.type_num) do
				if var_24_1 == iter_24_1 then
					self._damage_attr.is_miss = false

					self:set_damage_record("触发技能:攻击xx舰种/大中小型船/主力护卫舰时必定命中", "此次攻击必定命中")

					break
				end
			end
		end

		if self._fly_num == 0 then
			self._damage_attr.is_miss = true
		end

		if arg_24_1:get_ignore_miss() then
			self._damage_attr.is_miss = false

			self:set_damage_record("活动buff:", "此次攻击必定命中")
		end

		if self:__before_damage(arg_24_1, arg_24_2, arg_24_4) then
			return
		end

		self:set_damage_record("航空攻击是否被闪避", string.format("%s", self._damage_attr.is_miss) .. ",闪避时候的打击伤害为:" .. self._damage_attr.damage .. ",闪避情况下当前hp为：" .. arg_24_2:get_attribute().now_hp:get_final_value())

		if self._damage_attr.is_miss then
			self._damage_attr.damage = self._damage_attr.damage - self._fix_damage_add

			self:set_damage_record("航空攻击被闪避", "当前的固伤加成伤害置空")
		end

		if self._damage_attr.is_miss then
			arg_24_2:set_total_miss(1)

			self._damage_attr.damage_type = var_0_5.damage_type.miss

			return
		end

		local var_24_2 = self:get_crit_value(arg_24_1, arg_24_3, arg_24_2)
		local var_24_3 = self:__get_plane_atk(arg_24_1)

		var_24_3 = var_24_3 < 0 and 0 or var_24_3

		local var_24_4 = self:__change_damage_atke(arg_24_1, arg_24_2, var_24_3)
		local var_24_5 = self:get_atk_rate(arg_24_1)
		local var_24_6 = self:get_bullet_correct(arg_24_1)
		local var_24_7 = self:get_before_bottleneck_correct(arg_24_1)
		local var_24_8 = self:def_rate_by_armor(arg_24_2, var_24_4 * var_24_7 * var_24_2 * var_24_6 * var_24_5 * self._aircontrol_power, (self._plane_type == var_0_5.equip_type.bomber or nil) and (var_0_5.reduce_injury_type.aircraft_normal_rate or var_0_5.reduce_injury_type.aircraft_bomber_rate), arg_24_1, nil, "基本攻击力*瓶颈前的补正值*暴击补正值*弹药量补正*伤害浮动系数*制空伤害补正")
		local var_24_9 = self:__get_aircraft_def(arg_24_2, arg_24_4)
		local var_24_10 = self:get_sixth_year_ship_buff(arg_24_1)
		local var_24_11 = var_0_2.ceil(var_0_2.ceil(var_0_2.ceil(var_24_4 * var_24_7 * var_24_2 * var_24_8 * var_24_6 * var_24_5 * self._aircontrol_power) * var_24_9) * var_24_10)

		self:set_damage_record("伤害", var_0_4("math.ceil(math.ceil(math.ceil(基本攻击力%.2f*瓶颈前的补正值%.2f*暴击补正值%.2f*减伤%.6f*弹药量补正%.2f*伤害浮动系数%.2f*制空伤害补正%.2f)*防空减伤%.6f)*六周年加成%.6f)=%d", var_24_4, var_24_7, var_24_2, var_24_8, var_24_6, var_24_5, self._aircontrol_power, var_24_9, var_24_10, var_24_11))

		if self._plane_type == var_0_5.equip_type.bomber and arg_24_2:get_ship_type() == var_0_5.ship_type.seaplane_tender then
			var_24_11 = var_0_2.ceil(var_24_11 * 0.25)

			self:set_damage_record("装甲航母受伤害减少75%", var_0_4("伤害前:%d, 伤害后:%d", var_24_11, var_24_11))
		end

		self._damage_attr.damage = self:__min_damage(var_24_11, arg_24_4.now_hp:get_final_value(), var_24_4)

		local var_24_12 = arg_24_4.now_hp:get_final_value() - self._damage_attr.damage

		var_24_12 = var_24_12 < 0 and 0 or var_24_12

		arg_24_4.now_hp:modify_to_value(var_24_12)
		self:__after_damage(arg_24_1, arg_24_2, not self._damage_attr.is_miss, "aircraft_attack")
	end

	function arg_1_0:__nomal_damage(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
		self:__get_immune_state_by_tactics(arg_25_1, arg_25_2)

		if self._damage_attr.is_miss then
			return
		end

		self:hit_division_half_miss(arg_25_1, arg_25_2)

		if self:__before_damage(arg_25_1, arg_25_2, arg_25_4) then
			return
		end

		if self._damage_attr.is_miss then
			arg_25_2:set_total_miss(1)

			self._damage_attr.damage_type = var_0_5.damage_type.miss

			return
		end

		local var_25_0 = self:get_crit_value(arg_25_1, arg_25_3, arg_25_2)
		local var_25_1 = arg_25_3.atk:get_final_value()

		var_25_1 = var_25_1 < 0 and 0 or var_25_1

		local var_25_2 = self:get_addition_atk_by_day_or_night()
		local var_25_3 = arg_25_3.atk:get_final_value() + var_25_2

		self:set_damage_record("基础攻击力", var_0_4("船只火力%d+%d=%d", var_25_1, var_25_2, var_25_3))

		local var_25_4 = self:__change_damage_atke(arg_25_1, arg_25_2, var_25_3)
		local var_25_5 = self:get_equip_correct(arg_25_1)

		if var_25_5 ~= 1 then
			var_25_4 = var_25_4 * var_25_5

			self:set_damage_record("特殊装备效果，百分比增加攻击力(多件乘算):", var_0_4("提升比例%.6f，基本攻击力%.2f→%.2f", var_25_5 - 1, var_25_4 / var_25_5, var_25_4))
		end

		local var_25_6 = self:get_atk_rate(arg_25_1)
		local var_25_7 = self:get_bullet_correct(arg_25_1)
		local var_25_8 = self:get_before_bottleneck_correct(arg_25_1)
		local var_25_9 = self:def_rate_by_armor(arg_25_2, var_25_4 * var_25_8 * var_25_0 * var_25_7 * var_25_6, var_0_5.reduce_injury_type.normal_battle_rate, arg_25_1, var_0_5.calculate_def_type.normal_attack, "基本攻击力*瓶颈前的补正值*暴击补正值*弹药量补正*伤害浮动系数")
		local var_25_10 = self:get_sixth_year_ship_buff(arg_25_1)
		local var_25_11 = var_0_2.ceil(var_0_2.ceil(var_25_4 * var_25_8 * var_25_0 * var_25_9 * var_25_7 * var_25_6) * var_25_10)

		self:set_damage_record("伤害", var_0_4("math.ceil(math.ceil(基本攻击力%d*瓶颈前的补正值%.2f*暴击补正值%.2f*减伤%.6f*弹药量补正%.2f*伤害浮动系数%.2f)*六周年加成%.6f)=%d", var_25_4, var_25_8, var_25_0, var_25_9, var_25_7, var_25_6, var_25_10, var_25_11))

		local var_25_12 = self:__min_damage(var_25_11, arg_25_4.now_hp:get_final_value(), var_25_4)

		self._damage_attr.damage = var_25_12

		if var_25_12 > arg_25_4.now_hp:get_final_value() then
			var_25_12 = arg_25_4.now_hp:get_final_value()
		end

		arg_25_4.now_hp:modify_to_value(arg_25_4.now_hp:get_final_value() - var_25_12)
		self:__after_damage(arg_25_1, arg_25_2, not self._damage_attr.is_miss)
	end

	function arg_1_0:__aircraft_damage(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
		self:__get_immune_state_by_tactics(arg_26_1, arg_26_2)

		if self._damage_attr.is_miss then
			return
		end

		self:set_aircontrol_correct(arg_26_1)

		self._damage_attr.is_miss = self:__roll_hit_rate((self:__get_aircraft_hit_rate(arg_26_1, arg_26_2, arg_26_3, arg_26_4)))

		if arg_26_3.sure_to_hit then
			self._damage_attr.is_miss = false

			self:set_damage_record("触发技能:此次攻击必定命中", "此次攻击必定命中")
		end

		local var_26_0 = arg_26_3.sure_to_hit_by_shiptype

		if arg_26_3.sure_to_hit_by_shiptype then
			local var_26_1

			if var_26_0.type == "shipTypes" then
				var_26_1 = arg_26_2:get_ship_type()
			elseif var_26_0.type == "shipTons" then
				var_26_1 = arg_26_2:get_ship_ton()
			elseif var_26_0.type == "guardTypes" then
				var_26_1 = arg_26_2:get_ship_guard_type()
			end

			for iter_26_0, iter_26_1 in pairs(var_26_0.type_num) do
				if var_26_1 == iter_26_1 then
					self._damage_attr.is_miss = false

					self:set_damage_record("触发技能:攻击xx舰种/大中小型船/主力护卫舰时必定命中", "此次攻击必定命中")

					break
				end
			end
		end

		if arg_26_1:get_ignore_miss() then
			self._damage_attr.is_miss = false

			self:set_damage_record("活动buff:", "此次攻击必定命中")
		end

		if self:__before_damage(arg_26_1, arg_26_2, arg_26_4) then
			return
		end

		if self._damage_attr.is_miss then
			arg_26_2:set_total_miss(1)

			self._damage_attr.damage_type = var_0_5.damage_type.miss

			return
		end

		local var_26_2 = self:get_crit_value(arg_26_1, arg_26_3, arg_26_2)
		local var_26_3 = arg_26_3.atk:get_final_value()

		var_26_3 = var_26_3 < 0 and 0 or var_26_3

		local var_26_4 = arg_26_1:get_all_equip_attr_by_name("torpedo")

		var_26_4 = var_26_4 < 0 and 0 or var_26_4

		local var_26_5 = arg_26_1:get_all_equips_aircraft_atk()
		local var_26_6 = arg_26_1:get_ship_aircraft_add_hurt_info()
		local var_26_7 = self._battle_scene:get_player_air_control_type()

		if arg_26_1:get_side() == var_0_5.obj_side.enemy then
			var_26_7 = self._battle_scene:get_enemy_air_control_type()
		end

		local var_26_8 = var_26_7 == var_0_5.air_control_type.equl.value or var_26_7 == var_0_5.air_control_type.advantage.value or var_26_7 == var_0_5.air_control_type.supremacy.value
		local var_26_9 = var_26_3 + var_26_4 + var_26_5 * 2 + 35

		self:set_damage_record("基础攻击力", var_0_4("船只火力%d+装备鱼雷%d+所有装备的爆装%d*2+35=%d", var_26_3, var_26_4, var_26_5, var_26_3 + var_26_4 + var_26_5 * 2 + 35))

		local var_26_10 = self:__change_damage_atke(arg_26_1, arg_26_2, var_26_9)

		if arg_26_1:get_attribute().change_plane_damage then
			var_26_10 = var_26_10 * (1 + arg_26_1:get_attribute().change_plane_damage.boom)

			self:set_damage_record("触发技能：舰载机炮击战基础攻击力修正为", var_26_10)
		end

		if var_26_6 and var_26_6 ~= 0 and var_26_8 then
			var_26_10 = var_26_10 * (1 + var_26_6)

			self:set_damage_record("触发技能：舰载机威力变化", var_0_4("伤害前:%f, 伤害后:%f", var_26_10, var_26_10))
		end

		local var_26_11 = self:get_equip_correct(arg_26_1)
		local var_26_13
		local var_26_12
		local var_26_14

		if var_26_11 ~= 1 then
			var_26_10 = var_26_10 * var_26_11

			self:set_damage_record("特殊装备效果，百分比增加攻击力(多件乘算):", var_0_4("提升比例%.6f，基本攻击力%.2f→%.2f", var_26_11 - 1, var_26_10 / var_26_11, var_26_10))

			var_26_12 = self:get_atk_rate(arg_26_1)
			var_26_13 = self:get_bullet_correct(arg_26_1)
			var_26_14 = self:get_before_bottleneck_correct(arg_26_1)
		end

		local var_26_15 = self:def_rate_by_armor(arg_26_2, var_26_10 * var_26_14 * var_26_2 * var_26_13 * var_26_12 * self._aircontrol_power, var_0_5.reduce_injury_type.normal_battle_aircraft_rate, arg_26_1, nil, "基本攻击力*瓶颈前的补正值*暴击补正值*弹药量补正*伤害浮动系数*制空状态补正")
		local var_26_16 = self:__get_aircraft_def(arg_26_2, arg_26_4)
		local var_26_17 = self:get_sixth_year_ship_buff(arg_26_1)
		local var_26_18 = var_0_2.ceil(var_0_2.ceil(var_0_2.ceil(var_26_10 * var_26_14 * var_26_2 * var_26_15 * var_26_13 * var_26_12 * self._aircontrol_power) * var_26_16) * var_26_17)

		self:set_damage_record("伤害", var_0_4("math.ceil(math.ceil(math.ceil(基本攻击力%d*瓶颈前的补正值%.2f*暴击补正值%.2f*减伤%.6f*弹药量补正%.2f*伤害浮动系数%.2f*制空状态补正%.2f)*防空减伤%.6f)*六周年加成%.6f)=%d", var_26_10, var_26_14, var_26_2, var_26_15, var_26_13, var_26_12, self._aircontrol_power, var_26_16, var_26_17, var_26_18))

		local var_26_19 = self:__min_damage(var_26_18, arg_26_4.now_hp:get_final_value(), var_26_10)

		self._damage_attr.damage = var_26_19

		if var_26_19 > arg_26_4.now_hp:get_final_value() then
			var_26_19 = arg_26_4.now_hp:get_final_value()
		end

		arg_26_4.now_hp:modify_to_value(arg_26_4.now_hp:get_final_value() - var_26_19)
		self:__after_damage(arg_26_1, arg_26_2, not self._damage_attr.is_miss)
	end

	function arg_1_0:__destroyer_damage(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
		self:__get_immune_state_by_tactics(arg_27_1, arg_27_2)

		if self._damage_attr.is_miss then
			return
		end

		local var_27_0 = arg_27_3.ship_antisub and arg_27_3.ship_antisub:get_final_value() or 0

		var_27_0 = var_27_0 < 0 and 0 or var_27_0

		local var_27_1 = arg_27_1:get_all_equips_antisub_except_antisub()
		local var_27_2 = arg_27_4.miss:get_final_value()

		self:set_damage_record("基础命中率", var_0_4("船本身对潜值%d+对潜装备以外的装备提供的对潜总和%d/敌方回避%d/2=%.2f", var_27_0, var_27_1, var_27_2, (var_27_0 + var_27_1) / var_27_2 / 2))

		local var_27_3 = self:get_hit_rate_by_enemy_equips_effect(arg_27_2, (self:get_hit_rate_by_equips_effect(arg_27_1, (self:get_formation_correct_additional(arg_27_1, arg_27_2, (self:get_attack_correct_by_shiptype(arg_27_1, arg_27_2, (self:get_hit_rate_by_aircontrol((self:get_hit_rate_by_radar((self:get_hit_rate_by_formation((var_27_0 + var_27_1) / var_27_2 / 2))))))))))))) + arg_27_3.hit_repair:get_final_value() - arg_27_4.miss_repair:get_final_value()

		self:set_damage_record("双方命中闪避补正", var_0_4("命中补正%f-敌方闪避补正%f,总命中率为%f", arg_27_3.hit_repair:get_final_value(), arg_27_4.miss_repair:get_final_value(), var_27_3))

		local var_27_4 = self:__handle_rate((self:get_hit_rate_by_love_miss(arg_27_2, (self:get_hit_rate_by_love(arg_27_1, var_27_3)))))

		self:set_damage_record("命中率修正", var_0_4("命中率最大为0.95，最小为0.05，当前命中率为%f", var_27_4))

		self._damage_attr.is_miss = self:__roll_hit_rate(var_27_4)

		if arg_27_3.sure_to_hit_by_index and arg_27_1:get_index() == arg_27_2:get_index() then
			self._damage_attr.is_miss = false

			self:set_damage_record("触发技能:攻击对应位置目标必定命中", "此次攻击必定命中")
		end

		if arg_27_3.sure_to_hit and (not arg_27_3.skill_num.sure_to_hit or arg_27_3.skill_num.sure_to_hit > 0) then
			self._damage_attr.is_miss = false

			if arg_27_3.skill_num.sure_to_hit then
				arg_27_3.skill_num.sure_to_hit = arg_27_3.skill_num.sure_to_hit - 1
			end

			self:set_damage_record("触发技能:此次攻击必定命中", "此次攻击必定命中")
		end

		local var_27_5 = arg_27_3.sure_to_hit_by_shiptype

		if arg_27_3.sure_to_hit_by_shiptype then
			local var_27_6

			if var_27_5.type == "shipTypes" then
				var_27_6 = arg_27_2:get_ship_type()
			elseif var_27_5.type == "shipTons" then
				var_27_6 = arg_27_2:get_ship_ton()
			elseif var_27_5.type == "guardTypes" then
				var_27_6 = arg_27_2:get_ship_guard_type()
			end

			for iter_27_0, iter_27_1 in pairs(var_27_5.type_num) do
				if var_27_6 == iter_27_1 then
					self._damage_attr.is_miss = false

					self:set_damage_record("触发技能:攻击xx舰种/大中小型船/主力护卫舰时必定命中", "此次攻击必定命中")

					break
				end
			end
		end

		if arg_27_4.in_guardian then
			self._damage_attr.is_miss = false
		end

		local var_27_7 = self._battle_scene:get_attack_infallible_data()

		if var_27_7 then
			for iter_27_2, iter_27_3 in pairs(var_27_7.ship_list) do
				self._damage_attr.is_miss = false

				self:set_damage_record("触发芯片技能:", "此次攻击必定命中")
			end
		end

		if arg_27_1:get_ignore_miss() then
			self._damage_attr.is_miss = false

			self:set_damage_record("活动buff:", "此次攻击必定命中")
		end

		if self:__before_damage(arg_27_1, arg_27_2, arg_27_4) then
			return
		end

		if self._damage_attr.is_miss then
			arg_27_2:set_total_miss(1)

			self._damage_attr.damage_type = var_0_5.damage_type.miss

			return
		end

		local var_27_8 = self:get_crit_value(arg_27_1, arg_27_3, arg_27_2)
		local var_27_9 = arg_27_1:get_all_antisub_equips_antisub()
		local var_27_10
		local var_27_12

		if self._battle_scene:get_day_or_night_attack() == var_0_5.day_or_night.day then
			var_27_10 = 10
			var_27_12 = 0
		else
			var_27_10 = 30
			var_27_12 = 1
		end

		local var_27_13 = self:__change_damage_atke(arg_27_1, arg_27_2, (var_0_2.floor((var_0_2.pow(var_27_12 + var_27_9, 0.3333333333333333) * 20 + var_27_0 / 3) * (1 + var_27_1 / var_27_10))))

		self:set_damage_record("基础攻击力", var_0_4("(pow((%d+对潜装备提供的对潜总和%f),1/3)*20+船本身对潜值%f/3)*(1+对潜装备以外的装备提供的对潜总和%f/%d)=%.2f", var_27_12, var_27_9, var_27_0, var_27_1, var_27_10, var_27_13))

		local var_27_14 = self:get_equip_correct(arg_27_1)

		if var_27_14 ~= 1 then
			var_27_13 = var_27_13 * var_27_14

			self:set_damage_record("特殊装备效果，百分比增加攻击力(多件乘算):", var_0_4("提升比例%.6f，基本攻击力%.2f→%.2f", var_27_14 - 1, var_27_13 / var_27_14, var_27_13))
		end

		local var_27_15 = var_0_5.reduce_injury_type.antisubmarine_rate

		if self._battle_scene:get_day_or_night_attack() == var_0_5.day_or_night.night then
			var_27_15 = var_0_5.reduce_injury_type.night_antisub_rate
		end

		local var_27_16 = self:get_atk_rate(arg_27_1)
		local var_27_17 = self:get_bullet_correct(arg_27_1)
		local var_27_18 = self:get_before_bottleneck_correct(arg_27_1)
		local var_27_19 = self:def_rate_by_armor(arg_27_2, var_27_13 * var_27_18 * var_27_8 * var_27_17 * var_27_16, var_27_15, arg_27_1, nil, "基本攻击力*瓶颈前的补正值*暴击补正值*弹药量补正*伤害浮动系数")
		local var_27_20 = self:get_sixth_year_ship_buff(arg_27_1)
		local var_27_21 = var_0_2.ceil(var_0_2.ceil(var_27_13 * var_27_18 * var_27_8 * var_27_19 * var_27_17 * var_27_16) * var_27_20)

		self:set_damage_record("伤害", var_0_4("math.ceil(math.ceil(基本攻击力%.2f*瓶颈前的补正值%.2f*暴击补正值%.2f*减伤%.6f*弹药量补正%.2f*伤害浮动系数%.2f)*六周年加成%.6f)=%d", var_27_13, var_27_18, var_27_8, var_27_19, var_27_17, var_27_16, var_27_20, var_27_21))

		local var_27_22 = self:__min_damage(var_27_21, arg_27_4.now_hp:get_final_value(), var_27_13)

		self._damage_attr.damage = var_27_22

		if var_27_22 > arg_27_4.now_hp:get_final_value() then
			var_27_22 = arg_27_4.now_hp:get_final_value()
		end

		arg_27_4.now_hp:modify_to_value(arg_27_4.now_hp:get_final_value() - var_27_22)
		self:__after_damage(arg_27_1, arg_27_2, not self._damage_attr.is_miss)
	end

	function arg_1_0:__lac_damage(arg_28_1, arg_28_2, arg_28_3, arg_28_4)
		self:__get_immune_state_by_tactics(arg_28_1, arg_28_2)

		if self._damage_attr.is_miss then
			return
		end

		self:hit_division_half_miss(arg_28_1, arg_28_2)

		if self:__before_damage(arg_28_1, arg_28_2, arg_28_4) then
			return
		end

		if self._damage_attr.is_miss then
			arg_28_2:set_total_miss(1)

			self._damage_attr.damage_type = var_0_5.damage_type.miss

			return
		end

		local var_28_0 = self:get_crit_value(arg_28_1, arg_28_3, arg_28_2)
		local var_28_1 = arg_28_1:get_all_equips_antisub()
		local var_28_2 = arg_28_3.ship_antisub:get_final_value()

		var_28_2 = var_28_2 < 0 and 0 or var_28_2

		local var_28_3 = arg_28_3.radar:get_final_value()

		if var_28_3 < 0 then
			var_28_3 = 0
		end

		local var_28_4 = self:__change_damage_atke(arg_28_1, arg_28_2, var_28_1 * 2 + var_28_3 / 2 + var_28_2)

		self:set_damage_record("基础攻击力", var_0_4("所有装备对潜相加%d*2+索敌(包括装备)%d/2+舰船基础对潜%d=%.2f", var_28_1, var_28_3, var_28_2, var_28_4))

		local var_28_5 = self:get_equip_correct(arg_28_1)
		local var_28_8
		local var_28_7
		local var_28_6

		if var_28_5 ~= 1 then
			var_28_4 = var_28_4 * var_28_5

			self:set_damage_record("特殊装备效果，百分比增加攻击力(多件乘算):", var_0_4("提升比例%.6f，基本攻击力%.2f→%.2f", var_28_5 - 1, var_28_4 / var_28_5, var_28_4))

			var_28_6 = self:get_atk_rate(arg_28_1)
			var_28_7 = self:get_bullet_correct(arg_28_1)
			var_28_8 = self:get_before_bottleneck_correct(arg_28_1)
		end

		local var_28_9 = self:def_rate_by_armor(arg_28_2, var_28_4 * var_28_8 * var_28_0 * var_28_7 * var_28_6, var_0_5.reduce_injury_type.lac_damage_rate, arg_28_1, nil, "基本攻击力*瓶颈前的补正值*暴击补正值*弹药量补正*伤害浮动系数")
		local var_28_10 = self:get_sixth_year_ship_buff(arg_28_1)
		local var_28_11 = var_0_2.ceil(var_0_2.ceil(var_28_4 * var_28_8 * var_28_0 * var_28_9 * var_28_7 * var_28_6) * var_28_10)

		self:set_damage_record("伤害", var_0_4("math.ceil(math.ceil(基本攻击力%.2f*瓶颈前的补正值%.2f*暴击补正值%.2f*减伤%.6f*弹药量补正%.2f*伤害浮动系数%.2f)*六周年加成%.6f)=%d", var_28_4, var_28_8, var_28_0, var_28_9, var_28_7, var_28_6, var_28_10, var_28_11))

		local var_28_12 = self:__min_damage(var_28_11, arg_28_4.now_hp:get_final_value(), var_28_4)

		self._damage_attr.damage = var_28_12

		if var_28_12 > arg_28_4.now_hp:get_final_value() then
			var_28_12 = arg_28_4.now_hp:get_final_value()
		end

		arg_28_4.now_hp:modify_to_value(arg_28_4.now_hp:get_final_value() - var_28_12)
		self:__after_damage(arg_28_1, arg_28_2, not self._damage_attr.is_miss)
	end

	function arg_1_0:__calculate_night_mix_attack(arg_29_1, arg_29_2, arg_29_3, arg_29_4)
		if not arg_29_1 or not arg_29_2 then
			return
		end

		self:hit_division_half_miss(arg_29_1, arg_29_2)

		if self:__before_damage(arg_29_1, arg_29_2, arg_29_4) then
			return
		end

		if self._damage_attr.is_miss then
			arg_29_2:set_total_miss(1)

			self._damage_attr.damage_type = var_0_5.damage_type.miss

			return
		end

		local var_29_0 = self:get_crit_value(arg_29_1, arg_29_3, arg_29_2)
		local var_29_1 = arg_29_3.atk:get_final_value()

		var_29_1 = var_29_1 < 0 and 0 or var_29_1

		local var_29_2 = arg_29_3.torpedo:get_final_value()

		if var_29_2 < 0 then
			var_29_2 = 0
		end

		local var_29_3 = self:__change_damage_atke(arg_29_1, arg_29_2, var_29_1 + var_29_2 + 10)

		self:set_damage_record("混合攻击基础攻击力", var_0_4("船只火力%d+船只鱼雷%d+10=%d", var_29_1, var_29_2, var_29_3))

		local var_29_4 = self:get_equip_correct(arg_29_1)

		if var_29_4 ~= 1 then
			var_29_3 = var_29_3 * var_29_4

			self:set_damage_record("特殊装备效果，百分比增加攻击力(多件乘算):", var_0_4("提升比例%.6f，基本攻击力%.2f→%.2f", var_29_4 - 1, var_29_3 / var_29_4, var_29_3))
		end

		local var_29_5 = self:get_atk_rate(arg_29_1)
		local var_29_6 = self:get_before_bottleneck_correct(arg_29_1)
		local var_29_7 = self:get_bullet_correct(arg_29_1)
		local var_29_8 = self:def_rate_by_armor(arg_29_2, var_29_3 * var_29_6 * var_29_0 * var_29_7 * var_29_5, var_0_5.reduce_injury_type.night_mix_attack_rate, arg_29_1, nil, "基本攻击力*瓶颈前的补正值*暴击补正值*弹药量补正*伤害浮动系数")
		local var_29_9 = self:get_sixth_year_ship_buff(arg_29_1)
		local var_29_10 = var_0_2.ceil(var_0_2.ceil(var_29_3 * var_29_6 * var_29_0 * var_29_8 * var_29_7 * var_29_5) * var_29_9)

		self:set_damage_record("混合攻击伤害", var_0_4("math.ceil(math.ceil(基本攻击力%d*瓶颈前的补正值%.2f*暴击补正值%.2f*减伤%.6f*弹药量补正%.2f*伤害浮动系数%.2f)*六周年加成%.6f)=%d", var_29_3, var_29_6, var_29_0, var_29_8, var_29_7, var_29_5, var_29_9, var_29_10))

		local var_29_11 = self:__min_damage(var_29_10, arg_29_4.now_hp:get_final_value(), var_29_3)

		self._damage_attr.damage = var_29_11

		if var_29_11 > arg_29_4.now_hp:get_final_value() then
			var_29_11 = arg_29_4.now_hp:get_final_value()
		end

		arg_29_4.now_hp:modify_to_value(arg_29_4.now_hp:get_final_value() - var_29_11)
		self:__after_damage(arg_29_1, arg_29_2, not self._damage_attr.is_miss)
	end

	function arg_1_0:__get_plane_atk(arg_30_1)
		local var_30_0 = self:aircraft_attack_equip_add_attr(arg_30_1)
		local var_30_1 = self._battle_random:randRange(50, 100) / 100
		local var_30_2 = var_0_2.log(var_0_2.pow(self._fly_num + 1, 2))
		local var_30_3 = self._torpedo * var_30_2 * var_30_1 + 25

		if self._plane_type == var_0_5.equip_type.bomber then
			var_30_3 = self._aircraft_atk * var_30_2 + 25
		end

		local var_30_4 = var_30_3
		local var_30_5 = ""

		if var_30_0 ~= 0 then
			var_30_3 = var_30_3 * (1 + var_30_0)
			var_30_5 = var_0_4("*(1+专属或者特殊装备加成%f)", var_30_0)

			self:set_damage_record("专属或者特殊装备加成", var_0_4("%f", var_30_0))
		end

		if self._plane_type == var_0_5.equip_type.bomber then
			self:set_damage_record("基础攻击力", var_0_4("该格装备的爆装参数%d*(ln(该格飞出去的飞机数量%d+1)^2)+25=%.2f%s=%.2f", self._aircraft_atk, self._fly_num, var_30_4, var_30_5, var_30_3))

			var_30_3 = self:get_bomber_power_by_equips_effect(arg_30_1, var_30_3)
		end

		if self._plane_type == var_0_5.equip_type.torpedo_plane then
			self:set_damage_record("基础攻击力", var_0_4("该格装备的雷击参数%d*(ln(该格飞出去的飞机数量%d+1)^2)*rand%.2f+25=%.2f%s=%.2f", self._torpedo, self._fly_num, var_30_1, var_30_4, var_30_5, var_30_3))

			var_30_3 = self:get_torpedo_power_by_equips_effect(arg_30_1, var_30_3)
		end

		local var_30_6 = arg_30_1:get_ship_aircraft_add_hurt_info()
		local var_30_7 = self._battle_scene:get_player_air_control_type()

		if arg_30_1:get_side() == var_0_5.obj_side.enemy then
			var_30_7 = self._battle_scene:get_enemy_air_control_type()
		end

		if var_30_6 and var_30_6 ~= 0 and (var_30_7 == var_0_5.air_control_type.equl.value or var_30_7 == var_0_5.air_control_type.advantage.value or var_30_7 == var_0_5.air_control_type.supremacy.value) then
			var_30_3 = var_30_3 * (1 + var_30_6)

			self:set_damage_record("触发技能：舰载机威力变化", var_0_4("伤害前:%f, 伤害后:%f", var_30_3, var_30_3))
		end

		if arg_30_1:get_attribute().change_plane_damage then
			if self._plane_type == var_0_5.equip_type.bomber then
				var_30_3 = var_30_3 * (arg_30_1:get_attribute().change_plane_damage.boom + 1)

				self:set_damage_record("触发技能：", var_0_4("轰炸机攻击力前:%f,后:%f，加成比率为%.4f", var_30_3, var_30_3, arg_30_1:get_attribute().change_plane_damage.boom))
			elseif self._plane_type == var_0_5.equip_type.torpedo_plane then
				var_30_3 = var_30_3 * (arg_30_1:get_attribute().change_plane_damage.torpedo + 1)

				self:set_damage_record("触发技能：", var_0_4("鱼雷机攻击力前:%f,后:%f，加成比率为%.4f", var_30_3, var_30_3, arg_30_1:get_attribute().change_plane_damage.torpedo))
			end
		end

		return var_30_3
	end

	function arg_1_0:__get_aircraft_hit_rate(arg_31_1, arg_31_2, arg_31_3, arg_31_4)
		local var_31_1 = arg_31_3.hit:get_final_value()
		local var_31_2 = arg_31_4.ship_air_def:get_final_value()

		var_31_2 = var_31_2 > 0 and var_31_2 or 0

		self:set_damage_record("受击方技能结算后的裸对空", var_0_4("%f", var_31_2))

		local var_31_3 = arg_31_2:get_all_equip_air_def()

		self:set_damage_record("受击方装备对空", string.format("%f", var_31_3))
		self:set_damage_record("受击方对空", var_0_4("受击方自身对空%f*0.4+装备带的对空%f=%f", var_31_2, var_31_3, var_31_2 * 0.4 + var_31_3))

		local var_31_4 = var_0_5:get_ton_airdef(arg_31_2:get_ship_ton(), "mul")

		self:set_damage_record("航空基础命中率", var_0_4("攻击方命中%d/(受击方对空%f*%f+攻击方命中%d=%f)", var_31_1, var_31_2 * 0.4 + var_31_3, var_31_4, var_31_1, var_31_1 / ((var_31_2 * 0.4 + var_31_3) * var_31_4 + var_31_1)))

		local var_31_5 = self:get_hit_rate_by_air_love_miss(self:get_hit_rate_by_air_love_hit(self:get_hit_rate_by_enemy_equips_effect(arg_31_2, (self:get_hit_rate_by_equips_effect(arg_31_1, (self:get_formation_correct_additional(arg_31_1, arg_31_2, (self:get_attack_correct_by_shiptype(arg_31_1, arg_31_2, (self:get_hit_rate_by_aircontrol((self:get_hit_rate_by_radar((self:get_hit_rate_by_formation(var_31_1 / ((var_31_2 * 0.4 + var_31_3) * var_31_4 + var_31_1)))))))))))))), arg_31_1), arg_31_2) + arg_31_3.hit_repair:get_final_value() - arg_31_4.miss_repair:get_final_value()

		self:set_damage_record("航空战加上我方命中补正与减去敌方闪避补正", var_0_4("我方命中补正:%f，敌方闪避补正:%f，最终值为:%f", arg_31_3.hit_repair:get_final_value(), arg_31_4.miss_repair:get_final_value(), var_31_5))

		if self._is_beat_back then
			var_31_5 = 1
		end

		return var_31_5
	end

	function arg_1_0:__get_aircraft_def(arg_32_1, arg_32_2)
		if not arg_32_1 then
			return 1
		end

		local var_32_0 = arg_32_1:get_attribute()

		if not var_32_0 or not var_32_0.ship_air_def then
			return 1
		end

		local var_32_1 = var_32_0.ship_air_def:get_final_value()

		var_32_1 = var_32_1 > 0 and var_32_1 or 0

		local var_32_2 = var_32_1 * 0.4 + arg_32_1:get_all_equip_air_def()
		local var_32_3 = var_0_5:get_ton_airdef((arg_32_1:get_ship_ton()))

		self:set_damage_record("防空减伤", var_0_4("1-受击方对空%f/(受击方对空%f+%f)=%f", var_32_2, var_32_2, var_32_3, 1 - var_32_2 / (var_32_2 + var_32_3)))

		return 1 - var_32_2 / (var_32_2 + var_32_3)
	end

	function arg_1_0:__min_damage(arg_33_1, arg_33_2, arg_33_3, arg_33_4)
		local var_33_0 = var_0_2.ceil((var_0_2.min(arg_33_2 * 0.1, arg_33_3 * 0.1)))

		if arg_33_4 then
			var_33_0 = var_0_2.ceil(arg_33_3 * 0.1)
		end

		if arg_33_1 <= 0 then
			if arg_33_4 then
				self:set_damage_record("最终伤害小于最小伤害：固定打出最小伤害", var_0_4("减伤前最终伤害%d*0.1=%d", arg_33_3, var_33_0))

				return var_33_0
			end

			if self._battle_random:randRange(1, 100) > 50 then
				self:set_damage_record("最终伤害小于最小伤害：判定miss", var_0_4("min(最大血量%d*0.1,攻击方基础攻击力%d*0.1)=%d", arg_33_2, arg_33_3, var_33_0))

				self._damage_attr.damage_type = var_0_5.damage_type.miss
				self._damage_attr.is_miss = true
				self._damage_attr.is_crit = false
				self._damage_attr.is_ricochet = true

				return 0
			else
				self:set_damage_record("最终伤害小于最小伤害：判定打出最小伤害", var_0_4("min(最大血量%d*0.1,攻击方基础攻击力%d*0.1)=%d", arg_33_2, arg_33_3, var_33_0))

				self._damage_attr.is_ricochet = false

				return var_33_0
			end
		end

		return arg_33_1
	end

	function arg_1_0.__before_damage(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
		return false
	end

	function arg_1_0:__after_damage(arg_35_1, arg_35_2, arg_35_3, arg_35_4)
		local var_35_0 = arg_35_2:get_attribute()
		local var_35_1 = var_35_0.now_hp:get_final_value()

		if arg_35_3 then
			if not arg_35_2:get_fight_target() then
				arg_35_2.set_fight_target(arg_35_2, arg_35_2)
			end

			local var_35_2 = false

			if self._damage_attr.damage > 0 then
				var_35_0.now_hp:reduction_to_next_value()

				var_35_2 = true
			end

			self:set_damage_record("非替换技能阶段的额外伤害或者固伤加成，", "在命中后进行一波计算,这时候伤害会重新再算一次，不会和技能替换攻击冲突伤害")
			self:set_only_fixed_damage_by_skill(arg_35_1, arg_35_2)
			self:__set_enhance_damage_info(arg_35_1)
			self:__set_target_attack_state(arg_35_1, arg_35_2)
			self:__set_tower_buff_damage_effect(arg_35_1, arg_35_2)
			self:__set_rank_add_final_damage(arg_35_1, arg_35_2, false)

			local var_35_3 = arg_35_2:get_damage_with_ship_type()

			if var_0_3(var_35_3) then
				local var_35_4 = false
				local var_35_5 = arg_35_1:get_ship_type()

				for iter_35_0, iter_35_1 in pairs(var_35_3.shipTypes) do
					if var_35_5 == iter_35_1 then
						var_35_4 = true

						break
					end
				end

				if var_35_4 then
					self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage * (1 + var_35_3.rate))

					self:set_damage_record("技能减伤", var_0_4("被%s舰种攻击时，受到伤害变化%.2f%%，伤害=%d", var_0_5:get_ship_type_name_cn(var_35_5), var_35_3.rate * 100, self._damage_attr.damage))
				end
			end

			local var_35_6 = arg_35_2:get_damage_with_ship_ton()

			if var_0_3(var_35_6) then
				local var_35_7 = false
				local var_35_8 = arg_35_1:get_ship_ton()

				for iter_35_2, iter_35_3 in pairs(var_35_6.shipTons) do
					if var_35_8 == iter_35_3 then
						var_35_7 = true

						break
					end
				end

				if var_35_7 then
					self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage * (1 + var_35_6.rate))

					self:set_damage_record("技能减伤", var_0_4("被%s攻击时，受到伤害变化%.2f%%，伤害=%d", var_0_5:get_ship_ton_name_cn(var_35_8), var_35_6.rate * 100, self._damage_attr.damage))
				end
			end

			if self._is_beat_back then
				local var_35_9 = arg_35_1:get_num_of_beat_back()

				if var_35_9 and var_0_3(var_35_9) then
					self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage * (1 + var_35_9.hurt_rate))

					self:set_damage_record("技能减伤", var_0_4("反击：对攻击自己的敌方发动反击（每场战斗限XX次，大破无法发动）,必中，造成伤害变化%f 伤害=%d", var_35_9.hurt_rate, self._damage_attr.damage))
				end

				local var_35_10 = arg_35_1:get_damage_of_beat_back()

				if var_35_10 and var_0_3(var_35_10) then
					self._damage_attr.damage = var_35_10.damage

					self:set_damage_record("技能固伤", var_0_4("反击，造成固定伤害%d 伤害=%d", var_35_10.damage, self._damage_attr.damage))
				end

				local var_35_11 = arg_35_1:get_attribute().num_of_beat_back_with_fix_damage

				if var_35_11 then
					local var_35_12 = arg_35_1:get_attribute()[var_35_11.attr_type]:get_final_value() * var_35_11.attr_num

					self._damage_attr.damage = var_35_12

					self:set_damage_record("触发反击技能：自身大破时，对伤害来源造成YY属性的XX%固定伤害（每场战斗限XX次）", "反击，自身大破时，对伤害来源造成YY属性的XX%固定伤害" .. var_35_12)
				end

				if arg_35_1:get_attribute().skill_num and arg_35_1:get_attribute().skill_num.fight_back_percentage then
					self._damage_attr.tactics_id = arg_35_1:get_attribute().skill_num.fight_back_percentage
				end
			end

			if arg_35_2:get_immune_to_once_damage_state() then
				arg_35_2:set_immune_to_once_damage_state(false)

				self._damage_attr.is_immune = true
				self._damage_attr.damage = 0
				self._damage_attr.damage_type = var_0_5.damage_type.normal

				self:set_damage_record("技能免疫", var_0_4("为自身提供一个可抵御一次攻击的护盾 伤害=%d", self._damage_attr.damage))

				if var_35_2 then
					local var_35_13 = var_35_0.now_hp:reduction_to_next_value()
				end
			end

			self._damage_attr.damage = self:calculate_damage_increase(arg_35_1, arg_35_2, self._damage_attr.damage)

			self:calculate_damage_decrease(arg_35_1, arg_35_2)

			local var_35_14 = self._battle_scene:get_workshop_cfg_for_type_11(arg_35_1)

			if var_35_14 and var_0_3(var_35_14) then
				for iter_35_4, iter_35_5 in pairs(var_35_14) do
					if iter_35_5.shipTypes then
						for iter_35_6, iter_35_7 in pairs(iter_35_5.shipTypes) do
							if var_0_7:judge_stage(iter_35_5.num5, self._battlefield._battle_step) and iter_35_7 == arg_35_1:get_ship_type() then
								self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage * (1 + iter_35_5.num / 100))

								self:set_damage_record("编号" .. arg_35_1:getID() .. ":" .. "工坊伤害加成", var_0_4("增加%f伤害 伤害=%d", iter_35_5.num / 100, self._damage_attr.damage))
							end
						end
					end
				end
			end

			local var_35_15 = self._battle_scene:get_workshop_cfg_for_type_12(arg_35_2)

			if var_35_15 and var_0_3(var_35_15) then
				for iter_35_8, iter_35_9 in pairs(var_35_15) do
					if iter_35_9.shipTypes then
						for iter_35_10, iter_35_11 in pairs(iter_35_9.shipTypes) do
							if var_0_7:judge_stage(iter_35_9.num5, self._battlefield._battle_step) and iter_35_11 == arg_35_2:get_ship_type() then
								self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage * (1 - iter_35_9.num / 100))

								self:set_damage_record("编号" .. arg_35_1:getID() .. ":" .. "工坊伤害降低", var_0_4("减少%f伤害 伤害=%d", iter_35_9.num / 100, self._damage_attr.damage))
							end
						end
					end
				end
			end

			self:__set_equip_damage_effect(arg_35_1, arg_35_2)
			self:set_damage_record("专武加持下目标当前hp:", var_35_0.now_hp:get_final_value())

			local var_35_16 = var_35_0.now_hp:get_final_value() - self._damage_attr.damage

			self:set_damage_record("专武加持下目标受到伤害后的hp为:", var_35_16 .. ",  总伤害为: " .. self._damage_attr.damage)

			var_35_16 = var_35_16 > 0 and var_35_16 or 0

			var_35_0.now_hp:modify_to_value(var_35_16)
		end
	end

	function arg_1_0:__set_equip_damage_effect(arg_36_1, arg_36_2, arg_36_3)
		if arg_36_3 then
			self:set_damage_record("如果有这句话，说明是单独给某个技能额外计算了一次专武，比如正常攻击加成一次专武，技能固伤的单独再加一次", "")
		end

		self:set_damage_record("船只专属装备伤害加成前", "加成前伤害为：" .. self._damage_attr.damage .. ",加成船只为：" .. arg_36_1:get_ship_name())

		for iter_36_0, iter_36_1 in pairs(arg_36_1._equip_list) do
			local var_36_0 = var_0_14.find_object_by_cid(iter_36_1._cid)

			if var_0_3(var_36_0.exclusive_cid) and var_0_3(var_36_0.exclusive_buff) then
				for iter_36_2, iter_36_3 in pairs(var_36_0.exclusive_cid) do
					if iter_36_3 == arg_36_1:get_cid() then
						for iter_36_4, iter_36_5 in pairs(var_36_0.exclusive_buff) do
							if iter_36_5.type == 3 then
								if iter_36_5.stage and var_0_3(iter_36_5.stage) then
									for iter_36_6, iter_36_7 in pairs(iter_36_5.stage) do
										for iter_36_8, iter_36_9 in pairs(var_0_5.trigger_type) do
											if iter_36_9 == iter_36_7 and var_0_7:judge_stage(iter_36_7, self._battlefield._battle_step) then
												self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage * (1 + iter_36_5.num / 100))

												self:set_damage_record("编号" .. arg_36_1:getID() .. ":" .. "限定船只专属装备伤害阶段加成", var_0_4("增加%f伤害 伤害=%d", iter_36_5.num / 100, self._damage_attr.damage))
											end
										end
									end
								else
									self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage * (1 + iter_36_5.num / 100))

									self:set_damage_record("编号" .. arg_36_1:getID() .. ":" .. "限定船只专属装备伤害全阶段加成", var_0_4("增加%f伤害 伤害=%d", iter_36_5.num / 100, self._damage_attr.damage))
								end
							end
						end
					end
				end
			elseif not var_0_3(var_36_0.exclusive_cid) and var_0_3(var_36_0.exclusive_buff) then
				for iter_36_10, iter_36_11 in pairs(var_36_0.exclusive_buff) do
					if iter_36_11.type == 3 then
						if iter_36_11.stage and var_0_3(iter_36_11.stage) then
							for iter_36_12, iter_36_13 in pairs(iter_36_11.stage) do
								for iter_36_14, iter_36_15 in pairs(var_0_5.trigger_type) do
									if iter_36_15 == iter_36_13 and var_0_7:judge_stage(iter_36_13, self._battlefield._battle_step) then
										self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage * (1 + iter_36_11.num / 100))

										self:set_damage_record("编号" .. arg_36_1:getID() .. ":" .. "非限定船只专属装备伤害阶段加成", var_0_4("增加%f伤害 伤害=%d", iter_36_11.num / 100, self._damage_attr.damage))
									end
								end
							end
						else
							self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage * (1 + iter_36_11.num / 100))

							self:set_damage_record("编号" .. arg_36_1:getID() .. ":" .. "非限定船只专属装备伤害全阶段加成", var_0_4("增加%f伤害 伤害=%d", iter_36_11.num / 100, self._damage_attr.damage))
						end
					end
				end
			end
		end

		self:set_damage_record("船只专属装备伤害加成后", "加成后伤害为：" .. self._damage_attr.damage .. ",加成船只为：" .. arg_36_1:get_ship_name())

		for iter_36_16, iter_36_17 in pairs(arg_36_2._equip_list) do
			local var_36_1 = var_0_14.find_object_by_cid(iter_36_17._cid)

			if var_0_3(var_36_1.exclusive_cid) and var_0_3(var_36_1.exclusive_buff) then
				for iter_36_18, iter_36_19 in pairs(var_36_1.exclusive_cid) do
					if iter_36_19 == arg_36_2:get_cid() then
						for iter_36_20, iter_36_21 in pairs(var_36_1.exclusive_buff) do
							if iter_36_21.type == 4 then
								if iter_36_21.stage and var_0_3(iter_36_21.stage) then
									for iter_36_22, iter_36_23 in pairs(iter_36_21.stage) do
										for iter_36_24, iter_36_25 in pairs(var_0_5.trigger_type) do
											if iter_36_25 == iter_36_23 and var_0_7:judge_stage(iter_36_23, self._battlefield._battle_step) then
												self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage * (1 - iter_36_21.num / 100))

												self:set_damage_record("编号" .. arg_36_1:getID() .. ":" .. "限定船只专属装备阶段伤害减免", var_0_4("减免%f伤害 伤害=%d", iter_36_21.num / 100, self._damage_attr.damage))
											end
										end
									end
								else
									self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage * (1 - iter_36_21.num / 100))

									self:set_damage_record("编号" .. arg_36_1:getID() .. ":" .. "限定船只专属装备全阶段伤害减免", var_0_4("减免%f伤害 伤害=%d", iter_36_21.num / 100, self._damage_attr.damage))
								end
							end
						end
					end
				end
			elseif not var_0_3(var_36_1.exclusive_cid) and var_0_3(var_36_1.exclusive_buff) then
				for iter_36_26, iter_36_27 in pairs(var_36_1.exclusive_buff) do
					if iter_36_27.type == 4 then
						if iter_36_27.stage and var_0_3(iter_36_27.stage) then
							for iter_36_28, iter_36_29 in pairs(iter_36_27.stage) do
								for iter_36_30, iter_36_31 in pairs(var_0_5.trigger_type) do
									if iter_36_31 == iter_36_29 and var_0_7:judge_stage(iter_36_29, self._battlefield._battle_step) then
										self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage * (1 - iter_36_27.num / 100))

										self:set_damage_record("编号" .. arg_36_1:getID() .. ":" .. "非限定船只专属装备阶段伤害减免", var_0_4("减免%f伤害 伤害=%d", iter_36_27.num / 100, self._damage_attr.damage))
									end
								end
							end
						else
							self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage * (1 - iter_36_27.num / 100))

							self:set_damage_record("编号" .. arg_36_1:getID() .. ":" .. "非限定船只专属装备全阶段伤害减免", var_0_4("减免%f伤害 伤害=%d", iter_36_27.num / 100, self._damage_attr.damage))
						end
					end
				end
			end
		end
	end

	function arg_1_0:__set_rank_add_final_damage(arg_37_1, arg_37_2, arg_37_3)
		if self._battle_scene:get_fight_type() == var_0_5.fight_type.strike then
			self:set_damage_record("立体强袭军阶加成不生效", "  ")
		elseif arg_37_1:get_attribute().rank_add_final_damage and arg_37_1:get_attribute().rank_add_final_damage ~= 0 then
			self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage * arg_37_1:get_attribute().rank_add_final_damage)

			self:set_damage_record("命中后军阶伤害增加，如果是技能替换攻击，不会走普通攻击流程了", string.format("倍率为：%s,增幅前伤害为:%s,增幅后伤害为:%s", arg_37_1:get_attribute().rank_add_final_damage, self._damage_attr.damage, self._damage_attr.damage))
		else
			self:set_damage_record("没有军阶加成", "  ")
		end
	end

	function arg_1_0:__damage_protection(arg_38_1, arg_38_2)
		if arg_38_2:get_side() == var_0_5.obj_side.enemy then
			return arg_38_1
		end

		if arg_38_2:is_ignore_damage_protect() then
			return arg_38_1
		end

		local var_38_0 = arg_38_2:get_attribute()
		local var_38_1 = var_38_0.now_hp:get_final_value()

		if arg_38_1 > 0 then
			var_38_0.now_hp:reduction_to_next_value()
		end

		local var_38_2 = var_38_0.now_hp:get_final_value()
		local var_38_3 = var_38_0.hp:get_final_value()

		if var_38_2 == 1 then
			self._damage_attr.is_miss = true
			self._damage_attr.is_crit = false
			self._damage_attr.damage_type = var_0_5.damage_type.miss
			self._damage_attr.damage = 0

			self:set_damage_record("大破保护", "耐久为1时不会受到伤害")

			return self._damage_attr.damage
		end

		if arg_38_2:is_lowhp() and self._damage_attr.damage > 0 then
			self._damage_attr.damage = 1

			var_38_0.now_hp:modify_to_value(var_38_0.now_hp:get_final_value() - 1)
			self:set_damage_record("大破保护", var_0_4("已经大破,伤害固定为1"))

			return self._damage_attr.damage
		end

		if not arg_38_2:is_lowhp() and var_38_2 < var_38_3 then
			if arg_38_1 > var_38_2 - var_38_3 * 0.25 then
				local var_38_4 = var_0_2.ceil(var_38_2 - var_38_3 * 0.25) == 0 and 1 or var_0_2.ceil(var_38_2 - var_38_3 * 0.25)

				var_38_0.now_hp:modify_to_value(var_38_0.now_hp:get_final_value() - var_38_4)
				self:set_damage_record("未大破不满血保护", var_0_4("ceil(当前hp%d-最大hp%d*0.25)=%d", var_38_2, var_38_3, var_38_4))

				self._damage_attr.damage = var_38_4

				if var_38_4 == 0 then
					self._damage_attr.is_miss = true
					self._damage_attr.is_crit = false
				end

				return var_38_4
			end

			var_38_0.now_hp:modify_to_value(var_38_1)

			return arg_38_1
		end

		if var_38_3 <= var_38_2 then
			if arg_38_1 > var_38_3 - var_38_3 * 0.25 then
				local var_38_5 = self._battle_random:randRange(51, 74) / 100
				local var_38_6 = var_0_2.ceil(var_38_3 * var_38_5)

				var_38_0.now_hp:modify_to_value(var_38_0.now_hp:get_final_value() - var_38_6)
				self:set_damage_record("满血伤害保护", var_0_4("ceil(最大hp%d * %.2f)=%d", var_38_3, var_38_5, var_38_6))

				self._damage_attr.damage = var_38_6

				return var_38_6
			end

			var_38_0.now_hp:modify_to_value(var_38_1)

			return arg_38_1
		end

		var_38_0.now_hp:modify_to_value(var_38_1)

		return arg_38_1
	end

	function arg_1_0:set_add_attribute_by_attr_skill(arg_39_1, arg_39_2, arg_39_3)
		if arg_39_1 and arg_39_1:get_attribute().skill_num.change_atk_by_radom_by_attr then
			for iter_39_0, iter_39_1 in pairs(arg_39_1:get_attribute().save_set_attr) do
				local var_39_0 = arg_39_1:get_attribute()[iter_39_1.add_attr_type]
				local var_39_1 = var_39_0:get_final_value()

				var_39_0:modify_to_value(0 + iter_39_1.set_attr_by_num + var_39_0:get_final_value())
				self:set_damage_record("技能生效加入到数值变化,循环多次打印战报：发动攻击时，随机增加num1至num2*自身XX属性值的作为加成值", "生效对应的属性为：" .. var_0_5:get_attr_name_cn(iter_39_1.add_attr_type) .. "," .. "生效数值为：" .. 0 + iter_39_1.set_attr_by_num .. "," .. "给予加成属性为：" .. var_0_5:get_attr_name_cn(iter_39_1.attr_type) .. "," .. "生效前被加成属性值：" .. var_39_1 .. "," .. "生效后为加成值为：" .. 0 + iter_39_1.set_attr_by_num .. "," .. "生效后总值为：" .. var_39_0:get_final_value())
			end
		end
	end

	function arg_1_0:set_final_damage_by_skil(arg_40_1, arg_40_2, arg_40_3)
		self._fix_damage_add = 0

		if not arg_40_1 or not arg_40_2 then
			return
		end

		self:set_damage_record("开始进入攻击被替换成技能方法里，但不会加入到非替换的伤害里面", "判断是否存在额外伤害(source/target中任意一方属性变更)")
		self:set_additional_damage_by_skil(arg_40_1, arg_40_2, arg_40_3)
		self:set_damage_record("结束进入攻击被替换成技能方法里，但不会加入到非替换的伤害里面", "判断是否存在额外伤害(source/target中任意一方属性变更)")

		if arg_40_2:get_attribute().skill_num and arg_40_2:get_attribute().skill_num._is_immune_to_first_damage and arg_40_2:get_attribute().skill_num._is_immune_to_first_damage > 1 then
			local var_40_0 = false

			if arg_40_2:get_attribute().skill_num._is_immune_to_first_damage_stage then
				for iter_40_0, iter_40_1 in pairs(arg_40_2:get_attribute().skill_num._is_immune_to_first_damage_stage) do
					if var_0_7:judge_stage(iter_40_1, self._battlefield._battle_step) then
						var_40_0 = true
					end
				end
			end

			if (arg_40_2:get_attribute()._is_immune_to_first_damage or nil) and true then
				self._damage_attr.is_miss = false
				self._damage_attr.is_immune = true
				self._damage_attr.damage = 0
				self._damage_attr.damage_type = var_0_5.damage_type.normal
				self.skill_replace_hit = true
				self.skill_replace_hit_without_buff = true
				arg_40_2:get_attribute().skill_num._is_immune_to_first_damage = arg_40_2:get_attribute().skill_num._is_immune_to_first_damage - 1

				self:set_damage_record("免疫一次受到的伤害（不论是否命中）")

				if arg_40_1:get_attribute().phase_no_damage_by_phase_attack then
					local var_40_1 = arg_40_1:get_attribute().phase_no_damage_by_phase_attack

					for iter_40_2, iter_40_3 in pairs(var_40_1.action_stage) do
						if var_0_7:judge_stage(iter_40_3, self._battlefield._battle_step) then
							arg_40_1:set_attack_step_again_type(var_40_1.buff_stage[1], var_40_1.add_num)
						end
					end
				end

				return
			end
		end

		self:set_damage_record("进入攻击被替换成技能方法里，但不会加入到非替换的伤害里面", "进行一波固伤加成计算，当前伤害为：" .. self._damage_attr.damage)
		self:set_only_fixed_damage_by_skill(arg_40_1, arg_40_2)
		self:set_damage_record("进入攻击被替换成技能方法里", "计算结束,固伤加成后的伤害为:" .. self._damage_attr.damage)

		self._fix_damage_add = self._fix_damage_add + self._damage_attr.damage

		if arg_40_1:get_attribute().hit_by_hp_percent then
			self:hit_division_half_miss(arg_40_1, arg_40_2)

			if self._damage_attr.is_miss == false then
				local var_40_2 = arg_40_2:get_attribute().now_hp:get_final_value()

				self._damage_attr.damage = var_40_2 * arg_40_1:get_attribute().hit_by_hp_percent.rate
				self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)

				if self._fix_damage_add and self._fix_damage_add ~= 0 then
					self._damage_attr.damage = self._fix_damage_add + self._damage_attr.damage

					self:set_damage_record("固伤技能：攻击XX舰种/大中小型船/主力护卫舰（数组）时，增加XX点固定伤害", "固伤加值为：" .. self._fix_damage_add)
				end

				self._damage_attr.is_crit = false
				self._damage_attr.damage_type = var_0_5.damage_type.normal

				self:__set_rank_add_final_damage(arg_40_1, arg_40_2, false)

				if self._damage_attr.damage > arg_40_1:get_attribute().hit_by_hp_percent.max_damage then
					self._damage_attr.damage = arg_40_1:get_attribute().hit_by_hp_percent.max_damage
				end

				self:set_damage_record("对目标造成目标当前耐久值XX%伤害", "伤害加值为：" .. self._damage_attr.damage)
				self:set_damage_record("", "固伤加值为：" .. self._fix_damage_add)

				local var_40_3 = var_0_2.floor(arg_40_2:get_attribute().now_hp:get_final_value() - self._damage_attr.damage)

				var_40_3 = var_40_3 > 0 and var_40_3 or 0

				arg_40_2:get_attribute().now_hp:modify_to_value(var_40_3)
				self:set_damage_record("触发技能替换攻击：对目标造成目标当前耐久值XX%伤害。", "造成目标当前耐久百分之" .. arg_40_1:get_attribute().hit_by_hp_percent.rate * 100 .. "的伤害," .. "伤害为:" .. var_40_2 * arg_40_1:get_attribute().hit_by_hp_percent.rate .. ",总伤害为" .. self._damage_attr.damage)
			else
				arg_40_2:set_total_miss(1)

				self._damage_attr.damage_type = var_0_5.damage_type.miss
			end

			self.skill_replace_hit = true
		end

		if arg_40_1:get_attribute().hit_target_hp_to_broke then
			self:hit_division_half_miss(arg_40_1, arg_40_2)

			local var_40_4 = arg_40_2:get_attribute().now_hp:get_final_value() - var_0_2.floor(arg_40_2:get_attribute().hp:get_final_value() * arg_40_1:get_attribute().hit_target_hp_to_broke)

			if var_40_4 <= 0 then
				return
			else
				self._damage_attr.is_miss = false
				self._damage_attr.damage = var_40_4
				self._damage_attr.is_crit = false
				self._damage_attr.damage_type = var_0_5.damage_type.normal

				self:__set_rank_add_final_damage(arg_40_1, arg_40_2, false)

				local var_40_5 = var_0_2.floor(arg_40_2:get_attribute().now_hp:get_final_value() - self._damage_attr.damage)

				var_40_5 = var_40_5 > 0 and var_40_5 or 0

				arg_40_2:get_attribute().now_hp:modify_to_value(var_40_5)

				self.skill_replace_hit = true

				self:set_damage_record("触发技能:造成敌方耐久值降低至最大耐久值的XX%（如果目标大破，造成正常伤害）", "将目标打成大破状态，造成：" .. self._damage_attr.damage .. "的伤害")
			end
		end

		if arg_40_2:get_attribute().can_not_hit_or_be_hit then
			self:hit_division_half_miss(arg_40_1, arg_40_2)

			if self._damage_attr.is_miss == false then
				self._damage_attr.damage = 0
				self._damage_attr.is_crit = false
				self._damage_attr.damage_type = var_0_5.damage_type.normal
				self.skill_replace_hit = true
				self.skill_replace_hit_without_buff = true

				self:set_damage_record("触发技能:无法攻击，无法受到伤害", "该目标无法攻击也无法被攻击，造成：0的伤害")

				return
			else
				arg_40_2:set_total_miss(1)

				self._damage_attr.damage_type = var_0_5.damage_type.miss
			end
		end

		if arg_40_1:get_attribute().hit_by_fixed_demage then
			self:hit_division_half_miss(arg_40_1, arg_40_2)

			if self._damage_attr.is_miss == false then
				local var_40_6 = arg_40_1:get_attribute().hit_by_fixed_demage.attribute
				local var_40_7 = var_0_2.ceil(arg_40_1:get_attribute()[var_40_6]:get_final_value() * arg_40_1:get_attribute().hit_by_fixed_demage.rate)
				local var_40_8 = arg_40_2:get_attribute().now_hp:get_final_value()

				if self._fix_damage_add and self._fix_damage_add ~= 0 then
					self._damage_attr.damage = var_40_7 + self._fix_damage_add

					self:set_damage_record("触发攻击被替换技能:对目标造成自身XX属性XX%的固定伤害的值,并且还有额外的固伤加成", "对目标造成自身XX属性XX%的固定伤害：" .. var_40_6 .. "属性的" .. arg_40_1:get_attribute().hit_by_fixed_demage.rate .. ",伤害为:" .. var_40_7 .. ",额外增加的固伤为" .. self._fix_damage_add .. ",总伤害为:" .. self._damage_attr.damage)
				else
					self._damage_attr.damage = var_40_7

					self:set_damage_record("触发攻击被替换技能:对目标造成自身XX属性XX%的固定伤害的值", "对目标造成自身XX属性XX%的固定伤害：" .. var_40_6 .. "属性的" .. arg_40_1:get_attribute().hit_by_fixed_demage.rate .. ",伤害为:" .. var_40_7)
				end

				self:__set_rank_add_final_damage(arg_40_1, arg_40_2, false)
				self:__set_equip_damage_effect(arg_40_1, arg_40_2, true)

				local var_40_9 = var_0_2.floor(var_40_8 - self._damage_attr.damage)

				var_40_9 = var_40_9 > 0 and var_40_9 or 0

				arg_40_2:get_attribute().now_hp:modify_to_value(var_40_9)

				self.skill_replace_hit = true

				self:set_damage_record("对目标造成自身XX属性XX%的固定伤害后续总伤害:", "最终伤害为" .. self._damage_attr.damage)
			else
				arg_40_2:set_total_miss(1)

				self._damage_attr.damage_type = var_0_5.damage_type.miss
			end
		end
	end

	function arg_1_0:set_additional_damage_by_skil(arg_41_1, arg_41_2, arg_41_3)
		if not arg_41_1 or not arg_41_2 then
			return
		end

		if arg_41_1:get_attribute().set_immune_in_atk_by_shiptype then
			local var_41_0
			local var_41_1 = arg_41_1:get_attribute().set_immune_in_atk_by_shiptype.type
			local var_41_2 = arg_41_1:get_attribute().set_immune_in_atk_by_shiptype.effect_stage
			local var_41_3

			if var_41_1 == "shipTypes" then
				var_41_0 = arg_41_2:get_ship_type()
			elseif var_41_1 == "shipTons" then
				var_41_0 = arg_41_2:get_ship_ton()
			elseif var_41_1 == "guardTypes" then
				var_41_0 = arg_41_2:get_ship_guard_type()
			end

			for iter_41_0, iter_41_1 in pairs(arg_41_1:get_attribute().set_immune_in_atk_by_shiptype.type_num) do
				if iter_41_1 == var_41_0 then
					var_41_3 = true
				end
			end

			if var_41_3 then
				for iter_41_2, iter_41_3 in pairs(arg_41_1:get_attribute().set_immune_in_atk_by_shiptype.target_list) do
					iter_41_3:get_attribute().skill_num = iter_41_3:get_attribute().skill_num or {}
					iter_41_3:get_attribute().skill_num._is_immune_to_first_damage = iter_41_3:get_attribute().skill_num._is_immune_to_first_damage or 1
					iter_41_3:get_attribute().skill_num._is_immune_to_first_damage = iter_41_3:get_attribute().skill_num._is_immune_to_first_damage + 1
					iter_41_3:get_attribute().skill_num._is_immune_to_first_damage_stage = var_41_2
				end
			end
		end

		if arg_41_2:get_attribute().add_target_crit_in_be_atk_by_shiptype then
			local var_41_6
			local var_41_7 = arg_41_2:get_attribute().add_target_crit_in_be_atk_by_shiptype.type
			local var_41_8 = arg_41_2:get_attribute().add_target_crit_in_be_atk_by_shiptype.effect_stage
			local var_41_9

			if var_41_7 == "shipTypes" then
				var_41_6 = arg_41_2:get_ship_type()
			elseif var_41_7 == "shipTons" then
				var_41_6 = arg_41_2:get_ship_ton()
			elseif var_41_7 == "guardTypes" then
				var_41_6 = arg_41_2:get_ship_guard_type()
			end

			for iter_41_4, iter_41_5 in pairs(arg_41_2:get_attribute().add_target_crit_in_be_atk_by_shiptype.type_num) do
				if iter_41_5 == var_41_6 then
					var_41_9 = true
				end
			end

			if var_41_9 then
				for iter_41_6, iter_41_7 in pairs(arg_41_2:get_attribute().add_target_crit_in_be_atk_by_shiptype.target_list) do
					iter_41_7:get_attribute().skill_num = iter_41_7:get_attribute().skill_num or {}
					iter_41_7:get_attribute().skill_num.add_crit_hurt = iter_41_7:get_attribute().skill_num.add_crit_hurt or {}
					iter_41_7:get_attribute().skill_num.add_crit_hurt.effect_stage = var_41_8
					iter_41_7:get_attribute().skill_num.add_crit_hurt.num = iter_41_7:get_attribute().skill_num.add_crit_hurt.num or 0
					iter_41_7:get_attribute().skill_num.add_crit_hurt.num = iter_41_7:get_attribute().skill_num.add_crit_hurt.num + arg_41_2:get_attribute().add_target_crit_in_be_atk_by_shiptype.crit_hurt
				end
			end
		end

		if arg_41_1:get_attribute().can_not_shout_by_stage_before_shout then
			arg_41_1:set_is_not_attack_for_type(arg_41_1:get_attribute().can_not_shout_by_stage_before_shout)
			self:set_damage_record("攻击后不参与某阶段", "本次攻击后不参与" .. arg_41_1:get_attribute().can_not_shout_by_stage_before_shout[1] .. "阶段")
		end

		self:__deal_with_target(arg_41_1, arg_41_2)

		arg_41_1:get_attribute().skill_num = arg_41_1:get_attribute().skill_num or {}
		arg_41_2:get_attribute().skill_num = arg_41_2:get_attribute().skill_num or {}

		self:add_passive_attr_by_perence(arg_41_1)
		self:add_passive_attr_by_perence(arg_41_2)

		if arg_41_1:get_attribute().add_attr_by_target_alive then
			local var_41_13 = self._battle_obj_mgr:get_alive_ships_by_side(arg_41_2:get_side())

			for iter_41_8, iter_41_9 in pairs(arg_41_1:get_attribute().add_attr_by_target_alive) do
				if #var_41_13 <= iter_41_9.num then
					iter_41_9.change_value = iter_41_9.attr_num

					arg_41_1:get_attribute()[iter_41_8]:modify_to_value(arg_41_1:get_attribute()[iter_41_8]:get_final_value() + iter_41_9.attr_num)
					self:set_damage_record("攻击时场上目标小于等于X时，增加XX属性Y", "攻击时场上目标小于等于" .. iter_41_9.num .. "时，增加" .. var_0_5:get_attr_name_cn(iter_41_8) .. "属性" .. iter_41_9.attr_num)
				end
			end
		end

		if arg_41_1:get_attribute().add_attr_by_num_bu_lost_hp then
			for iter_41_10, iter_41_11 in pairs(arg_41_1:get_attribute().add_attr_by_num_bu_lost_hp) do
				local var_41_15 = arg_41_2:get_attribute().hp
				local var_41_17 = (iter_41_11.attr_max - iter_41_11.attr_min) * ((var_41_15:get_final_value() - arg_41_2:get_attribute().now_hp:get_final_value()) / arg_41_2:get_attribute().hp:get_final_value())
				local var_41_18 = var_0_2.ceil(iter_41_11.attr_min + var_41_15)

				iter_41_11.change_value = var_41_18

				local var_41_19 = arg_41_1:get_attribute()[iter_41_11.attr_type]:get_final_value() + var_41_18

				arg_41_1:get_attribute()[iter_41_11.attr_type]:modify_to_value(var_41_19)
				self:set_damage_record("攻击时，根据目标损失的耐久值，提高自身xx属性[最少提高X%，最多提高Y%]", var_0_5:get_attr_name_cn(iter_41_11.attr_type) .. "属性变化为" .. var_41_19)
			end
		end

		if arg_41_1:get_attribute().change_attr_by_hp then
			local var_41_20 = arg_41_1:get_attribute().change_attr_by_hp.attr_type
			local var_41_21 = arg_41_1:get_attribute().change_attr_by_hp.attr_num
			local var_41_22 = var_0_2.floor((arg_41_1:get_attribute().hp:get_final_value() - arg_41_1:get_attribute().now_hp:get_final_value()) / (arg_41_1:get_attribute().change_attr_by_hp.num * arg_41_1:get_attribute().hp:get_final_value()))

			if var_41_20 == "crit_repair" then
				var_41_22 = arg_41_1:get_attribute()[var_41_20]:get_final_value() + var_41_21 * var_41_22 * 100
				arg_41_1:get_attribute().change_attr_by_hp.change_value = var_41_21 * var_41_22
			else
				arg_41_1:get_attribute().change_attr_by_hp.change_value = arg_41_1:get_attribute()[var_41_20]:get_final_value() * (var_41_21 * var_41_22)
				var_41_22 = arg_41_1:get_attribute()[var_41_20]:get_final_value() * (1 + var_41_21 * var_41_22)
			end

			local var_41_23 = var_0_2.floor(var_41_22)

			arg_41_1:get_attribute()[var_41_20]:modify_to_value(var_41_23)
			self:set_damage_record("自身每损失X%耐久值，XX属性变化YY%", var_0_5:get_attr_name_cn(var_41_20) .. "属性变化为" .. var_41_23)
		end

		if self._battle_scene:get_add_attr_by_ship_number_data() then
			local var_41_24 = self._battle_scene:get_add_attr_by_ship_number_data()

			for iter_41_12, iter_41_13 in pairs(var_41_24.ship_list) do
				if arg_41_1:getID() == iter_41_13 then
					arg_41_1:get_attribute()[var_41_24.attr_type]:modify_to_value(arg_41_1:get_attribute()[var_41_24.attr_type]:get_final_value() + var_41_24.num)
				end
			end
		end

		if arg_41_1:get_attribute().dec_target_attribute_by_this_atk then
			arg_41_2:get_attribute().skill_num = arg_41_2:get_attribute().skill_num or {}
			arg_41_2:get_attribute().skill_num.change_attr_by_stage = arg_41_2:get_attribute().skill_num.change_attr_by_stage or {}

			for iter_41_14, iter_41_15 in pairs(arg_41_1:get_attribute().dec_target_attribute_by_this_atk) do
				local var_41_26 = true

				for iter_41_16, iter_41_17 in pairs(arg_41_2:get_attribute().skill_num.change_attr_by_stage) do
					if iter_41_17.unique and iter_41_17.unique[1] == iter_41_15.unique[1] and iter_41_17.unique[2] == iter_41_15.unique[2] then
						var_41_26 = false
					end
				end

				if not iter_41_15.unique or iter_41_15.unique[1] == 0 then
					var_41_26 = true
				end

				local var_41_27 = #arg_41_2:get_attribute().skill_num.change_attr_by_stage

				if var_41_26 then
					if iter_41_15.shipTypes then
						if var_0_7:have_data(iter_41_15.shipTypes, arg_41_2:get_ship_type()) then
							arg_41_2:get_attribute().skill_num.change_attr_by_stage[var_41_27 + 1] = {
								attr_type = iter_41_15.attr_type,
								attr_num = iter_41_15.attr_num,
								effect_stage = iter_41_15.effect_stage,
								unique = iter_41_15.unique,
								percent = iter_41_15.percent
							}
						end
					elseif iter_41_15.shipTons and var_0_7:have_data(iter_41_15.shipTons, arg_41_2:get_ship_ton()) then
						arg_41_2:get_attribute().skill_num.change_attr_by_stage[var_41_27 + 1] = {
							attr_type = iter_41_15.attr_type,
							attr_num = iter_41_15.attr_num,
							effect_stage = iter_41_15.effect_stage,
							unique = iter_41_15.unique,
							percent = iter_41_15.percent
						}
					end
				end
			end
		end

		if arg_41_1:get_attribute().skill_num.change_attr_by_stage then
			for iter_41_18, iter_41_19 in pairs(arg_41_1:get_attribute().skill_num.change_attr_by_stage) do
				if self:__get_attr_type_side(iter_41_19.attr_type) == 1 then
					for iter_41_20, iter_41_21 in pairs(iter_41_19.effect_stage) do
						if var_0_7:judge_stage(iter_41_21, self._battlefield._battle_step) then
							if iter_41_19.percent and arg_41_1:get_attribute().skill_num.change_attr_by_stage.attr_type ~= "crit_repair" then
								local var_41_28 = arg_41_1:get_attribute()[iter_41_19.attr_type]

								arg_41_1:get_attribute()[iter_41_19.attr_type]:modify_to_value(var_41_28:get_final_value() + arg_41_1:get_attribute()[iter_41_19.attr_type]:get_final_value() * iter_41_19.attr_num)
								self:set_damage_record("触发技能:自身在对应阶段" .. var_0_5:get_attr_name_cn(iter_41_19.attr_type) .. "属性变更", "在对应阶段" .. var_0_5:get_attr_name_cn(iter_41_19.attr_type) .. "属性变更百分比" .. iter_41_19.attr_num)
							else
								local var_41_31 = iter_41_19.attr_type
								local var_41_32 = iter_41_19.attr_num

								if iter_41_19.attr_type == "crit_repair" then
									var_41_32 = var_41_32 * 100
								end

								arg_41_1:get_attribute()[var_41_31]:modify_to_value(arg_41_1:get_attribute()[var_41_31]:get_final_value() + var_41_32)
								self:set_damage_record("触发技能:自身在对应阶段" .. var_0_5:get_attr_name_cn(var_41_31) .. "属性变更", "在对应阶段" .. var_0_5:get_attr_name_cn(var_41_31) .. "属性变更" .. var_41_32)
							end
						end
					end
				end
			end
		end

		if arg_41_2:get_attribute().skill_num.change_attr_by_stage then
			for iter_41_22, iter_41_23 in pairs(arg_41_2:get_attribute().skill_num.change_attr_by_stage) do
				if self:__get_attr_type_side(iter_41_23.attr_type) == -1 then
					for iter_41_24, iter_41_25 in pairs(iter_41_23.effect_stage) do
						if var_0_7:judge_stage(iter_41_25, self._battlefield._battle_step) then
							if iter_41_23.percent and arg_41_2:get_attribute().skill_num.change_attr_by_stage.attr_type ~= "crit_repair" then
								local var_41_33 = arg_41_2:get_attribute()[iter_41_23.attr_type]

								arg_41_2:get_attribute()[iter_41_23.attr_type]:modify_to_value(var_41_33:get_final_value() + arg_41_2:get_attribute()[iter_41_23.attr_type]:get_final_value() * iter_41_23.attr_num)
								self:set_damage_record("触发技能:敌方在对应阶段" .. var_0_5:get_attr_name_cn(iter_41_23.attr_type) .. "属性变更", "在对应阶段" .. var_0_5:get_attr_name_cn(iter_41_23.attr_type) .. "属性变更百分比" .. iter_41_23.attr_num)
							else
								local var_41_36 = iter_41_23.attr_type
								local var_41_37 = iter_41_23.attr_num

								if iter_41_23.attr_type == "crit_repair" then
									var_41_37 = var_41_37 * 100
								end

								arg_41_2:get_attribute()[var_41_36]:modify_to_value(arg_41_2:get_attribute()[var_41_36]:get_final_value() + var_41_37)
								self:set_damage_record("触发技能:敌方在对应阶段" .. var_0_5:get_attr_name_cn(var_41_36) .. "属性变更", "在对应阶段" .. var_0_5:get_attr_name_cn(var_41_36) .. "属性变更" .. var_41_37)
							end
						end
					end
				end
			end
		end

		if arg_41_1:get_attribute().make_other_demage_by_special_ship_by_num and self:__get_probability_result(arg_41_2, 95) then
			local var_41_38 = arg_41_1:get_attribute().make_other_demage_by_special_ship_by_num.type
			local var_41_40

			if var_41_38 == "shipTypes" then
				var_41_40 = arg_41_2:get_ship_type()
			elseif var_41_38 == "shipTons" then
				var_41_40 = arg_41_2:get_ship_ton()
			elseif var_41_38 == "guardTypes" then
				var_41_40 = arg_41_2:get_ship_guard_type()
			end

			for iter_41_26, iter_41_27 in pairs(arg_41_1:get_attribute().make_other_demage_by_special_ship_by_num.type_num) do
				if iter_41_27 == var_41_40 then
					arg_41_1:get_attribute().make_other_demage_by_num = arg_41_1:get_attribute().make_other_demage_by_special_ship_by_num.num
				end
			end

			self:set_damage_record("触发技能:攻击特定类型船时，增加xx的额外伤害", "增加了攻击特定类型船时的额外基础伤害(基础攻击力)!" .. arg_41_1:get_attribute().make_other_demage_by_special_ship_by_num.num)
		end

		if arg_41_1:get_attribute().make_other_demage_by_num then
			arg_41_1:get_attribute().atk:modify_to_value(arg_41_1:get_attribute().atk:get_final_value() + arg_41_1:get_attribute().make_other_demage_by_num)

			if arg_41_3 == "torpedo_attack" then
				arg_41_1:get_attribute().torpedo:modify_to_value(arg_41_1:get_attribute().torpedo:get_final_value() + arg_41_1:get_attribute().make_other_demage_by_num)
			end

			self:set_damage_record("触发技能:对目标造成额外伤害", "对目标造成额外伤害" .. arg_41_1:get_attribute().make_other_demage_by_num)
		end

		if arg_41_2:get_attribute().skill_num and arg_41_2:get_attribute().skill_num.change_be_crit_rate_by_stage then
			for iter_41_28, iter_41_29 in pairs(arg_41_2:get_attribute().skill_num.change_be_crit_rate_by_stage) do
				local var_41_41 = false

				for iter_41_30, iter_41_31 in pairs(iter_41_29.stage) do
					if var_0_7:judge_stage(iter_41_31, self._battlefield._battle_step) then
						var_41_41 = true
					end
				end

				if var_41_41 then
					arg_41_2:get_attribute().change_be_crit_rate = arg_41_2:get_attribute().change_be_crit_rate or 0
					arg_41_2:get_attribute().change_be_crit_rate = arg_41_2:get_attribute().change_be_crit_rate + iter_41_29.rate
					arg_41_2:get_attribute().change_be_crit_rate_value = arg_41_2:get_attribute().change_be_crit_rate_value or 0
					arg_41_2:get_attribute().change_be_crit_rate_value = arg_41_2:get_attribute().change_be_crit_rate_value + iter_41_29.rate

					self:set_damage_record("被自身攻击的目标被暴击几率改变XX%", "目标xx阶段被暴击几率提高了" .. arg_41_2:get_attribute().change_be_crit_rate_value * 100 .. "%")
				end
			end
		end

		if arg_41_1:get_attribute().change_attr_by_atk_type then
			for iter_41_32, iter_41_33 in pairs(arg_41_1:get_attribute().change_attr_by_atk_type) do
				local var_41_44
				local var_41_45 = iter_41_33.attr_type

				for iter_41_34, iter_41_35 in pairs(iter_41_33.atktype) do
					if arg_41_1:get_atk_type() == iter_41_35 then
						var_41_44 = true
					end
				end

				if var_41_44 == true then
					local var_41_46

					if iter_41_33.percent then
						var_41_46 = arg_41_1:get_attribute()[var_41_45]:get_final_value() + var_0_2.ceil(arg_41_1:get_attribute()[var_41_45]:get_final_value() * iter_41_33.attr_num)
						iter_41_33.change_value = iter_41_33.change_value or {}
						iter_41_33.change_value[var_41_45] = var_0_2.ceil(arg_41_1:get_attribute()[var_41_45]:get_final_value() * iter_41_33.attr_num)

						arg_41_1:get_attribute()[var_41_45]:modify_to_value(var_41_46)
					else
						var_41_46 = arg_41_1:get_attribute()[var_41_45]:get_final_value() + iter_41_33.attr_num
						iter_41_33.change_value = iter_41_33.change_value or {}
						iter_41_33.change_value[var_41_45] = iter_41_33.attr_num

						arg_41_1:get_attribute()[var_41_45]:modify_to_value(var_41_46)
					end

					self:set_damage_record("触发技能:发动XX类型攻击时，自身XX属性变化XX%", "发动XX类型攻击时，自身XX属性变化XX%：" .. var_0_5:get_attr_name_cn(var_41_45) .. "属性变化了" .. iter_41_33.change_value[var_41_45] .. "为" .. var_41_46)
				end
			end
		end

		if arg_41_2:get_attribute().change_attr_by_be_atk_type and var_0_3(arg_41_2:get_attribute().change_attr_by_be_atk_type) then
			for iter_41_36, iter_41_37 in pairs(arg_41_2:get_attribute().change_attr_by_be_atk_type) do
				local var_41_48
				local var_41_49 = iter_41_37.attr_type

				for iter_41_38, iter_41_39 in pairs(iter_41_37.atktype) do
					if arg_41_1:get_atk_type() == iter_41_39 then
						var_41_48 = true
					end
				end

				if var_41_48 == true then
					local var_41_50

					if iter_41_37.percent then
						var_41_50 = arg_41_2:get_attribute()[var_41_49]:get_final_value() + arg_41_2:get_attribute()[var_41_49]:get_final_value() * iter_41_37.attr_num

						arg_41_2:get_attribute()[var_41_49]:modify_to_value(var_41_50)
					else
						var_41_50 = iter_41_37.attr_num + arg_41_2:get_attribute()[var_41_49]:get_final_value()

						arg_41_2:get_attribute()[var_41_49]:modify_to_value(var_41_50)
					end

					self:set_damage_record("触发技能:被XX类型攻击时，自身XX属性变化XX%", "被XX类型攻击时，自身XX属性变化XX%：" .. var_0_5:get_attr_name_cn(var_41_49) .. "属性变化了" .. var_41_50)
				end
			end
		end

		if arg_41_1:get_attribute().skill_num.change_atk_by_radom_by_attr then
			local var_41_52 = arg_41_1:get_attribute().skill_num.change_atk_by_radom_by_attr

			arg_41_1:get_attribute().set_attr_by_num = arg_41_1:get_attribute().set_attr_by_num or 0
			arg_41_1:get_attribute().set_attr_by_use_attr = var_41_52.add_attr_type
			arg_41_1:get_attribute().save_set_attr = arg_41_1:get_attribute().save_set_attr or {}

			local var_41_53 = {}

			for iter_41_40, iter_41_41 in pairs(var_41_52) do
				local var_41_54 = arg_41_1:get_attribute()[iter_41_41.add_attr_type]:get_final_value()
				local var_41_55 = self._battle_random:randomRangeDouble(iter_41_41.num1, iter_41_41.num2) * arg_41_1:get_attribute()[iter_41_41.attr_type]:get_final_value()

				table.insert(var_41_53, {
					set_attr_by_num = var_41_55,
					attr_type = iter_41_41.attr_type,
					add_attr_type = iter_41_41.add_attr_type,
					cid = arg_41_1:get_cid(),
					ship_name = arg_41_1:get_ship_name(),
					type = arg_41_3,
					old_attr = var_41_54
				})
				self:set_damage_record("遍历多次触发叠加的技能:发动攻击时，随机增加num1至num2*自身XX属性值的作为加成值", "发动攻击时，随机增加" .. iter_41_41.num1 .. "至" .. iter_41_41.num2 .. "*自身" .. var_0_5:get_attr_name_cn(iter_41_41.attr_type) .. "属性值的基础" .. var_0_5:get_attr_name_cn(iter_41_41.add_attr_type) .. "值为:" .. var_41_55 .. "," .. "加持前对应属性值为:" .. var_41_54)
			end

			arg_41_1:get_attribute().save_set_attr = var_41_53
		end

		if arg_41_2:get_attribute().change_attr_by_radom_by_attr then
			for iter_41_42, iter_41_43 in pairs(arg_41_2:get_attribute().change_attr_by_radom_by_attr) do
				local var_41_56 = self._battle_random:randomRangeDouble(iter_41_43.num1, iter_41_43.num2)
				local var_41_57 = arg_41_2:get_attribute()[iter_41_43.attr_type1]
				local var_41_58 = arg_41_2:get_attribute()[iter_41_43.attr_type2]
				local var_41_59 = var_0_2.ceil(var_41_56 * var_41_57:get_final_value()) + var_41_58:get_final_value()

				iter_41_43.change_value = var_0_2.ceil(var_41_56 * arg_41_2:get_attribute()[iter_41_43.attr_type1].get_final_value(var_41_58))

				local var_41_60 = arg_41_2:get_attribute()[iter_41_43.attr_type2]:get_final_value()

				arg_41_2:get_attribute()[iter_41_43.attr_type2]:modify_to_value(var_41_59)

				if arg_41_2:get_attribute()[iter_41_43.attr_type2]:get_final_value() < 0 then
					arg_41_2:get_attribute()[iter_41_43.attr_type2]:modify_to_value(0)
				end

				self:set_damage_record("受到攻击时，随机增加num1至num2*自身XX属性值的YY属性", "受到攻击时，随机增加" .. iter_41_43.num1 .. "至" .. iter_41_43.num2 .. "*自身" .. var_0_5:get_attr_name_cn(iter_41_43.attr_type1) .. "属性值的" .. var_0_5:get_attr_name_cn(iter_41_43.attr_type2) .. "属性，变化为" .. var_41_59)
			end
		end

		if self._is_beat_back then
			local var_41_61 = arg_41_1:get_back_hit_to_random_target_by_attr()

			if var_41_61 and var_0_3(var_41_61) then
				arg_41_1:get_attribute().atk:modify_to_value(arg_41_1:get_attribute()[var_41_61.attr_type]:get_final_value() * var_41_61.rate)
				self:set_damage_record("触发技能:反击：对随机1个目标造成XX%属性的伤害", "反击（只有在炮击阶段）")
			end
		end
	end

	function arg_1_0:__deal_with_target(arg_42_1, arg_42_2)
		if arg_42_2 then
			local var_42_0 = arg_42_1:get_special_type_ship_add_attr()
			local var_42_1 = arg_42_1:get_add_attr_contrast_target()
			local var_42_2 = arg_42_1:get_special_tons_ship_add_attr()
			local var_42_3 = arg_42_1:get_special_guard_ship_add_attr()

			if var_42_0 and var_0_3(var_42_0) and not arg_42_1:judge_use_skill_add_attr(var_0_5.skill_add_attr_type.special_type_ship_add_attr) then
				for iter_42_0, iter_42_1 in pairs(var_42_0.shipTypes) do
					if arg_42_2:get_ship_type() == iter_42_1 then
						local var_42_4 = arg_42_1:get_attribute()[var_42_0.attr_type]:get_final_value()

						if var_42_0.percent and var_42_0.attr_type ~= "crit_repair" and var_42_0.attr_type ~= "miss_repair" and var_42_0.attr_type ~= "hit_repair" then
							arg_42_1:get_attribute()[var_42_0.attr_type]:modify_to_value(var_42_4 * (1 + var_42_0.value))
							self._battlefield:append_result(arg_42_1._cid, "触发技能效果:百分比", (var_0_4("攻击XX舰种时，%s属性+%s点,之前是%s，之后是%s。", var_42_0.attr_type, var_42_0.value, var_42_4, arg_42_1:get_attribute()[var_42_0.attr_type]:get_final_value())))
						else
							if var_42_0.attr_type == "crit_repair" then
								var_42_0.value = var_42_0.value * 100
							end

							if var_42_0.attr_type == "miss_repair" then
								-- block empty
							end

							if var_42_0.attr_type == "hit_repair" then
								-- block empty
							end

							var_0_7:modify_attr_value(arg_42_1, var_42_0.attr_type, var_42_0.value)
							self._battlefield:append_result(arg_42_1._cid, "触发技能效果：固定值", (var_0_4("攻击XX舰种时，%s属性+%s点,之前是%s，之后是%s。", var_42_0.attr_type, var_42_0.value, var_42_4, arg_42_1:get_attribute()[var_42_0.attr_type]:get_final_value())))
						end

						arg_42_1:set_use_skill_add_attr(var_0_5.skill_add_attr_type.special_type_ship_add_attr)
					end
				end
			end

			if self:__get_probability_result(arg_42_1, 102) or self:__get_probability_result(arg_42_1, 129) then
				self:__being_attacked_add_an_attribute(arg_42_1, arg_42_2, (arg_42_1:get_special_type_ship_target_add_attr()))
				self:__being_attacked_add_an_attribute(arg_42_1, arg_42_2, (arg_42_1:get_special_tons_ship_target_add_attr()))
				self:__being_attacked_add_an_attribute(arg_42_1, arg_42_2, (arg_42_1:get_special_guard_ship_target_add_attr()))
			end

			if var_42_2 and var_0_3(var_42_2) and not arg_42_1:judge_use_skill_add_attr(var_0_5.skill_add_attr_type.special_tons_ship_add_attr) then
				for iter_42_2, iter_42_3 in pairs(var_42_2.shipTons) do
					if arg_42_2:get_ship_ton() == iter_42_3 then
						var_0_7:modify_attr_value(arg_42_1, var_42_2.attr_type, var_42_2.value)
						arg_42_1:set_use_skill_add_attr(var_0_5.skill_add_attr_type.special_tons_ship_add_attr)
					end
				end
			end

			if var_42_3 and var_0_3(var_42_3) and not arg_42_1:judge_use_skill_add_attr(var_0_5.skill_add_attr_type.special_guard_ship_add_attr) then
				for iter_42_4, iter_42_5 in pairs(var_42_3.guardTypes) do
					if arg_42_2:get_ship_guard_type() == iter_42_5 then
						var_0_7:modify_attr_value(arg_42_1, var_42_3.attr_type, var_42_3.value)
						arg_42_1:set_use_skill_add_attr(var_0_5.skill_add_attr_type.special_guard_ship_add_attr)
					end
				end
			end

			if var_0_3(var_42_1) and not arg_42_1:judge_use_skill_add_attr(var_0_5.skill_add_attr_type.add_attr_contrast_target_data) then
				local var_42_5 = arg_42_1:get_attribute()

				if arg_42_2:get_attribute()[var_0_5.skil_attribute_type[var_42_1.index]]:get_final_value() <= var_42_5[var_0_5.skil_attribute_type[var_42_1.index]]:get_final_value() then
					if var_42_1.percent and var_42_1.type ~= "crit_repair" then
						var_42_5[var_42_1.type]:modify_to_value(var_42_5[var_42_1.type]:get_final_value() * (1 + var_42_1.value))
						self:set_damage_record("触发技能:攻击xx属性低于等于自已的目标时，xx属性+xx点", "攻击" .. var_0_5.skil_attribute_type[var_42_1.index] .. "属性小于等于自已的目标时,add_" .. var_42_1.type .. "属性变化百分比" .. var_42_1.value)
					else
						if var_42_1.type == "crit_repair" then
							var_42_1.value = var_42_1.value * 100
						end

						var_0_7:modify_attr_value(arg_42_1, var_42_1.type, var_42_1.value)
						self:set_damage_record("触发技能:攻击xx属性低于等于自已的目标时，xx属性+xx点", "攻击" .. var_0_5.skil_attribute_type[var_42_1.index] .. "属性小于等于自已的目标时," .. var_42_1.type .. "属性改变" .. var_42_1.value)
					end

					arg_42_1:set_use_skill_add_attr(var_0_5.skill_add_attr_type.add_attr_contrast_target_data)
				end
			end

			local var_42_6

			if arg_42_2 then
				var_42_6 = arg_42_2:get_add_attr_with_attr()
			end

			if var_0_3(var_42_6) and not arg_42_2:judge_use_skill_add_attr(var_0_5.skill_add_attr_type.add_attr_with_attr) then
				local var_42_7 = arg_42_2:get_attribute()

				if var_42_7[var_0_5.skil_attribute_type[var_42_6.index]]:get_final_value() <= arg_42_1:get_attribute()[var_0_5.skil_attribute_type[var_42_6.index]]:get_final_value() then
					if var_42_6.percent and var_42_6.type ~= "crit_repair" then
						var_42_7[var_42_6.type]:modify_to_value(var_42_7[var_42_6.type]:get_final_value() * (1 + var_42_6.value))
						self:set_damage_record("触发技能:攻击xx属性高于等于自已的目标时，xx属性+xx点", "攻击" .. var_0_5.skil_attribute_type[var_42_6.index] .. "属性小于等于自已的目标时," .. var_42_6.type .. "属性化百分比" .. var_42_6.value)
					else
						var_0_7:modify_attr_value(arg_42_2, var_42_6.type, var_42_6.value)
						self:set_damage_record("触发技能:攻击xx属性高于等于自已的目标时，xx属性+xx点", "攻击" .. var_0_5.skil_attribute_type[var_42_6.index] .. "属性小于等于自已的目标时," .. var_42_6.type .. "属性改变" .. var_42_6.value)
					end

					arg_42_2:set_use_skill_add_attr(var_0_5.skill_add_attr_type.add_attr_with_attr)
				end
			end

			local var_42_8 = arg_42_2:get_add_attr_with_attacked_1()

			if var_0_3(var_42_8) and not arg_42_2:judge_use_skill_add_attr(var_0_5.skill_add_attr_type.add_attr_of_attacked_data_1) then
				local var_42_9 = arg_42_1:get_atk_type()

				if var_42_9 == var_42_8.atkType then
					var_0_7:modify_attr_value(arg_42_2, var_42_8.type, var_42_8.value)
					arg_42_2:set_use_skill_add_attr(var_0_5.skill_add_attr_type.add_attr_of_attacked_data_1)
					self:set_damage_record("触发技能:被xx攻击时,XX属性提高xx点", "被" .. var_42_9 .. "攻击时," .. var_42_8.type .. "*属性提高" .. var_42_8.value .. "点")
				end
			end

			local var_42_10 = arg_42_2:get_add_attr_with_attacked_2()

			if var_0_3(var_42_10) and not arg_42_2:judge_use_skill_add_attr(var_0_5.skill_add_attr_type.add_attr_of_attacked_data_2) then
				local var_42_11 = false

				for iter_42_6, iter_42_7 in pairs(var_42_10.shipTypes) do
					if arg_42_1._ship_type == iter_42_7 then
						var_42_11 = true

						break
					end
				end

				if var_42_11 then
					var_0_7:modify_attr_value(arg_42_2, var_42_10.type, var_42_10.value)
					arg_42_2:set_use_skill_add_attr(var_0_5.skill_add_attr_type.add_attr_of_attacked_data_2)
				end
			end

			local var_42_12 = arg_42_2:get_add_attr_with_attacked_3()

			if var_0_3(var_42_12) and not arg_42_2:judge_use_skill_add_attr(var_0_5.skill_add_attr_type.add_attr_of_attacked_data_3) then
				local var_42_13 = false

				for iter_42_8, iter_42_9 in pairs(var_42_12.shipTons) do
					if arg_42_1._ship_ton == iter_42_9 then
						var_42_13 = true

						break
					end
				end

				if var_42_13 then
					var_0_7:modify_attr_value(arg_42_2, var_42_12.type, var_42_12.value)
					arg_42_2:set_use_skill_add_attr(var_0_5.skill_add_attr_type.add_attr_of_attacked_data_3)
				end
			end
		end
	end

	function arg_1_0:__being_attacked_add_an_attribute(arg_43_1, arg_43_2, arg_43_3)
		local var_43_0

		if not arg_43_3 or not var_0_3(arg_43_3) then
			return
		end

		local var_43_1
		local var_43_2

		if arg_43_3.shipTypes then
			var_43_1 = arg_43_2:get_ship_type()
			var_43_2 = arg_43_3.shipTypes
			var_43_0 = var_0_5.skill_add_attr_type.special_type_ship_target_add_attr
		elseif arg_43_3.shipTons then
			var_43_1 = arg_43_2:get_ship_ton()
			var_43_2 = arg_43_3.shipTons
			var_43_0 = var_0_5.skill_add_attr_type.special_tons_ship_target_add_attr
		elseif arg_43_3.guardTypes then
			var_43_1 = arg_43_2:get_ship_guard_type()
			var_43_2 = arg_43_3.guardTypes
			var_43_0 = var_0_5.skill_add_attr_type.special_guard_ship_target_add_attr
		end

		if not var_43_1 then
			return
		end

		if arg_43_1:judge_use_skill_add_attr(var_43_0) then
			return
		end

		for iter_43_0, iter_43_1 in pairs(var_43_2) do
			if var_43_1 == iter_43_1 then
				local var_43_3 = arg_43_2:get_attribute()[arg_43_3.attr_type]:get_final_value()

				if arg_43_3.percent and arg_43_3.attr_type ~= "crit_repair" then
					arg_43_2:get_attribute()[arg_43_3.attr_type]:modify_to_value(var_43_3 * (1 + arg_43_3.value))

					arg_43_2:get_attribute().special_target_add_attr_before_attr_value = var_43_3

					self._battlefield:append_result(arg_43_2._cid, "触发技能效果:百分比", (var_0_4("攻击XX舰种时，%s属性+%s点,之前是%s，之后是%s。", arg_43_3.attr_type, arg_43_3.value, var_43_3, arg_43_2:get_attribute()[arg_43_3.attr_type]:get_final_value())))
				else
					if arg_43_3.attr_type == "crit_repair" then
						arg_43_3.value = arg_43_3.value * 100
					end

					var_0_7:modify_attr_value(arg_43_2, arg_43_3.attr_type, arg_43_3.value)
					self._battlefield:append_result(arg_43_2._cid, "触发技能效果：固定值", (var_0_4("攻击XX舰种时，对方%s属性+%s点,之前是%s，之后是%s。", arg_43_3.attr_type, arg_43_3.value, var_43_3, arg_43_2:get_attribute()[arg_43_3.attr_type]:get_final_value())))
				end

				arg_43_1:set_use_skill_add_attr(var_43_0)
			end
		end
	end

	function arg_1_0:set_fixed_damage_by_skil(arg_44_1, arg_44_2, arg_44_3)
		if not arg_44_1 or not arg_44_2 then
			return
		end

		if arg_44_2:get_attribute().in_guardian then
			self._damage_attr.is_miss = false
		end

		local var_44_0 = self._damage_attr.damage > 0
		local var_44_1 = false

		if arg_44_1:get_attribute().dec_target_attribute and (self:__get_probability_result(arg_44_1, 14) or self:__get_probability_result(arg_44_1, 15)) then
			arg_44_2:get_attribute().skill_num = arg_44_2:get_attribute().skill_num or {}
			arg_44_2:get_attribute().skill_num.change_attr_by_stage = arg_44_2:get_attribute().skill_num.change_attr_by_stage or {}

			for iter_44_0, iter_44_1 in pairs(arg_44_1:get_attribute().dec_target_attribute) do
				local var_44_4 = true

				for iter_44_2, iter_44_3 in pairs(arg_44_2:get_attribute().skill_num.change_attr_by_stage) do
					if iter_44_3.unique and iter_44_3.unique[1] == iter_44_1.unique[1] and iter_44_3.unique[2] == iter_44_1.unique[2] then
						var_44_4 = false
					end
				end

				if not iter_44_1.unique or iter_44_1.unique[1] == 0 then
					var_44_4 = true
				end

				local var_44_5 = #arg_44_2:get_attribute().skill_num.change_attr_by_stage

				if var_44_4 then
					if iter_44_1.shipTypes then
						if var_0_7:have_data(iter_44_1.shipTypes, arg_44_2:get_ship_type()) then
							arg_44_2:get_attribute().skill_num.change_attr_by_stage[var_44_5 + 1] = {
								attr_type = iter_44_1.attr_type,
								attr_num = iter_44_1.attr_num,
								effect_stage = iter_44_1.effect_stage,
								unique = iter_44_1.unique,
								percent = iter_44_1.percent
							}
						end
					elseif iter_44_1.shipTons and var_0_7:have_data(iter_44_1.shipTons, arg_44_2:get_ship_ton()) then
						arg_44_2:get_attribute().skill_num.change_attr_by_stage[var_44_5 + 1] = {
							attr_type = iter_44_1.attr_type,
							attr_num = iter_44_1.attr_num,
							effect_stage = iter_44_1.effect_stage,
							unique = iter_44_1.unique,
							percent = iter_44_1.percent
						}
					end
				end
			end
		end

		if self._damage_attr.is_miss or self._damage_attr.is_recover_life then
			if arg_44_1:get_attribute().phase_no_damage_by_phase_attack then
				local var_44_6 = arg_44_1:get_attribute().phase_no_damage_by_phase_attack

				for iter_44_4, iter_44_5 in pairs(var_44_6.action_stage) do
					if var_0_7:judge_stage(iter_44_5, self._battlefield._battle_step) then
						arg_44_1:set_attack_step_again_type(var_44_6.buff_stage[1], var_44_6.add_num)
					end
				end
			end

			return
		end

		arg_44_2:get_attribute().be_hit = true
		arg_44_1:get_attribute().change_final_damage = arg_44_1:get_attribute().change_final_damage or 0
		arg_44_2:get_attribute().change_final_be_damage = arg_44_2:get_attribute().change_final_be_damage or 0
		arg_44_1:get_attribute().change_final_damage_by_num = arg_44_1:get_attribute().change_final_damage_by_num or 0

		if arg_44_1:get_attribute().change_damage_by_is_flag_with_num and arg_44_2:is_flag() then
			arg_44_1:get_attribute().change_final_damage_by_num = arg_44_1:get_attribute().change_damage_by_is_flag_with_num + arg_44_1:get_attribute().change_final_damage_by_num

			self:set_damage_record("触发技能:攻击旗舰时，造成的伤害改变XX", "攻击旗舰时，造成的伤害改变数值" .. arg_44_1:get_attribute().change_damage_by_is_flag_with_num .. "最终伤害为" .. self._damage_attr.damage)
		end

		if self:__get_probability_result(arg_44_1, 12) and arg_44_1:get_attribute().hit_by_other_demage then
			local var_44_7 = arg_44_2:get_attribute().now_hp:get_final_value()
			local var_44_8 = var_0_2.floor(((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage)

			var_44_8 = var_44_8 > 0 and var_44_8 or 0

			arg_44_2:get_attribute().now_hp:modify_to_value(var_44_8)
			self:set_damage_record("触发技能:对目标造成目标XX属性XX%的额外伤害，只看hp结算，不涉及伤害变化", "检测增加伤害后的伤害" .. self._damage_attr.damage)
		end

		if arg_44_1:get_attribute().add_fix_damage_by_index and arg_44_2:get_index() == arg_44_1:get_index() then
			local var_44_9 = arg_44_2:get_attribute().now_hp:get_final_value()
			local var_44_10 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage

			var_44_10 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage > 0 and var_44_10 or 0

			arg_44_2:get_attribute().now_hp:modify_to_value(var_44_10)
			self:set_damage_record("对相同位置目标单位，增加XX点固定伤害后续hp结算", "检测增加固定伤害后的伤害" .. self._damage_attr.damage)
		end

		if arg_44_1:get_attribute().hit_by_fixed_demage_attr_by_percent then
			local var_44_11 = arg_44_2:get_attribute().now_hp:get_final_value()
			local var_44_12 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage

			var_44_12 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage > 0 and var_44_12 or 0

			if arg_44_2:get_attribute().in_guardian and arg_44_2:get_attribute().in_guardian == true then
				var_44_1 = true
				var_44_12 = arg_44_2:get_attribute().now_hp:reduction_to_next_value()
			end

			arg_44_2:get_attribute().now_hp:modify_to_value(var_44_12)
			self:set_damage_record("触发技能累加后续:检测属性百分比的额外固定伤害是否和上面的计算一致的后续hp结算", "当前伤害和属性加成的额外固定伤害加成后的总伤害" .. self._damage_attr.damage)
		end

		if arg_44_1:get_attribute().hit_by_fixed_demage_by_ship_type then
			for iter_44_6, iter_44_7 in pairs(arg_44_1:get_attribute().hit_by_fixed_demage_by_ship_type) do
				local var_44_13

				if iter_44_7.data_type == "shipTypes" then
					var_44_13 = arg_44_2:get_ship_type()
				elseif iter_44_7.data_type == "shipTons" then
					var_44_13 = arg_44_2:get_ship_ton()
				elseif iter_44_7.data_type == "guardTypes" then
					var_44_13 = arg_44_2:get_ship_guard_type()
				end

				for iter_44_8, iter_44_9 in pairs(iter_44_7.data_num or {}) do
					if var_44_13 == iter_44_9 then
						local var_44_14 = arg_44_2:get_attribute().now_hp:get_final_value()
						local var_44_15 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage

						var_44_15 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage > 0 and var_44_15 or 0

						arg_44_2:get_attribute().now_hp:modify_to_value(var_44_15)
						self:set_damage_record("触发增加额外伤害技能:攻击XX舰种/大中小型船/主力护卫舰（数组）时，增加XX点固定伤害", "增加XX点固定伤害的后续hp变化阶段:" .. self._fix_damage_add .. ",加入固伤后的总伤害为:" .. self._damage_attr.damage)
					end
				end
			end
		end

		if arg_44_1:get_attribute().change_final_damage_by_num ~= 0 then
			self._damage_attr.damage = self._damage_attr.damage + var_0_2.ceil(arg_44_1:get_attribute().change_final_damage_by_num)
			self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)

			local var_44_16 = arg_44_2:get_attribute().now_hp:get_final_value()
			local var_44_17 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage

			var_44_17 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage > 0 and var_44_17 or 0

			arg_44_2:get_attribute().now_hp:modify_to_value(var_44_17)

			if arg_44_1:get_attribute().change_final_damage_by_num ~= 0 then
				self:set_damage_record("触发技能:造成的最终伤害改变XX", "（总结，可能多个技能叠加）造成的最终伤害改变数值" .. arg_44_1:get_attribute().change_final_damage_by_num .. "最终伤害为" .. self._damage_attr.damage)
			end
		end

		if arg_44_2:get_attribute().change_be_damage_by_num then
			self._damage_attr.damage = self._damage_attr.damage + var_0_2.ceil(arg_44_2:get_attribute().change_be_damage_by_num)
			self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)

			if self._damage_attr.damage < 0 then
				self._damage_attr.damage = 0
			end

			local var_44_18 = arg_44_2:get_attribute().now_hp:get_final_value()
			local var_44_19 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage

			var_44_19 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage > 0 and var_44_19 or 0

			arg_44_2:get_attribute().now_hp:modify_to_value(var_44_19)

			if arg_44_2:get_attribute().change_be_damage_by_num ~= 0 then
				self:set_damage_record("触发技能:被造成的最终伤害改变XX", "（总结，可能多个技能叠加）被造成的最终伤害改变数值" .. arg_44_2:get_attribute().change_be_damage_by_num)
			end
		end

		if (arg_44_1:get_attribute().hit_complex_target or arg_44_1:get_attribute().hit_adjacent_complex_target or arg_44_1:get_attribute()._attack_cause_damage or arg_44_1:get_attribute().couple_attack_by_shipcid) and arg_44_3 then
			self._damage_attr.damage = self._damage_attr.damage * arg_44_3
			self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)

			local var_44_20 = arg_44_2:get_attribute().now_hp:get_final_value()
			local var_44_21 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage

			var_44_21 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage > 0 and var_44_21 or 0

			arg_44_2:get_attribute().now_hp:modify_to_value(var_44_21)
			self:set_damage_record("触发技能:每发炮弹都拥有一个伤害系数hurt_rate", "多重攻击,本次伤害系数为" .. arg_44_3 .. ",加成后伤害为" .. self._damage_attr.damage)

			if arg_44_1:get_attribute().save_set_attr and var_0_3(arg_44_1:get_attribute().save_set_attr) then
				for iter_44_10, iter_44_11 in pairs(arg_44_1:get_attribute().save_set_attr) do
					local var_44_22 = arg_44_1:get_attribute()[iter_44_11.add_attr_type]
					local var_44_23 = var_44_22:get_final_value()

					var_44_22:modify_to_value(var_44_23 - iter_44_11.set_attr_by_num)
					self:set_damage_record("还原多次攻击后的火力：", "还原属性" .. var_0_5:get_attr_name_cn(iter_44_11.add_attr_type) .. "," .. "加成前数据：" .. var_44_23 .. "," .. "还原后数据：" .. var_44_22:get_final_value())
				end
			end
		end

		if arg_44_2:get_attribute().dec_hit_by_type then
			if not arg_44_2:get_is_alive() then
				return
			end

			if self:__get_probability_result(arg_44_2, 19) then
				local var_44_24 = arg_44_2:get_attribute().dec_hit_by_type.hurt_rate
				local var_44_25

				for iter_44_12, iter_44_13 in pairs(arg_44_2:get_attribute().dec_hit_by_type.atkType) do
					if arg_44_1:get_atk_type() == iter_44_13 then
						var_44_25 = true
					end
				end

				if var_44_25 then
					local var_44_26 = arg_44_2:get_attribute().now_hp:get_final_value()

					if var_44_0 then
						var_44_26 = arg_44_2:get_attribute().now_hp:reduction_to_next_value()
					end

					self._damage_attr.damage = self._damage_attr.damage * (1 - var_44_24)
					self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)

					local var_44_27 = var_0_2.ceil(var_44_26 - self._damage_attr.damage)

					var_44_27 = var_44_27 > 0 and var_44_27 or 0

					arg_44_2:get_attribute().now_hp:modify_to_value(var_44_27)
					self:set_damage_record("触发技能:降低XX%受到的XX攻击的伤害", "降低XX%受到的XX攻击的伤害:降低了" .. var_44_24)
				end
			end
		end

		if arg_44_1:get_attribute().double_hit then
			local var_44_28 = 0

			for iter_44_14, iter_44_15 in pairs(arg_44_1:get_attribute().double_hit.hurt_rates) do
				var_44_28 = var_44_28 + iter_44_15
			end

			self._damage_attr.damage = self._damage_attr.damage * var_44_28
			self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)

			local var_44_29 = arg_44_2:get_attribute().now_hp:get_final_value()
			local var_44_30 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage

			var_44_30 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage > 0 and var_44_30 or 0

			arg_44_2:get_attribute().now_hp:modify_to_value(var_44_30)

			self._damage_attr.is_double = true

			self:set_damage_record("触发技能:攻击两次", "攻击两次,每次" .. arg_44_1:get_attribute().double_hit.hurt_rates[1] .. "最终伤害为" .. self._damage_attr.damage)
		end

		if arg_44_1:get_attribute().double_hit_by_crit and self._damage_attr.is_crit then
			local var_44_31 = 0

			for iter_44_16, iter_44_17 in pairs(arg_44_1:get_attribute().double_hit_by_crit.hurt_rates) do
				var_44_31 = var_44_31 + iter_44_17
			end

			self._damage_attr.damage = self._damage_attr.damage * var_44_31
			self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)

			local var_44_32 = arg_44_2:get_attribute().now_hp:get_final_value()
			local var_44_33 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage

			var_44_33 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage > 0 and var_44_33 or 0

			arg_44_2:get_attribute().now_hp:modify_to_value(var_44_33)

			self._damage_attr.is_double = true

			self:set_damage_record("触发技能:暴击时攻击两次", "攻击两次,每次" .. arg_44_1:get_attribute().double_hit_by_crit.hurt_rates[1] .. "最终伤害为" .. self._damage_attr.damage)
		end

		if arg_44_1:get_attribute().change_damage_less_than_attr then
			local var_44_34 = arg_44_1:get_attribute().change_damage_less_than_attr.attr_type

			if arg_44_1:get_attribute()[var_44_34]:get_final_value() > arg_44_2:get_attribute()[var_44_34]:get_final_value() then
				self._damage_attr.damage = self._damage_attr.damage * (1 + arg_44_1:get_attribute().change_damage_less_than_attr.hurt_rate)
				self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)

				local var_44_35 = arg_44_2:get_attribute().now_hp:get_final_value()
				local var_44_36 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage

				var_44_36 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage > 0 and var_44_36 or 0

				arg_44_2:get_attribute().now_hp:modify_to_value(var_44_36)
				self:set_damage_record("触发技能:攻击XX属性低于自身的目标，最终伤害改变XX%", var_0_4("攻击%s属性低于自身的目标，最终伤害改变%.2f%%，最终伤害为%d", var_0_5:get_attr_name_cn(var_44_34), arg_44_1:get_attribute().change_damage_less_than_attr.hurt_rate * 100, self._damage_attr.damage))
			end
		end

		if arg_44_1:get_attribute().change_damage_greater_than_num then
			local var_44_37 = arg_44_1:get_attribute().change_damage_greater_than_num.attr_type
			local var_44_38 = arg_44_1:get_attribute().change_damage_greater_than_num.attr_num

			if var_44_38 < arg_44_2:get_attribute()[var_44_37]:get_final_value() then
				self._damage_attr.damage = self._damage_attr.damage * (1 + arg_44_1:get_attribute().change_damage_greater_than_num.hurt_rate)
				self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)

				local var_44_39 = arg_44_2:get_attribute().now_hp:get_final_value()
				local var_44_40 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage

				var_44_40 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage > 0 and var_44_40 or 0

				arg_44_2:get_attribute().now_hp:modify_to_value(var_44_40)
				self:set_damage_record("触发技能:攻击XX属性大于XX数值的目标时，最终伤害变化XX%", var_0_4("攻击%s属性大于%d数值的目标时，最终伤害变化%.2f%%", var_0_5:get_attr_name_cn(var_44_37), var_44_38, arg_44_1:get_attribute().change_damage_greater_than_num.hurt_rate * 100))
			end
		end

		if arg_44_1:get_attribute().change_final_damage_by_stage then
			local var_44_41 = arg_44_1:get_attribute().change_final_damage_by_stage.effect_stage

			if var_0_7:judge_stage(var_44_41, self._battlefield._battle_step) then
				arg_44_1:get_attribute().change_final_damage = (1 + arg_44_1:get_attribute().change_final_damage) * (1 + arg_44_1:get_attribute().change_final_damage_by_stage.num) - 1
			end

			self:set_damage_record("舰队在[参数E]阶段，造成伤害提高[参数A]", var_0_4("舰队在%s阶段，造成伤害提高%.2f%%", var_0_5:get_stage_name_cn(var_44_41), arg_44_1:get_attribute().change_final_damage_by_stage.num * 100))
		end

		if arg_44_2:get_attribute().change_final_be_damage_by_stage then
			local var_44_42 = arg_44_2:get_attribute().change_final_be_damage_by_stage.effect_stage

			if var_0_7:judge_stage(var_44_42, self._battlefield._battle_step) then
				arg_44_2:get_attribute().change_final_be_damage = (1 + arg_44_2:get_attribute().change_final_be_damage) * (1 - arg_44_2:get_attribute().change_final_be_damage_by_stage.num) - 1
			end

			self:set_damage_record("舰队在[参数E]阶段，受到伤害降低[参数A]", var_0_4("舰队在%s阶段，受到伤害降低%.2f%%", var_0_5:get_stage_name_cn(var_44_42), var_0_2.abs(arg_44_2:get_attribute().change_final_be_damage_by_stage.num) * 100))
		end

		if arg_44_1:get_attribute().change_damage_less_than_num then
			local var_44_43 = arg_44_1:get_attribute().change_damage_less_than_num.attr_type
			local var_44_44 = arg_44_1:get_attribute().change_damage_less_than_num.attr_num

			if var_44_44 > arg_44_2:get_attribute()[var_44_43]:get_final_value() then
				self._damage_attr.damage = self._damage_attr.damage * (1 + arg_44_1:get_attribute().change_damage_less_than_num.hurt_rate)
				self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)

				local var_44_45 = arg_44_2:get_attribute().now_hp:get_final_value()
				local var_44_46 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage

				var_44_46 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage > 0 and var_44_46 or 0

				arg_44_2:get_attribute().now_hp:modify_to_value(var_44_46)
				self:set_damage_record("触发技能:攻击XX属性小于XX数值的目标时，最终伤害变化XX%", var_0_4("攻击%s属性小于%d数值的目标时，最终伤害变化%.2f%%", var_0_5:get_attr_name_cn(var_44_43), var_44_44, arg_44_1:get_attribute().change_damage_less_than_num.hurt_rate * 100))
			end
		end

		if arg_44_1:get_attribute().change_damage_by_index and arg_44_1:get_index() == arg_44_2:get_index() then
			self._damage_attr.damage = self._damage_attr.damage * (1 + arg_44_1:get_attribute().change_damage_by_index)
			self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)

			local var_44_47 = arg_44_2:get_attribute().now_hp:get_final_value()
			local var_44_48 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage

			var_44_48 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage > 0 and var_44_48 or 0

			arg_44_2:get_attribute().now_hp:modify_to_value(var_44_48)
			self:set_damage_record("触发技能:攻击对应位置的目标，最终伤害改变XX%", "攻击对应位置的目标，最终伤害改变" .. arg_44_1:get_attribute().change_damage_by_index)
		end

		if arg_44_1:get_attribute().change_damage_by_hp_not_full and not self._is_full_hp_before_attack then
			self._damage_attr.damage = self._damage_attr.damage * (1 + arg_44_1:get_attribute().change_damage_by_hp_not_full)
			self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)

			local var_44_49 = arg_44_2:get_attribute().now_hp:get_final_value()
			local var_44_50 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage

			var_44_50 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage > 0 and var_44_50 or 0

			arg_44_2:get_attribute().now_hp:modify_to_value(var_44_50)
			self:set_damage_record("触发技能:对耐久值不满的目标攻击时，最终伤害改变XX%", "对耐久值不满的目标攻击时，最终伤害改变" .. arg_44_1:get_attribute().change_damage_by_hp_not_full)
		end

		if arg_44_1:get_attribute().change_damage_by_special_ship and self:__get_probability_result(arg_44_1, 92) then
			local var_44_51 = arg_44_1:get_attribute().change_damage_by_special_ship.type
			local var_44_53

			if var_44_51 == "shipTypes" then
				var_44_53 = arg_44_2:get_ship_type()
			elseif var_44_51 == "shipTons" then
				var_44_53 = arg_44_2:get_ship_ton()
			elseif var_44_51 == "guardTypes" then
				var_44_53 = arg_44_2:get_ship_guard_type()
			end

			for iter_44_18, iter_44_19 in pairs(arg_44_1:get_attribute().change_damage_by_special_ship.type_num) do
				if iter_44_19 == var_44_53 then
					self._damage_attr.damage = self._damage_attr.damage * (1 + arg_44_1:get_attribute().change_damage_by_special_ship.hurt_rate)
					self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)

					local var_44_54 = arg_44_2:get_attribute().now_hp:get_final_value()
					local var_44_55 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage

					var_44_55 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage > 0 and var_44_55 or 0

					arg_44_2:get_attribute().now_hp:modify_to_value(var_44_55)
					self:set_damage_record("触发技能:攻击特定类型船时，最终伤害改变XX%", "攻击特定类型船时，最终伤害改变" .. arg_44_1:get_attribute().change_damage_by_special_ship.hurt_rate)
				end
			end
		end

		if arg_44_1:get_attribute().change_damage_by_is_flag_with_percnet and arg_44_2:is_flag() then
			self._damage_attr.damage = self._damage_attr.damage * (1 + arg_44_1:get_attribute().change_damage_by_is_flag_with_percnet)
			self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)

			local var_44_56 = arg_44_2:get_attribute().now_hp:get_final_value()
			local var_44_57 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage

			var_44_57 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage > 0 and var_44_57 or 0

			arg_44_2:get_attribute().now_hp:modify_to_value(var_44_57)
			self:set_damage_record("触发技能:攻击旗舰时,最终伤害改变xx%", "攻击旗舰时,最终伤害改变" .. arg_44_1:get_attribute().change_damage_by_is_flag_with_percnet)
		end

		if arg_44_1:get_attribute().add_damage_by_now_hp_less_than_num then
			local var_44_58 = arg_44_2:get_attribute().now_hp:get_final_value()

			if var_44_0 then
				var_44_58 = arg_44_2:get_attribute().now_hp:reduction_to_next_value()
			end

			if arg_44_2:get_attribute().now_hp:get_final_value() / arg_44_2:get_attribute().hp:get_final_value() < arg_44_1:get_attribute().add_damage_by_now_hp_less_than_num.target_hp then
				self._damage_attr.damage = self._damage_attr.damage * (1 + arg_44_1:get_attribute().add_damage_by_now_hp_less_than_num.max_damage)
				self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)
				var_44_58 = var_44_58 - self._damage_attr.damage
				var_44_58 = var_44_58 > 0 and var_44_58 or 0

				arg_44_2:get_attribute().now_hp:modify_to_value(var_44_58)
				self:set_damage_record("攻击时对方生命值低于对方自己生命上限的百分之xx,最终伤害增加xx%", var_0_4("攻击对象当前耐久低于其耐久上限的%.2f%%时触发,最终伤害增加%.2f%%", arg_44_1:get_attribute().add_damage_by_now_hp_less_than_num.target_hp * 100, arg_44_1:get_attribute().add_damage_by_now_hp_less_than_num.max_damage * 100))
			else
				local var_44_59 = var_44_58 - self._damage_attr.damage

				var_44_59 = var_44_58 - self._damage_attr.damage > 0 and var_44_59 or 0

				arg_44_2:get_attribute().now_hp:modify_to_value(var_44_59)
			end
		end

		if arg_44_1:get_attribute().add_damage_by_now_hp_greater_than_num then
			local var_44_60 = arg_44_1:get_attribute()

			if var_44_60.now_hp:get_final_value() / var_44_60.hp:get_final_value() > arg_44_1:get_attribute().add_damage_by_now_hp_greater_than_num.target_hp then
				self._damage_attr.damage = self._damage_attr.damage * (1 + arg_44_1:get_attribute().add_damage_by_now_hp_greater_than_num.max_damage)
				self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)

				local var_44_61 = arg_44_2:get_attribute().now_hp:get_final_value()
				local var_44_62 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage

				var_44_62 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage > 0 and var_44_62 or 0

				arg_44_2:get_attribute().now_hp:modify_to_value(var_44_62)
				self:set_damage_record("攻击时自身生命值高于自己上限的百分之xx,最终伤害增加xx%", var_0_4("自身当前耐久高于耐久上限的%.2f%%时触发,最终伤害增加%.2f%%", arg_44_1:get_attribute().add_damage_by_now_hp_greater_than_num.target_hp * 100, arg_44_1:get_attribute().add_damage_by_now_hp_greater_than_num.max_damage * 100))
			end
		end

		if self._plane_type == var_0_5.equip_type.bomber and self._battle_scene:get_open_airattack_damage_up_data() then
			for iter_44_20, iter_44_21 in pairs((self._battle_scene:get_open_airattack_damage_up_data())) do
				if iter_44_21.airplane_type == 1 and self._battlefield._battle_step == iter_44_21.stage then
					self._damage_attr.damage = self._damage_attr.damage * (1 + iter_44_21.rate)
					self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)

					local var_44_63 = arg_44_2:get_attribute().now_hp:get_final_value()
					local var_44_64 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage

					var_44_64 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage > 0 and var_44_64 or 0

					arg_44_2:get_attribute().now_hp:modify_to_value(var_44_64)
					self:set_damage_record("触发了深海buff:轰炸机攻击增加", var_0_4("最终伤害提升%s", iter_44_21.rate))
				end
			end
		end

		if self._plane_type == var_0_5.equip_type.torpedo_plane and self._battle_scene:get_open_airattack_damage_up_data() then
			for iter_44_22, iter_44_23 in pairs((self._battle_scene:get_open_airattack_damage_up_data())) do
				if iter_44_23.airplane_type == 2 and self._battlefield._battle_step == iter_44_23.stage then
					self._damage_attr.damage = self._damage_attr.damage * (1 + iter_44_23.rate)
					self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)

					local var_44_65 = arg_44_2:get_attribute().now_hp:get_final_value()
					local var_44_66 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage

					var_44_66 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage > 0 and var_44_66 or 0

					arg_44_2:get_attribute().now_hp:modify_to_value(var_44_66)
					self:set_damage_record("触发了深海buff:鱼雷机攻击增加", var_0_4("最终伤害提升%s", iter_44_23.rate))
				end
			end
		end

		if arg_44_1:get_attribute().change_crit_hurt_by_ship_type then
			local var_44_67 = self._damage_attr.is_crit
			local var_44_68
			local var_44_69 = arg_44_1:get_attribute().change_crit_hurt_by_ship_type.data_type

			if var_44_69 == "shipTypes" then
				var_44_68 = arg_44_2:get_ship_type()
			elseif var_44_69 == "shipTons" then
				var_44_68 = arg_44_2:get_ship_ton()
			elseif var_44_69 == "guardTypes" then
				var_44_68 = arg_44_2:get_ship_guard_type()
			end

			for iter_44_24, iter_44_25 in pairs(arg_44_1:get_attribute().change_crit_hurt_by_ship_type.data_num) do
				if var_44_68 == iter_44_25 and var_44_67 then
					self._damage_attr.damage = self._damage_attr.damage * (1 + arg_44_1:get_attribute().change_crit_hurt_by_ship_type.hurt_rate)
					self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)

					local var_44_70 = arg_44_2:get_attribute().now_hp:get_final_value()
					local var_44_71 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage

					var_44_71 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage > 0 and var_44_71 or 0

					arg_44_2:get_attribute().now_hp:modify_to_value(var_44_71)
					self:set_damage_record("触发技能:暴击时，伤害变化XX%", "伤害变化" .. arg_44_1:get_attribute().change_crit_hurt_by_ship_type.hurt_rate .. "最终伤害为" .. self._damage_attr.damage)
				end
			end
		end

		if arg_44_2:get_attribute().in_guardian and arg_44_2:get_attribute().in_guardian == true then
			self._damage_attr.damage = self._damage_attr.damage * (1 + -arg_44_2:get_attribute().skill_num.guardian.rate)
			self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)

			local var_44_72 = arg_44_2:get_attribute().now_hp:get_final_value()

			if var_44_0 then
				var_44_72 = arg_44_2:get_attribute().now_hp:reduction_to_next_value()
			end

			local var_44_73 = ((var_44_1 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage

			var_44_73 = ((var_44_1 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage > 0 and var_44_73 or 0

			arg_44_2:get_attribute().now_hp:modify_to_value(var_44_73)
			self:set_damage_record("触发技能:守护动作", "守护队友，最终伤害" .. arg_44_2:get_attribute().skill_num.guardian.rate)

			self._damage_attr.is_immune = true
			self._damage_attr.damage_type = var_0_5.damage_type.normal
			arg_44_2:get_attribute().in_guardian = false
		end

		if arg_44_1:get_attribute().change_attack_rate then
			local var_44_74 = self._battle_random:randRange(arg_44_1:get_attribute().change_attack_rate.hurt_rate * 100, arg_44_1:get_attribute().change_attack_rate.hurt_rate2 * 100)

			self._damage_attr.damage = self._damage_attr.damage * (1 + var_44_74 / 100)
			self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)

			local var_44_75 = arg_44_2:get_attribute().now_hp:get_final_value()
			local var_44_76 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage

			var_44_76 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage > 0 and var_44_76 or 0

			arg_44_2:get_attribute().now_hp:modify_to_value(var_44_76)
			self:set_damage_record("触发技能:伤害浮动xx%-xx%", "伤害浮动xx%-xx%，本次提升伤害" .. var_44_74 .. "%最终伤害" .. self._damage_attr.damage)
		end

		if arg_44_1:get_attribute().change_final_damage ~= 0 then
			self._damage_attr.damage = self._damage_attr.damage * (1 + (arg_44_1:get_attribute().change_final_damage < -1 and -1 or arg_44_1:get_attribute().change_final_damage))
			self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)

			local var_44_77 = arg_44_2:get_attribute().now_hp:get_final_value()
			local var_44_78 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage

			var_44_78 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage > 0 and var_44_78 or 0

			arg_44_2:get_attribute().now_hp:modify_to_value(var_44_78)

			if arg_44_1:get_attribute().change_final_damage ~= 0 then
				self:set_damage_record("触发技能:造成的最终伤害变化XX%", "（总结，可能多个技能叠加）最终伤害改变百分比" .. arg_44_1:get_attribute().change_final_damage .. "最终伤害为" .. self._damage_attr.damage)
			end
		end

		if arg_44_2:get_attribute().change_final_be_damage ~= 0 then
			if arg_44_2:get_attribute().more_change_final_be_damage_save then
				if var_0_3(arg_44_2:get_attribute().more_change_final_be_damage_save) then
					if #arg_44_2:get_attribute().more_change_final_be_damage_save == 1 then
						self._damage_attr.damage = self._damage_attr.damage * (1 + (arg_44_2:get_attribute().change_final_be_damage < -1 and -1 or arg_44_2:get_attribute().change_final_be_damage))
						self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)
					elseif #arg_44_2:get_attribute().more_change_final_be_damage_save > 1 then
						for iter_44_26, iter_44_27 in pairs(arg_44_2:get_attribute().more_change_final_be_damage_save) do
							self._damage_attr.damage = self._damage_attr.damage * (1 + (iter_44_27 < -1 and -1 or iter_44_27))
							self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)
						end
					end
				else
					self._damage_attr.damage = self._damage_attr.damage * (1 + (arg_44_2:get_attribute().change_final_be_damage < -1 and -1 or arg_44_2:get_attribute().change_final_be_damage))
					self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)
				end
			else
				self._damage_attr.damage = self._damage_attr.damage * (1 + (arg_44_2:get_attribute().change_final_be_damage < -1 and -1 or arg_44_2:get_attribute().change_final_be_damage))
				self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)
			end

			local var_44_80 = arg_44_2:get_attribute().now_hp:get_final_value()
			local var_44_81 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage

			var_44_81 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage > 0 and var_44_81 or 0

			arg_44_2:get_attribute().now_hp:modify_to_value(var_44_81)

			if arg_44_2:get_attribute().change_final_be_damage ~= 0 then
				self:set_damage_record("触发技能:敌人被造成的最终伤害变化XX%", "（总结，可能多个技能叠加）被造成的最终伤害改变百分比" .. arg_44_2:get_attribute().change_final_be_damage .. "最终伤害为" .. self._damage_attr.damage)
			end
		end

		local var_44_82 = arg_44_2:get_attribute().skill_num and arg_44_2:get_attribute().skill_num.change_final_be_damage_list

		if var_44_82 and var_0_3(var_44_82) then
			for iter_44_28, iter_44_29 in pairs(var_44_82) do
				local var_44_83 = false

				for iter_44_30, iter_44_31 in pairs(iter_44_29.stage) do
					if var_0_7:judge_stage(iter_44_31, self._battlefield._battle_step) then
						var_44_83 = true
					end
				end

				if var_44_83 then
					self._damage_attr.damage = self._damage_attr.damage * (1 + (iter_44_29.rate < -1 and -1 or iter_44_29.rate))
					self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage)
				end
			end

			local var_44_84 = arg_44_2:get_attribute().now_hp:get_final_value()
			local var_44_85 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage

			var_44_85 = ((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage > 0 and var_44_85 or 0

			arg_44_2:get_attribute().now_hp:modify_to_value(var_44_85)
			self:set_damage_record("触发技能:被自身攻击命中的目标受到最终伤害改变XX%", "（总结，可能多个技能叠加）被自身攻击命中的目标受到最终伤害改变，最终伤害为" .. self._damage_attr.damage)
		end

		if arg_44_1:get_attribute().phase_no_damage_by_phase_attack then
			local var_44_86 = arg_44_1:get_attribute().phase_no_damage_by_phase_attack

			for iter_44_32, iter_44_33 in pairs(var_44_86.action_stage) do
				if var_0_7:judge_stage(iter_44_33, self._battlefield._battle_step) and self._damage_attr.damage == 0 then
					arg_44_1:set_attack_step_again_type(var_44_86.buff_stage[1], var_44_86.add_num)
				end
			end
		end

		if self:__get_probability_result(arg_44_2, 100) then
			if arg_44_2:get_attribute().hited_effect == 1 then
				self._damage_attr.is_immune = true
				self._damage_attr.damage_type = var_0_5.damage_type.normal
			elseif arg_44_2:get_attribute().hited_effect == 2 then
				self._damage_attr.is_dodging = true
				self._damage_attr.is_immune = false
				self._damage_attr.is_crit = false
				self._damage_attr.damage_type = var_0_5.damage_type.normal
			end
		end

		if arg_44_2:get_attribute().lock_hp_by_num then
			local var_44_87 = arg_44_2:get_attribute().now_hp:get_final_value()

			if var_44_0 then
				var_44_87 = arg_44_2:get_attribute().now_hp:reduction_to_next_value()
			end

			local var_44_88 = arg_44_2:get_attribute().lock_hp_by_num
			local var_44_89 = var_44_87 - self._damage_attr.damage

			var_44_89 = var_44_87 - self._damage_attr.damage < var_44_88 and var_44_88 or var_44_89
			self._damage_attr.damage = var_0_2.ceil(arg_44_2:get_attribute().now_hp:get_final_value() - var_44_89)

			if self._damage_attr.damage == 0 then
				self._damage_attr.damage_type = var_0_5.damage_type.normal
			end

			arg_44_2:get_attribute().now_hp:modify_to_value(var_44_89)
			self:set_damage_record("触发技能:-血量不会降到xx以下", "血量不会降到" .. var_44_88 .. "以下")
		end

		arg_44_2:get_attribute().skill_num = arg_44_2:get_attribute().skill_num or {}

		if arg_44_2:get_attribute().skill_num.change_damage_by_attr_by_num and arg_44_2:get_attribute().skill_num.change_damage_by_attr_by_num.num > 0 then
			local var_44_91 = arg_44_2:get_attribute().skill_num.change_damage_by_attr_by_num.damage_rate

			if self._damage_attr.damage > arg_44_2:get_attribute()[arg_44_2:get_attribute().skill_num.change_damage_by_attr_by_num.attr_type]:get_final_value() * arg_44_2:get_attribute().skill_num.change_damage_by_attr_by_num.attr_rate then
				local var_44_92 = arg_44_2:get_attribute().now_hp:reduction_to_next_value()

				self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage * (1 - var_44_91))

				local var_44_93 = var_44_92 - self._damage_attr.damage

				var_44_93 = var_44_92 - self._damage_attr.damage > 0 and var_44_93 or 0

				arg_44_2:get_attribute().now_hp:modify_to_value(var_44_93)

				arg_44_2:get_attribute().skill_num.change_damage_by_attr_by_num.num = arg_44_2:get_attribute().skill_num.change_damage_by_attr_by_num.num - 1

				self:set_damage_record("触发技能:受到当前XX属性XX%的伤害时", "自身所受伤害减少了" .. var_44_91)
			end
		end

		local var_44_94 = self._battle_scene:get_kill_target_immediate_data() or arg_44_2:is_flag() or self._battle_scene:get_kill_not_flag_target_immediate_data()

		if var_44_94 then
			for iter_44_34, iter_44_35 in pairs(var_44_94.ship_list) do
				if arg_44_1:getID() == iter_44_35 and self._battle_random:randomRangeDouble(0, 1) <= var_44_94.rate then
					self._damage_attr.damage = arg_44_2:get_attribute().now_hp:reduction_to_next_value()

					arg_44_2:get_attribute().now_hp:modify_to_value(0)
					arg_44_2:set_is_alive(false)
					self:__process_unit_die(arg_44_2)

					self._damage_attr.damage_type = var_0_5.damage_type.kill
					self._damage_attr.is_miss = false
					self._damage_attr.is_crit = false
				end
			end
		end

		local var_44_96 = self._battle_scene:get_hit_reset_zero_data()

		if var_44_96 then
			for iter_44_36, iter_44_37 in pairs(var_44_96.ship_list) do
				if arg_44_1:getID() == iter_44_37 and self._damage_attr.damage <= var_44_96.num then
					self._damage_attr.damage = 0

					local var_44_97 = arg_44_2:get_attribute().now_hp:get_final_value()

					arg_44_2:get_attribute().now_hp:modify_to_value((var_44_0 or nil) and arg_44_2:get_attribute().now_hp:reduction_to_next_value())
				end
			end
		end

		local var_44_98 = self._battle_scene:get_evade_hit_data()

		if var_44_98 then
			for iter_44_38, iter_44_39 in pairs(var_44_98.ship_list) do
				if arg_44_2:getID() == iter_44_39 and self._battle_random:randomRangeDouble(0, 1) <= var_44_98.num then
					self._damage_attr.damage = 0
					self._damage_attr.is_miss = true
					self._damage_attr.is_crit = false
					self._damage_attr.damage_type = var_0_5.damage_type.miss

					if var_44_0 then
						arg_44_2:get_attribute().now_hp:reduction_to_next_value()
					end

					self:set_damage_record("触发(深海)buff：攻击概率闪避", "成功触发闪避，闪避概率为" .. var_44_98.num .. "%")
				end
			end
		end

		if arg_44_2:get_attribute().creat_shield_in_hurt and self._damage_attr.is_miss ~= true then
			arg_44_2:get_attribute().skill_num = arg_44_2:get_attribute().skill_num or {}

			if not arg_44_2:get_attribute().skill_num._is_immune_to_first_damage or arg_44_2:get_attribute().skill_num._is_immune_to_first_damage < 1 then
				arg_44_2:get_attribute().skill_num._is_immune_to_first_damage = 2
				arg_44_2:get_attribute()._is_immune_to_first_damage = true
				arg_44_2:get_attribute().skill_num._is_immune_to_first_damage_stage = arg_44_2:get_attribute().creat_shield_in_hurt
			end

			if arg_44_2:get_attribute().skill_num._is_immune_to_first_damage == 1 then
				arg_44_2:get_attribute().skill_num._is_immune_to_first_damage = 0
			end
		end

		if not self._damage_attr.is_immune_pool_used and self:__get_probability_result(arg_44_2, 67) and arg_44_2:get_attribute().skill_num and arg_44_2:get_attribute().skill_num._total_immune_value and arg_44_2:get_attribute().skill_num._total_immune_value > 0 then
			self._damage_attr.is_immune_pool_used = true
			self._damage_attr.damage = 0
			self._damage_attr.damage_type = var_0_5.damage_type.normal

			if var_44_0 then
				arg_44_2:get_attribute().now_hp:reduction_to_next_value()
			end

			if not self._damage_attr.is_dodging then
				self._damage_attr.is_immune = true
			end

			arg_44_2:get_attribute().skill_num._total_immune_value = arg_44_2:get_attribute().skill_num._total_immune_value - 1

			self:set_damage_record("触发技能:免疫伤害（每场战斗触发xx次）", "免疫伤害（每场战斗触发xx次）,剩余次数：" .. arg_44_2:get_attribute().skill_num._total_immune_value)
		end

		if not self._damage_attr.is_immune_pool_used and arg_44_2:get_attribute().skill_num and arg_44_2:get_attribute().skill_num._buff_immune_value and arg_44_2:get_attribute().skill_num._buff_immune_value > 0 then
			self._damage_attr.is_immune_pool_used = true
			self._damage_attr.damage = 0
			self._damage_attr.damage_type = var_0_5.damage_type.normal

			if var_44_0 then
				arg_44_2:get_attribute().now_hp:reduction_to_next_value()
			end

			if not self._damage_attr.is_dodging then
				self._damage_attr.is_immune = true
			end

			arg_44_2:get_attribute().skill_num._buff_immune_value = arg_44_2:get_attribute().skill_num._buff_immune_value - 1

			self:set_damage_record("触发技能:免疫伤害（可被buff配置）", "免疫伤害（可被buff配置）,剩余次数：" .. arg_44_2:get_attribute().skill_num._buff_immune_value)
		end

		local var_44_99 = arg_44_2:get_attribute().immune_num_of_speed_and_shipTons_atk

		arg_44_2:get_attribute().skill_num = arg_44_2:get_attribute().skill_num or {}

		if not self._damage_attr.is_immune_pool_used and var_44_99 and arg_44_2:get_attribute().skill_num.immune_num_of_speed_and_shipTons_atk.num > 0 then
			local var_44_100 = false
			local var_44_101 = false

			if var_44_99.attr_num and arg_44_1:get_attribute()[var_44_99.attr_type]:get_final_value() <= var_44_99.attr_num then
				var_44_100 = true
			end

			local var_44_103 = arg_44_1:get_ship_ton()
			local var_44_104 = arg_44_1:get_ship_type()
			local var_44_105 = arg_44_1:get_ship_guard_type()

			if var_44_99.shipTons then
				for iter_44_40, iter_44_41 in pairs(var_44_99.shipTons) do
					if var_44_103 == iter_44_41 then
						var_44_101 = true

						break
					end
				end
			elseif var_44_99.shipTypes then
				for iter_44_42, iter_44_43 in pairs(var_44_99.shipTypes) do
					if var_44_104 == iter_44_43 then
						var_44_101 = true

						break
					end
				end
			elseif var_44_99.guardTypes then
				for iter_44_44, iter_44_45 in pairs(var_44_99.guardTypes) do
					if var_44_105 == iter_44_45 then
						var_44_101 = true

						break
					end
				end
			end

			if var_44_100 == true and var_44_101 == true and ((var_44_99.flag and var_44_99.flag == 1 and arg_44_1:is_flag() or nil) and false) == true then
				self._damage_attr.is_immune_pool_used = true
				self._damage_attr.damage = 0
				self._damage_attr.damage_type = var_0_5.damage_type.normal

				if var_44_0 then
					arg_44_2:get_attribute().now_hp:reduction_to_next_value()
				end

				self._damage_attr.is_immune = true
				arg_44_2:get_attribute().skill_num.immune_num_of_speed_and_shipTons_atk.num = arg_44_2:get_attribute().skill_num.immune_num_of_speed_and_shipTons_atk.num - 1

				self:set_damage_record("触发技能:免疫伤害（每场战斗触发xx次）", "免疫伤害（每场战斗触发xx次）,剩余次数：" .. arg_44_2:get_attribute().skill_num.immune_num_of_speed_and_shipTons_atk.num)
			end
		end

		if arg_44_2:get_attribute().now_hp:get_final_value() <= 0 then
			arg_44_2:get_attribute().is_full_damage = true

			local var_44_106, var_44_107 = arg_44_2:get_recover_life_state()

			arg_44_2:get_attribute().skill_num = arg_44_2:get_attribute().skill_num or {}

			if var_44_106 then
				arg_44_2:set_recover_life_state(false, 0)

				self._damage_attr.is_recover_life = var_44_107

				self:set_damage_record("技能加血", var_0_4("致命伤害回复指定生命值%d 伤害=%d", var_44_107, self._damage_attr.damage))

				arg_44_2:get_attribute().skill_num.have_recover_life = var_44_107
			elseif arg_44_2:get_attribute().skill_num.have_recover_life then
				self._damage_attr.is_recover_life = true
			end
		end

		if not self._damage_attr.is_immune_pool_used and arg_44_2._immune_num_of_special_atk then
			for iter_44_46, iter_44_47 in pairs(arg_44_2._immune_num_of_special_atk.type) do
				if iter_44_47 == arg_44_1:get_atk_type() and arg_44_2.skill_num._immune_num_of_special_atk.count > 0 then
					self._damage_attr.is_immune_pool_used = true
					arg_44_2.skill_num._immune_num_of_special_atk.count = arg_44_2.skill_num._immune_num_of_special_atk.count - 1
					self._damage_attr.is_immune = true
					self._damage_attr.damage = 0
					self._damage_attr.damage_type = var_0_5.damage_type.normal

					self:set_damage_record("技能免疫", var_0_4("免疫特殊类型%s攻击伤害 伤害=%d", iter_44_47, self._damage_attr.damage))

					if var_44_0 then
						arg_44_2:get_attribute().now_hp:reduction_to_next_value()
					end
				end
			end
		end

		if not self._damage_attr.is_immune_pool_used and self:__get_probability_result(arg_44_2, 33) then
			local var_44_109 = arg_44_2:get_reduce_percentage_of_damage()

			if var_44_109 and var_0_3(var_44_109) and var_44_109.count > 0 then
				self._damage_attr.is_immune_pool_used = true

				local var_44_110 = arg_44_2:get_attribute().now_hp:get_final_value()

				if var_44_0 then
					var_44_110 = arg_44_2:get_attribute().now_hp:reduction_to_next_value()
				end

				local var_44_111 = self._damage_attr.damage

				self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage * (1 - var_44_109.rate))

				local var_44_112 = var_0_2.ceil(var_44_110 - self._damage_attr.damage)

				var_44_112 = var_44_112 > 0 and var_44_112 or 0

				arg_44_2:get_attribute().now_hp:modify_to_value(var_44_112)
				arg_44_2:set_reduce_percentage_of_damage(var_44_109.rate, var_44_109.count - 1)
				self:set_damage_record("触发技能:获取减少xx%所受到的伤害", string.format("伤害减少%f, 伤害前:%d,伤害后:%d", var_44_109.rate, var_44_111, self._damage_attr.damage))
			end
		end

		if arg_44_1:get_attribute().can_not_hit_in_this_stage_by_be_hit then
			arg_44_2:set_is_not_attack_for_type(arg_44_1:get_attribute().can_not_hit_in_this_stage_by_be_hit)
			self:set_damage_record("触发技能:被攻击目标xx阶段无法进行攻击", "被攻击目标xx阶段无法进行攻击")
		end

		if arg_44_1:get_attribute().can_not_hit_in_this_stage_by_not_flag and not arg_44_2:is_flag() then
			arg_44_2:set_is_not_attack_for_type(arg_44_1:get_attribute().can_not_hit_in_this_stage_by_not_flag)
			self:set_damage_record("触发技能:被攻击非旗舰目标xx阶段无法进行攻击", "被攻击非旗舰目标xx阶段无法进行攻击")
		end

		if arg_44_1:get_attribute().can_not_shout_in_crit_by_stage and self._damage_attr.is_crit then
			arg_44_2:set_is_not_attack_for_type(arg_44_1:get_attribute().can_not_shout_in_crit_by_stage)
			self:set_damage_record("触发技能:攻击暴击时，命中目标在XX阶段无法攻击", "攻击暴击时，命中目标在XX阶段无法攻击")
		end

		arg_44_2.can_back_hit = not self._damage_attr.is_miss and not self._is_beat_back

		if arg_44_1:get_attribute().self_change_attr_by_shiptype_by_stage then
			arg_44_1:get_attribute().skill_num = arg_44_1:get_attribute().skill_num or {}
			arg_44_1:get_attribute().skill_num.change_attr_by_stage = arg_44_1:get_attribute().skill_num.change_attr_by_stage or {}

			for iter_44_48, iter_44_49 in pairs(arg_44_1:get_attribute().self_change_attr_by_shiptype_by_stage) do
				if iter_44_49.shipTypes then
					if var_0_7:have_data(iter_44_49.shipTypes, arg_44_1:get_ship_type()) then
						arg_44_1:get_attribute().skill_num.change_attr_by_stage[iter_44_48] = {
							attr_type = iter_44_49.attr_type,
							attr_num = iter_44_49.attr_num,
							effect_stage = iter_44_49.effect_stage,
							percent = iter_44_49.percent
						}
					end
				elseif iter_44_49.shipTons and var_0_7:have_data(iter_44_49.shipTons, arg_44_1:get_ship_ton()) then
					arg_44_1:get_attribute().skill_num.change_attr_by_stage[iter_44_48] = {
						attr_type = iter_44_49.attr_type,
						attr_num = iter_44_49.attr_num,
						effect_stage = iter_44_49.effect_stage,
						percent = iter_44_49.percent
					}
				end
			end
		end

		if arg_44_1:get_attribute().target_change_attr_by_shiptype_by_stage and (self:__get_probability_result(arg_44_1, 127) or self:__get_probability_result(arg_44_1, 128)) then
			arg_44_2:get_attribute().skill_num = arg_44_2:get_attribute().skill_num or {}
			arg_44_2:get_attribute().skill_num.change_attr_by_stage = arg_44_2:get_attribute().skill_num.change_attr_by_stage or {}

			for iter_44_50, iter_44_51 in pairs(arg_44_1:get_attribute().target_change_attr_by_shiptype_by_stage) do
				local var_44_115 = true

				for iter_44_52, iter_44_53 in pairs(arg_44_2:get_attribute().skill_num.change_attr_by_stage) do
					if iter_44_53.unique and iter_44_53.unique[1] == iter_44_51.unique[1] and iter_44_53.unique[2] == iter_44_51.unique[2] then
						var_44_115 = false
					end
				end

				if not iter_44_51.unique or iter_44_51.unique[1] == 0 then
					var_44_115 = true
				end

				local var_44_116 = #arg_44_2:get_attribute().skill_num.change_attr_by_stage

				if var_44_115 then
					if iter_44_51.shipTypes then
						if var_0_7:have_data(iter_44_51.shipTypes, arg_44_2:get_ship_type()) then
							arg_44_2:get_attribute().skill_num.change_attr_by_stage[var_44_116 + 1] = {
								attr_type = iter_44_51.attr_type,
								attr_num = iter_44_51.attr_num,
								effect_stage = iter_44_51.effect_stage,
								unique = iter_44_51.unique,
								percent = iter_44_51.percent
							}
						end
					elseif iter_44_51.shipTons and var_0_7:have_data(iter_44_51.shipTons, arg_44_2:get_ship_ton()) then
						arg_44_2:get_attribute().skill_num.change_attr_by_stage[var_44_116 + 1] = {
							attr_type = iter_44_51.attr_type,
							attr_num = iter_44_51.attr_num,
							effect_stage = iter_44_51.effect_stage,
							unique = iter_44_51.unique,
							percent = iter_44_51.percent
						}
					end
				end
			end
		end

		if arg_44_1:get_attribute().change_be_crit_rate_by_be_hit and not self._damage_attr.is_miss then
			arg_44_2:get_attribute().skill_num = arg_44_2:get_attribute().skill_num or {}
			arg_44_2:get_attribute().skill_num.change_be_crit_rate_by_stage = arg_44_2:get_attribute().skill_num.change_be_crit_rate_by_stage or {}

			local var_44_117 = true

			for iter_44_54, iter_44_55 in pairs(arg_44_2:get_attribute().skill_num.change_be_crit_rate_by_stage) do
				if iter_44_55.unique and arg_44_1:get_attribute().change_be_crit_rate_by_be_hit.unique and iter_44_55.unique[1] == arg_44_1:get_attribute().change_be_crit_rate_by_be_hit.unique[1] and iter_44_55.unique[2] == arg_44_1:get_attribute().change_be_crit_rate_by_be_hit.unique[2] then
					var_44_117 = false
				end
			end

			if (not arg_44_1:get_attribute().change_be_crit_rate_by_be_hit.unique or arg_44_1:get_attribute().change_be_crit_rate_by_be_hit.unique[1] == 0 or nil) and true then
				table.insert(arg_44_2:get_attribute().skill_num.change_be_crit_rate_by_stage, arg_44_1:get_attribute().change_be_crit_rate_by_be_hit)
			end
		end

		if arg_44_1:get_attribute().change_final_be_damage_by_be_hit and not self._damage_attr.is_miss then
			local var_44_118 = arg_44_1:get_attribute().change_final_be_damage_by_be_hit

			if var_44_118.unique and var_44_118.unique[1] and var_44_118.unique[1] ~= 0 then
				arg_44_2:get_attribute().skill_num = arg_44_2:get_attribute().skill_num or {}
				arg_44_2:get_attribute().skill_num.change_final_be_damage_list = arg_44_2:get_attribute().skill_num.change_final_be_damage_list or {}

				local var_44_119 = true

				for iter_44_56, iter_44_57 in pairs(arg_44_2:get_attribute().skill_num.change_final_be_damage_list) do
					if iter_44_57.unique and iter_44_57.unique[1] == var_44_118.unique[1] and iter_44_57.unique[2] == var_44_118.unique[2] then
						var_44_119 = false
					end
				end

				if var_44_119 then
					table.insert(arg_44_2:get_attribute().skill_num.change_final_be_damage_list, {
						rate = var_44_118.rate,
						stage = var_44_118.stage,
						unique = var_44_118.unique
					})
					self:set_damage_record("触发技能:被自身攻击命中的目标受到最终伤害改变XX%", "被自身攻击命中的目标受到最终伤害改变" .. var_44_118.rate)
				end
			end
		end

		if arg_44_2:get_attribute().self_change_attr_by_shiptype_by_stage_by_attack then
			arg_44_2:get_attribute().skill_num = arg_44_2:get_attribute().skill_num or {}
			arg_44_2:get_attribute().skill_num.change_attr_by_stage = arg_44_2:get_attribute().skill_num.change_attr_by_stage or {}

			for iter_44_58, iter_44_59 in pairs(arg_44_2:get_attribute().self_change_attr_by_shiptype_by_stage_by_attack) do
				local var_44_121 = true

				for iter_44_60, iter_44_61 in pairs(arg_44_2:get_attribute().skill_num.change_attr_by_stage) do
					if iter_44_61.unique and iter_44_61.unique[1] == iter_44_59.unique[1] and iter_44_61.unique[2] == iter_44_59.unique[2] then
						var_44_121 = false
					end
				end

				if iter_44_59.unique and iter_44_59.unique[1] == 0 then
					var_44_121 = true
				end

				local var_44_122 = #arg_44_2:get_attribute().skill_num.change_attr_by_stage

				if var_44_121 and iter_44_59.shipTypes then
					if var_0_7:have_data(iter_44_59.shipTypes, arg_44_2:get_ship_type()) then
						arg_44_2:get_attribute().skill_num.change_attr_by_stage[var_44_122 + 1] = {
							attr_type = iter_44_59.attr_type,
							attr_num = iter_44_59.attr_num,
							effect_stage = iter_44_59.effect_stage,
							unique = iter_44_59.unique,
							percent = iter_44_59.percent
						}
					end
				elseif var_44_121 and iter_44_59.shipTons and var_0_7:have_data(iter_44_59.shipTons, arg_44_2:get_ship_ton()) then
					arg_44_2:get_attribute().skill_num.change_attr_by_stage[var_44_122 + 1] = {
						attr_type = iter_44_59.attr_type,
						attr_num = iter_44_59.attr_num,
						effect_stage = iter_44_59.effect_stage,
						unique = iter_44_59.unique,
						percent = iter_44_59.percent
					}
				end
			end
		end

		if self._battle_scene:get_abyss_add_damage_by_flag_data() then
			for iter_44_62, iter_44_63 in pairs((self._battle_scene:get_abyss_add_damage_by_flag_data())) do
				for iter_44_64, iter_44_65 in pairs(iter_44_63.ship_list) do
					if iter_44_65 == arg_44_1:getID() and arg_44_2:is_flag() == iter_44_63.is_flag then
						self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage * (1 + iter_44_63.num))

						local var_44_123 = arg_44_2:get_attribute().now_hp:get_final_value()

						if var_44_0 then
							local var_44_124 = arg_44_2:get_attribute().now_hp:reduction_to_next_value()
						end

						local var_44_125 = arg_44_2:get_attribute().now_hp:get_final_value() - self._damage_attr.damage

						var_44_125 = var_44_125 < 0 and 0 or var_44_125

						arg_44_2:get_attribute().now_hp:modify_to_value(var_44_125)
						self:set_damage_record("触发深海buff:攻击旗舰（或非旗舰），伤害增加:", iter_44_63.num .. "%")
					end
				end
			end
		end

		if arg_44_2:get_attribute().after_lost_hp_by_percent_immune_by_num then
			arg_44_2:get_attribute().skill_num = arg_44_2:get_attribute().skill_num or {}
			arg_44_2:get_attribute().skill_num.now_lost_hp = arg_44_2:get_attribute().skill_num.now_lost_hp or 0

			if arg_44_2:get_attribute().skill_num.now_lost_hp / arg_44_2:get_attribute().hp:get_final_value() < arg_44_2:get_attribute().after_lost_hp_by_percent_immune_by_num.hp then
				if (arg_44_2:get_attribute().skill_num.now_lost_hp + self._damage_attr.damage) / arg_44_2:get_attribute().hp:get_final_value() >= arg_44_2:get_attribute().after_lost_hp_by_percent_immune_by_num.hp then
					arg_44_2:get_attribute().skill_num._is_immune_to_first_damage = 1 + arg_44_2:get_attribute().after_lost_hp_by_percent_immune_by_num.num
					arg_44_2:get_attribute().skill_num._is_immune_to_first_damage_stage = {
						0
					}

					self:set_damage_record("一场战斗中累积受到最大生命值x%的伤害后，免疫一次伤害:", "下次伤害免疫")
				end
			end

			arg_44_2:get_attribute().skill_num.now_lost_hp = arg_44_2:get_attribute().skill_num.now_lost_hp + self._damage_attr.damage
		end

		if not self._damage_attr.is_miss and self._damage_attr.damage_type ~= var_0_5.damage_type.miss then
			self:__set_tactics_addition_effect(arg_44_1, arg_44_2, var_0_5.obj_side.player)
			self:__set_tactics_addition_effect(arg_44_1, arg_44_2, var_0_5.obj_side.enemy)
		end

		if self:__get_probability_result(arg_44_2, 34) then
			local var_44_126 = arg_44_2:get_reduce_damage_to_value()

			if var_0_3(var_44_126) then
				if arg_44_2:get_attribute().now_hp:get_final_value() >= 0 and self._damage_attr.damage > var_44_126.value1 then
					self._damage_attr.damage = var_44_126.value2
					self._damage_attr.is_immune = true

					local var_44_127 = arg_44_2:get_attribute().now_hp:reduction_to_next_value()

					self:set_damage_record("技能减伤", var_0_4("将单次受到高于%s点的伤害降低为%s点伤害 伤害=%d", var_44_126.value1, var_44_126.value2, var_44_126.value2))

					local var_44_128 = arg_44_2:get_attribute().now_hp:get_final_value() - var_44_126.value2

					if var_44_128 < 0 then
						var_44_128 = 0
					end

					arg_44_2:get_attribute().now_hp:modify_to_value(var_44_128)
				end
			end
		end

		local var_44_129 = arg_44_2:get_attribute()

		self._damage_attr.damage = self:__damage_protection(self._damage_attr.damage, arg_44_2)

		arg_44_1:set_total_damage(self._damage_attr.damage)

		if arg_44_2:get_side() == var_0_5.obj_side.enemy and arg_44_2:is_flag() then
			self._damage_attr.boss_info = {}

			local var_44_130 = var_44_129.now_hp:get_final_value()

			self._battle_scene:update_boss_hp(var_0_2.abs(var_44_129.now_hp:get_next_value() - var_44_130), arg_44_2:getID(), var_44_130)

			self._damage_attr.boss_info = var_0_1.clone_table(self._battle_scene:get_boss_info())
		end

		for iter_44_66, iter_44_67 in pairs((self._battle_obj_mgr:get_sea_ships_by_side(arg_44_1:get_side()))) do
			iter_44_67:get_attribute().skill_num = iter_44_67:get_attribute().skill_num or {}

			if iter_44_67:getID() ~= arg_44_1:getID() and var_44_129.now_hp:get_final_value() > 0 and iter_44_67:get_is_alive() and iter_44_67:get_attribute().skill_num.can_not_shout_and_shout_with_teammate_save_list and iter_44_67:get_attribute().skill_num.can_not_shout_and_shout_with_teammate then
				iter_44_67:get_attribute().skill_num.can_not_shout_and_shout_with_teammate.can_shout = true

				table.insert(iter_44_67:get_attribute().skill_num.can_not_shout_and_shout_with_teammate_save_list.ship_list, arg_44_2)
			end
		end

		if arg_44_2:get_attribute().skill_num.immune_to_once_fatal_injury then
			if arg_44_2:get_attribute().now_hp:get_final_value() == 0 then
				local var_44_132 = false

				if not arg_44_2:get_attribute().skill_num.immune_to_once_fatal_injury.stage then
					self._damage_attr.is_immune = true
					var_44_132 = true
					arg_44_2:get_attribute().skill_num.immune_to_once_fatal_injury.stage = self._battlefield._battle_step
				else
					if arg_44_2:get_attribute().skill_num.immune_to_once_fatal_injury.stage == self._battlefield._battle_step then
						var_44_132 = true
					end

					if arg_44_2:get_attribute().skill_num.immune_to_once_fatal_injury.stage == var_0_5.trigger_type.first_normal_attack or arg_44_2:get_attribute().skill_num.immune_to_once_fatal_injury.stage == var_0_5.trigger_type.second_normal_attack or arg_44_2:get_attribute().skill_num.immune_to_once_fatal_injury.stage == var_0_5.trigger_type.night_war then
						var_44_132 = false
					end
				end

				if var_44_132 then
					local var_44_133 = arg_44_2:get_attribute().now_hp:get_final_value()

					if var_44_0 then
						var_44_133 = arg_44_2:get_attribute().now_hp:reduction_to_next_value()
					end

					local var_44_134 = arg_44_2:get_attribute().skill_num.immune_to_once_fatal_injury.num
					local var_44_135 = var_44_133 - self._damage_attr.damage

					var_44_135 = var_44_133 - self._damage_attr.damage < var_44_134 and var_44_134 or var_44_135
					self._damage_attr.damage = var_0_2.ceil(arg_44_2:get_attribute().now_hp:get_final_value() - var_44_135)
					self._damage_attr.damage = self._damage_attr.damage < 0 and 0 or self._damage_attr.damage

					if self._damage_attr.damage == 0 then
						self._damage_attr.damage_type = var_0_5.damage_type.normal
					end

					arg_44_2:get_attribute().now_hp:modify_to_value(var_44_134)
					self:set_damage_record("血量本阶段不会降到xx以下（炮击阶段与夜战只会抵挡一次攻击）", "血量不会降到" .. arg_44_2:get_attribute().skill_num.immune_to_once_fatal_injury.num .. "以下")
				end
			end
		end

		if self._damage_attr.syncytium_skill then
			local var_44_136 = arg_44_1:get_attribute().couple_by_shipcid

			if var_44_136 then
				arg_44_2:get_attribute().skill_num.change_attr_by_stage = arg_44_2:get_attribute().skill_num.change_attr_by_stage or {}

				local var_44_137 = false

				for iter_44_68, iter_44_69 in ipairs(arg_44_2:get_attribute().skill_num.change_attr_by_stage) do
					if iter_44_69.is_syncytium_skill and iter_44_69.is_syncytium_skill == true then
						var_44_137 = true
					end
				end

				if not var_44_137 then
					table.insert(arg_44_2:get_attribute().skill_num.change_attr_by_stage, {
						is_syncytium_skill = true,
						attr_type = var_44_136.attr_type,
						attr_num = var_44_136.attr_num,
						effect_stage = var_44_136.effect_stage
					})
				end
			end
		end

		if self._battlefield._battle_step ~= var_0_5.trigger_type.air_attack and var_44_129.now_hp:get_final_value() <= 0 and not self._is_beat_back then
			arg_44_1:get_attribute().can_one_more_attack = true
		end

		if var_44_129.now_hp:get_final_value() <= 0 then
			if arg_44_1:get_side() == 1 and arg_44_2:is_flag() and not arg_44_2.skill_num.is_be_kill then
				self._battle_scene:set_kill_flag_ship_id(arg_44_1:get_character_id())

				arg_44_2.skill_num.is_be_kill = true
			end

			if not arg_44_2.skill_num.is_dead then
				arg_44_1:set_total_sink(1)
				arg_44_1:set_kill_npc(arg_44_2:get_cid())

				arg_44_2.skill_num.is_dead = true
			end
		end

		if not self._damage_attr.is_miss then
			arg_44_1:set_total_hit_count(1, self._battlefield._battle_step)

			if self._battlefield.is_test and self._damage_attr.is_crit then
				arg_44_1:set_total_crit(1)
			end
		end

		arg_44_2:get_attribute().is_full_damage = self._damage_attr.damage / (arg_44_2:get_attribute().now_hp:get_final_value() + self._damage_attr.damage)
	end

	function arg_1_0:set_only_fixed_damage_by_skill(arg_45_1, arg_45_2)
		if not arg_45_1 or not arg_45_2 then
			return
		end

		if arg_45_2:get_attribute().in_guardian then
			self._damage_attr.is_miss = false
		end

		if self._damage_attr.damage > 0 then
			-- block empty
		end

		if arg_45_1:get_side() == var_0_5.obj_side.player then
			self:set_damage_record("我方非替换攻击的固伤生效前的伤害", "伤害为:" .. self._damage_attr.damage)
		end

		if self:__get_probability_result(arg_45_1, 12) and arg_45_1:get_attribute().hit_by_other_demage then
			local var_45_3 = var_0_2.ceil(arg_45_2:get_attribute()[arg_45_1:get_attribute().hit_by_other_demage.attribute]:get_final_value() * arg_45_1:get_attribute().hit_by_other_demage.rate)

			self._damage_attr.damage = self._damage_attr.damage + var_45_3

			self:set_damage_record("触发技能:对目标造成目标XX属性XX%的额外固定伤害", "增加固定伤害" .. var_45_3)
		end

		if arg_45_1:get_attribute().add_fix_damage_by_index and arg_45_2:get_index() == arg_45_1:get_index() then
			self._damage_attr.damage = self._damage_attr.damage + arg_45_1:get_attribute().add_fix_damage_by_index.num

			self:set_damage_record("对相同位置目标单位，增加XX点固定伤害", "增加固定伤害!" .. arg_45_1:get_attribute().add_fix_damage_by_index.num)
		end

		if arg_45_1:get_attribute().hit_by_fixed_demage_attr_by_percent then
			local var_45_4 = 0

			for iter_45_0, iter_45_1 in pairs(arg_45_1:get_attribute().hit_by_fixed_demage_attr_by_percent) do
				local var_45_5 = arg_45_1:get_attribute()[iter_45_1.attribute_type]:get_final_value() * iter_45_1.rate

				if var_45_5 ~= 0 then
					self:set_damage_record("触发技能累加阶段:属性百分之%的额外固定伤害", iter_45_1.attribute_type .. "属性百分之" .. iter_45_1.rate * 100 .. "的额外固定伤害" .. var_45_5)
				end

				var_45_4 = var_45_4 + var_45_5
			end

			self:set_damage_record("触发技能累加后续:属性百分比的额外固定伤害", "所有属性加成的总额外固定伤害" .. var_45_4)

			local var_45_6 = var_0_2.ceil(var_45_4)

			self._damage_attr.damage = self._damage_attr.damage + var_45_6

			if var_45_6 ~= 0 then
				self:set_damage_record("触发技能累加后续:属性百分比的额外固定伤害", "当前伤害和属性加成的额外固定伤害加成后的总伤害" .. self._damage_attr.damage)
			end
		end

		if arg_45_1:get_attribute().hit_by_fixed_demage_by_ship_type then
			for iter_45_2, iter_45_3 in pairs(arg_45_1:get_attribute().hit_by_fixed_demage_by_ship_type) do
				local var_45_7

				if iter_45_3.data_type == "shipTypes" then
					var_45_7 = arg_45_2:get_ship_type()
				elseif iter_45_3.data_type == "shipTons" then
					var_45_7 = arg_45_2:get_ship_ton()
				elseif iter_45_3.data_type == "guardTypes" then
					var_45_7 = arg_45_2:get_ship_guard_type()
				end

				for iter_45_4, iter_45_5 in pairs(iter_45_3.data_num or {}) do
					if var_45_7 == iter_45_5 then
						self._damage_attr.damage = self._damage_attr.damage + iter_45_3.num

						self:set_damage_record("触发增加额外伤害技能:攻击XX舰种/大中小型船/主力护卫舰（数组）时，增加XX点固定伤害", "攻击XX舰种/大中小型船/主力护卫舰（数组）时，增加XX点固定伤害" .. iter_45_3.num)
					end
				end
			end
		end

		if arg_45_1:get_attribute().change_damage_greater_than_num_by_num then
			local var_45_8 = arg_45_1:get_attribute().change_damage_greater_than_num_by_num.attr_type
			local var_45_9 = arg_45_1:get_attribute().change_damage_greater_than_num_by_num.attr_num

			if var_45_9 <= arg_45_2:get_attribute()[var_45_8]:get_final_value() then
				self._damage_attr.damage = self._damage_attr.damage + arg_45_1:get_attribute().change_damage_greater_than_num_by_num.num

				self:set_damage_record("触发技能:攻击XX属性大于XX数值的目标时，额外固定伤害变化XX", "攻击" .. var_0_5:get_attr_name_cn(var_45_8) .. "属性大于" .. var_45_9 .. "数值的目标时，额外固定伤害变化" .. arg_45_1:get_attribute().change_damage_greater_than_num_by_num.num .. "加成伤害为" .. self._damage_attr.damage)
			end
		end

		if arg_45_1:get_side() == var_0_5.obj_side.player then
			self:set_damage_record("我方非替换攻击的加减增幅固伤生效后的伤害总值", "伤害为:" .. self._damage_attr.damage)
		else
			self:set_damage_record("我方非替换攻击的加减增幅固伤生效后的伤害总值", "伤害为:" .. self._damage_attr.damage)
		end
	end

	function arg_1_0:__set_target_fight_back_by_tactics_pencertage(arg_46_1)
		if var_0_7:judge_stage(var_0_5.trigger_type.normal_attack, self._battlefield._battle_step) then
			local var_46_0 = arg_46_1:get_carry_tactics_logic()

			if var_46_0 then
				var_46_0:on_tactics_func()

				if arg_46_1:get_attribute().fight_back_percentage then
					local var_46_1 = arg_46_1:get_attribute().fight_back_percentage.num

					if var_46_1 == var_0_5.tactics_const.rate_max then
						return true
					end

					if var_0_7:get_random_chance({
						var_46_1,
						100 - var_46_1
					}, self._battle_random) == arg_46_1:get_attribute().fight_back_percentage.num then
						return true
					end
				end
			end
		end

		return false
	end

	function arg_1_0:__process_unit_die(arg_47_1)
		if arg_47_1:get_side() == var_0_5.obj_side.player then
			self._battlefield:eventOnPlayerDie(arg_47_1:getID())
		else
			self._battlefield:eventOnEnemyDie(arg_47_1:getID())
		end
	end

	function arg_1_0.__set_target_attack_state(arg_48_0, arg_48_1, arg_48_2)
		arg_48_1:set_attack_count_by_target(1)

		if arg_48_1:get_attack_count_by_target() == 1 and not arg_48_1:get_some_target_attack_state() then
			arg_48_2:set_attack_state(false)
		end
	end

	function arg_1_0:__set_tactics_addition_effect(arg_49_1, arg_49_2, arg_49_3)
		local var_49_0
		local var_49_1
		local var_49_2

		if arg_49_3 == var_0_5.obj_side.player then
			var_49_0 = arg_49_1:get_side()
			var_49_1 = arg_49_1:get_carry_tactics_logic()
			var_49_2 = arg_49_1:is_triggered_counter()
		end

		if arg_49_3 == var_0_5.obj_side.enemy then
			var_49_1 = arg_49_2:get_carry_tactics_logic()
			var_49_2 = arg_49_2:is_triggered_counter()
			var_49_0 = arg_49_2:get_side()
		end

		if var_49_1 then
			local var_49_3 = self._damage_attr.damage > 0
			local var_49_4 = arg_49_1:getID()
			local var_49_5 = arg_49_2:getID()
			local var_49_6 = var_49_1:on_tactics_func(var_49_4, var_49_5, self._battlefield._battle_step, true, var_49_2)

			for iter_49_0, iter_49_1 in pairs(var_49_6.num) do
				if iter_49_0 == var_49_0 then
					var_49_1:on_tactics_func(var_49_4, var_49_5, self._battlefield._battle_step, false, var_49_2)

					self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage * (1 + iter_49_1))

					local var_49_7 = arg_49_2:get_attribute()
					local var_49_8 = arg_49_2:get_attribute().now_hp:get_final_value()
					local var_49_9 = ((var_49_3 or nil) and arg_49_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage

					var_49_9 = ((var_49_3 or nil) and arg_49_2:get_attribute().now_hp:reduction_to_next_value()) - self._damage_attr.damage < 0 and 0 or var_49_9

					arg_49_2:get_attribute().now_hp:modify_to_value(var_49_9)
					self:set_damage_record(arg_49_1:getID() .. "战术效果加成" .. iter_49_0, var_0_4("伤害前:%d, 伤害加成%f, 伤害后:%d", self._damage_attr.damage, iter_49_1, self._damage_attr.damage))

					self._damage_attr.tactics_id = var_49_6.tactic_id[var_49_0]
				end
			end
		end
	end

	function arg_1_0:__ignore_tactics_by_map()
		local var_50_0 = self._battle_scene:get_map_id()
		local var_50_1 = self._battle_scene:get_battle_point()
		local var_50_2 = false
		local var_50_3 = var_0_8(var_0_9(var_50_1), 1, 3)
		local var_50_4 = var_0_8(var_0_9(var_50_1), 1, 4)

		if self._battle_scene:get_fight_type() == var_0_5.fight_type.main then
			for iter_50_0, iter_50_1 in pairs(var_0_5.ignore_tactics_maps) do
				if var_50_3 == iter_50_1 then
					var_50_2 = true
				end
			end
		end

		if self._battle_scene:get_fight_type() == var_0_5.fight_type.seventh then
			local var_50_6 = var_0_12.find_object_by_id(var_50_0)

			if var_50_6 then
				return var_50_6.difficulty == 0
			end
		end

		if self._battle_scene:get_fight_type() == var_0_5.fight_type.eighth then
			local var_50_7 = var_0_13.find_object_by_id(var_50_0)

			if var_50_7 then
				return var_50_7.difficulty == 0
			end
		end

		if not var_50_1 then
			return true
		end

		if var_50_1 >= 953601 and var_50_1 <= 953919 then
			return true
		end

		for iter_50_2, iter_50_3 in pairs(var_0_5.ignore_tactics_battle_point) do
			if var_50_4 == iter_50_3 then
				var_50_2 = true
			end
		end

		if self._battle_scene:get_fight_type() == var_0_5.fight_type.score then
			local var_50_8 = var_0_8(var_0_9(var_50_1), 1, 5)

			for iter_50_4, iter_50_5 in pairs(var_0_5.ignore_tactics_score_maps) do
				if var_50_8 == iter_50_5 then
					var_50_2 = true
				end
			end
		end

		if self._battle_scene:get_fight_type() == var_0_5.fight_type.ninth then
			local var_50_9 = var_0_8(var_0_9(var_50_1), 1, 5)

			for iter_50_6, iter_50_7 in pairs(var_0_5.ignore_tactics_ninth_maps) do
				if var_50_9 == iter_50_7 then
					var_50_2 = true
				end
			end
		end

		if self._battle_scene:get_fight_type() == var_0_5.fight_type.campaign then
			return false
		end

		return var_50_2
	end

	function arg_1_0:__get_immune_state_by_tactics(arg_51_1, arg_51_2)
		if var_0_7:judge_stage(var_0_5.trigger_type.air_attack, self._battlefield._battle_step) or var_0_7:judge_stage(var_0_5.trigger_type.normal_attack, self._battlefield._battle_step) then
			local var_51_0 = arg_51_2:get_carry_tactics_logic()

			if var_51_0 then
				var_51_0:on_tactics_func(arg_51_1:getID(), arg_51_2:getID(), self._battlefield._battle_step, true)

				if arg_51_2:get_immune_by_tactics() then
					self._damage_attr.is_immune = false
					self._damage_attr.damage = 0
					self._damage_attr.is_miss = true
					self._damage_attr.is_crit = false
					self._damage_attr.damage_type = var_0_5.damage_type.miss
					self._damage_attr.tactics_id = arg_51_2:get_immune_by_tactics()

					if not self:__ignore_tactics_by_map() then
						arg_51_2:set_tactics_trigger_count(1, arg_51_2:get_immune_by_tactics())
					end

					self:set_damage_record("战术免疫", var_0_4("炮击战/航空战免疫 伤害=%d", self._damage_attr.damage))
				end
			end
		end
	end

	function arg_1_0:__reset_attribute(arg_52_1, arg_52_2)
		if not arg_52_1 or not arg_52_2 then
			return
		end

		if arg_52_1:get_attribute().change_attr_by_atk_type then
			for iter_52_0, iter_52_1 in pairs(arg_52_1:get_attribute().change_attr_by_atk_type) do
				if iter_52_1.change_value then
					for iter_52_2, iter_52_3 in pairs(iter_52_1.change_value) do
						arg_52_1:get_attribute()[iter_52_2]:modify_to_value(arg_52_1:get_attribute()[iter_52_2]:get_final_value() - iter_52_3)

						iter_52_1.change_value[iter_52_2] = nil
					end
				end
			end
		end

		if arg_52_2:get_attribute().change_attr_by_radom_by_attr then
			for iter_52_4, iter_52_5 in pairs(arg_52_2:get_attribute().change_attr_by_radom_by_attr) do
				if iter_52_5.change_value then
					arg_52_2:get_attribute()[iter_52_5.attr_type2]:modify_to_value(arg_52_2:get_attribute()[iter_52_5.attr_type2]:get_final_value() - iter_52_5.change_value)

					iter_52_5.change_value = nil
				end
			end
		end

		if arg_52_1:get_attribute().add_attr_by_num_bu_lost_hp then
			for iter_52_6, iter_52_7 in pairs(arg_52_1:get_attribute().add_attr_by_num_bu_lost_hp) do
				if iter_52_7.change_value then
					arg_52_1:get_attribute()[iter_52_7.attr_type]:modify_to_value(arg_52_1:get_attribute()[iter_52_7.attr_type]:get_final_value() - iter_52_7.change_value)

					iter_52_7.change_value = nil
				end
			end
		end

		if self._battle_scene:get_add_attr_by_ship_number_data() then
			local var_52_3 = self._battle_scene:get_add_attr_by_ship_number_data()

			for iter_52_8, iter_52_9 in pairs(var_52_3.ship_list) do
				if arg_52_1:getID() == iter_52_9 then
					arg_52_1:get_attribute()[var_52_3.attr_type]:modify_to_value(arg_52_1:get_attribute()[var_52_3.attr_type]:get_final_value() - var_52_3.num)
				end
			end
		end

		if arg_52_1:get_attribute().change_attr_by_hp and arg_52_1:get_attribute().change_attr_by_hp.change_value then
			local var_52_4 = arg_52_1:get_attribute().change_attr_by_hp.attr_type

			arg_52_1:get_attribute()[var_52_4]:modify_to_value(arg_52_1:get_attribute()[var_52_4]:get_final_value() - arg_52_1:get_attribute().change_attr_by_hp.change_value)

			arg_52_1:get_attribute().change_attr_by_hp.change_value = nil
		end

		if arg_52_1:get_attribute().add_attr_by_target_alive then
			for iter_52_10, iter_52_11 in pairs(arg_52_1:get_attribute().add_attr_by_target_alive) do
				if iter_52_11.change_value then
					arg_52_1:get_attribute()[iter_52_10]:modify_to_value(arg_52_1:get_attribute()[iter_52_10]:get_final_value() - iter_52_11.change_value)

					iter_52_11.change_value = nil
				end
			end
		end

		if arg_52_2:get_attribute().skill_num and arg_52_2:get_attribute().skill_num.change_be_crit_rate_by_stage and arg_52_2:get_attribute().change_be_crit_rate_value and arg_52_2:get_attribute().change_be_crit_rate_value ~= 0 then
			arg_52_2:get_attribute().change_be_crit_rate = arg_52_2:get_attribute().change_be_crit_rate - arg_52_2:get_attribute().change_be_crit_rate_value
			arg_52_2:get_attribute().change_be_crit_rate_value = nil
		end

		if arg_52_2:get_attribute().change_attr_by_be_atk_type and var_0_3(arg_52_2:get_attribute().change_attr_by_be_atk_type) then
			for iter_52_12, iter_52_13 in pairs(arg_52_2:get_attribute().change_attr_by_be_atk_type) do
				local var_52_5

				for iter_52_14, iter_52_15 in pairs(iter_52_13.atktype) do
					if arg_52_1:get_atk_type() == iter_52_15 then
						var_52_5 = true
					end
				end

				if var_52_5 == true then
					if iter_52_13.percent then
						arg_52_2:get_attribute()[iter_52_13.attr_type]:modify_to_value(arg_52_2:get_attribute()[iter_52_13.attr_type]:get_final_value() - arg_52_2:get_attribute()[iter_52_13.attr_type]._next_value * iter_52_13.attr_num)
					else
						arg_52_2:get_attribute()[iter_52_13.attr_type]:modify_to_value(arg_52_2:get_attribute()[iter_52_13.attr_type]:get_final_value() - iter_52_13.attr_num)
					end
				end
			end
		end

		self:__reset_attribute_by_side(arg_52_1, 1, arg_52_2)
		self:__reset_attribute_by_side(arg_52_2, -1, arg_52_2)
		arg_52_1:reset_use_skill_add_attr()
		arg_52_2:reset_use_skill_add_attr()
	end

	function arg_1_0:__reset_attribute_by_side(arg_53_1, arg_53_2, arg_53_3)
		for iter_53_0, iter_53_1 in pairs((arg_53_1:get_use_skill_add_attr())) do
			if iter_53_1 == var_0_5.skill_add_attr_type.special_type_ship_add_attr then
				local var_53_1 = arg_53_1:get_special_type_ship_add_attr()

				if var_53_1 then
					var_0_7:modify_attr_value(arg_53_1, var_53_1.attr_type, -var_53_1.value)
				end
			elseif iter_53_1 == var_0_5.skill_add_attr_type.special_tons_ship_add_attr then
				local var_53_2 = arg_53_1:get_special_tons_ship_add_attr()

				if var_53_2 then
					var_0_7:modify_attr_value(arg_53_1, var_53_2.attr_type, -var_53_2.value)
				end
			elseif iter_53_1 == var_0_5.skill_add_attr_type.special_guard_ship_add_attr then
				local var_53_3 = arg_53_1:get_special_guard_ship_add_attr()

				if var_53_3 then
					var_0_7:modify_attr_value(arg_53_1, var_53_3.attr_type, -var_53_3.value)
				end
			elseif iter_53_1 == var_0_5.skill_add_attr_type.add_attr_contrast_target_data then
				local var_53_4 = arg_53_1:get_add_attr_contrast_target()

				if var_53_4 then
					var_0_7:modify_attr_value(arg_53_1, var_53_4.type, -var_53_4.value)
				end
			elseif iter_53_1 == var_0_5.skill_add_attr_type.add_attr_of_attacked_data_1 then
				local var_53_5 = arg_53_1:get_add_attr_with_attacked_1()

				if var_53_5 then
					var_0_7:modify_attr_value(arg_53_1, var_53_5.type, -var_53_5.value)
				end
			elseif iter_53_1 == var_0_5.skill_add_attr_type.add_attr_of_attacked_data_2 then
				local var_53_6 = arg_53_1:get_add_attr_with_attacked_2()

				if var_53_6 then
					var_0_7:modify_attr_value(arg_53_1, var_53_6.type, -var_53_6.value)
				end
			elseif iter_53_1 == var_0_5.skill_add_attr_type.add_attr_of_attacked_data_3 then
				local var_53_7 = arg_53_1:get_add_attr_with_attacked_3()

				if var_53_7 then
					var_0_7:modify_attr_value(arg_53_1, var_53_7.type, -var_53_7.value)
				end
			elseif iter_53_1 == var_0_5.skill_add_attr_type.add_attr_with_attr then
				local var_53_8 = arg_53_1:get_add_attr_with_attr()

				if var_53_8 then
					var_0_7:modify_attr_value(arg_53_1, var_53_8.type, -var_53_8.value)
				end
			elseif iter_53_1 == var_0_5.skill_add_attr_type.special_type_ship_target_add_attr then
				local var_53_9 = arg_53_1:get_special_type_ship_target_add_attr()

				if var_53_9 then
					if var_53_9.percent and var_53_9.attr_type ~= "crit_repair" then
						local var_53_10 = arg_53_3:get_attribute()

						if var_53_10.special_target_add_attr_before_attr_value then
							var_53_10[var_53_9.attr_type]:modify_to_value(var_53_10.special_target_add_attr_before_attr_value)
						end
					else
						var_0_7:modify_attr_value(arg_53_3, var_53_9.type, -var_53_9.value)
					end
				end
			elseif iter_53_1 == var_0_5.skill_add_attr_type.special_tons_ship_target_add_attr then
				local var_53_11 = arg_53_1:get_special_tons_ship_target_add_attr()

				if var_53_11 then
					if var_53_11.percent and var_53_11.attr_type ~= "crit_repair" then
						local var_53_12 = arg_53_3:get_attribute()

						if var_53_12.special_target_add_attr_before_attr_value then
							var_53_12[var_53_11.attr_type]:modify_to_value(var_53_12.special_target_add_attr_before_attr_value)
						end
					else
						var_0_7:modify_attr_value(arg_53_3, var_53_11.attr_type, -var_53_11.value)
					end
				end
			elseif iter_53_1 == var_0_5.skill_add_attr_type.special_guard_ship_target_add_attr then
				local var_53_13 = arg_53_1:get_special_guard_ship_target_add_attr()

				if var_53_13 then
					if var_53_13.percent and var_53_13.attr_type ~= "crit_repair" then
						local var_53_14 = arg_53_3:get_attribute()

						if var_53_14.special_target_add_attr_before_attr_value then
							var_53_14[var_53_13.attr_type]:modify_to_value(var_53_14.special_target_add_attr_before_attr_value)
						end
					else
						var_0_7:modify_attr_value(arg_53_3, var_53_13.attr_type, -var_53_13.value)
					end
				end
			end
		end

		if arg_53_1:get_attribute().skill_num.change_attr_by_stage and arg_53_1:get_attribute().skill_num.change_attr_by_stage then
			for iter_53_2, iter_53_3 in pairs(arg_53_1:get_attribute().skill_num.change_attr_by_stage) do
				if self:__get_attr_type_side(iter_53_3.attr_type) == arg_53_2 then
					for iter_53_4, iter_53_5 in pairs(iter_53_3.effect_stage) do
						if var_0_7:judge_stage(iter_53_5, self._battlefield._battle_step) then
							if iter_53_3.percent and arg_53_1:get_attribute().skill_num.change_attr_by_stage.attr_type ~= "crit_repair" then
								arg_53_1:get_attribute()[iter_53_3.attr_type]:modify_to_value(arg_53_1:get_attribute()[iter_53_3.attr_type]:get_final_value() * iter_53_3.attr_num)
							else
								local var_53_15 = iter_53_3.attr_type
								local var_53_16 = iter_53_3.attr_num

								if iter_53_3.attr_type == "crit_repair" then
									var_53_16 = var_53_16 * 100
								end

								arg_53_1:get_attribute()[var_53_15]:modify_to_value(arg_53_1:get_attribute()[var_53_15]:get_final_value() - var_53_16)
							end
						end
					end
				end
			end
		end

		if arg_53_1.skill_type_4 then
			for iter_53_6, iter_53_7 in pairs(arg_53_1.skill_type_4) do
				if iter_53_7.change_value then
					for iter_53_8, iter_53_9 in pairs(iter_53_7.change_value) do
						arg_53_1:get_attribute()[iter_53_8]:modify_to_value(arg_53_1:get_attribute()[iter_53_8]:get_final_value() - iter_53_9)

						iter_53_7.change_value[iter_53_8] = nil
					end
				end
			end
		end

		if arg_53_1.skill_type_5 then
			for iter_53_10, iter_53_11 in pairs(arg_53_1.skill_type_5) do
				if iter_53_11.change_value then
					for iter_53_12, iter_53_13 in pairs(iter_53_11.change_value) do
						arg_53_1:get_attribute()[iter_53_12]:modify_to_value(arg_53_1:get_attribute()[iter_53_12]:get_final_value() - iter_53_13)

						iter_53_11.change_value[iter_53_12] = nil
					end
				end
			end
		end
	end

	function arg_1_0:__set_enhance_damage_info(arg_54_1)
		if arg_54_1:get_side() == var_0_5.obj_side.player then
			local var_54_0, var_54_1 = self._battle_scene:get_adjutant_skill_buff()

			if var_54_0 then
				self:__set_buff_effect_cause_damage(var_54_1)
			end
		end
	end

	function arg_1_0:__set_buff_adjust_damage_effect(arg_55_1, arg_55_2)
		local var_55_0 = self._battle_scene:get_buffs_logic()

		if var_55_0 then
			local var_55_1 = var_55_0:on_main_fight_hit_buffs_func(arg_55_1, arg_55_2, self._battlefield._battle_step)

			if var_55_1 then
				self:__set_buff_effect_cause_damage(var_55_1)
			end
		end
	end

	function arg_1_0:__set_tower_buff_damage_effect(arg_56_1, arg_56_2)
		local var_56_0 = arg_56_1:get_side()
		local var_56_1 = self._battle_scene:get_hit_rate_enhance_data()

		if var_56_1 then
			for iter_56_0, iter_56_1 in pairs(var_56_1) do
				local var_56_2 = false

				for iter_56_2, iter_56_3 in pairs(iter_56_1.ship_list) do
					if arg_56_1:getID() == iter_56_3 then
						var_56_2 = true
					end
				end

				if var_56_2 and iter_56_1.stage_list and not iter_56_1.is_add then
					self:__on_func_excute_team_reduce_hit(iter_56_1)

					iter_56_1.is_add = true
				end
			end
		end

		local var_56_3 = self._battle_scene:get_hit_rate_reduce_data()

		if var_56_3 then
			for iter_56_4, iter_56_5 in pairs(var_56_3) do
				local var_56_4 = false

				for iter_56_6, iter_56_7 in pairs(iter_56_5.ship_list) do
					if arg_56_2:getID() == iter_56_7 then
						var_56_4 = true

						break
					end
				end

				if var_56_4 and iter_56_5.stage_list and not iter_56_5.is_add then
					self:__on_func_excute_team_reduce_hit(iter_56_5)

					iter_56_5.is_add = true
				end
			end
		end

		local var_56_5 = self._battle_scene:get_enemy_attack_hit_reduce_data()

		if var_56_5 and var_56_0 == var_0_5.obj_side.enemy then
			self:__on_func_excute_enemy_attack_hit_reduce(var_56_5, arg_56_1, arg_56_2)
		end

		local var_56_6 = self._battle_scene:get_team_reduce_hit_data()

		if var_56_6 and arg_56_2:get_side() == var_0_5.obj_side.player then
			self:__on_func_excute_team_reduce_hit(var_56_6)
		end

		local var_56_7 = self._battle_scene:get_team_all_reduce_hit_data()

		if var_56_7 and var_56_0 == var_0_5.obj_side.enemy then
			self:__set_buff_effect_cause_damage(var_56_7.hit_rate)
		end

		local var_56_8 = self._battle_scene:get_special_atk_as_zero()

		if var_56_8 and var_56_0 == var_0_5.obj_side.enemy and var_0_7:judge_ship(arg_56_2, var_56_8) then
			local var_56_9 = arg_56_1:get_atk_type()

			if var_56_9 == var_0_5.attack_round.aircraft or var_56_9 == var_0_5.attack_round.missile then
				self._damage_attr.damage = 0
				self._damage_attr.is_miss = true
				self._damage_attr.is_crit = true

				self:set_damage_record("技能加伤/减伤", var_0_4("受到的所有航空与导弹类伤害皆为0 伤害=%d", self._damage_attr.damage))
			end
		end

		local var_56_10 = self._battle_scene:get_add_extra_damage()

		if var_56_10 and var_56_0 == var_0_5.obj_side.player and var_0_7:judge_ship(arg_56_1, var_56_10) and var_0_7:judge_enemy_ship(arg_56_2, var_56_10) then
			self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage * (1 + var_56_10.num))

			self:set_damage_record("技能加伤/减伤", var_0_4("攻击敌方[参数E]舰种时造成额外伤害%.2f 伤害=%d", var_56_10.num, self._damage_attr.damage))
		end

		local var_56_11 = self._battle_scene:get_reduce_damage_with_special_enemy()

		if var_56_11 and var_56_0 == var_0_5.obj_side.enemy and var_0_7:judge_ship(arg_56_2, var_56_11) and var_0_7:judge_enemy_ship(arg_56_1, var_56_11) then
			self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage * (1 - var_56_11.num))

			self:set_damage_record("技能加伤/减伤", var_0_4("受到敌方[参数E]舰种的伤害减少%.2f 伤害=%d", var_56_11.num, self._damage_attr.damage))
		end

		local var_56_12 = self._battle_scene:get_reduce_damage_by_ship_type()

		if var_56_12 and var_56_0 == var_0_5.obj_side.enemy and var_0_7:judge_ship(arg_56_2, var_56_12) and var_0_7:judge_enemy_ship(arg_56_1, var_56_12) then
			self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage * (1 - var_56_12.num))

			self:set_damage_record("技能加伤/减伤", var_0_4("受到敌方[参数E]舰种的伤害减少%.2f 伤害=%d", var_56_12.num, self._damage_attr.damage))
		end
	end

	function arg_1_0:__on_func_excute_team_reduce_hit(arg_57_1)
		if tonumber(arg_57_1.stage_list) then
			if var_0_7:judge_stage(arg_57_1.stage_list, self._battlefield._battle_step) then
				self:__set_buff_effect_cause_damage(arg_57_1.hit_rate)
			end
		elseif arg_57_1.stage_list then
			for iter_57_0, iter_57_1 in pairs(arg_57_1.stage_list) do
				if var_0_7:judge_stage(iter_57_1, self._battlefield._battle_step) then
					self:__set_buff_effect_cause_damage(arg_57_1.hit_rate)

					break
				end
			end
		end
	end

	function arg_1_0:__on_func_excute_enemy_attack_hit_reduce(arg_58_1, arg_58_2, arg_58_3)
		if arg_58_1.enemy_ship_type then
			if tonumber(arg_58_1.enemy_ship_type) then
				if arg_58_2:get_ship_type() == arg_58_1.enemy_ship_type then
					self:__check_ship_list_data(arg_58_1, arg_58_3)
				end
			else
				for iter_58_0, iter_58_1 in pairs(arg_58_1.enemy_ship_type) do
					if arg_58_2:get_ship_type() == iter_58_1 then
						self:__check_ship_list_data(arg_58_1, arg_58_3)

						break
					end
				end
			end
		else
			self:__check_ship_list_data(arg_58_1, arg_58_3)
		end
	end

	function arg_1_0:__check_ship_list_data(arg_59_1, arg_59_2)
		if arg_59_1.ship_list then
			if tonumber(arg_59_1.ship_list) then
				if arg_59_2:getID() == arg_59_1.ship_list then
					self:__set_buff_effect_cause_damage(arg_59_1.hit_rate)
				end
			else
				local var_59_0 = false

				for iter_59_0, iter_59_1 in pairs(arg_59_1.ship_list) do
					if arg_59_2:getID() == iter_59_1 then
						var_59_0 = true

						break
					end
				end

				if var_59_0 then
					self:__set_buff_effect_cause_damage(arg_59_1.hit_rate)
				end
			end
		end
	end

	function arg_1_0:__set_buff_effect_cause_damage(arg_60_1)
		self._damage_attr.damage = var_0_2.ceil(self._damage_attr.damage * (1 + arg_60_1))

		self:set_damage_record("技能(深海buff)加伤/减伤(同类型效果可叠加，但战报只显示一次)", var_0_4("增加/减少%f伤害 伤害=%d", arg_60_1, self._damage_attr.damage))
	end

	function arg_1_0.__get_attr_type_side(arg_61_0, arg_61_1)
		if arg_61_1 == var_0_5.skil_attribute_type[2] or arg_61_1 == var_0_5.skil_attribute_type[4] or arg_61_1 == var_0_5.skil_attribute_type[9] or arg_61_1 == var_0_5.skil_attribute_type[10] or arg_61_1 == var_0_5.skil_attribute_type[11] or arg_61_1 == var_0_5.skil_attribute_type[12] or arg_61_1 == var_0_5.skil_attribute_type[13] or arg_61_1 == var_0_5.skil_attribute_type[14] or arg_61_1 == var_0_5.skil_attribute_type[16] or arg_61_1 == var_0_5.skil_attribute_type[17] then
			return 1
		end

		if arg_61_1 == var_0_5.skil_attribute_type[3] or arg_61_1 == var_0_5.skil_attribute_type[5] or arg_61_1 == var_0_5.skil_attribute_type[6] or arg_61_1 == var_0_5.skil_attribute_type[15] then
			return -1
		end

		return 0
	end

	function arg_1_0:add_passive_attr_by_perence(arg_62_1)
		if arg_62_1.skill_type_4 then
			for iter_62_0, iter_62_1 in pairs(arg_62_1.skill_type_4) do
				local var_62_0
				local var_62_1
				local var_62_2

				for iter_62_2, iter_62_3 in pairs(iter_62_1) do
					for iter_62_4, iter_62_5 in pairs(var_0_5.skil_attribute_type) do
						if iter_62_2 == iter_62_5 then
							var_62_0 = iter_62_2
							var_62_1 = iter_62_3

							break
						end
					end
				end

				if var_62_0 == "crit_repair" then
					var_62_2 = arg_62_1:get_attribute()[var_62_0]:get_final_value() + var_62_1 * ((not iter_62_1.multiple or nil) and 1)
					iter_62_1.change_value = iter_62_1.change_value or {}
					iter_62_1.change_value[var_62_0] = var_62_1 * (iter_62_1.multiple or 1)
				else
					var_62_2 = arg_62_1:get_attribute()[var_62_0]:get_final_value() * (1 + var_62_1 * ((not iter_62_1.multiple or nil) and 1))
					iter_62_1.change_value = iter_62_1.change_value or {}
					iter_62_1.change_value[var_62_0] = arg_62_1:get_attribute()[var_62_0]:get_final_value() * (var_62_1 * (iter_62_1.multiple or 1))
				end

				arg_62_1:get_attribute()[var_62_0]:modify_to_value(var_62_2)
				self:set_damage_record("被动技能4效果发动", var_0_4("%s修改为%s", var_0_5:get_attr_name_cn(var_62_0), var_62_2))
			end
		end

		if arg_62_1.skill_type_5 then
			for iter_62_6, iter_62_7 in pairs(arg_62_1.skill_type_5) do
				local var_62_7 = arg_62_1:get_attribute()[var_0_5.skil_attribute_type[iter_62_7.attribute2]]:get_final_value() + arg_62_1:get_attribute()[var_0_5.skil_attribute_type[iter_62_7.attribute]]:get_final_value() * iter_62_7.rate * (iter_62_7.multiple or 1)

				iter_62_7.change_value = iter_62_7.change_value or {}
				iter_62_7.change_value[var_0_5.skil_attribute_type[iter_62_7.attribute2]] = arg_62_1:get_attribute()[var_0_5.skil_attribute_type[iter_62_7.attribute]]:get_final_value() * iter_62_7.rate * (iter_62_7.multiple or 1)

				arg_62_1:get_attribute()[var_0_5.skil_attribute_type[iter_62_7.attribute2]]:modify_to_value(var_62_7)
				self:set_damage_record("被动技能5效果发动", var_0_4("%s修改为%s", var_0_5:get_attr_name_cn(var_0_5.skil_attribute_type[iter_62_7.attribute2]), var_62_7))
			end
		end
	end

	function arg_1_0.__get_probability_result(arg_63_0, arg_63_1, arg_63_2)
		local var_63_0 = false

		if arg_63_1:get_attribute().probability then
			var_63_0 = true

			if not arg_63_1:get_attribute().probability.determine then
				for iter_63_0, iter_63_1 in pairs(arg_63_1:get_attribute().probability.num) do
					if iter_63_1 == arg_63_2 then
						var_63_0 = false
					end
				end
			end
		end

		if not arg_63_1:get_attribute().probability or arg_63_1:get_attribute().probability.determine then
			var_63_0 = true

			if not arg_63_1:get_attribute().probability then
				var_63_0 = true
			else
				for iter_63_2, iter_63_3 in pairs(arg_63_1:get_attribute().probability.num) do
					if iter_63_3 == arg_63_2 then
						var_63_0 = arg_63_1:get_attribute().probability.determine
					end
				end
			end
		end

		return var_63_0
	end

	function arg_1_0.__get_self_probability(arg_64_0, arg_64_1, arg_64_2)
		if arg_64_1:get_attribute().ignore_rate_by_armor_in_special_ship then
			return true
		end

		return arg_64_2
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_65_0)
	local var_65_0 = var_0_1.class("damage_info")

	var_65_0._target_id = 0
	var_65_0._source_id = 0
	var_65_0._attack_info = nil
	var_65_0._battle_obj_mgr = nil
	var_65_0._battle_random = nil
	var_65_0._damage_attr = nil
	var_65_0._plane_type = nil
	var_65_0._torpedo = 0
	var_65_0._aircraft_atk = 0
	var_65_0._missile_atk = 0
	var_65_0._fly_num = 0
	var_65_0._damage_record = nil
	var_65_0.skill_replace_hit = false
	var_65_0._attack_type = nil
	var_65_0._is_full_hp_before_attack = false

	gamecore.extend_obj(var_65_0)

	return var_65_0
end

return var_0_0
