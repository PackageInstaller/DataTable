-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoldendragonclg/agent/OriginGoldenDragonClgAgent.lua

module("logic.extensions.origingoldendragonclg.agent.OriginGoldenDragonClgAgent", package.seeall)

local OriginGoldenDragonClgAgent = class("OriginGoldenDragonClgAgent", BaseAgent)

function OriginGoldenDragonClgAgent:sendPM_OriginGoldenDragonClgGetInfoReq(activityId)
	local req = OriginGoldenDragonClgExtension_pb.PM_OriginGoldenDragonClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginGoldenDragonClgAgent:handlePM_OriginGoldenDragonClgGetInfoRes(status, msg)
	if status == 0 then
		OriginGoldenDragonClgController.instance:handlePM_OriginGoldenDragonClgGetInfoRes(msg)
	end
end

function OriginGoldenDragonClgAgent:sendPM_OriginGoldenDragonClgChallengeStageReq(activityId, stageId, prophecyId, form_pb)
	local req = OriginGoldenDragonClgExtension_pb.PM_OriginGoldenDragonClgChallengeStageReq()

	req.activityId = activityId
	req.stageId = stageId
	req.prophecyId = prophecyId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginGoldenDragonClgAgent:handlePM_OriginGoldenDragonClgChallengeStageRes(status, msg)
	if status == 0 then
		OriginGoldenDragonClgController.instance:handlePM_OriginGoldenDragonClgChallengeStageRes(msg)
	else
		BattleFacade.instance:registerResultHandler(nil, nil)
	end
end

function OriginGoldenDragonClgAgent:sendPM_OriginGoldenDragonClgGainPrizeReq(activityId, prizeId)
	local req = OriginGoldenDragonClgExtension_pb.PM_OriginGoldenDragonClgGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function OriginGoldenDragonClgAgent:handlePM_OriginGoldenDragonClgGainPrizeRes(status, msg)
	if status == 0 then
		OriginGoldenDragonClgController.instance:handlePM_OriginGoldenDragonClgGainPrizeRes(msg)
	end
end

function OriginGoldenDragonClgAgent:sendPM_OriginGoldenDragonClgResetChallengeReq(activityId)
	local req = OriginGoldenDragonClgExtension_pb.PM_OriginGoldenDragonClgResetChallengeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginGoldenDragonClgAgent:handlePM_OriginGoldenDragonClgResetChallengeRes(status, msg)
	if status == 0 then
		OriginGoldenDragonClgController.instance:handlePM_OriginGoldenDragonClgResetChallengeRes(msg)
	end
end

function OriginGoldenDragonClgAgent:handlePM_OriginGoldenDragonClgNotifyStageResultRes(status, msg)
	if status == 0 then
		OriginGoldenDragonClgController.instance:handlePM_OriginGoldenDragonClgNotifyStageResultRes(msg)
	end
end

function OriginGoldenDragonClgAgent:sendPM_OriginGoldenDragonClgConfirmReq(activityId, stageId, save)
	local req = OriginGoldenDragonClgExtension_pb.PM_OriginGoldenDragonClgConfirmReq()

	req.activityId = activityId
	req.stageId = stageId
	req.save = save

	self:sendMsg(req)
end

function OriginGoldenDragonClgAgent:handlePM_OriginGoldenDragonClgConfirmRes(status, msg)
	if status == 0 then
		OriginGoldenDragonClgController.instance:handlePM_OriginGoldenDragonClgConfirmRes(msg)
	end
end

OriginGoldenDragonClgAgent.instance = OriginGoldenDragonClgAgent.New()

return OriginGoldenDragonClgAgent
