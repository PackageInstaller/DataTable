-- chunkname: @modules/logic/room/view/transport/RoomTransportSiteItem.lua

module("modules.logic.room.view.transport.RoomTransportSiteItem", package.seeall)

local RoomTransportSiteItem = class("RoomTransportSiteItem", ListScrollCellExtend)

function RoomTransportSiteItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomTransportSiteItem:addEvents()
	self._btnswithItem:AddClickListener(self._btnswithItemOnClick, self)
end

function RoomTransportSiteItem:removeEvents()
	self._btnswithItem:RemoveClickListener()
end

function RoomTransportSiteItem:_btnswithItemOnClick()
	if self._view and self._view.viewContainer then
		self._view.viewContainer:dispatchEvent(RoomEvent.TransportSiteSelect, self:getDataMO())
	end
end

function RoomTransportSiteItem:_editableInitView()
	self._btnswithItem = gohelper.findChildButtonWithAudio(self.viewGO, "btn_swithItem")
	self._goselect = gohelper.findChild(self.viewGO, "btn_swithItem/go_select")
	self._imageselecticon = gohelper.findChildImage(self.viewGO, "btn_swithItem/go_select/image_selecticon")
	self._gounselect = gohelper.findChild(self.viewGO, "btn_swithItem/go_unselect")
	self._imageunselecticon = gohelper.findChildImage(self.viewGO, "btn_swithItem/go_unselect/image_unselecticon")
end

function RoomTransportSiteItem:_editableAddEvents()
	return
end

function RoomTransportSiteItem:_editableRemoveEvents()
	return
end

function RoomTransportSiteItem:getDataMO()
	return self._dataMO
end

function RoomTransportSiteItem:onUpdateMO(mo)
	self._dataMO = mo

	self:refreshUI()
end

function RoomTransportSiteItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)
	gohelper.setActive(self._gounselect, not isSelect)
end

function RoomTransportSiteItem:onDestroyView()
	return
end

function RoomTransportSiteItem:refreshUI()
	if self._dataMO then
		local pathMO = RoomMapTransportPathModel.instance:getTransportPathMO(self._dataMO.pathId)
		local isActive = false
		local vehicleCfg = pathMO and RoomTransportHelper.getVehicleCfgByBuildingId(pathMO.buildingId, pathMO.buildingSkinId)

		if vehicleCfg then
			if vehicleCfg.id ~= self._lastVehicleId then
				UISpriteSetMgr.instance:setRoomSprite(self._imageselecticon, vehicleCfg.buildIcon)
				UISpriteSetMgr.instance:setRoomSprite(self._imageunselecticon, vehicleCfg.buildIcon)
			end

			isActive = true
		end

		if self._lastIsActive ~= isActive then
			gohelper.setActive(self._imageselecticon, isActive)
			gohelper.setActive(self._imageunselecticon, isActive)
		end
	end
end

return RoomTransportSiteItem
