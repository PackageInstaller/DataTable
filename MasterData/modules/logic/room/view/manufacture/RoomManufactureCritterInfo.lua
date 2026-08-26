-- chunkname: @modules/logic/room/view/manufacture/RoomManufactureCritterInfo.lua

module("modules.logic.room.view.manufacture.RoomManufactureCritterInfo", package.seeall)

local RoomManufactureCritterInfo = class("RoomManufactureCritterInfo", LuaCompBase)
local NONE_NAME = "critterInfo"

function RoomManufactureCritterInfo:init(go)
	self.go = go
	self._gohas = gohelper.findChild(self.go, "#go_has")
	self._gocrittericon = gohelper.findChild(self.go, "#go_has/#go_critterIcon")
	self._gonone = gohelper.findChild(self.go, "#go_none")
	self._goselected = gohelper.findChild(self.go, "#go_selected")
	self._btnclick = gohelper.findChildClickWithDefaultAudio(self.go, "#btn_click")
	self._goplaceEff = gohelper.findChild(self.go, "#add")

	self:reset()
end

function RoomManufactureCritterInfo:addEventListeners()
	self._btnclick:AddClickListener(self._onClick, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ChangeSelectedCritterSlotItem, self._onChangeSelectedCritterSlotItem, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.CritterWorkInfoChange, self._onCritterWorkInfoChange, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.PlayAddCritterEff, self._onAddCritter, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function RoomManufactureCritterInfo:removeEventListeners()
	self._btnclick:RemoveClickListener()
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.ChangeSelectedCritterSlotItem, self._onChangeSelectedCritterSlotItem, self)
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.CritterWorkInfoChange, self._onCritterWorkInfoChange, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.PlayAddCritterEff, self._onAddCritter, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function RoomManufactureCritterInfo:_onClick()
	local curBuildingUid = self:getViewBuilding()

	if self.parent and self.parent.setViewBuildingUid then
		self.parent:setViewBuildingUid()
	end

	ManufactureController.instance:clickCritterSlotItem(curBuildingUid, self.critterSlotId)
end

function RoomManufactureCritterInfo:_onChangeSelectedCritterSlotItem()
	self:refreshSelected()
end

function RoomManufactureCritterInfo:_onCritterWorkInfoChange()
	self:setCritter()
	self:refresh()
end

function RoomManufactureCritterInfo:_onAddCritter(playEffDict, isTransport)
	if not playEffDict or isTransport then
		return
	end

	local curBuildingUid = self:getViewBuilding()

	if playEffDict[curBuildingUid] and playEffDict[curBuildingUid][self.critterSlotId] then
		self:playPlaceCritterEff()
	end
end

function RoomManufactureCritterInfo:_onCloseView(viewName)
	if viewName == ViewName.RoomCritterOneKeyView and self._playEffWaitCloseView then
		self:playPlaceCritterEff()
	end
end

function RoomManufactureCritterInfo:getViewBuilding()
	local viewBuildingUid, viewBuildingMO

	if self.parent then
		viewBuildingUid, viewBuildingMO = self.parent:getViewBuilding()
	end

	return viewBuildingUid, viewBuildingMO
end

function RoomManufactureCritterInfo:setData(critterSlotId, index, parent)
	self.critterSlotId = critterSlotId
	self.index = index
	self.parent = parent
	self._playEffWaitCloseView = false
	self.go.name = string.format("id-%s_i-%s", self.critterSlotId, self.index)

	self:setCritter()
	self:refresh()
	gohelper.setActive(self._goplaceEff, false)
	gohelper.setActive(self.go, true)
end

function RoomManufactureCritterInfo:setCritter()
	local _, curBuildingMO = self:getViewBuilding()
	local critterUid = curBuildingMO and curBuildingMO:getWorkingCritter(self.critterSlotId)

	if critterUid then
		self.critterIcon = self.critterIcon or IconMgr.instance:getCommonCritterIcon(self._gocrittericon)

		self.critterIcon:setMOValue(critterUid)
		self.critterIcon:showMood()
	end

	gohelper.setActive(self._gohas, critterUid)
	gohelper.setActive(self._gonone, not critterUid)
end

function RoomManufactureCritterInfo:refresh()
	self:refreshSelected()
end

function RoomManufactureCritterInfo:refreshSelected()
	local isSelected = false

	if self.critterSlotId then
		local curBuildingUid = self:getViewBuilding()
		local buildingUid, critterSlotId = ManufactureModel.instance:getSelectedCritterSlot()

		if curBuildingUid and curBuildingUid == buildingUid then
			isSelected = true
		end
	end

	gohelper.setActive(self._goselected, isSelected)
end

function RoomManufactureCritterInfo:playPlaceCritterEff()
	local isOpenOneKeyView = ViewMgr.instance:isOpen(ViewName.RoomCritterOneKeyView)

	if isOpenOneKeyView then
		self._playEffWaitCloseView = true
	else
		gohelper.setActive(self._goplaceEff, false)
		gohelper.setActive(self._goplaceEff, true)

		self._playEffWaitCloseView = false
	end
end

function RoomManufactureCritterInfo:reset()
	self.critterSlotId = nil
	self.index = nil
	self.parent = nil
	self.go.name = NONE_NAME
	self._playEffWaitCloseView = false

	gohelper.setActive(self._goplaceEff, false)
	gohelper.setActive(self.go, false)
end

function RoomManufactureCritterInfo:onDestroy()
	return
end

return RoomManufactureCritterInfo
