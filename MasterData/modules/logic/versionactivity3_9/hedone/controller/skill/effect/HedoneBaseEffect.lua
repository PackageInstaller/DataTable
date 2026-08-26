-- chunkname: @modules/logic/versionactivity3_9/hedone/controller/skill/effect/HedoneBaseEffect.lua

module("modules.logic.versionactivity3_9.hedone.controller.skill.effect.HedoneBaseEffect", package.seeall)

local HedoneBaseEffect = class("HedoneBaseEffect")

function HedoneBaseEffect:ctor(skillId, effectId)
	self._id = effectId
	self._skillId = skillId
	self._isIgnoreSelf = HedoneConfig.instance:getHedoneEffectIgnoreSelf(self._id)
	self._baseValueMul = HedoneConfig.instance:getHedoneEffectValueMul(self._id)
	self._lastHitTime = 0

	self:onCtor()
end

function HedoneBaseEffect:hit(context)
	local isValid = self:_validateContext(context)

	if not isValid then
		return
	end

	local nowTime = Time.time
	local isReady = self:_checkHitInterval(nowTime)

	if not isReady then
		return
	end

	self._lastHitTime = nowTime

	local result, affectUidList = callWithCatch(self.onHit, self, context)

	if result then
		return affectUidList
	end
end

function HedoneBaseEffect:_checkHitInterval(nowTime)
	local minInterval = self:getMinHitInterval()

	return minInterval <= 0 or minInterval <= nowTime - self._lastHitTime
end

function HedoneBaseEffect:_validateContext(context)
	if not context then
		logError("HedoneBaseEffect:hit error, context is nil")

		return false
	end

	if not context.skillCaster then
		logError("HedoneBaseEffect:hit error, context skillCaster is nil")

		return false
	end

	return true
end

function HedoneBaseEffect:getId()
	return self._id
end

function HedoneBaseEffect:getAffectedTargetUidList(skillCaster, targetUid)
	if targetUid then
		::label_6_0::

		local targetMO = HedoneGameModel.instance:getEntityMO(targetUid)

		if not targetMO then
			return
		end

		local id = self:getId()
		local effectGroup = HedoneConfig.instance:getHedoneEffectGroup(id)
		local rangAttr = skillCaster and skillCaster:getAttrValue(HedoneGameEnum.Attribute.EffectRange, effectGroup) or 0
		local baseRange = HedoneConfig.instance:getHedoneEffectRange(id)
		local range = baseRange * (HedoneGameEnum.Const.EffectBaseFactor + rangAttr)
		local x, y = targetMO:getPosition()

		return (self:_queryRangeTargets(range, targetUid, x, y))
	end
end

local BOUNDS_BUF = {
	0,
	0,
	0,
	0
}

function HedoneBaseEffect:_queryRangeTargets(range, targetUid, cx, cy)
	local uidList = HedoneGameModel.instance:getEntityTypeUidList(HedoneGameEnum.EntityType.Monster)

	if range < 0 or not uidList then
		return
	end

	local result = {}
	local half = range * 0.5

	BOUNDS_BUF[1] = cx - half
	BOUNDS_BUF[2] = cx + half
	BOUNDS_BUF[3] = cy - half
	BOUNDS_BUF[4] = cy + half

	local uidCount = #uidList

	for i = 1, uidCount do
		local uid = uidList[i]

		if not self._isIgnoreSelf or uid ~= targetUid then
			local isInRange = self:_checkUnitInRange(uid, BOUNDS_BUF)

			if isInRange then
				result[#result + 1] = uid
			end
		end
	end

	return result
end

function HedoneBaseEffect:_checkUnitInRange(uid, bounds)
	local mo = HedoneGameModel.instance:getEntityMO(uid)

	if not mo then
		return false
	end

	local mx, my = mo:getPosition()

	return mx >= bounds[1] and mx <= bounds[2] and my >= bounds[3] and my <= bounds[4]
end

function HedoneBaseEffect:getEffectValMul(skillCaster)
	local effectId = self:getId()
	local effectGroup = HedoneConfig.instance:getHedoneEffectGroup(effectId)
	local effectValAttr = skillCaster and skillCaster:getAttrValue(HedoneGameEnum.Attribute.EffectValue, effectGroup) or 0

	return self._baseValueMul * (HedoneGameEnum.Const.EffectBaseFactor + effectValAttr)
end

function HedoneBaseEffect:onCtor()
	return
end

function HedoneBaseEffect:onHit(context)
	return
end

function HedoneBaseEffect:getMinHitInterval()
	return 0
end

return HedoneBaseEffect
