-- chunkname: @modules/logic/room/view/transport/RoomTransportBuildingSkinItem.lua

module("modules.logic.room.view.transport.RoomTransportBuildingSkinItem", package.seeall)

local RoomTransportBuildingSkinItem = class("RoomTransportBuildingSkinItem", ListScrollCellExtend)

function RoomTransportBuildingSkinItem:onInitView()
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._imagerare = gohelper.findChildImage(self.viewGO, "#go_content/#image_rare")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_content/#simage_icon")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_content/#btn_click")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_content/#go_reddot")
	self._goselected = gohelper.findChild(self.viewGO, "#go_content/#go_selected")
	self._golock = gohelper.findChild(self.viewGO, "#go_content/#go_lock")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomTransportBuildingSkinItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function RoomTransportBuildingSkinItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function RoomTransportBuildingSkinItem:_btnclickOnClick()
	if self._mo and self._view and self._view.viewContainer then
		self._view.viewContainer:dispatchEvent(RoomEvent.TransportBuildingSkinSelect, self._mo)
	end
end

function RoomTransportBuildingSkinItem:_editableInitView()
	return
end

function RoomTransportBuildingSkinItem:_editableAddEvents()
	return
end

function RoomTransportBuildingSkinItem:_editableRemoveEvents()
	return
end

function RoomTransportBuildingSkinItem:onUpdateMO(mo)
	self._mo = mo

	self:_refreshUI()
end

function RoomTransportBuildingSkinItem:onSelect(isSelect)
	gohelper.setActive(self._goselected, isSelect)
end

function RoomTransportBuildingSkinItem:_refreshUI()
	local mo = self._mo

	if mo then
		if not mo.config then
			local cfg = mo.buildingCfg

			if mo then
				self._simageicon:LoadImage(ResUrl.getRoomImage("building/" .. cfg.icon))

				if not RoomBuildingEnum.RareFrame[cfg.rare] then
					UISpriteSetMgr.instance:setRoomSprite(self._imagerare, RoomBuildingEnum.RareFrame[cfg.rare])
					gohelper.setActive(self._golock, mo.isLock)
				end
			end
		end
	end
end

function RoomTransportBuildingSkinItem:onDestroyView()
	return
end

RoomTransportBuildingSkinItem.prefabPath = "ui/viewres/room/transport/roomtransportbuildingskinitem.prefab"

return RoomTransportBuildingSkinItem
