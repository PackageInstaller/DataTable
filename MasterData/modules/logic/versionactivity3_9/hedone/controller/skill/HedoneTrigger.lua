-- chunkname: @modules/logic/versionactivity3_9/hedone/controller/skill/HedoneTrigger.lua

module("modules.logic.versionactivity3_9.hedone.controller.skill.HedoneTrigger", package.seeall)

local HedoneTrigger = class("HedoneTrigger")

function HedoneTrigger:ctor(skillUid, skillId, index)
	self._skillUid = skillUid
	self._skillId = skillId
	self._triggerIndex = index

	local skillCfgKey = HedoneGameEnum.SkillCfgKey
	local skillCfg = HedoneConfig.instance:getHedoneSkillCfg(self._skillId, true)
	local triggerPointKey = string.format("%s%s", skillCfgKey.TriggerPoint, self._triggerIndex)
	local strTriggerPointWithParam = skillCfg and skillCfg[triggerPointKey]

	self._triggerPointWithParam = string.nilorempty(strTriggerPointWithParam) and HedoneGameEnum.TriggerPoint.None or strTriggerPointWithParam

	local probabilityKey = string.format("%s%s", skillCfgKey.Probability, self._triggerIndex)

	if skillCfg then
		self._probability = skillCfg[probabilityKey] or 0
	end

	local paramKey = string.format("%s%s", skillCfgKey.Param, self._triggerIndex)
	local skillParam = skillCfg and skillCfg[paramKey]

	self._effect = HedoneGameHelper.createEffect(self._skillId, skillParam)
end

function HedoneTrigger:tryTrigger(context)
	if not context or string.nilorempty(self._triggerPointWithParam) then
		return
	end

	local effect = self:getEffect()

	if not effect then
		return
	end

	local isHitProb = self:_isHitProbability()

	if not isHitProb then
		return
	end

	local targetX, targetY
	local targetMO = HedoneGameModel.instance:getEntityMO(context.targetUid)

	if targetMO then
		targetX, targetY = targetMO:getPosition()
	end

	self:hitEffect(context)

	local effectId = effect:getId()

	HedoneTriggerMgr.instance:tryCreateEffectUnit(effectId, self._skillUid, self._triggerIndex, context, targetX, targetY)

	return true
end

function HedoneTrigger:_isHitProbability()
	if not self._probability or self._probability <= 0 then
		return true
	end

	return math.random() <= self._probability
end

function HedoneTrigger:hitEffect(context)
	local effect = self:getEffect()

	if not effect then
		return
	end

	local effectId = effect:getId()
	local hitUidList = effect:hit(context)

	if hitUidList and #hitUidList > 0 then
		local effectGroup = HedoneConfig.instance:getHedoneEffectGroup(effectId)
		local hitEffectName = HedoneConfig.instance:getHedoneEffectHitEffect(effectId)

		for _, uid in ipairs(hitUidList) do
			HedoneTriggerMgr.instance:trigger(HedoneGameEnum.TriggerPoint.AfterHitEffect, effectGroup, {
				targetUid = uid
			})
			HedoneGameController.instance:dispatchEvent(HedoneEvent.EntityPlayEffect, uid, hitEffectName)
		end

		local hitAudioId = HedoneConfig.instance:getHedoneEffectHitAudio(effectId)

		if hitAudioId and hitAudioId ~= 0 then
			AudioMgr.instance:trigger(hitAudioId)
		end
	end

	local targetUid = context.targetUid
	local targetMO = HedoneGameModel.instance:getEntityMO(targetUid)

	if not targetMO then
		return
	end

	local triggerVFX = HedoneConfig.instance:getHedoneEffectTriggerEffect(effectId)
	local duration = HedoneConfig.instance:getHedoneEffectTriggerEffectDuration(effectId)
	local x, y = targetMO:getPosition()
	local scaleFactor = HedoneGameHelper.getEffectScaleFactor(effectId, context.skillCaster)

	HedoneGameController.instance:dispatchEvent(HedoneEvent.ShowVisualEffect, targetUid, triggerVFX, duration, x, y, scaleFactor)
end

function HedoneTrigger:getEffect()
	return self._effect
end

function HedoneTrigger:getTriggerPointWithParam()
	return self._triggerPointWithParam
end

return HedoneTrigger
