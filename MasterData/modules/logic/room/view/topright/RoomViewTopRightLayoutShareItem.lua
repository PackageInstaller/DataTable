-- chunkname: @modules/logic/room/view/topright/RoomViewTopRightLayoutShareItem.lua

module("modules.logic.room.view.topright.RoomViewTopRightLayoutShareItem", package.seeall)

local RoomViewTopRightLayoutShareItem = class("RoomViewTopRightLayoutShareItem", RoomViewTopRightBaseItem)

function RoomViewTopRightLayoutShareItem:ctor(param)
	RoomViewTopRightLayoutShareItem.super.ctor(self, param)

	self._ismap = self._param.ismap
end

function RoomViewTopRightLayoutShareItem:_customOnInit()
	self._resourceItem.simageicon = gohelper.findChildImage(self._resourceItem.go, "icon")

	UISpriteSetMgr.instance:setRoomSprite(self._resourceItem.simageicon, "room_layout_icon_redu")
end

function RoomViewTopRightLayoutShareItem:_onClick()
	if RoomController.instance:isVisitMode() then
		return
	end

	ViewMgr.instance:openView(ViewName.RoomTipsView, {
		type = RoomTipsView.ViewType.PlanShare,
		shareCount = self:_getQuantity()
	})
end

function RoomViewTopRightLayoutShareItem:addEventListeners()
	return
end

function RoomViewTopRightLayoutShareItem:removeEventListeners()
	return
end

function RoomViewTopRightLayoutShareItem:_refreshUI()
	local isShow = not (self._ismap and not RoomController.instance:isVisitShareMode())

	if isShow then
		self._resourceItem.txtquantity.text = self:_getQuantity()
	end

	self:_setShow(isShow)
end

function RoomViewTopRightLayoutShareItem:_getQuantity()
	if self._ismap then
		local info = RoomModel.instance:getInfoByMode(RoomModel.instance:getGameMode())

		return (info or nil) and (info.useCount or 0)
	end

	return RoomLayoutModel.instance:getUseCount()
end

return RoomViewTopRightLayoutShareItem
