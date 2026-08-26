-- chunkname: @modules/logic/partycloth/rpc/PartyClothRpc.lua

module("modules.logic.partycloth.rpc.PartyClothRpc", package.seeall)

local PartyClothRpc = class("PartyClothRpc", BaseRpc)

function PartyClothRpc:sendGetPartyClothSummonPoolInfoRequest(callback, callbackObj)
	local req = PartyClothModule_pb.GetPartyClothSummonPoolInfoRequest()

	self:sendMsg(req, callback, callbackObj)
end

function PartyClothRpc:onReceiveGetPartyClothSummonPoolInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local poolInfos = msg.poolInfos

	PartyClothModel.instance:setSummonPoolInfo(poolInfos)
end

function PartyClothRpc:sendSummonPartyClothRequest(poolId, count)
	local req = PartyClothModule_pb.SummonPartyClothRequest()

	req.poolId = poolId
	req.count = count

	self:sendMsg(req)
end

function PartyClothRpc:onReceiveSummonPartyClothReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local poolId = msg.poolId
	local summonResult = msg.summonResult
	local hasSummonPrizeInfos = msg.hasSummonPrizeInfos
	local leftPrizeNum = msg.leftPrizeNum

	PartyClothModel.instance:updateSummonPoolInfo(poolId, hasSummonPrizeInfos, leftPrizeNum)

	for _, info in ipairs(summonResult) do
		local rewardData = PartyClothConfig.instance:getRewardData(info.groupId, info.index)

		if rewardData then
			PartyClothModel.instance:addClothMo(rewardData[2], rewardData[3])
		end
	end

	PartyClothController.instance:dispatchEvent(PartyClothEvent.ClothInfoUpdate)
	PartyClothController.instance:dispatchEvent(PartyClothEvent.SummonReply)
end

function PartyClothRpc:sendGetPartyClothInfoRequest()
	local req = PartyClothModule_pb.GetPartyClothInfoRequest()

	self:sendMsg(req)
end

function PartyClothRpc:onReceiveGetPartyClothInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local clothInfos = msg.clothInfos

	PartyClothModel.instance:updateClothInfo(clothInfos)
end

function PartyClothRpc:sendGetPartyWearInfoRequest()
	local req = PartyClothModule_pb.GetPartyWearInfoRequest()

	self:sendMsg(req)
end

function PartyClothRpc:onReceiveGetPartyWearInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local wearClothIds = msg.wearClothIds

	PartyClothModel.instance:updateWearClothIds(wearClothIds)
	PartyClothModel.instance:setInitMark(true)
	PartyClothController.instance:dispatchEvent(PartyClothEvent.GetWearInfoReply)
end

function PartyClothRpc:sendWearPartyClothsRequest(wearClothIds)
	local req = PartyClothModule_pb.WearPartyClothsRequest()

	for _, clothId in ipairs(wearClothIds) do
		table.insert(req.wearClothIds, clothId)
	end

	self:sendMsg(req)
end

function PartyClothRpc:onReceiveWearPartyClothsReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local wearClothIds = msg.wearClothIds

	PartyClothModel.instance:updateWearClothIds(wearClothIds)
end

PartyClothRpc.instance = PartyClothRpc.New()

return PartyClothRpc
