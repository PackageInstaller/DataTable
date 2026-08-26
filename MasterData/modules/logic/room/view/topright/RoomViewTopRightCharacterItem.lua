-- chunkname: @modules/logic/room/view/topright/RoomViewTopRightCharacterItem.lua

module("modules.logic.room.view.topright.RoomViewTopRightCharacterItem", package.seeall)

local RoomViewTopRightCharacterItem = class("RoomViewTopRightCharacterItem", RoomViewTopRightBaseItem)

function RoomViewTopRightCharacterItem:ctor(param)
	RoomViewTopRightCharacterItem.super.ctor(self, param)
end

function RoomViewTopRightCharacterItem:_customOnInit()
	self._resourceItem.simageicon = gohelper.findChildImage(self._resourceItem.go, "icon")

	UISpriteSetMgr.instance:setRoomSprite(self._resourceItem.simageicon, "img_juese")
	self:_setShow(true)
end

function RoomViewTopRightCharacterItem:_onClick()
	local maxCharacterCount = RoomCharacterModel.instance:getMaxCharacterCount()
	local buildDegree = RoomMapModel.instance:getAllBuildDegree()
	local characterLimitAdd = RoomConfig.instance:getCharacterLimitAddByBuildDegree(buildDegree)

	ViewMgr.instance:openView(ViewName.RoomTipsView, {
		type = RoomTipsView.ViewType.Character
	})
end

function RoomViewTopRightCharacterItem:addEventListeners()
	self.addEventCb(self, RoomMapController.instance, RoomEvent.UpdateRoomLevel, self._refreshUI, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ConfirmCharacter, self._refreshUI, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.UnUseCharacter, self._refreshUI, self)
end

function RoomViewTopRightCharacterItem:removeEventListeners()
	return
end

function RoomViewTopRightCharacterItem:_refreshUI()
	local maxCharacterCount = RoomCharacterModel.instance:getMaxCharacterCount()
	local characterCount = RoomCharacterModel.instance:getConfirmCharacterCount()

	self._resourceItem.txtquantity.text = string.format("%d/%d", characterCount, maxCharacterCount)
end

function RoomViewTopRightCharacterItem:_customOnDestory()
	return
end

return RoomViewTopRightCharacterItem
