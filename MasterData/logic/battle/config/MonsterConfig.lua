-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/MonsterConfig.lua

module("logic.battle.config.MonsterConfig", package.seeall)

local MonsterConfig = class("MonsterConfig")

function MonsterConfig:ctor()
	self._levelCodeLoadedCache = {}
	self._cfgMonster = {
		[10000000] = {
			normalSkill = 1001,
			name = "全局技能释放假人",
			pre_magicAtk = 0,
			maxHp = 1,
			aiName = "mob_passive_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 0,
			pre_meleeDef = 45,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 45,
			level = 1,
			hasGodlike = false,
			meleeAtk = 224.7,
			pre_meleeAtk = 224.7,
			pre_maxHp = 1,
			colorType = 3,
			monsterType = 0,
			id = 10000000,
			mobility = 2,
			pre_magicDef = 0,
			aiStepOrder = 1,
			trumpSkill = 0,
			inspire = 0,
			camp = 0,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			pre_inspire = 0,
			modelId = 130000,
			magicDef = 0,
			specialSkill = 0,
			extraSkills = {}
		}
	}
end

function MonsterConfig:getMonsterCO(code, ignoreLog)
	local monsterCO = self._cfgMonster[code]

	if code > 0 and not monsterCO and ignoreLog and BattleLog.enableError then
		BattleLog.error(string.format("MonsterConfig::cannot find monster config for code[%s]", code))
	end

	return monsterCO
end

function MonsterConfig:loadLevelMonsterConfig(levelCode)
	if self._levelCodeLoadedCache[levelCode] then
		return
	end

	local levelCO = BattleConfig.instance:getBattleLevelCO(levelCode)

	if not levelCO then
		return
	end

	local monsters = levelCO.monsters

	for monsterCode, monsterCO in pairs(monsters) do
		self._cfgMonster[monsterCode] = monsterCO
	end

	self._levelCodeLoadedCache[levelCode] = true
end

function MonsterConfig:loadDungeonMonsterConfig(dungeonId)
	local dungeonCO = DungeonConfig.instance:getDungeonCfgById(dungeonId)

	self:loadLevelMonsterConfig(dungeonCO.levelID)
end

MonsterConfig.instance = MonsterConfig.New()

return MonsterConfig
