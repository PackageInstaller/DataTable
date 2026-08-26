-- chunkname: @modules/logic/room/view/transport/RoomTransportLineItem.lua

module("modules.logic.room.view.transport.RoomTransportLineItem", package.seeall)

local RoomTransportLineItem = class("RoomTransportLineItem", ListScrollCellExtend)

function RoomTransportLineItem:onInitView()
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._btnitemclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_content/#btn_itemclick")
	self._imagetype1 = gohelper.findChildImage(self.viewGO, "#go_content/#image_type1")
	self._imagetype2 = gohelper.findChildImage(self.viewGO, "#go_content/#image_type2")
	self._goselect = gohelper.findChild(self.viewGO, "#go_content/#go_select")
	self._btndelectPath = gohelper.findChildButtonWithAudio(self.viewGO, "#go_content/#btn_delectPath")
	self._golinkfail = gohelper.findChild(self.viewGO, "#go_content/#go_linkfail")
	self._golinksuccess = gohelper.findChild(self.viewGO, "#go_content/#go_linksuccess")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomTransportLineItem:addEvents()
	self._btnitemclick:AddClickListener(self._btnitemclickOnClick, self)
	self._btndelectPath:AddClickListener(self._btndelectPathOnClick, self)
end

function RoomTransportLineItem:removeEvents()
	self._btnitemclick:RemoveClickListener()
	self._btndelectPath:RemoveClickListener()
end

function RoomTransportLineItem:_btnitemclickOnClick()
	if self._view and self._view.viewContainer then
		self._view.viewContainer:dispatchEvent(RoomEvent.TransportPathSelectLineItem, self:getDataMO())
	end
end

function RoomTransportLineItem:_btndelectPathOnClick()
	local transportMO = self:getTransportPathMO()

	if transportMO and transportMO:isLinkFinish() or transportMO:getHexPointCount() > 0 then
		transportMO:clear()
		transportMO:setIsEdit(true)
		self:refreshLinkUI()
		RoomMapTransportPathModel.instance:updateSiteHexPoint()
		RoomTransportController.instance:updateBlockUseState()
	end
end

function RoomTransportLineItem:_editableInitView()
	self._gofinishAnim = gohelper.findChild(self._golinksuccess, "finish")

	gohelper.setActive(self._goselect, false)
end

function RoomTransportLineItem:_editableAddEvents()
	return
end

function RoomTransportLineItem:_editableRemoveEvents()
	return
end

function RoomTransportLineItem:onUpdateMO(mo)
	self._dataMO = mo

	self:refreshUI()
end

function RoomTransportLineItem:getDataMO()
	return self._dataMO
end

function RoomTransportLineItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)
end

function RoomTransportLineItem:refreshUI()
	gohelper.setActive(self._gocontent, self._dataMO ~= nil)

	if self._dataMO then
		UISpriteSetMgr.instance:setRoomSprite(self._imagetype1, RoomBuildingEnum.BuildingTypeLineIcon[self._dataMO.fromType])
		UISpriteSetMgr.instance:setRoomSprite(self._imagetype2, RoomBuildingEnum.BuildingTypeLineIcon[self._dataMO.toType])
	end

	self:refreshLinkUI()
end

function RoomTransportLineItem:refreshLinkUI()
	local isSuccess = self:_isCheckLinkFinish()

	gohelper.setActive(self._btndelectPath, isSuccess)
	gohelper.setActive(self._golinksuccess, isSuccess)
	gohelper.setActive(self._golinkfail, isSuccess == false)

	if self._isLinkFinishAnim ~= isSuccess then
		if self._isLinkFinishAnim ~= nil then
			gohelper.setActive(self._gofinishAnim, isSuccess)
		end

		self._isLinkFinishAnim = isSuccess
	end
end

function RoomTransportLineItem:_isCheckLinkFinish()
	local transportMO = self:getTransportPathMO()

	if transportMO and transportMO:isLinkFinish() then
		return true
	end

	return false
end

function RoomTransportLineItem:getTransportPathMO()
	if self._dataMO then
		return RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(self._dataMO.fromType, self._dataMO.toType)
	end
end

function RoomTransportLineItem:onDestroyView()
	return
end

return RoomTransportLineItem
