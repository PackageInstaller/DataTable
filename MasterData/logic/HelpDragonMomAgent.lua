-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/helpdragonmom/agent/HelpDragonMomAgent.lua

module("logic.extensions.helpdragonmom.agent.HelpDragonMomAgent", package.seeall)

local HelpDragonMomAgent = class("HelpDragonMomAgent", BaseAgent)

function HelpDragonMomAgent:sendPM_HelpDragonMomGetInfoReq(activityId)
	local req = HelpDragonMomExtension_pb.PM_HelpDragonMomGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HelpDragonMomAgent:handlePM_HelpDragonMomGetInfoRes(status, msg)
	if status == 0 then
		HelpDragonMomModel.instance:onHelpDragonMomGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.HelpDragonMomGetInfoRes)
	end
end

function HelpDragonMomAgent:sendPM_HelpDragonMomChallengeReq(activityId, score)
	local req = HelpDragonMomExtension_pb.PM_HelpDragonMomChallengeReq()

	req.activityId = activityId
	req.score = score

	self:sendMsg(req)
end

function HelpDragonMomAgent:handlePM_HelpDragonMomChallengeRes(status, msg)
	if status == 0 then
		HelpDragonMomModel.instance:onHelpDragonMomChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.HelpDragonMomChallengeRes)
	end
end

function HelpDragonMomAgent:sendPM_HelpDragonMomSelfAwardReq(activityId, progress)
	local req = HelpDragonMomExtension_pb.PM_HelpDragonMomSelfAwardReq()

	req.activityId = activityId
	req.progress = progress

	self:sendMsg(req)
end

function HelpDragonMomAgent:handlePM_HelpDragonMomSelfAwardRes(status, msg)
	if status == 0 then
		HelpDragonMomModel.instance:onHelpDragonMomSelfAwardRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.HelpDragonMomSelfAwardRes)
	end
end

function HelpDragonMomAgent:sendPM_HelpDragonMomWorldAwardReq(activityId, progress)
	local req = HelpDragonMomExtension_pb.PM_HelpDragonMomWorldAwardReq()

	req.activityId = activityId
	req.progress = progress

	self:sendMsg(req)
end

function HelpDragonMomAgent:handlePM_HelpDragonMomWorldAwardRes(status, msg)
	if status == 0 then
		HelpDragonMomModel.instance:onHelpDragonMomWorldAwardRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.HelpDragonMomWorldAwardRes)
	end
end

HelpDragonMomAgent.instance = HelpDragonMomAgent.New()

return HelpDragonMomAgent
