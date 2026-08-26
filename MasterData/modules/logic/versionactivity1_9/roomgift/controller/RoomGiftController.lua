-- chunkname: @modules/logic/versionactivity1_9/roomgift/controller/RoomGiftController.lua

module("modules.logic.versionactivity1_9.roomgift.controller.RoomGiftController", package.seeall)

local RoomGiftController = class("RoomGiftController", BaseController)

function RoomGiftController:onInit()
	return
end

function RoomGiftController:onInitFinish()
	return
end

function RoomGiftController:addConstEvents()
	return
end

function RoomGiftController:reInit()
	return
end

function RoomGiftController:getAct159Info()
	local isOnline = RoomGiftModel.instance:isActOnLine()

	if isOnline then
		local actId = RoomGiftModel.instance:getActId()

		RoomGiftRpc.instance:sendGet159InfosRequest(actId)
	else
		self:dispatchEvent(RoomGiftEvent.UpdateActInfo)
	end
end

function RoomGiftController:getAct159Bonus()
	local isOnline = RoomGiftModel.instance:isActOnLine(true)

	if not isOnline then
		return
	end

	local actId = RoomGiftModel.instance:getActId()

	RoomGiftRpc.instance:sendGet159BonusRequest(actId)
end

RoomGiftController.instance = RoomGiftController.New()

return RoomGiftController
