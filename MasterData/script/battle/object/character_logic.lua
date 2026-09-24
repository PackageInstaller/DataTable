local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = table.insert
local var_0_3 = gamecore.object_logic_base
local var_0_4 = gameenum.battle_type
local var_0_5 = gameconfig.monster_config
local var_0_6 = gameconfig.ship_config
local var_0_7 = gameconfig.equip_config

lx.define_class("character_logic", function(arg_1_0)
	function arg_1_0.set_is_alive(arg_2_0, arg_2_1)
		arg_2_0._is_alive = arg_2_1
	end

	function arg_1_0:get_is_alive()
		return self._is_alive
	end

	function arg_1_0.set_pos(arg_4_0, arg_4_1)
		arg_4_0._pos = arg_4_1
	end

	function arg_1_0:get_pos()
		return self._pos
	end

	function arg_1_0:is_flag()
		return self._index == 1
	end

	function arg_1_0:get_equip_list()
		return self._equip_list
	end

	function arg_1_0.set_index(arg_8_0, arg_8_1)
		arg_8_0._index = arg_8_1
		arg_8_0._normal_attack_order = arg_8_1

		if arg_8_1 == 5 then
			arg_8_0._normal_attack_order = 6
		end

		if arg_8_1 == 6 then
			arg_8_0._normal_attack_order = 5
		end
	end

	function arg_1_0:get_index()
		return self._index
	end

	function arg_1_0:get_normal_attack_order()
		return self._normal_attack_order
	end

	function arg_1_0.set_oil(arg_11_0, arg_11_1)
		arg_11_0._oil = arg_11_1
	end

	function arg_1_0:get_oil()
		return self._oil
	end

	function arg_1_0:get_max_oil()
		return self._max_oil
	end

	function arg_1_0.set_ammo(arg_14_0, arg_14_1)
		arg_14_0._ammo = arg_14_1
	end

	function arg_1_0:get_ammo()
		return self._ammo
	end

	function arg_1_0:get_max_ammo()
		return self._max_ammo
	end

	function arg_1_0:is_lowhp()
		return self._attribute.now_hp:get_final_value() / self._attribute.hp:get_final_value() < var_0_4.hp_ratio_type.lowhp
	end

	function arg_1_0:is_medhp()
		local var_18_0 = self._attribute.now_hp:get_final_value() / self._attribute.hp:get_final_value()

		return var_18_0 < var_0_4.hp_ratio_type.medhp and var_18_0 >= var_0_4.hp_ratio_type.lowhp
	end

	function arg_1_0:judge_is_lowhp(arg_19_1)
		return arg_19_1 / self._attribute.hp:get_final_value() < var_0_4.hp_ratio_type.lowhp
	end

	function arg_1_0:judge_is_medhp(arg_20_1)
		local var_20_0 = arg_20_1 / self._attribute.hp:get_final_value()

		return var_20_0 < var_0_4.hp_ratio_type.medhp and var_20_0 >= var_0_4.hp_ratio_type.lowhp
	end

	function arg_1_0:hp_more_than_half()
		return self._attribute.now_hp:get_final_value() / self._attribute.hp:get_final_value() >= var_0_4.hp_ratio_type.medhp
	end

	function arg_1_0:hp_more_than_quarter()
		return self._attribute.now_hp:get_final_value() / self._attribute.hp:get_final_value() >= var_0_4.hp_ratio_type.lowhp
	end

	function arg_1_0:lost_hp_perent()
		return 1 - self._attribute.now_hp:get_final_value() / self._attribute.hp:get_final_value()
	end

	function arg_1_0.set_cid(arg_24_0, arg_24_1)
		arg_24_0._cid = arg_24_1
	end

	function arg_1_0:get_cid()
		return self._cid
	end

	function arg_1_0.set_ship_name(arg_26_0, arg_26_1)
		arg_26_0._ship_name = arg_26_1
	end

	function arg_1_0:get_ship_name()
		return self._ship_name
	end

	function arg_1_0.set_love(arg_28_0, arg_28_1)
		arg_28_0._love = arg_28_1
	end

	function arg_1_0:get_love()
		return self._love
	end

	function arg_1_0.set_luck(arg_30_0, arg_30_1)
		arg_30_0._luck = arg_30_1
	end

	function arg_1_0:get_luck()
		return self._luck
	end

	function arg_1_0.set_level(arg_32_0, arg_32_1)
		arg_32_0._level = arg_32_1
	end

	function arg_1_0:get_level()
		return self._level
	end

	function arg_1_0:carry_plane()
		for iter_34_0, iter_34_1 in pairs(self._equip_list) do
			if iter_34_1:is_plane() then
				return true
			end
		end

		return false
	end

	function arg_1_0:carry_antisub_plane()
		for iter_35_0, iter_35_1 in pairs(self._equip_list) do
			if iter_35_1:is_bomber_torpedoplane_or_spyplane() and iter_35_1:get_equip_num() > 0 then
				return true
			end
		end

		return false
	end

	function arg_1_0:left_plane_num()
		local var_36_0 = 0

		for iter_36_0, iter_36_1 in pairs(self._equip_list) do
			var_36_0 = var_36_0 + iter_36_1:get_left_plane_num()
		end

		return var_36_0
	end

	function arg_1_0.set_ship_type(arg_37_0, arg_37_1)
		arg_37_0._ship_type = arg_37_1
	end

	function arg_1_0:get_ship_type()
		return self._ship_type
	end

	function arg_1_0.set_ship_ton(arg_39_0, arg_39_1)
		arg_39_0._ship_ton = arg_39_1
	end

	function arg_1_0:get_ship_ton()
		return self._ship_ton
	end

	function arg_1_0.set_country(arg_41_0, arg_41_1)
		arg_41_0._country = arg_41_1
	end

	function arg_1_0:get_country()
		return self._country
	end

	function arg_1_0:is_submarine()
		return self._ship_type == var_0_4.ship_type.submarine or self._ship_type == var_0_4.ship_type.submarine_strategic_carrier or self._ship_type == var_0_4.ship_type.heavy_bomb_submarine
	end

	function arg_1_0:can_launch_missile(arg_44_1)
		return self:equip_launcher(arg_44_1) and self:get_missile_num(arg_44_1) > 0
	end

	function arg_1_0:get_missile_num(arg_45_1)
		local var_45_0 = 0

		for iter_45_0, iter_45_1 in pairs(self._equip_list) do
			var_45_0 = arg_45_1 == "tmd" and var_45_0 + iter_45_1:get_tmd_missile_num() or var_45_0 + iter_45_1:get_missile_num()
		end

		return var_45_0
	end

	function arg_1_0:equip_launcher(arg_46_1)
		for iter_46_0, iter_46_1 in pairs(self._equip_list) do
			if arg_46_1 == "tmd" then
				if iter_46_1:equip_tmd_missile_launcher() then
					return true
				end
			elseif iter_46_1:equip_missile_launcher() then
				return true
			end
		end

		return false
	end

	function arg_1_0:get_ship_state()
		return (var_0_4:get_ship_state_by_value(self:get_character_attribute().now_hp:get_final_value(), (self:get_character_attribute().hp:get_final_value())))
	end

	function arg_1_0:get_attribute()
		return self._attribute
	end

	function arg_1_0.set_air_control_type(arg_49_0, arg_49_1)
		arg_49_0._air_control_type = arg_49_1
	end

	function arg_1_0:get_air_control_type()
		self._air_control_type = self._air_control_type or var_0_4.air_control_type.equl.value

		return self._air_control_type
	end

	function arg_1_0.set_night_attack_type(arg_51_0, arg_51_1)
		arg_51_0._night_attack_type = arg_51_1
	end

	function arg_1_0:get_night_attack_type()
		return self._night_attack_type
	end

	function arg_1_0.set_can_night_attack(arg_53_0, arg_53_1)
		arg_53_0._can_night_attack = arg_53_1
	end

	function arg_1_0:get_can_night_attack()
		return self._can_night_attack
	end

	function arg_1_0:have_bomber_or_torpedoplane()
		local var_55_0 = false

		for iter_55_0, iter_55_1 in pairs(self._equip_list) do
			if iter_55_1:is_bomber_or_torpedoplane() then
				var_55_0 = true
			end
		end

		return var_55_0
	end

	function arg_1_0:have_bomber_torpedoplane_or_spyplane()
		local var_56_0 = false

		for iter_56_0, iter_56_1 in pairs(self._equip_list) do
			if iter_56_1:is_bomber_torpedoplane_or_spyplane() then
				var_56_0 = true
			end
		end

		return var_56_0
	end

	function arg_1_0.set_pic_id(arg_57_0, arg_57_1)
		arg_57_0._pic_id = arg_57_1
	end

	function arg_1_0:get_pic_id()
		return self._pic_id
	end

	function arg_1_0:set_total_damage(arg_59_1)
		self._total_damage = self._total_damage + arg_59_1
	end

	function arg_1_0:get_total_damage()
		return self._total_damage
	end

	function arg_1_0:set_total_miss(arg_61_1)
		self._total_miss = self._total_miss + arg_61_1
	end

	function arg_1_0:get_total_miss()
		return self._total_miss
	end

	function arg_1_0:set_total_sink(arg_63_1)
		self._total_sink = self._total_sink + arg_63_1
	end

	function arg_1_0:get_total_sink()
		return self._total_sink
	end

	function arg_1_0:set_total_crit(arg_65_1)
		self._total_crit = self._total_crit + arg_65_1
	end

	function arg_1_0:get_total_crit()
		return self._total_crit
	end

	function arg_1_0:set_kill_npc(arg_67_1)
		if not arg_67_1 then
			return
		end

		self._kill_npc = self._kill_npc or {}

		var_0_2(self._kill_npc, arg_67_1)
	end

	function arg_1_0:get_kill_npc()
		return self._kill_npc
	end

	function arg_1_0.set_init_hp(arg_69_0, arg_69_1)
		arg_69_0._init_hp = arg_69_1
	end

	function arg_1_0:get_init_hp()
		return self._init_hp
	end

	function arg_1_0:get_now_hp()
		return self._attribute.now_hp:get_final_value()
	end

	function arg_1_0.set_character_id(arg_72_0, arg_72_1)
		arg_72_0._character_id = arg_72_1
	end

	function arg_1_0.set_reduce_hp(arg_73_0, arg_73_1)
		arg_73_0._reduce_hp = arg_73_1
	end

	function arg_1_0:get_reduce_hp(arg_74_1)
		return self._reduce_hp
	end

	function arg_1_0:get_character_id()
		return self._character_id
	end

	function arg_1_0.set_skin_id(arg_76_0, arg_76_1)
		arg_76_0._skin_id = arg_76_1 or 0
	end

	function arg_1_0:get_skin_id()
		return self._skin_id
	end

	function arg_1_0:get_equips_data()
		local var_78_0 = {}

		for iter_78_0, iter_78_1 in pairs(self._equip_list) do
			var_0_2(var_78_0, {
				carry_type = iter_78_1:get_carry_type(),
				id = iter_78_1:get_equip_cid(),
				num = iter_78_1:get_equip_num(),
				index = iter_78_1:get_index()
			})
		end

		return var_78_0
	end

	function arg_1_0:get_range()
		return self._attribute.range:get_final_value()
	end

	function arg_1_0:is_carry_fighter()
		local var_80_0 = false

		for iter_80_0, iter_80_1 in pairs(self._equip_list) do
			if iter_80_1:is_fighter() then
				var_80_0 = true
			end
		end

		return var_80_0
	end

	function arg_1_0.set_is_ignore_damage_protect(arg_81_0, arg_81_1)
		arg_81_0._ignore_damage_protect = arg_81_1
	end

	function arg_1_0:is_ignore_damage_protect()
		if self._battle_scene:get_fight_type() == var_0_4.fight_type.maneuver then
			return true
		end

		return self._ignore_damage_protect
	end

	function arg_1_0.set_skill(arg_83_0, arg_83_1)
		arg_83_0._skill_id = arg_83_1
	end

	function arg_1_0:get_skill()
		return self._skill_id
	end

	function arg_1_0.set_now_satge_skill(arg_85_0, arg_85_1)
		arg_85_0._now_satge_skill = arg_85_1
	end

	function arg_1_0:get_now_satge_skill()
		return self._now_satge_skill
	end

	function arg_1_0:get_tactics()
		return self._tactics
	end

	function arg_1_0.set_tactics(arg_88_0, arg_88_1)
		arg_88_0._tactics = arg_88_1
	end

	function arg_1_0:get_learning_tactic()
		return self._learning_tactic
	end

	function arg_1_0.set_learning_tactic(arg_90_0, arg_90_1)
		arg_90_0._learning_tactic = arg_90_1
	end

	function arg_1_0:get_skill_target()
		if self._target then
			if self._target._is_alive then
				return self._target
			else
				return nil
			end
		else
			return nil
		end
	end

	function arg_1_0.set_skill_target(arg_92_0, arg_92_1)
		arg_92_0._target = arg_92_1
	end

	function arg_1_0.set_battle_damage_state(arg_93_0, arg_93_1)
		arg_93_0._is_ignore_battle_damage = arg_93_1
	end

	function arg_1_0:get_battle_damage_state()
		return self._is_ignore_battle_damage
	end

	function arg_1_0.set_reduce_damage(arg_95_0, arg_95_1)
		arg_95_0._reduce_damage_value = arg_95_1
	end

	function arg_1_0:get_reduce_damage()
		return self._reduce_damage_value
	end

	function arg_1_0.set_reduce_loss(arg_97_0, arg_97_1)
		arg_97_0._reduce_loss_value = arg_97_1
	end

	function arg_1_0:get_reduce_loss()
		return self._reduce_loss_value
	end

	function arg_1_0:set_immune_to_fatal_injury_state(arg_99_1)
		self.skill_num = self.skill_num or {}

		if self.skill_num._is_immune_to_fatal_injury == nil or self.skill_num._is_immune_to_fatal_injury then
			self.skill_num._is_immune_to_fatal_injury = arg_99_1
		end
	end

	function arg_1_0:get_immune_to_fatal_injury_state()
		self.skill_num = self.skill_num or {}

		return self.skill_num._is_immune_to_fatal_injury
	end

	function arg_1_0:set_immune_num_of_special_atk(arg_101_1, arg_101_2)
		self.skill_num = self.skill_num or {}
		self._immune_num_of_special_atk = {
			type = arg_101_1
		}

		if self.skill_num._immune_num_of_special_atk then
			return
		end

		self.skill_num._immune_num_of_special_atk = {
			count = arg_101_2
		}
	end

	function arg_1_0:get_immune_num_of_special_atk()
		self.skill_num = self.skill_num or {}

		return self._immune_num_of_special_atk
	end

	function arg_1_0:set_reduce_percentage_of_damage(arg_103_1, arg_103_2)
		self.skill_num = self.skill_num or {}
		self.skill_num._reduce_percentage_of_damage = {
			rate = arg_103_1,
			count = arg_103_2
		}
	end

	function arg_1_0:get_reduce_percentage_of_damage()
		self.skill_num = self.skill_num or {}

		return self.skill_num._reduce_percentage_of_damage
	end

	function arg_1_0.set_ship_speed(arg_105_0, arg_105_1)
		arg_105_0._speed = arg_105_1
	end

	function arg_1_0:get_ship_speed()
		return self._speed
	end

	function arg_1_0.set_reduce_damage_to_value(arg_107_0, arg_107_1, arg_107_2)
		arg_107_0._reduce_damage_to_value = {
			value1 = arg_107_1,
			value2 = arg_107_2
		}
	end

	function arg_1_0:get_reduce_damage_to_value()
		return self._reduce_damage_to_value
	end

	function arg_1_0.set_ship_guard_type(arg_109_0, arg_109_1)
		arg_109_0._guard_type = arg_109_1
	end

	function arg_1_0:get_ship_guard_type()
		return self._guard_type
	end

	function arg_1_0.set_special_type_ship_target_add_attr(arg_111_0, arg_111_1, arg_111_2, arg_111_3, arg_111_4)
		arg_111_0._special_type_ship_target_add_attr = {
			shipTypes = arg_111_1,
			attr_type = arg_111_2,
			value = arg_111_3,
			percent = arg_111_4
		}
	end

	function arg_1_0:get_special_type_ship_target_add_attr()
		return self._special_type_ship_target_add_attr
	end

	function arg_1_0.set_special_tons_ship_target_add_attr(arg_113_0, arg_113_1, arg_113_2, arg_113_3, arg_113_4)
		arg_113_0._special_tons_ship_target_add_attr = {
			shipTons = arg_113_1,
			attr_type = arg_113_2,
			value = arg_113_3,
			percent = arg_113_4
		}
	end

	function arg_1_0:get_special_tons_ship_target_add_attr()
		return self._special_tons_ship_target_add_attr
	end

	function arg_1_0.set_special_guard_ship_target_add_attr(arg_115_0, arg_115_1, arg_115_2, arg_115_3, arg_115_4)
		arg_115_0._special_guard_ship_target_add_attr = {
			guardTypes = arg_115_1,
			attr_type = arg_115_2,
			value = arg_115_3,
			percent = arg_115_4
		}
	end

	function arg_1_0:get_special_guard_ship_target_add_attr()
		return self._special_guard_ship_target_add_attr
	end

	function arg_1_0.set_special_type_ship_add_attr(arg_117_0, arg_117_1, arg_117_2, arg_117_3, arg_117_4)
		arg_117_0._special_type_ship_add_attr = {
			shipTypes = arg_117_1,
			attr_type = arg_117_2,
			value = arg_117_3,
			percent = arg_117_4
		}
	end

	function arg_1_0:get_special_type_ship_add_attr()
		return self._special_type_ship_add_attr
	end

	function arg_1_0.set_alltypes_ignore_damaged(arg_119_0, arg_119_1, arg_119_2)
		arg_119_0._special_all_type_ignore_damaged = {
			shipType = arg_119_1,
			typeNum = arg_119_2
		}
	end

	function arg_1_0:get_alltypes_ignore_damaged()
		return self._special_all_type_ignore_damaged
	end

	function arg_1_0.set_special_tons_ship_add_attr(arg_121_0, arg_121_1, arg_121_2, arg_121_3, arg_121_4)
		arg_121_0._special_tons_ship_add_attr = {
			shipTons = arg_121_1,
			attr_type = arg_121_2,
			value = arg_121_3,
			percent = arg_121_4
		}
	end

	function arg_1_0:get_special_tons_ship_add_attr()
		return self._special_tons_ship_add_attr
	end

	function arg_1_0.set_special_guard_ship_add_attr(arg_123_0, arg_123_1, arg_123_2, arg_123_3, arg_123_4)
		arg_123_0._special_guard_ship_add_attr = {
			guardTypes = arg_123_1,
			attr_type = arg_123_2,
			value = arg_123_3,
			percent = arg_123_4
		}
	end

	function arg_1_0:get_special_guard_ship_add_attr()
		return self._special_guard_ship_add_attr
	end

	function arg_1_0.set_add_attr_contrast_target(arg_125_0, arg_125_1, arg_125_2, arg_125_3, arg_125_4)
		arg_125_0._add_attr_contrast_target_data = {
			index = arg_125_1,
			type = arg_125_2,
			value = arg_125_3,
			percent = arg_125_4
		}
	end

	function arg_1_0:get_add_attr_contrast_target()
		return self._add_attr_contrast_target_data
	end

	function arg_1_0.set_add_attr_with_attr(arg_127_0, arg_127_1, arg_127_2, arg_127_3, arg_127_4)
		arg_127_0._add_attr_with_attr = {
			index = arg_127_1,
			type = arg_127_2,
			value = arg_127_3,
			percent = arg_127_4
		}
	end

	function arg_1_0:get_add_attr_with_attr()
		return self._add_attr_with_attr
	end

	function arg_1_0.set_add_attr_with_attacked_1(arg_129_0, arg_129_1, arg_129_2, arg_129_3)
		arg_129_0._add_attr_of_attacked_data_1 = {
			atkType = arg_129_1,
			type = arg_129_2,
			value = arg_129_3
		}
	end

	function arg_1_0:get_add_attr_with_attacked_1()
		return self._add_attr_of_attacked_data_1
	end

	function arg_1_0.set_atk_type(arg_131_0, arg_131_1)
		arg_131_0._atk_type = arg_131_1
	end

	function arg_1_0:get_atk_type()
		return self._atk_type
	end

	function arg_1_0.set_add_attr_with_attacked_2(arg_133_0, arg_133_1, arg_133_2, arg_133_3)
		arg_133_0._add_attr_of_attacked_data_2 = {
			shipTypes = arg_133_1,
			type = arg_133_2,
			value = arg_133_3
		}
	end

	function arg_1_0:get_add_attr_with_attacked_2()
		return self._add_attr_of_attacked_data_2
	end

	function arg_1_0.set_add_attr_with_attacked_3(arg_135_0, arg_135_1, arg_135_2, arg_135_3)
		arg_135_0._add_attr_of_attacked_data_3 = {
			shipTons = arg_135_1,
			type = arg_135_2,
			value = arg_135_3
		}
	end

	function arg_1_0:get_add_attr_with_attacked_3()
		return self._add_attr_of_attacked_data_3
	end

	function arg_1_0.set_damage_with_ship_type(arg_137_0, arg_137_1, arg_137_2)
		arg_137_0._damage_with_ship_type_data = {
			shipTypes = arg_137_1,
			rate = arg_137_2
		}
	end

	function arg_1_0:get_damage_with_ship_type()
		return self._damage_with_ship_type_data
	end

	function arg_1_0.set_damage_with_ship_ton(arg_139_0, arg_139_1, arg_139_2)
		arg_139_0._damage_with_ship_ton_data = {
			shipTons = arg_139_1,
			rate = arg_139_2
		}
	end

	function arg_1_0:get_damage_with_ship_ton()
		return self._damage_with_ship_ton_data
	end

	function arg_1_0:get_use_skill_add_attr()
		self.skill_num = self.skill_num or {}
		self.skill_num._temp_skill_add_attr = self.skill_num._temp_skill_add_attr or {}

		return self.skill_num._temp_skill_add_attr
	end

	function arg_1_0:reset_use_skill_add_attr()
		self.skill_num = self.skill_num or {}
		self.skill_num._temp_skill_add_attr = {}
	end

	function arg_1_0:set_use_skill_add_attr(arg_143_1, arg_143_2)
		self.skill_num = self.skill_num or {}
		self.skill_num._temp_skill_add_attr = self.skill_num._temp_skill_add_attr or {}

		if not self:judge_use_skill_add_attr(arg_143_1) then
			var_0_2(self.skill_num._temp_skill_add_attr, arg_143_1)
		end
	end

	function arg_1_0:judge_use_skill_add_attr(arg_144_1)
		local var_144_0 = false

		self.skill_num = self.skill_num or {}
		self.skill_num._temp_skill_add_attr = self.skill_num._temp_skill_add_attr or {}

		for iter_144_0, iter_144_1 in pairs(self.skill_num._temp_skill_add_attr) do
			if arg_144_1 == iter_144_1 then
				var_144_0 = true

				break
			end
		end

		return var_144_0
	end

	function arg_1_0.set_can_enter_normal_attack(arg_145_0, arg_145_1)
		arg_145_0._can_enter_normal_attack = arg_145_1
	end

	function arg_1_0:get_can_enter_normal_attack()
		return self._can_enter_normal_attack
	end

	function arg_1_0.set_normal_turn_to_torpedo(arg_147_0, arg_147_1)
		arg_147_0._can_normal_turn_to_torpedo = arg_147_1
	end

	function arg_1_0:get_normal_turn_to_torpedo()
		return self._can_normal_turn_to_torpedo
	end

	function arg_1_0:set_is_not_attack_for_type(arg_149_1)
		self.skill_num = self.skill_num or {}
		self.skill_num._is_not_attack_for_type = arg_149_1
	end

	function arg_1_0:get_is_not_attack_for_type()
		self.skill_num = self.skill_num or {}
		self.skill_num._is_not_attack_for_type = self.skill_num._is_not_attack_for_type or {}

		return self.skill_num._is_not_attack_for_type
	end

	function arg_1_0:set_attack_step_again_type(arg_151_1, arg_151_2)
		self.skill_num = self.skill_num or {}
		self.skill_num._attack_step_again_type = {
			step = arg_151_1,
			add_num = arg_151_2
		}
	end

	function arg_1_0:get_attack_step_again_type()
		self.skill_num = self.skill_num or {}
		self.skill_num._attack_step_again_type = self.skill_num._attack_step_again_type or {}

		return self.skill_num._attack_step_again_type
	end

	function arg_1_0.set_unlock_open_torpedo_attack(arg_153_0, arg_153_1)
		arg_153_0._is_unlock_open_torpedo_attack = arg_153_1
	end

	function arg_1_0:get_unlock_open_torpedo_attack()
		return self._is_unlock_open_torpedo_attack
	end

	function arg_1_0.set_back_hit_to_random_target_by_attr(arg_155_0, arg_155_1, arg_155_2)
		arg_155_0.back_hit_to_random_target_by_attr = {
			attr = arg_155_1,
			rate = arg_155_2
		}
	end

	function arg_1_0:get_back_hit_to_random_target_by_attr()
		return self.back_hit_to_random_target_by_attr
	end

	function arg_1_0:set_num_of_beat_back(arg_157_1, arg_157_2)
		self.skill_num = self.skill_num or {}
		self.skill_num._num_of_beat_back_data = {
			num = arg_157_1,
			hurt_rate = arg_157_2
		}
	end

	function arg_1_0:get_num_of_beat_back()
		self.skill_num = self.skill_num or {}

		return self.skill_num._num_of_beat_back_data
	end

	function arg_1_0:set_num_of_beat_back_wihtout_hp_state()
		self.skill_num = self.skill_num or {}
		self.skill_num._num_of_beat_back_wihtout_hp_state = {}
	end

	function arg_1_0:get_num_of_beat_back_wihtout_hp_state()
		self.skill_num = self.skill_num or {}

		return self.skill_num._num_of_beat_back_wihtout_hp_state
	end

	function arg_1_0:set_immune_to_once_damage_state(arg_161_1)
		self.skill_num = self.skill_num or {}
		self.skill_num._is_immune_to_once_damage = arg_161_1
	end

	function arg_1_0:get_immune_to_once_damage_state()
		self.skill_num = self.skill_num or {}

		return self.skill_num._is_immune_to_once_damage
	end

	function arg_1_0:set_total_attack(arg_163_1)
		self._total_attack = self._total_attack + arg_163_1
	end

	function arg_1_0:get_total_attack()
		return self._total_attack
	end

	function arg_1_0.set_fight_back_target(arg_165_0, arg_165_1)
		arg_165_0._fight_back_target = arg_165_1
	end

	function arg_1_0:get_fight_back_target()
		return self._fight_back_target
	end

	function arg_1_0.set_skill_effect_count(arg_167_0, arg_167_1)
		arg_167_0._skill_effect_count = arg_167_1
	end

	function arg_1_0:get_skill_effect_count()
		return self._skill_effect_count
	end

	function arg_1_0.set_multiple_attr_value(arg_169_0, arg_169_1)
		arg_169_0._multiple_attr_value = arg_169_1
	end

	function arg_1_0:get_multiple_attr_value()
		return self._multiple_attr_value
	end

	function arg_1_0:set_recover_life_state(arg_171_1, arg_171_2)
		self.skill_num = self.skill_num or {}
		self.skill_num._is_recover_life_once_damage = arg_171_1
		self.skill_num._recover_life_value = arg_171_2
	end

	function arg_1_0:get_recover_life_state()
		self.skill_num = self.skill_num or {}

		return self.skill_num._is_recover_life_once_damage, self.skill_num._recover_life_value
	end

	function arg_1_0:set_total_hit_count(arg_173_1, arg_173_2)
		self._total_hit_count[arg_173_2] = self._total_hit_count[arg_173_2] or 0
		self._total_hit_count[arg_173_2] = self._total_hit_count[arg_173_2] + arg_173_1
	end

	function arg_1_0:get_total_hit_count()
		return self._total_hit_count
	end

	function arg_1_0.reset_hit_count(arg_175_0)
		arg_175_0._total_hit_count = {}
	end

	function arg_1_0.set_ship_aircraft_loss(arg_176_0, arg_176_1)
		arg_176_0._loss_percentage = arg_176_1
	end

	function arg_1_0:get_ship_aircraft_loss(arg_177_1)
		return self._loss_percentage
	end

	function arg_1_0:set_ship_aircraft_add_hurt_info(arg_178_1)
		self._add_hurt_percentage = self._add_hurt_percentage or 0
		self._add_hurt_percentage = (1 + self._add_hurt_percentage) * (1 + arg_178_1) - 1
	end

	function arg_1_0:get_ship_aircraft_add_hurt_info()
		return self._add_hurt_percentage
	end

	function arg_1_0.set_ship_aircraft_hurt_state(arg_180_0, arg_180_1)
		arg_180_0._is_reduce_hurt = arg_180_1
	end

	function arg_1_0:get_ship_aircraft_hurt_state()
		return self._is_reduce_hurt
	end

	function arg_1_0.set_enemy_type(arg_182_0, arg_182_1)
		arg_182_0._enemy_type = arg_182_1
	end

	function arg_1_0:get_enemy_collection_data()
		return self._enemy_collection
	end

	function arg_1_0.set_enemy_collection_data(arg_184_0, arg_184_1)
		arg_184_0._enemy_collection = arg_184_1
	end

	function arg_1_0:get_enemy_type()
		return self._enemy_type
	end

	function arg_1_0:get_ship_cfg()
		local var_186_1 = var_0_6.find_object_by_cid(self._cid)

		if self._side == var_0_4.obj_side.enemy then
			if self._enemy_type == var_0_4.enemy_type.monster or self._enemy_type == var_0_4.enemy_type.robot then
				var_186_1 = var_0_5.find_object_by_id(self._cid)
			elseif self._enemy_type == var_0_4.enemy_type.player then
				var_186_1 = self._battle_scene:get_fight_type() == var_0_4.fight_type.plot_main and var_0_5.find_object_by_id(self._cid) or var_0_6.find_object_by_cid(self._cid)
			end
		end

		return var_186_1
	end

	function arg_1_0.set_attack_state(arg_187_0, arg_187_1)
		arg_187_0._is_attack = arg_187_1
	end

	function arg_1_0:get_attack_state()
		return self._is_attack
	end

	function arg_1_0.set_armor_through_percentage(arg_189_0, arg_189_1)
		arg_189_0._armor_through_percentage = arg_189_1
	end

	function arg_1_0:get_armor_through_percentage()
		return self._armor_through_percentage
	end

	function arg_1_0.set_some_target_attack_state(arg_191_0, arg_191_1)
		arg_191_0._target_is_attack = arg_191_1
	end

	function arg_1_0:get_some_target_attack_state()
		return self._target_is_attack
	end

	function arg_1_0.set_fight_target(arg_193_0, arg_193_1)
		arg_193_0._first_fight_target = arg_193_1
	end

	function arg_1_0:get_fight_target()
		return self._first_fight_target
	end

	function arg_1_0:set_tactics_trigger_count(arg_195_1, arg_195_2)
		self._record_tactics_count = self._record_tactics_count or {}
		self._record_tactics_count[arg_195_2] = self._record_tactics_count[arg_195_2] or 0
		self._record_tactics_count[arg_195_2] = self._record_tactics_count[arg_195_2] + arg_195_1
	end

	function arg_1_0:get_tactics_trigger_count()
		return self._record_tactics_count
	end

	function arg_1_0.reset_tactics_trigger_count(arg_197_0)
		arg_197_0._record_tactics_count = {}
	end

	function arg_1_0.set_attack_ropund_type(arg_198_0, arg_198_1)
		arg_198_0._round_type = arg_198_1
	end

	function arg_1_0:get_attack_ropund_type()
		return self._round_type
	end

	function arg_1_0.set_carry_tactics_logic(arg_200_0, arg_200_1)
		arg_200_0._tactics_logic = arg_200_1
	end

	function arg_1_0:get_carry_tactics_logic()
		return self._tactics_logic
	end

	function arg_1_0:trigger_counter_atk()
		self._tactics_logic._counter_triggered = true
	end

	function arg_1_0:is_triggered_counter()
		if self._tactics_logic and self._tactics_logic._counter_triggered then
			self._tactics_logic._counter_triggered = false

			return true
		end
	end

	function arg_1_0.set_immune_by_tactics(arg_204_0, arg_204_1)
		arg_204_0._is_immune_by_tactics = arg_204_1
	end

	function arg_1_0:get_immune_by_tactics()
		return self._is_immune_by_tactics
	end

	function arg_1_0:set_attach_rate(arg_206_1, arg_206_2)
		self._attach_rate = self._attach_rate or {}
		self._attach_rate[arg_206_2] = arg_206_1
	end

	function arg_1_0:get_attach_rate()
		return self._attach_rate
	end

	function arg_1_0:set_player_skill_buff(arg_208_1)
		var_0_2(self._player_skill_buff, arg_208_1)
	end

	function arg_1_0:get_player_skill_buff()
		return self._player_skill_buff
	end

	function arg_1_0:set_enemy_skill_buff(arg_210_1)
		var_0_2(self._enemy_skill_buff, arg_210_1)
	end

	function arg_1_0:get_enemy_skill_buff()
		return self._enemy_skill_buff
	end

	function arg_1_0:set_damage_of_beat_back(arg_212_1)
		self.skill_num = self.skill_num or {}
		self.skill_num._damage_of_beat_back_data = {
			damage = arg_212_1
		}
	end

	function arg_1_0:get_damage_of_beat_back()
		self.skill_num = self.skill_num or {}

		return self.skill_num._damage_of_beat_back_data
	end

	function arg_1_0.set_curr_carry_tactics_id(arg_214_0, arg_214_1)
		arg_214_0._carry_tactics_id = arg_214_1
	end

	function arg_1_0:get_curr_carry_tactics_id()
		if self._ignore_add_tactics_exp then
			return
		end

		return self._carry_tactics_id
	end

	function arg_1_0:is_guard_ship()
		return var_0_4:get_ship_is_guard(self._ship_type)
	end

	function arg_1_0:is_facilities()
		return self._ship_type == var_0_4.ship_type.fortress or self._ship_type == var_0_4.ship_type.airport or self._ship_type == var_0_4.ship_type.port
	end

	function arg_1_0.set_can_open_torpedo_attack(arg_218_0, arg_218_1)
		arg_218_0._can_open_torpedo_attack = arg_218_1
	end

	function arg_1_0:get_can_open_torpedo_attack()
		return self._can_open_torpedo_attack
	end

	function arg_1_0.set_ignore_miss(arg_220_0, arg_220_1)
		arg_220_0._ignore_miss = arg_220_1
	end

	function arg_1_0:get_ignore_miss()
		return self._ignore_miss
	end

	function arg_1_0.set_attack_ignore_state(arg_222_0, arg_222_1)
		arg_222_0._attack_ignore_state = arg_222_1
	end

	function arg_1_0:get_attack_ignore_state()
		return self._attack_ignore_state
	end

	function arg_1_0.set_ignore_add_tactics_exp(arg_224_0, arg_224_1)
		arg_224_0._ignore_add_tactics_exp = arg_224_1
	end

	function arg_1_0:get_ignore_add_tactics_exp()
		return self._ignore_add_tactics_exp
	end

	function arg_1_0:set_attack_count_by_target(arg_226_1)
		self._attack_target_count = self._attack_target_count + arg_226_1
	end

	function arg_1_0:get_attack_count_by_target()
		return self._attack_target_count
	end

	function arg_1_0:get_all_equips_aircraft_atk()
		local var_228_0 = 0

		for iter_228_0, iter_228_1 in pairs(self._equip_list) do
			if iter_228_1:get_equip_type() == var_0_4.equip_type.bomber or iter_228_1:get_equip_type() == var_0_4.equip_type.fighter then
				var_228_0 = var_228_0 + iter_228_1:get_equip_attribute("aircraft_atk")
			end
		end

		return var_228_0
	end

	function arg_1_0:get_all_antisub_equips_antisub()
		local var_229_0 = 0

		for iter_229_0, iter_229_1 in pairs(self._equip_list) do
			if iter_229_1:get_equip_type() == var_0_4.equip_type.anti_sub or iter_229_1:get_equip_second_type() == var_0_4.equip_type.anti_sub then
				var_229_0 = var_229_0 + iter_229_1:get_equip_attribute("antisub")
			end
		end

		return var_229_0
	end

	function arg_1_0:get_all_equips_antisub_except_antisub()
		local var_230_0 = 0

		for iter_230_0, iter_230_1 in pairs(self._equip_list) do
			local var_230_1 = iter_230_1:get_equip_second_type()

			if iter_230_1:get_equip_type() ~= var_0_4.equip_type.anti_sub and not var_230_1 and var_230_1 ~= var_0_4.equip_type.anti_sub then
				var_230_0 = var_230_0 + iter_230_1:get_equip_attribute("antisub")
			end
		end

		return var_230_0
	end

	function arg_1_0:get_all_equips_antisub()
		local var_231_0 = 0

		for iter_231_0, iter_231_1 in pairs(self._equip_list) do
			var_231_0 = var_231_0 + iter_231_1:get_equip_attribute("antisub")
		end

		return var_231_0
	end

	function arg_1_0:get_all_equip_air_def(arg_232_1)
		local var_232_0 = 0

		for iter_232_0, iter_232_1 in pairs(self._equip_list) do
			local var_232_1 = iter_232_1:get_equip_type()
			local var_232_2 = iter_232_1:get_equip_second_type()

			var_232_0 = arg_232_1 and var_232_0 + iter_232_1:get_equip_attribute("air_def") or var_232_0 + iter_232_1:get_equip_attribute("air_def") * iter_232_1:get_equip_air_def_rate()
		end

		return var_232_0
	end

	function arg_1_0:get_all_equip_attr_by_name(arg_233_1)
		local var_233_0 = 0

		for iter_233_0, iter_233_1 in pairs(self._equip_list) do
			var_233_0 = var_233_0 + iter_233_1:get_equip_attribute(arg_233_1)
		end

		return var_233_0
	end

	function arg_1_0.set_can_attack_if_middle_or_big_break(arg_234_0, arg_234_1)
		arg_234_0._can_attack_if_break = arg_234_1
	end

	function arg_1_0:get_can_attack_if_middle_or_big_break()
		if self._can_attack_if_break and not self:hp_more_than_half() then
			return false
		end

		return true
	end

	function arg_1_0:set_can_attack_in_broken(arg_236_1)
		self.skill_num = self.skill_num or {}
		self.skill_num.can_attack_in_broken = arg_236_1
	end

	function arg_1_0:get_can_attack_in_broken()
		self.skill_num = self.skill_num or {}

		return self:get_is_alive() and self:get_now_hp() > 0 and self.skill_num.can_attack_in_broken
	end

	function arg_1_0:have_ap_equip()
		local var_238_0 = 0

		for iter_238_0, iter_238_1 in pairs(self._equip_list) do
			local var_238_1 = var_0_7.find_object_by_cid(iter_238_1:get_equip_cid())

			for iter_238_2, iter_238_3 in pairs(var_238_1.effect) do
				if var_238_1.special_effect == var_0_4.equip_special_effect_type.ap then
					var_238_0 = var_238_0 < iter_238_3.value and iter_238_3.value or var_238_0

					return true, var_238_0
				end
			end
		end

		return false, 0
	end

	function arg_1_0.set_affect_power_by_state(arg_239_0, arg_239_1)
		arg_239_0._affect_power_by_state = arg_239_1
	end

	function arg_1_0:get_affect_power_by_state()
		return self._affect_power_by_state
	end

	function arg_1_0:set_normal_attack_ap(arg_241_1)
		self._normal_attack_ap = self._normal_attack_ap or 0
		self._normal_attack_ap = arg_241_1
	end

	function arg_1_0:get_normal_attack_ap()
		return self._normal_attack_ap or 0
	end

	function arg_1_0.set_add_attrs_when_night_attack(arg_243_0, arg_243_1)
		arg_243_0._add_attrs_night_atk = arg_243_1
	end

	function arg_1_0:get_add_attrs_when_night_attack()
		return self._add_attrs_night_atk
	end

	function arg_1_0:set_effect_tactics(arg_245_1)
		var_0_2(self._effect_tactics, arg_245_1)
	end

	function arg_1_0:get_effect_tactics()
		return self._effect_tactics
	end

	function arg_1_0.reset_attack_times_in_aircraft_attack(arg_247_0)
		arg_247_0._attacked_times_in_aircraft_attack = 0
	end

	function arg_1_0:set_attack_times_in_aircraft_attack()
		self._attacked_times_in_aircraft_attack = self._attacked_times_in_aircraft_attack + 1
	end

	function arg_1_0:get_attack_times_in_aircraft_attack()
		return self._attacked_times_in_aircraft_attack
	end

	function arg_1_0:get_max_air_def_correction()
		local var_250_0 = 0

		for iter_250_0, iter_250_1 in pairs(self._equip_list) do
			local var_250_1 = iter_250_1:get_air_def_correct()

			var_250_0 = var_250_1 < var_250_0 and var_250_0 or var_250_1
		end

		return var_250_0
	end
end, "object_logic_base")

function var_0_0.inherit(arg_251_0)
	local var_251_0 = var_0_1.class("character_logic", var_0_3:inherit())

	var_251_0._battle_event = var_0_4.battle_event_type.character
	var_251_0._cid = 0
	var_251_0._is_alive = true
	var_251_0._character_id = 0
	var_251_0._equip_list = nil
	var_251_0._ship_type = nil
	var_251_0._level = 0
	var_251_0._side = 0
	var_251_0._cookbuff_damage = 1
	var_251_0._total_damage = 0
	var_251_0._total_miss = 0
	var_251_0._total_sink = 0
	var_251_0._total_crit = 0
	var_251_0._skill_id = nil
	var_251_0._tactics = {}
	var_251_0._learning_tactic = 0
	var_251_0._target = nil
	var_251_0._is_ignore_battle_damage = nil
	var_251_0._reduce_damage_value = 0
	var_251_0._reduce_loss_value = 0
	var_251_0._is_immune_to_fatal_injury = nil
	var_251_0._is_immune_to_first_damage = nil
	var_251_0._immune_num_of_special_atk = nil
	var_251_0._reduce_percentage_of_damage = {}
	var_251_0._speed = nil
	var_251_0._reduce_damage_to_value = {}
	var_251_0._guard_type = 0
	var_251_0._add_attr_contrast_target_data = {}
	var_251_0._add_attr_of_attacked_data_1 = {}
	var_251_0._atk_type = 0
	var_251_0._add_attr_of_attacked_data_2 = {}
	var_251_0._add_attr_of_attacked_data_3 = {}
	var_251_0._damage_with_ship_type_data = {}
	var_251_0._damage_with_ship_ton_data = {}
	var_251_0._can_enter_normal_attack = nil
	var_251_0._can_normal_turn_to_torpedo = nil
	var_251_0._is_unlock_open_torpedo_attack = nil
	var_251_0._num_of_beat_back_data = {}
	var_251_0._is_immune_to_once_damage = nil
	var_251_0._total_attack = 0
	var_251_0._fight_back_target = nil
	var_251_0._skill_effect_count = -1
	var_251_0._multiple_attr_value = 1
	var_251_0._is_recover_life_once_damage = nil
	var_251_0._recover_life_value = 0
	var_251_0._is_immune_by_hurt = nil
	var_251_0._total_immune_value = 0
	var_251_0._is_reduce_hurt = true
	var_251_0._total_hit_count = {}
	var_251_0._enemy_type = 0
	var_251_0._is_attack = true
	var_251_0._armor_through_percentage = 0
	var_251_0._target_is_attack = true
	var_251_0._is_trigger_tactics = false
	var_251_0._record_tactics_count = 0
	var_251_0._tactics_ids_counts = {}
	var_251_0._round_type = 0
	var_251_0._attach_rate = {}
	var_251_0._first_fight_target = nil
	var_251_0._player_skill_buff = {}
	var_251_0._enemy_skill_buff = {}
	var_251_0._add_attr_with_attr = {}
	var_251_0._kill_npc = nil
	var_251_0._attack_target_count = 0
	var_251_0._add_hurt_percentage = nil
	var_251_0._reduce_hp = 0
	var_251_0._effect_tactics = {}
	var_251_0._init_hp = 0
	var_251_0._attacked_times_in_aircraft_attack = 0

	return var_251_0
end

return var_0_0
