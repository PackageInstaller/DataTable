-- chunkname: @modules/logic/room/view/transport/RoomTransportCritterItem.lua

module("modules.logic.room.view.transport.RoomTransportCritterItem", package.seeall)

local RoomTransportCritterItem = class("RoomTransportCritterItem", ListScrollCellExtend)

function RoomTransportCritterItem:onInitView()
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._goicon = gohelper.findChild(self.viewGO, "#go_content/#go_icon")
	self._goinfo = gohelper.findChild(self.viewGO, "#go_content/#go_info")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_content/#go_info/#txt_name")
	self._goskill = gohelper.findChild(self.viewGO, "#go_content/#go_info/#go_skill")
	self._simageskill = gohelper.findChildSingleImage(self.viewGO, "#go_content/#go_info/#go_skill/#simage_skill")
	self._golayoutAttr = gohelper.findChild(self.viewGO, "#go_content/#go_info/#go_layoutAttr")
	self._goattrItem = gohelper.findChild(self.viewGO, "#go_content/#go_info/#go_layoutAttr/#go_attrItem")
	self._txtattrValue = gohelper.findChildText(self.viewGO, "#go_content/#go_info/#go_layoutAttr/#go_attrItem/#txt_attrValue")
	self._simageattrIcon = gohelper.findChildSingleImage(self.viewGO, "#go_content/#go_info/#go_layoutAttr/#go_attrItem/#simage_attrIcon")
	self._goselected = gohelper.findChild(self.viewGO, "#go_content/#go_selected")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_content/#btn_click")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "#go_content/#btn_detail")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomTransportCritterItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
end

function RoomTransportCritterItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btndetail:RemoveClickListener()
end

function RoomTransportCritterItem:_btnclickOnClick()
	if self._mo and self._view and self._view.viewContainer then
		self._view.viewContainer:dispatchEvent(RoomEvent.TransportCritterSelect, self._mo)
	end
end

function RoomTransportCritterItem:_btndetailOnClick()
	return
end

function RoomTransportCritterItem:_editableInitView()
	return
end

function RoomTransportCritterItem:_editableAddEvents()
	return
end

function RoomTransportCritterItem:_editableRemoveEvents()
	return
end

function RoomTransportCritterItem:onUpdateMO(mo)
	self._mo = mo

	self:_refreshUI()
end

function RoomTransportCritterItem:_refreshUI()
	local critterUid = self._mo:getId()
	local critterId = self._mo:getDefineId()
	local critterCfg = self._mo:getDefineCfg()

	self.critterIcon = self.critterIcon or IconMgr.instance:getCommonCritterIcon(self._goicon)

	self.critterIcon:setMOValue(critterUid, critterId)

	self._txtname.text = critterCfg.name
end

function RoomTransportCritterItem:onSelect(isSelect)
	return
end

function RoomTransportCritterItem:onDestroyView()
	return
end

RoomTransportCritterItem.prefabPath = "ui/viewres/room/transport/roomtransportcritteritem.prefab"

return RoomTransportCritterItem
