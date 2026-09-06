-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/agent/FamilySummonCommandAgent.lua

module("logic.extensions.familysummoncommand.agent.FamilySummonCommandAgent", package.seeall)

local FamilySummonCommandAgent = class("FamilySummonCommandAgent", BaseAgent)

function FamilySummonCommandAgent:sendPM_FamilySummonCommandGetInfoReq(activityId)
	local req = FamilySummonCommandExtension_pb.PM_FamilySummonCommandGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FamilySummonCommandAgent:handlePM_FamilySummonCommandGetInfoRes(status, msg)
	if status == 0 then
		FamilyCallOrderModel.instance:setFamilSummonCommandGetInfo(msg)
		FamilyCallOrderController.instance:sendPM_FamilySummonCommandViewFamilyRankReq_TopThree()
		GlobalDispatcher:dispatch(GlobalNotify.FamilyCallOrder)
	end
end

function FamilySummonCommandAgent:sendPM_FamilySummonCommandGainPrizeReq(activityId, prizeId)
	local req = FamilySummonCommandExtension_pb.PM_FamilySummonCommandGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function FamilySummonCommandAgent:handlePM_FamilySummonCommandGainPrizeRes(status, msg)
	if status == 0 then
		FamilyCallOrderModel.instance:setFamilySummonCommandGainPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FamilyCallOrderPrize)
	end
end

function FamilySummonCommandAgent:sendPM_FamilySummonCommandViewFamilyRankReq(activityId, startRank, endRank)
	local req = FamilySummonCommandExtension_pb.PM_FamilySummonCommandViewFamilyRankReq()

	req.activityId = activityId
	req.startRank = startRank
	req.endRank = endRank

	self:sendMsg(req)
end

function FamilySummonCommandAgent:handlePM_FamilySummonCommandViewFamilyRankRes(status, msg)
	if status == 0 then
		FamilyCallOrderModel.instance:setFamilySummonCommandViewFamilyRank(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FamilyRankData)
	end
end

function FamilySummonCommandAgent:sendPM_FamilySummonCommandViewMemberRankReq(activityId)
	local req = FamilySummonCommandExtension_pb.PM_FamilySummonCommandViewMemberRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FamilySummonCommandAgent:handlePM_FamilySummonCommandViewMemberRankRes(status, msg)
	if status == 0 then
		FamilyCallOrderModel.instance:setFamilySummonCommandViewMemberRank(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FamilyRankData)
	end
end

FamilySummonCommandAgent.instance = FamilySummonCommandAgent.New()

return FamilySummonCommandAgent
