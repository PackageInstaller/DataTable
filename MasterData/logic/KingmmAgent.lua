-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmengmeng/agent/KingmmAgent.lua

module("logic.extensions.kingmengmeng.agent.KingmmAgent", package.seeall)

local KingmmAgent = class("KingmmAgent", BaseAgent)

function KingmmAgent:sendPM_KMMChallengeGetCommonInfoReq(activityId)
	local req = KingMengMengChallengeExtension_pb.PM_KMMChallengeGetCommonInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KingmmAgent:handlePM_KMMChallengeGetCommonInfoRes(status, msg)
	if status == 0 then
		KingmmModel.instance:onGetCommonInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.KMMChallengeGetCommonInfoRes)
	end
end

function KingmmAgent:sendPM_KMMChallengeCommonChallengeReq(activityId, form)
	local req = KingMengMengChallengeExtension_pb.PM_KMMChallengeCommonChallengeReq()

	req.activityId = activityId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function KingmmAgent:handlePM_KMMChallengeCommonChallengeRes(status, msg)
	if status == 0 then
		KingmmModel.instance:onCommonChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.KMMChallengeCommonChallengeRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function KingmmAgent:handlePM_KMMChallengeNotifyCommonChallengeRes(status, msg)
	if status == 0 then
		KingmmModel.instance:onNotifyCommonChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.KMMChallengeNotifyCommonChallengeRes, msg.activityId)
	end
end

function KingmmAgent:sendPM_KMMChallengeGetSocrePrizeReq(activityId, prizeId)
	local req = KingMengMengChallengeExtension_pb.PM_KMMChallengeGetSocrePrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function KingmmAgent:handlePM_KMMChallengeGetSocrePrizeRes(status, msg)
	if status == 0 then
		KingmmModel.instance:onGetSocrePrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.KMMChallengeGetSocrePrizeRes)
	end
end

function KingmmAgent:sendPM_KMMChallengeResetRandomInfoReq(activityId)
	local req = KingMengMengChallengeExtension_pb.PM_KMMChallengeResetRandomInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KingmmAgent:handlePM_KMMChallengeResetRandomInfoRes(status, msg)
	if status == 0 then
		KingmmModel.instance:onResetRandomInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.KMMChallengeResetRandomInfoRes)
	end
end

function KingmmAgent:sendPM_KMMChallengeGetExtremeInfoReq(activityId)
	local req = KingMengMengChallengeExtension_pb.PM_KMMChallengeGetExtremeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KingmmAgent:handlePM_KMMChallengeGetExtremeInfoRes(status, msg)
	if status == 0 then
		KingmmModel.instance:onGetExtremeInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.KMMChallengeGetExtremeInfoRes)
	end
end

function KingmmAgent:sendPM_KMMChallengeExtremeChallengeReq(activityId, type, stageId, form)
	local req = KingMengMengChallengeExtension_pb.PM_KMMChallengeExtremeChallengeReq()

	req.activityId = activityId
	req.type = type
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function KingmmAgent:handlePM_KMMChallengeExtremeChallengeRes(status, msg)
	if status == 0 then
		KingmmModel.instance:onExtremeChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.KMMChallengeExtremeChallengeRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function KingmmAgent:handlePM_KMMChallengeNotifyExtremeChallengeRes(status, msg)
	if status == 0 then
		KingmmModel.instance:onNotifyExtremeChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.KMMChallengeNotifyExtremeChallengeRes, msg.activityId, msg.type, msg.stageId)
	end
end

function KingmmAgent:sendPM_KMMChallengeResetGuardStageReq(activityId)
	local req = KingMengMengChallengeExtension_pb.PM_KMMChallengeResetGuardStageReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KingmmAgent:handlePM_KMMChallengeResetGuardStageRes(status, msg)
	if status == 0 then
		KingmmModel.instance:onResetGuardStageRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.KMMChallengeResetGuardStageRes)
	end
end

function KingmmAgent:sendPM_KMMChallengeGainPassPrizeReq(activityId)
	local req = KingMengMengChallengeExtension_pb.PM_KMMChallengeGainPassPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KingmmAgent:handlePM_KMMChallengeGainPassPrizeRes(status, msg)
	if status == 0 then
		KingmmModel.instance:onGainPassPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.KMMChallengeGainPassPrizeRes)
	end
end

KingmmAgent.instance = KingmmAgent.New()

return KingmmAgent
