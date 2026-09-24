return {
	init = function(arg_1_0)
		gamecore.start_register()

		for iter_1_0, iter_1_1 in pairs({
			{
				path = "battle_type",
				name = "battle_type"
			}
		}) do
			gamecore.register_enum(iter_1_1.name, arg_1_0("enum." .. iter_1_1.path))
		end

		for iter_1_2, iter_1_3 in pairs({
			{
				path = "core.BattleScene.missile_attack_step",
				name = "BattleScene"
			},
			{
				path = "core.BattleScene.normal_attack_step",
				name = "BattleScene"
			},
			{
				path = "core.BattleScene.torpedo_attack_step",
				name = "BattleScene"
			},
			{
				path = "core.BattleScene.aircraft_attack_step",
				name = "BattleScene"
			},
			{
				path = "core.BattleScene.antisub_attack_step",
				name = "BattleScene"
			},
			{
				path = "core.BattleScene.open_torpedo_step",
				name = "BattleScene"
			},
			{
				path = "core.BattleScene.skill_buff_step",
				name = "BattleScene"
			},
			{
				path = "core.BattleScene.night_attack_step",
				name = "BattleScene"
			},
			{
				path = "core.BattleScene.support_attack_step",
				name = "BattleScene"
			},
			{
				path = "core.BattleScene.event",
				name = "BattleScene"
			},
			{
				path = "core.BattleScene.base",
				name = "BattleScene"
			},
			{
				path = "core.BattleField.event",
				name = "BattleField"
			},
			{
				path = "core.BattleField.switch_fight_step",
				name = "BattleField"
			},
			{
				path = "core.BattleObjectManager.base",
				name = "BattleObjectManager"
			},
			{
				path = "core.BattleObjectManager.event",
				name = "BattleObjectManager"
			},
			{
				path = "core.BattleObjectManager.order",
				name = "BattleObjectManager"
			},
			{
				path = "object.character.base_attribute",
				name = "player_logic"
			},
			{
				path = "object.character.base_attack",
				name = "player_logic"
			},
			{
				path = "object.character.normal_attack",
				name = "player_logic"
			},
			{
				path = "object.character.aircraft_attack",
				name = "player_logic"
			},
			{
				path = "object.character.antisub_attack",
				name = "player_logic"
			},
			{
				path = "object.character.missile_attack",
				name = "player_logic"
			},
			{
				path = "object.character.torpedo_attack",
				name = "player_logic"
			},
			{
				path = "object.character.night_attack",
				name = "player_logic"
			},
			{
				path = "object.character.base_skill",
				name = "player_logic"
			},
			{
				path = "object.character.base_enemy_attribute",
				name = "enemy_logic"
			},
			{
				path = "object.character.base_attack",
				name = "enemy_logic"
			},
			{
				path = "object.character.normal_attack",
				name = "enemy_logic"
			},
			{
				path = "object.character.aircraft_attack",
				name = "enemy_logic"
			},
			{
				path = "object.character.antisub_attack",
				name = "enemy_logic"
			},
			{
				path = "object.character.missile_attack",
				name = "enemy_logic"
			},
			{
				path = "object.character.torpedo_attack",
				name = "enemy_logic"
			},
			{
				path = "object.character.night_attack",
				name = "enemy_logic"
			},
			{
				path = "object.character.base_skill",
				name = "enemy_logic"
			},
			{
				path = "skill.trigger.event",
				name = "trigger_logic"
			},
			{
				path = "skill.condition.event",
				name = "condition_logic"
			},
			{
				path = "skill.action.event",
				name = "action_logic"
			},
			{
				path = "skill.action.action_target",
				name = "action_logic"
			},
			{
				path = "tactics.event",
				name = "tactics_logic"
			},
			{
				path = "buffs.fightbuff.event",
				name = "buffs_logic"
			},
			{
				path = "buffs.towerbuff.event",
				name = "tower_buffs_logic"
			},
			{
				path = "buffs.ocean_cia_buffs.event",
				name = "ocean_cia_buffs_logic"
			},
			{
				path = "buffs.war_concerto_buffs.event",
				name = "war_concerto_buffs_logic"
			},
			{
				path = "buffs.solid_strike_buffs.event",
				name = "solid_strike_buffs_logic"
			},
			{
				path = "buffs.abyss_broken_buffs.event",
				name = "abyss_broken_buffs_logic"
			},
			{
				path = "buffs.push_map_buffs_logic.event",
				name = "push_map_buffs_logic"
			},
			{
				path = "buffs.seventh_buffs_logic.event",
				name = "seventh_buffs_logic"
			},
			{
				path = "buffs.score_push_buffs.event",
				name = "score_push_buffs_logic"
			},
			{
				path = "buffs.strike_score_solid_buff.event",
				name = "solid_score_strike_buffs_logic"
			},
			{
				path = "buffs.equip_entire_buffs.event",
				name = "equip_entire_buffs_logic"
			},
			{
				path = "buffs.equip_entire_buffs.enemy_event",
				name = "equip_entire_buffs_enemy_logic"
			},
			{
				path = "buffs.eighth_buffs_logic.event",
				name = "eighth_buffs_logic"
			},
			{
				path = "buffs.push_buffs.event",
				name = "push_buffs_logic"
			},
			{
				path = "buffs.ninth_push_buffs.event",
				name = "ninth_push_buffs_logic"
			},
			{
				path = "buffs.rank_support_buffs.event",
				name = "rank_support_buffs_logic"
			},
			{
				path = "damage.base",
				name = "damage_info"
			}
		}) do
			gamecore.register_class_extend(iter_1_3.name, "battle." .. iter_1_3.path)
		end

		for iter_1_4, iter_1_5 in pairs({
			{
				path = "core.BattleField",
				name = "BattleField"
			},
			{
				path = "core.BattleTime",
				name = "BattleTime"
			},
			{
				path = "core.BattleScene",
				name = "BattleScene"
			},
			{
				path = "core.BattleObjectManager",
				name = "BattleObjectManager"
			},
			{
				path = "core.OrderManager",
				name = "OrderManager"
			},
			{
				path = "core.BattleRandom",
				name = "BattleRandom"
			},
			{
				path = "core.BaseObject",
				name = "BaseObject"
			},
			{
				path = "damage.damage_info",
				name = "damage_info"
			},
			{
				path = "equip.equip_logic",
				name = "equip_logic"
			},
			{
				path = "skill.skill_logic",
				name = "skill_logic"
			},
			{
				path = "skill.trigger_logic",
				name = "trigger_logic"
			},
			{
				path = "skill.condition_logic",
				name = "condition_logic"
			},
			{
				path = "skill.action_logic",
				name = "action_logic"
			},
			{
				path = "object.object_logic_base",
				name = "object_logic_base"
			},
			{
				path = "object.character_logic",
				name = "character_logic"
			},
			{
				path = "object.player_logic",
				name = "player_logic"
			},
			{
				path = "object.enemy_logic",
				name = "enemy_logic"
			},
			{
				path = "attribute.attribute_item",
				name = "attribute_item"
			},
			{
				path = "object.aircraft.aircraft_logic",
				name = "aircraft_logic"
			},
			{
				path = "object.bomb.bomb_logic",
				name = "bomb_logic"
			},
			{
				path = "object.torpedo.torpedo_logic",
				name = "torpedo_logic"
			},
			{
				path = "object.missile.missile_logic",
				name = "missile_logic"
			},
			{
				path = "object.booster.booster_logic",
				name = "booster_logic"
			},
			{
				path = "object.projectile.projectile_logic",
				name = "projectile_logic"
			},
			{
				path = "object.depthcharge.depthcharge_logic",
				name = "depthcharge_logic"
			},
			{
				path = "tactics.tactics_logic",
				name = "tactics_logic"
			},
			{
				path = "buffs.fightbuff.buffs_logic",
				name = "buffs_logic"
			},
			{
				path = "buffs.towerbuff.tower_buffs_logic",
				name = "tower_buffs_logic"
			},
			{
				path = "buffs.ocean_cia_buffs.ocean_cia_buffs_logic",
				name = "ocean_cia_buffs_logic"
			},
			{
				path = "buffs.war_concerto_buffs.war_concerto_buffs_logic",
				name = "war_concerto_buffs_logic"
			},
			{
				path = "buffs.abyss_broken_buffs.abyss_broken_buffs_logic",
				name = "abyss_broken_buffs_logic"
			},
			{
				path = "buffs.solid_strike_buffs.solid_strike_buffs_logic",
				name = "solid_strike_buffs_logic"
			},
			{
				path = "buffs.push_map_buffs_logic.push_map_buffs_logic",
				name = "push_map_buffs_logic"
			},
			{
				path = "buffs.seventh_buffs_logic.seventh_buffs_logic",
				name = "seventh_buffs_logic"
			},
			{
				path = "buffs.score_push_buffs.score_push_buffs_logic",
				name = "score_push_buffs_logic"
			},
			{
				path = "buffs.strike_score_solid_buff.solid_score_strike_buffs_logic",
				name = "solid_score_strike_buffs_logic"
			},
			{
				path = "buffs.equip_entire_buffs.equip_entire_buffs_logic",
				name = "equip_entire_buffs_logic"
			},
			{
				path = "buffs.equip_entire_buffs.equip_entire_buffs_enemy_logic",
				name = "equip_entire_buffs_enemy_logic"
			},
			{
				path = "buffs.eighth_buffs_logic.eighth_buffs_logic",
				name = "eighth_buffs_logic"
			},
			{
				path = "buffs.push_buffs.push_buffs_logic",
				name = "push_buffs_logic"
			},
			{
				path = "buffs.ninth_push_buffs.ninth_push_buffs_logic",
				name = "ninth_push_buffs_logic"
			},
			{
				path = "buffs.rank_support_buffs.rank_support_buffs_logic",
				name = "rank_support_buffs_logic"
			}
		}) do
			gamecore.register_class_module(iter_1_5.name, "battle." .. iter_1_5.path)
		end

		for iter_1_6, iter_1_7 in pairs({
			{
				path = "utilfunc.battle_util",
				name = "battle_util"
			}
		}) do
			gamecore.register_class_module(iter_1_7.name, iter_1_7.path)
		end

		for iter_1_8, iter_1_9 in pairs({}) do
			gamecore.register_class_module(iter_1_9.name, "battle." .. iter_1_9.path)
		end

		gamecore.finish_register(arg_1_0)
	end
}
