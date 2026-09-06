-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/festiveflower/agent/FestiveFlowerAgent.lua

module("logic.extensions.festiveflower.agent.FestiveFlowerAgent", package.seeall)

local FestiveFlowerAgent = class("FestiveFlowerAgent", BaseAgent)

function FestiveFlowerAgent:sendPM_FestiveFlowerInfoReq(activityId)
	local req = FestiveFlowerExtension_pb.PM_FestiveFlowerInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FestiveFlowerAgent:handlePM_FestiveFlowerInfoRes(status, msg)
	FestiveFlowerController.instance:handleFestiveFlowerInfoRes(status, msg)
end

function FestiveFlowerAgent:sendPM_FestiveFlowerFlowerInfoReq(activityId)
	local req = FestiveFlowerExtension_pb.PM_FestiveFlowerFlowerInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FestiveFlowerAgent:handlePM_FestiveFlowerFlowerInfoRes(status, msg)
	FestiveFlowerController.instance:handleFestiveFlowerFlowerInfoRes(status, msg)
end

function FestiveFlowerAgent:sendPM_FestiveFlowerFlowerGetRankReq(activityId)
	local req = FestiveFlowerExtension_pb.PM_FestiveFlowerFlowerGetRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FestiveFlowerAgent:handlePM_FestiveFlowerFlowerGetRankRes(status, msg)
	FestiveFlowerController.instance:handleFestiveFlowerFlowerGetRankRes(status, msg)
end

function FestiveFlowerAgent:sendPM_FestiveFlowerBuyFlowerReq(activityId, flowerId)
	local req = FestiveFlowerExtension_pb.PM_FestiveFlowerBuyFlowerReq()

	req.activityId = activityId
	req.flowerId = flowerId

	self:sendMsg(req)
end

function FestiveFlowerAgent:handlePM_FestiveFlowerBuyFlowerRes(status, msg)
	FestiveFlowerController.instance:handleFestiveFlowerBuyFlowerRes(status, msg)
end

function FestiveFlowerAgent:handlePM_NotifyGainFreeFlowerRes(status, msg)
	FestiveFlowerController.instance:handleNotifyGainFreeFlowerRes(status, msg)
end

function FestiveFlowerAgent:sendPM_FestiveFlowerGainPrizeReq(activityId, prizeId)
	local req = FestiveFlowerExtension_pb.PM_FestiveFlowerGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function FestiveFlowerAgent:handlePM_FestiveFlowerGainPrizeRes(status, msg)
	FestiveFlowerController.instance:handleFestiveFlowerGainPrizeRes(status, msg)
end

FestiveFlowerAgent.instance = FestiveFlowerAgent.New()

return FestiveFlowerAgent
