-- chunkname: @modules/logic/versionactivity3_9/hedone/controller/HedoneTriggerMgr.lua

module("modules.logic.versionactivity3_9.hedone.controller.HedoneTriggerMgr", package.seeall)

local HedoneTriggerMgr = class("HedoneTriggerMgr", BaseController)

function HedoneTriggerMgr:onInit()
	return
end

function HedoneTriggerMgr:onInitFinish()
	return
end

function HedoneTriggerMgr:addConstEvents()
	return
end

function HedoneTriggerMgr:reInit()
	return
end

function HedoneTriggerMgr:onEnterGame()
	self._triggerLastSec = 0
	self._triggerCount = 0
	self._triggerErrorLogged = false
end

function HedoneTriggerMgr:onUpdate(deltaTime, nowTime)
	local effectUidList = HedoneGameModel.instance:getEntityTypeUidList(HedoneGameEnum.EntityType.Effect)

	if effectUidList then
		if not #effectUidList then
			local count = 0

			if count <= 0 then
				return
			end

			for i = 1, count do
				self:_updateEffectUnit(effectUidList[i], nowTime)
			end
		end
	end
end

function HedoneTriggerMgr:_updateEffectUnit(effectUid, nowTime)
	local effectMO = HedoneGameModel.instance:getEntityMO(effectUid)

	if not effectMO then
		return
	end

	self:_tryHitEffect(effectMO, nowTime)
	self:_tryRemoveDeadEffectEntity(effectMO)
end

function HedoneTriggerMgr:_tryHitEffect(effectMO, nowTime)
	local isCanHit = effectMO:getIsCanHit(nowTime)

	if not isCanHit then
		return
	end

	local context = effectMO:getHitContext()
	local skillCaster = context and context.skillCaster
	local isAlive = skillCaster and skillCaster:getIsAlive()

	if not isAlive then
		return
	end

	local skillUid = effectMO:getSkillUid()
	local skill = skillCaster:getSkill(skillUid)

	if skill then
		local triggerIndex = effectMO:getTriggerIndex()

		skill:triggerEffectDirectly(triggerIndex, context)
	end

	effectMO:addHitRecord(nowTime)
end

function HedoneTriggerMgr:tryCreateEffectUnit(effectId, skillUid, triggerIndex, context, posX, posY)
	local lifeRule = HedoneConfig.instance:getHedoneEffectLifeRule(effectId)
	local isDotEffect = lifeRule == HedoneGameEnum.EffectLifeRule.Timed or lifeRule == HedoneGameEnum.EffectLifeRule.CountBased

	if not context or not isDotEffect then
		return
	end

	local targetUid = context.targetUid
	local isDetached = HedoneConfig.instance:getHedoneEffectIsDetachedEff(effectId)

	if isDetached then
		if not posX or not posY then
			logError(string.format("HedoneTriggerMgr:tryCreateEffectUnit error, targetMO position is nil, effectId=%s targetUid=%s", effectId, targetUid))

			return
		end
	else
		local targetMO = HedoneGameModel.instance:getEntityMO(targetUid)
		local isAlive = targetMO and targetMO:getIsAlive()

		if not isAlive then
			return
		end
	end

	local copyContext = tabletool.copy(context)
	local effectData = {
		id = effectId,
		posX = posX,
		posY = posY,
		entityType = HedoneGameEnum.EntityType.Effect,
		skillUid = skillUid,
		triggerIndex = triggerIndex,
		context = copyContext
	}

	HedoneGameController.instance:addEntity(effectData)
end

function HedoneTriggerMgr:_tryRemoveDeadEffectEntity(effectMO)
	local isAlive = effectMO:getIsAlive()

	if isAlive then
		return
	end

	local uid = effectMO:getUid()

	HedoneGameController.instance:removeEntity(uid)
end

function HedoneTriggerMgr:tryResetTriggerCount()
	local gameTime = HedoneGameModel.instance:getGameTime()

	if self._triggerLastSec == gameTime then
		return
	end

	self._triggerLastSec = gameTime
	self._triggerCount = 0
	self._triggerErrorLogged = false
end

function HedoneTriggerMgr:trigger(triggerPoint, triggerPointParam, context)
	local skillCaster = HedoneGameModel.instance:getPlayerMO()
	local triggerPointWithParam = HedoneGameHelper.getTriggerPointWithParamKey(triggerPoint, triggerPointParam)
	local triggerSkillUidList = skillCaster and skillCaster:getTriggerSkillUidList(triggerPointWithParam)

	if not triggerSkillUidList or #triggerSkillUidList <= 0 then
		return
	end

	context = context or {}
	context.skillCaster = skillCaster

	for _, skillUid in ipairs(triggerSkillUidList) do
		self:_triggerSkill(skillUid, triggerPointWithParam, context)
	end
end

function HedoneTriggerMgr:triggerSpecifiedSkill(skillUid, triggerPoint, triggerPointParam, context, needHaveCD)
	context = context or {}
	context.skillCaster = HedoneGameModel.instance:getPlayerMO()

	local triggerPointWithParam = HedoneGameHelper.getTriggerPointWithParamKey(triggerPoint, triggerPointParam)

	self:_triggerSkill(skillUid, triggerPointWithParam, context, needHaveCD)
end

function HedoneTriggerMgr:_triggerSkill(skillUid, triggerPointWithParam, context, needHaveCD)
	local isGameEnd = HedoneGameModel.instance:getIsGameEnd()

	if isGameEnd then
		return
	end

	local skillCaster = context and context.skillCaster
	local isAlive = skillCaster and skillCaster:getIsAlive()

	if not isAlive then
		return
	end

	local skill = skillCaster:getSkill(skillUid)

	if not skill then
		return
	end

	local skillId = skill:getId()
	local skillCD = HedoneConfig.instance:getHedoneSkillCd(skillId)
	local isCDSkill = skillCD and skillCD > 0

	if not isCDSkill then
		local isOverLimit = self:_isTriggerOverLimit(skillUid, skillId)

		if isOverLimit then
			return
		end
	end

	local success = skill:tryTriggerCast(triggerPointWithParam, context, needHaveCD)

	if success then
		self._triggerCount = self._triggerCount + 1
	end
end

function HedoneTriggerMgr:_isTriggerOverLimit(skillUid, skillId)
	local gameTime = HedoneGameModel.instance:getGameTime()
	local triggerMaxCount = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.TriggerMaxCountPerSec, false, true)
	local isOverLimit = self._triggerLastSec == gameTime and triggerMaxCount <= self._triggerCount

	if isDebugBuild and isOverLimit and not self._triggerErrorLogged then
		self._triggerErrorLogged = true

		logError(string.format("HedoneTriggerMgr:_isTriggerOverLimit trigger count exceeds limit, skillUid=%d, skillId=%d, count=%d", skillUid, skillId, self._triggerCount))
	end

	return isOverLimit
end

function HedoneTriggerMgr:onExitGame()
	return
end

HedoneTriggerMgr.instance = HedoneTriggerMgr.New()

return HedoneTriggerMgr
