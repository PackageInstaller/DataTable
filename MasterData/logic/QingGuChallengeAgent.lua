-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/agent/QingGuChallengeAgent.lua

module("logic.extensions.qingguchallenge.agent.QingGuChallengeAgent", package.seeall)

local QingGuChallengeAgent = class("QingGuChallengeAgent", BaseAgent)

function QingGuChallengeAgent:ctor()
	return
end

function QingGuChallengeAgent:setExtId(extId)
	QingGuChallengeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function QingGuChallengeAgent:sendPM_QingGuChallengeGetInfoReq(activityId)
	local req = QingGuChallengeExtension_pb.PM_QingGuChallengeGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function QingGuChallengeAgent:handlePM_QingGuChallengeGetInfoRes(status, msg)
	if status == 0 then
		LounaController.instance:onGetInfo(msg)
	end
end

function QingGuChallengeAgent:sendPM_QingGuChallengeReq(activityId, creepsMasterId, form_pb)
	local req = QingGuChallengeExtension_pb.PM_QingGuChallengeReq()

	req.activityId = activityId
	req.creepsMasterId = creepsMasterId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function QingGuChallengeAgent:handlePM_QingGuChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function QingGuChallengeAgent:sendPM_QingGuChallengeResetReq(activityId)
	local req = QingGuChallengeExtension_pb.PM_QingGuChallengeResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function QingGuChallengeAgent:handlePM_QingGuChallengeResetRes(status, msg)
	if status == 0 then
		LounaController.instance:onResetChallenge(msg)
	end
end

function QingGuChallengeAgent:sendPM_QingGuChallengeGainPrizeReq(activityId, prizeId)
	local req = QingGuChallengeExtension_pb.PM_QingGuChallengeGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function QingGuChallengeAgent:handlePM_QingGuChallengeGainPrizeRes(status, msg)
	if status == 0 then
		LounaController.instance:onGetPrize(msg)
	end
end

function QingGuChallengeAgent:handlePM_QingGuChallengeResultRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.ON_LOUNA_FIGHT_END, msg)
end

QingGuChallengeAgent.instance = QingGuChallengeAgent.New()

return QingGuChallengeAgent
