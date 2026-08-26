-- chunkname: @modules/logic/room/view/transport/RoomTransportBuildingItem.lua

module("modules.logic.room.view.transport.RoomTransportBuildingItem", package.seeall)

local RoomTransportBuildingItem = class("RoomTransportBuildingItem", ListScrollCellExtend)

function RoomTransportBuildingItem:onInitView()
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._imagerare = gohelper.findChildImage(self.viewGO, "#go_content/#image_rare")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_content/#simage_icon")
	self._txtbuildingname = gohelper.findChildText(self.viewGO, "#go_content/#txt_buildingname")
	self._txtbuildingdec = gohelper.findChildText(self.viewGO, "#go_content/#txt_buildingdec")
	self._gobeplaced = gohelper.findChild(self.viewGO, "#go_content/#go_beplaced")
	self._goselect = gohelper.findChild(self.viewGO, "#go_content/#go_select")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_content/#btn_click")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_content/#go_reddot")
	self._golock = gohelper.findChild(self.viewGO, "#go_content/#go_lock")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomTransportBuildingItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function RoomTransportBuildingItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function RoomTransportBuildingItem:_btnclickOnClick()
	if self._view and self._view.viewContainer then
		self._view.viewContainer:dispatchEvent(RoomEvent.TransportBuildingSelect, self._mo)
	end

	if not self._mo.isNeedToBuy then
		self:_hideReddot()
	end
end

function RoomTransportBuildingItem:_editableInitView()
	return
end

function RoomTransportBuildingItem:_editableAddEvents()
	return
end

function RoomTransportBuildingItem:_editableRemoveEvents()
	return
end

function RoomTransportBuildingItem:onUpdateMO(mo)
	self._mo = mo

	self:_refreshUI()
end

function RoomTransportBuildingItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)
	gohelper.setActive(self._gobeplaced, self:_getIsUnse())
end

function RoomTransportBuildingItem:onDestroyView()
	return
end

function RoomTransportBuildingItem:_refreshUI()
	self._simageicon:LoadImage(ResUrl.getRoomImage("building/" .. self._mo:getIcon()))
	gohelper.setActive(self._gobeplaced, self:_getIsUnse())

	self._txtbuildingname.text = self._mo.config.name
	self._txtbuildingdec.text = self._mo.config.useDesc

	if not RoomBuildingEnum.RareFrame[self._mo.config.rare] then
		UISpriteSetMgr.instance:setRoomSprite(self._imagerare, RoomBuildingEnum.RareFrame[self._mo.config.rare])
		gohelper.setActive(self._goreddot, not self._mo.use)
		gohelper.setActive(self._golock, self._mo.isNeedToBuy)

		if not self._mo.use then
			RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.RoomBuildingPlace, self._mo.buildingId)
		end
	end
end

function RoomTransportBuildingItem:_getIsUnse()
	if self._mo and self._view and self._view.viewContainer then
		return self._mo.id == self._view.viewContainer.useBuildingUid
	end

	return false
end

function RoomTransportBuildingItem:_hideReddot()
	if self._mo.use then
		return
	end

	local reddotInfo = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.RoomBuildingPlace)

	if not reddotInfo or not reddotInfo.infos then
		return
	end

	local info = reddotInfo.infos[self._mo.buildingId]

	if not info then
		return
	end

	if info.value > 0 then
		RoomRpc.instance:sendHideBuildingReddotRequset(self._mo.buildingId)
	end
end

RoomTransportBuildingItem.prefabPath = "ui/viewres/room/transport/roomtransportbuildingitem.prefab"

return RoomTransportBuildingItem
