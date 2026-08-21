-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/property/BattleEntityCOAdapter.lua

module("logic.battle.unit.comp.property.BattleEntityCOAdapter", package.seeall)

local BattleEntityCOAdapter = class("BattleEntityCOAdapter")

function BattleEntityCOAdapter:getSharedEntityCOAdapter(entityCode, entityType)
	local sharedCO = BattleEntityCOAdapter.shared

	sharedCO:bindEntityCode(entityCode, entityType)

	return sharedCO
end

function BattleEntityCOAdapter:ctor()
	self._entityCode = false
	self._name = false
	self._colorType = false
	self._career = false
	self._faction = false
	self._modelCode = false
	self._weakPointColor = -1
	self._maxWeakPointRate = false
	self._isFuzzy = false
	self._isSkipEntity = false
end

function BattleEntityCOAdapter:bindEntityCode(entityCode, entityType)
	self._entityCode = entityCode

	if entityType == BattleEnum.EntityType.Summon then
		self:_parseAsSummonCO(entityCode)
	elseif BattleConfigUtil.isMonsterCode(entityCode) then
		self:_parseAsMonsterCO(entityCode)
	elseif BattleConfigUtil.isAdditionalTerrainCode(entityCode) then
		self:_parseAsAdditionalTerrainCO(entityCode)
	else
		self:_parseAsCharacterCO(entityCode)
	end
end

function BattleEntityCOAdapter:getEntityCode()
	return self._entityCode
end

function BattleEntityCOAdapter:getName()
	return self._name
end

function BattleEntityCOAdapter:getModelCode()
	local heroMO = HeroDepotModel.instance:getHeroInfoByID(self._entityCode)

	if heroMO then
		local skinId = heroMO:getSkinId()
		local skinCO = HeroSkinConfig.instance:getInfo(skinId)

		if skinCO then
			return skinCO.module
		end
	end

	return self._modelCode
end

function BattleEntityCOAdapter:getColorType()
	return self._colorType
end

function BattleEntityCOAdapter:getCareer()
	return self._career
end

function BattleEntityCOAdapter:getFaction()
	return self._faction
end

function BattleEntityCOAdapter:getMonsterType()
	return self._monsterType
end

function BattleEntityCOAdapter:getWeakPointHpRate()
	return self._maxWeakPointRate
end

function BattleEntityCOAdapter:isModelFuzzy()
	return self._isFuzzy
end

function BattleEntityCOAdapter:isSkipStep()
	return self._isSkipEntity
end

function BattleEntityCOAdapter:_parseAsCharacterCO(entityCode)
	local entityCO = CharacterConfig.instance:getCfgInfoByID(entityCode)
	local characterInfoCO = PastInfoConfig.instance:getCharacterInfo(entityCode)

	self._name = characterInfoCO.name
	self._colorType = entityCO.colorType
	self._career = entityCO.career
	self._faction = entityCO.camp
	self._modelCode = entityCO.modelId
	self._monsterType = false
end

function BattleEntityCOAdapter:_parseAsSummonCO(entityCode)
	local entityCO = CharacterConfig.instance:getSummonMonsterCO(entityCode)

	self._name = entityCO.name
	self._colorType = entityCO.colorType
	self._career = entityCO.career
	self._faction = entityCO.camp
	self._modelCode = entityCO.modelId
	self._monsterType = entityCO.monsterType
	self._maxWeakPointRate = entityCO.weakPointHpRate
end

function BattleEntityCOAdapter:_parseAsMonsterCO(entityCode)
	local entityCO = MonsterConfig.instance:getMonsterCO(entityCode)

	if entityCO then
		self._name = entityCO.name
		self._colorType = entityCO.colorType
		self._career = entityCO.career
		self._faction = entityCO.camp
		self._modelCode = entityCO.modelId
		self._monsterType = entityCO.monsterType
		self._maxWeakPointRate = entityCO.weakPointHpRate
		self._isFuzzy = entityCO.isFuzzy
		self._isSkipEntity = entityCO.skipStep
	elseif enableErrorLog then
		printError("怪物不存在", entityCode)
	end
end

function BattleEntityCOAdapter:_parseAsAdditionalTerrainCO(entityCode)
	local entityCO = TerrainConfig.instance:getAdditionalTerrainCO(entityCode)

	self._name = entityCO.name
	self._colorType = false
	self._career = false
	self._faction = false
	self._modelCode = entityCode
	self._monsterType = false
end

BattleEntityCOAdapter.shared = BattleEntityCOAdapter.New()

return BattleEntityCOAdapter
