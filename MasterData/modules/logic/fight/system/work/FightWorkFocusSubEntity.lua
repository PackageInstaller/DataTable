-- chunkname: @modules/logic/fight/system/work/FightWorkFocusSubEntity.lua

module("modules.logic.fight.system.work.FightWorkFocusSubEntity", package.seeall)

local FightWorkFocusSubEntity = class("FightWorkFocusSubEntity", BaseWork)

function FightWorkFocusSubEntity:ctor(entityMO)
	self._entityMO = entityMO
	self._entityId = self._entityMO.id .. "focusSub"
end

function FightWorkFocusSubEntity:onStart()
	local isSub = FightDataHelper.entityMgr:isSub(self._entityMO.id)

	if isSub then
		local subEntityList = self.context.subEntityList

		for i, v in ipairs(subEntityList) do
			if v.id == self._entityId then
				self:onDone(true)

				return
			end
		end

		if self._entityMO then
			local skinConfig = self._entityMO:getSpineSkinCO()

			if not self._entityMO then
				self:onDone(true)

				return
			end

			FightController.instance:registerCallback(FightEvent.OnSpineLoaded, self._onSpineLoaded, self)
			FightGameMgr.entityMgr:buildTempSpineByName(nil, self._entityId, self._entityMO.side, nil, self._entityMO)
		end
	else
		self:onDone(true)
	end
end

function FightWorkFocusSubEntity:_onSpineLoaded(unitSpine)
	if self._entityId == unitSpine.unitSpawn.id then
		table.insert(self.context.subEntityList, unitSpine.unitSpawn)
		self:onDone(true)
	end
end

function FightWorkFocusSubEntity:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self._onSpineLoaded, self)
end

return FightWorkFocusSubEntity
