-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleDamagedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleDamagedCommand", package.seeall)

local BattleDamagedCommand = class("BattleDamagedCommand", BattleCommandBase)

function BattleDamagedCommand:parseServerCommand(cmdParser, damagedEventNO)
	local cmd = BattleDamagedCommand:createInstance()

	cmd:setAttackerEntityId(damagedEventNO.fromEntity)
	cmd:setVictimEntityId(damagedEventNO.entity)
	cmd:setSkillEntityId(damagedEventNO.skillEntity)
	cmd:setDamge(damagedEventNO.damageValue)
	cmd:setHpDecrement(damagedEventNO.hpDecrement)
	cmd:setHpDecrementOverflow(damagedEventNO.hpDecrementOverflow)
	cmd:setWeakPointDamage(damagedEventNO.weakPointDamage)
	cmd:setDamgeType(damagedEventNO.damageType)
	cmd:setCritical(damagedEventNO.critical)
	cmd:setImmunized(damagedEventNO.immunized)
	cmd:setSkillCode(damagedEventNO.skill)
	cmd:setBuffCode(damagedEventNO.buff)
	cmd:setVictimDead(self:_isEntityDeadByDamage(cmdParser, damagedEventNO.entity))
	cmdParser:addCommand(cmd)
	cmdParser:addCommand(BattleDelayCommand:create(BattleConst.DelayOne))
end

function BattleDamagedCommand:_isEntityDeadByDamage(cmdParser, entityId)
	local resultCollection = cmdParser:getParam(BattleCmdParser.Param_PerformanceResultCollection)

	return resultCollection and resultCollection:isEntityDead(entityId)
end

function BattleDamagedCommand:onInit()
	self._attackerEntityId = false
	self._victimEntityId = false
	self._skillEntityId = false
	self._isVictimDead = false
	self._damageValue = 0
	self._damageType = 0
	self._hpDecrement = 0
	self._hpDecrementOverflow = 0
	self._skillCode = 0
	self._buffCode = 0
	self._weakPointDamage = 0
	self._isCritical = false
	self._isImmunized = false
	self._timelineTask = TimelineTask.New()
	self._totalWeight = 1
	self._totalCount = 0
	self._damagedCount = 0
	self._timelineEffectUnit = false
	self._numberDivider = SkillValueDivider.New()
end

function BattleDamagedCommand:onClear()
	self._attackerEntityId = false
	self._victimEntityId = false
	self._skillEntityId = false
	self._isVictimDead = false
	self._damageValue = 0
	self._damageType = 0
	self._hpDecrement = 0
	self._hpDecrementOverflow = 0
	self._skillCode = 0
	self._buffCode = 0
	self._weakPointDamage = 0
	self._isCritical = false
	self._isImmunized = false

	self._timelineTask:clear()

	self._totalWeight = 1
	self._totalCount = 0
	self._damagedCount = 0
	self._timelineEffectUnit = false

	self._numberDivider:clear()
end

function BattleDamagedCommand:execute(battleFlow, runningContext)
	local unitMgr = battleFlow.unitMgr
	local victim = unitMgr:getUnit(self._victimEntityId)

	if not victim then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("BattleDamagedCommand::cannot find unit[%s]", self._victimEntityId))
		end

		self:finish(true)

		return
	end

	BattleDispatcher:dispatchEvent(BattleEventType.DamageCountUpdate, self._victimEntityId, self._hpDecrement)

	local skillUnit = unitMgr:getUnit(self._skillEntityId)
	local skillMO = skillUnit and skillUnit.skill:getActiveSkillById(self._skillCode)
	local isSpecialPassiveHit = skillMO and skillMO:isPassiveByPurpose() and skillMO:getAnimType() == BattleEnum.AnimStateType.HitEfectCode and not string.nilorempty(skillMO:getSpecialAttackedCode())

	self._isSpecialPassiveHit = isSpecialPassiveHit
	self._hitEffectCode = isSpecialPassiveHit and checkint(skillMO:getSpecialAttackedCode()) or self:_judgeHitEffectCode(runningContext)

	local sourceType = self:_getDamageSourceType()

	if isSpecialPassiveHit or sourceType == BattleExtension_pb.SkillSourceType.ADDITIONAL_TERRAIN then
		local damagedIndex = runningContext:getParam(BattleCmdRunningContext.Param_DamageIndex)

		if not damagedIndex or damagedIndex <= 0 then
			runningContext:setParam(BattleCmdRunningContext.Param_DamageIndex, 1)
			self:_doCameraFollow(battleFlow, runningContext)
		end

		local duaration = runningContext:getParam(BattleCmdRunningContext.Param_AdjustFollowCenterTime)

		self._timelineTask:addTask(duaration, self._playHitEffect, self)
		self._timelineTask:addTask(isSpecialPassiveHit and BattleConst.DelayTwo or BattleConst.DelayOne)
		self._timelineTask:addFinishListener(self._onTimelineTaskFinish, self)
		self._timelineTask:setTimeScale(BattleTime.timeScale)
		self._timelineTask:start(battleFlow)

		return
	end

	self:_playHitEffect()
	self:finish(true)
end

function BattleDamagedCommand:_judgeHitEffectCode(runningContext)
	local tagId = runningContext:getParam(BattleCmdRunningContext.Param_TagId)

	if tagId then
		local attackerEntityId = runningContext:getParam(BattleCmdRunningContext.Param_AttackerEntityId)
		local hitEffectCode = SkillTagUtils.getSpecialDamageEffect(attackerEntityId, tagId)

		if hitEffectCode > 0 then
			return hitEffectCode
		end
	end

	return BattleConst.DAMAGE
end

function BattleDamagedCommand:_doCameraFollow(battleFlow, runningContext)
	local cmd = BattleAdjustFollowCenterCommand:create(0, self._victimEntityId)

	cmd:execute(battleFlow, runningContext)
end

function BattleDamagedCommand:_playHitEffect()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local victim = unitMgr:getUnit(self._victimEntityId)

	if not self._isSpecialPassiveHit then
		victim.effectPlayer:playEffect(self._hitEffectCode)
		self:_playHitBubble()
	else
		local effect = victim.effectPlayer:playEffect(self._hitEffectCode, EffectTimelineUnit)

		effect.listener:setTimelineEventListener(self._playDividedHitBubble, self)

		self._timelineEffectUnit = effect
	end
end

function BattleDamagedCommand:_playHitBubble()
	self._totalCount = 1

	self._numberDivider:setOriginalValueAndWeight(self._hpDecrementOverflow, self._totalWeight)
	self:_playDividedHitBubble(BattleTimelineEventName.AttackPoint, self._totalWeight)
end

function BattleDamagedCommand:_playDividedHitBubble(eventName, weight)
	if eventName == BattleTimelineEventName.AttackPoint then
		self:_initTotalHitCountAndWeight()

		self._damagedCount = self._damagedCount + 1

		local unitMgr = BattleMgr.instance:getUnitMgr()
		local victim = unitMgr:getUnit(self._victimEntityId)

		if not victim then
			if BattleLog.enableWarn then
				BattleLog.warn(string.format("BattleDamagedCommand::cannot find unit[%s]", self._victimEntityId))
			end

			return
		end

		local bubbleType = self._isCritical and BattleEnum.BubbleType.CRIT_DAMAGE or BattleEnum.BubbleType.NORMAL_DAMAGE
		local dividedDamage = self._numberDivider:genNextValue(weight)
		local curDamage = self._numberDivider:getCurTotalValue()

		victim.bubble:showPerformanceBubble(bubbleType, curDamage, BattleConst.DelayOne, true)

		if victim.property:getBattleCamp() == BattleEnum.CampRelation.ENEMY then
			BattleDamageHintFacade.instance:showHint(dividedDamage)
		end

		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_general_hit)

		local hpCurrent = victim.property:getAttribute(BattleExtension_pb.Attribute.CURRENT_HP)
		local damagedHp = math.max(hpCurrent - dividedDamage, 0)

		victim.property:setAttribute(BattleExtension_pb.Attribute.CURRENT_HP, damagedHp)
		victim:dispatchInnerEvent(UnitActionType.BattleAttributeUpdate)

		if self._damagedCount == self._totalCount and self._isVictimDead then
			BattleAudioUtil.playVoice(victim, BattleAudioUtil.VoiceEnum.speech_death)
			victim.property:activeState(BattleEnum.State.DEAD_PERFORMANCED)
			BattleUnitDieUtil.handleDie(victim, BattleEnum.PerformanceDeadType.Animation)
		else
			victim.meshModel:playAndAutoIdleIfExists(UnitAnimState.Hit)
		end
	end
end

function BattleDamagedCommand:_initTotalHitCountAndWeight()
	if not self._timelineEffectUnit or self._totalCount ~= 0 then
		return
	end

	self._totalCount, self._totalWeight = self._timelineEffectUnit.bindings:getTotalHitCountAndWeight()

	self._numberDivider:setOriginalValueAndWeight(self._hpDecrementOverflow, self._totalWeight)
end

function BattleDamagedCommand:_onTimelineTaskFinish()
	self:finish(true)
end

function BattleDamagedCommand:_getDamageSourceType()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local skillUnit = unitMgr:getUnit(self._skillEntityId)
	local skillMO = skillUnit and skillUnit.skill:getActiveSkillById(self._skillCode)

	return skillMO and skillMO:getSourceType()
end

function BattleDamagedCommand:toString()
	return string.format("[damaged command victimEntityId = %s,attackerEntityId = %s,skillEntityId = %s, isVictimDead = %s, hpDecrement = %s, damage = %s,weakPointDamage = %s, damageType = %s,isCritical = %s,isImmunized = %s,skillCode = %s, buffCode = %s]", tostring(self._victimEntityId), tostring(self._attackerEntityId), tostring(self._skillEntityId), tostring(self._isVictimDead), self._hpDecrement, self._damageValue, self._weakPointDamage, self._damageType, tostring(self._isCritical), tostring(self._isImmunized), self._skillCode, self._buffCode)
end

function BattleDamagedCommand:setAttackerEntityId(attackerEntityId)
	self._attackerEntityId = attackerEntityId

	return self
end

function BattleDamagedCommand:setVictimEntityId(victimEntityId)
	self._victimEntityId = victimEntityId

	return self
end

function BattleDamagedCommand:setSkillEntityId(skillEntityId)
	self._skillEntityId = skillEntityId

	return self
end

function BattleDamagedCommand:setDamge(damage)
	self._damageValue = damage

	return self
end

function BattleDamagedCommand:setHpDecrement(hpDecrement)
	self._hpDecrement = hpDecrement

	return self
end

function BattleDamagedCommand:setHpDecrementOverflow(hpDecrementOverflow)
	self._hpDecrementOverflow = hpDecrementOverflow

	return self
end

function BattleDamagedCommand:setDamgeType(damageType)
	self._damageType = damageType

	return self
end

function BattleDamagedCommand:setWeakPointDamage(damage)
	self._weakPointDamage = damage

	return self
end

function BattleDamagedCommand:setCritical(isCritical)
	self._isCritical = isCritical

	return self
end

function BattleDamagedCommand:setImmunized(isImmunized)
	self._isImmunized = isImmunized

	return self
end

function BattleDamagedCommand:setSkillCode(skillCode)
	self._skillCode = skillCode

	return self
end

function BattleDamagedCommand:setBuffCode(buffCode)
	self._buffCode = buffCode

	return self
end

function BattleDamagedCommand:setVictimDead(isVictimDead)
	self._isVictimDead = isVictimDead

	return self
end

return BattleDamagedCommand
