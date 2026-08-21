-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/DungeonBattleInfoCOWrapper.lua

module("logic.battle.config.DungeonBattleInfoCOWrapper", package.seeall)

local DungeonBattleInfoCOWrapper = class("DungeonBattleInfoCOWrapper")
local kConditionDefaultWinTag = -1
local kConditionDefaultLossTag = -2
local kWinConditionPatterns = {
	"%s回合内击杀所有敌人",
	"存活%s回合",
	"%s回合内击杀%s",
	"%s回合内击破敌人弱点",
	"%s回合内击破%s弱点",
	"%s回合内全体守秘人撤离",
	"%s回合内%s名守秘人撤离",
	"%s回合内%s撤离",
	"%s回合内%s撤离",
	"己方全灭",
	"%s回合内击杀所有指定单位",
	nil,
	"%s回合内击杀所有敌人(包括隐藏)"
}
local kLoseConditionPatterns = {
	"守秘人全灭",
	"%s死亡",
	"%s名守秘人死亡",
	"%s弱点被击破",
	"所有敌人撤离",
	"%s名敌人撤离",
	"%s撤离",
	"光柱全部被点亮"
}
local kWinConditionDescriptionParsers = {}
local kLoseConditionDescriptionParsers = {}
local kWinConditionDataParsers = {}
local kLoseConditionDataParsers = {}
local kConditionDescriptionJoinAnd = "且\n"
local kConditionDescriptionJoinOr = "<color=#FFFFFF>或</color>"

function DungeonBattleInfoCOWrapper:ctor(dungeonBattleInfoCO)
	self._dungeonBattleInfoCO = dungeonBattleInfoCO
	self._killEntityCodes = {}
	self._protectEntityCodes = {}
	self._lockedRefreshType2LockedHeroes = {}
	self._tag2ConditionDescriptionTable = {}
	self._tag2ConditionCategoryTable = {}
	self._defaultWinTags = {
		kConditionDefaultWinTag
	}
	self._defaultLoseTags = {
		kConditionDefaultLossTag
	}
	self._tag2EscapePoint = {}
	self._tag2KillEntityCodes = {}
	self._tag2ProtectEntityCodes = {}

	self:_buildConfig()
end

function DungeonBattleInfoCOWrapper:getDungeonBattleInfoCO()
	return self._dungeonBattleInfoCO
end

function DungeonBattleInfoCOWrapper:getWinConditionDescription(tags)
	if tags and #tags > 0 then
		return self:buildConditionDescription(tags)
	end
end

function DungeonBattleInfoCOWrapper:getLoseConditionDescription(tags)
	if tags and #tags > 0 then
		return self:buildConditionDescription(tags)
	end
end

function DungeonBattleInfoCOWrapper:getKillEntityCodes()
	return self._killEntityCodes
end

function DungeonBattleInfoCOWrapper:getProtectEntityCodes()
	return self._protectEntityCodes
end

function DungeonBattleInfoCOWrapper:hasEscape(winTags, lossTags)
	if winTags then
		for i, tag in ipairs(winTags) do
			if self._tag2EscapePoint[tag] then
				return true
			end
		end
	end

	if lossTags then
		for i, tag in ipairs(lossTags) do
			if self._tag2EscapePoint[tag] then
				return true
			end
		end
	end

	return false
end

function DungeonBattleInfoCOWrapper:fillKillEntityCodes(fillCodes, tags)
	if tags and #tags > 0 then
		for i, tag in ipairs(tags) do
			local entityCodes = self._tag2KillEntityCodes[tag]

			if entityCodes then
				table.insertto(fillCodes, entityCodes)
			end
		end
	end
end

function DungeonBattleInfoCOWrapper:fillProtectEntityCodes(fillCodes, tags)
	if tags and #tags > 0 then
		for i, tag in ipairs(tags) do
			local entityCodes = self._tag2ProtectEntityCodes[tag]

			if entityCodes then
				table.insertto(fillCodes, entityCodes)
			end
		end
	end
end

function DungeonBattleInfoCOWrapper:getDefaultWinTags()
	return self._defaultWinTags
end

function DungeonBattleInfoCOWrapper:getDefaultLoseTags()
	return self._defaultLoseTags
end

function DungeonBattleInfoCOWrapper:getLockedHeroes(lockedHeroRefreshType)
	return self._lockedRefreshType2LockedHeroes[lockedHeroRefreshType] or false
end

function DungeonBattleInfoCOWrapper:getConditionDescription(tag)
	return self._tag2ConditionDescriptionTable[tag]
end

function DungeonBattleInfoCOWrapper:isWinCondition(tag)
	return self._tag2ConditionCategoryTable[tag]
end

function DungeonBattleInfoCOWrapper:buildConditionDescription(tags)
	local sb = StringBuffer.New()

	for _, tag in ipairs(tags) do
		local desc = self:getConditionDescription(tag)

		if not string.nilorempty(desc) then
			sb:append(desc)
		end
	end

	return sb:toString(kConditionDescriptionJoinOr)
end

function DungeonBattleInfoCOWrapper:_buildConfig()
	local dungeonBattleInfoCO = self._dungeonBattleInfoCO

	self:_parseDescription(dungeonBattleInfoCO)
	self:_parseLockedHeros(dungeonBattleInfoCO)
end

function DungeonBattleInfoCOWrapper:_parseDescription(dungeonBattleInfoCO)
	local globalWinDesc = dungeonBattleInfoCO.winConditionDesc ~= "" and dungeonBattleInfoCO.winConditionDesc or false
	local globalLossDesc = dungeonBattleInfoCO.lossConditionDesc ~= "" and dungeonBattleInfoCO.lossConditionDesc or false
	local sb = StringBuffer.New()
	local isEmpty = true
	local subSb = StringBuffer.New()

	for _, subWinConditionGroup in ipairs(dungeonBattleInfoCO.winConditionGroupList) do
		for _, winCondition in ipairs(subWinConditionGroup.winConditionList) do
			subSb:append(self:_parseOneWinCondition(winCondition, subWinConditionGroup.hasTag and subWinConditionGroup.tag or kConditionDefaultWinTag))
		end

		local subDescription = subSb:toString(kConditionDescriptionJoinAnd)

		if subWinConditionGroup.hasTag then
			self._tag2ConditionDescriptionTable[subWinConditionGroup.tag] = globalWinDesc and globalWinDesc or subDescription
			self._tag2ConditionCategoryTable[subWinConditionGroup.tag] = true

			if not subWinConditionGroup.isBackup then
				table.insert(self._defaultWinTags, subWinConditionGroup.tag)
			end
		else
			isEmpty = false

			sb:append(subDescription)
		end

		subSb:clear()
	end

	local winConditionDescription = isEmpty and "" or sb:toString(kConditionDescriptionJoinOr)

	self._tag2ConditionDescriptionTable[kConditionDefaultWinTag] = globalWinDesc and globalWinDesc or winConditionDescription

	sb:clear()

	isEmpty = true

	for _, lossCondition in ipairs(dungeonBattleInfoCO.lossConditionList) do
		local subDescription = self:_parseOneLoseCondition(lossCondition, lossCondition.hasTag and lossCondition.tag or kConditionDefaultLossTag)

		if lossCondition.hasTag then
			self._tag2ConditionDescriptionTable[lossCondition.tag] = globalLossDesc and globalLossDesc or subDescription
			self._tag2ConditionCategoryTable[lossCondition.tag] = false

			if not lossCondition.isBackup then
				table.insert(self._defaultLoseTags, lossCondition.tag)
			end
		else
			isEmpty = false

			sb:append(subDescription)
		end
	end

	local loseConditionDescription = isEmpty and "" or sb:toString(kConditionDescriptionJoinOr)

	self._tag2ConditionDescriptionTable[kConditionDefaultLossTag] = globalLossDesc and globalLossDesc or loseConditionDescription
end

function DungeonBattleInfoCOWrapper:_parseLockedHeros(dungeonBattleInfoCO)
	if not dungeonBattleInfoCO.lockHeroList then
		return
	end

	for i, lockHero in ipairs(dungeonBattleInfoCO.lockHeroList) do
		local refreshType = lockHero.heroType
		local lockedHeroes = self._lockedRefreshType2LockedHeroes[refreshType]

		if not lockedHeroes then
			lockedHeroes = {}
			self._lockedRefreshType2LockedHeroes[refreshType] = lockedHeroes
		end

		if lockHero.heroId > 0 then
			table.insert(self._lockedRefreshType2LockedHeroes[refreshType], lockHero.heroId)
		else
			table.insert(self._lockedRefreshType2LockedHeroes[refreshType], lockHero.monsterId)
		end
	end
end

function DungeonBattleInfoCOWrapper:_parseOneWinCondition(conditionCO, tag)
	local t = conditionCO.condition
	local dataParser = kWinConditionDataParsers[t]

	if dataParser then
		dataParser(self, conditionCO, tag)
	end

	if not string.nilorempty(conditionCO.DIYName) then
		return conditionCO.DIYName
	end

	local t = conditionCO.condition
	local parser = kWinConditionDescriptionParsers[t]

	if parser then
		return parser(self, conditionCO)
	end

	return kWinConditionPatterns[t]
end

function DungeonBattleInfoCOWrapper:_parseOneLoseCondition(conditionCO, tag)
	local t = conditionCO.condition
	local dataParser = kLoseConditionDataParsers[t]

	if dataParser then
		dataParser(self, conditionCO, tag)
	end

	if not string.nilorempty(conditionCO.DIYName) then
		return conditionCO.DIYName
	end

	local parser = kLoseConditionDescriptionParsers[t]

	if parser then
		return parser(self, conditionCO)
	end

	return kLoseConditionPatterns[t]
end

kWinConditionDescriptionParsers[1] = function(self, conditionCO)
	local desPattern = kWinConditionPatterns[conditionCO.condition]

	return string.format(desPattern, self._dungeonBattleInfoCO.maxRound)
end
kWinConditionDescriptionParsers[2] = function(self, conditionCO)
	local desPattern = kWinConditionPatterns[conditionCO.condition]

	return string.format(desPattern, conditionCO.round)
end
kWinConditionDescriptionParsers[3] = function(self, conditionCO)
	local monsterCO = MonsterConfig.instance:getMonsterCO(conditionCO.monsterIds[1])
	local desPattern = kWinConditionPatterns[conditionCO.condition]

	return string.format(desPattern, self._dungeonBattleInfoCO.maxRound, monsterCO.name)
end
kWinConditionDescriptionParsers[4] = function(self, conditionCO)
	local desPattern = kWinConditionPatterns[conditionCO.condition]

	return string.format(desPattern, self._dungeonBattleInfoCO.maxRound)
end
kWinConditionDescriptionParsers[5] = function(self, conditionCO)
	local monsterCO = MonsterConfig.instance:getMonsterCO(conditionCO.monsterIds[1])
	local desPattern = kWinConditionPatterns[conditionCO.condition]

	return string.format(desPattern, self._dungeonBattleInfoCO.maxRound, monsterCO.name)
end
kWinConditionDescriptionParsers[6] = function(self, conditionCO)
	local desPattern = kWinConditionPatterns[conditionCO.condition]

	return string.format(desPattern, self._dungeonBattleInfoCO.maxRound)
end
kWinConditionDescriptionParsers[7] = function(self, conditionCO)
	local desPattern = kWinConditionPatterns[conditionCO.condition]

	return string.format(desPattern, self._dungeonBattleInfoCO.maxRound, conditionCO.count)
end
kWinConditionDescriptionParsers[8] = function(self, conditionCO)
	local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(conditionCO.heroId)
	local desPattern = kWinConditionPatterns[conditionCO.condition]

	return string.format(desPattern, self._dungeonBattleInfoCO.maxRound, heroInfoCO.name)
end
kWinConditionDescriptionParsers[9] = function(self, conditionCO)
	local monsterCO = MonsterConfig.instance:getMonsterCO(conditionCO.monsterIds[1])
	local desPattern = kWinConditionPatterns[conditionCO.condition]

	return string.format(desPattern, self._dungeonBattleInfoCO.maxRound, monsterCO.name)
end
kWinConditionDescriptionParsers[11] = function(self, conditionCO)
	local monsterCO = MonsterConfig.instance:getMonsterCO(conditionCO.monsterIds[1])
	local desPattern = kWinConditionPatterns[conditionCO.condition]

	return string.format(desPattern, self._dungeonBattleInfoCO.maxRound, monsterCO.name)
end
kWinConditionDescriptionParsers[13] = function(self, conditionCO)
	local desPattern = kWinConditionPatterns[conditionCO.condition]

	return string.format(desPattern, self._dungeonBattleInfoCO.maxRound)
end
kWinConditionDataParsers[3] = function(self, conditionCO, tag)
	if not self._tag2KillEntityCodes[tag] then
		self._tag2KillEntityCodes[tag] = {}
	end

	table.insert(self._tag2KillEntityCodes[tag], conditionCO.monsterIds[1])
	table.insert(self._killEntityCodes, conditionCO.monsterIds[1])
end
kWinConditionDataParsers[5] = function(self, conditionCO, tag)
	self._tag2EscapePoint[tag] = true
end
kWinConditionDataParsers[6] = function(self, conditionCO, tag)
	self._tag2EscapePoint[tag] = true
end
kWinConditionDataParsers[7] = function(self, conditionCO, tag)
	self._tag2EscapePoint[tag] = true
end
kWinConditionDataParsers[8] = function(self, conditionCO, tag)
	self._tag2EscapePoint[tag] = true
end
kWinConditionDataParsers[11] = function(self, conditionCO, tag)
	if not self._tag2KillEntityCodes[tag] then
		self._tag2KillEntityCodes[tag] = {}
	end

	for i, monsterId in ipairs(conditionCO.monsterIds) do
		table.insert(self._tag2KillEntityCodes[tag], monsterId)
		table.insert(self._killEntityCodes, monsterId)
	end
end
kLoseConditionDescriptionParsers[2] = function(self, conditionCO)
	local desPattern = kLoseConditionPatterns[conditionCO.condition]
	local monsterOrCharacterCode = conditionCO.targetId

	if BattleConfigUtil.isMonsterCode(monsterOrCharacterCode) then
		local monsterCO = MonsterConfig.instance:getMonsterCO(monsterOrCharacterCode)

		return string.format(desPattern, monsterCO.name)
	end

	local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(monsterOrCharacterCode)

	return string.format(desPattern, heroInfoCO.name)
end
kLoseConditionDescriptionParsers[3] = function(self, conditionCO)
	local desPattern = kLoseConditionPatterns[conditionCO.condition]

	return string.format(desPattern, conditionCO.maxDeadCount + 1)
end
kLoseConditionDescriptionParsers[4] = function(self, conditionCO)
	local desPattern = kLoseConditionPatterns[conditionCO.condition]
	local monsterCO = MonsterConfig.instance:getMonsterCO(conditionCO.monsterIds[1])

	return string.format(desPattern, monsterCO.name)
end
kLoseConditionDescriptionParsers[6] = function(self, conditionCO)
	local desPattern = kLoseConditionPatterns[conditionCO.condition]

	return string.format(desPattern, conditionCO.count)
end
kLoseConditionDescriptionParsers[7] = function(self, conditionCO)
	local monsterCO = MonsterConfig.instance:getMonsterCO(conditionCO.monsterIds[1])
	local desPattern = kLoseConditionPatterns[conditionCO.condition]

	return string.format(desPattern, monsterCO.name)
end
kLoseConditionDataParsers[2] = function(self, conditionCO, tag)
	if not self._tag2ProtectEntityCodes[tag] then
		self._tag2ProtectEntityCodes[tag] = {}
	end

	table.insert(self._tag2ProtectEntityCodes[tag], conditionCO.targetId)
	table.insert(self._protectEntityCodes, conditionCO.targetId)
end
kLoseConditionDataParsers[4] = function(self, conditionCO, tag)
	self._tag2EscapePoint[tag] = true
end
kLoseConditionDataParsers[5] = function(self, conditionCO, tag)
	self._tag2EscapePoint[tag] = true
end
kLoseConditionDataParsers[6] = function(self, conditionCO, tag)
	self._tag2EscapePoint[tag] = true
end

return DungeonBattleInfoCOWrapper
