-- chunkname: @modules/logic/room/view/backpack/RoomBackpackCritterItem.lua

module("modules.logic.room.view.backpack.RoomBackpackCritterItem", package.seeall)

local RoomBackpackCritterItem = class("RoomBackpackCritterItem", ListScrollCellExtend)

function RoomBackpackCritterItem:onInitView()
	self._goCritterIcon = gohelper.findChild(self.viewGO, "#go_critterIcon")
end

function RoomBackpackCritterItem:addEvents()
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterInfoPushUpdate, self._onCritterInfoUpdate, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterChangeLockStatus, self._onCritterLockStatusChange, self)
end

function RoomBackpackCritterItem:removeEvents()
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterInfoPushUpdate, self._onCritterInfoUpdate, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterChangeLockStatus, self._onCritterLockStatusChange, self)
end

function RoomBackpackCritterItem:_onCritterInfoUpdate(critterUidDict)
	if self._mo then
		local critterUid = self._mo:getId()

		if not self._critterIcon or not self._mo or critterUidDict and not critterUidDict[self._mo] then
			return
		end

		self._critterIcon:refreshLockIcon()
		self._critterIcon:refreshMaturityIcon()
	end
end

function RoomBackpackCritterItem:_onCritterLockStatusChange(changeCritterUid)
	if self._mo then
		local critterUid = self._mo:getId()

		if not self._critterIcon or not self._mo or self._mo ~= changeCritterUid then
			return
		end

		self._critterIcon:refreshLockIcon()
	end
end

function RoomBackpackCritterItem:onUpdateMO(mo)
	self._mo = mo

	if not self._critterIcon then
		self._critterIcon = IconMgr.instance:getCommonCritterIcon(self._goCritterIcon)

		self._critterIcon:setLockIconShow(true)
		self._critterIcon:setMaturityIconShow(true)
	end

	self._critterIcon:onUpdateMO(self._mo)
	self._critterIcon:setCustomClick(self.onClickCB, self)
	self._critterIcon:setIsShowBuildingIcon(true)
end

function RoomBackpackCritterItem:onClickCB()
	local isMaturity = self._mo:isMaturity()

	CritterController.instance:openRoomCritterDetailView(not isMaturity, self._mo)
end

function RoomBackpackCritterItem:onDestroyView()
	return
end

return RoomBackpackCritterItem
