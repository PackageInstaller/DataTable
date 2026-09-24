local var_0_0 = {}
local var_0_1 = lx
local var_0_4 = gameenum.battle_type
local var_0_5 = gamecore.battle_util
local var_0_6 = gamecore.buffs_logic
local var_0_7 = gamecore.tower_buffs_logic
local var_0_8 = gamecore.war_concerto_buffs_logic
local var_0_9 = gamecore.solid_strike_buffs_logic
local var_0_10 = gamecore.solid_score_strike_buffs_logic
local var_0_11 = gamecore.push_map_buffs_logic
local var_0_12 = gamecore.seventh_buffs_logic
local var_0_13 = gamecore.eighth_buffs_logic
local var_0_14 = gamecore.abyss_broken_buffs_logic
local var_0_15 = table.insert
local var_0_16 = gameconfig.sixth_map_node_config
local var_0_17 = gameconfig.pve_mix_level_node_config
local var_0_18 = gameconfig.pve_eighth_level_node_config
local var_0_19 = gamecore.score_push_buffs_logic
local var_0_20 = gamecore.push_buffs_logic
local var_0_21 = gamecore.equip_entire_buffs_logic
local var_0_22 = gamecore.equip_entire_buffs_enemy_logic
local var_0_23 = gamecore.ninth_push_buffs_logic
local var_0_24 = gamecore.rank_support_buffs_logic

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__eventOnInit(arg_2_1)
		self:set_player_formation(arg_2_1.player_formation)
		self:set_enemy_formation(arg_2_1.enemy_formation)
		self:set_fight_type(arg_2_1.fight_type)
		self:set_battle_point(arg_2_1.point)
		self:set_damage_control_num(arg_2_1.damage_control)
		self:set_radar_state(arg_2_1.search)
		self:set_boss_info(var_0_1.clone_table(arg_2_1.boss_info))
		self:set_support_id(arg_2_1.support_id)
		self:set_player_cookbuff(arg_2_1.player_cookbuff)
		self:set_day_or_night_attack()

		local var_2_0, var_2_1 = var_0_5:set_battle_node_data(arg_2_1.point, arg_2_1.fight_type, arg_2_1.start_point)

		self:set_battle_start_point(var_2_0)
		self:set_battle_end_point(var_2_1)
		self:set_player_collectionbuff(arg_2_1.collectionbuff)
		self:set_enemy_collectionbuff(arg_2_1.enemy_collectionbuff)
		self:set_player_racingbuff(arg_2_1.racingbuff)
		self:set_player_workshop_cfg(arg_2_1.player_workshop_cfg)
		self:set_enemy_workshop_cfg(arg_2_1.enemy_workshop_cfg)
		self:set_six_year_buff_data(arg_2_1.six_year_combat_buff)

		if arg_2_1.fight_type ~= var_0_4.fight_type.plot_main then
			self:set_main_fight_buff_data(arg_2_1.main_fight_buff)
		end

		self:set_push_fight_buff_data(arg_2_1.random_push_buff)
		self:set_seventh_buff_data(arg_2_1.seventh_buff)
		self:set_eighth_buff_data(arg_2_1.eighth_buff, arg_2_1.eighth_enemy_buff)
		self:set_sixth_adjutant_skill_buff(arg_2_1.sixth_adjutant_skill_buff)
		self:set_map_total_num(arg_2_1.map_total)
		self:set_map_ship_data(arg_2_1.ship_open_map)
		self:set_map_id(arg_2_1.map_id)

		if arg_2_1.tower_buff then
			self:set_tower_buff(arg_2_1.tower_buff.tower_buff)
			self:set_tower_buff_data(arg_2_1.tower_buff.chip)
			self:create_tower_buff(arg_2_1.tower_buff)
		end

		self.has_submarine = arg_2_1.has_submarine

		self:create_main_buff(arg_2_1.main_fight_buff)
		self:create_buff(arg_2_1.six_year_combat_buff)
		self:create_concerto_buff(arg_2_1.concerto)
		self:create_seventh_buff(arg_2_1.seventh_buff)
		self:create_eighth_buff(arg_2_1.eighth_buff)
		self:create_solid_buff(arg_2_1.solid_buff)
		self:create_score_solid_buff(arg_2_1.solid_extend_buff)
		self:create_abyss_buff(arg_2_1.abyss_buff)
		self:set_abyss_power(arg_2_1.abyss_power)
		self:create_score_push_buffs(arg_2_1.answer_buff)
		self:create_push_buffs(arg_2_1.push_buff)
		self:create_ninth_push_buffs(arg_2_1.ninth_buff)
		self:create_equip_entire_buffs(arg_2_1.special_equipment_buff.player_list)
		self:create_equip_entire_enemy_buffs(arg_2_1.special_equipment_buff.enemy_list)
		self:create_rank_support_buffs(arg_2_1.rank_buff)
		self:set_is_erro(flag)
		self:get_is_erro()
		self._battle_processor:eventOnBattleScene(arg_2_1)
	end

	function arg_1_0:order_on__night_attack_step(arg_3_1)
		log.print_r("进入夜战----------------")
		self._battlefield:on_night_war(arg_3_1)
	end

	function arg_1_0:order_on__story_end(arg_4_1)
		self._battlefield:start(true)
	end

	function arg_1_0.set_is_erro(arg_5_0, arg_5_1)
		arg_5_0._is_erro = arg_5_1
	end

	function arg_1_0:get_is_erro()
		return self._is_erro
	end

	function arg_1_0:create_buff(arg_7_1)
		if not arg_7_1 or not next(arg_7_1) then
			return
		end

		local var_7_0

		if not arg_7_1.buff and not arg_7_1.fleetdecisive_buff then
			do return end

			var_7_0 = {}
		end

		local var_7_1 = var_0_16.find_object_by_id((self:get_battle_point()))

		if var_7_1 and var_7_1.buff then
			var_0_15(var_7_0, {
				point_effect = var_7_1.buff
			})
		end

		self._buff_list = self._buff_list or {}

		for iter_7_0, iter_7_1 in pairs(arg_7_1.buff) do
			var_0_15(self._buff_list, (self:createObject(var_0_6, iter_7_1, "combat_buff")))
		end

		if arg_7_1.fleetdecisive_buff and arg_7_1.fleetdecisive_buff ~= 0 then
			var_0_15(self._buff_list, (self:createObject(var_0_6, {
				level = 1,
				id = arg_7_1.fleetdecisive_buff
			}, "combat_buff")))
		end

		for iter_7_2, iter_7_3 in pairs(var_7_0) do
			var_0_15(self._buff_list, (self:createObject(var_0_6, iter_7_3, "combat_buff")))
		end
	end

	function arg_1_0:create_main_buff(arg_8_1)
		if not arg_8_1 or not next(arg_8_1) then
			return
		end

		self._buff_list = self._buff_list or {}

		for iter_8_0, iter_8_1 in pairs(arg_8_1) do
			var_0_15(self._buff_list, (self:createObject(var_0_6, iter_8_1, "ship_pve_buff")))
		end
	end

	function arg_1_0:create_tower_buff(arg_9_1)
		if not arg_9_1 or not next(arg_9_1) then
			return
		end

		self._buff_list = self._buff_list or {}

		for iter_9_0, iter_9_1 in pairs(arg_9_1.tower_buff) do
			var_0_15(self._buff_list, (self:createObject(var_0_6, iter_9_1, "tower_buff")))
		end

		for iter_9_2, iter_9_3 in pairs(arg_9_1.enemys_buff) do
			var_0_15(self._buff_list, (self:createObject(var_0_6, iter_9_3, "tower_buff")))
		end

		for iter_9_4, iter_9_5 in pairs(arg_9_1.chip) do
			var_0_15(self._buff_list, (self:createObject(var_0_7, iter_9_5, "tower_stone_buff")))
		end
	end

	function arg_1_0:create_concerto_buff(arg_10_1)
		if not arg_10_1 or not next(arg_10_1) then
			return
		end

		self._buff_list = self._buff_list or {}

		for iter_10_0, iter_10_1 in pairs(arg_10_1) do
			var_0_15(self._buff_list, (self:createObject(var_0_8, iter_10_1, "concerto_buff")))
		end
	end

	function arg_1_0:create_push_buff(arg_11_1, arg_11_2)
		if not arg_11_1 or not next(arg_11_1) then
			return
		end

		self._buff_list = self._buff_list or {}

		for iter_11_0, iter_11_1 in pairs(arg_11_1) do
			var_0_15(self._buff_list, (self:createObject(var_0_11, iter_11_1, "push_buff")))
		end

		if arg_11_2 then
			var_0_15(self._buff_list, (self:createObject(var_0_11, arg_11_2, "push_buff")))
		end
	end

	function arg_1_0:create_seventh_buff(arg_12_1)
		if not arg_12_1 or not next(arg_12_1) then
			return
		end

		self._buff_list = self._buff_list or {}

		local var_12_1 = var_0_17.find_object_by_id((self:get_battle_point()))

		if var_12_1 and var_12_1.node_buff then
			var_0_15(self._buff_list, (self:createObject(var_0_12, var_12_1.node_buff, "seventh_node_buff")))
		end

		for iter_12_0, iter_12_1 in pairs(arg_12_1) do
			var_0_15(self._buff_list, (self:createObject(var_0_12, iter_12_1, "seventh_buff")))
		end
	end

	function arg_1_0:create_eighth_buff(arg_13_1)
		if not arg_13_1 or not next(arg_13_1) then
			return
		end

		self._buff_list = self._buff_list or {}

		local var_13_1 = var_0_18.find_object_by_id((self:get_battle_point()))

		if var_13_1 and var_13_1.node_buff then
			var_0_15(self._buff_list, (self:createObject(var_0_13, var_13_1.node_buff, "eighth_node_buff")))
		end

		for iter_13_0, iter_13_1 in pairs(arg_13_1) do
			var_0_15(self._buff_list, (self:createObject(var_0_13, iter_13_1, "eighth_buff")))
		end
	end

	function arg_1_0:create_score_push_buffs(arg_14_1)
		if not arg_14_1 or not next(arg_14_1) then
			return
		end

		self._buff_list = self._buff_list or {}

		for iter_14_0, iter_14_1 in pairs(arg_14_1) do
			var_0_15(self._buff_list, (self:createObject(var_0_19, iter_14_1, "score_push_buff")))
		end
	end

	function arg_1_0:create_ninth_push_buffs(arg_15_1)
		if not arg_15_1 or not next(arg_15_1) then
			return
		end

		self._buff_list = self._buff_list or {}

		for iter_15_0, iter_15_1 in pairs(arg_15_1) do
			var_0_15(self._buff_list, (self:createObject(var_0_23, iter_15_1, "ninth_push_buff")))
		end
	end

	function arg_1_0:create_push_buffs(arg_16_1)
		if not arg_16_1 or not next(arg_16_1) then
			return
		end

		self._buff_list = self._buff_list or {}

		for iter_16_0, iter_16_1 in pairs(arg_16_1) do
			var_0_15(self._buff_list, (self:createObject(var_0_20, iter_16_1, "push_buff")))
		end
	end

	function arg_1_0:create_solid_buff(arg_17_1)
		if not arg_17_1 or not next(arg_17_1) then
			return
		end

		self._buff_list = self._buff_list or {}

		for iter_17_0, iter_17_1 in pairs(arg_17_1) do
			var_0_15(self._buff_list, (self:createObject(var_0_9, iter_17_1, "solid_strike")))
		end
	end

	function arg_1_0:create_score_solid_buff(arg_18_1)
		if not arg_18_1 or not next(arg_18_1) then
			return
		end

		self._buff_list = self._buff_list or {}

		for iter_18_0, iter_18_1 in pairs(arg_18_1) do
			var_0_15(self._buff_list, (self:createObject(var_0_10, iter_18_1, "solid_score_strike")))
		end
	end

	function arg_1_0:create_abyss_buff(arg_19_1)
		if not arg_19_1 or not next(arg_19_1) then
			return
		end

		self._buff_list = self._buff_list or {}

		for iter_19_0, iter_19_1 in pairs(arg_19_1) do
			var_0_15(self._buff_list, (self:createObject(var_0_14, iter_19_1, "abyss_buff")))
		end
	end

	function arg_1_0:create_equip_entire_buffs(arg_20_1)
		if not arg_20_1 or not next(arg_20_1) then
			return
		end

		self._buff_list = self._buff_list or {}

		for iter_20_0, iter_20_1 in pairs(arg_20_1) do
			for iter_20_2, iter_20_3 in pairs(iter_20_1) do
				var_0_15(self._buff_list, (self:createObject(var_0_21, iter_20_3, "equip_entire_buff")))
			end
		end
	end

	function arg_1_0:create_equip_entire_enemy_buffs(arg_21_1)
		if not arg_21_1 or not next(arg_21_1) then
			return
		end

		self._buff_list = self._buff_list or {}

		for iter_21_0, iter_21_1 in pairs(arg_21_1) do
			for iter_21_2, iter_21_3 in pairs(iter_21_1) do
				var_0_15(self._buff_list, (self:createObject(var_0_22, iter_21_3, "equip_entire_buff")))
			end
		end
	end

	function arg_1_0:create_rank_support_buffs(arg_22_1)
		if not arg_22_1 or not next(arg_22_1) then
			return
		end

		self._buff_list = self._buff_list or {}

		var_0_15(self._buff_list, (self:createObject(var_0_24, arg_22_1, "rank_support_buff")))
	end

	function arg_1_0:__eventOnDestroy()
		local var_23_0 = {}

		for iter_23_0, iter_23_1 in pairs(self._object_set) do
			var_23_0[iter_23_0] = iter_23_0
		end

		for iter_23_2, iter_23_3 in pairs(var_23_0) do
			self:removeObject(iter_23_2)
		end
	end

	function arg_1_0.__eventOnCreateObject(arg_24_0, arg_24_1, ...)
		arg_24_1:__eventOnInit(...)
	end

	function arg_1_0.__eventOnRemoveObject(arg_25_0, arg_25_1)
		arg_25_1:__eventOnDestroy()
	end

	function arg_1_0:__eventOnFrame(arg_26_1)
		for iter_26_0, iter_26_1 in pairs(self._object_set) do
			iter_26_1:__eventOnFrame(arg_26_1)
		end
	end
end

function var_0_0.extend_obj(arg_27_0)
	arg_27_0._buff_list = nil
end

return var_0_0
