-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qichallenge/agent/QiChallengeAgent.lua

module("logic.extensions.qichallenge.agent.QiChallengeAgent", package.seeall)

local QiChallengeAgent = class("QiChallengeAgent", BaseAgent)

function QiChallengeAgent:sendPM_QiChallengeGetInfoReq(activityId)
	local req = QiChallengeExtension_pb.PM_QiChallengeGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function QiChallengeAgent:handlePM_QiChallengeGetInfoRes(status, msg)
	if status == 0 then
		QichallengeController.instance:handlePM_QiChallengeGetInfoRes(msg)
	end
end

function QiChallengeAgent:sendPM_QiChallengeAllSealReq(activityId, raceIds)
	local req = QiChallengeExtension_pb.PM_QiChallengeAllSealReq()

	req.activityId = activityId

	for i, v in ipairs(raceIds) do
		req.raceIds:append(v)
	end

	self:sendMsg(req)
end

function QiChallengeAgent:handlePM_QiChallengeAllSealRes(status, msg)
	if status == 0 then
		QichallengeController.instance:handlePM_QiChallengeAllSealRes(msg)
	end
end

function QiChallengeAgent:sendPM_QiChallengeAllReq(activityId, challengeId, form)
	local req = QiChallengeExtension_pb.PM_QiChallengeAllReq()

	req.activityId = activityId
	req.challengeId = challengeId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function QiChallengeAgent:handlePM_QiChallengeAllRes(status, msg)
	if status == 0 then
		QichallengeController.instance:handlePM_QiChallengeAllRes(msg)
	end
end

function QiChallengeAgent:handlePM_QiChallengeAllResultRes(status, msg)
	if status == 0 then
		QichallengeController.instance:handlePM_QiChallengeAllResultRes(msg)
	end
end

function QiChallengeAgent:sendPM_QiChallengeExtremeResetReq(activityId)
	local req = QiChallengeExtension_pb.PM_QiChallengeExtremeResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function QiChallengeAgent:handlePM_QiChallengeExtremeResetRes(status, msg)
	if status == 0 then
		QichallengeController.instance:handlePM_QiChallengeExtremeResetRes(msg)
	end
end

function QiChallengeAgent:sendPM_QiChallengeExtremeReq(activityId, challengeId, form)
	local req = QiChallengeExtension_pb.PM_QiChallengeExtremeReq()

	req.activityId = activityId
	req.challengeId = challengeId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function QiChallengeAgent:handlePM_QiChallengeExtremeRes(status, msg)
	if status == 0 then
		QichallengeController.instance:handlePM_QiChallengeExtremeRes(msg)
	end
end

function QiChallengeAgent:handlePM_QiChallengeExtremeResultRes(status, msg)
	if status == 0 then
		QichallengeController.instance:handlePM_QiChallengeExtremeResultRes(msg)
	end
end

QiChallengeAgent.instance = QiChallengeAgent.New()

return QiChallengeAgent
