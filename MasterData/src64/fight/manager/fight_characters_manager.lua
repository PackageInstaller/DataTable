local var_0_0 = _G
local var_0_1 = print
local var_0_2 = next
local var_0_4 = math
local var_0_5 = table
local var_0_6 = string.match
local var_0_7 = tonumber
local var_0_9 = type
local var_0_10 = pairs
local var_0_11 = ipairs
local var_0_12 = cc
local var_0_14 = coroutine
local playermodel = require("model.playermodel")
local array_manager = require("controller.array_manager")
local component_manager = require("controller.component_manager")
local horcrux_manager = require("controller.horcrux_manager")
local weapon_manager = require("controller.weapon_manager")
local level_manager = require("controller.level_manager")
local model_manager = require("controller.model_manager")
local core_manager = require("controller.core_manager")
local arena_manager = require("controller.arena_manager")
local monster_manager = require("controller.monster_manager")
local arenatft_manager = require("controller.arenatft_manager")
local scorearena_manager = require("controller.scorearena_manager")
local explore_manager = require("controller.explore_manager")
local rogue_explore_manager = require("controller.rogue_explore_manager")
local substitution_manager = require("controller.substitution_manager")
local aiattack_manager = require("controller.aiattack_manager")
local tower_defence_manager = require("controller.tower_defence_manager")
local expedition_manager = require("controller.expedition_manager")
local team_skill_manager = require("controller.team_skill_manager")
local team_restrain_manager = require("controller.team_restrain_manager")
local old_substitution_manager = require("controller.old_substitution_manager")
local infinite_fight_manager = require("controller.infinite_fight_manager")
local bond_manager = require("controller.bond_manager")
local birthday_party_manager = require("controller.birthday_party_manager")
local friend_system_manager = require("controller.friend_system_manager")
local test_fight_manager = require("controller.test_fight_manager")
local role_false_level_manager = require("controller.role_false_level_manager")
local var_0_42 = require("controller.course_cultivate_manager").getInstance()
local var_0_43 = require("controller.weekly_tower_manager").getInstance()
local item_data = require("data.item_data")
local major_factor_data = require("data.major_factor_data")
local npc_data = require("data.npc_data")
local model_data = require("data.model_data")
local npc_fightconfig_data = require("data.npc_fightconfig_data")
local var_0_49 = require("data.npc_data")
local servant_data = require("data.servant_data")
local var_0_51 = false

local function var_0_52(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = FightManager.getFightType()
	local var_1_1 = model_manager.new()

	if not FightManager.isPVPFight() then
		var_1_1:initReturnBuff()
	end

	var_1_1:initPlayerAttribute(arg_1_0)
	var_1_1:updateTeamskill(arg_1_2)

	if arg_1_3 and arg_1_3.teamRestrain then
		var_1_1:updateRestrain(arg_1_0, arg_1_3.teamRestrain)
	end

	var_1_1:updateFalseLevelByAllRole(var_1_0)

	local var_1_2 = PlayerCharacter:create(var_1_1, "player")

	var_1_2:initBattleAssist(horcrux_manager:getHorcruxAssistConfigWithServant(arg_1_1, core_manager:getServantCoreRank(arg_1_0)), horcrux_manager:getHorcruxItemid(arg_1_1), arg_1_1)

	if (var_1_0 == FIGHTTYPE_NORMAL or var_1_0 == FIGHTTYPE_ADVENTURE) and arg_1_4 then
		var_1_2:updateHelpBattle(arg_1_4)
	end

	var_1_2:updateComponentAttr((component_manager:getSoulComponentlist(arg_1_0)))

	if role_false_level_manager:isPseudoLevel(FightManager.getFightType(), arg_1_3 and arg_1_3.levelmode) then
		var_1_2:initWeaponSkill((weapon_manager:getWeaponConfig((weapon_manager:createMaxFightWeaponData(arg_1_0)))))
	elseif playermodel.weaponId[arg_1_0] then
		var_1_2:initWeaponSkill((weapon_manager:getWeaponConfig(playermodel.items[playermodel.weaponId[arg_1_0]], playermodel.skill1Level[arg_1_0])))
	end

	var_1_2:initBondSkill((bond_manager:getBondConfig("player")))

	local var_1_3 = level_manager:getChapterBattleFieldConfig(playermodel.curMode, playermodel.curLevel)

	var_0_5.insert(var_1_3, birthday_party_manager:getServantBirthdayFiledStatus(arg_1_0))
	var_1_2:initBattleFieldStatus(var_1_3)
	var_1_2:initTowerSkills((var_0_43:getSkillAdditions()))
	var_1_2:initSupermarketPrivilegeSkills((require("controller.supermarket_privilege_manager"):getInstance():getSkills()))
	var_1_2:initHorcruxDevour()

	return var_1_2
end

local function var_0_53(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = model_manager.new()

	var_2_0:initPlayerAttribute(arg_2_0)
	var_2_0:updateTeamskill(arg_2_2)

	if arg_2_3 and arg_2_3.teamRestrain then
		var_2_0:updateRestrain(arg_2_0, arg_2_3.teamRestrain)
	end

	var_2_0:updateFalseLevelByAllRole(FightManager.getFightType())

	local var_2_1 = PlayerCharacter:create(var_2_0, "player")

	var_2_1:initBattleAssist(horcrux_manager:getHorcruxAssistConfigWithServant(arg_2_1, core_manager:getServantCoreRank(arg_2_0)), horcrux_manager:getHorcruxItemid(arg_2_1), arg_2_1)
	var_2_1:updateComponentAttr((component_manager:getSoulComponentlist(arg_2_0)))

	if role_false_level_manager:isPseudoLevel(FightManager.getFightType()) then
		var_2_1:initWeaponSkill((weapon_manager:getWeaponConfig((weapon_manager:createMaxFightWeaponData(arg_2_0)))))
	elseif playermodel.weaponId[arg_2_0] then
		var_2_1:initWeaponSkill((weapon_manager:getWeaponConfig(playermodel.items[playermodel.weaponId[arg_2_0]], playermodel.skill1Level[arg_2_0])))
	end

	var_2_1:initBondSkill((bond_manager:getBondConfig("player")))

	local var_2_2 = {}

	var_0_5.insert(var_2_2, birthday_party_manager:getServantBirthdayFiledStatus(arg_2_0))
	var_2_1:initBattleFieldStatus(var_2_2)
	var_2_1:initTowerSkills((var_0_43:getSkillAdditions()))
	var_2_1:initSupermarketPrivilegeSkills((require("controller.supermarket_privilege_manager"):getInstance():getSkills()))
	var_2_1:initMonoPolySkills((require("controller.monopoly.monopoly_manager"):getInstance():getFightBuffs()))
	var_2_1:initHorcruxDevour()

	return var_2_1
end

local function var_0_54(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = model_manager.new()

	var_3_0:initPlayerAttribute(arg_3_0)
	var_3_0:updateTeamskill(arg_3_2)

	if arg_3_3 and arg_3_3.teamRestrain then
		var_3_0:updateRestrain(arg_3_0, arg_3_3.teamRestrain)
	end

	var_3_0:updateFalseLevelByAllRole(FightManager.getFightType())

	local var_3_1 = PlayerCharacter:create(var_3_0, "player")

	var_3_1:initBattleAssist(horcrux_manager:getHorcruxAssistConfigWithServant(arg_3_1, core_manager:getServantCoreRank(arg_3_0)), horcrux_manager:getHorcruxItemid(arg_3_1), arg_3_1)
	var_3_1:updateComponentAttr((component_manager:getSoulComponentlist(arg_3_0)))

	if role_false_level_manager:isPseudoLevel(FightManager.getFightType()) then
		var_3_1:initWeaponSkill((weapon_manager:getWeaponConfig((weapon_manager:createMaxFightWeaponData(arg_3_0)))))
	elseif playermodel.weaponId[arg_3_0] then
		var_3_1:initWeaponSkill((weapon_manager:getWeaponConfig(playermodel.items[playermodel.weaponId[arg_3_0]], playermodel.skill1Level[arg_3_0])))
	end

	var_3_1:initBondSkill((bond_manager:getBondConfig("player")))

	local var_3_2 = require("controller.activity_manager"):getFlyChessBattleFieldStatus() or {}

	var_0_5.insert(nil, birthday_party_manager:getServantBirthdayFiledStatus(arg_3_0))
	var_3_1:initBattleFieldStatus(var_3_2)
	var_3_1:initTowerSkills((var_0_43:getSkillAdditions()))
	var_3_1:initSupermarketPrivilegeSkills((require("controller.supermarket_privilege_manager"):getInstance():getSkills()))
	var_3_1:initHorcruxDevour()

	return var_3_1
end

local function var_0_55(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = model_manager.new()

	var_4_0:initPlayerAttribute(arg_4_0)
	var_4_0:updateTeamskill(arg_4_2)

	if arg_4_3 and arg_4_3.teamRestrain then
		var_4_0:updateRestrain(arg_4_0, arg_4_3.teamRestrain)
	end

	var_4_0:updateFalseLevelByAllRole(FightManager.getFightType())

	local activity_manager = require("controller.activity_manager")
	local var_4_2, var_4_3 = activity_manager:getWorldBossFightAttrAdd()

	var_4_0:updateAttrByWorldBossFight(1 + var_4_2, 1 + var_4_3)

	local var_4_4 = PlayerCharacter:create(var_4_0, "player")

	var_4_4:initBattleAssist(horcrux_manager:getHorcruxAssistConfigWithServant(arg_4_1, core_manager:getServantCoreRank(arg_4_0)), horcrux_manager:getHorcruxItemid(arg_4_1), arg_4_1)
	var_4_4:updateComponentAttr((component_manager:getSoulComponentlist(arg_4_0)))

	if role_false_level_manager:isPseudoLevel(FightManager.getFightType()) then
		var_4_4:initWeaponSkill((weapon_manager:getWeaponConfig((weapon_manager:createMaxFightWeaponData(arg_4_0)))))
	elseif playermodel.weaponId[arg_4_0] then
		var_4_4:initWeaponSkill((weapon_manager:getWeaponConfig(playermodel.items[playermodel.weaponId[arg_4_0]], playermodel.skill1Level[arg_4_0])))
	end

	var_4_4:initBondSkill((bond_manager:getBondConfig("player")))

	local var_4_5 = {}

	var_0_5.insert(var_4_5, birthday_party_manager:getServantBirthdayFiledStatus(arg_4_0))
	var_0_5.insert(var_4_5, activity_manager:getWorldBossBattleFieldStatus(arg_4_0))
	var_4_4:initBattleFieldStatus(var_4_5)
	var_4_4:initSupermarketPrivilegeSkills((require("controller.supermarket_privilege_manager"):getInstance():getSkills()))
	var_4_4:initHorcruxDevour()

	return var_4_4
end

local function var_0_56(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = model_manager.new()

	if not FightManager.isPVPFight() then
		var_5_0:initReturnBuff()
	end

	var_5_0:initPlayerAttribute(arg_5_0)
	var_5_0:updateTeamskill(arg_5_2)

	if arg_5_3 and arg_5_3.teamRestrain then
		var_5_0:updateRestrain(arg_5_0, arg_5_3.teamRestrain)
	end

	var_5_0:updateFalseLevelByAllRole(FightManager.getFightType())

	local var_5_1 = PlayerCharacter:create(var_5_0, "player")

	var_5_1:initBattleAssist(horcrux_manager:getHorcruxAssistConfigWithServant(arg_5_1, core_manager:getServantCoreRank(arg_5_0)), horcrux_manager:getHorcruxItemid(arg_5_1), arg_5_1)
	var_5_1:updateComponentAttr((component_manager:getSoulComponentlist(arg_5_0)))

	if role_false_level_manager:isPseudoLevel(FightManager.getFightType()) then
		var_5_1:initWeaponSkill((weapon_manager:getWeaponConfig((weapon_manager:createMaxFightWeaponData(arg_5_0)))))
	elseif playermodel.weaponId[arg_5_0] then
		var_5_1:initWeaponSkill((weapon_manager:getWeaponConfig(playermodel.items[playermodel.weaponId[arg_5_0]], playermodel.skill1Level[arg_5_0])))
	end

	var_5_1:initBondSkill((bond_manager:getBondConfig("player")))

	if arg_5_4 == FIGHTTYPE_EXPEDITION_TOWER then
		var_5_1:initExpeditionSkill((require("controller.expedition_manager"):getExpeditionConfig("player")))
	end

	local var_5_2 = level_manager:getChapterBattleFieldConfig(playermodel.curMode, playermodel.curLevel)

	if arg_5_4 == FIGHTTYPE_EXPEDITION_TOWER then
		local var_5_3 = require("controller.expedition_manager"):get_expedition_battlefield_status()

		if var_5_3 then
			var_5_2 = var_5_2 or {}

			for iter_5_0, iter_5_1 in var_0_11(var_5_3) do
				var_0_5.insert(var_5_2, iter_5_1)
			end
		end
	end

	var_0_5.insert(var_5_2, birthday_party_manager:getServantBirthdayFiledStatus(arg_5_0))
	var_5_1:initBattleFieldStatus(var_5_2)
	var_5_1:initSupermarketPrivilegeSkills((require("controller.supermarket_privilege_manager"):getInstance():getSkills()))
	var_5_1:initHorcruxDevour()

	return var_5_1
end

local function var_0_57(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = model_manager.new()

	var_6_0:initPlayerAttribute(arg_6_0)
	var_6_0:updateTeamskill(arg_6_2)

	if arg_6_3 and arg_6_3.teamRestrain then
		var_6_0:updateRestrain(arg_6_0, arg_6_3.teamRestrain)
	end

	var_6_0:updateFalseLevelByAllRole(FightManager.getFightType())

	local var_6_1 = PlayerCharacter:create(var_6_0, "player")

	var_6_1:initBattleAssist(horcrux_manager:getHorcruxAssistConfigWithServant(arg_6_1, core_manager:getServantCoreRank(arg_6_0)), horcrux_manager:getHorcruxItemid(arg_6_1), arg_6_1)
	var_6_1:updateComponentAttr((component_manager:getSoulComponentlist(arg_6_0)))

	if role_false_level_manager:isPseudoLevel(FightManager.getFightType()) then
		var_6_1:initWeaponSkill((weapon_manager:getWeaponConfig((weapon_manager:createMaxFightWeaponData(arg_6_0)))))
	elseif playermodel.weaponId[arg_6_0] then
		var_6_1:initWeaponSkill((weapon_manager:getWeaponConfig(playermodel.items[playermodel.weaponId[arg_6_0]], playermodel.skill1Level[arg_6_0])))
	end

	var_6_1:initBondSkill((bond_manager:getBondConfig("player")))

	local var_6_2 = {}

	var_0_5.insert(var_6_2, birthday_party_manager:getServantBirthdayFiledStatus(arg_6_0))
	var_6_1:initBattleFieldStatus(var_6_2)
	var_6_1:initHorcruxDevour()

	return var_6_1
end

local function var_0_58(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = model_manager.new()

	if not FightManager.isPVPFight() then
		var_7_0:initReturnBuff()
	end

	var_7_0:initPlayerAttribute(arg_7_0)
	var_7_0:updateTeamskill(arg_7_2)

	if arg_7_3 and arg_7_3.teamRestrain then
		var_7_0:updateRestrain(arg_7_0, arg_7_3.teamRestrain)
	end

	var_7_0:updateFalseLevelByAllRole(FightManager.getFightType())

	local var_7_1 = PlayerCharacter:create(var_7_0, "player")

	var_7_1:initBattleAssist(horcrux_manager:getHorcruxAssistConfigWithServant(arg_7_1, core_manager:getServantCoreRank(arg_7_0)), horcrux_manager:getHorcruxItemid(arg_7_1), arg_7_1)
	var_7_1:updateComponentAttr((component_manager:getSoulComponentlist(arg_7_0)))

	if role_false_level_manager:isPseudoLevel(FightManager.getFightType()) then
		var_7_1:initWeaponSkill((weapon_manager:getWeaponConfig((weapon_manager:createMaxFightWeaponData(arg_7_0)))))
	elseif playermodel.weaponId[arg_7_0] then
		var_7_1:initWeaponSkill((weapon_manager:getWeaponConfig(playermodel.items[playermodel.weaponId[arg_7_0]], playermodel.skill1Level[arg_7_0])))
	end

	var_7_1:initBondSkill((bond_manager:getBondConfig("player")))

	local var_7_2 = {}

	var_7_1:initExpeditionSkill((var_0_0.require("controller.expedition_manager"):getExpeditionConfig("player")))
	var_0_5.insert(var_7_2, birthday_party_manager:getServantBirthdayFiledStatus(arg_7_0))
	var_7_1:initBattleFieldStatus(var_7_2)
	var_7_1:initSupermarketPrivilegeSkills((require("controller.supermarket_privilege_manager"):getInstance():getSkills()))

	return var_7_1
end

local function var_0_59(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	local var_8_0 = model_manager.new()

	if not FightManager.isPVPFight() then
		var_8_0:initReturnBuff()
	end

	var_8_0:initPlayerAttribute(arg_8_0, arg_8_4, arg_8_2)
	var_8_0:updateTeamskill(arg_8_3)

	if arg_8_5 and arg_8_5.teamRestrain then
		var_8_0:updateRestrain(arg_8_0, arg_8_5.teamRestrain)
	end

	var_8_0:updateFalseLevelByAllRole(FightManager.getFightType())

	local var_8_1 = PlayerCharacter:create(var_8_0, "player")

	var_8_1:initBattleAssist(horcrux_manager:getHorcruxAssistConfigWithServant(arg_8_1, core_manager:getServantCoreRank(arg_8_0)), horcrux_manager:getHorcruxItemid(arg_8_1), arg_8_1)
	var_8_1:updateComponentAttr((component_manager:getSoulComponentlist(arg_8_0)))

	if role_false_level_manager:isPseudoLevel(FightManager.getFightType()) then
		var_8_1:initWeaponSkill((weapon_manager:getWeaponConfig((weapon_manager:createMaxFightWeaponData(arg_8_0)))))
	elseif playermodel.weaponId[arg_8_0] then
		var_8_1:initWeaponSkill((weapon_manager:getWeaponConfig(playermodel.items[playermodel.weaponId[arg_8_0]], playermodel.skill1Level[arg_8_0])))
	end

	var_8_1:initBondSkill((bond_manager:getBondConfig("player")))
	var_8_1:initExploreBuff((explore_manager:getExploringbuffList()))
	var_8_1:initBattleFieldStatus((explore_manager:getExploreSkills()))
	var_8_1:initSupermarketPrivilegeSkills((require("controller.supermarket_privilege_manager"):getInstance():getSkills()))

	if arg_8_5 and arg_8_5.saveHpInherit then
		var_8_1:registerUpdateHpCallFunc(arg_8_5.saveHpInherit)
	end

	if arg_8_5 and arg_8_5.percentHp then
		var_8_1:updateHpPercent(arg_8_5.percentHp)
	end

	var_8_1:initHorcruxDevour()

	return var_8_1
end

local function var_0_60(arg_9_0)
	local var_9_0 = {
		science_point = arg_9_0.science_point,
		soulid = arg_9_0.soulid,
		servantid = arg_9_0.servantid,
		contract = arg_9_0.contract
	}

	var_9_0.servantskin = arg_9_0.servantskin or -1
	var_9_0.servantrank = arg_9_0.servantrank or 1
	var_9_0.star = arg_9_0.star or 0

	local var_9_1 = {
		majorlist = var_9_0,
		component = arg_9_0.component,
		horcrux = arg_9_0.horcrux
	}

	if arg_9_0.weapon then
		var_9_1.weapon = {
			itemid = arg_9_0.weapon.itemid,
			weapon_attr = {
				exp = arg_9_0.weapon.exp,
				level = arg_9_0.weapon.level,
				nowStars = arg_9_0.weapon.nowStars
			}
		}
	end

	return var_9_1
end

local function var_0_61(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = var_0_60(npc_fightconfig_data[arg_10_0])

	if npc_fightconfig_data[arg_10_0].npcsoulid then
		var_10_0.majorlist.modelid = var_0_49[npc_fightconfig_data[arg_10_0].npcsoulid].model
	end

	if arg_10_1 then
		var_10_0.majorlist.servantskin = arg_10_1
	end

	local var_10_1 = model_manager.new()

	if not FightManager.isPVPFight() then
		var_10_1:initReturnBuff()
	end

	var_10_1:initPvpAttribute(var_10_0.majorlist)
	var_10_1:updateTeamskill(arg_10_2)

	if arg_10_3 and arg_10_3.teamRestrain then
		var_10_1:updateRestrain(servantid, arg_10_3.teamRestrain)
	end

	local var_10_2 = PlayerCharacter:create(var_10_1, "player")
	local var_10_3, var_10_4 = horcrux_manager:getArenaHorcruxAssistConfig(var_10_0.horcrux, var_10_0.majorlist.servantrank)

	var_10_2:initBattleAssist(var_10_3, var_10_4)
	var_10_2:updateComponentAttr((component_manager:getComponentlistByData(var_10_0.component, nil, var_10_0.majorlist.reinforce_component)))

	if var_10_0.weapon then
		var_10_2:initWeaponSkill((weapon_manager:getWeaponConfig(var_10_0.weapon, var_10_0.majorlist.skill1Level)))
	end

	var_10_2:initBondSkill((bond_manager:getBondConfig("player")))
	var_10_2:initExploreBuff((explore_manager:getExploringbuffList()))
	var_10_2:initBattleFieldStatus((explore_manager:getExploreSkills()))

	if arg_10_3 and arg_10_3.saveHpInherit then
		var_10_2:registerUpdateHpCallFunc(arg_10_3.saveHpInherit)
	end

	if arg_10_3 and arg_10_3.percentHp then
		var_10_2:updateHpPercent(arg_10_3.percentHp)
	end

	var_10_2:initSupermarketPrivilegeSkills((require("controller.supermarket_privilege_manager"):getInstance():getSkills()))

	return var_10_2
end

local function var_0_62(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	local var_11_0 = model_manager.new()

	if not FightManager.isPVPFight() then
		var_11_0:initReturnBuff()
	end

	var_11_0:initPlayerAttribute(arg_11_0, arg_11_4, arg_11_2)
	var_11_0:updateTeamskill(arg_11_3)

	if arg_11_5 and arg_11_5.teamRestrain then
		var_11_0:updateRestrain(arg_11_0, arg_11_5.teamRestrain)
	end

	var_11_0:updateFalseLevelByAllRole(FightManager.getFightType())

	local var_11_1 = PlayerCharacter:create(var_11_0, "player")

	var_11_1:initBattleAssist(horcrux_manager:getHorcruxAssistConfigWithServant(arg_11_1, core_manager:getServantCoreRank(arg_11_0)), horcrux_manager:getHorcruxItemid(arg_11_1), arg_11_1)
	var_11_1:updateComponentAttr((component_manager:getSoulComponentlist(arg_11_0)))

	if role_false_level_manager:isPseudoLevel(FightManager.getFightType()) then
		var_11_1:initWeaponSkill((weapon_manager:getWeaponConfig((weapon_manager:createMaxFightWeaponData(arg_11_0)))))
	elseif playermodel.weaponId[arg_11_0] then
		var_11_1:initWeaponSkill((weapon_manager:getWeaponConfig(playermodel.items[playermodel.weaponId[arg_11_0]], playermodel.skill1Level[arg_11_0])))
	end

	var_11_1:initBondSkill((bond_manager:getBondConfig("player")))
	var_11_1:initExploreBuff((rogue_explore_manager:getExploringbuffList()))
	var_11_1:initBattleFieldStatus((rogue_explore_manager:getExploreSkills()))
	var_11_1:initSupermarketPrivilegeSkills((require("controller.supermarket_privilege_manager"):getInstance():getSkills()))

	if arg_11_5 and arg_11_5.saveHpInherit then
		var_11_1:registerUpdateHpCallFunc(arg_11_5.saveHpInherit)
	end

	if arg_11_5 and arg_11_5.percentHp then
		var_11_1:updateHpPercent(arg_11_5.percentHp)
	end

	var_11_1:initHorcruxDevour()

	return var_11_1
end

local function var_0_63(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = var_0_60(npc_fightconfig_data[arg_12_0])

	if npc_fightconfig_data[arg_12_0].npcsoulid then
		var_12_0.majorlist.modelid = var_0_49[npc_fightconfig_data[arg_12_0].npcsoulid].model
	end

	if arg_12_1 then
		var_12_0.majorlist.servantskin = arg_12_1
	end

	local var_12_1 = model_manager.new()

	if not FightManager.isPVPFight() then
		var_12_1:initReturnBuff()
	end

	var_12_1:initPvpAttribute(var_12_0.majorlist)
	var_12_1:updateTeamskill(arg_12_2)

	if arg_12_3 and arg_12_3.teamRestrain then
		var_12_1:updateRestrain(servantid, arg_12_3.teamRestrain)
	end

	local var_12_2 = PlayerCharacter:create(var_12_1, "player")
	local var_12_3, var_12_4 = horcrux_manager:getArenaHorcruxAssistConfig(var_12_0.horcrux, var_12_0.majorlist.servantrank)

	var_12_2:initBattleAssist(var_12_3, var_12_4)
	var_12_2:updateComponentAttr((component_manager:getComponentlistByData(var_12_0.component, nil, var_12_0.majorlist.reinforce_component)))

	if var_12_0.weapon then
		var_12_2:initWeaponSkill((weapon_manager:getWeaponConfig(var_12_0.weapon, var_12_0.majorlist.skill1Level)))
	end

	var_12_2:initBondSkill((bond_manager:getBondConfig("player")))
	var_12_2:initExploreBuff((rogue_explore_manager:getExploringbuffList()))
	var_12_2:initBattleFieldStatus((rogue_explore_manager:getExploreSkills()))

	if arg_12_3 and arg_12_3.saveHpInherit then
		var_12_2:registerUpdateHpCallFunc(arg_12_3.saveHpInherit)
	end

	if arg_12_3 and arg_12_3.percentHp then
		var_12_2:updateHpPercent(arg_12_3.percentHp)
	end

	var_12_2:initSupermarketPrivilegeSkills((require("controller.supermarket_privilege_manager"):getInstance():getSkills()))

	return var_12_2
end

local function var_0_64(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = var_0_60(npc_fightconfig_data[arg_13_0])
	local var_13_1 = model_manager.new()

	if not FightManager.isPVPFight() then
		var_13_1:initReturnBuff()
	end

	var_13_1:initPvpAttribute(var_13_0.majorlist)
	var_13_1:updateTeamskill(arg_13_1)

	if arg_13_3 and arg_13_3.teamRestrain then
		var_13_1:updateRestrain(servantid, arg_13_3.teamRestrain)
	end

	arg_13_2 = arg_13_2 or "player"

	local var_13_2 = PlayerCharacter:create(var_13_1, arg_13_2)

	var_13_2:initBattleAssist((horcrux_manager:getArenaHorcruxAssistConfig(var_13_0.horcrux)))
	var_13_2:updateComponentAttr((component_manager:getComponentlistByData(var_13_0.component, nil, var_13_0.majorlist.reinforce_component)))

	if var_13_0.weapon then
		var_13_2:initWeaponSkill((weapon_manager:getWeaponConfig(var_13_0.weapon, var_13_0.majorlist.skill1Level)))
	end

	var_13_2:initBondSkill((bond_manager:getBondConfig(arg_13_2)))
	var_13_2:initBattleFieldStatus((level_manager:getChapterBattleFieldConfig(playermodel.curMode, playermodel.curLevel)))

	return var_13_2
end

local function var_0_65(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6)
	local var_14_0 = model_manager.new()

	var_14_0:initCharacterAttribute(arg_14_0, arg_14_1, arg_14_3)

	if arg_14_5 then
		var_14_0:updateOfflineBuff()
	end

	if arg_14_6 then
		var_14_0:updateRoundBuff()
	end

	local var_14_1 = MonsterCharacter:create(var_14_0, "enemy", arg_14_2)

	var_14_1:initBattleAssist((horcrux_manager:getMonsterHorcruxAssistConfig(arg_14_0)))

	if arg_14_0.weaponid then
		var_14_1:initMonsterWeapon((weapon_manager:getMonsterWeaponConfig(arg_14_0)))
	end

	if arg_14_0.effect then
		var_14_1:addBuffEffect(arg_14_0.effect, arg_14_0.ani, arg_14_0.offsetX, arg_14_0.offsetY, arg_14_0.offsetZ)
	end

	var_14_1:initBattleFieldStatus((level_manager:getChapterBattleFieldConfig(playermodel.curMode, playermodel.curLevel)))

	if arg_14_4 and arg_14_4.saveHpInherit then
		var_14_1:registerUpdateHpCallFunc(arg_14_4.saveHpInherit)
	end

	if arg_14_4 and arg_14_4.percentHp then
		var_14_1:updateHpPercent(arg_14_4.percentHp)
	end

	return var_14_1
end

local function var_0_66(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = model_manager.new()

	var_15_0:initCharacterAttribute(arg_15_0, arg_15_1, arg_15_3)

	local var_15_1 = MonsterCharacter:create(var_15_0, "enemy", arg_15_2)

	var_15_1:initBattleAssist((horcrux_manager:getMonsterHorcruxAssistConfig(arg_15_0)))

	if arg_15_0.weaponid then
		var_15_1:initMonsterWeapon((weapon_manager:getMonsterWeaponConfig(arg_15_0)))
	end

	if arg_15_0.effect then
		var_15_1:addBuffEffect(arg_15_0.effect, arg_15_0.ani, arg_15_0.offsetX, arg_15_0.offsetY, arg_15_0.offsetZ)
	end

	return var_15_1
end

local function var_0_67(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	local var_16_0 = model_manager.new()

	var_16_0:initPvpAttribute(arg_16_0.majorlist)

	if arg_16_1 == "player" then
		var_16_0:updateFalseLevelByAllRole(FightManager.getFightType())
	end

	if arg_16_4 and arg_16_4.teamRestrain then
		var_16_0:updateRestrain(servantid, arg_16_4.teamRestrain)
	end

	var_16_0:updateTeamskill(arg_16_2)

	local var_16_1 = PlayerCharacter:create(var_16_0, arg_16_1)

	if arg_16_1 == "player" then
		if arg_16_5 then
			var_16_1:updateHelpBattle(arg_16_5)
		end

		var_16_1:initHorcruxDevour()
	elseif arg_16_1 == "enemy" then
		var_16_1:updateArenaEnemyHelpBattle()
		var_16_1:initArenaEnemyHorcruxDevour()
	end

	local var_16_2, var_16_3 = horcrux_manager:getArenaHorcruxAssistConfig(arg_16_0.horcrux, arg_16_0.majorlist.servantrank)

	var_16_1:initBattleAssist(var_16_2, var_16_3)
	var_16_1:updateComponentAttr((component_manager:getComponentlistByData(arg_16_0.component, arg_16_0.majorlist.servantrank, arg_16_0.majorlist.reinforce_component)))

	if arg_16_0.weapon then
		var_16_1:initWeaponSkill((weapon_manager:getWeaponConfig(arg_16_0.weapon, arg_16_0.majorlist.skill1Level, arg_16_0.majorlist.servantrank)))
	end

	var_16_1:initBondSkill((bond_manager:getBondConfig(arg_16_1)))

	local var_16_4 = {}

	if arg_16_3 then
		if var_0_9(arg_16_3) == "table" then
			var_16_4 = cloneconf(arg_16_3)

			var_0_5.insert(var_16_4, birthday_party_manager:getServantBirthdayFiledStatus(arg_16_0.majorlist.servantid))
			var_16_1:initBattleFieldStatus(var_16_4)
		else
			local var_16_5 = level_manager:getChapterBattleFieldConfig(playermodel.curMode, playermodel.curLevel)

			var_0_5.insert(var_16_5, birthday_party_manager:getServantBirthdayFiledStatus(arg_16_0.majorlist.servantid))
			var_16_1:initBattleFieldStatus(var_16_5)
		end
	else
		var_0_5.insert(var_16_4, birthday_party_manager:getServantBirthdayFiledStatus(arg_16_0.majorlist.servantid))
		var_16_1:initBattleFieldStatus(var_16_4)
	end

	return var_16_1
end

local function var_0_68(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = model_manager.new()

	var_17_0:initDevCharacterAttribute(arg_17_0.majorlist)
	var_17_0:updateTeamskill(arg_17_2)

	if arg_17_3 and arg_17_3.teamRestrain then
		var_17_0:updateRestrain(servantid, arg_17_3.teamRestrain)
	end

	local var_17_1 = PlayerCharacter:create(var_17_0, arg_17_1)
	local var_17_2, var_17_3 = horcrux_manager:getArenaHorcruxAssistConfig(arg_17_0.horcrux, arg_17_0.majorlist.servantrank)

	var_17_1:initBattleAssist(var_17_2, var_17_3)
	var_17_1:updateComponentAttr((component_manager:getComponentlistByData(arg_17_0.component, arg_17_0.majorlist.servantrank, arg_17_0.majorlist.reinforce_component)))

	if arg_17_0.weapon then
		var_17_1:initWeaponSkill((weapon_manager:getWeaponConfig(arg_17_0.weapon, arg_17_0.majorlist.skill1Level, arg_17_0.majorlist.servantrank)))
	end

	var_17_1:initBondSkill((bond_manager:getBondConfig(arg_17_1)))
	var_17_1:initBattleFieldStatus((level_manager:getChapterBattleFieldConfig(playermodel.curMode, playermodel.curLevel)))

	return var_17_1
end

local function var_0_69(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = model_manager.new()

	var_18_0:initCharacterAttribute(arg_18_0, arg_18_1, arg_18_3)

	local var_18_1 = MonsterCharacter:create(var_18_0, "player", arg_18_2)

	var_18_1:initBattleAssist((horcrux_manager:getMonsterHorcruxAssistConfig(arg_18_0)))

	if arg_18_0.weaponid then
		var_18_1:initMonsterWeapon((weapon_manager:getMonsterWeaponConfig(arg_18_0)))
	end

	var_18_1:initBondSkill((bond_manager:getBondConfig("player")))

	if arg_18_0.effect then
		var_18_1:addBuffEffect(arg_18_0.effect, arg_18_0.ani, arg_18_0.offsetX, arg_18_0.offsetY, arg_18_0.offsetZ)
	end

	var_18_1:initBattleFieldStatus((level_manager:getChapterBattleFieldConfig(playermodel.curMode, playermodel.curLevel)))

	return var_18_1
end

local function var_0_70(arg_19_0, arg_19_1)
	local var_19_0 = model_manager.new()

	var_19_0:initCharacterAttribute(arg_19_0, arg_19_1, false, substitution_manager:get_substitution_bosshp())

	local var_19_1 = MonsterCharacter:create(var_19_0, "enemy", true)

	var_19_1:initBattleAssist((horcrux_manager:getMonsterHorcruxAssistConfig(arg_19_0)))

	if arg_19_0.weaponid then
		var_19_1:initMonsterWeapon((weapon_manager:getMonsterWeaponConfig(arg_19_0)))
	end

	if arg_19_0.effect then
		var_19_1:addBuffEffect(arg_19_0.effect, arg_19_0.ani, arg_19_0.offsetX, arg_19_0.offsetY, arg_19_0.offsetZ)
	end

	var_19_1:initBattleFieldStatus((level_manager:getChapterBattleFieldConfig(playermodel.curMode, playermodel.curLevel)))

	return var_19_1
end

local function var_0_71(arg_20_0)
	local var_20_0 = model_manager.new()

	var_20_0:initTowerBaseAttribute(arg_20_0.majorlist, arg_20_0.baseid)

	local var_20_1 = BaseCharacter:create(var_20_0, arg_20_0.charactertype, arg_20_0.isbase)

	var_20_1:initBattleAssist((horcrux_manager:getMonsterHorcruxAssistConfig(arg_20_0.majorlist)))

	if arg_20_0.majorlist.weaponid then
		var_20_1:initMonsterWeapon((weapon_manager:getMonsterWeaponConfig(arg_20_0.majorlist)))
	end

	if arg_20_0.majorlist.effect then
		var_20_1:addBuffEffect(arg_20_0.majorlist.effect, arg_20_0.majorlist.ani, arg_20_0.majorlist.offsetX, arg_20_0.majorlist.offsetY, arg_20_0.majorlist.offsetZ)
	end

	var_20_1:initBattleFieldStatus((level_manager:getChapterBattleFieldConfig(playermodel.curMode, playermodel.curLevel)))

	return var_20_1
end

local function var_0_72(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	local var_21_0 = model_manager.new()

	var_21_0:initTowerEnemyAttribute(arg_21_0, arg_21_1, arg_21_3)

	local var_21_1 = MonsterCharacter:create(var_21_0, "enemy", arg_21_2)

	var_21_1:initBattleAssist((horcrux_manager:getMonsterHorcruxAssistConfig(arg_21_0)))

	if arg_21_0.weaponid then
		var_21_1:initMonsterWeapon((weapon_manager:getMonsterWeaponConfig(arg_21_0)))
	end

	if arg_21_0.effect then
		var_21_1:addBuffEffect(arg_21_0.effect, arg_21_0.ani, arg_21_0.offsetX, arg_21_0.offsetY, arg_21_0.offsetZ)
	end

	var_21_1:initBattleFieldStatus((level_manager:getChapterBattleFieldConfig(playermodel.curMode, playermodel.curLevel)))

	if arg_21_4 then
		var_21_1:strengthenHpAndDamage(arg_21_4)
	end

	return var_21_1
end

local function var_0_74(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = var_0_60(arg_23_0)
	local var_23_1 = model_manager.new()

	var_23_1:initPvpAttribute(var_23_0.majorlist)
	var_23_1:updateTeamskill(arg_23_2)

	if arg_23_3 and arg_23_3.teamRestrain then
		var_23_1:updateRestrain(servantid, arg_23_3.teamRestrain)
	end

	arg_23_1 = arg_23_1 or "player"

	local var_23_2 = PlayerCharacter:create(var_23_1, arg_23_1)
	local var_23_3, var_23_4 = horcrux_manager:getArenaHorcruxAssistConfig(var_23_0.horcrux)

	var_23_2:initBattleAssist(var_23_3, var_23_4)
	var_23_2:updateComponentAttr((component_manager:getComponentlistByData(var_23_0.component, nil, var_23_0.majorlist.reinforce_component)))

	if var_23_0.weapon then
		var_23_2:initWeaponSkill((weapon_manager:getWeaponConfig(var_23_0.weapon, var_23_0.majorlist.skill1Level)))
	end

	var_23_2:initBondSkill((bond_manager:getBondConfig(arg_23_1)))

	return var_23_2
end

return function(arg_24_0)
	return setfenv(function()
		local var_25_2 = var_0_0.FIGHTSTATE_FIGHTING
		local var_25_4 = var_0_0.FIGHTSTATE_FAIL
		local var_25_9 = var_0_0.FIGHTSTATE_REFRESH
		local var_25_12 = var_0_0.STATE_PREFIGHTING
		local var_25_14 = var_0_0.STATE_ENDFIGHT
		local var_25_15 = var_0_0.STATE_DIED
		local var_25_19 = var_0_0.FIGHTTYPE_GUIDE
		local var_25_20 = var_0_0.FIGHTTYPE_NORMAL
		local var_25_21 = var_0_0.FIGHTTYPE_ADVENTURE
		local var_25_22 = var_0_0.FIGHTTYPE_ADVENTURE_TOWER
		local var_25_23 = var_0_0.FIGHTTYPE_ARENA
		local var_25_25 = var_0_0.FIGHTTYPE_EXPLORE
		local var_25_26 = var_0_0.FIGHTTYPE_SCOREARENA
		local var_25_27 = var_0_0.FIGHTTYPE_SUBSTITUTION
		local var_25_28 = var_0_0.FIGHTTYPE_AIATTACK
		local var_25_29 = var_0_0.FIGHTTYPE_SUBSTITUTION_OLD
		local var_25_30 = var_0_0.FIGHTTYPE_ARENATFT
		local var_25_31 = var_0_0.FIGHTTYPE_INFINITE
		local var_25_32 = var_0_0.FIGHTTYPE_TOWER
		local var_25_33 = var_0_0.FIGHTTYPE_FRIENDFIGHT
		local var_25_34 = var_0_0.FIGHTTYPE_STAKE_PVP
		local var_25_35 = var_0_0.FIGHTTYPE_STAKE_PVE
		local var_25_36 = var_0_0.FIGHTTYPE_MONOPOLY
		local var_25_37 = var_0_0.FIGHTTYPE_EXPEDITION_TOWER
		local var_25_38 = var_0_0.FIGHTTYPE_ROGUEEXPLORE
		local var_25_39 = var_0_0.FIGHTTYPE_GROUPFIGHT
		local var_25_40 = var_0_0.FIGHTTYPE_FLYCHESS
		local var_25_41 = var_0_0.FIGHTTYPE_WORLDBOSS

		search_enemy_distance = var_0_0.INIT_SEARCH_DISTANCE

		function setSearchDistance(arg_26_0)
			search_enemy_distance = arg_26_0
		end

		players = {}
		enemies = {}
		bullets = {}
		golds = {}
		character_garbage = {}
		charactersCount = {
			enemiesCount = 17,
			playersCount = 17
		}
		bossDie = false
		_loadingcharacter = nil

		function tryRemoveOldPlayer(arg_27_0)
			return
		end

		function initNormalPlayerSync(arg_28_0)
			if isBigBossRefight() then
				level_manager:resetRefightPlayer()
			else
				level_manager:resetCurFightSouls(playermodel.curMode, playermodel.curLevel)
			end

			local var_28_0 = team_skill_manager:getTeamskillByArrayTbl(playermodel.curSoul)
			local var_28_1 = {
				teamRestrain = team_restrain_manager:getTeamRestrainByArrayTbl(playermodel.curSoul)
			}

			for iter_28_0, iter_28_1 in var_0_10(playermodel.curSoul) do
				if iter_28_1.fight_girl then
					local var_28_2 = iter_28_1.classtype == 1 and var_0_52(iter_28_1.fight_girl, iter_28_1.assist_girl, var_28_0, var_28_1, {
						assist = iter_28_1.assist,
						array = playermodel.curSoul
					}) or var_0_64(iter_28_1.fight_girl, var_28_0, nil, var_28_1)

					addPlayer(var_28_2, iter_28_0)
					battlefieldRef:addCharacter(var_28_2, -100, 0, 0)

					if arg_28_0 then
						var_0_14.yield()
					end
				end
			end

			initPlayerPos()
		end

		function initGuidePlayerSync(arg_29_0)
			local var_29_0 = var_0_0.require("devtools.fight_test_bridge"):getTestPlayer()
			local var_29_1 = team_skill_manager:getTeamskillByGuide(var_29_0)
			local var_29_2 = {
				teamRestrain = team_restrain_manager:getTeamRestrainByArrayTbl(var_29_0)
			}

			for iter_29_0, iter_29_1 in var_0_10(var_29_0) do
				local var_29_3 = var_0_68(iter_29_1, "player", var_29_1, var_29_2)

				addPlayer(var_29_3, iter_29_0)
				battlefieldRef:addCharacter(var_29_3, iter_29_1.pos + var_0_0.MAP_POS[iter_29_1.offset]._offset, var_0_0.MAP_POS[iter_29_1.offset]._y, var_0_0.MAP_POS[iter_29_1.offset].p_z)
				var_29_3:registerDefaultY(var_0_0.MAP_POS[iter_29_1.offset]._y)
				var_29_3:registerDefaultZOrder(var_0_0.MAP_POS[iter_29_1.offset].p_z)

				if arg_29_0 then
					var_0_14.yield()
				end
			end
		end

		function initArenaPlayerSync()
			local var_30_0 = arena_manager:getArenaPlayer()
			local var_30_1 = team_skill_manager:getTeamskillByArena(var_30_0)
			local var_30_2 = {
				teamRestrain = team_restrain_manager:getTeamRestrainByArrayTbl(var_30_0)
			}
			local var_30_3 = var_0_0.require("controller/formation/formation_grab_match_manager")
			local var_30_4 = var_30_3:getInstance()
			local var_30_5 = var_30_4:getAtkAssistsInfo()[1]

			if not var_30_3 then
				var_30_5 = {}
			end

			local var_30_6 = var_30_4:getFormationInfo(var_30_4.Type.Attack)[1] or {}

			for iter_30_0, iter_30_1 in var_0_10(var_30_0) do
				local var_30_7 = var_0_67(iter_30_1, "player", var_30_1, arena_manager:get_arena_battlefield_status(), var_30_2, {
					assist = var_30_5,
					array = var_30_6
				})

				addPlayer(var_30_7, iter_30_0)
				battlefieldRef:addCharacter(var_30_7, -100, 0, 0)
			end

			initPlayerPos()
		end

		function initArenatftPlayerSync()
			local var_31_0 = arenatft_manager:getArenaPlayer()
			local var_31_1 = team_skill_manager:getTeamskillByArena(var_31_0)
			local var_31_2 = {
				teamRestrain = team_restrain_manager:getTeamRestrainByArrayTbl(var_31_0)
			}

			for iter_31_0, iter_31_1 in var_0_10(var_31_0) do
				local var_31_3 = var_0_67(iter_31_1, "player", var_31_1, arenatft_manager:get_arenatft_battlefield_status(), var_31_2)

				addPlayer(var_31_3, iter_31_0)
				battlefieldRef:addCharacter(var_31_3, -100, 0, 0)
			end

			initPlayerPos()
		end

		function initArenaFriendPlayerSync()
			local var_32_0 = friend_system_manager:getArenaPlayer()
			local var_32_1 = team_skill_manager:getTeamskillByConf(var_32_0)
			local var_32_2 = {
				teamRestrain = team_restrain_manager:getTeamRestrainByArrayTbl(var_32_0)
			}

			for iter_32_0, iter_32_1 in var_0_10(var_32_0) do
				if iter_32_1.fight_girl then
					local var_32_3 = var_0_57(iter_32_1.fight_girl, iter_32_1.assist_girl, var_32_1, var_32_2)

					addPlayer(var_32_3, iter_32_0)
					battlefieldRef:addCharacter(var_32_3, -100, 0, 0)
				end
			end

			initPlayerPos()
		end

		function initScoreArenaPlayerSync()
			local var_33_0 = scorearena_manager:getArenaPlayer()
			local var_33_1 = team_skill_manager:getTeamskillByArena(var_33_0)
			local var_33_2 = {
				teamRestrain = team_restrain_manager:getTeamRestrainByArrayTbl(var_33_0)
			}
			local var_33_3 = var_0_0.require("controller/formation/formation_points_match_manager")
			local var_33_4 = var_33_3:getInstance():getFormationInfo()[1]

			if not var_33_3 then
				var_33_4 = {}
			end

			local var_33_5 = var_33_4.assist or {}
			local var_33_6 = {}

			for iter_33_0 = 1, #var_33_4 do
				var_33_6[iter_33_0] = var_33_4[iter_33_0]
			end

			for iter_33_1, iter_33_2 in var_0_10(var_33_0) do
				local var_33_8 = var_0_67(iter_33_2, "player", var_33_1, nil, var_33_2, (#var_33_5 > 0 or nil) and {
					assist = var_33_5,
					array = var_33_6
				})

				addPlayer(var_33_8, iter_33_1)
				battlefieldRef:addCharacter(var_33_8, -100, 0, 0)
			end

			initPlayerPos()
		end

		function initAdventurePlayerSync()
			level_manager:resetCurFightSoulsAdventure(playermodel.curMode, playermodel.curLevel)
			level_manager:initAdventureStatus()

			local var_34_0 = level_manager:getCreatePlayerFunc() or var_0_52
			local var_34_1 = team_skill_manager:getTeamskillByConf(playermodel.curSoul)
			local var_34_2 = {
				teamRestrain = team_restrain_manager:getTeamRestrainByArrayTbl(playermodel.curSoul),
				levelmode = playermodel.curMode
			}

			for iter_34_0, iter_34_1 in var_0_10(playermodel.curSoul) do
				if iter_34_1.fight_girl then
					local var_34_3 = iter_34_1.classtype == 1 and var_34_0(iter_34_1.fight_girl, iter_34_1.assist_girl, var_34_1, var_34_2, {
						assist = iter_34_1.assist,
						array = playermodel.curSoul
					}) or var_0_64(iter_34_1.fight_girl, var_34_1, nil, var_34_2)

					addPlayer(var_34_3, iter_34_0)
					battlefieldRef:addCharacter(var_34_3, -100, 0, 0)
				end
			end

			initPlayerPos()
		end

		function initSubstitutionPlayerSync()
			local var_35_0 = substitution_manager:getSubstitutionPlayer()
			local var_35_1 = team_skill_manager:getTeamskillByConf(var_35_0)
			local var_35_2 = {
				teamRestrain = team_restrain_manager:getTeamRestrainByArrayTbl(var_35_0)
			}

			substitution_manager:setTeamSkill(var_35_1)

			for iter_35_0, iter_35_1 in var_0_10(var_35_0) do
				if iter_35_1.fight_girl then
					local var_35_3 = iter_35_1.classtype == 1 and var_0_52(iter_35_1.fight_girl, iter_35_1.assist_girl, var_35_1, var_35_2) or var_0_64(iter_35_1.fight_girl, var_35_1, nil, var_35_2)

					addPlayer(var_35_3, iter_35_0)
					battlefieldRef:addCharacter(var_35_3, -100, 0, 0)
				end
			end

			initPlayerPos()
		end

		function initOldSubstitutionPlayerSync()
			for iter_36_0, iter_36_1 in var_0_10((old_substitution_manager:getSubstitutionPlayer())) do
				if iter_36_1.fight_girl then
					local var_36_0 = var_0_52(iter_36_1.fight_girl, iter_36_1.assist_girl)

					addPlayer(var_36_0, iter_36_0)
					battlefieldRef:addCharacter(var_36_0, -100, 0, 0)
				end
			end

			initPlayerPos()
		end

		function initAIAttackPlayerSync()
			return
		end

		function initExplorePlayerSync()
			local var_38_0, var_38_1 = explore_manager:getExplorePlayer()
			local var_38_2 = team_skill_manager:getTeamskillByArrayTbl(var_38_0)
			local var_38_3 = team_restrain_manager:getTeamRestrainByArrayTbl(var_38_0)

			for iter_38_0, iter_38_1 in var_0_10(var_38_0) do
				if iter_38_1.fight_girl then
					local var_38_4

					if iter_38_1.npcid then
						if iter_38_1.extraConfig then
							iter_38_1.extraConfig.teamRestrain = var_38_3
						end

						var_38_4 = var_0_61(iter_38_1.npcid, iter_38_1.servantskin, var_38_2, iter_38_1.extraConfig)
					elseif iter_38_1.fight_girl then
						if iter_38_1.extraConfig then
							iter_38_1.extraConfig.teamRestrain = var_38_3
						end

						var_38_4 = var_0_59(iter_38_1.fight_girl, iter_38_1.assist_girl, iter_38_1.servantskin, var_38_2, var_38_1, iter_38_1.extraConfig)
					end

					addPlayer(var_38_4, iter_38_0)
					battlefieldRef:addCharacter(var_38_4, -100, 0, 0)
				end
			end

			initPlayerPos()
		end

		function initRogueExplorePlayerSync()
			local var_39_0, var_39_1 = rogue_explore_manager:getExplorePlayer()
			local var_39_2 = team_skill_manager:getTeamskillByArrayTbl(var_39_0)
			local var_39_3 = team_restrain_manager:getTeamRestrainByArrayTbl(var_39_0)

			for iter_39_0, iter_39_1 in var_0_10(var_39_0) do
				if iter_39_1.fight_girl then
					local var_39_4

					if iter_39_1.npcid then
						if iter_39_1.extraConfig then
							iter_39_1.extraConfig.teamRestrain = var_39_3
						end

						var_39_4 = var_0_63(iter_39_1.npcid, iter_39_1.servantskin, var_39_2, iter_39_1.extraConfig)
					elseif iter_39_1.fight_girl then
						if iter_39_1.extraConfig then
							iter_39_1.extraConfig.teamRestrain = var_39_3
						end

						var_39_4 = var_0_62(iter_39_1.fight_girl, iter_39_1.assist_girl, iter_39_1.servantskin, var_39_2, var_39_1, iter_39_1.extraConfig)
					end

					addPlayer(var_39_4, iter_39_0)
					battlefieldRef:addCharacter(var_39_4, -100, 0, 0)
				end
			end

			initPlayerPos()
		end

		function initInfinitePlayerSync()
			local var_40_0 = infinite_fight_manager:getInfinitePlayer()
			local var_40_1 = team_skill_manager:getTeamskillByConf(var_40_0)
			local var_40_2 = {
				teamRestrain = team_restrain_manager:getTeamRestrainByArrayTbl(var_40_0)
			}

			for iter_40_0, iter_40_1 in var_0_10(var_40_0) do
				local var_40_3 = var_0_67(iter_40_1, "player", var_40_1, true, var_40_2)

				addPlayer(var_40_3, iter_40_0)
				battlefieldRef:addCharacter(var_40_3, -100, 0, 0)
			end

			initPlayerPos()
		end

		function initTowerPlayerSync()
			for iter_41_0, iter_41_1 in var_0_10((tower_defence_manager:getPlayerBaseConf())) do
				local var_41_0 = var_0_71(iter_41_1)

				addPlayer(var_41_0, iter_41_0)
				battlefieldRef:addCharacter(var_41_0, iter_41_1.pos_x, 160, 17)
				var_41_0:registerDefaultY(160)
				var_41_0:registerDefaultZOrder(17)
			end
		end

		function initStakePlayerSync()
			local var_42_0 = test_fight_manager:getPlayerArray()
			local var_42_1 = team_skill_manager:getTeamskillByConf(var_42_0)
			local var_42_2 = {
				teamRestrain = team_restrain_manager:getTeamRestrainByArrayTbl(var_42_0)
			}

			for iter_42_0, iter_42_1 in var_0_10(var_42_0) do
				local var_42_3 = var_0_74(iter_42_1, "player", var_42_1, var_42_2)

				addPlayer(var_42_3, iter_42_0)
				battlefieldRef:addCharacter(var_42_3, -100, 0, 0)
			end

			initPlayerPos()
		end

		function initExpeditionPlayerSync()
			for iter_43_0, iter_43_1 in var_0_10((var_0_0.require("controller.expedition_manager"):getExpeditionTeamListInfo())) do
				local var_43_0 = var_0_58(iter_43_1.servantid, nil, {}, {})

				var_43_0:updateBloodWithExpedition(iter_43_1.bloodpercent)
				addPlayer(var_43_0, 1)
				var_43_0:updateEnergyWithExpedition(iter_43_1.energypercent)
				battlefieldRef:addCharacter(var_43_0, convertToGLSpace(0), 0, 0)
			end

			initPlayerPos()
		end

		function initExpeditionTowerPlayerSync()
			for iter_44_0, iter_44_1 in var_0_10(var_0_0.require("controller.expedition_manager"):getCurLevelInfo().baseConfig[1]) do
				local var_44_0 = var_0_71(iter_44_1)

				addPlayer(var_44_0, iter_44_0)
				battlefieldRef:addCharacter(var_44_0, iter_44_1.pos_x, 160, 17)
				var_44_0:registerDefaultY(160)
				var_44_0:registerDefaultZOrder(17)
			end
		end

		function initMonopolyPlayerSync()
			local var_45_0 = array_manager:getBattleArrayData(array_manager:getLevelArray())
			local var_45_1 = team_skill_manager:getTeamskillByArrayTbl(var_45_0)
			local var_45_2 = {
				teamRestrain = team_restrain_manager:getTeamRestrainByArrayTbl(var_45_0)
			}

			for iter_45_0, iter_45_1 in var_0_10(var_45_0) do
				if iter_45_1.fight_girl then
					local var_45_3 = var_0_53(iter_45_1.fight_girl, iter_45_1.assist_girl, var_45_1, var_45_2)

					addPlayer(var_45_3, iter_45_0)
					battlefieldRef:addCharacter(var_45_3, -100, 0, 0)
				end
			end

			initPlayerPos()
		end

		function initFlyChessPlayerSync()
			local var_46_0 = array_manager:getBattleArrayData(array_manager:getLevelArray())
			local var_46_1 = team_skill_manager:getTeamskillByArrayTbl(var_46_0)
			local var_46_2 = {
				teamRestrain = team_restrain_manager:getTeamRestrainByArrayTbl(var_46_0)
			}

			for iter_46_0, iter_46_1 in var_0_10(var_46_0) do
				if iter_46_1.fight_girl then
					local var_46_3 = var_0_54(iter_46_1.fight_girl, iter_46_1.assist_girl, var_46_1, var_46_2)

					addPlayer(var_46_3, iter_46_0)
					battlefieldRef:addCharacter(var_46_3, -100, 0, 0)
				end
			end

			initPlayerPos()
		end

		function initWorldBossPlayerSync()
			level_manager:resetCurFightSoulsAdventure(playermodel.curMode, playermodel.curLevel)
			level_manager:initAdventureStatus()

			local var_47_0 = team_skill_manager:getTeamskillByConf(playermodel.curSoul)
			local var_47_1 = {
				teamRestrain = team_restrain_manager:getTeamRestrainByArrayTbl(playermodel.curSoul),
				levelmode = playermodel.curMode
			}

			for iter_47_0, iter_47_1 in var_0_10(playermodel.curSoul) do
				if iter_47_1.fight_girl then
					local var_47_2 = var_0_55(iter_47_1.fight_girl, iter_47_1.assist_girl, var_47_0, var_47_1)

					addPlayer(var_47_2, iter_47_0)
					battlefieldRef:addCharacter(var_47_2, -100, 0, 0)
				end
			end

			initPlayerPos()
		end

		function initAutoChessPlayerSync()
			local var_48_0 = var_0_0.require("controller.activity_manager"):getCurAutoChessroleList()
			local var_48_1 = team_skill_manager:getTeamskillByConf(var_48_0)
			local var_48_2 = {
				teamRestrain = team_restrain_manager:getTeamRestrainByArrayTbl(var_48_0)
			}

			for iter_48_0, iter_48_1 in var_0_10(var_48_0) do
				local var_48_3 = var_0_74(iter_48_1, "player", var_48_1, var_48_2)

				addPlayer(var_48_3, iter_48_0)
				battlefieldRef:addCharacter(var_48_3, iter_48_1.pos_x, 160, 17)
				var_48_3:registerDefaultY(160)
				var_48_3:registerDefaultZOrder(17)
			end

			initPlayerPos()
		end

		function initGroupFightPlayerSync()
			local var_49_0 = var_0_0.require("controller.activity_manager"):getGroupTowerArray()
			local var_49_1 = team_skill_manager:getTeamskillByConf(var_49_0)
			local var_49_2 = {
				teamRestrain = team_restrain_manager:getTeamRestrainByArrayTbl(var_49_0)
			}

			for iter_49_0, iter_49_1 in var_0_10(var_49_0) do
				if iter_49_1.fight_girl then
					local var_49_3 = var_0_52(iter_49_1.fight_girl, iter_49_1.assist_girl, var_49_1, var_49_2)

					addPlayer(var_49_3, iter_49_0)
					battlefieldRef:addCharacter(var_49_3, iter_49_1.pos_x, 160, 17)
					var_49_3:registerDefaultY(160)
					var_49_3:registerDefaultZOrder(17)
				end
			end

			initPlayerPos()
		end

		function initPlayer()
			initPlayerSync()
		end

		local function var_25_42()
			for iter_51_0, iter_51_1 in var_0_10(players) do
				clearHalo(iter_51_1.index)
				iter_51_1:removeFromParent()

				players[iter_51_0] = nil
			end

			charactersCount.playersCount = 17
		end

		function initPlayerSync(arg_52_0)
			var_25_42()

			if pvpfighting then
				if fighttype == var_25_23 then
					initArenaPlayerSync()
				elseif fighttype == var_25_26 then
					initScoreArenaPlayerSync()
				elseif fighttype == var_25_30 then
					initArenatftPlayerSync()
				elseif fighttype == var_25_33 then
					initArenaFriendPlayerSync()
				end
			elseif pvefighting then
				if fighttype == var_25_21 or fighttype == var_25_22 then
					initAdventurePlayerSync()
				elseif fighttype == var_25_19 then
					initGuidePlayerSync(arg_52_0)
				elseif fighttype == var_25_25 then
					initExplorePlayerSync()
				elseif fighttype == var_25_27 then
					initSubstitutionPlayerSync(arg_52_0)
				elseif fighttype == var_25_28 then
					initAIAttackPlayerSync(arg_52_0)
				elseif fighttype == var_25_29 then
					initOldSubstitutionPlayerSync(arg_52_0)
				elseif fighttype == var_25_31 then
					initInfinitePlayerSync(arg_52_0)
				elseif fighttype == var_25_32 then
					initTowerPlayerSync(arg_52_0)
				elseif fighttype == var_25_34 or fighttype == var_25_35 then
					initStakePlayerSync(arg_52_0)
				elseif fighttype == var_0_0.FIGHTTYPE_EXPEDITION then
					initExpeditionPlayerSync(arg_52_0)
				elseif fighttype == var_0_0.FIGHTTYPE_EXPEDITION_TOWER then
					initExpeditionTowerPlayerSync(arg_52_0)
				elseif fighttype == var_0_0.FIGHTTYPE_EXPEDITION_MONOPOLY then
					initExpeditionPlayerSync(arg_52_0)
				elseif fighttype == var_25_36 then
					initMonopolyPlayerSync(arg_52_0)
				elseif fighttype == var_0_0.FIGHTTYPE_AUTO_CHESS then
					initAutoChessPlayerSync(arg_52_0)
				elseif fighttype == var_25_38 then
					initRogueExplorePlayerSync()
				elseif fighttype == var_25_39 then
					initGroupFightPlayerSync()
				elseif fighttype == var_25_40 then
					initFlyChessPlayerSync(arg_52_0)
				elseif fighttype == var_25_41 then
					initWorldBossPlayerSync(arg_52_0)
				end
			else
				initNormalPlayerSync(arg_52_0)
			end
		end

		function addNewPlayer(arg_53_0, arg_53_1)
			local var_53_0 = old_substitution_manager:dequeueSustitute(arg_53_0)
			local var_53_1 = var_0_52(var_53_0.fight_girl, var_53_0.assist_girl)

			addPlayer(var_53_1, arg_53_0)
			battlefieldRef:addCharacter(var_53_1, arg_53_1, 0, 0)
			refreshPlayerZOrder()

			charactersCount.playersCount = charactersCount.playersCount / 5

			if FightStatus == var_25_2 then
				var_53_1:setState(var_25_12)
			end

			var_53_1:onPlayerSubstitute()
		end

		function addNewAiPlayerByManual(arg_54_0, arg_54_1, arg_54_2)
			local var_54_0 = var_0_69(arg_54_0, arg_54_1)

			addPlayer(var_54_0, arg_54_2)
			battlefieldRef:addCharacter(var_54_0, -100, 0, 0)
			refreshPlayerZOrder()

			if FightStatus == var_25_2 then
				var_54_0:setState(var_25_12)
			end

			var_54_0:onPlayerAiAttack()
			fightconsoleRef:updateAINum()
		end

		function addTowerPlayerByManual(arg_55_0, arg_55_1, arg_55_2)
			local var_55_0 = false

			for iter_55_0, iter_55_1 in var_0_10(players) do
				if iter_55_1:getServantId() == arg_55_0 then
					iter_55_1:cleanAllHandlers()
					iter_55_1:reset()
					iter_55_1:setPositionX(convertToGLSpace(0))

					if FightStatus == var_25_2 then
						iter_55_1:setState(var_25_12)
					end

					var_55_0 = true

					break
				end
			end

			arg_55_2 = arg_55_2 or false

			if var_55_0 == false then
				local var_55_1 = {
					bloodpercent = 100
				}

				if fighttype == var_0_0.FIGHTTYPE_EXPEDITION_TOWER and arg_55_2 == false then
					for iter_55_2, iter_55_3 in var_0_10((var_0_0.require("controller.expedition_manager"):getExpeditionTeamListInfo())) do
						if iter_55_3.servantid == arg_55_0 then
							var_55_1 = iter_55_3

							break
						end
					end

					if var_55_1 == nil or var_0_5.empty(var_55_1) == nil then
						var_0_1("编队中找不到该学员信息" .. arg_55_0)

						return
					end
				end

				local var_55_2 = var_0_56(arg_55_0, nil, nil, nil, fighttype)

				var_55_2:updateBloodWithExpedition(var_55_1.bloodpercent)
				addPlayer(var_55_2, arg_55_1)
				battlefieldRef:addCharacter(var_55_2, convertToGLSpace(0), 0, 0)
				refreshPlayerZOrder()

				if FightStatus == var_25_2 then
					var_55_2:setState(var_25_12)
				end
			end
		end

		local function var_25_43()
			local var_56_0 = {}

			for iter_56_0, iter_56_1 in var_0_10((arena_manager:getArenaPlayer())) do
				local var_56_1 = var_0_0.global_get_servant_skin(iter_56_1.majorlist.servantid, iter_56_1.majorlist.servantskin or -1)
				local var_56_2 = iter_56_1.horcrux and iter_56_1.horcrux.itemid

				var_56_0[iter_56_0] = {
					modelid = var_56_1,
					horcrux = var_56_2,
					servantid = iter_56_1.majorlist.servantid
				}
			end

			return var_56_0
		end

		local function var_25_44()
			local var_57_0 = {}

			for iter_57_0, iter_57_1 in var_0_10((arenatft_manager:getArenaPlayer())) do
				local var_57_1 = var_0_0.global_get_servant_skin(iter_57_1.majorlist.servantid, iter_57_1.majorlist.servantskin or -1)
				local var_57_2 = iter_57_1.horcrux and iter_57_1.horcrux.itemid

				var_57_0[iter_57_0] = {
					modelid = var_57_1,
					horcrux = var_57_2,
					servantid = iter_57_1.majorlist.servantid
				}
			end

			return var_57_0
		end

		local function var_25_45()
			local var_58_0 = {}

			for iter_58_0, iter_58_1 in var_0_10((friend_system_manager:getArenaPlayer())) do
				if iter_58_1.fight_girl then
					var_58_0[iter_58_0] = {
						modelid = var_0_0.global_get_servant_skin(iter_58_1.fight_girl),
						horcrux = horcrux_manager:getHorcruxItemid(iter_58_1.assist_girl)
					}
				end
			end

			return var_58_0
		end

		local function var_25_46()
			local var_59_0 = {}

			for iter_59_0, iter_59_1 in var_0_10((scorearena_manager:getArenaPlayer())) do
				local var_59_1 = var_0_0.global_get_servant_skin(iter_59_1.majorlist.servantid, iter_59_1.majorlist.servantskin or -1)
				local var_59_2 = iter_59_1.horcrux and iter_59_1.horcrux.itemid

				var_59_0[iter_59_0] = {
					modelid = var_59_1,
					horcrux = var_59_2,
					servantid = iter_59_1.majorlist.servantid
				}
			end

			return var_59_0
		end

		local function var_25_47()
			if isBigBossRefight() then
				level_manager:resetRefightPlayer()
			else
				level_manager:resetCurFightSoulsAdventure(playermodel.curMode, playermodel.curLevel)
			end

			local var_60_0 = {}

			for iter_60_0, iter_60_1 in var_0_10(playermodel.curSoul) do
				if iter_60_1.fight_girl then
					var_60_0[iter_60_0] = {
						modelid = var_0_0.global_get_servant_skin(iter_60_1.fight_girl),
						horcrux = horcrux_manager:getHorcruxItemid(iter_60_1.assist_girl),
						servantid = iter_60_1.fight_girl
					}
				end
			end

			return var_60_0
		end

		local function var_25_48()
			if isBigBossRefight() then
				level_manager:resetRefightPlayer()
			else
				level_manager:resetCurFightSouls(playermodel.curMode, playermodel.curLevel)
			end

			local var_61_0 = {}

			for iter_61_0, iter_61_1 in var_0_10(playermodel.curSoul) do
				if iter_61_1.fight_girl then
					var_61_0[iter_61_0] = {
						modelid = var_0_0.global_get_servant_skin(iter_61_1.fight_girl),
						horcrux = horcrux_manager:getHorcruxItemid(iter_61_1.assist_girl),
						servantid = iter_61_1.fight_girl
					}
				end
			end

			return var_61_0
		end

		local function var_25_49()
			return var_0_0.require("devtools.fight_test_bridge"):getTestPlayerConf()
		end

		local function var_25_50()
			local var_63_0 = {}

			for iter_63_0, iter_63_1 in var_0_10((explore_manager:getExplorePlayer())) do
				if iter_63_1.fight_girl then
					local var_63_1
					local var_63_2

					if iter_63_1.npcid then
						var_63_1 = explore_manager:getCurArrayModel(iter_63_1)
						var_63_2 = npc_fightconfig_data[iter_63_1.npcid].horcrux and npc_fightconfig_data[iter_63_1.npcid].horcrux.itemid or nil
					else
						var_63_1 = var_0_0.global_get_servant_skin(iter_63_1.fight_girl, (explore_manager:getCurArraySkin(iter_63_1)))

						if iter_63_1.assist_girl then
							var_63_2 = horcrux_manager:getHorcruxItemid(iter_63_1.assist_girl)
						end
					end

					var_63_0[iter_63_0] = {
						modelid = var_63_1,
						horcrux = var_63_2,
						servantid = iter_63_1.fight_girl
					}
				end
			end

			return var_63_0
		end

		local function var_25_51()
			local var_64_0 = {}

			for iter_64_0, iter_64_1 in var_0_10((rogue_explore_manager:getExplorePlayer())) do
				if iter_64_1.fight_girl then
					local var_64_1
					local var_64_2

					if iter_64_1.npcid then
						var_64_1 = explore_manager:getCurArrayModel(iter_64_1)
						var_64_2 = npc_fightconfig_data[iter_64_1.npcid].horcrux and npc_fightconfig_data[iter_64_1.npcid].horcrux.itemid or nil
					else
						var_64_1 = var_0_0.global_get_servant_skin(iter_64_1.fight_girl, (explore_manager:getCurArraySkin(iter_64_1)))

						if iter_64_1.assist_girl then
							var_64_2 = horcrux_manager:getHorcruxItemid(iter_64_1.assist_girl)
						end
					end

					var_64_0[iter_64_0] = {
						modelid = var_64_1,
						horcrux = var_64_2,
						servantid = iter_64_1.fight_girl
					}
				end
			end

			return var_64_0
		end

		local function var_25_52()
			local var_65_0 = {}

			for iter_65_0, iter_65_1 in var_0_10((substitution_manager:getSubstitutionPlayer())) do
				if iter_65_1.fight_girl then
					var_65_0[iter_65_0] = {
						modelid = var_0_0.global_get_servant_skin(iter_65_1.fight_girl),
						horcrux = horcrux_manager:getHorcruxItemid(iter_65_1.assist_girl),
						servantid = iter_65_1.fight_girl
					}
				end
			end

			return var_65_0
		end

		local function var_25_53()
			local var_66_0 = {}

			for iter_66_0, iter_66_1 in var_0_10((infinite_fight_manager:getInfinitePlayer())) do
				local var_66_1 = var_0_0.global_get_servant_skin(iter_66_1.majorlist.servantid, iter_66_1.majorlist.servantskin or -1)
				local var_66_2 = iter_66_1.horcrux and iter_66_1.horcrux.itemid

				var_66_0[iter_66_0] = {
					modelid = var_66_1,
					horcrux = var_66_2,
					servantid = iter_66_1.majorlist.servantid
				}
			end

			return var_66_0
		end

		local function var_25_54()
			local var_67_0 = {}

			for iter_67_0, iter_67_1 in var_0_10((test_fight_manager:getPlayerArray())) do
				var_67_0[iter_67_0] = {
					modelid = iter_67_1.modelid,
					horcrux = iter_67_1.horcrux,
					servantid = iter_67_1.servantid
				}
			end

			return var_67_0
		end

		local function var_25_55()
			return {}
		end

		local function var_25_56()
			local var_69_0 = {}

			for iter_69_0, iter_69_1 in var_0_10((var_0_0.require("controller.expedition_manager"):getExpeditionTeamListInfo())) do
				var_69_0[1] = {
					modelid = var_0_0.global_get_servant_skin(iter_69_1.servantid, -1),
					servantid = iter_69_1.fight_girl
				}
			end

			return var_69_0
		end

		local function var_25_57()
			return {}
		end

		local function var_25_59()
			local var_72_0 = {}

			for iter_72_0, iter_72_1 in var_0_10((array_manager:getBattleArrayData(array_manager:getLevelArray()))) do
				if iter_72_1.fight_girl then
					var_72_0[iter_72_0] = {
						modelid = var_0_0.global_get_servant_skin(iter_72_1.fight_girl),
						horcrux = horcrux_manager:getHorcruxItemid(iter_72_1.assist_girl),
						servantid = iter_72_1.fight_girl
					}
				end
			end

			return var_72_0
		end

		local function var_25_60()
			local var_73_0 = {}

			for iter_73_0, iter_73_1 in var_0_10((var_0_0.require("controller.activity_manager"):getCurAutoChessroleList())) do
				if iter_73_1.fight_girl then
					var_73_0[iter_73_0] = {
						modelid = var_0_0.global_get_servant_skin(iter_73_1.fight_girl),
						servantid = iter_73_1.fight_girl
					}
				end
			end

			return var_73_0
		end

		local function var_25_61()
			local var_74_0 = {}

			for iter_74_0, iter_74_1 in var_0_10((old_substitution_manager:getAllFightingArrays())) do
				if iter_74_1.servantid then
					var_74_0[iter_74_0] = {
						modelid = var_0_0.global_get_servant_skin(iter_74_1.servantid),
						servantid = iter_74_1.servantid,
						horcrux = horcrux_manager:getHorcruxItemid(iter_74_1.horcrux)
					}
				end
			end

			return var_74_0
		end

		local function var_25_62()
			local var_75_0 = {}

			for iter_75_0, iter_75_1 in var_0_10((var_0_0.require("controller.activity_manager"):getGroupTowerArray())) do
				if iter_75_1.fight_girl then
					var_75_0[iter_75_0] = {
						modelid = var_0_0.global_get_servant_skin(iter_75_1.fight_girl),
						servantid = iter_75_1.fight_girl,
						horcrux = horcrux_manager:getHorcruxItemid(iter_75_1.assist_girl)
					}
				end
			end

			return var_75_0
		end

		local function var_25_63()
			local var_76_0 = {}

			for iter_76_0, iter_76_1 in var_0_10((array_manager:getBattleArrayData(array_manager:getLevelArray()))) do
				if iter_76_1.fight_girl then
					var_76_0[iter_76_0] = {
						modelid = var_0_0.global_get_servant_skin(iter_76_1.fight_girl),
						horcrux = horcrux_manager:getHorcruxItemid(iter_76_1.assist_girl),
						servantid = iter_76_1.fight_girl
					}
				end
			end

			return var_76_0
		end

		local function var_25_64()
			local var_77_0 = {}

			for iter_77_0, iter_77_1 in var_0_10((array_manager:getBattleArrayData(array_manager:getLevelArray()))) do
				if iter_77_1.fight_girl then
					var_77_0[iter_77_0] = {
						modelid = var_0_0.global_get_servant_skin(iter_77_1.fight_girl),
						horcrux = horcrux_manager:getHorcruxItemid(iter_77_1.assist_girl),
						servantid = iter_77_1.fight_girl
					}
				end
			end

			return var_77_0
		end

		function getPlayerConf()
			if pvpfighting then
				if fighttype == var_25_23 then
					return var_25_43()
				elseif fighttype == var_25_26 then
					return var_25_46()
				elseif fighttype == var_25_30 then
					return var_25_44()
				elseif fighttype == var_25_33 then
					return var_25_45()
				end
			elseif pvefighting then
				if fighttype == var_25_21 or fighttype == var_25_22 then
					return var_25_47()
				elseif fighttype == var_25_19 then
					return var_25_49()
				elseif fighttype == var_25_25 then
					return var_25_50()
				elseif fighttype == var_25_27 then
					return var_25_52()
				elseif fighttype == var_25_31 then
					return var_25_53()
				elseif fighttype == var_25_34 or fighttype == var_25_35 then
					return var_25_54()
				elseif fighttype == var_25_32 then
					return var_25_55()
				elseif fighttype == var_0_0.FIGHTTYPE_EXPEDITION then
					return var_25_56()
				elseif fighttype == var_0_0.FIGHTTYPE_EXPEDITION_TOWER then
					return var_25_57()
				elseif fighttype == var_0_0.FIGHTTYPE_EXPEDITION_MONOPOLY then
					return var_25_56()
				elseif fighttype == var_25_36 then
					return var_25_59()
				elseif fighttype == var_0_0.FIGHTTYPE_AUTO_CHESS then
					return var_25_60()
				elseif fighttype == var_25_29 then
					return var_25_61()
				elseif fighttype == var_25_38 then
					return var_25_51()
				elseif fighttype == var_25_39 then
					return var_25_62()
				elseif fighttype == var_25_40 then
					return var_25_63()
				elseif fighttype == var_25_41 then
					return var_25_64()
				end
			else
				return var_25_48()
			end
		end

		function initEnemySync()
			battlefieldRef:updateWave()

			local var_79_1 = var_0_0.MAP_POS

			for iter_79_0, iter_79_1 in var_0_11(isHangupFighting() and monster_manager.initMonsterList((level_manager.getHangupTeam())) or monster_manager.initMonsterList((level_manager.getMonsterTeam()))) do
				local var_79_2 = var_0_65(iter_79_1.majorlist, iter_79_1.id)

				addEnemy(var_79_2)

				local var_79_3 = iter_79_1.posy or var_79_1[iter_79_1.offset]._y
				local var_79_4 = var_79_1[iter_79_1.offset].e_z

				battlefieldRef:addCharacter(var_79_2, iter_79_1.pos + var_79_1[iter_79_1.offset]._offset, var_79_3, var_79_1[iter_79_1.offset].e_z)
				var_79_2:registerDefaultY(var_79_3)
				var_79_2:registerDefaultZOrder(var_79_4)

				if iter_79_1.posy then
					var_79_2:dropToBattleField(var_79_1[iter_79_1.offset]._y, iter_79_1.delaytime)
				elseif iter_79_1.delaytime then
					var_79_2:delayToBattleField(iter_79_1.delaytime, iter_79_1.pos + var_79_1[iter_79_1.offset]._offset, var_79_3)
				end
			end

			setSearchDistance(var_0_0.NORMAL_SEARCH_DISTANCE)
		end

		function initNormalBossSync()
			local var_80_0 = monster_manager.initBossList((level_manager.getBossTeam()))

			for iter_80_0, iter_80_1 in var_0_11(var_80_0) do
				local var_80_1 = var_0_65(iter_80_1.majorlist, iter_80_1.id)

				addEnemy(var_80_1)

				local var_80_2 = iter_80_1.posy or var_0_0.MAP_POS[iter_80_1.offset]._y
				local var_80_3 = var_0_0.MAP_POS[iter_80_1.offset].e_z

				battlefieldRef:addCharacter(var_80_1, iter_80_1.pos + var_0_0.MAP_POS[iter_80_1.offset]._offset, var_80_2, var_0_0.MAP_POS[iter_80_1.offset].e_z)
				var_80_1:registerDefaultY(var_80_2)
				var_80_1:registerDefaultZOrder(var_80_3)

				if iter_80_1.posy then
					var_80_1:dropToBattleField(var_0_0.MAP_POS[iter_80_1.offset]._y, iter_80_1.delaytime)
				elseif iter_80_1.delaytime then
					var_80_1:delayToBattleField(iter_80_1.delaytime, iter_80_1.pos + var_0_0.MAP_POS[iter_80_1.offset]._offset, var_80_2)
				end
			end

			if var_80_0.boss then
				local var_80_4 = var_0_65(var_80_0.boss.majorlist, var_80_0.boss.id, true)

				addEnemy(var_80_4)

				local var_80_5 = var_80_0.boss.posy or var_0_0.MAP_POS[var_80_0.boss.offset]._y
				local var_80_6 = var_0_0.MAP_POS[var_80_0.boss.offset].e_z

				battlefieldRef:addCharacter(var_80_4, var_80_0.boss.pos + var_0_0.MAP_POS[var_80_0.boss.offset]._offset, var_80_5, var_0_0.MAP_POS[var_80_0.boss.offset].e_z)
				var_80_4:registerDefaultY(var_80_5)
				var_80_4:registerDefaultZOrder(var_80_6)

				if var_80_0.boss.posy then
					var_80_4:dropToBattleField(var_0_0.MAP_POS[var_80_0.boss.offset]._y, var_80_0.boss.delaytime)
				elseif var_80_0.boss.delaytime then
					var_80_4:delayToBattleField(var_80_0.boss.delaytime, var_80_0.boss.pos + var_0_0.MAP_POS[var_80_0.boss.offset]._offset, var_80_5)
				end
			end
		end

		function initBigBossSync()
			local var_81_0 = monster_manager.initBossList((level_manager.getBigBossTeam()))
			local var_81_1 = var_0_0.MAP_POS

			for iter_81_0, iter_81_1 in var_0_11(var_81_0) do
				local var_81_2 = var_0_65(iter_81_1.majorlist, iter_81_1.id, false, var_81_0.boss == nil, nil, true)

				addEnemy(var_81_2)

				local var_81_3 = iter_81_1.posy or var_81_1[iter_81_1.offset]._y
				local var_81_4 = var_81_1[iter_81_1.offset].e_z

				battlefieldRef:addCharacter(var_81_2, iter_81_1.pos + var_81_1[iter_81_1.offset]._offset, var_81_3, var_81_1[iter_81_1.offset].e_z)
				var_81_2:registerDefaultY(var_81_3)
				var_81_2:registerDefaultZOrder(var_81_4)

				if iter_81_1.posy then
					var_81_2:dropToBattleField(var_81_1[iter_81_1.offset]._y, iter_81_1.delaytime)
				elseif iter_81_1.delaytime then
					var_81_2:delayToBattleField(iter_81_1.delaytime, iter_81_1.pos + var_81_1[iter_81_1.offset]._offset, var_81_3)
				end
			end

			if var_81_0.boss then
				local var_81_5 = var_0_65(var_81_0.boss.majorlist, var_81_0.boss.id, true, nil, nil, true)

				addEnemy(var_81_5)

				local var_81_6 = var_81_0.boss.posy or var_81_1[var_81_0.boss.offset]._y
				local var_81_7 = var_81_1[var_81_0.boss.offset].e_z

				battlefieldRef:addCharacter(var_81_5, var_81_0.boss.pos + var_81_1[var_81_0.boss.offset]._offset, var_81_6, var_81_1[var_81_0.boss.offset].e_z)
				var_81_5:registerDefaultY(var_81_6)
				var_81_5:registerDefaultZOrder(var_81_7)

				if var_81_0.boss.posy then
					var_81_5:dropToBattleField(var_81_1[var_81_0.boss.offset]._y, var_81_0.boss.delaytime)
				elseif var_81_0.boss.delaytime then
					var_81_5:delayToBattleField(var_81_0.boss.delaytime, var_81_0.boss.pos + var_81_1[var_81_0.boss.offset]._offset, var_81_6)
				end
			end

			var_0_0.require("model.playermodel"):resetOfflineBuff()
		end

		function initAdventureBossSync()
			battlefieldRef:updateWave()

			local var_82_0 = level_manager:generateEnemy() or monster_manager.initBossList((level_manager.getBossTeam()))
			local var_82_1 = level_manager:getCreateEnemyFunc() or var_0_65
			local var_82_2 = var_0_0.MAP_POS

			for iter_82_0, iter_82_1 in var_0_11(var_82_0) do
				local var_82_3 = var_82_1(iter_82_1.majorlist, iter_82_1.id, false, var_82_0.boss == nil)

				addEnemy(var_82_3)

				local var_82_4 = iter_82_1.posy or var_82_2[iter_82_1.offset]._y
				local var_82_5 = var_82_2[iter_82_1.offset].e_z

				battlefieldRef:addCharacter(var_82_3, iter_82_1.pos + var_82_2[iter_82_1.offset]._offset, var_82_4, var_82_2[iter_82_1.offset].e_z)
				var_82_3:registerDefaultY(var_82_4)
				var_82_3:registerDefaultZOrder(var_82_5)

				if iter_82_1.posy then
					var_82_3:dropToBattleField(var_82_2[iter_82_1.offset]._y, iter_82_1.delaytime)
				elseif iter_82_1.delaytime then
					var_82_3:delayToBattleField(iter_82_1.delaytime, iter_82_1.pos + var_82_2[iter_82_1.offset]._offset, var_82_4)
				end
			end

			if var_82_0.boss then
				local var_82_6 = var_82_1(var_82_0.boss.majorlist, var_82_0.boss.id, true, nil, nil, nil, not not var_0_0.FightManager.fightActivityData().fightingActivityBoss)

				addEnemy(var_82_6)

				local var_82_7 = var_82_0.boss.posy or var_82_2[var_82_0.boss.offset]._y
				local var_82_8 = var_82_2[var_82_0.boss.offset].e_z

				battlefieldRef:addCharacter(var_82_6, var_82_0.boss.pos + var_82_2[var_82_0.boss.offset]._offset, var_82_7, var_82_2[var_82_0.boss.offset].e_z)
				var_82_6:registerDefaultY(var_82_7)
				var_82_6:registerDefaultZOrder(var_82_8)

				if var_82_0.boss.posy then
					var_82_6:dropToBattleField(var_82_2[var_82_0.boss.offset]._y, var_82_0.boss.delaytime)
				elseif var_82_0.boss.delaytime then
					var_82_6:delayToBattleField(var_82_0.boss.delaytime, var_82_0.boss.pos + var_82_2[var_82_0.boss.offset]._offset, var_82_7)
				end
			end
		end

		function initArenaEnemySync()
			local var_83_0 = arena_manager:getArenaEnemy()
			local var_83_1 = team_skill_manager:getTeamskillByArena(var_83_0)
			local var_83_2 = {
				teamRestrain = team_restrain_manager:getTeamRestrainByArrayTbl(var_83_0)
			}

			for iter_83_0, iter_83_1 in var_0_10(var_83_0) do
				local var_83_3 = var_0_67(iter_83_1, "enemy", var_83_1, arena_manager:get_arena_battlefield_status(), var_83_2)

				addEnemy(var_83_3)
				battlefieldRef:addCharacter(var_83_3, 0, 0, 0)
			end

			initEnemyPos()
		end

		function initArenatftEnemySync()
			battlefieldRef:updateArenatftWave()

			local var_84_0 = arenatft_manager:getArenaEnemy()
			local var_84_1 = team_skill_manager:getTeamskillByArena(var_84_0)
			local var_84_2 = {
				teamRestrain = team_restrain_manager:getTeamRestrainByArrayTbl(var_84_0)
			}

			for iter_84_0, iter_84_1 in var_0_10(var_84_0) do
				local var_84_3 = var_0_67(iter_84_1, "enemy", var_84_1, nil, var_84_2)

				addEnemy(var_84_3)
				battlefieldRef:addCharacter(var_84_3, 0, 0, 0)
			end

			initEnemyPos()
		end

		function initArenaFrindEnemySync()
			local var_85_0 = friend_system_manager:getArenaEnemy()
			local var_85_1 = team_skill_manager:getTeamskillByArena(var_85_0)
			local var_85_2 = {
				teamRestrain = team_restrain_manager:getTeamRestrainByArrayTbl(var_85_0)
			}

			for iter_85_0, iter_85_1 in var_0_10(var_85_0) do
				local var_85_3 = var_0_67(iter_85_1, "enemy", var_85_1, nil, var_85_2)

				addEnemy(var_85_3)
				battlefieldRef:addCharacter(var_85_3, 0, 0, 0)
			end

			initEnemyPos()
		end

		function initScoreArenaEnemySync()
			local var_86_0 = scorearena_manager:getArenaEnemy()
			local var_86_1 = team_skill_manager:getTeamskillByArena(var_86_0)
			local var_86_2 = {
				teamRestrain = team_restrain_manager:getTeamRestrainByArrayTbl(var_86_0)
			}

			for iter_86_0, iter_86_1 in var_0_10(var_86_0) do
				local var_86_3 = var_0_67(iter_86_1, "enemy", var_86_1, nil, var_86_2)

				addEnemy(var_86_3)
				battlefieldRef:addCharacter(var_86_3, 0, 0, 0)
			end

			initEnemyPos()
		end

		function initGuideEnemySync()
			local var_87_0 = var_0_0.require("devtools.fight_test_bridge"):getTestEnemy()
			local var_87_1 = team_skill_manager:getTeamskillByGuide(var_87_0)
			local var_87_2 = {
				teamRestrain = team_restrain_manager:getTeamRestrainByArrayTbl(var_87_0)
			}

			for iter_87_0, iter_87_1 in var_0_10(var_87_0) do
				local var_87_3 = var_0_68(iter_87_1, "enemy", var_87_1, var_87_2)

				addEnemy(var_87_3)
				battlefieldRef:addCharacter(var_87_3, iter_87_1.pos + var_0_0.MAP_POS[iter_87_1.offset]._offset, var_0_0.MAP_POS[iter_87_1.offset]._y, var_0_0.MAP_POS[iter_87_1.offset].e_z)
				var_87_3:registerDefaultY(var_0_0.MAP_POS[iter_87_1.offset]._y)
				var_87_3:registerDefaultZOrder(var_0_0.MAP_POS[iter_87_1.offset].e_z)
			end
		end

		function initExploreEnemySync()
			local var_88_0 = explore_manager:initBossList()
			local var_88_1 = var_0_0.MAP_POS

			for iter_88_0 = 1, #var_88_0 do
				local var_88_2 = var_0_65(var_88_0[iter_88_0].majorlist, var_88_0[iter_88_0].id, false, var_88_0.boss == nil, var_88_0[iter_88_0].extraConfig)
				local var_88_3 = var_88_0[iter_88_0].posy or var_88_1[var_88_0[iter_88_0].offset]._y
				local var_88_4 = var_88_1[var_88_0[iter_88_0].offset].e_z

				battlefieldRef:addCharacter(var_88_2, var_88_0[iter_88_0].pos + var_88_1[var_88_0[iter_88_0].offset]._offset, var_88_3, var_88_1[var_88_0[iter_88_0].offset].e_z)
				var_88_2:registerDefaultY(var_88_3)
				var_88_2:registerDefaultZOrder(var_88_4)
				addEnemy(var_88_2)

				if var_88_0[iter_88_0].posy then
					var_88_2:dropToBattleField(var_88_1[var_88_0[iter_88_0].offset]._y, var_88_0[iter_88_0].delaytime)
				elseif var_88_0[iter_88_0].delaytime then
					var_88_2:delayToBattleField(var_88_0[iter_88_0].delaytime, var_88_0[iter_88_0].pos + var_88_1[var_88_0[iter_88_0].offset]._offset, var_88_3)
				end
			end

			if var_88_0.boss then
				local var_88_5 = var_0_65(var_88_0.boss.majorlist, var_88_0.boss.id, true, false, var_88_0.boss.extraConfig)
				local var_88_6 = var_88_0.boss.posy or var_88_1[var_88_0.boss.offset]._y
				local var_88_7 = var_88_1[var_88_0.boss.offset].e_z

				battlefieldRef:addCharacter(var_88_5, var_88_0.boss.pos + var_88_1[var_88_0.boss.offset]._offset, var_88_6, var_88_1[var_88_0.boss.offset].e_z)
				var_88_5:registerDefaultY(var_88_6)
				var_88_5:registerDefaultZOrder(var_88_7)
				addEnemy(var_88_5)

				if var_88_0.boss.posy then
					var_88_5:dropToBattleField(var_88_1[var_88_0.boss.offset]._y, var_88_0.boss.delaytime)
				elseif var_88_0.boss.delaytime then
					var_88_5:delayToBattleField(var_88_0.boss.delaytime, var_88_0.boss.pos + var_88_1[var_88_0.boss.offset]._offset, var_88_6)
				end
			end
		end

		function initRogueExploreEnemySync()
			local var_89_0 = rogue_explore_manager:initBossList()
			local var_89_1 = var_0_0.MAP_POS

			for iter_89_0 = 1, #var_89_0 do
				local var_89_2 = var_0_65(var_89_0[iter_89_0].majorlist, var_89_0[iter_89_0].id, false, var_89_0.boss == nil, var_89_0[iter_89_0].extraConfig)
				local var_89_3 = var_89_0[iter_89_0].posy or var_89_1[var_89_0[iter_89_0].offset]._y
				local var_89_4 = var_89_1[var_89_0[iter_89_0].offset].e_z

				battlefieldRef:addCharacter(var_89_2, var_89_0[iter_89_0].pos + var_89_1[var_89_0[iter_89_0].offset]._offset, var_89_3, var_89_1[var_89_0[iter_89_0].offset].e_z)
				var_89_2:registerDefaultY(var_89_3)
				var_89_2:registerDefaultZOrder(var_89_4)
				addEnemy(var_89_2)

				if var_89_0[iter_89_0].posy then
					var_89_2:dropToBattleField(var_89_1[var_89_0[iter_89_0].offset]._y, var_89_0[iter_89_0].delaytime)
				elseif var_89_0[iter_89_0].delaytime then
					var_89_2:delayToBattleField(var_89_0[iter_89_0].delaytime, var_89_0[iter_89_0].pos + var_89_1[var_89_0[iter_89_0].offset]._offset, var_89_3)
				end
			end

			if var_89_0.boss then
				local var_89_5 = var_0_65(var_89_0.boss.majorlist, var_89_0.boss.id, true, false, var_89_0.boss.extraConfig)
				local var_89_6 = var_89_0.boss.posy or var_89_1[var_89_0.boss.offset]._y
				local var_89_7 = var_89_1[var_89_0.boss.offset].e_z

				battlefieldRef:addCharacter(var_89_5, var_89_0.boss.pos + var_89_1[var_89_0.boss.offset]._offset, var_89_6, var_89_1[var_89_0.boss.offset].e_z)
				var_89_5:registerDefaultY(var_89_6)
				var_89_5:registerDefaultZOrder(var_89_7)
				addEnemy(var_89_5)

				if var_89_0.boss.posy then
					var_89_5:dropToBattleField(var_89_1[var_89_0.boss.offset]._y, var_89_0.boss.delaytime)
				elseif var_89_0.boss.delaytime then
					var_89_5:delayToBattleField(var_89_0.boss.delaytime, var_89_0.boss.pos + var_89_1[var_89_0.boss.offset]._offset, var_89_6)
				end
			end
		end

		function initSubstitutionEnemySync()
			local var_90_0 = substitution_manager:getSubstitutionEnemy()
			local var_90_1 = var_0_0.MAP_POS

			for iter_90_0, iter_90_1 in var_0_11(var_90_0) do
				local var_90_2 = var_0_65(iter_90_1.majorlist, iter_90_1.id, false, var_90_0.boss == nil)

				addEnemy(var_90_2)

				local var_90_3 = iter_90_1.posy or var_90_1[iter_90_1.offset]._y
				local var_90_4 = var_90_1[iter_90_1.offset].e_z

				battlefieldRef:addCharacter(var_90_2, iter_90_1.pos + var_90_1[iter_90_1.offset]._offset, var_90_3, var_90_1[iter_90_1.offset].e_z)
				var_90_2:registerDefaultY(var_90_3)
				var_90_2:registerDefaultZOrder(var_90_4)

				if iter_90_1.posy then
					var_90_2:dropToBattleField(var_90_1[iter_90_1.offset]._y, iter_90_1.delaytime)
				elseif iter_90_1.delaytime then
					var_90_2:delayToBattleField(iter_90_1.delaytime, iter_90_1.pos + var_90_1[iter_90_1.offset]._offset, var_90_3)
				end
			end

			if var_90_0.boss then
				local var_90_5 = var_0_70(var_90_0.boss.majorlist, var_90_0.boss.id)

				addEnemy(var_90_5)

				local var_90_6 = var_90_0.boss.posy or var_90_1[var_90_0.boss.offset]._y
				local var_90_7 = var_90_1[var_90_0.boss.offset].e_z

				battlefieldRef:addCharacter(var_90_5, var_90_0.boss.pos + var_90_1[var_90_0.boss.offset]._offset, var_90_6, var_90_1[var_90_0.boss.offset].e_z)
				var_90_5:registerDefaultY(var_90_6)
				var_90_5:registerDefaultZOrder(var_90_7)

				if var_90_0.boss.posy then
					var_90_5:dropToBattleField(var_90_1[var_90_0.boss.offset]._y, var_90_0.boss.delaytime)
				elseif var_90_0.boss.delaytime then
					var_90_5:delayToBattleField(var_90_0.boss.delaytime, var_90_0.boss.pos + var_90_1[var_90_0.boss.offset]._offset, var_90_6)
				end
			end
		end

		function initOldSubstitutionEnemySync()
			local var_91_0 = old_substitution_manager:getSubstitutionEnemy()
			local var_91_1 = var_0_0.MAP_POS

			for iter_91_0, iter_91_1 in var_0_11(var_91_0) do
				local var_91_2 = var_0_65(iter_91_1.majorlist, iter_91_1.id, false, var_91_0.boss == nil)

				addEnemy(var_91_2)

				local var_91_3 = iter_91_1.posy or var_91_1[iter_91_1.offset]._y
				local var_91_4 = var_91_1[iter_91_1.offset].e_z

				battlefieldRef:addCharacter(var_91_2, iter_91_1.pos + var_91_1[iter_91_1.offset]._offset, var_91_3, var_91_1[iter_91_1.offset].e_z)
				var_91_2:registerDefaultY(var_91_3)
				var_91_2:registerDefaultZOrder(var_91_4)

				if iter_91_1.posy then
					var_91_2:dropToBattleField(var_91_1[iter_91_1.offset]._y, iter_91_1.delaytime)
				elseif iter_91_1.delaytime then
					var_91_2:delayToBattleField(iter_91_1.delaytime, iter_91_1.pos + var_91_1[iter_91_1.offset]._offset, var_91_3)
				end
			end

			if var_91_0.boss then
				local var_91_5 = var_0_65(var_91_0.boss.majorlist, var_91_0.boss.id, true)

				addEnemy(var_91_5)

				local var_91_6 = var_91_0.boss.posy or var_91_1[var_91_0.boss.offset]._y
				local var_91_7 = var_91_1[var_91_0.boss.offset].e_z

				battlefieldRef:addCharacter(var_91_5, var_91_0.boss.pos + var_91_1[var_91_0.boss.offset]._offset, var_91_6, var_91_1[var_91_0.boss.offset].e_z)
				var_91_5:registerDefaultY(var_91_6)
				var_91_5:registerDefaultZOrder(var_91_7)

				if var_91_0.boss.posy then
					var_91_5:dropToBattleField(var_91_1[var_91_0.boss.offset]._y, var_91_0.boss.delaytime)
				elseif var_91_0.boss.delaytime then
					var_91_5:delayToBattleField(var_91_0.boss.delaytime, var_91_0.boss.pos + var_91_1[var_91_0.boss.offset]._offset, var_91_6)
				end

				old_substitution_manager:updateSubstitutionEnemyTotalHp(var_91_5:getAttribute("hp"))
			end
		end

		function initAIAttackEnemySync()
			local var_92_0 = aiattack_manager:getAiAttackEnemy()
			local var_92_1 = var_0_0.MAP_POS

			for iter_92_0, iter_92_1 in var_0_11(var_92_0) do
				local var_92_2 = var_0_65(iter_92_1.majorlist, iter_92_1.id, false, var_92_0.boss == nil)

				addEnemy(var_92_2)

				local var_92_3 = iter_92_1.posy or var_92_1[iter_92_1.offset]._y
				local var_92_4 = var_92_1[iter_92_1.offset].e_z

				battlefieldRef:addCharacter(var_92_2, iter_92_1.pos + var_92_1[iter_92_1.offset]._offset, var_92_3, var_92_1[iter_92_1.offset].e_z)
				var_92_2:registerDefaultY(var_92_3)
				var_92_2:registerDefaultZOrder(var_92_4)

				if iter_92_1.posy then
					var_92_2:dropToBattleField(var_92_1[iter_92_1.offset]._y, iter_92_1.delaytime)
				elseif iter_92_1.delaytime then
					var_92_2:delayToBattleField(iter_92_1.delaytime, iter_92_1.pos + var_92_1[iter_92_1.offset]._offset, var_92_3)
				end
			end

			if var_92_0.boss then
				local var_92_5 = var_0_65(var_92_0.boss.majorlist, var_92_0.boss.id, true)

				addEnemy(var_92_5)

				local var_92_6 = var_92_0.boss.posy or var_92_1[var_92_0.boss.offset]._y
				local var_92_7 = var_92_1[var_92_0.boss.offset].e_z

				battlefieldRef:addCharacter(var_92_5, var_92_0.boss.pos + var_92_1[var_92_0.boss.offset]._offset, var_92_6, var_92_1[var_92_0.boss.offset].e_z)
				var_92_5:registerDefaultY(var_92_6)
				var_92_5:registerDefaultZOrder(var_92_7)

				if var_92_0.boss.posy then
					var_92_5:dropToBattleField(var_92_1[var_92_0.boss.offset]._y, var_92_0.boss.delaytime)
				elseif var_92_0.boss.delaytime then
					var_92_5:delayToBattleField(var_92_0.boss.delaytime, var_92_0.boss.pos + var_92_1[var_92_0.boss.offset]._offset, var_92_6)
				end
			end
		end

		function initInfiniteEnemySync()
			battlefieldRef:updateInfinteWave()

			local var_93_0 = infinite_fight_manager:generateEnemy()
			local var_93_1 = var_0_0.MAP_POS

			for iter_93_0, iter_93_1 in var_0_11(var_93_0) do
				local var_93_2 = var_0_65(iter_93_1.majorlist, iter_93_1.id, false, var_93_0.boss == nil)

				addEnemy(var_93_2)

				local var_93_3 = iter_93_1.posy or var_93_1[iter_93_1.offset]._y
				local var_93_4 = var_93_1[iter_93_1.offset].e_z

				battlefieldRef:addCharacter(var_93_2, iter_93_1.pos + var_93_1[iter_93_1.offset]._offset, var_93_3, var_93_1[iter_93_1.offset].e_z)
				var_93_2:registerDefaultY(var_93_3)
				var_93_2:registerDefaultZOrder(var_93_4)

				if iter_93_1.posy then
					var_93_2:dropToBattleField(var_93_1[iter_93_1.offset]._y, iter_93_1.delaytime)
				elseif iter_93_1.delaytime then
					var_93_2:delayToBattleField(iter_93_1.delaytime, iter_93_1.pos + var_93_1[iter_93_1.offset]._offset, var_93_3)
				end
			end

			if var_93_0.boss then
				local var_93_5 = var_0_65(var_93_0.boss.majorlist, var_93_0.boss.id, true)

				addEnemy(var_93_5)

				local var_93_6 = var_93_0.boss.posy or var_93_1[var_93_0.boss.offset]._y
				local var_93_7 = var_93_1[var_93_0.boss.offset].e_z

				battlefieldRef:addCharacter(var_93_5, var_93_0.boss.pos + var_93_1[var_93_0.boss.offset]._offset, var_93_6, var_93_1[var_93_0.boss.offset].e_z)
				var_93_5:registerDefaultY(var_93_6)
				var_93_5:registerDefaultZOrder(var_93_7)

				if var_93_0.boss.posy then
					var_93_5:dropToBattleField(var_93_1[var_93_0.boss.offset]._y, var_93_0.boss.delaytime)
				elseif var_93_0.boss.delaytime then
					var_93_5:delayToBattleField(var_93_0.boss.delaytime, var_93_0.boss.pos + var_93_1[var_93_0.boss.offset]._offset, var_93_6)
				end
			end
		end

		function initTowerEnemySync()
			for iter_94_0, iter_94_1 in var_0_10((tower_defence_manager:getEnemyBaseConf())) do
				local var_94_0 = var_0_71(iter_94_1)

				addEnemy(var_94_0, iter_94_0)

				local var_94_2 = iter_94_1.posy or var_0_0.MAP_POS[0]._y
				local var_94_3 = var_0_0.MAP_POS[0].e_z

				battlefieldRef:addCharacter(var_94_0, iter_94_1.pos_x, var_94_2, var_0_0.MAP_POS[0].e_z)
				var_94_0:registerDefaultY(var_94_2)
				var_94_0:registerDefaultZOrder(var_94_3)
			end
		end

		function initStakePvpEnemySync()
			local var_95_0 = test_fight_manager:getPvpArray()
			local var_95_1 = team_skill_manager:getTeamskillByConf(var_95_0)
			local var_95_2 = {
				teamRestrain = team_restrain_manager:getTeamRestrainByArrayTbl(var_95_0)
			}

			for iter_95_0, iter_95_1 in var_0_10(var_95_0) do
				local var_95_3 = var_0_74(iter_95_1, "enemy", var_95_1, var_95_2)

				battlefieldRef:addCharacter(var_95_3, 700 + var_0_0.MAP_POS[0]._offset, var_0_0.MAP_POS[0]._y, var_0_0.MAP_POS[0].e_z)
				var_95_3:registerDefaultY(var_0_0.MAP_POS[0]._y)
				var_95_3:registerDefaultZOrder(var_0_0.MAP_POS[0].e_z)
				addEnemy(var_95_3, iter_95_0)
			end
		end

		function initStakePveEnemySync()
			local var_96_0 = test_fight_manager:initBossList()
			local var_96_1 = var_0_0.MAP_POS

			for iter_96_0 = 1, #var_96_0 do
				local var_96_2 = var_0_65(var_96_0[iter_96_0].majorlist, var_96_0[iter_96_0].id, false, var_96_0.boss == nil, var_96_0[iter_96_0].extraConfig)
				local var_96_3 = var_96_0[iter_96_0].posy or var_96_1[var_96_0[iter_96_0].offset]._y
				local var_96_4 = var_96_1[var_96_0[iter_96_0].offset].e_z

				battlefieldRef:addCharacter(var_96_2, var_96_0[iter_96_0].pos + var_96_1[var_96_0[iter_96_0].offset]._offset, var_96_3, var_96_1[var_96_0[iter_96_0].offset].e_z)
				var_96_2:registerDefaultY(var_96_3)
				var_96_2:registerDefaultZOrder(var_96_4)
				addEnemy(var_96_2)

				if var_96_0[iter_96_0].posy then
					var_96_2:dropToBattleField(var_96_1[var_96_0[iter_96_0].offset]._y, var_96_0[iter_96_0].delaytime)
				elseif var_96_0[iter_96_0].delaytime then
					var_96_2:delayToBattleField(var_96_0[iter_96_0].delaytime, var_96_0[iter_96_0].pos + var_96_1[var_96_0[iter_96_0].offset]._offset, var_96_3)
				end
			end

			if var_96_0.boss then
				local var_96_5 = var_0_65(var_96_0.boss.majorlist, var_96_0.boss.id, true, false, var_96_0.boss.extraConfig)
				local var_96_6 = var_96_0.boss.posy or var_96_1[var_96_0.boss.offset]._y
				local var_96_7 = var_96_1[var_96_0.boss.offset].e_z

				battlefieldRef:addCharacter(var_96_5, var_96_0.boss.pos + var_96_1[var_96_0.boss.offset]._offset, var_96_6, var_96_1[var_96_0.boss.offset].e_z)
				var_96_5:registerDefaultY(var_96_6)
				var_96_5:registerDefaultZOrder(var_96_7)
				addEnemy(var_96_5)

				if var_96_0.boss.posy then
					var_96_5:dropToBattleField(var_96_1[var_96_0.boss.offset]._y, var_96_0.boss.delaytime)
				elseif var_96_0.boss.delaytime then
					var_96_5:delayToBattleField(var_96_0.boss.delaytime, var_96_0.boss.pos + var_96_1[var_96_0.boss.offset]._offset, var_96_6)
				end
			end
		end

		function initExpeditionEnemySync()
			local var_97_0 = var_0_0.require("controller.expedition_manager"):getGenerateEnemyList()

			for iter_97_0, iter_97_1 in var_0_11(var_97_0) do
				local var_97_1 = var_0_65(iter_97_1.majorlist, iter_97_1.id)

				var_97_1:updateBloodWithExpedition(iter_97_1.bloodpercent)

				var_97_1.bloodpercent = iter_97_1.bloodpercent

				addEnemy(var_97_1)
				var_97_1:updateEnergyWithExpedition(iter_97_1.energypercent)

				local var_97_2 = iter_97_1.posy or var_0_0.MAP_POS[iter_97_1.offset]._y
				local var_97_3 = var_0_0.MAP_POS[iter_97_1.offset].e_z

				battlefieldRef:addCharacter(var_97_1, iter_97_1.pos + var_0_0.MAP_POS[iter_97_1.offset]._offset, var_97_2, var_0_0.MAP_POS[iter_97_1.offset].e_z)
				var_97_1:registerDefaultY(var_97_2)
				var_97_1:registerDefaultZOrder(var_97_3)

				if iter_97_1.posy then
					var_97_1:dropToBattleField(var_0_0.MAP_POS[iter_97_1.offset]._y, iter_97_1.delaytime)
				elseif iter_97_1.delaytime then
					var_97_1:delayToBattleField(iter_97_1.delaytime, iter_97_1.pos + var_0_0.MAP_POS[iter_97_1.offset]._offset, var_97_2)
				end
			end

			if var_97_0.boss then
				local var_97_4 = var_0_65(var_97_0.boss.majorlist, var_97_0.boss.id, true)

				var_97_4:updateBloodWithExpedition(var_97_0.boss.bloodpercent)

				var_97_4.bloodpercent = var_97_0.boss.bloodpercent

				addEnemy(var_97_4)
				var_97_4:updateEnergyWithExpedition(var_97_0.boss.energypercent)

				local var_97_5 = var_97_0.boss.pos + var_0_0.MAP_POS[var_97_0.boss.offset]._offset
				local var_97_6 = var_97_0.boss.posy or var_0_0.MAP_POS[var_97_0.boss.offset]._y
				local var_97_7 = var_0_0.MAP_POS[var_97_0.boss.offset].e_z

				battlefieldRef:addCharacter(var_97_4, var_97_5, var_97_6, var_0_0.MAP_POS[var_97_0.boss.offset].e_z)
				var_97_4:registerDefaultY(var_97_6)
				var_97_4:registerDefaultZOrder(var_97_7)

				if var_97_0.boss.posy then
					var_97_4:dropToBattleField(var_0_0.MAP_POS[var_97_0.boss.offset]._y, var_97_0.boss.delaytime)
				elseif var_97_0.boss.delaytime then
					var_97_4:delayToBattleField(var_97_0.boss.delaytime, var_97_5, var_97_6)
				end
			end
		end

		function initExpeditionTowerEnemySync()
			for iter_98_0, iter_98_1 in var_0_10(var_0_0.require("controller.expedition_manager"):getCurLevelInfo().baseConfig[2]) do
				local var_98_0 = var_0_71(iter_98_1)

				addEnemy(var_98_0, iter_98_0)

				local var_98_1 = iter_98_1.posy or var_0_0.MAP_POS[0]._y
				local var_98_2 = var_0_0.MAP_POS[0].e_z

				battlefieldRef:addCharacter(var_98_0, iter_98_1.pos_x, var_98_1, var_0_0.MAP_POS[0].e_z)
				var_98_0:registerDefaultY(var_98_1)
				var_98_0:registerDefaultZOrder(var_98_2)
			end
		end

		function initMonopolyEnemySync()
			local var_99_0 = var_0_0.require("controller.monopoly.monopoly_manager"):getInstance():initBossList()
			local var_99_1 = var_0_0.MAP_POS

			for iter_99_0 = 1, #var_99_0 do
				local var_99_2 = var_0_66(var_99_0[iter_99_0].majorlist, var_99_0[iter_99_0].id, false, var_99_0.boss == nil)
				local var_99_3 = var_99_0[iter_99_0].posy or var_99_1[var_99_0[iter_99_0].offset]._y
				local var_99_4 = var_99_1[var_99_0[iter_99_0].offset].e_z

				battlefieldRef:addCharacter(var_99_2, var_99_0[iter_99_0].pos + var_99_1[var_99_0[iter_99_0].offset]._offset, var_99_3, var_99_1[var_99_0[iter_99_0].offset].e_z)
				var_99_2:registerDefaultY(var_99_3)
				var_99_2:registerDefaultZOrder(var_99_4)
				addEnemy(var_99_2)

				if var_99_0[iter_99_0].posy then
					var_99_2:dropToBattleField(var_99_1[var_99_0[iter_99_0].offset]._y, var_99_0[iter_99_0].delaytime)
				elseif var_99_0[iter_99_0].delaytime then
					var_99_2:delayToBattleField(var_99_0[iter_99_0].delaytime, var_99_0[iter_99_0].pos + var_99_1[var_99_0[iter_99_0].offset]._offset, var_99_3)
				end
			end

			if var_99_0.boss then
				local var_99_5 = var_0_66(var_99_0.boss.majorlist, var_99_0.boss.id, true, false)
				local var_99_6 = var_99_0.boss.posy or var_99_1[var_99_0.boss.offset]._y
				local var_99_7 = var_99_1[var_99_0.boss.offset].e_z

				battlefieldRef:addCharacter(var_99_5, var_99_0.boss.pos + var_99_1[var_99_0.boss.offset]._offset, var_99_6, var_99_1[var_99_0.boss.offset].e_z)
				var_99_5:registerDefaultY(var_99_6)
				var_99_5:registerDefaultZOrder(var_99_7)
				addEnemy(var_99_5)

				if var_99_0.boss.posy then
					var_99_5:dropToBattleField(var_99_1[var_99_0.boss.offset]._y, var_99_0.boss.delaytime)
				elseif var_99_0.boss.delaytime then
					var_99_5:delayToBattleField(var_99_0.boss.delaytime, var_99_0.boss.pos + var_99_1[var_99_0.boss.offset]._offset, var_99_6)
				end
			end
		end

		function initGroupFightEnemySync()
			local var_100_0 = var_0_0.require("controller.activity_manager"):getGroupEnemyList()
			local var_100_1 = var_0_0.MAP_POS

			for iter_100_0 = 1, #var_100_0 do
				local var_100_2 = var_0_66(var_100_0[iter_100_0].majorlist, var_100_0[iter_100_0].id, false, var_100_0.boss == nil)
				local var_100_3 = var_100_0[iter_100_0].posy or var_100_1[var_100_0[iter_100_0].offset]._y
				local var_100_4 = var_100_1[var_100_0[iter_100_0].offset].e_z

				battlefieldRef:addCharacter(var_100_2, var_100_0[iter_100_0].pos + var_100_1[var_100_0[iter_100_0].offset]._offset, var_100_3, var_100_1[var_100_0[iter_100_0].offset].e_z)
				var_100_2:registerDefaultY(var_100_3)
				var_100_2:registerDefaultZOrder(var_100_4)
				addEnemy(var_100_2)

				if var_100_0[iter_100_0].posy then
					var_100_2:dropToBattleField(var_100_1[var_100_0[iter_100_0].offset]._y, var_100_0[iter_100_0].delaytime)
				elseif var_100_0[iter_100_0].delaytime then
					var_100_2:delayToBattleField(var_100_0[iter_100_0].delaytime, var_100_0[iter_100_0].pos + var_100_1[var_100_0[iter_100_0].offset]._offset, var_100_3)
				end
			end

			if var_100_0.boss then
				local var_100_5 = var_0_66(var_100_0.boss.majorlist, var_100_0.boss.id, true, false)
				local var_100_6 = var_100_0.boss.posy or var_100_1[var_100_0.boss.offset]._y
				local var_100_7 = var_100_1[var_100_0.boss.offset].e_z

				battlefieldRef:addCharacter(var_100_5, var_100_0.boss.pos + var_100_1[var_100_0.boss.offset]._offset, var_100_6, var_100_1[var_100_0.boss.offset].e_z)
				var_100_5:registerDefaultY(var_100_6)
				var_100_5:registerDefaultZOrder(var_100_7)
				addEnemy(var_100_5)

				if var_100_0.boss.posy then
					var_100_5:dropToBattleField(var_100_1[var_100_0.boss.offset]._y, var_100_0.boss.delaytime)
				elseif var_100_0.boss.delaytime then
					var_100_5:delayToBattleField(var_100_0.boss.delaytime, var_100_0.boss.pos + var_100_1[var_100_0.boss.offset]._offset, var_100_6)
				end
			end
		end

		function initFlyChessEnemySync()
			local var_101_0 = var_0_0.require("controller.activity_manager"):initFlyChessEnemyList()
			local var_101_1 = var_0_0.MAP_POS

			for iter_101_0 = 1, #var_101_0 do
				local var_101_2 = var_0_66(var_101_0[iter_101_0].majorlist, var_101_0[iter_101_0].id, false, var_101_0.boss == nil)
				local var_101_3 = var_101_0[iter_101_0].posy or var_101_1[var_101_0[iter_101_0].offset]._y
				local var_101_4 = var_101_1[var_101_0[iter_101_0].offset].e_z

				battlefieldRef:addCharacter(var_101_2, var_101_0[iter_101_0].pos + var_101_1[var_101_0[iter_101_0].offset]._offset, var_101_3, var_101_1[var_101_0[iter_101_0].offset].e_z)
				var_101_2:registerDefaultY(var_101_3)
				var_101_2:registerDefaultZOrder(var_101_4)
				addEnemy(var_101_2)

				if var_101_0[iter_101_0].posy then
					var_101_2:dropToBattleField(var_101_1[var_101_0[iter_101_0].offset]._y, var_101_0[iter_101_0].delaytime)
				elseif var_101_0[iter_101_0].delaytime then
					var_101_2:delayToBattleField(var_101_0[iter_101_0].delaytime, var_101_0[iter_101_0].pos + var_101_1[var_101_0[iter_101_0].offset]._offset, var_101_3)
				end
			end

			if var_101_0.boss then
				local var_101_5 = var_0_66(var_101_0.boss.majorlist, var_101_0.boss.id, true, false)
				local var_101_6 = var_101_0.boss.posy or var_101_1[var_101_0.boss.offset]._y
				local var_101_7 = var_101_1[var_101_0.boss.offset].e_z

				battlefieldRef:addCharacter(var_101_5, var_101_0.boss.pos + var_101_1[var_101_0.boss.offset]._offset, var_101_6, var_101_1[var_101_0.boss.offset].e_z)
				var_101_5:registerDefaultY(var_101_6)
				var_101_5:registerDefaultZOrder(var_101_7)
				addEnemy(var_101_5)

				if var_101_0.boss.posy then
					var_101_5:dropToBattleField(var_101_1[var_101_0.boss.offset]._y, var_101_0.boss.delaytime)
				elseif var_101_0.boss.delaytime then
					var_101_5:delayToBattleField(var_101_0.boss.delaytime, var_101_0.boss.pos + var_101_1[var_101_0.boss.offset]._offset, var_101_6)
				end
			end
		end

		function initWorldBossEnemySync()
			local var_102_0 = var_0_0.require("controller.activity_manager"):getWorldBossEnemy()
			local var_102_1 = var_0_0.MAP_POS

			for iter_102_0 = 1, #var_102_0 do
				local var_102_2 = var_0_66(var_102_0[iter_102_0].majorlist, var_102_0[iter_102_0].id, false, var_102_0.boss == nil)
				local var_102_3 = var_102_0[iter_102_0].posy or var_102_1[var_102_0[iter_102_0].offset]._y
				local var_102_4 = var_102_1[var_102_0[iter_102_0].offset].e_z

				battlefieldRef:addCharacter(var_102_2, var_102_0[iter_102_0].pos + var_102_1[var_102_0[iter_102_0].offset]._offset, var_102_3, var_102_1[var_102_0[iter_102_0].offset].e_z)
				var_102_2:registerDefaultY(var_102_3)
				var_102_2:registerDefaultZOrder(var_102_4)
				addEnemy(var_102_2)

				if var_102_0[iter_102_0].posy then
					var_102_2:dropToBattleField(var_102_1[var_102_0[iter_102_0].offset]._y, var_102_0[iter_102_0].delaytime)
				elseif var_102_0[iter_102_0].delaytime then
					var_102_2:delayToBattleField(var_102_0[iter_102_0].delaytime, var_102_0[iter_102_0].pos + var_102_1[var_102_0[iter_102_0].offset]._offset, var_102_3)
				end
			end

			if var_102_0.boss then
				local var_102_5 = var_0_66(var_102_0.boss.majorlist, var_102_0.boss.id, true, false)
				local var_102_6 = var_102_0.boss.posy or var_102_1[var_102_0.boss.offset]._y
				local var_102_7 = var_102_1[var_102_0.boss.offset].e_z

				battlefieldRef:addCharacter(var_102_5, var_102_0.boss.pos + var_102_1[var_102_0.boss.offset]._offset, var_102_6, var_102_1[var_102_0.boss.offset].e_z)
				var_102_5:registerDefaultY(var_102_6)
				var_102_5:registerDefaultZOrder(var_102_7)
				addEnemy(var_102_5)

				if var_102_0.boss.posy then
					var_102_5:dropToBattleField(var_102_1[var_102_0.boss.offset]._y, var_102_0.boss.delaytime)
				elseif var_102_0.boss.delaytime then
					var_102_5:delayToBattleField(var_102_0.boss.delaytime, var_102_0.boss.pos + var_102_1[var_102_0.boss.offset]._offset, var_102_6)
				end
			end
		end

		function initCurEnemy()
			if pvpfighting then
				if fighttype == var_25_23 then
					initArenaEnemySync()
				elseif fighttype == var_25_26 then
					initScoreArenaEnemySync()
				elseif fighttype == var_25_30 then
					initArenatftEnemySync()
				elseif fighttype == var_25_33 then
					initArenaFrindEnemySync()
				end
			elseif pvefighting then
				if fighttype == var_25_21 or fighttype == var_25_22 then
					if isFightingBoss() then
						initAdventureBossSync()
					else
						initEnemySync()
					end
				elseif fighttype == var_25_19 then
					initGuideEnemySync()
				elseif fighttype == var_25_25 then
					initExploreEnemySync()
				elseif fighttype == var_25_27 then
					initSubstitutionEnemySync()
				elseif fighttype == var_25_28 then
					initAIAttackEnemySync()
				elseif fighttype == var_25_29 then
					initOldSubstitutionEnemySync()
				elseif fighttype == var_25_31 then
					initInfiniteEnemySync()
				elseif fighttype == var_25_32 then
					initTowerEnemySync()
				elseif fighttype == var_25_34 then
					initStakePvpEnemySync()
				elseif fighttype == var_25_35 then
					initStakePveEnemySync()
				elseif fighttype == var_0_0.FIGHTTYPE_EXPEDITION then
					initExpeditionEnemySync()
				elseif fighttype == var_0_0.FIGHTTYPE_EXPEDITION_TOWER then
					initExpeditionTowerEnemySync()
				elseif fighttype == var_0_0.FIGHTTYPE_EXPEDITION_MONOPOLY then
					initExpeditionEnemySync()
				elseif fighttype == var_25_36 then
					initMonopolyEnemySync()
				elseif fighttype == var_0_0.FIGHTTYPE_AUTO_CHESS then
					initAdventureBossSync()
				elseif fighttype == var_25_38 then
					initRogueExploreEnemySync()
				elseif fighttype == var_25_39 then
					initGroupFightEnemySync()
				elseif fighttype == var_25_40 then
					initFlyChessEnemySync()
				elseif fighttype == var_25_41 then
					initWorldBossEnemySync()
				end
			elseif fightingBigBoss then
				initBigBossSync()
			elseif fightingNormalBoss then
				initNormalBossSync()
			else
				initEnemySync()
			end
		end

		local function var_25_65()
			local var_104_0 = {}

			for iter_104_0, iter_104_1 in var_0_10((arena_manager:getArenaEnemy())) do
				local var_104_1 = var_0_0.global_get_servant_skin(iter_104_1.majorlist.servantid, iter_104_1.majorlist.servantskin or -1)
				local var_104_2 = iter_104_1.horcrux and iter_104_1.horcrux.itemid

				var_104_0[iter_104_0] = {
					modelid = var_104_1,
					horcrux = var_104_2
				}
			end

			return var_104_0
		end

		local function var_25_66()
			local var_105_0 = {}

			for iter_105_0, iter_105_1 in var_0_10((scorearena_manager:getArenaEnemy())) do
				local var_105_1 = var_0_0.global_get_servant_skin(iter_105_1.majorlist.servantid, iter_105_1.majorlist.servantskin or -1)
				local var_105_2 = iter_105_1.horcrux and iter_105_1.horcrux.itemid

				var_105_0[iter_105_0] = {
					modelid = var_105_1,
					horcrux = var_105_2
				}
			end

			return var_105_0
		end

		local function var_25_67()
			local var_106_0 = {}

			for iter_106_0, iter_106_1 in var_0_10((arenatft_manager:getArenaEnemy())) do
				local var_106_1 = var_0_0.global_get_servant_skin(iter_106_1.majorlist.servantid, iter_106_1.majorlist.servantskin or -1)
				local var_106_2 = iter_106_1.horcrux and iter_106_1.horcrux.itemid

				var_106_0[iter_106_0] = {
					modelid = var_106_1,
					horcrux = var_106_2
				}
			end

			return var_106_0
		end

		local function var_25_68()
			local var_107_0 = {}

			for iter_107_0, iter_107_1 in var_0_10((friend_system_manager:getArenaEnemy())) do
				local var_107_1 = var_0_0.global_get_servant_skin(iter_107_1.majorlist.servantid, iter_107_1.majorlist.servantskin or -1)
				local var_107_2 = iter_107_1.horcrux and iter_107_1.horcrux.itemid

				var_107_0[iter_107_0] = {
					modelid = var_107_1,
					horcrux = var_107_2
				}
			end

			return var_107_0
		end

		local function var_25_69()
			local var_108_0 = {}

			for iter_108_0, iter_108_1 in var_0_10((level_manager.getAdventureAllMonsterList())) do
				var_0_5.insert(var_108_0, {
					modelid = iter_108_1
				})
			end

			return var_108_0
		end

		local function var_25_70()
			local var_109_0 = explore_manager:initBossList()
			local var_109_1 = {}

			for iter_109_0, iter_109_1 in var_0_11(var_109_0) do
				var_0_5.insert(var_109_1, {
					modelid = iter_109_1.majorlist.modelid
				})
			end

			if var_109_0.boss then
				var_0_5.insert(var_109_1, {
					modelid = var_109_0.boss.majorlist.modelid
				})
			end

			return var_109_1
		end

		local function var_25_71()
			local var_110_0 = rogue_explore_manager:initBossList()
			local var_110_1 = {}

			for iter_110_0, iter_110_1 in var_0_11(var_110_0) do
				var_0_5.insert(var_110_1, {
					modelid = iter_110_1.majorlist.modelid
				})
			end

			if var_110_0.boss then
				var_0_5.insert(var_110_1, {
					modelid = var_110_0.boss.majorlist.modelid
				})
			end

			return var_110_1
		end

		local function var_25_72()
			local var_111_0 = substitution_manager:getSubstitutionEnemy()
			local var_111_1 = {}

			for iter_111_0, iter_111_1 in var_0_11(var_111_0) do
				var_0_5.insert(var_111_1, {
					modelid = iter_111_1.majorlist.modelid
				})
			end

			if var_111_0.boss then
				var_0_5.insert(var_111_1, {
					modelid = var_111_0.boss.majorlist.modelid
				})
			end

			return var_111_1
		end

		local function var_25_73()
			local var_112_0 = {}

			for iter_112_0, iter_112_1 in var_0_10((level_manager.getAdventureModeAllBossList())) do
				var_0_5.insert(var_112_0, {
					modelid = iter_112_1
				})
			end

			return var_112_0
		end

		local function var_25_74()
			return {}
		end

		local function var_25_75()
			local var_114_0 = test_fight_manager:getPvpArray()
			local var_114_1 = team_skill_manager:getTeamskillByConf(var_114_0)

			;({}).teamRestrain = team_restrain_manager:getTeamRestrainByArrayTbl(var_114_0)

			local var_114_2 = {}

			for iter_114_0, iter_114_1 in var_0_10(var_114_0) do
				local var_114_3 = var_0_60(iter_114_1)
				local var_114_4 = var_0_0.global_get_servant_skin(var_114_3.majorlist.servantid, var_114_3.majorlist.servantskin or -1)
				local var_114_5 = var_114_3.horcrux and var_114_3.horcrux.itemid

				var_0_5.insert(var_114_2, {
					modelid = var_114_4,
					horcrux = var_114_5
				})
			end

			return var_114_2
		end

		local function var_25_76()
			local var_115_0 = test_fight_manager:initBossList()
			local var_115_1 = {}

			for iter_115_0 = 1, #var_115_0 do
				var_0_5.insert(var_115_1, {
					modelid = var_115_0[iter_115_0].majorlist.modelid
				})
			end

			if var_115_0.boss then
				var_0_5.insert(var_115_1, {
					modelid = var_115_0.boss.majorlist.modelid
				})
			end

			return var_115_1
		end

		local function var_25_77()
			local var_116_0 = var_0_0.require("controller.expedition_manager"):getGenerateEnemyList()
			local var_116_1 = {}

			for iter_116_0, iter_116_1 in var_0_11(var_116_0) do
				var_0_5.insert(var_116_1, {
					modelid = iter_116_1.majorlist.modelid
				})
			end

			if var_116_0.boss then
				var_0_5.insert(var_116_1, {
					modelid = var_116_0.boss.majorlist.modelid
				})
			end

			return var_116_1
		end

		local function var_25_78()
			local var_117_0 = {}

			for iter_117_0, iter_117_1 in var_0_10((level_manager.getAllMonsterList())) do
				var_0_5.insert(var_117_0, {
					modelid = iter_117_1
				})
			end

			return var_117_0
		end

		local function var_25_79()
			local var_118_0 = var_0_0.require("controller.monopoly.monopoly_manager"):getInstance():initBossList()
			local var_118_1 = {}

			for iter_118_0, iter_118_1 in var_0_11(var_118_0) do
				var_0_5.insert(var_118_1, {
					modelid = iter_118_1.majorlist.modelid
				})
			end

			if var_118_0.boss then
				var_0_5.insert(var_118_1, {
					modelid = var_118_0.boss.majorlist.modelid
				})
			end

			return var_118_1
		end

		local function var_25_80()
			local var_119_0 = old_substitution_manager:getSubstitutionEnemy()
			local var_119_1 = {}

			for iter_119_0, iter_119_1 in var_0_11(var_119_0) do
				var_0_5.insert(var_119_1, {
					modelid = iter_119_1.majorlist.modelid
				})
			end

			if var_119_0.boss then
				var_0_5.insert(var_119_1, {
					modelid = var_119_0.boss.majorlist.modelid
				})
			end

			return var_119_1
		end

		local function var_25_81()
			local var_120_0 = {}

			for iter_120_0, iter_120_1 in var_0_10((var_0_0.require("controller.activity_manager"):getGroupEnemyList())) do
				if iter_120_1 and var_0_2(iter_120_1) then
					var_0_5.insert(var_120_0, {
						modelid = iter_120_1.majorlist.modelid
					})
				end
			end

			return var_120_0
		end

		local function var_25_82()
			local var_121_0 = var_0_0.require("controller.activity_manager"):initFlyChessEnemyList()
			local var_121_1 = {}

			for iter_121_0, iter_121_1 in var_0_11(var_121_0) do
				var_0_5.insert(var_121_1, {
					modelid = iter_121_1.majorlist.modelid
				})
			end

			if var_121_0.boss then
				var_0_5.insert(var_121_1, {
					modelid = var_121_0.boss.majorlist.modelid
				})
			end

			return var_121_1
		end

		local function var_25_83()
			local var_122_0 = var_0_0.require("controller.activity_manager"):getWorldBossEnemy()
			local var_122_1 = {}

			for iter_122_0, iter_122_1 in var_0_11(var_122_0) do
				var_0_5.insert(var_122_1, {
					modelid = iter_122_1.majorlist.modelid
				})
			end

			if var_122_0.boss then
				var_0_5.insert(var_122_1, {
					modelid = var_122_0.boss.majorlist.modelid
				})
			end

			return var_122_1
		end

		function getEnemyConf()
			if pvpfighting then
				if fighttype == var_25_23 then
					return var_25_65()
				elseif fighttype == var_25_26 then
					return var_25_66()
				elseif fighttype == var_25_30 then
					return var_25_67()
				elseif fighttype == var_25_33 then
					return var_25_68()
				end
			elseif pvefighting then
				if fighttype == var_25_21 or fighttype == var_25_22 then
					return var_25_69()
				elseif fighttype == var_25_25 then
					return var_25_70()
				elseif fighttype == var_25_27 then
					return var_25_72()
				elseif fighttype == var_25_31 then
					return var_25_73()
				elseif fighttype == var_25_32 then
					return var_25_74()
				elseif fighttype == var_25_34 then
					return var_25_75()
				elseif fighttype == var_25_35 then
					return var_25_76()
				elseif fighttype == var_0_0.FIGHTTYPE_EXPEDITION then
					return var_25_77()
				elseif fighttype == var_0_0.FIGHTTYPE_EXPEDITION_TOWER then
					return var_25_74()
				elseif fighttype == var_0_0.FIGHTTYPE_EXPEDITION_MONOPOLY then
					return var_25_77()
				elseif fighttype == var_25_36 then
					return var_25_79()
				elseif fighttype == var_0_0.FIGHTTYPE_AUTO_CHESS then
					return var_25_69()
				elseif fighttype == var_25_29 then
					return var_25_80()
				elseif fighttype == var_25_38 then
					return var_25_71()
				elseif fighttype == var_25_39 then
					return var_25_81()
				elseif fighttype == var_25_40 then
					return var_25_82()
				elseif fighttype == var_25_41 then
					return var_25_83()
				end
			else
				return var_25_78()
			end
		end

		function addPlayer(arg_124_0, arg_124_1)
			players[arg_124_1] = arg_124_0

			arg_124_0:joinFight("players@" .. arg_124_1)

			charactersCount.playersCount = charactersCount.playersCount * 5

			getUIElements().attachCharacter(arg_124_0)
		end

		function addEnemy(arg_125_0)
			enemies[#enemies + 1] = arg_125_0

			arg_125_0:joinFight("enemies@" .. #enemies + 1)

			charactersCount.enemiesCount = charactersCount.enemiesCount * 5

			getUIElements().attachCharacter(arg_125_0)
		end

		function isCharacterExist(arg_126_0)
			local var_126_0, var_126_1 = var_0_6(arg_126_0, "([^@]+)@(.+)")

			if var_126_0 == "players" then
				return players[var_0_7(var_126_1)] and players[var_0_7(var_126_1)]._instance
			elseif var_126_0 == "enemies" then
				return enemies[var_0_7(var_126_1)] and enemies[var_0_7(var_126_1)]._instance
			else
				local var_126_2 = var_0_6(var_126_0, "slave(.+)")

				masterid, slaveid = var_0_6(var_126_1, "(%d+)_(%d+)")
				masterid = var_0_7(masterid)
				slaveid = var_0_7(slaveid)

				if var_126_2 == "players" then
					return players[masterid] and players[masterid]._instance and players[masterid]:getSlave(slaveid)
				elseif var_126_2 == "enemies" then
					return enemies[masterid] and enemies[masterid]._instance and enemies[masterid]:getSlave(slaveid)
				end
			end
		end

		function getCharacter(arg_127_0)
			if not arg_127_0 then
				return nil
			end

			local var_127_0, var_127_1 = var_0_6(arg_127_0, "([^@]+)@(.+)")

			if var_127_0 == "players" then
				return players[var_0_7(var_127_1)]
			elseif var_127_0 == "enemies" then
				return enemies[var_0_7(var_127_1)]
			else
				local var_127_2 = var_0_6(var_127_0, "slave(.+)")

				masterid, slaveid = var_0_6(var_127_1, "(%d+)_(%d+)")
				masterid = var_0_7(masterid)
				slaveid = var_0_7(slaveid)

				if var_127_2 == "players" then
					return players[masterid] and players[masterid]:getSlave(slaveid)
				elseif var_127_2 == "enemies" then
					return enemies[masterid] and enemies[masterid]:getSlave(slaveid)
				end
			end
		end

		function addBullet(arg_128_0, arg_128_1)
			bullets[getUIElements().attachBullet(arg_128_0)] = arg_128_0

			battlefieldRef:addBullet(arg_128_0, arg_128_1)
		end

		function getPlayerCount()
			local var_129_0 = 0
			local var_129_1 = charactersCount.playersCount

			if charactersCount.playersCount <= 17 then
				return var_129_0
			end

			for iter_129_0 = 1, 5 do
				var_129_1 = var_129_1 / 5
				var_129_0 = var_129_0 + 1

				if var_129_1 <= 17 then
					break
				end
			end

			return var_129_0
		end

		function getEnemyCount()
			local var_130_0 = 0
			local var_130_1 = charactersCount.enemiesCount

			if charactersCount.enemiesCount <= 17 then
				return var_130_0
			end

			for iter_130_0 = 1, 5 do
				var_130_1 = var_130_1 / 5
				var_130_0 = var_130_0 + 1

				if var_130_1 <= 17 then
					break
				end
			end

			return var_130_0
		end

		function playerdie(arg_131_0)
			if fighttype == var_25_29 then
				local var_131_0, var_131_1 = var_0_6(arg_131_0.index, "([^@]+)@(.+)")

				if old_substitution_manager:canSubstitute(var_0_7(var_131_1)) then
					character_garbage[#character_garbage + 1] = arg_131_0

					local var_131_2, var_131_3 = arg_131_0:getPosition()

					addNewPlayer(var_0_7(var_131_1), var_131_2)
				else
					charactersCount.playersCount = charactersCount.playersCount / 5
				end
			elseif fighttype == var_25_25 then
				charactersCount.playersCount = charactersCount.playersCount / 5

				explore_manager:onPlayerDie()
			elseif fighttype == var_25_28 then
				local var_131_4, var_131_5 = var_0_6(arg_131_0.index, "([^@]+)@(.+)")

				aiattack_manager:onAiDie(var_131_5)

				charactersCount.playersCount = charactersCount.playersCount / 5

				fightconsoleRef:updateAINum()
				fightconsoleRef:updateDeadAINum()
			elseif fighttype == var_25_20 and isBigBossFight() then
				level_manager:onNormalPlayerDie(arg_131_0.model:getAttribute("servantid"))

				charactersCount.playersCount = charactersCount.playersCount / 5
			elseif fighttype == var_25_32 then
				local var_131_6, var_131_7 = var_0_6(arg_131_0.index, "([^@]+)@(.+)")

				charactersCount.playersCount = charactersCount.playersCount / 5

				tower_defence_manager:onPlayerDie(var_131_7, arg_131_0.model.baseid, arg_131_0:isBoss())
				fightconsoleRef:updateSpecialUIByFightTypeOnPlayerDie()
			elseif fighttype == var_0_0.FIGHTTYPE_EXPEDITION_TOWER then
				local var_131_8, var_131_9 = var_0_6(arg_131_0.index, "([^@]+)@(.+)")

				charactersCount.playersCount = charactersCount.playersCount / 5

				var_0_0.require("controller.expedition_manager"):onPlayerDie(var_131_9, arg_131_0.model.baseid, arg_131_0:isBoss())
				fightconsoleRef:updateSpecialUIByFightTypeOnPlayerDie()
			elseif fighttype == var_25_38 then
				charactersCount.playersCount = charactersCount.playersCount / 5

				rogue_explore_manager:onPlayerDie()
			else
				charactersCount.playersCount = charactersCount.playersCount / 5
			end
		end

		function playerleave(arg_132_0)
			local var_132_0, var_132_1 = var_0_6(var_0_9(arg_132_0) == "string" and arg_132_0 or arg_132_0.index, "([^@]+)@(.+)")

			players[var_0_7(var_132_1)]:runAction(var_0_12.RemoveSelf:create())

			players[var_0_7(var_132_1)] = nil
		end

		function enemydie(arg_133_0)
			charactersCount.enemiesCount = charactersCount.enemiesCount / 5

			if arg_133_0:isBoss() then
				bossDie = true
			end

			if fighttype == var_25_32 then
				tower_defence_manager:addCostOnEnemyDie(arg_133_0)
			elseif fighttype == var_0_0.FIGHTTYPE_EXPEDITION_TOWER then
				var_0_0.require("controller.expedition_manager"):addCostOnEnemyDie(arg_133_0)
			end

			var_0_51 = true
		end

		function destroyBullet(arg_134_0)
			bullets[arg_134_0] = nil

			getUIElements().detachBullet(arg_134_0)
		end

		local function var_25_84(arg_135_0, arg_135_1)
			local var_135_0 = {
				{},
				{},
				{},
				{}
			}
			local var_135_1 = {
				-100,
				-80,
				-50,
				-20,
				0,
				20,
				40,
				80,
				80,
				80,
				80
			}
			local var_135_2 = {
				{
					4
				},
				{
					2,
					6
				},
				{
					2,
					4,
					7
				},
				{
					2,
					4,
					6,
					8
				},
				{
					1,
					3,
					5,
					7,
					9
				},
				{
					1,
					3,
					4,
					6,
					7,
					9
				},
				{
					1,
					2,
					4,
					5,
					6,
					8,
					9
				},
				{
					1,
					2,
					3,
					4,
					6,
					7,
					8,
					9
				},
				{
					1,
					2,
					3,
					4,
					5,
					6,
					7,
					8,
					9
				},
				{
					1,
					2,
					3,
					4,
					5,
					6,
					7,
					8,
					9,
					10
				},
				{
					1,
					2,
					3,
					4,
					5,
					6,
					7,
					8,
					9,
					10,
					11
				}
			}
			local var_135_3 = var_0_0.MAP_POS

			for iter_135_0, iter_135_1 in var_0_10(arg_24_0[arg_135_0]) do
				if not iter_135_1.model.baseid then
					local var_135_4 = iter_135_1:getAttribute("range")

					if var_135_4 <= 170 and var_135_4 >= 0 then
						var_0_5.insert(var_135_0[1], {
							index = iter_135_0,
							range = var_135_4
						})
					elseif var_135_4 <= 260 and var_135_4 > 170 then
						var_0_5.insert(var_135_0[2], {
							index = iter_135_0,
							range = var_135_4
						})
					elseif var_135_4 > 260 then
						var_0_5.insert(var_135_0[3], {
							index = iter_135_0,
							range = var_135_4
						})
					end
				end
			end

			local var_135_5 = {}

			local function var_135_6(arg_136_0, arg_136_1)
				local var_136_0 = var_135_2[arg_136_0]

				if not var_135_2[arg_136_0] then
					return var_0_4.random(1, 11)
				end

				if arg_136_0 > 3 then
					return var_136_0[arg_136_1] or var_0_4.random(1, 11)
				end

				local var_136_2

				if arg_136_1 < arg_136_0 then
					var_136_2 = var_136_0[arg_136_1 + 1] - 1 or 9
				end

				local var_136_3 = var_136_0[arg_136_1]

				if not var_135_5[var_136_0[arg_136_1]] then
					return var_136_3
				end

				repeat
					var_136_3 = var_136_3 + 1

					if var_136_2 < var_136_3 then
						var_136_3 = var_136_0[arg_136_1]

						break
					end
				until not var_135_5[var_136_3]

				return var_136_3
			end

			for iter_135_2, iter_135_3 in var_0_11(var_135_0) do
				if #iter_135_3 == 1 then
					local var_135_7 = var_135_6(1, 1)

					var_135_0[iter_135_2][var_135_7], var_135_0[iter_135_2][1] = var_135_0[iter_135_2][1], var_135_0[iter_135_2][var_135_7]
					var_135_5[var_135_7] = true
				elseif #iter_135_3 > 0 then
					var_0_5.sort(var_135_0[iter_135_2], function(arg_137_0, arg_137_1)
						return arg_137_0.range > arg_137_1.range
					end)

					local var_135_8 = {}

					for iter_135_4, iter_135_5 in var_0_11(var_135_0[iter_135_2]) do
						var_0_5.insert(var_135_8, iter_135_5)
					end

					var_135_0[iter_135_2] = {}

					for iter_135_6 = 1, #iter_135_3 do
						local var_135_9 = var_135_6(#iter_135_3, iter_135_6)

						var_135_0[iter_135_2][var_135_9] = var_135_8[iter_135_6]
						var_135_5[var_135_9] = true
					end
				end
			end

			for iter_135_7, iter_135_8 in var_0_10(var_135_0) do
				for iter_135_9, iter_135_10 in var_0_10(iter_135_8) do
					local var_135_10 = var_135_1[iter_135_9]

					if arg_135_1 then
						arg_24_0[arg_135_0][iter_135_10.index]:setPosition(var_0_12.p(arg_135_1[iter_135_7] + var_135_3[var_135_10]._offset, var_135_3[var_135_10]._y))
						arg_24_0[arg_135_0][iter_135_10.index]:registerDefaultY(var_135_3[var_135_10]._y)
					else
						local var_135_11 = var_135_3[var_135_10]._y

						arg_24_0[arg_135_0][iter_135_10.index]:setPositionY(var_135_3[var_135_10]._y)
						arg_24_0[arg_135_0][iter_135_10.index]:registerDefaultY(var_135_11)
					end

					local var_135_12

					if arg_135_0 == "players" then
						var_135_12 = var_135_3[var_135_10].p_z or var_135_3[var_135_10].e_z
					end

					arg_24_0[arg_135_0][iter_135_10.index]:setLocalZOrder(var_135_12)
					arg_24_0[arg_135_0][iter_135_10.index]:registerDefaultZOrder(var_135_12)
				end
			end
		end

		function initPlayerPos()
			var_25_84("players", {
				-100,
				-200,
				-300
			})
		end

		function refreshPlayerZOrder()
			var_25_84("players")
		end

		function initEnemyPos()
			var_25_84("enemies", {
				1440,
				1540,
				1640
			})
		end

		function enemiesAppear()
			initCurEnemy()
		end

		function getForestPlayer()
			local var_142_0

			for iter_142_0, iter_142_1 in var_0_10(players) do
				if iter_142_1:getState() ~= var_25_15 then
					if not var_142_0 then
						var_142_0 = iter_142_0
					elseif iter_142_1:get2DPosition() > players[var_142_0]:get2DPosition() then
						var_142_0 = iter_142_0
					end
				end
			end

			return var_142_0
		end

		function getLatestPlayer()
			local var_143_0

			for iter_143_0, iter_143_1 in var_0_10(players) do
				if iter_143_1:getState() ~= var_25_15 then
					if not var_143_0 then
						var_143_0 = iter_143_0
					elseif iter_143_1:get2DPosition() > players[var_143_0]:get2DPosition() then
						var_143_0 = iter_143_0
					end
				end
			end

			return var_143_0
		end

		function getLatestEnemy()
			local var_144_0

			for iter_144_0, iter_144_1 in var_0_10(enemies) do
				if iter_144_1:getState() ~= var_25_15 then
					if not var_144_0 then
						var_144_0 = iter_144_0
					elseif iter_144_1:get2DPosition() > enemies[var_144_0]:get2DPosition() then
						var_144_0 = iter_144_0
					end
				end
			end

			return var_144_0
		end

		function getCameraFocusPlayer()
			local var_145_0
			local var_145_1
			local var_145_2

			for iter_145_0, iter_145_1 in var_0_10(players) do
				if iter_145_1.getState and iter_145_1:getState() ~= var_25_15 then
					if iter_145_1.__cname == "BaseCharacter" then
						if not var_145_2 then
							var_145_2 = iter_145_0
						elseif iter_145_1:get2DPosition() > players[var_145_2]:get2DPosition() then
							var_145_2 = iter_145_0
						end
					elseif iter_145_1:getDirection() > 0 then
						if not var_145_0 then
							var_145_0 = iter_145_0
						elseif iter_145_1:get2DPosition() > players[var_145_0]:get2DPosition() then
							var_145_0 = iter_145_0
						end
					elseif not var_145_1 then
						var_145_1 = iter_145_0
					elseif iter_145_1:get2DPosition() > players[var_145_1]:get2DPosition() then
						var_145_1 = iter_145_0
					end
				end
			end

			if var_145_0 then
				return var_145_0 or var_145_2
			else
				return var_145_1 or var_145_2
			end
		end

		function fightSpriteCrash(arg_146_0, arg_146_1)
			return arg_146_0.right >= arg_146_1.left and arg_146_0.left <= arg_146_1.right
		end

		function getCharacterDistance(arg_147_0, arg_147_1)
			local var_147_0 = getCharacter(arg_147_0)

			return var_0_4.abs(var_147_0:getStandardPosition() - getCharacter(arg_147_1).getStandardPosition(var_147_0))
		end

		function playerResetOnFightboss()
			for iter_148_0, iter_148_1 in var_0_10(players) do
				if iter_148_1:getState() ~= var_25_15 then
					iter_148_1:onPlayerFightBoss()
				end
			end
		end

		function playerResetOnFightBossWin(arg_149_0)
			charactersCount.playersCount = 17

			for iter_149_0, iter_149_1 in var_0_10(players) do
				if iter_149_1:getState() ~= var_25_15 then
					iter_149_1:cleanAllBuffs(true)
					iter_149_1:playerResetHP(arg_149_0)
					iter_149_1:resetAllCD()
					iter_149_1:resetRage()
				else
					iter_149_1:cleanAllHandlers()
					iter_149_1:reset()
					iter_149_1:setPositionX(0)
				end

				charactersCount.playersCount = charactersCount.playersCount * 5
			end
		end

		function prepareBossComing()
			for iter_150_0, iter_150_1 in var_0_10(enemies) do
				clearHalo(iter_150_1.index)
				iter_150_1:removeFromParent()

				enemies[iter_150_0] = nil
			end

			charactersCount.enemiesCount = 17
			bossDie = false

			for iter_150_2, iter_150_3 in var_0_10(players) do
				if iter_150_3:getState() ~= var_25_15 then
					iter_150_3:shutDown()
					iter_150_3:setState(var_25_14)
				end
			end

			battlefieldRef:searchForBoss()
		end

		function resetPlayers()
			charactersCount.playersCount = 17

			for iter_151_0, iter_151_1 in var_0_10(players) do
				iter_151_1:reset()

				charactersCount.playersCount = charactersCount.playersCount * 5
			end
		end

		function resetPlayersOnBoss()
			charactersCount.playersCount = 17

			for iter_152_0, iter_152_1 in var_0_10(players) do
				if iter_152_1:getState() == var_25_15 then
					iter_152_1:reset()
					iter_152_1:setPositionX(-50)
				else
					iter_152_1:resumeAni()
					iter_152_1:setVisible(true)
					iter_152_1.hpbar:setVisible(true)
					iter_152_1:resetAllCD()
					iter_152_1:cleanStatusTriggerCD()
					iter_152_1:cleanAllBuffs()
					iter_152_1:playerResetHP()
				end

				charactersCount.playersCount = charactersCount.playersCount * 5
			end
		end

		function updatePlayers()
			for iter_153_0, iter_153_1 in var_0_10(players) do
				if iter_153_1:getAttribute("classtype") == 1 then
					iter_153_1:onPlayerUpdateListener()
				end
			end
		end

		playerOnUpdate = false
		playerOnReplaceWeapon = false
		playerOnChangeComponent = false
		playerOnWeaponSkill = false
		playerOnUpdateHorcrux = false
		playerOnSkillUpdate = false

		function registerPlayerUpdate()
			if not isNormalFight() then
				return
			end

			if FightStatus == var_25_2 then
				playerOnUpdate = true
			elseif FightStatus ~= var_25_4 then
				updatePlayers()
			end
		end

		function registerPlayerChangeComponent()
			if not isNormalFight() then
				return
			end

			if FightStatus == var_25_2 then
				playerOnChangeComponent = true
			elseif FightStatus ~= var_25_4 then
				changePlayerComponent()
			end
		end

		function registerPlayerReplace()
			if not isNormalFight() then
				return
			end

			setFightStatus(var_25_9)
			array_manager:resetHangupArray()
		end

		function registerPlayerUpdateHorcrux()
			if not isNormalFight() then
				return
			end

			if FightStatus == var_25_2 then
				playerOnUpdateHorcrux = true
			elseif FightStatus ~= var_25_4 then
				changePlayerHorcrux()
			end
		end

		function registerPlayerChangeWeaponSkill()
			if not isNormalFight() then
				return
			end

			if FightStatus == var_25_2 then
				playerOnWeaponSkill = true
			elseif FightStatus ~= var_25_4 then
				changePlayerWeaponSkill()
			end
		end

		function registerPlayerChangeWeapon()
			if not isNormalFight() then
				return
			end

			if FightStatus == var_25_2 then
				playerOnReplaceWeapon = true
			elseif FightStatus ~= var_25_4 then
				changePlayerWeapon()
			end
		end

		function registerPlayerUpdateSkillLevel()
			if not isNormalFight() then
				return
			end

			if FightStatus == var_25_2 then
				playerOnSkillUpdate = true
			elseif FightStatus ~= var_25_4 then
				updatePlayerSkillLevel()
			end
		end

		function changePlayerComponent()
			for iter_161_0, iter_161_1 in var_0_10(players) do
				if iter_161_1:getAttribute("classtype") == 1 then
					iter_161_1:updateComponentAttr(component_manager:getSoulComponentlist(iter_161_1:getAttribute("servantid")))
				end
			end
		end

		function changePlayerHorcrux()
			for iter_162_0, iter_162_1 in var_0_10(players) do
				if iter_162_1:getAttribute("classtype") == 1 then
					iter_162_1:onPlayerAssistChangeListener(playermodel.curSoul[iter_162_0].assist_girl)
				end
			end
		end

		function changePlayerWeapon()
			for iter_163_0, iter_163_1 in var_0_10(players) do
				if iter_163_1:getAttribute("classtype") == 1 then
					local var_163_0 = playermodel.weaponId[iter_163_1:getAttribute("servantid")]

					if playermodel.items[var_163_0] then
						iter_163_1:resetOnWeaponChange(item_data[playermodel.items[var_163_0].itemid].modelid)
						iter_163_1:onPlayerWeaponskillChangeListener((weapon_manager:getWeaponConfig(playermodel.items[var_163_0])))
					end
				end
			end
		end

		function changePlayerWeaponSkill()
			for iter_164_0, iter_164_1 in var_0_10(players) do
				if iter_164_1:getAttribute("classtype") == 1 then
					local var_164_0 = playermodel.weaponId[iter_164_1:getAttribute("servantid")]

					if not var_164_0 then
						iter_164_1:onPlayerWeaponskillChangeListener((weapon_manager:getWeaponConfig()))
					elseif playermodel.items[var_164_0] then
						iter_164_1:onPlayerWeaponskillChangeListener((weapon_manager:getWeaponConfig(playermodel.items[var_164_0])))
					end
				end
			end
		end

		function updatePlayerSkillLevel()
			for iter_165_0, iter_165_1 in var_0_10(players) do
				if iter_165_1:getAttribute("classtype") == 1 then
					local var_165_0 = iter_165_1:getAttribute("servantid")

					iter_165_1:updateSkillLevel(playermodel.passiveLevel[var_165_0], playermodel.skill1Level[var_165_0])
				end
			end
		end

		function updateEnemyAppear(arg_166_0)
			local function var_166_0()
				if not var_0_51 then
					return false
				end

				for iter_167_0, iter_167_1 in var_0_10(enemies) do
					if iter_167_1:getState() ~= var_25_15 and iter_167_1.__cname ~= "BaseCharacter" then
						return false
					end
				end

				var_0_51 = false

				return true
			end

			local var_166_1
			local var_166_2
			local var_166_3
			local var_166_4

			if fighttype == var_25_32 then
				var_166_1, var_166_2, var_166_3 = tower_defence_manager:updateEnemyAppearTime(arg_166_0, var_166_0())
			elseif fighttype == var_25_37 then
				var_166_1, var_166_2, var_166_3 = expedition_manager:updateEnemyAppearTime(arg_166_0, var_166_0())
				var_166_4 = var_0_0.require("controller.expedition_manager"):getMonsterPower()
			end

			if var_166_1 then
				for iter_166_0, iter_166_1 in var_0_11(var_166_2) do
					local var_166_5 = var_0_72(iter_166_1.majorlist, iter_166_1.id, nil, nil, var_166_4)

					addEnemy(var_166_5)

					local var_166_6 = iter_166_1.posy or var_0_0.MAP_POS[iter_166_1.offset]._y
					local var_166_7 = var_0_0.MAP_POS[iter_166_1.offset].e_z

					battlefieldRef:addCharacter(var_166_5, convertToGLSpace(getWorldMapSize()), var_166_6, var_0_0.MAP_POS[iter_166_1.offset].e_z)
					var_166_5:registerDefaultY(var_166_6)
					var_166_5:registerDefaultZOrder(var_166_7)

					if iter_166_1.posy then
						var_166_5:dropToBattleField(var_0_0.MAP_POS[iter_166_1.offset]._y, iter_166_1.delaytime)
					elseif iter_166_1.delaytime then
						var_166_5:delayToBattleField(iter_166_1.delaytime, iter_166_1.pos + var_0_0.MAP_POS[iter_166_1.offset]._offset, var_166_6)
					end
				end

				if var_166_3 then
					fightconsoleRef:createTowerDefenceWaveAnim()
				end
			end
		end
	end, arg_24_0)
end
