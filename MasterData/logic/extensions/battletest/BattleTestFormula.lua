-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battletest/BattleTestFormula.lua

module("logic.extensions.battletest.BattleTestFormula", package.seeall)

local BattleTestFormula = {}
local kDefaultLevel = 1

local function kCalculateAttribute(b, s, level)
	level = level or kDefaultLevel

	return checkint(b + s * (level - 1))
end

BattleTestFormula.characterConfigFormula = {}

function BattleTestFormula.characterConfigFormula.code(characterCO)
	return characterCO.id
end

function BattleTestFormula.characterConfigFormula.level(characterCO)
	return kDefaultLevel
end

function BattleTestFormula.characterConfigFormula.hasSanity(characterCO)
	return 1
end

function BattleTestFormula.characterConfigFormula.name(characterCO)
	local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(characterCO.id)

	return heroInfoCO.name
end

function BattleTestFormula.characterConfigFormula.battleCamp(characterCO)
	return 2
end

function BattleTestFormula.characterConfigFormula.sanity(characterCO)
	return characterCO.initialSan
end

function BattleTestFormula.characterConfigFormula.skillCodes(characterCO)
	local skillCodes = {}

	BattleTableUtil.insertto(skillCodes, characterCO.normalSkills)

	if characterCO.battleTalent[1] > 0 then
		table.insert(skillCodes, characterCO.battleTalent[1])
	end

	return table.concat(skillCodes, ",")
end

function BattleTestFormula.characterConfigFormula.enhanceCodes(characterCO)
	local skillCodes = BattleTestFormula.characterConfigFormula.skillCodes(characterCO)

	skillCodes = string.splitToNumber(skillCodes, ",")

	local enhanceCodes = {}

	for _, skillCode in pairs(skillCodes) do
		BattleTableUtil.insertto(enhanceCodes, ActiveSkillConfig.instance:getEnhanceCodesOfSkill(skillCode))
	end

	return table.concat(enhanceCodes, ",")
end

function BattleTestFormula.characterConfigFormula.move(characterCO)
	return characterCO.move
end

function BattleTestFormula.characterConfigFormula.aiName(characterCO, level)
	return characterCO.aiName
end

function BattleTestFormula.characterConfigFormula.maxHp(characterCO, level)
	return kCalculateAttribute(characterCO.b_maxHp, characterCO.s_maxHp, level)
end

function BattleTestFormula.characterConfigFormula.atkPhy(characterCO, level)
	return kCalculateAttribute(characterCO.b_meleeAtk, characterCO.s_meleeAtk, level)
end

function BattleTestFormula.characterConfigFormula.defPhy(characterCO, level)
	return kCalculateAttribute(characterCO.b_meleeDef, characterCO.s_meleeDef, level)
end

function BattleTestFormula.characterConfigFormula.atkMag(characterCO, level)
	return kCalculateAttribute(characterCO.b_magicAtk, characterCO.s_magicAtk, level)
end

function BattleTestFormula.characterConfigFormula.defMag(characterCO, level)
	return kCalculateAttribute(characterCO.b_magicDef, characterCO.s_magicDef, level)
end

function BattleTestFormula.characterConfigFormula.inspiration(characterCO, level)
	return kCalculateAttribute(characterCO.b_inspire, characterCO.s_inspire, level)
end

function BattleTestFormula.characterConfigFormula.weakPointColor(characterCO, level)
	return -1
end

function BattleTestFormula.characterConfigFormula.weakPointHpRate(characterCO, level)
	return 0
end

BattleTestFormula.monsterConfigFormula = {}

function BattleTestFormula.monsterConfigFormula.code(monsterCO)
	return monsterCO.id
end

function BattleTestFormula.monsterConfigFormula.level(monsterCO)
	return MonsterCOUtil.getLevel(monsterCO)
end

function BattleTestFormula.monsterConfigFormula.name(monsterCO)
	return monsterCO.name
end

function BattleTestFormula.monsterConfigFormula.battleCamp(monsterCO)
	return monsterCO.battleCamp
end

function BattleTestFormula.monsterConfigFormula.hasSanity(monsterCO)
	return monsterCO.hasSanity and 1 or 0
end

function BattleTestFormula.monsterConfigFormula.sanity(monsterCO)
	return monsterCO.sanity
end

function BattleTestFormula.monsterConfigFormula.skillCodes(monsterCO)
	local skillCodes = {}

	if monsterCO.normalSkill > 0 then
		table.insert(skillCodes, monsterCO.normalSkill)
	end

	if monsterCO.specialSkill > 0 then
		table.insert(skillCodes, monsterCO.specialSkill)
	end

	if monsterCO.trumpSkill > 0 then
		table.insert(skillCodes, monsterCO.trumpSkill)
	end

	if monsterCO.giftSkill > 0 then
		table.insert(skillCodes, monsterCO.giftSkill)
	end

	return table.concat(skillCodes, ",")
end

function BattleTestFormula.monsterConfigFormula.enhanceCodes(monsterCO)
	local skillCodes = BattleTestFormula.monsterConfigFormula.skillCodes(monsterCO)

	skillCodes = string.splitToNumber(skillCodes, ",")

	local enhanceCodes = {}

	for _, skillCode in pairs(skillCodes) do
		BattleTableUtil.insertto(enhanceCodes, ActiveSkillConfig.instance:getEnhanceCodesOfSkill(skillCode))
	end

	return table.concat(enhanceCodes, ",")
end

function BattleTestFormula.monsterConfigFormula.move(monsterCO)
	return monsterCO.mobility
end

function BattleTestFormula.monsterConfigFormula.aiName(monsterCO, level)
	return monsterCO.aiName
end

function BattleTestFormula.monsterConfigFormula.maxHp(monsterCO, level)
	return monsterCO.maxHp
end

function BattleTestFormula.monsterConfigFormula.atkPhy(monsterCO, level)
	return monsterCO.meleeAtk
end

function BattleTestFormula.monsterConfigFormula.defPhy(monsterCO, level)
	return monsterCO.meleeDef
end

function BattleTestFormula.monsterConfigFormula.atkMag(monsterCO, level)
	return monsterCO.magicAtk
end

function BattleTestFormula.monsterConfigFormula.defMag(monsterCO, level)
	return monsterCO.magicDef
end

function BattleTestFormula.monsterConfigFormula.inspiration(monsterCO, level)
	return monsterCO.inspire
end

function BattleTestFormula.monsterConfigFormula.weakPointColor(monsterCO, level)
	return monsterCO.weakPointColor
end

function BattleTestFormula.monsterConfigFormula.weakPointHpRate(monsterCO, level)
	return monsterCO.weakPointHpRate
end

return BattleTestFormula
