-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionRoomPlaceBlock.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomPlaceBlock", package.seeall)

local WaitGuideActionRoomPlaceBlock = class("WaitGuideActionRoomPlaceBlock", BaseGuideAction)

function WaitGuideActionRoomPlaceBlock:onStart(context)
	self._placeCount = tonumber(self.actionParam)

	WaitGuideActionRoomPlaceBlock.super.onStart(self, context)
	RoomMapController.instance:registerCallback(RoomEvent.OnUseBlock, self._checkPlaceCount, self)
	self:_checkPlaceCount()
end

function WaitGuideActionRoomPlaceBlock:_checkPlaceCount()
	local fullBlockCount = RoomMapBlockModel.instance:getFullBlockCount()

	if fullBlockCount >= self._placeCount then
		self:onDone(true)
	end
end

function WaitGuideActionRoomPlaceBlock:clearWork()
	RoomMapController.instance:unregisterCallback(RoomEvent.OnUseBlock, self._checkPlaceCount, self)
end

return WaitGuideActionRoomPlaceBlock
