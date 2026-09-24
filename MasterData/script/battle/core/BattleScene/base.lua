local var_0_0 = {}
local var_0_1 = table.insert
local var_0_2 = gameenum.battle_type
local var_0_3 = gamecore.battle_util
local var_0_4 = gameconfig.workshop_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.set_battle_point(arg_2_0, arg_2_1)
		arg_2_0._battle_point = arg_2_1
	end

	function arg_1_0:get_battle_point()
		return self._battle_point
	end

	function arg_1_0.set_fight_type(arg_4_0, arg_4_1)
		arg_4_0._fight_type = arg_4_1
	end

	function arg_1_0:get_fight_type()
		return self._fight_type
	end

	function arg_1_0:set_effect_tactics(arg_6_1)
		var_0_1(self._effect_tactics, arg_6_1)
	end

	function arg_1_0:get_effect_tactics()
		return self._effect_tactics
	end

	function arg_1_0:set_effect_skills(arg_8_1)
		var_0_1(self._skill_id, arg_8_1)
	end

	function arg_1_0:get_effect_skill()
		return self._skill_id
	end

	function arg_1_0.set_damage_control_num(arg_10_0, arg_10_1)
		arg_10_0._damage_control_num = arg_10_1 or 0
	end

	function arg_1_0:get_damage_control_num()
		return self._damage_control_num
	end

	function arg_1_0:set_damage_control_last_hp_num(arg_12_1, arg_12_2)
		self.damage_control_last_hp_num = self.damage_control_last_hp_num or {}

		table.insert(self.damage_control_last_hp_num, {
			last_hp = arg_12_1,
			id = arg_12_2
		})
	end

	function arg_1_0:get_damage_control_last_hp_num()
		return self.damage_control_last_hp_num
	end

	function arg_1_0.set_kill_flag_ship_id(arg_14_0, arg_14_1)
		arg_14_0.kill_flag_ship_id = arg_14_1 or 0
	end

	function arg_1_0:get_kill_flag_ship_id()
		return self.kill_flag_ship_id
	end

	function arg_1_0.set_radar_state(arg_16_0, arg_16_1)
		arg_16_0._radar_state = arg_16_1
	end

	function arg_1_0:get_radar_state()
		return self._radar_state
	end

	function arg_1_0.set_player_formation(arg_18_0, arg_18_1)
		arg_18_1 = arg_18_1 or var_0_2.formation_type.single
		arg_18_0._player_formation = arg_18_1
	end

	function arg_1_0:get_player_formation()
		return self._player_formation
	end

	function arg_1_0.set_enemy_formation(arg_20_0, arg_20_1)
		arg_20_1 = arg_20_1 or var_0_2.formation_type.single
		arg_20_0._enemy_formation = arg_20_1
	end

	function arg_1_0:get_enemy_formation()
		return self._enemy_formation
	end

	function arg_1_0.set_support_id(arg_22_0, arg_22_1)
		arg_22_0._support_id = arg_22_1
	end

	function arg_1_0:get_support_id()
		return self._support_id
	end

	function arg_1_0.set_player_course(arg_24_0, arg_24_1)
		arg_24_0._player_course = arg_24_1 or 1
	end

	function arg_1_0:get_player_course()
		return self._player_course
	end

	function arg_1_0.set_fix_player_course(arg_26_0, arg_26_1)
		arg_26_0._fix_player_course = arg_26_1 or 1
	end

	function arg_1_0:get_fix_player_course(arg_27_1)
		return self._fix_player_course
	end

	function arg_1_0.set_enemy_course(arg_28_0, arg_28_1)
		arg_28_0._enemy_course = arg_28_1 or 2
	end

	function arg_1_0:get_enemy_course()
		return self._enemy_course
	end

	function arg_1_0.set_day_or_night_attack(arg_30_0, arg_30_1)
		arg_30_0._day_or_night = arg_30_1 or var_0_2.day_or_night.day
	end

	function arg_1_0.set_is_night_attack(arg_31_0)
		arg_31_0._is_night = true
	end

	function arg_1_0:get_is_night_attack()
		return self._is_night
	end

	function arg_1_0:get_day_or_night_attack()
		return self._day_or_night
	end

	function arg_1_0.set_player_racingbuff(arg_34_0, arg_34_1)
		arg_34_0._player_racingbuff = arg_34_1
	end

	function arg_1_0:get_player_racingbuff()
		return self._player_racingbuff
	end

	function arg_1_0.set_player_cookbuff(arg_36_0, arg_36_1)
		arg_36_0._player_cookbuff = arg_36_1
	end

	function arg_1_0:get_player_cookbuff()
		return self._player_cookbuff
	end

	function arg_1_0.set_player_collectionbuff(arg_38_0, arg_38_1)
		arg_38_0._collectionbuff = arg_38_1
	end

	function arg_1_0:get_player_collectionbuff()
		return self._collectionbuff
	end

	function arg_1_0.set_enemy_collectionbuff(arg_40_0, arg_40_1)
		arg_40_0._enemy_collectionbuff = arg_40_1
	end

	function arg_1_0:get_enemy_collectionbuff()
		return self._enemy_collectionbuff
	end

	function arg_1_0.set_map_id(arg_42_0, arg_42_1)
		arg_42_0._map_id = arg_42_1
	end

	function arg_1_0:get_map_id()
		return self._map_id
	end

	function arg_1_0.set_is_undersea(arg_44_0, arg_44_1)
		arg_44_0._is_undersea = arg_44_1
	end

	function arg_1_0:is_undersea()
		return self._is_undersea
	end

	function arg_1_0:set_boss_info(arg_46_1)
		self._boss_info = arg_46_1
		self._boss_info.init_hp = arg_46_1.boss_now_hp
	end

	function arg_1_0:get_boss_info()
		return self._boss_info
	end

	function arg_1_0:update_boss_hp(arg_48_1, arg_48_2, arg_48_3)
		if not self._boss_info or not next(self._boss_info) then
			return
		end

		if self._boss_info.init_hp == 0 then
			return
		end

		local var_48_0 = self._battle_obj_mgr:findObject(arg_48_2)

		if not var_48_0 or var_48_0:get_side() == var_0_2.obj_side.player or not var_48_0:is_flag() then
			return
		end

		self._boss_info.can_not_dead = false

		local var_48_1 = self._boss_info.boss_now_hp - arg_48_1

		if arg_48_1 > self._boss_info.boss_now_hp then
			self._boss_info.damage = self._boss_info.boss_now_hp or arg_48_1
		end

		self._boss_info.boss_now_hp = var_48_1 > 0 and var_48_1 or 0

		if arg_48_3 > 0 and self._boss_info.boss_now_hp == 0 then
			self._boss_info.can_not_dead = true
			self._boss_info.boss_now_hp = 1
		end
	end

	function arg_1_0.set_player_speed(arg_49_0, arg_49_1)
		arg_49_0._player_avg_speed = arg_49_1
	end

	function arg_1_0:get_player_speed()
		return self._player_avg_speed
	end

	function arg_1_0.set_player_ship_attr(arg_51_0, arg_51_1)
		arg_51_0._total_attr_num = arg_51_1
	end

	function arg_1_0:get_player_ship_attr()
		return self._total_attr_num
	end

	function arg_1_0:set_battle_start_point(arg_53_1)
		if self._battle_start_id then
			return
		end

		self._battle_start_id = arg_53_1
	end

	function arg_1_0:get_battle_start_point()
		return self._battle_start_id
	end

	function arg_1_0.set_battle_end_point(arg_55_0, arg_55_1)
		arg_55_0._battle_end_id = arg_55_1
	end

	function arg_1_0:get_battle_end_point()
		return self._battle_end_id
	end

	function arg_1_0:set_player_workshop_cfg(arg_57_1)
		self._work_fight_info = arg_57_1
		self._player_workshop_data_for_type_11 = {}
		self._player_workshop_data_for_type_12 = {}

		if not arg_57_1 then
			return
		end

		for iter_57_0, iter_57_1 in pairs(arg_57_1) do
			for iter_57_2, iter_57_3 in pairs(var_0_4.find_object_by_id(iter_57_1).effect) do
				if iter_57_3.type == 11 then
					var_0_1(self._player_workshop_data_for_type_11, iter_57_3)
				end

				if iter_57_3.type == 12 then
					var_0_1(self._player_workshop_data_for_type_12, iter_57_3)
				end
			end
		end
	end

	function arg_1_0:get_player_workshop_cfg()
		return self._work_fight_info
	end

	function arg_1_0:set_enemy_workshop_cfg(arg_59_1)
		self._work_fight_enemy_info = arg_59_1
		self._enemy_workshop_data_for_type_11 = {}
		self._enemy_workshop_data_for_type_12 = {}

		if not arg_59_1 then
			return
		end

		for iter_59_0, iter_59_1 in pairs(arg_59_1) do
			for iter_59_2, iter_59_3 in pairs(var_0_4.find_object_by_id(iter_59_1).effect) do
				if iter_59_3.type == 11 then
					var_0_1(self._enemy_workshop_data_for_type_11, iter_59_3)
				end

				if iter_59_3.type == 12 then
					var_0_1(self._enemy_workshop_data_for_type_12, iter_59_3)
				end
			end
		end
	end

	function arg_1_0:get_enemy_workshop_cfg()
		return self._work_fight_enemy_info
	end

	function arg_1_0:get_workshop_cfg_for_type_11(arg_61_1)
		local var_61_0

		if arg_61_1:get_side() == var_0_2.obj_side.player then
			var_61_0 = self._player_workshop_data_for_type_11
		elseif arg_61_1:get_side() == var_0_2.obj_side.enemy then
			var_61_0 = self._enemy_workshop_data_for_type_11
		end

		return var_61_0
	end

	function arg_1_0:get_workshop_cfg_for_type_12(arg_62_1)
		local var_62_0

		if arg_62_1:get_side() == var_0_2.obj_side.player then
			var_62_0 = self._player_workshop_data_for_type_12
		elseif arg_62_1:get_side() == var_0_2.obj_side.enemy then
			var_62_0 = self._enemy_workshop_data_for_type_12
		end

		return var_62_0
	end

	function arg_1_0.set_main_fight_buff_data(arg_63_0, arg_63_1)
		local var_63_0 = {}

		local function var_63_1(arg_64_0)
			for iter_64_0, iter_64_1 in pairs(var_63_0) do
				if iter_64_1 == arg_64_0 then
					return
				end
			end

			var_0_1(var_63_0, arg_64_0)
		end

		for iter_63_0, iter_63_1 in pairs(arg_63_1) do
			var_63_1(iter_63_1)
		end

		arg_63_0._main_fight_buff_data = var_63_0
	end

	function arg_1_0:get_main_fight_buff_data()
		return self._main_fight_buff_data
	end

	function arg_1_0.set_push_fight_buff_data(arg_66_0, arg_66_1)
		arg_66_0._push_fight_buff_data = arg_66_1
	end

	function arg_1_0:get_push_fight_buff_data()
		return self._push_fight_buff_data
	end

	function arg_1_0.set_seventh_buff_data(arg_68_0, arg_68_1)
		arg_68_0._seventh_buff_data = arg_68_1
	end

	function arg_1_0:get_seventh_buff_data()
		return self._seventh_buff_data
	end

	function arg_1_0:set_eighth_buff_data(arg_70_1, arg_70_2)
		self._eighth_buff_data = {}
		self._eighth_buff_data = arg_70_1

		if arg_70_2 and not self:__have_data(arg_70_1, arg_70_2) then
			table.insert(self._eighth_buff_data, arg_70_2)
		end
	end

	function arg_1_0.__have_data(arg_71_0, arg_71_1, arg_71_2)
		if arg_71_1 and next(arg_71_1) then
			for iter_71_0, iter_71_1 in pairs(arg_71_1) do
				if iter_71_1 == arg_71_2 then
					return true
				end
			end
		end

		return false
	end

	function arg_1_0:get_eighth_buff_data()
		return self._eighth_buff_data
	end

	function arg_1_0.set_six_year_buff_data(arg_73_0, arg_73_1)
		arg_73_0._six_year_ship_buff = arg_73_1.ship or {}
		arg_73_0._six_year_buff_data = arg_73_1.buff
	end

	function arg_1_0:get_six_year_buff_data()
		return self._six_year_buff_data
	end

	function arg_1_0:get_six_year_ship_buff()
		return self._six_year_ship_buff
	end

	function arg_1_0.set_buffs_logic(arg_76_0, arg_76_1)
		arg_76_0._buffs_logic = arg_76_1
	end

	function arg_1_0:get_buffs_logic()
		return self._buffs_logic
	end

	function arg_1_0.set_main_fight_buff_hit(arg_78_0, arg_78_1)
		arg_78_0._must_hit = arg_78_1
	end

	function arg_1_0:get_main_fight_buff_hit()
		return self._must_hit
	end

	function arg_1_0.set_enemy_open_torpedo_info(arg_80_0, arg_80_1)
		arg_80_0._buff_ship_list = arg_80_1
	end

	function arg_1_0:get_enemy_open_torpedo_info()
		return self._buff_ship_list
	end

	function arg_1_0.set_enemy_night_info(arg_82_0, arg_82_1)
		arg_82_0._is_attack = arg_82_1
	end

	function arg_1_0:get_enemy_night_info()
		return self._is_attack
	end

	function arg_1_0.set_enemy_broken_info(arg_84_0, arg_84_1)
		arg_84_0._is_broken_attack = arg_84_1
	end

	function arg_1_0:get_enemy_broken_info()
		return self._is_broken_attack
	end

	function arg_1_0.reset_record_buff_data(arg_86_0)
		arg_86_0._is_attack = false
		arg_86_0._is_broken_attack = false
		arg_86_0._buff_ship_list = nil
	end

	function arg_1_0.set_sixth_adjutant_skill_buff(arg_87_0, arg_87_1)
		arg_87_0._adjutant_skill_buff = arg_87_1
	end

	function arg_1_0:get_sixth_adjutant_skill_buff()
		return self._adjutant_skill_buff
	end

	function arg_1_0.record_adjutant_skill_buff(arg_89_0, arg_89_1)
		arg_89_0._is_enhance = true
		arg_89_0._repeat_rate = arg_89_1
	end

	function arg_1_0:get_adjutant_skill_buff()
		return self._is_enhance, self._repeat_rate
	end

	function arg_1_0.reset_adjutant_skill_buff(arg_91_0)
		arg_91_0._is_enhance = false
		arg_91_0._repeat_rate = 0
	end

	function arg_1_0.set_map_total_num(arg_92_0, arg_92_1)
		arg_92_0._map_total_num = arg_92_1
	end

	function arg_1_0:get_map_total_num()
		return self._map_total_num
	end

	function arg_1_0.set_map_ship_data(arg_94_0, arg_94_1)
		arg_94_0._ship_map_data = arg_94_1
	end

	function arg_1_0:get_map_ship_data()
		return self._ship_map_data
	end

	function arg_1_0.set_kill_target_immediate_data(arg_96_0, arg_96_1)
		arg_96_0._kill_target_immediate_data = {
			ship_list = arg_96_1.ship_list,
			rate = arg_96_1.rate
		}
	end

	function arg_1_0:get_kill_target_immediate_data(arg_97_1)
		return self._kill_target_immediate_data
	end

	function arg_1_0.set_kill_not_flag_target_immediate_data(arg_98_0, arg_98_1)
		arg_98_0._kill_not_flag_target_immediate_data = {
			ship_list = arg_98_1.ship_list,
			rate = arg_98_1.rate
		}
	end

	function arg_1_0:get_kill_not_flag_target_immediate_data(arg_99_1)
		return self._kill_not_flag_target_immediate_data
	end

	function arg_1_0.set_attack_infallible_data(arg_100_0, arg_100_1)
		arg_100_0._attack_infallible = {
			ship_list = arg_100_1.ship_list,
			crit_hurt = arg_100_1.crit_hurt
		}
	end

	function arg_1_0:get_attack_infallible_data(arg_101_1)
		return self._attack_infallible
	end

	function arg_1_0.set_hit_reset_zero_data(arg_102_0, arg_102_1)
		arg_102_0._hit_reset_zero = {
			ship_list = arg_102_1.ship_list,
			num = arg_102_1.num
		}
	end

	function arg_1_0:set_open_airattack_damage_up_data(arg_103_1)
		self._open_airattack_damage_up = self._open_airattack_damage_up or {}

		local var_103_0 = {
			ship_list = arg_103_1.ship_list,
			stage = arg_103_1.stage,
			rate = arg_103_1.rate,
			airplane_type = arg_103_1.airplane_type
		}

		self._open_airattack_damage_up[var_103_0.airplane_type] = var_103_0
	end

	function arg_1_0:get_open_airattack_damage_up_data()
		return self._open_airattack_damage_up
	end

	function arg_1_0:get_hit_reset_zero_data(arg_105_1)
		return self._hit_reset_zero
	end

	function arg_1_0.set_evade_hit_data(arg_106_0, arg_106_1)
		arg_106_0._evade_hit = {
			ship_list = arg_106_1.ship_list,
			num = arg_106_1.num
		}
	end

	function arg_1_0:get_evade_hit_data(arg_107_1)
		return self._evade_hit
	end

	function arg_1_0.set_ship_range_limit_data(arg_108_0, arg_108_1)
		arg_108_0._ship_range_limit = {
			ship_list = arg_108_1.ship_list,
			num = arg_108_1.num
		}
	end

	function arg_1_0:get_ship_range_limit_data(arg_109_1)
		return self._ship_range_limit
	end

	function arg_1_0:set_abyss_add_damage_by_flag_data(arg_110_1)
		self._abyss_ship_range_limit = self._abyss_ship_range_limit or {}

		for iter_110_0, iter_110_1 in pairs(self._abyss_ship_range_limit) do
			if iter_110_1.is_flag == arg_110_1.is_flag then
				self._abyss_ship_range_limit[iter_110_0] = arg_110_1

				return
			end
		end

		self._abyss_ship_range_limit[#self._abyss_ship_range_limit + 1] = {
			ship_list = arg_110_1.ship_list,
			num = arg_110_1.num,
			is_flag = arg_110_1.is_flag
		}
	end

	function arg_1_0:get_abyss_add_damage_by_flag_data(arg_111_1)
		return self._abyss_ship_range_limit
	end

	function arg_1_0.set_team_reduce_hit_data(arg_112_0, arg_112_1)
		arg_112_0._team_reduce_hit_data = {
			stage_list = arg_112_1.stage_list,
			hit_rate = arg_112_1.hit_rate
		}
	end

	function arg_1_0:get_team_reduce_hit_data()
		return self._team_reduce_hit_data
	end

	function arg_1_0:set_hit_rate_enhance_data(arg_114_1)
		self._hit_rate_enhance_data = self._hit_rate_enhance_data or {}
		self._hit_rate_enhance_data[#self._hit_rate_enhance_data + 1] = {
			ship_list = arg_114_1.ship_list,
			stage_list = arg_114_1.stage_list,
			hit_rate = arg_114_1.hit_rate
		}
	end

	function arg_1_0:get_hit_rate_enhance_data()
		return self._hit_rate_enhance_data
	end

	function arg_1_0:set_hit_rate_reduce_data(arg_116_1)
		self._hit_rate_reduce_data = self._hit_rate_reduce_data or {}

		local var_116_0 = {}

		for iter_116_0, iter_116_1 in pairs(self._hit_rate_reduce_data) do
			if not iter_116_1.type or iter_116_1.type ~= arg_116_1.type then
				var_0_1(var_116_0, iter_116_1)
			end
		end

		self._hit_rate_reduce_data = var_116_0
		self._hit_rate_reduce_data[#self._hit_rate_reduce_data + 1] = {
			ship_list = arg_116_1.ship_list,
			stage_list = arg_116_1.stage_list,
			hit_rate = arg_116_1.hit_rate,
			type = arg_116_1.type
		}
	end

	function arg_1_0:get_hit_rate_reduce_data()
		return self._hit_rate_reduce_data
	end

	function arg_1_0:set_attend_fight_by_broken(arg_118_1)
		for iter_118_0, iter_118_1 in pairs(arg_118_1.ship_list) do
			local var_118_0 = false

			for iter_118_2, iter_118_3 in pairs(self._attend_fight_by_broken_ship_list) do
				if iter_118_3 == iter_118_1 then
					var_118_0 = true
				end
			end

			if not var_118_0 then
				var_0_1(self._attend_fight_by_broken_ship_list, iter_118_1)
			end
		end

		self._fight_by_broken_data = {
			ship_list = self._attend_fight_by_broken_ship_list
		}
	end

	function arg_1_0:get_attend_fight_by_broken()
		return self._fight_by_broken_data
	end

	function arg_1_0:get_cur_ship_can_attend_fight_by_broken(arg_120_1)
		if not self._fight_by_broken_data or not self._fight_by_broken_data.ship_list then
			return false
		end

		for iter_120_0, iter_120_1 in pairs(self._fight_by_broken_data.ship_list) do
			if iter_120_1 == arg_120_1 then
				return true
			end
		end
	end

	function arg_1_0.set_enemy_attack_hit_reduce_data(arg_121_0, arg_121_1)
		arg_121_0._enemy_attack_hit_data = {
			ship_list = arg_121_1.ship_list,
			enemy_ship_type = arg_121_1.enemy_ship_type,
			hit_rate = arg_121_1.hit_rate
		}
	end

	function arg_1_0:get_enemy_attack_hit_reduce_data()
		return self._enemy_attack_hit_data
	end

	function arg_1_0.set_team_all_reduce_hit_data(arg_123_0, arg_123_1)
		arg_123_0._team_all_reduce_hit = {
			hit_rate = arg_123_1.hit_rate
		}
	end

	function arg_1_0:get_team_all_reduce_hit_data()
		return self._team_all_reduce_hit
	end

	function arg_1_0.set_add_attr_by_ship_number_data(arg_125_0, arg_125_1)
		arg_125_0._add_attr_by_ship_number = arg_125_1
	end

	function arg_1_0:get_add_attr_by_ship_number_data()
		return self._add_attr_by_ship_number
	end

	function arg_1_0.set_attend_night_fight_ship(arg_127_0, arg_127_1)
		arg_127_0._night_fight_ship = {
			ship_list = arg_127_1.ship_list
		}
	end

	function arg_1_0:get_attend_night_fight_ship()
		return self._night_fight_ship
	end

	function arg_1_0:get_buff_list()
		return self._buff_list
	end

	function arg_1_0.set_open_antisub(arg_130_0, arg_130_1)
		arg_130_0._open_antisub = arg_130_1
	end

	function arg_1_0:get_open_antisubb()
		return self._open_antisub
	end

	function arg_1_0.set_ignore_armor(arg_132_0, arg_132_1)
		arg_132_0._ignore_armor = arg_132_1
	end

	function arg_1_0:get_ignore_armor()
		return self._ignore_armor
	end

	function arg_1_0.set_special_atk_as_zero(arg_134_0, arg_134_1)
		arg_134_0._special_atk_as_zeror = arg_134_1
	end

	function arg_1_0:get_special_atk_as_zero()
		return self._special_atk_as_zeror
	end

	function arg_1_0.set_rate_of_ignore_armor(arg_136_0, arg_136_1)
		arg_136_0._rate_of_ignore_armor = arg_136_1
	end

	function arg_1_0:get_rate_of_ignore_armor()
		return self._rate_of_ignore_armor
	end

	function arg_1_0.set_add_extra_damage(arg_138_0, arg_138_1)
		arg_138_0._add_extra_damage = arg_138_1
	end

	function arg_1_0:get_add_extra_damage()
		return self._add_extra_damage
	end

	function arg_1_0.set_ignore_armor_in_open_torpedo_attack(arg_140_0, arg_140_1)
		arg_140_0._ignore_armor_in_open_torpedo_attack = arg_140_1
	end

	function arg_1_0:get_ignore_armor_in_open_torpedo_attack()
		return self._ignore_armor_in_open_torpedo_attack
	end

	function arg_1_0.set_reduce_damage_with_special_enemy(arg_142_0, arg_142_1)
		arg_142_0._reduce_damage_with_special_enemy = arg_142_1
	end

	function arg_1_0:get_reduce_damage_with_special_enemy()
		return self._reduce_damage_with_special_enemy
	end

	function arg_1_0.set_reduce_damage_by_ship_type(arg_144_0, arg_144_1)
		arg_144_0._reduce_damage_by_ship_type = arg_144_1
	end

	function arg_1_0:get_reduce_damage_by_ship_type()
		return self._reduce_damage_by_ship_type
	end

	function arg_1_0.set_tower_buff_data(arg_146_0, arg_146_1)
		arg_146_0._tower_buff_data = arg_146_1
	end

	function arg_1_0:get_tower_buff_data()
		return self._tower_buff_data
	end

	function arg_1_0.set_ocean_cia_buffs_data(arg_148_0, arg_148_1)
		arg_148_0._ocean_cia_buffs_data = arg_148_1
	end

	function arg_1_0:get_ocean_cia_buffs_data()
		return self._ocean_cia_buffs_data
	end

	function arg_1_0.set_solid_strike_buffs_data(arg_150_0, arg_150_1)
		arg_150_0._solid_strike_buffs_data = arg_150_1
	end

	function arg_1_0:get_solid_strike_buffs_data()
		return self._solid_strike_buffs_data
	end

	function arg_1_0.set_war_concerto_buffs_data(arg_152_0, arg_152_1)
		arg_152_0._war_concerto_buffs = arg_152_1
	end

	function arg_1_0:get_war_concerto_buffs_data()
		return self._war_concerto_buffs or {}
	end

	function arg_1_0.set_abyss_power(arg_154_0, arg_154_1)
		arg_154_0._abyss_power = arg_154_1
	end

	function arg_1_0:get_abyss_power()
		return self._abyss_power
	end

	function arg_1_0:get_attack_state_by_hp(arg_156_1, arg_156_2)
		return self:__execute_tower_buff_broken_fight(arg_156_1, arg_156_2)
	end

	function arg_1_0:__execute_tower_buff_broken_fight(arg_157_1, arg_157_2)
		if not self:get_attend_fight_by_broken() then
			return false
		end

		local var_157_0 = self:get_attend_fight_by_broken()

		if var_157_0 and var_157_0.ship_list then
			for iter_157_0, iter_157_1 in pairs(var_157_0.ship_list) do
				if arg_157_2:getID() == iter_157_1 then
					return true
				end
			end
		end

		return false
	end

	function arg_1_0:__execute_main_buff_broken_fight(arg_158_1, arg_158_2)
		if not self:get_enemy_broken_info() then
			return false
		end

		for iter_158_0, iter_158_1 in pairs(var_0_2.broken_enemy_type_by_buff) do
			if arg_158_2:get_ship_type() == iter_158_1 and (arg_158_2:is_lowhp() or arg_158_2:is_medhp()) and var_0_3:get_exist_state(arg_158_1, arg_158_2) then
				return true
			end
		end

		return false
	end

	function arg_1_0.set_tower_buff(arg_159_0, arg_159_1)
		arg_159_0._tower_buff = arg_159_1
	end

	function arg_1_0:get_tower_buff()
		return self._tower_buff
	end
end

function var_0_0.extend_obj(arg_161_0)
	arg_161_0._is_undersea = false
	arg_161_0._effect_tactics = {}
	arg_161_0._skill_id = {}
	arg_161_0._work_fight_info = {}
	arg_161_0._work_fight_enemy_info = {}
	arg_161_0._enemy_eighth_info = {}
	arg_161_0._attend_fight_by_broken_ship_list = {}
	arg_161_0.damage_control_last_hp_num = {}
	arg_161_0.kill_flag_ship_id = 0
end

return var_0_0
