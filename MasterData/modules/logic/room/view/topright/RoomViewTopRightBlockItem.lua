-- chunkname: @modules/logic/room/view/topright/RoomViewTopRightBlockItem.lua

module("modules.logic.room.view.topright.RoomViewTopRightBlockItem", package.seeall)

local RoomViewTopRightBlockItem = class("RoomViewTopRightBlockItem", RoomViewTopRightBaseItem)

function RoomViewTopRightBlockItem:ctor(param)
	RoomViewTopRightBlockItem.super.ctor(self, param)
end

function RoomViewTopRightBlockItem:_customOnInit()
	self._resourceItem.imageicon = gohelper.findChildImage(self._resourceItem.go, "icon")

	UISpriteSetMgr.instance:setRoomSprite(self._resourceItem.imageicon, "icon_zongkuai_light")
	recthelper.setSize(self._resourceItem.imageicon.transform, 68, 52)
	self:_setShow(true)
end

function RoomViewTopRightBlockItem:_imageLoaded()
	self._resourceItem.imageicon:SetNativeSize()
end

function RoomViewTopRightBlockItem:_onClick()
	if RoomController.instance:isVisitMode() then
		return
	end

	ViewMgr.instance:openView(ViewName.RoomTipsView, {
		type = RoomTipsView.ViewType.Block
	})
end

function RoomViewTopRightBlockItem:addEventListeners()
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ClientTryBackBlock, self._refreshUI, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ClientCancelBackBlock, self._refreshUI, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ConfirmBackBlock, self._refreshUI, self)
	self.addEventCb(self, RoomBuildingController.instance, RoomEvent.BuildingListShowChanged, self._refreshUI, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.UpdateInventoryCount, self._refreshUI, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ConfirmSelectBlockPackage, self._refreshUI, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.TradeLevelChange, self._refreshUI, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ClientPlaceBlock, self._refreshAddNumUI, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ClientCancelBlock, self._refreshAddNumUI, self)
end

function RoomViewTopRightBlockItem:removeEventListeners()
	return
end

function RoomViewTopRightBlockItem:_getPlaceBlockNum()
	if RoomController.instance:isEditMode() and RoomMapBlockModel.instance:getTempBlockMO() then
		return 1
	end

	return 0
end

function RoomViewTopRightBlockItem:_refreshAddNumUI()
	local num = self:_getPlaceBlockNum()

	if num > 0 then
		self._resourceItem.txtaddNum.text = "+" .. num
	end

	gohelper.setActive(self._resourceItem.txtaddNum, num > 0)
end

function RoomViewTopRightBlockItem:_refreshUI()
	local curNum = RoomMapBlockModel.instance:getConfirmBlockCount()

	if RoomController.instance:isVisitMode() then
		self._resourceItem.txtquantity.text = curNum
	else
		local maxNum = RoomMapBlockModel.instance:getMaxBlockCount()

		self._resourceItem.txtquantity.text = string.format("%s/%s", curNum, maxNum)
	end

	self:_refreshAddNumUI()
end

function RoomViewTopRightBlockItem:_customOnDestory()
	return
end

return RoomViewTopRightBlockItem
