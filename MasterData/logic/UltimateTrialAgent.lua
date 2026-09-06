-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatetrial/agent/UltimateTrialAgent.lua

module("logic.extensions.ultimatetrial.agent.UltimateTrialAgent", package.seeall)

local UltimateTrialAgent = class("UltimateTrialAgent", BaseAgent)

function UltimateTrialAgent:sendPM_UltimateTrialGetInfoReq(activityId)
	local req = UltimateTrialExtension_pb.PM_UltimateTrialGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function UltimateTrialAgent:handlePM_UltimateTrialGetInfoRes(status, msg)
	if status == 0 then
		UltimateTrialController.instance:handlePM_UltimateTrialGetInfoRes(msg)
	end
end

function UltimateTrialAgent:sendPM_UltimateTrialSignInReq(activityId)
	local req = UltimateTrialExtension_pb.PM_UltimateTrialSignInReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function UltimateTrialAgent:handlePM_UltimateTrialSignInRes(status, msg)
	if status == 0 then
		UltimateTrialController.instance:handlePM_UltimateTrialSignInRes(msg)
	end
end

function UltimateTrialAgent:sendPM_UltimateTrialGetTimeRankViewReq(activityId, clgActId)
	local req = UltimateTrialExtension_pb.PM_UltimateTrialGetTimeRankViewReq()

	req.activityId = activityId
	req.clgActId = clgActId

	self:sendMsg(req)
end

function UltimateTrialAgent:handlePM_UltimateTrialGetTimeRankViewRes(status, msg)
	if status == 0 then
		UltimateTrialController.instance:handlePM_UltimateTrialGetTimeRankViewRes(msg)
	end
end

function UltimateTrialAgent:sendPM_UltimateTrialGetScoreRankViewReq(activityId, clgActId)
	local req = UltimateTrialExtension_pb.PM_UltimateTrialGetScoreRankViewReq()

	req.activityId = activityId
	req.clgActId = clgActId

	self:sendMsg(req)
end

function UltimateTrialAgent:handlePM_UltimateTrialGetScoreRankViewRes(status, msg)
	if status == 0 then
		UltimateTrialController.instance:handlePM_UltimateTrialGetScoreRankViewRes(msg)
	end
end

UltimateTrialAgent.instance = UltimateTrialAgent.New()

return UltimateTrialAgent
