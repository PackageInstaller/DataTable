-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doubleeleven/agent/RebateMallAgent.lua

module("logic.extensions.doubleeleven.agent.RebateMallAgent", package.seeall)

local RebateMallAgent = class("RebateMallAgent", BaseAgent)

function RebateMallAgent:sendPM_RebateMallPeriod1InfoReq(activityId)
	local req = RebateMallExtension_pb.PM_RebateMallPeriod1InfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function RebateMallAgent:handlePM_RebateMallPeriod1InfoRes(status, msg)
	if status == 0 then
		RebateMallController.instance:handlePM_RebateMallPeriod1InfoRes(status, msg)
	end
end

function RebateMallAgent:sendPM_RebateMallPeriod2InfoReq(activityId)
	local req = RebateMallExtension_pb.PM_RebateMallPeriod2InfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function RebateMallAgent:handlePM_RebateMallPeriod2InfoRes(status, msg)
	if status == 0 then
		RebateMallController.instance:handlePM_RebateMallPeriod2InfoRes(status, msg)
	end
end

function RebateMallAgent:sendPM_RebateMallGainPrizeReq(activityId, prizeId)
	local req = RebateMallExtension_pb.PM_RebateMallGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function RebateMallAgent:handlePM_RebateMallGainPrizeRes(status, msg)
	if status == 0 then
		RebateMallController.instance:handlePM_RebateMallGainPrizeRes(status, msg)
	end
end

function RebateMallAgent:sendPM_RebateMallBuyReq(activityId, itemId, deduceCount)
	local req = RebateMallExtension_pb.PM_RebateMallBuyReq()

	req.activityId = activityId
	req.itemId = itemId
	req.deduceCount = deduceCount

	self:sendMsg(req)
end

function RebateMallAgent:handlePM_RebateMallBuyRes(status, msg)
	if status == 0 then
		RebateMallController.instance:handlePM_RebateMallBuyRes(status, msg)
	end
end

RebateMallAgent.instance = RebateMallAgent.New()

return RebateMallAgent
