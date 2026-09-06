-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalegod/agent/FemaleGodAgent.lua

module("logic.extensions.femalegod.agent.FemaleGodAgent", package.seeall)

local FemaleGodAgent = class("FemaleGodAgent", BaseAgent)

function FemaleGodAgent:sendPM_InflationMoneyGetInfoReq(activityId)
	local req = InflationMoneyExtension_pb.PM_InflationMoneyGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FemaleGodAgent:handlePM_InflationMoneyGetInfoRes(status, msg)
	if status == 0 then
		FemaleGodController.instance:handlePM_InflationMoneyGetInfoRes(msg)
	end
end

function FemaleGodAgent:sendPM_InflationMoneyGainOncePrizeReq(activityId)
	local req = InflationMoneyExtension_pb.PM_InflationMoneyGainOncePrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FemaleGodAgent:handlePM_InflationMoneyGainOncePrizeRes(status, msg)
	if status == 0 then
		FemaleGodController.instance:handlePM_InflationMoneyGainOncePrizeRes(msg)
	end
end

function FemaleGodAgent:sendPM_InflationMoneyGainProgressPrizeReq(activityId, prizeId)
	local req = InflationMoneyExtension_pb.PM_InflationMoneyGainProgressPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function FemaleGodAgent:handlePM_InflationMoneyGainProgressPrizeRes(status, msg)
	if status == 0 then
		FemaleGodController.instance:handlePM_InflationMoneyGainProgressPrizeRes(msg)
	end
end

FemaleGodAgent.instance = FemaleGodAgent.New()

return FemaleGodAgent
