-- chunkname: @modules/logic/fight/system/work/asfd/FightWorkASFDTryPlayYXTimeline.lua

module("modules.logic.fight.system.work.asfd.FightWorkASFDTryPlayYXTimeline", package.seeall)

local FightWorkASFDTryPlayYXTimeline = class("FightWorkASFDTryPlayYXTimeline", BaseWork)

function FightWorkASFDTryPlayYXTimeline:ctor(fightStepData)
	self.fightStepData = fightStepData
end

function FightWorkASFDTryPlayYXTimeline:onStart()
	local actEffectData = FightHelper.getActEffectData(FightEnum.EffectType.EMITTEREXTRADEMAGE, self.fightStepData)

	if not actEffectData then
		return self:onDone(true)
	end

	local damageBuffUid = actEffectData.effectNum
	local entityId = self.getDamageFromUidAndTargetUid(self.fightStepData, damageBuffUid)
	local entity = entityId and FightHelper.getEntity(entityId)

	if not entity then
		logError("FightWorkASFDTryPlayYXTimeline not found entityId : " .. tostring(entityId))

		return self:onDone(true)
	end

	local entityMo = entity:getMO()
	local skin = entityMo and entityMo.skin
	local co = skin and lua_fight_yaxian_timeline.configDict[skin]

	co = co or lua_fight_yaxian_timeline.configDict[0]
	self.timelineName = co.timeline

	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self.onSkillEnd, self)
	entity.skill:playTimeline(self.timelineName, self.fightStepData)
end

function FightWorkASFDTryPlayYXTimeline:onSkillEnd(entity, actId, fightStepData, timelineName)
	if timelineName ~= self.timelineName then
		return
	end

	self:onDone(true)
end

function FightWorkASFDTryPlayYXTimeline.getDamageFromUidAndTargetUid(fightStepData, damageBuffUid)
	if not fightStepData then
		return
	end

	local uid, targetUid

	for i, actEffectData in ipairs(fightStepData.actEffect) do
		local effectType = actEffectData.effectType

		if effectType == FightEnum.EffectType.FIGHTSTEP then
			uid, targetUid = FightWorkASFDTryPlayYXTimeline.getDamageFromUidAndTargetUid(actEffectData.fightStep, damageBuffUid)
		elseif effectType == FightEnum.EffectType.ORIGINDAMAGE then
			local hurtInfo = actEffectData.hurtInfo

			if hurtInfo and hurtInfo.buffUid == damageBuffUid then
				uid = hurtInfo.fromUid
				targetUid = actEffectData.targetId
			end
		end

		if uid then
			return uid, targetUid
		end
	end
end

function FightWorkASFDTryPlayYXTimeline:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self.onSkillEnd, self)
end

return FightWorkASFDTryPlayYXTimeline
