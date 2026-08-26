-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLPlayActionByEffectType.lua

module("modules.logic.fight.entity.comp.skill.FightTLPlayActionByEffectType", package.seeall)

local FightTLPlayActionByEffectType = class("FightTLPlayActionByEffectType", FightTimelineTrackItem)

function FightTLPlayActionByEffectType:onTrackStart(fightStepData, duration, paramsArr)
	self.fightStepData = fightStepData
	self.duration = duration
	self.effectType = tonumber(paramsArr[1])
	self.actionName = paramsArr[2]
	self.playWeapon = FightTLHelper.getBoolParam(paramsArr[3])

	if not self.effectType then
		return
	end

	if string.nilorempty(self.actionName) then
		return
	end

	local actEffect = FightHelper.getActEffectData(self.effectType, fightStepData)

	if not actEffect then
		logError("未找到 effect 数据 : " .. tostring(self.effectType))

		return
	end

	local entityUid = actEffect.targetId
	local entity = entityUid and FightHelper.getEntity(entityUid)

	if not entity then
		return
	end

	self.entity = entity

	self:tryPlayAction(entity, self.actionName)
	self:tryPlayWeaponAudio()
end

function FightTLPlayActionByEffectType:tryPlayWeaponAudio()
	local audioAtkId = self.fightStepData.atkAudioId

	if not audioAtkId then
		return
	end

	if audioAtkId < 1 then
		return
	end

	local mo = self.entity:getMO()
	local skin = mo and mo.skin

	FightAudioMgr.instance:playHitByAtkAudioId(audioAtkId, skin, false)
end

function FightTLPlayActionByEffectType:tryPlayAction(entity, action)
	if string.nilorempty(action) then
		return
	end

	if not entity then
		return
	end

	if entity.buff:haveBuffId(2112031) then
		return
	end

	action = FightHelper.processEntityActionName(entity, action, self.fightStepData)

	entity.spine:play(action, false, true, true)
	entity.spine:addAnimEventCallback(self.onAnimEvent, self, {
		entity,
		action
	})
end

function FightTLPlayActionByEffectType:onAnimEvent(actionName, eventName, eventArgs, param)
	local entity = param[1]
	local action = param[2]

	if eventName == SpineAnimEvent.ActionComplete and actionName == action then
		entity.spine:removeAnimEventCallback(self.onAnimEvent, self)
		entity:resetAnimState()
	end
end

function FightTLPlayActionByEffectType:onTrackEnd()
	return
end

function FightTLPlayActionByEffectType:onDestructor()
	if self.entity then
		self.entity.spine:removeAnimEventCallback(self.onAnimEvent, self)

		self.entity = nil
	end
end

return FightTLPlayActionByEffectType
