-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/attackpoint/DamageSkillAttackPointHandler.lua

module("logic.battle.skill.attackpoint.DamageSkillAttackPointHandler", package.seeall)

local DamageSkillAttackPointHandler = class("DamageSkillAttackPointHandler", AbstractGlobalReusable, ISkillAttackPointHandler)
local kTempVec3 = Vector3.New()

function DamageSkillAttackPointHandler:parseEventNO(damagedEventNO)
	local handler = DamageSkillAttackPointHandler:createInstance()

	handler:setEntityId(damagedEventNO.entity)
	handler:setCritical(damagedEventNO.critical)
	handler:setImmunized(damagedEventNO.immunized)
	handler:setDamage(damagedEventNO.hpDecrementOverflow)
	handler:setHpDecrement(damagedEventNO.hpDecrement)
	handler:setWeakPointDamage(damagedEventNO.weakPointDamage)

	return handler
end

function DamageSkillAttackPointHandler:ctor()
	self._damageDivider = SkillValueDivider.New()
	self._weakPointDamgeDivider = SkillValueDivider.New()
	self._stageDamageList = {}

	self:reset()
end

function DamageSkillAttackPointHandler:reuse(...)
	return
end

function DamageSkillAttackPointHandler:reset()
	self._entityId = false
	self._isCritical = false
	self._isImmunized = false
	self._damage = 0
	self._hpDecrement = 0
	self._weakPointDamge = 0
	self._pointIndex = 0
	self._isMultiStage = false

	BattleTableUtil.clearTable(self._stageDamageList)

	self._stageDamageList = {}

	self._damageDivider:clear()
	self._weakPointDamgeDivider:clear()
end

function DamageSkillAttackPointHandler:destroy()
	self:reset()
end

function DamageSkillAttackPointHandler:build(context)
	BattleDispatcher:dispatchEvent(BattleEventType.DamageCountUpdate, self._entityId, self._hpDecrement)

	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._entityId)
	local damage = unit and unit.property:getHp() > self._hpDecrement and self._hpDecrement or self._damage
	local totalWeight = context:getParam(SkillAttackPointContext.TotalWeight)

	self._damageDivider:setOriginalValueAndWeight(damage, totalWeight)
	self._weakPointDamgeDivider:setOriginalValueAndWeight(self._weakPointDamge, totalWeight)
end

function DamageSkillAttackPointHandler:clear(context)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		return
	end

	local modelCode = unit.property:getModelCode()
	local hitEffectCode = EntityHitEffectConfig.instance:getHitEffectCode(modelCode)

	if hitEffectCode then
		unit.effectPlayer:stopEffect(hitEffectCode)
	end
end

function DamageSkillAttackPointHandler:handleAttackPoint(context, weight, amplitude)
	AttackPointShakeUtil.shake(amplitude)

	self._pointIndex = self._pointIndex + 1

	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("Cannot find unit[%s]", self._entityId))
		end

		return
	end

	if weight <= 0 then
		return
	end

	local damage = self._damageDivider:genNextValue(weight)

	if self._isMultiStage then
		damage = self:getStageDamage(self._pointIndex)
	end

	unit.property:internal_deltaHp(-damage)
	unit.property:internal_deltaWeakPointHp(-self._weakPointDamgeDivider:genNextValue(weight))

	local pointTimeList = context:getPointTimeList()

	if self._pointIndex < #pointTimeList then
		local pointTime = pointTimeList[self._pointIndex]
		local nextPointTime = pointTimeList[self._pointIndex + 1]

		if nextPointTime - pointTime > 0.5 then
			unit.property:setCurPerformanceHp(unit.property:getHp())
		end
	else
		unit.property:setCurPerformanceHp(unit.property:getHp())
	end

	local bubbleType = self._isCritical and BattleEnum.BubbleType.CRIT_DAMAGE or BattleEnum.BubbleType.NORMAL_DAMAGE
	local isFirstAttackPoint = self._pointIndex == 1

	if context:isSoloPerformance() then
		unit:dispatchInnerEvent(UnitActionType.BattleAttributeUpdate)

		local attackInfo = context:getAttackInfo()

		if context:isSkipPerformance() and not attackInfo:getShowNormalHitEffect() then
			unit.effectPlayer:playUniqueEffect(BattleConst.DAMAGE)
		end
	end

	local bubbleNumber = self._damageDivider:getCurTotalValue()

	if self._isMultiStage then
		bubbleNumber = self:getStageDamage(self._pointIndex)
	end

	local isFlag = context:isSoloPerformance() or context:isSkipPerformance()

	unit.bubble:showPerformanceBubble(bubbleType, damage, false, isFirstAttackPoint, isFlag)

	if unit.property:getBattleCamp() == BattleEnum.CampRelation.ENEMY then
		BattleDamageHintFacade.instance:showHint(damage)
	end

	local modelCode = unit.property:getModelCode()
	local hitEffectCode = EntityHitEffectConfig.instance:getHitEffectCode(modelCode)

	if not context:isSoloPerformance() and hitEffectCode then
		unit.effectPlayer:playOverrideEffect(hitEffectCode)
	end
end

function DamageSkillAttackPointHandler:handleLastAttackPoint(context)
	local deadEntityIds = context:getDeadEntityIds()

	if table.indexof(deadEntityIds, self._entityId) then
		local deadType = context:getParam(SkillAttackPointContext.DeadType)
		local unitMgr = BattleMgr.instance:getUnitMgr()
		local unit = unitMgr:getUnit(self._entityId)

		unit.property:activeState(BattleEnum.State.DEAD)
		BattleAudioUtil.playVoice(unit, BattleAudioUtil.VoiceEnum.speech_death)

		local isAutoRemove = context:isSoloPerformance()

		if isAutoRemove then
			unit.meshModel:setManualUpdateEnable(false)
			unit.property:activeState(BattleEnum.State.DEAD_PERFORMANCED)
			BattleUnitDieUtil.handleDie(unit, deadType)
		elseif deadType == BattleEnum.PerformanceDeadType.Animation then
			local deathAnimation = unit.meshModelMover:getMappedAnimation(UnitAnimState.Death)

			if unit.meshModel:containsAnimation(deathAnimation) then
				unit.meshModel:setManualUpdateEnable(false)
				BattleUnitDieUtil.playDeathAnimation(unit, true)
			end
		else
			unit.meshModel:exchangeActivePlayable()
			unit.meshModel:setManualUpdateEnable(false)
			unit.meshModel:setFrozen(true)
		end
	end
end

function DamageSkillAttackPointHandler:toString()
	return string.format("[damage skill handler entityId = %s,hpDecrement = %s, damage = %s,weakPointDamage = %s,isCritical = %s,isImmunized = %s]", self._entityId, self._hpDecrement, self._damage, tostring(self._weakPointDamge), tostring(self._isCritical), tostring(self._isImmunized))
end

function DamageSkillAttackPointHandler:collectEntityIds(entityIdList)
	table.insert(entityIdList, self._entityId)
end

function DamageSkillAttackPointHandler:setEntityId(entityId)
	self._entityId = entityId
end

function DamageSkillAttackPointHandler:setCritical(isCritical)
	self._isCritical = isCritical

	return self
end

function DamageSkillAttackPointHandler:setImmunized(isImmunized)
	self._isImmunized = isImmunized

	return self
end

function DamageSkillAttackPointHandler:setDamage(damage)
	self._damage = damage

	return self
end

function DamageSkillAttackPointHandler:setHpDecrement(hpDecrement)
	self._hpDecrement = hpDecrement

	return self
end

function DamageSkillAttackPointHandler:setWeakPointDamage(weakPointDamage)
	self._weakPointDamge = weakPointDamage

	return self
end

function DamageSkillAttackPointHandler:getDamage()
	return self._damage
end

function DamageSkillAttackPointHandler:getEnitityId()
	return self._entityId
end

function DamageSkillAttackPointHandler:getHpDecrement()
	return self._hpDecrement
end

function DamageSkillAttackPointHandler:getWeakPointDamage()
	return self._weakPointDamge
end

function DamageSkillAttackPointHandler:getHpDecrement()
	return self._hpDecrement
end

function DamageSkillAttackPointHandler:setMultiStageStatus(status)
	self._isMultiStage = status
end

function DamageSkillAttackPointHandler:addStageDamage(damage)
	table.insert(self._stageDamageList, damage)
end

function DamageSkillAttackPointHandler:getStageDamage(stage)
	if stage > #self._stageDamageList then
		return false
	end

	return self._stageDamageList[stage]
end

return DamageSkillAttackPointHandler
