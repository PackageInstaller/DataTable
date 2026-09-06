-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/agent/SunWuKongChallengeAgent.lua

module("logic.extensions.sunwukongchallenge.agent.SunWuKongChallengeAgent", package.seeall)

local SunWuKongChallengeAgent = class("SunWuKongChallengeAgent", BaseAgent)

SunWuKongChallengeAgent.PM_SunWuKongChallengeGetInfoRes = "SunWuKongChallengeAgent.PM_SunWuKongChallengeGetInfoRes"
SunWuKongChallengeAgent.PM_SunWuKongChallengeRes = "SunWuKongChallengeAgent.PM_SunWuKongChallengeRes"
SunWuKongChallengeAgent.PM_SunWuKongChallengeResultRes = "SunWuKongChallengeAgent.PM_SunWuKongChallengeResultRes"
SunWuKongChallengeAgent.PM_SunWuKongChallengeDoHiddenTaskRes = "SunWuKongChallengeAgent.PM_SunWuKongChallengeDoHiddenTaskRes"
SunWuKongChallengeAgent.PM_SunWuKongChallengeStartGameRes = "SunWuKongChallengeAgent.PM_SunWuKongChallengeStartGameRes"
SunWuKongChallengeAgent.PM_SunWuKongChallengeEndGameRes = "SunWuKongChallengeAgent.PM_SunWuKongChallengeEndGameRes"
SunWuKongChallengeAgent.PM_SunWuKongChallengeGetCimeliaInfoRes = "SunWuKongChallengeAgent.PM_SunWuKongChallengeGetCimeliaInfoRes"
SunWuKongChallengeAgent.PM_SunWuKongChallengeUpgradeCimeliaRes = "SunWuKongChallengeAgent.PM_SunWuKongChallengeUpgradeCimeliaRes"
SunWuKongChallengeAgent.PM_SunWuKongChallengeResetCimeliaRes = "SunWuKongChallengeAgent.PM_SunWuKongChallengeResetCimeliaRes"

function SunWuKongChallengeAgent:sendPM_SunWuKongChallengeGetInfoReq(activityId)
	local req = SunWuKongChallengeExtension_pb.PM_SunWuKongChallengeGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SunWuKongChallengeAgent:handlePM_SunWuKongChallengeGetInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(SunWuKongChallengeAgent.PM_SunWuKongChallengeGetInfoRes, msg)
	end
end

function SunWuKongChallengeAgent:sendPM_SunWuKongChallengeReq(activityId, form, stageId)
	local req = SunWuKongChallengeExtension_pb.PM_SunWuKongChallengeReq()

	req.activityId = activityId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	if stageId then
		req.stageId = stageId
	end

	self:sendMsg(req)
end

function SunWuKongChallengeAgent:handlePM_SunWuKongChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(SunWuKongChallengeAgent.PM_SunWuKongChallengeRes, msg)
	end
end

function SunWuKongChallengeAgent:handlePM_SunWuKongChallengeResultRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(SunWuKongChallengeAgent.PM_SunWuKongChallengeResultRes, msg)
	end
end

function SunWuKongChallengeAgent:sendPM_SunWuKongChallengeDoHiddenTaskReq(activityId, stageId, params)
	local req = SunWuKongChallengeExtension_pb.PM_SunWuKongChallengeDoHiddenTaskReq()

	req.activityId = activityId
	req.stageId = stageId
	req.params = params

	self:sendMsg(req)
end

function SunWuKongChallengeAgent:handlePM_SunWuKongChallengeDoHiddenTaskRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(SunWuKongChallengeAgent.PM_SunWuKongChallengeDoHiddenTaskRes, msg)
	end
end

function SunWuKongChallengeAgent:sendPM_SunWuKongChallengeStartGameReq(activityId, stageId, clientKey)
	local req = SunWuKongChallengeExtension_pb.PM_SunWuKongChallengeStartGameReq()

	req.activityId = activityId
	req.stageId = stageId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function SunWuKongChallengeAgent:handlePM_SunWuKongChallengeStartGameRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(SunWuKongChallengeAgent.PM_SunWuKongChallengeStartGameRes, msg)
	end
end

function SunWuKongChallengeAgent:sendPM_SunWuKongChallengeEndGameReq(score, encryptedKey)
	local req = SunWuKongChallengeExtension_pb.PM_SunWuKongChallengeEndGameReq()

	req.score = score
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function SunWuKongChallengeAgent:handlePM_SunWuKongChallengeEndGameRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(SunWuKongChallengeAgent.PM_SunWuKongChallengeEndGameRes, msg)
	end
end

function SunWuKongChallengeAgent:sendPM_SunWuKongChallengeGetCimeliaInfoReq(activityId)
	local req = SunWuKongChallengeExtension_pb.PM_SunWuKongChallengeGetCimeliaInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SunWuKongChallengeAgent:handlePM_SunWuKongChallengeGetCimeliaInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(SunWuKongChallengeAgent.PM_SunWuKongChallengeGetCimeliaInfoRes, msg)
	end
end

function SunWuKongChallengeAgent:sendPM_SunWuKongChallengeUpgradeCimeliaReq(activityId, cimeliaId)
	local req = SunWuKongChallengeExtension_pb.PM_SunWuKongChallengeUpgradeCimeliaReq()

	req.activityId = activityId
	req.cimeliaId = cimeliaId

	self:sendMsg(req)
end

function SunWuKongChallengeAgent:handlePM_SunWuKongChallengeUpgradeCimeliaRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(SunWuKongChallengeAgent.PM_SunWuKongChallengeUpgradeCimeliaRes, msg)
	end
end

function SunWuKongChallengeAgent:sendPM_SunWuKongChallengeResetCimeliaReq(activityId, cimeliaId)
	local req = SunWuKongChallengeExtension_pb.PM_SunWuKongChallengeResetCimeliaReq()

	req.activityId = activityId
	req.cimeliaId = cimeliaId

	self:sendMsg(req)
end

function SunWuKongChallengeAgent:handlePM_SunWuKongChallengeResetCimeliaRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(SunWuKongChallengeAgent.PM_SunWuKongChallengeResetCimeliaRes, msg)
	end
end

function SunWuKongChallengeAgent:sendPM_SunWuKongChallengeGainDailyPrizeReq(activityId)
	local req = SunWuKongChallengeExtension_pb.PM_SunWuKongChallengeGainDailyPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SunWuKongChallengeAgent:handlePM_SunWuKongChallengeGainDailyPrizeRes(status, msg)
	if status == 0 then
		SunWuKongChallengeModel.instance:upateDailyPirze(msg)
		GlobalDispatcher:dispatch(GlobalNotify.PM_SunWuKongChallengeGetInfoRes)
	end
end

SunWuKongChallengeAgent.instance = SunWuKongChallengeAgent.New()

return SunWuKongChallengeAgent
