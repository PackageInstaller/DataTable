-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/property/BattleUnitCompProperty.lua

module("logic.battle.unit.comp.property.BattleUnitCompProperty", package.seeall)

local BattleUnitCompProperty = class("BattleUnitCompProperty", BattleUnitCompBase)

function BattleUnitCompProperty:onInit()
	self:_clearAllState()

	self._entityId = false
	self._entityType = false
	self._userId = false
	self._campId = false
	self._battleCamp = false
	self._level = false
	self._modelCode = false
	self._flagMask = 0
	self._viewEntityCode = 0
	self._entityCOAdapter = BattleEntityCOAdapter.New()
	self._baseAttributeFields = {}
	self._attributeFields = {}
	self._states = {}
	self._stateMOs = {}
	self._tags = {}
	self._bakStateCodes = {}
	self._sourceUnit = false
	self._ForecastUnit = false
	self._transportForecastUnit = false
	self._runAudioName = false
	self._dieAudioName = false
	self._reactAudioName = false
	self._hitAudioName = false
	self._isModelFuzzy = false
	self._immuneBuffs = {}
	self._isDeadPeformLost = false
	self._bodyEffect = false
end

function BattleUnitCompProperty:onReset()
	self:onInit()
end

function BattleUnitCompProperty:onDestroy()
	self:onInit()
end

function BattleUnitCompProperty:getBaseAttribute(attributeCode)
	return self._baseAttributeFields[attributeCode] or self:getAttribute(attributeCode)
end

function BattleUnitCompProperty:setBaseAttribute(attributeCode, value)
	self._baseAttributeFields[attributeCode] = value
end

function BattleUnitCompProperty:setAttribute(attributeCode, value)
	self._attributeFields[attributeCode] = value
end

function BattleUnitCompProperty:getAttribute(attributeCode)
	return self._attributeFields[attributeCode] or false
end

function BattleUnitCompProperty:hasAttribute(attributeCode)
	return self._attributeFields[attributeCode] and true or false
end

function BattleUnitCompProperty:activeState(stateName, key)
	local booleanStateValue = self._states[stateName]

	if not booleanStateValue then
		booleanStateValue = BattleBooleanStateValue:createInstance()
		self._states[stateName] = booleanStateValue
	end

	booleanStateValue:activeState(key or BattleConst.DefaultStateKey)
end

function BattleUnitCompProperty:inactiveState(stateName, key)
	local booleanStateValue = self._states[stateName]

	if not booleanStateValue then
		return
	end

	booleanStateValue:inactiveState(key or BattleConst.DefaultStateKey)
end

function BattleUnitCompProperty:isStateActive(stateName)
	local booleanStateValue = self._states[stateName]

	return booleanStateValue and booleanStateValue:isActive() or false
end

function BattleUnitCompProperty:setStateMO(stateName, stateMO)
	self:clearStateMO(stateName)

	self._stateMOs[stateName] = stateMO
end

function BattleUnitCompProperty:clearStateMO(stateName)
	local stateMO = self:getStateMO(stateName)

	if stateMO then
		stateMO:returnSelf()
	end

	self._stateMOs[stateName] = nil
end

function BattleUnitCompProperty:getStateMO(stateName)
	return self._stateMOs[stateName] or false
end

function BattleUnitCompProperty:setEntityId(entityId)
	self._entityId = entityId
end

function BattleUnitCompProperty:getEntityId()
	return self._entityId
end

function BattleUnitCompProperty:setEntityType(entityType)
	self._entityType = entityType
end

function BattleUnitCompProperty:getEntityType()
	return self._entityType
end

function BattleUnitCompProperty:isNpc()
	return self._entityType == BattleEnum.EntityType.Npc
end

function BattleUnitCompProperty:isSkipStep()
	return self._entityCOAdapter:isSkipStep()
end

function BattleUnitCompProperty:setEntityCode(entityCode)
	self._entityCOAdapter:bindEntityCode(entityCode, self._entityType)

	self._colorType = self._entityCOAdapter:getColorType()
	self._career = self._entityCOAdapter:getCareer()
	self._faction = self._entityCOAdapter:getFaction()

	if not self._modelCode or not (self._modelCode > 0) then
		self._modelCode = self._entityCOAdapter:getModelCode()
	end

	self._monsterType = self._entityCOAdapter:getMonsterType()
	self._isModelFuzzy = self._entityCOAdapter:isModelFuzzy()

	self:_initAudio()
end

function BattleUnitCompProperty:isModelFuzzy()
	return self._isModelFuzzy
end

function BattleUnitCompProperty:setModelCode(modelCode)
	self._modelCode = modelCode
end

function BattleUnitCompProperty:setViewEntityCode(viewEntityCode)
	self._viewEntityCode = viewEntityCode
end

function BattleUnitCompProperty:setUserId(userId)
	self._userId = userId
end

function BattleUnitCompProperty:getUserId()
	return self._userId
end

function BattleUnitCompProperty:setCampId(campId)
	self._campId = campId
end

function BattleUnitCompProperty:getCampId()
	return self._campId
end

function BattleUnitCompProperty:setBattleCamp(battleCamp)
	self._battleCamp = battleCamp
end

function BattleUnitCompProperty:getBattleCamp()
	return self._battleCamp
end

function BattleUnitCompProperty:getEntityCode()
	return self._entityCOAdapter:getEntityCode()
end

function BattleUnitCompProperty:getViewEntityCode()
	return self._viewEntityCode
end

function BattleUnitCompProperty:getName()
	return self._entityCOAdapter:getName()
end

function BattleUnitCompProperty:getModelCode()
	return self._modelCode or 0
end

function BattleUnitCompProperty:getCareer()
	return self._career
end

function BattleUnitCompProperty:getColorType()
	return self._colorType
end

function BattleUnitCompProperty:getFaction()
	return self._faction
end

function BattleUnitCompProperty:getMonsterType()
	return self._monsterType
end

function BattleUnitCompProperty:setCareer(career)
	self._career = career
end

function BattleUnitCompProperty:setColorType(colorType)
	self._colorType = colorType
end

function BattleUnitCompProperty:setFaction(faction)
	self._faction = faction
end

function BattleUnitCompProperty:setMonsterType(monsterType)
	self._monsterType = monsterType
end

function BattleUnitCompProperty:setLevel(level)
	self._level = level
end

function BattleUnitCompProperty:getLevel()
	return self._level
end

function BattleUnitCompProperty:setWeakPointHp(weakPointHp)
	self:setAttribute(BattleEnum.Attribute.CURRENT_WEAKPOINT_HP, weakPointHp)
end

function BattleUnitCompProperty:setWeakPointType(type)
	self:setAttribute(BattleEnum.Attribute.WEAKPOINT_TYPE, type)
end

function BattleUnitCompProperty:getWeakPointHp()
	return self:getAttribute(BattleEnum.Attribute.CURRENT_WEAKPOINT_HP)
end

function BattleUnitCompProperty:getWeakPointMaxHp()
	return self:getAttribute(BattleEnum.Attribute.MAX_WEAKPOINT_HP)
end

function BattleUnitCompProperty:getWeakPointType()
	return self:getAttribute(BattleEnum.Attribute.WEAKPOINT_TYPE) or false
end

function BattleUnitCompProperty:isWeakPointBroken()
	return self:isShowWeakPoint() and not self:isStateActive(BattleEnum.State.HAS_WEAK_POINT)
end

function BattleUnitCompProperty:getHp()
	return self:getAttribute(BattleExtension_pb.Attribute.CURRENT_HP)
end

function BattleUnitCompProperty:getMaxHp()
	return self:getAttribute(BattleExtension_pb.Attribute.MAX_HP)
end

function BattleUnitCompProperty:isShowWeakPoint()
	local type = self:getWeakPointType()

	return type and type == 1 and true or false
end

function BattleUnitCompProperty:setSanity(sanity)
	self:setAttribute(BattleExtension_pb.Attribute.CURRENT_SAN, sanity)
end

function BattleUnitCompProperty:getSanity()
	return self:getAttribute(BattleExtension_pb.Attribute.CURRENT_SAN)
end

function BattleUnitCompProperty:setFlagMask(flagMask)
	self._flagMask = flagMask
end

function BattleUnitCompProperty:isMaskEnable(flagMask)
	return BattleUnitFlagMask.checkMaskEnable(self._flagMask, flagMask)
end

function BattleUnitCompProperty:isFlagEnable(flag)
	return BattleUnitFlagMask.checkFlagEnable(self._flagMask, flag)
end

function BattleUnitCompProperty:checkStateOperatable()
	local result = BattleUnitUtil.isDisableMove(self._unit) and self:isStateActive(BattleEnum.State.CANNOT_NORMAL_ATTACK) and self:isStateActive(BattleEnum.State.SILENT)

	return not result
end

function BattleUnitCompProperty:internal_deltaHp(deltaValue)
	local hp = math.min(self:getMaxHp(), math.max(0, self:getHp() + deltaValue))

	self:setAttribute(BattleExtension_pb.Attribute.CURRENT_HP, hp)
end

function BattleUnitCompProperty:internal_deltaWeakPointHp(deltaValue)
	if self:isShowWeakPoint() then
		local hp = math.max(0, self:getWeakPointHp() + deltaValue)

		self:setWeakPointHp(hp)
	end
end

function BattleUnitCompProperty:addTag(tag)
	table.insert(self._tags, tag)
end

function BattleUnitCompProperty:containsTag(tag)
	for _, tTag in pairs(self._tags) do
		if tTag == tag then
			return true
		end
	end

	return false
end

function BattleUnitCompProperty:toBriefString()
	return string.format("entityId=%s,name=%s,campId=%s", self:getEntityId(), self:getName(), self:getCampId())
end

function BattleUnitCompProperty:_clearAllState()
	if self._states then
		BattleTableUtil.clearReusableTable(self._states)
	end
end

function BattleUnitCompProperty:clearAllState()
	self:_clearAllState()
end

function BattleUnitCompProperty:setCurPerformanceHp(hp)
	self._performanceHp = hp
end

function BattleUnitCompProperty:getCurPerformanceHp()
	return self._performanceHp or 0
end

function BattleUnitCompProperty:forecast(entityInfo)
	self:_recordProperties()

	if not BattleUnitUtil.isUnitNotMoved(self._unit) then
		self:_clearServerState()
	end

	self:_applyEntityInfo(entityInfo)
end

function BattleUnitCompProperty:clearForecast()
	self:_clearServerState()

	for _, state in pairs(self._bakStateCodes) do
		self:activeState(state)
	end

	BattleTableUtil.clearTable(self._bakStateCodes)
end

function BattleUnitCompProperty:_recordProperties()
	for stateCode, booleanStateValue in pairs(self._states) do
		if stateCode >= 0 and booleanStateValue:isActive() then
			table.insert(self._bakStateCodes, stateCode)
		end
	end
end

function BattleUnitCompProperty:_clearServerState()
	for stateCode, booleanStateValue in pairs(self._states) do
		if stateCode >= 0 then
			self:inactiveState(stateCode)
		end
	end
end

function BattleUnitCompProperty:_applyEntityInfo(entityInfo)
	local states = entityInfo.states

	for _, stateCode in ipairs(states) do
		self:activeState(stateCode)
	end
end

function BattleUnitCompProperty:setSourceUnit(unit)
	self._sourceUnit = unit
end

function BattleUnitCompProperty:getSourceUnit()
	return self._sourceUnit
end

function BattleUnitCompProperty:setForecastUnit(unit)
	self._ForecastUnit = unit
end

function BattleUnitCompProperty:getForecastUnit()
	return self._ForecastUnit
end

function BattleUnitCompProperty:setTransportForecastUnit(unit)
	self._transportForecastUnit = unit
end

function BattleUnitCompProperty:getTransportForecastUnit()
	return self._transportForecastUnit
end

function BattleUnitCompProperty:_initAudio()
	self._runAudioName = string.format("skill_%d_run", self:getModelCode())
	self._dieAudioName = string.format("skill_%d_die", self:getModelCode())
	self._reactAudioName = string.format("skill_%d_react", self:getModelCode())
	self._hitAudioName = string.format("skill_%d_hit1", self:getModelCode())
end

function BattleUnitCompProperty:getDeathAudio()
	return self._dieAudioName
end

function BattleUnitCompProperty:getRunAudio()
	return self._runAudioName
end

function BattleUnitCompProperty:getReactAudio()
	return self._reactAudioName
end

function BattleUnitCompProperty:getHitAudio()
	return self._hitAudioName
end

function BattleUnitCompProperty:setRunAudio(name)
	self._runAudioName = name
end

function BattleUnitCompProperty:getDeadPerformLost(name)
	return self._isDeadPeformLost
end

function BattleUnitCompProperty:setDeadPerformLost(status)
	self._isDeadPeformLost = status
end

function BattleUnitCompProperty:setBodyEffect(effect)
	self._bodyEffect = effect
end

function BattleUnitCompProperty:getBodyEffect()
	return self._bodyEffect
end

function BattleUnitCompProperty:onHeroInfoUpdate(entityInfo)
	self:setLevel(entityInfo.level)

	local attributes = entityInfo.attributes

	for attributeCode, attributeValue in pairs(attributes) do
		self:setAttribute(attributeCode, attributeValue)
	end

	local baseAttributes = entityInfo.baseAttributes

	for attributeCode, attributeValue in pairs(baseAttributes) do
		self:setBaseAttribute(attributeCode, attributeValue)
	end
end

function BattleUnitCompProperty:addImmuneBuff(buffCode)
	self._immuneBuffs[buffCode] = true
end

function BattleUnitCompProperty:removeImmuneBuff(buffCode)
	self._immuneBuffs[buffCode] = nil
end

function BattleUnitCompProperty:isImmuneBuff(buffCode)
	return self._immuneBuffs[buffCode]
end

return BattleUnitCompProperty
