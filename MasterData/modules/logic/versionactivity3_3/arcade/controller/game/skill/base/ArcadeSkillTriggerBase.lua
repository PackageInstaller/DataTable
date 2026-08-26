-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/base/ArcadeSkillTriggerBase.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.base.ArcadeSkillTriggerBase", package.seeall)

local ArcadeSkillTriggerBase = class("ArcadeSkillTriggerBase", ArcadeSkillClass)

function ArcadeSkillTriggerBase:ctor(condBaseList, hitBase, triggerPoint)
	ArcadeSkillTriggerBase.super.ctor(self)

	self._condBaseList = condBaseList
	self._hitBase = hitBase
	self._triggerPoint = triggerPoint
end

function ArcadeSkillTriggerBase:trigger(triggerPoint, context, ignoreTriggerPoint)
	self._context = context

	if (self._triggerPoint == triggerPoint or ignoreTriggerPoint == true) and self:isCondSuccess(context) then
		self:tryCallFunc(self.onTrigger)
	end
end

function ArcadeSkillTriggerBase:isCondSuccess(context)
	if self._hitBase:isReachMaxLimit() then
		return false
	end

	if not self._condBaseList then
		return false
	end

	for _, cond in ipairs(self._condBaseList) do
		if not cond:isCondSuccess(context) then
			return false
		end
	end

	return true
end

function ArcadeSkillTriggerBase:onTrigger()
	self._hitBase:hit(self._context)
end

function ArcadeSkillTriggerBase:setSkillBase(skillBase)
	self._skillBase = skillBase

	if self._condBaseList then
		for _, cond in ipairs(self._condBaseList) do
			cond:setSkillBase(skillBase)
		end
	end

	if self._hitBase then
		self._hitBase:setSkillBase(skillBase)
	end
end

function ArcadeSkillTriggerBase:setOwner(ownerEntityType, ownerUid)
	ArcadeSkillTriggerBase.super.setOwner(self, ownerEntityType, ownerUid)

	if self._condBaseList then
		for _, cond in ipairs(self._condBaseList) do
			cond:setOwner(ownerEntityType, ownerUid)
		end
	end

	if self._hitBase then
		self._hitBase:setOwner(ownerEntityType, ownerUid)
	end
end

function ArcadeSkillTriggerBase:setSpecBelongSkillSetMO(skillSetMO)
	ArcadeSkillTriggerBase.super.setSpecBelongSkillSetMO(self, skillSetMO)

	if self._condBaseList then
		for _, cond in ipairs(self._condBaseList) do
			cond:setSpecBelongSkillSetMO(skillSetMO)
		end
	end

	if self._hitBase then
		self._hitBase:setSpecBelongSkillSetMO(skillSetMO)
	end
end

function ArcadeSkillTriggerBase:getCondBaseList()
	return self._condBaseList
end

function ArcadeSkillTriggerBase:getHitBase()
	return self._hitBase
end

function ArcadeSkillTriggerBase:getTriggerPoint()
	return self._triggerPoint
end

return ArcadeSkillTriggerBase
