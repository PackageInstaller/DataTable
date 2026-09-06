-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starhall/agent/StarHallAgent.lua

module("logic.extensions.starhall.agent.StarHallAgent", package.seeall)

local StarHallAgent = class("StarHallAgent", BaseAgent)

function StarHallAgent:sendPM_StarHallInfoReq(activityId)
	local req = StarHallExtension_pb.PM_StarHallInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function StarHallAgent:handlePM_StarHallInfoRes(status, msg)
	if status == 0 then
		StarHallController.instance:handleGetInfo(msg)
	end
end

function StarHallAgent:sendPM_StarHallChallengeReq(activityId, stageId, difficultId, settlementId, number, form_pb)
	local req = StarHallExtension_pb.PM_StarHallChallengeReq()

	req.activityId = activityId
	req.stageId = stageId
	req.difficultId = difficultId
	req.settlementId = settlementId
	req.number = number

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function StarHallAgent:handlePM_StarHallChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function StarHallAgent:sendPM_StarHallResetReq(activityId, stageId)
	local req = StarHallExtension_pb.PM_StarHallResetReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function StarHallAgent:handlePM_StarHallResetRes(status, msg)
	if status == 0 then
		StarHallController.instance:handleResetStage(msg)
	end
end

function StarHallAgent:sendPM_StarHallRankInfoReq(activityId)
	local req = StarHallExtension_pb.PM_StarHallRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function StarHallAgent:handlePM_StarHallRankInfoRes(status, msg)
	if status == 0 then
		StarHallController.instance:handleGetRankInfo(msg)
	end
end

function StarHallAgent:handlePM_NotifyStarHallChallengeFinishRes(status, msg)
	if status == 0 then
		StarHallController.instance:handleNorifyFinishChallenge(msg)
	end
end

StarHallAgent.instance = StarHallAgent.New()

return StarHallAgent
