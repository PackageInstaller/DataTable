-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/base/ArcadeSkillBase.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.base.ArcadeSkillBase", package.seeall)

local ArcadeSkillBase = class("ArcadeSkillBase", ArcadeSkillClass)

function ArcadeSkillBase:ctor(skillId)
	ArcadeSkillBase.super.ctor(self)

	self.skillId = skillId
	self._triggerBaseList = {}
	self._skillBase = self
	self.isActive = true

	self:tryCallFunc(self.onCtor)
end

function ArcadeSkillBase:trigger(triggerPoint, context, ignoreTriggerPoint)
	self:tryCallFunc(self.onTrigger, {
		triggerPoint = triggerPoint,
		context = context,
		ignoreTriggerPoint = ignoreTriggerPoint
	})
end

function ArcadeSkillBase:addTriggerBase(triggerBase)
	if not triggerBase then
		return
	end

	table.insert(self._triggerBaseList, triggerBase)
	triggerBase:setSkillBase(self)
	triggerBase:setOwner(self.ownerEntityType, self.ownerUid)
	triggerBase:setSpecBelongSkillSetMO(self._specBelongSkillSetMO)
end

function ArcadeSkillBase:setIsActive(isActive)
	self.isActive = not not isActive
end

function ArcadeSkillBase:setSkillBase(skillBase)
	return
end

function ArcadeSkillBase:setOwner(ownerEntityType, ownerUid)
	ArcadeSkillBase.super.setOwner(self, ownerEntityType, ownerUid)

	for _, triggerBase in ipairs(self._triggerBaseList) do
		triggerBase:setOwner(ownerEntityType, ownerUid)
	end
end

function ArcadeSkillBase:setSpecBelongSkillSetMO(skillSetMO)
	ArcadeSkillBase.super.setSpecBelongSkillSetMO(self, skillSetMO)

	for _, triggerBase in ipairs(self._triggerBaseList) do
		triggerBase:setSpecBelongSkillSetMO(skillSetMO)
	end
end

function ArcadeSkillBase:onCtor()
	return
end

function ArcadeSkillBase:onTrigger()
	return
end

function ArcadeSkillBase:getSkillConfig()
	return self.skillConfig
end

function ArcadeSkillBase:getSkillId()
	return self.skillId
end

function ArcadeSkillBase:getTriggerList()
	return self._triggerBaseList
end

function ArcadeSkillBase:getIsActive()
	return self.isActive
end

function ArcadeSkillBase:getSkillNeedCounter2ParamsDict()
	local result = {}

	for _, triggerBase in ipairs(self._triggerBaseList) do
		local condList = triggerBase:getCondBaseList()

		if condList then
			for _, cond in ipairs(condList) do
				local needCounterName, param = cond:getCondNeedCounter()

				if needCounterName then
					result[needCounterName] = {
						param
					}
				end
			end
		end
	end

	return result
end

return ArcadeSkillBase
