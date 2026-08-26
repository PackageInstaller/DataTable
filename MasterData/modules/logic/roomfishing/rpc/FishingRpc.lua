-- chunkname: @modules/logic/roomfishing/rpc/FishingRpc.lua

module("modules.logic.roomfishing.rpc.FishingRpc", package.seeall)

local FishingRpc = class("FishingRpc", BaseRpc)

function FishingRpc:sendGetFishingInfoRequest(cb, cbObj)
	local req = FishingModule_pb.GetFishingInfoRequest()

	self:sendMsg(req, cb, cbObj)
end

function FishingRpc:onReceiveGetFishingInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	FishingController.instance:updateFishingInfo(nil, msg.fishingPoolInfo)
end

function FishingRpc:sendGetOtherFishingInfoRequest(userId, cb, cbObj)
	local req = FishingModule_pb.GetOtherFishingInfoRequest()

	req.userId = userId

	self:sendMsg(req, cb, cbObj)
end

function FishingRpc:onReceiveGetOtherFishingInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	FishingController.instance:updateFishingInfo(msg.userId, msg.fishingPoolInfo, msg.friendInfo)
end

function FishingRpc:sendFishingRequest(poolUserId, fishTimes, cb, cbObj)
	local req = FishingModule_pb.FishingRequest()

	req.poolUserId = poolUserId
	req.fishTimes = fishTimes

	self:sendMsg(req, cb, cbObj)
end

function FishingRpc:onReceiveFishingReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	FishingController.instance:onFishing(msg.poolUserId, msg.fishTimes, msg.progress)
end

function FishingRpc:sendGetFishingBonusRequest(cb, cbObj)
	local req = FishingModule_pb.GetFishingBonusRequest()

	self:sendMsg(req, cb, cbObj)
end

function FishingRpc:onReceiveGetFishingBonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	FishingController.instance:onGetFishingBonus(msg)
end

function FishingRpc:sendChangeFishingCurrencyRequest(count, cb, cbObj)
	local req = FishingModule_pb.ChangeFishingCurrencyRequest()

	req.count = count

	self:sendMsg(req, cb, cbObj)
end

function FishingRpc:onReceiveChangeFishingCurrencyReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	FishingController.instance:onExchangeFishingCurrency(msg.count, msg.exchangedCount)
end

function FishingRpc:sendGetFishingFriendsRequest(cb, cbObj)
	local req = FishingModule_pb.GetFishingFriendsRequest()

	self:sendMsg(req, cb, cbObj)
end

function FishingRpc:onReceiveGetFishingFriendsReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	FishingController.instance:updateFriendListInfo(msg.notFishingFriendInfo, true)
end

FishingRpc.instance = FishingRpc.New()

return FishingRpc
