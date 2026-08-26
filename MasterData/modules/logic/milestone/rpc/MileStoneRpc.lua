-- chunkname: @modules/logic/milestone/rpc/MileStoneRpc.lua

module("modules.logic.milestone.rpc.MileStoneRpc", package.seeall)

local MileStoneRpc = class("MileStoneRpc", BaseRpc)

function MileStoneRpc:sendGetMilestoneInfoRequest(ids, callback, callbackObj)
	local req = MilestoneModule_pb.GetMilestoneInfoRequest()

	for _, v in ipairs(ids) do
		table.insert(req.milestoneIds, v)
	end

	self:sendMsg(req, callback, callbackObj)
end

function MileStoneRpc:onReceiveGetMilestoneInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	MileStoneModel.instance:updateInfos(msg.milestoneInfos)
	MileStoneController.instance:dispatchEvent(MileStoneEvent.OnUpdateInfo)
end

function MileStoneRpc:sendGetMilestoneBonusRequest(milestoneId, callback, callbackObj)
	local req = MilestoneModule_pb.GetMilestoneBonusRequest()

	req.milestoneId = milestoneId

	self:sendMsg(req, callback, callbackObj)
end

function MileStoneRpc:onReceiveGetMilestoneBonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	MileStoneModel.instance:updateBonusInfo(msg)
	MileStoneController.instance:dispatchEvent(MileStoneEvent.onGetBonus, msg.milestoneId)
end

MileStoneRpc.instance = MileStoneRpc.New()

return MileStoneRpc
