-- chunkname: @modules/logic/fight/system/work/FightWorkTriggerStress.lua

module("modules.logic.fight.system.work.FightWorkTriggerStress", package.seeall)

local FightWorkTriggerStress = class("FightWorkTriggerStress", FightEffectBase)

function FightWorkTriggerStress:onStart()
	local targetId = self.actEffectData.targetId
	local entityMo = FightDataHelper.entityMgr:getById(targetId)

	if not entityMo then
		return self:onDone(true)
	end

	local behavior = self.actEffectData.effectNum
	local constId = FightEnum.StressBehaviourConstId[behavior]
	local constCo = constId and lua_stress_const.configDict[constId]

	if not constCo then
		return self:onDone(true)
	end

	if self:checkNeedWaitTimeLineHandle(self.actEffectData) then
		FightModel.instance:recordDelayHandleStressBehaviour(self.actEffectData)
	else
		local type = tonumber(constCo.value)
		local content = constCo.value2

		FightFloatMgr.instance:float(targetId, FightEnum.FloatType.stress, content, type, false)
		FightController.instance:dispatchEvent(FightEvent.TriggerStressBehaviour, targetId, behavior)
	end

	return self:onDone(true)
end

function FightWorkTriggerStress:checkNeedWaitTimeLineHandle(actEffectData)
	local configEffect = actEffectData.configEffect
	local stressRule = configEffect and lua_stress_rule.configDict[configEffect]

	return stressRule and stressRule.type == "triggerSkill"
end

return FightWorkTriggerStress
