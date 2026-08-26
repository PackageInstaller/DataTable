-- chunkname: @modules/logic/room/entity/comp/RoomBuildingCritterComp.lua

module("modules.logic.room.entity.comp.RoomBuildingCritterComp", package.seeall)

local RoomBuildingCritterComp = class("RoomBuildingCritterComp", RoomBaseEffectKeyComp)

function RoomBuildingCritterComp:init(go)
	self.go = go
	self._scene = GameSceneMgr.instance:getCurScene()
end

function RoomBuildingCritterComp:addEventListeners()
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterBuildingChangSeatSlotVisible, self.isShowSeatSlots, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterBuildingChangeRestingCritter, self._startRefreshSeatSlotsTask, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterUnlockSeatSlot, self._startRefreshSeatSlotsTask, self)
end

function RoomBuildingCritterComp:removeEventListeners()
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterBuildingChangSeatSlotVisible, self.isShowSeatSlots, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterBuildingChangeRestingCritter, self._startRefreshSeatSlotsTask, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterUnlockSeatSlot, self._startRefreshSeatSlotsTask, self)
end

function RoomBuildingCritterComp:onStart()
	return
end

function RoomBuildingCritterComp:setSeatSlotItem()
	self._seatSlotDict = {}

	local buildingMO = self:getMO()

	for index = 1, CritterEnum.CritterMaxSeatCount do
		local seatSlotId = index - 1
		local pointGO = self.entity:getCritterPoint(seatSlotId)

		if not pointGO then
			logError(string.format("RoomBuildingCritterComp:setSeatSlotItem error, no critter point, buildingUid:%s,index:%s", buildingMO and buildingMO.buildingUid, seatSlotId + 1))

			return
		end

		local seatSlotGO = RoomGOPool.getInstance(RoomScenePreloader.CritterBuildingSeatSlot, pointGO, "seatSlot" .. seatSlotId)

		gohelper.setActive(seatSlotGO, false)

		local seatSlotItem = self:getUserDataTb_()

		seatSlotItem.go = seatSlotGO
		seatSlotItem.trans = seatSlotGO.transform

		transformhelper.setLocalScale(seatSlotItem.trans, 0.35, 0.35, 0.35)

		seatSlotItem.goLocked = gohelper.findChild(seatSlotItem.go, "locked")
		seatSlotItem.goUnlocked = gohelper.findChild(seatSlotItem.go, "unlocked")
		self._seatSlotDict[seatSlotId] = seatSlotItem
	end
end

function RoomBuildingCritterComp:cleanSeatSlotItem()
	if self._seatSlotDict then
		for _, seatSlotItem in pairs(self._seatSlotDict) do
			RoomGOPool.returnInstance(RoomScenePreloader.CritterBuildingSeatSlot, seatSlotItem.go)
		end

		self._seatSlotDict = nil
	end
end

function RoomBuildingCritterComp:onRebuildEffectGO()
	local buildingMO = self:getMO()

	if buildingMO then
		::label_7_0::

		local var_7_0 = buildingMO.config

		if buildingMO.config then
			local buildingType = buildingMO.config.buildingType

			if buildingType == RoomBuildingEnum.BuildingType.Rest then
				local sceneLoader = self._scene.loader

				sceneLoader:makeSureLoaded({
					RoomScenePreloader.CritterBuildingSeatSlot
				}, self.setSeatSlotItem, self)
			end
		end
	end
end

function RoomBuildingCritterComp:onReturnEffectGO()
	self:cleanSeatSlotItem()
end

function RoomBuildingCritterComp:refreshAllCritter()
	return
end

function RoomBuildingCritterComp:isShowSeatSlots(isShow)
	if not self._seatSlotDict then
		return
	end

	self:refreshSeatSlots()

	for _, seatSlotItem in pairs(self._seatSlotDict) do
		gohelper.setActive(seatSlotItem.go, isShow)
	end
end

function RoomBuildingCritterComp:_startRefreshSeatSlotsTask()
	if not self._isHasRefreshSeatSlotsTask then
		self._isHasRefreshSeatSlotsTask = true

		TaskDispatcher.runDelay(self._onRunRefreshSeatSlotsTask, self, 0.1)
	end
end

function RoomBuildingCritterComp:_onRunRefreshSeatSlotsTask()
	self._isHasRefreshSeatSlotsTask = false

	if self.__willDestroy then
		return
	end

	self:refreshSeatSlots()
end

function RoomBuildingCritterComp:refreshSeatSlots()
	if not self._seatSlotDict then
		return
	end

	local buildingMO = self:getMO()

	for seatSlotId, seatSlotItem in pairs(self._seatSlotDict) do
		local seatSlotMO = buildingMO:getSeatSlotMO(seatSlotId)
		local isEmpty = buildingMO:isSeatSlotEmpty(seatSlotId)

		gohelper.setActive(seatSlotItem.goUnlocked, seatSlotMO and isEmpty)
		gohelper.setActive(seatSlotItem.goLocked, not seatSlotMO)
	end
end

function RoomBuildingCritterComp:getMO()
	return self.entity:getMO()
end

function RoomBuildingCritterComp:beforeDestroy()
	self.__willDestroy = true

	self:removeEventListeners()
	self:cleanSeatSlotItem()

	self._isHasRefreshSeatSlotsTask = false

	TaskDispatcher.cancelTask(self._onRunRefreshSeatSlotsTask, self)
end

return RoomBuildingCritterComp
