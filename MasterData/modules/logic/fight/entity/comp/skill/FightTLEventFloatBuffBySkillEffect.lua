-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventFloatBuffBySkillEffect.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventFloatBuffBySkillEffect", package.seeall)

local FightTLEventFloatBuffBySkillEffect = class("FightTLEventFloatBuffBySkillEffect", FightTimelineTrackItem)

function FightTLEventFloatBuffBySkillEffect:onTrackStart(fightStepData, duration, paramsArr)
	self.fightStepData = fightStepData
	self.buffId = FightTLHelper.getNumberParam(paramsArr[1])

	local skillId = fightStepData.actId
	local skillCo = skillId and lua_skill.configDict[skillId]
	local skillEffectCo = skillCo and lua_skill_effect.configDict[skillCo.skillEffect]

	if not skillEffectCo then
		return
	end

	local floatBuffCount = 0

	for i = 1, FightEnum.MaxBehavior do
		local behavior = skillEffectCo["behavior" .. i]

		if string.nilorempty(behavior) then
			break
		end

		local behaviorList = FightStrUtil.instance:getSplitToNumberCache(behavior, "#")
		local skillBehaviour = lua_skill_behavior.configDict[behaviorList[1]]
		local type = skillBehaviour and skillBehaviour.type
		local getFloatBuffCountHandle = self:getHandle(type)

		if getFloatBuffCountHandle then
			floatBuffCount = getFloatBuffCountHandle(self, behaviorList)

			break
		end
	end

	if floatBuffCount < 1 then
		return
	end

	self:floatBuff(floatBuffCount)
end

function FightTLEventFloatBuffBySkillEffect:getHandle(type)
	FightTLEventFloatBuffBySkillEffect.SkillEffectHandleDict = FightTLEventFloatBuffBySkillEffect.SkillEffectHandleDict or {
		AddBuff = self.getAddBuffFloatCount
	}

	return type and FightTLEventFloatBuffBySkillEffect.SkillEffectHandleDict[type]
end

function FightTLEventFloatBuffBySkillEffect:floatBuff(floatCount)
	local addBuff = FightEnum.EffectType.BUFFADD
	local entityId = self.fightStepData.toId
	local count = 0

	for _, actEffectData in ipairs(self.fightStepData.actEffect) do
		if not actEffectData:isDone() and entityId == actEffectData.targetId and actEffectData.effectType == addBuff and actEffectData.effectNum == self.buffId then
			count = count + 1

			FightSkillBuffMgr.instance:playSkillBuff(self.fightStepData, actEffectData)
			FightDataHelper.playEffectData(actEffectData)

			if floatCount <= count then
				return
			end
		end
	end
end

function FightTLEventFloatBuffBySkillEffect:getAddBuffFloatCount(behaviorList)
	return (behaviorList or nil) and (behaviorList[3] or 1)
end

function FightTLEventFloatBuffBySkillEffect:onTrackEnd()
	return
end

function FightTLEventFloatBuffBySkillEffect:onDestructor()
	return
end

return FightTLEventFloatBuffBySkillEffect
