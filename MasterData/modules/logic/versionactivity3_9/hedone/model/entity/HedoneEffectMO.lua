-- chunkname: @modules/logic/versionactivity3_9/hedone/model/entity/HedoneEffectMO.lua

module("modules.logic.versionactivity3_9.hedone.model.entity.HedoneEffectMO", package.seeall)

local HedoneEffectMO = class("HedoneEffectMO", HedoneBaseUnitMO)

function HedoneEffectMO:onCtor(data)
	self._skillUid = data.skillUid
	self._triggerIndex = data.triggerIndex
	self._context = data.context

	local id = self:getId()

	self._lifeRule = HedoneConfig.instance:getHedoneEffectLifeRule(id)
	self._baseLifeParam = HedoneConfig.instance:getHedoneEffectLifeParam(id)

	local effectGroup = HedoneConfig.instance:getHedoneEffectGroup(id)

	if self._context then
		local durationAttr = self._context and self._context:getAttrValue(HedoneGameEnum.Attribute.EffectDuration, effectGroup) or 0

		self._lifeParam = self._baseLifeParam + durationAttr
		self._hitInterval = HedoneConfig.instance:getHedoneEffectTriggerInterval(id)

		local isDetached = HedoneConfig.instance:getHedoneEffectIsDetachedEff(id)

		if isDetached and self._context then
			self._context.targetUid = self:getUid()
		end

		self._hitCount = 0
		self._startTime = Time.time
		self._lastHitTime = self._startTime
	end
end

function HedoneEffectMO:addHitRecord(nowTime)
	self._lastHitTime = nowTime
	self._hitCount = self._hitCount + 1
end

function HedoneEffectMO:getIsAlive(nowTime)
	local result = false

	if self._lifeRule == HedoneGameEnum.EffectLifeRule.Timed then
		nowTime = nowTime or Time.time

		local existTime = nowTime - self._startTime

		result = existTime < self._lifeParam
	elseif self._lifeRule == HedoneGameEnum.EffectLifeRule.CountBased then
		result = self._hitCount < self._lifeParam
	end

	return result
end

function HedoneEffectMO:getSkillUid()
	return self._skillUid
end

function HedoneEffectMO:getTriggerIndex()
	return self._triggerIndex
end

function HedoneEffectMO:getHitContext()
	return self._context
end

function HedoneEffectMO:getIsCanHit(nowTime)
	nowTime = nowTime or Time.time

	local isAlive = self:getIsAlive(nowTime)

	if not isAlive then
		return
	end

	if not self._lastHitTime or nowTime - self._lastHitTime >= self._hitInterval then
		return true
	end
end

function HedoneEffectMO:getScaleFactor()
	local id = self:getId()
	local context = self:getHitContext()

	return HedoneGameHelper.getEffectScaleFactor(id, context and context.skillCaster)
end

return HedoneEffectMO
