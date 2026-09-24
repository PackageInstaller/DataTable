local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gameconfig.monster_config
local var_0_3 = gameconfig.map_config
local var_0_4 = gameconfig.shop_config
local var_0_5 = gameconfig.map_node_config
local var_0_6 = gameconfig.monster_formation_config
local var_0_7 = gameconfig.ship_config
local var_0_8 = gameconfig.map_campaign_config
local var_0_9 = gameconfig.equip_config
local var_0_10 = gameconfig.sixth_map_node_config
local var_0_11 = gameconfig.sixth_map_config
local var_0_13 = gameconfig.strike_map_node_config
local var_0_14 = gameconfig.robot_config
local var_0_15 = gamecore.util_func
local var_0_16 = table.insert
local var_0_17 = gameenum.common_type
local var_0_19 = gameconfig.ocean_map_node_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:init()
		local var_2_0 = var_0_1:get_battle_info()

		self._fight_type = var_2_0.type

		if var_2_0.type == gameenum.battle_type.fight_type.main then
			self:get_normal_data()
		end

		if var_2_0.type == gameenum.battle_type.fight_type.campaign then
			self:get_campaign_data(var_2_0.point)
		end

		if var_2_0.type == gameenum.battle_type.fight_type.maneuver then
			self:get_maneuver_data()
		end

		if var_2_0.type == gameenum.battle_type.fight_type.sixth then
			self:get_sixth_data(var_2_0.point)
		end

		if var_2_0.type == gameenum.battle_type.fight_type.plot_main then
			self:get_sixth_data(var_2_0.point)
		end

		if var_2_0.type == gameenum.battle_type.fight_type.strike then
			self:get_strike_data(var_2_0.point)
		end

		if var_2_0.type == gameenum.battle_type.fight_type.ocean_attack then
			self:get_ocean_data(var_2_0.point)
		end

		if var_2_0.type == gameenum.battle_type.fight_type.score then
			self:get_normal_data()
		end

		self._scene_data = self._scene
		self._unit_data = {
			player = self._players,
			enemy = self._enemys
		}
	end

	function arg_1_0:get_normal_data()
		local var_3_0 = var_0_1:get_battle_data()
		local var_3_1 = var_0_6.find_object_by_id(var_3_0.monster)

		self._monsters = var_3_1.formation

		self:get_player_data()
		self:get_enemy_data()
		self:get_scene_data(var_0_5.find_object_by_id(var_3_0.point).bg_sea, var_3_1)
	end

	function arg_1_0:get_sixth_data(arg_4_1)
		local var_4_0 = var_0_1:get_battle_data()
		local var_4_1 = var_0_10.find_object_by_id(var_4_0.point)
		local var_4_2 = var_0_6.find_object_by_id(var_4_0.monster)

		self._monsters = var_4_2.formation

		if self._fight_type == gameenum.battle_type.fight_type.plot_main then
			self:get_player_data(var_4_1.self_formation)
		else
			self:get_player_data()
		end

		self:get_enemy_data()
		self:get_scene_data(var_4_1.bg_sea, var_4_2)
	end

	function arg_1_0:get_strike_data(arg_5_1)
		local var_5_0 = var_0_1:get_strike_battle_data()
		local var_5_1 = var_0_6.find_object_by_id(var_5_0.monster)

		self._monsters = var_5_1.formation

		self:get_player_data()
		self:get_enemy_data()
		self:get_scene_data(var_0_13.find_object_by_id(var_5_0.point).bg_sea, var_5_1)
	end

	function arg_1_0:get_ocean_data(arg_6_1)
		local var_6_0 = var_0_1:get_ocean_map_data()
		local var_6_1 = var_0_6.find_object_by_id(var_6_0.boss_info)

		self._monsters = var_6_1.formation

		self:get_player_data()
		self:get_enemy_data()
		self:get_scene_data(var_0_19.find_object_by_id(var_6_0.start_point).bg_sea, var_6_1)
	end

	function arg_1_0:get_campaign_data(arg_7_1)
		local var_7_0 = var_0_6.find_object_by_id(var_0_1:get_campaign_info().monster)

		self._monsters = var_7_0.formation

		self:get_player_data(arg_7_1)
		self:get_enemy_data()
		self:get_scene_data(var_0_8.find_object_by_id(arg_7_1).bg_sea, var_7_0)
	end

	function arg_1_0:get_maneuver_data()
		local var_8_0 = {}
		local var_8_1 = {}
		local var_8_2 = var_0_1:get_maneuver_resp_info()
		local var_8_3 = var_0_1:get_battle_type()

		if var_8_3 == var_0_17.battle_type.exercise then
			local var_8_4 = var_0_1:get_maneuver_target_info()

			if var_8_4.robot then
				var_8_1 = var_0_6.find_object_by_id(var_0_14.find_object_by_id(var_8_4.id).npc_formation)
				var_8_0 = var_8_1.formation
				var_8_1.formation_id = var_8_1.formation_id
			else
				var_8_0 = var_8_4.garrison
				var_8_1.formation_id = var_8_2.formation
			end
		elseif var_8_3 == var_0_17.battle_type.friend_exercise then
			var_8_0 = var_0_1:get_friend_info(var_0_1:get_friend_id()).mansion.garrison
			var_8_1.formation_id = var_8_2.formation
		end

		self._monsters = var_8_0

		self:get_player_data()
		self:get_enemy_data()
		self:get_scene_data(var_0_17.maneuver_sea, var_8_1)
	end

	function arg_1_0:get_scene_data(arg_9_1, arg_9_2)
		self._scene = {}
		self._scene.fight_type = self._fight_type
		self._scene.point = self:get_battle_point()
		self._scene.bg_sea = arg_9_1
		self._scene.boss_info = self:get_boss_point_info()
		self._scene.enemy_formation = arg_9_2.formation_id
		self._scene.player_formation = self:get_player_formation()
		self._scene.search = self:get_radar_state()
		self._scene.support_id = self:get_support_id()
		self._scene.damage_control = self:get_damage_control_num()
		self._scene.player_flag_speed = self._players[1].speed
		self._scene.player_avg_speed = self:__get_avg_speed(self._players)
		self._scene.enemy_flag_speed = self._enemys[1].speed
		self._scene.enemy_avg_speed = self:__get_avg_speed(self._enemys)
		self._scene.has_submarine = self:has_submarine()
		self._scene.player_cookbuff = self:get_cookbuff()
		self._scene.racingbuff = self:get_racingbuff()
		self._scene.collectionbuff = self:get_collectionbuff()
		self._scene.main_fight_buff = self:get_main_line_buff()
		self._scene.six_year_combat_buff = self:get_six_year_buff()
		self._scene.sixth_adjutant_skill_buff = self:get_sixth_adjutant_buff_data()
		self._scene.enemy_collectionbuff = self:get_enemy_collectionbuff()

		if self._fight_type ~= gameenum.battle_type.fight_type.plot_main then
			self._scene.player_workshop_cfg = var_0_1:get_workshop_cfg()
			self._scene.enemy_workshop_cfg = {}
		end

		self._scene.map_total = self:get_main_map_fight_num()
		self._scene.ship_open_map = self:get_map_data_by_ship()

		return self._scene
	end

	function arg_1_0:get_boss_point_info()
		if self._fight_type == gameenum.battle_type.fight_type.campaign or self._fight_type == gameenum.battle_type.fight_type.maneuver or self._fight_type == gameenum.battle_type.fight_type.sixth or self._fight_type == gameenum.battle_type.fight_type.strike then
			return nil
		end

		if self._fight_type == gameenum.battle_type.fight_type.plot_main then
			return nil
		end

		local var_10_0 = {}
		local var_10_1 = var_0_1:get_battle_info().id
		local var_10_2 = var_0_3.find_object_by_id(var_10_1)

		if self._fight_type == gameenum.battle_type.fight_type.sixth then
			var_10_2 = var_0_11.find_object_by_id(var_10_1)
		end

		local var_10_3 = var_10_2.hp
		local var_10_4 = var_0_15.have_data(var_10_2.boss_node_id, var_0_1:get_battle_data().point)

		if var_10_2.hp ~= 0 and var_10_2.boss_node_id then
			var_10_0.boss_now_hp = var_0_1:get_map_list()[var_10_1].hp
			var_10_0.boss_max_hp = var_10_3
			var_10_0.boss_max_hp2 = var_10_2.hp2

			return var_10_0
		end

		return nil
	end

	function arg_1_0:get_battle_point()
		if self._fight_type == gameenum.battle_type.fight_type.main or self._fight_type == gameenum.battle_type.fight_type.campaign or self._fight_type == gameenum.battle_type.fight_type.plot_main or self._fight_type == gameenum.battle_type.fight_type.sixth or self._fight_type == gameenum.battle_type.fight_type.strike or self._fight_type == gameenum.battle_type.fight_type.ocean_attack then
			return var_0_1:get_battle_data().point
		end

		return 0
	end

	function arg_1_0.get_player_formation(arg_12_0)
		return var_0_1:get_battle_data().formation
	end

	function arg_1_0.get_support_id(arg_13_0)
		return var_0_1:get_battle_data().support
	end

	function arg_1_0.get_random(arg_14_0)
		return var_0_1:get_battle_data().random
	end

	function arg_1_0.get_battletime(arg_15_0)
		return var_0_1:get_battle_data().battle_time
	end

	function arg_1_0.get_team(arg_16_0)
		return var_0_1:get_battle_info().team
	end

	function arg_1_0.get_damage_control_num(arg_17_0)
		return (var_0_1:get_item_count(var_0_4.find_object_by_id(var_0_17.shop_damage_control_cid).content[1].id))
	end

	function arg_1_0.get_cookbuff(arg_18_0)
		return {}
	end

	function arg_1_0.get_racingbuff(arg_19_0)
		return {}
	end

	function arg_1_0.get_collectionbuff(arg_20_0)
		return (var_0_1:get_player_desk_collection_data())
	end

	function arg_1_0.set_main_line_buff(arg_21_0, arg_21_1)
		arg_21_0._fight_buff_id = arg_21_1
	end

	function arg_1_0:get_main_line_buff()
		return self._fight_buff_id
	end

	function arg_1_0.get_six_year_buff(arg_23_0)
		return var_0_1:get_sixth_combat_info().buff
	end

	function arg_1_0.get_strike_buff(arg_24_0)
		return var_0_1:get_strike_point_info().buffs
	end

	function arg_1_0.get_ocean_buff(arg_25_0)
		return (var_0_1:get_ocean_map_buff_data())
	end

	function arg_1_0.get_enemy_collectionbuff(arg_26_0)
		local var_26_0 = {}

		if not var_0_1:get_friend_id() then
			return var_26_0
		end

		if var_0_1:get_friend_info(var_0_1:get_friend_id()) and var_0_1:get_friend_info(var_0_1:get_friend_id()).boxroom then
			var_26_0 = var_0_1:get_friend_info(var_0_1:get_friend_id()).boxroom.desk
		end

		return var_26_0
	end

	function arg_1_0:get_radar_state()
		if self._fight_type == gameenum.battle_type.fight_type.main then
			local var_27_0 = var_0_1:get_map_move_info()

			if not var_27_0 then
				return false
			end

			return var_27_0.search
		end

		if self._fight_type == gameenum.battle_type.fight_type.campaign then
			local var_27_1 = var_0_1:get_campaign_info()

			if not var_27_1 then
				return false
			end

			return var_27_1.search
		end

		return false
	end

	function arg_1_0:get_player_data(arg_28_1)
		self._players = {}

		local var_28_0 = {}

		if self._fight_type == gameenum.battle_type.fight_type.main or self._fight_type == gameenum.battle_type.fight_type.maneuver then
			var_28_0 = var_0_1:get_team_group(var_0_17.team_type.normal)[self:get_team()].members
		end

		if self._fight_type == gameenum.battle_type.fight_type.sixth then
			var_28_0 = var_0_1:get_sixth_combat_info().members
		end

		if self._fight_type == gameenum.battle_type.fight_type.strike then
			var_28_0 = var_0_1:get_strike_team_data()
		end

		if self._fight_type == gameenum.battle_type.fight_type.ocean_attack then
			var_28_0 = var_0_1:get_ocean_team_data()
		end

		for iter_28_0, iter_28_1 in pairs((self._fight_type == gameenum.battle_type.fight_type.campaign or nil) and var_0_1:get_campaign_members(arg_28_1)) do
			local var_28_1 = var_0_1:find_character_by_id(iter_28_1)
			local var_28_2 = self:get_character_attribute(iter_28_1)

			var_0_16(self._players, {
				cid = var_28_1.cid,
				character_id = iter_28_1,
				pos = gameenum.battle_type.player_pos[iter_28_0],
				level = var_28_1.level,
				love = var_28_1.love,
				attrs = var_28_2,
				intensify = self:get_character_intensify(iter_28_1),
				hp = var_28_1.hp,
				equips = self:get_character_equips(iter_28_1),
				oil = var_28_1.now_oil,
				ammo = var_28_1.now_bullet,
				index = iter_28_0,
				ship_type = var_0_7.find_object_by_cid(var_28_1.cid).type,
				speed = var_28_2.speed,
				skin_id = var_28_1.skin,
				skill = var_28_1.now_skill,
				skill_level = var_28_1.skill_level,
				tactics = var_28_1.tactics,
				learning_tactic = var_0_1:get_learning_tactic(iter_28_1)
			})
		end

		if self._fight_type == gameenum.battle_type.fight_type.plot_main then
			self.player_list = arg_28_1

			for iter_28_2, iter_28_3 in pairs(self.player_list) do
				local var_28_3 = var_0_7.find_object_by_cid(iter_28_3)
				local var_28_4 = {
					aircraft_atk = 0,
					learning_tactic = 0,
					air_def_correct = 0,
					id = iter_28_2,
					radar = var_28_3.radar,
					miss = var_28_3.miss,
					hp = var_28_3.hp,
					luck = var_28_3.luck,
					speed = var_28_3.speed,
					now_oil = var_28_3.max_oil,
					now_bullet = var_28_3.max_ammo,
					air_def = var_28_3.air_def,
					range = var_28_3.range,
					hit = var_28_3.hit,
					atk = var_28_3.atk,
					now_hp = var_28_3.hp,
					torpedo = var_28_3.torpedo,
					def = var_28_3.def,
					antisub = var_28_3.monster_conf
				}

				for iter_28_4, iter_28_5 in pairs(var_28_3.equipment) do
					local var_28_5 = var_0_9.find_object_by_cid(iter_28_5)

					for iter_28_6, iter_28_7 in pairs(gameenum.battle_type.equip_attribute_type) do
						var_28_4[iter_28_7] = var_28_4[iter_28_7] or 0

						if iter_28_7 == "range" then
							if var_28_5[iter_28_7] > var_28_4[iter_28_7] then
								var_28_4[iter_28_7] = var_28_5[iter_28_7] or var_28_4[iter_28_7]
							end
						elseif iter_28_7 == "ap" then
							for iter_28_8, iter_28_9 in pairs(var_28_5.effect) do
								if iter_28_9.name == "ap" then
									var_28_4[iter_28_7] = var_28_4[iter_28_7] + var_28_5.effect.value
								end
							end
						else
							var_28_4[iter_28_7] = var_28_4[iter_28_7] + var_28_5[iter_28_7]
						end
					end
				end

				var_0_16(self._players, {
					love = 0,
					skill_level = 0,
					skin_id = 0,
					skill = 0,
					level = 110,
					cid = var_28_3.cid,
					character_id = var_28_3.cid,
					pos = iter_28_2,
					attrs = var_28_4,
					hp = var_28_3.hp,
					equips = self:set_plot_character_equips(var_28_3.equipment),
					oil = var_28_3.max_oil,
					ammo = var_28_3.max_ammo,
					index = iter_28_2,
					ship_type = var_28_3.type,
					speed = var_28_3.speed,
					skill_id = var_28_3.skill_id
				})
			end
		end

		return self._players
	end

	function arg_1_0:get_enemy_data()
		self._enemys = {}

		for iter_29_0, iter_29_1 in pairs(self._monsters) do
			local var_29_0 = var_0_17.enemy_type.monster
			local var_29_1 = var_0_2.find_object_by_id(iter_29_1)
			local var_29_2 = iter_29_1
			local var_29_3 = iter_29_1

			if self._fight_type == gameenum.battle_type.fight_type.maneuver then
				local var_29_4 = var_0_1:get_battle_type()

				if var_29_4 == var_0_17.battle_type.exercise then
					if var_0_1:get_maneuver_target_info().robot then
						var_29_0 = var_0_17.enemy_type.robot
					else
						local var_29_5 = var_0_7.find_object_by_cid(iter_29_1.id)

						var_29_0 = var_0_17.enemy_type.player
						var_29_1 = iter_29_1
						var_29_2 = iter_29_1.id
						var_29_3 = iter_29_1.id
						var_29_1.luck = var_29_5.luck
						var_29_1.equipment = iter_29_1.equips
						var_29_1.oil = 200
						var_29_1.ammo = 200
						var_29_1.type = var_29_5.type
						var_29_1.speed = var_29_5.speed
						var_29_1.skin_id = iter_29_1.skin
						var_29_1.skill_id = iter_29_1.now_skill
					end
				elseif var_29_4 == var_0_17.battle_type.friend_exercise then
					local var_29_6 = var_0_7.find_object_by_cid(iter_29_1.id)

					var_29_0 = var_0_17.enemy_type.player
					var_29_1 = iter_29_1
					var_29_2 = iter_29_1.id
					var_29_3 = iter_29_1.id
					var_29_1.luck = var_29_6.luck
					var_29_1.equipment = iter_29_1.equips
					var_29_1.oil = 200
					var_29_1.ammo = 200
					var_29_1.type = var_29_6.type
					var_29_1.speed = var_29_6.speed
					var_29_1.skin_id = iter_29_1.skin
					var_29_1.skill_id = iter_29_1.now_skill
				end
			end

			var_0_16(self._enemys, {
				cid = var_29_2,
				character_id = var_29_3,
				pos = iter_29_0,
				level = var_29_1.level,
				luck = var_29_1.luck,
				hp = var_29_1.hp,
				equips = var_29_1.equipment,
				oil = var_29_1.oil,
				ammo = var_29_1.ammo,
				index = iter_29_0,
				ship_type = var_29_1.type,
				speed = var_29_1.speed,
				skin_id = 0,
				skill_id = var_29_1.skill_id,
				monster_type = var_29_0
			})
		end

		return self._enemys
	end

	function arg_1_0.get_character_intensify(arg_30_0, arg_30_1)
		return var_0_1:get_character_intensify(arg_30_1) or {}
	end

	function arg_1_0.get_character_attribute(arg_31_0, arg_31_1)
		return var_0_1:get_character_attribute(arg_31_1) or {}
	end

	function arg_1_0.get_character_equips(arg_32_0, arg_32_1)
		local var_32_0 = var_0_1:find_character_by_id(arg_32_1)

		if not var_32_0 then
			return {}
		end

		return var_32_0.equips
	end

	function arg_1_0.set_plot_character_equips(arg_33_0, arg_33_1)
		local var_33_0 = {}

		for iter_33_0, iter_33_1 in pairs(arg_33_1) do
			var_0_16(var_33_0, {
				num = 0,
				carry_type = 1,
				id = iter_33_1
			})
		end

		return var_33_0
	end

	function arg_1_0:has_submarine()
		return self:__is_submarine(self._enemys) or self:__is_submarine(self._players)
	end

	function arg_1_0.get_sixth_adjutant_buff_data(arg_35_0)
		return {}
	end

	function arg_1_0.get_main_map_fight_num(arg_36_0)
		return var_0_1:get_user_info().map_total
	end

	function arg_1_0.get_map_data_by_ship(arg_37_0)
		return (var_0_1:get_cardbook_ship_list())
	end

	function arg_1_0.__is_submarine(arg_38_0, arg_38_1)
		local var_38_0 = false

		for iter_38_0, iter_38_1 in pairs(arg_38_1) do
			if var_0_17:is_ship_submarine(iter_38_1.ship_type) then
				var_38_0 = true

				break
			end
		end

		return var_38_0
	end

	function arg_1_0.__get_avg_speed(arg_39_0, arg_39_1)
		local var_39_0 = 0
		local var_39_1 = 0
		local var_39_2 = 0
		local var_39_3 = 0
		local var_39_4 = 0
		local var_39_5 = 0
		local var_39_6 = 1
		local var_39_7 = 0
		local var_39_8 = 0
		local var_39_9 = 0

		for iter_39_0, iter_39_1 in pairs(arg_39_1) do
			local var_39_10, var_39_11 = var_0_17:get_avg_speed_class(iter_39_1.ship_type)

			if var_39_10 == "class1" then
				var_39_0 = var_39_0 + var_39_11 * iter_39_1.speed
				var_39_1 = var_39_1 + var_39_11
				var_39_6 = 0
			elseif var_39_10 == "class2" then
				var_39_2 = var_39_2 + var_39_11 * iter_39_1.speed
				var_39_3 = var_39_3 + var_39_11
				var_39_6 = 0
			elseif var_39_10 == "class3" then
				var_39_4 = var_39_4 + var_39_11 * iter_39_1.speed
				var_39_5 = var_39_5 + var_39_11
			end
		end

		if var_39_6 == 1 then
			var_39_7 = math.floor(var_39_4 / var_39_5)
		else
			if var_39_0 ~= 0 then
				var_39_8 = var_39_0 / var_39_1
				var_39_7 = var_39_0 / var_39_1
			end

			if var_39_2 ~= 0 then
				var_39_9 = var_39_2 / var_39_3
				var_39_7 = var_39_2 / var_39_3
			end

			if var_39_8 ~= 0 and var_39_9 ~= 0 then
				var_39_7 = math.floor(math.min(var_39_8, var_39_9))
			end
		end

		return var_39_7
	end
end

function var_0_0.extend_obj(arg_40_0)
	arg_40_0._monsters = nil
	arg_40_0._players = nil
	arg_40_0._enemys = nil
	arg_40_0._scene = nil
	arg_40_0._battle_type = var_0_17.fight_type.gotofight
end

return var_0_0
