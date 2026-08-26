-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventStressTrigger.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventStressTrigger", package.seeall)

local FightTLEventStressTrigger = class("FightTLEventStressTrigger", FightTimelineTrackItem)

function FightTLEventStressTrigger:onTrackStart(fightStepData, duration, paramsArr)
	local entityId = fightStepData.fromId
	local stressBehaviour = FightModel.instance:popNoHandledStressBehaviour(entityId)

	if not stressBehaviour then
		logError("压力触发技能动效帧, 但是没找到触发压力的effect")

		return
	end

	local behaviorId = stressBehaviour.effectNum
	local constId = FightEnum.StressBehaviourConstId[behaviorId]
	local constCo = constId and lua_stress_const.configDict[constId]

	if not constCo then
		logError(string.format("压力行为 %s 的常量配置不存在", behaviorId))

		return
	end

	local type = tonumber(constCo.value)
	local content = constCo.value2

	FightFloatMgr.instance:float(entityId, FightEnum.FloatType.stress, content, type, false)
	FightController.instance:dispatchEvent(FightEvent.TriggerStressBehaviour, entityId, behaviorId)

	for _, actEffectData in ipairs(fightStepData.actEffect) do
		if actEffectData.effectType == FightEnum.EffectType.POWERCHANGE and actEffectData.targetId == entityId and actEffectData.configEffect == FightEnum.PowerType.Stress then
			local entityMo = FightDataHelper.entityMgr:getById(entityId)
			local powerData = entityMo and entityMo:getPowerInfo(FightEnum.PowerType.Stress)
			local oldValue = powerData and powerData.num

			FightDataHelper.playEffectData(actEffectData)

			local newValue = powerData and powerData.num

			if oldValue and newValue and oldValue ~= newValue then
				FightController.instance:dispatchEvent(FightEvent.PowerChange, entityId, FightEnum.PowerType.Stress, oldValue, newValue)
			end

			break
		end
	end
end

function FightTLEventStressTrigger:onTrackEnd()
	return
end

function FightTLEventStressTrigger:onDestructor()
	return
end

return FightTLEventStressTrigger
