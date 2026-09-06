-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingjichallenge/agent/KingJiChallengeAgent.lua

module("logic.extensions.kingjichallenge.agent.KingJiChallengeAgent", package.seeall)

local KingJiChallengeAgent = class("KingJiChallengeAgent", BaseAgent)

KingJiChallengeAgent.KingJiChallengeGetInfoRes = "KingJiChallengeAgent.KingJiChallengeGetInfoRes"
KingJiChallengeAgent.KingJiChallengeChallengeRes = "KingJiChallengeAgent.KingJiChallengeChallengeRes"
KingJiChallengeAgent.KingJiChallengeGainPrizeRes = "KingJiChallengeAgent.KingJiChallengeGainPrizeRes"
KingJiChallengeAgent.KingJiChallengeResetRes = "KingJiChallengeAgent.KingJiChallengeResetRes"
KingJiChallengeAgent.KingJiChallengeNotifyChallengeRes = "KingJiChallengeAgent.KingJiChallengeNotifyChallengeRes"
KingJiChallengeAgent.KingJiChallengeSaveResultRes = "KingJiChallengeAgent.KingJiChallengeSaveResultRes"

function KingJiChallengeAgent:sendPM_KingJiChallengeGetInfoReq(actId)
	local req = KingJiChallengeExtension_pb.PM_KingJiChallengeGetInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function KingJiChallengeAgent:handlePM_KingJiChallengeGetInfoRes(status, msg)
	if status == 0 then
		KingjichallengeModel.instance:setInfo(msg)
		KingjichallengeController.instance:checkRedpoint()
		GlobalDispatcher:dispatch(KingJiChallengeAgent.KingJiChallengeGetInfoRes)
	end
end

function KingJiChallengeAgent:sendPM_KingJiChallengeChallengeReq(actId, type, stageId, extInfo, form)
	local req = KingJiChallengeExtension_pb.PM_KingJiChallengeChallengeReq()

	req.actId = actId
	req.type = type
	req.stageId = stageId

	if extInfo then
		req.extInfo = tostring(extInfo)
	end

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function KingJiChallengeAgent:handlePM_KingJiChallengeChallengeRes(status, msg)
	if status == 0 then
		KingjichallengeController.instance:checkRedpoint()
		GlobalDispatcher:dispatch(KingJiChallengeAgent.KingJiChallengeChallengeRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function KingJiChallengeAgent:handlePM_KingJiChallengeNotifyChallengeRes(status, msg)
	if status == 0 then
		KingjichallengeController.instance:notifyChallengeRes(msg)
		GlobalDispatcher:dispatch(KingJiChallengeAgent.KingJiChallengeNotifyChallengeRes)
	end
end

function KingJiChallengeAgent:sendPM_KingJiChallengeGainPrizeReq(actId, type, prizeId)
	local req = KingJiChallengeExtension_pb.PM_KingJiChallengeGainPrizeReq()

	req.actId = actId
	req.type = type
	req.prizeId = prizeId

	self:sendMsg(req)
end

function KingJiChallengeAgent:handlePM_KingJiChallengeGainPrizeRes(status, msg)
	if status == 0 then
		KingjichallengeModel.instance:gainPrizeRes(msg)
		KingjichallengeController.instance:checkRedpoint()
		GlobalDispatcher:dispatch(KingJiChallengeAgent.KingJiChallengeGainPrizeRes)
	end
end

function KingJiChallengeAgent:sendPM_KingJiChallengeResetReq(actId, stageId)
	local req = KingJiChallengeExtension_pb.PM_KingJiChallengeResetReq()

	req.actId = actId
	req.stageId = stageId

	self:sendMsg(req)
end

function KingJiChallengeAgent:handlePM_KingJiChallengeResetRes(status, msg)
	if status == 0 then
		KingjichallengeModel.instance:challengeResetRes(msg)
		GlobalDispatcher:dispatch(KingJiChallengeAgent.KingJiChallengeResetRes)
	end
end

function KingJiChallengeAgent:sendPM_KingJiChallengeSaveResultReq(actId, stageId, creepsMasterId, isSave)
	local req = KingJiChallengeExtension_pb.PM_KingJiChallengeSaveResultReq()

	req.actId = actId
	req.stageId = stageId
	req.creepsMasterId = creepsMasterId
	req.isSave = isSave

	self:sendMsg(req)
end

function KingJiChallengeAgent:handlePM_KingJiChallengeSaveResultRes(status, msg)
	if status == 0 then
		KingjichallengeController.instance:saveMixMsg(msg.mixStage)
		GlobalDispatcher:dispatch(KingJiChallengeAgent.KingJiChallengeSaveResultRes)
	end
end

KingJiChallengeAgent.instance = KingJiChallengeAgent.New()

return KingJiChallengeAgent
