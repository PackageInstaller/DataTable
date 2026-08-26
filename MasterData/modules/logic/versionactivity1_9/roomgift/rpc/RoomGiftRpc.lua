-- chunkname: @modules/logic/versionactivity1_9/roomgift/rpc/RoomGiftRpc.lua

module("modules.logic.versionactivity1_9.roomgift.rpc.RoomGiftRpc", package.seeall)

local RoomGiftRpc = class("RoomGiftRpc", BaseRpc)

function RoomGiftRpc:sendGet159InfosRequest(activityId)
	if not activityId then
		return
	end

	local req = Activity159Module_pb.Get159InfosRequest()

	req.activityId = activityId

	return self:sendMsg(req)
end

function RoomGiftRpc:onReceiveGet159InfosReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoomGiftModel.instance:setActivityInfo(msg)
	RoomGiftController.instance:dispatchEvent(RoomGiftEvent.UpdateActInfo)
end

function RoomGiftRpc:sendGet159BonusRequest(activityId)
	if not activityId then
		return
	end

	local req = Activity159Module_pb.Get159BonusRequest()

	req.activityId = activityId

	return self:sendMsg(req)
end

function RoomGiftRpc:onReceiveGet159BonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoomGiftModel.instance:setHasGotBonus(true)
	RoomGiftController.instance:dispatchEvent(RoomGiftEvent.GetBonus)
end

RoomGiftRpc.instance = RoomGiftRpc.New()

return RoomGiftRpc
