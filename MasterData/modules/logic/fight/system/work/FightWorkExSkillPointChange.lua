-- chunkname: @modules/logic/fight/system/work/FightWorkExSkillPointChange.lua

module("modules.logic.fight.system.work.FightWorkExSkillPointChange", package.seeall)

local FightWorkExSkillPointChange = class("FightWorkExSkillPointChange", FightEffectBase)

function FightWorkExSkillPointChange:beforePlayEffectData()
	self._entityId = self.actEffectData.targetId
	self._entityMO = FightDataHelper.entityMgr:getById(self._entityId)
	self._oldValue = self._entityMO and self._entityMO:getUniqueSkillPoint()
end

function FightWorkExSkillPointChange:onStart()
	local entity = FightHelper.getEntity(self._entityId)

	if not entity then
		self:onDone(true)

		return
	end

	if not self._entityMO then
		self:onDone(true)

		return
	end

	self._newValue = self._entityMO and self._entityMO:getUniqueSkillPoint()

	if self._oldValue ~= self._newValue then
		FightController.instance:dispatchEvent(FightEvent.OnExSkillPointChange, self.actEffectData.targetId, self._oldValue, self._newValue)
	end

	self:onDone(true)
end

function FightWorkExSkillPointChange:clearWork()
	return
end

return FightWorkExSkillPointChange
