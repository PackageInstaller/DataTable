-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingciyuanchallenge/agent/KingCiYuanChallengeAgent.lua

module("logic.extensions.kingciyuanchallenge.agent.KingCiYuanChallengeAgent", package.seeall)

local KingCiYuanChallengeAgent = class("KingCiYuanChallengeAgent", BaseAgent)

function KingCiYuanChallengeAgent:sendPM_KingCiYuanGetInfoReq(activityId)
	local req = KingCiYuanChallengeExtension_pb.PM_KingCiYuanGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KingCiYuanChallengeAgent:handlePM_KingCiYuanGetInfoRes(status, msg)
	KingCiYuanChallengeController.instance:handleKingCiYuanGetInfoRes(status, msg)
end

function KingCiYuanChallengeAgent:sendPM_KingCiYuanBossGetPrizeReq(activityId, prizeId)
	local req = KingCiYuanChallengeExtension_pb.PM_KingCiYuanBossGetPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function KingCiYuanChallengeAgent:handlePM_KingCiYuanBossGetPrizeRes(status, msg)
	KingCiYuanChallengeController.instance:handleKingCiYuanBossGetPrizeRes(status, msg)
end

function KingCiYuanChallengeAgent:sendPM_KingCiYuanBossBuyCountReq(activityId)
	local req = KingCiYuanChallengeExtension_pb.PM_KingCiYuanBossBuyCountReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KingCiYuanChallengeAgent:handlePM_KingCiYuanBossBuyCountRes(status, msg)
	KingCiYuanChallengeController.instance:handleKingCiYuanBossBuyCountRes(status, msg)
end

function KingCiYuanChallengeAgent:sendPM_KingCiYuanBossChallengeReq(activityId, simpleForm)
	local req = KingCiYuanChallengeExtension_pb.PM_KingCiYuanBossChallengeReq()

	req.activityId = activityId

	req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	self:sendMsg(req)
end

function KingCiYuanChallengeAgent:handlePM_KingCiYuanBossChallengeRes(status, msg)
	KingCiYuanChallengeController.instance:handleKingCiYuanBossChallengeRes(status, msg)
end

function KingCiYuanChallengeAgent:handlePM_KingCiYuanBossChallengeEndRes(status, msg)
	KingCiYuanChallengeController.instance:handleKingCiYuanBossChallengeEndRes(status, msg)
end

function KingCiYuanChallengeAgent:sendPM_KingCiYuanStageResetReq(activityId)
	local req = KingCiYuanChallengeExtension_pb.PM_KingCiYuanStageResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KingCiYuanChallengeAgent:handlePM_KingCiYuanStageResetRes(status, msg)
	KingCiYuanChallengeController.instance:handleKingCiYuanStageResetRes(status, msg)
end

function KingCiYuanChallengeAgent:sendPM_KingCiYuanStageChangeBuffReq(activityId)
	local req = KingCiYuanChallengeExtension_pb.PM_KingCiYuanStageChangeBuffReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KingCiYuanChallengeAgent:handlePM_KingCiYuanStageChangeBuffRes(status, msg)
	KingCiYuanChallengeController.instance:handleKingCiYuanStageChangeBuffRes(status, msg)
end

function KingCiYuanChallengeAgent:sendPM_KingCiYuanStageActionReq(activityId, stageId, selectBuff, simpleForm)
	local req = KingCiYuanChallengeExtension_pb.PM_KingCiYuanStageActionReq()

	req.activityId = activityId
	req.stageId = stageId
	req.selectBuff = selectBuff or 0

	if simpleForm then
		req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	end

	self:sendMsg(req)
end

function KingCiYuanChallengeAgent:handlePM_KingCiYuanStageActionRes(status, msg)
	KingCiYuanChallengeController.instance:handleKingCiYuanStageActionRes(status, msg)
end

function KingCiYuanChallengeAgent:handlePM_KingCiYuanStageActionEndRes(status, msg)
	KingCiYuanChallengeController.instance:handleKingCiYuanStageActionEndRes(status, msg)
end

function KingCiYuanChallengeAgent:handlePM_KingCiYuanStageFightRes(status, msg)
	KingCiYuanChallengeController.instance:handleKingCiYuanStageFightRes(status, msg)
end

function KingCiYuanChallengeAgent:sendPM_KingCiYuanFightResultConfirmReq(activityId, stageId)
	local req = KingCiYuanChallengeExtension_pb.PM_KingCiYuanFightResultConfirmReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function KingCiYuanChallengeAgent:handlePM_KingCiYuanFightResultConfirmRes(status, msg)
	KingCiYuanChallengeController.instance:handleKingCiYuanResultConfirmRes(status, msg)
end

KingCiYuanChallengeAgent.instance = KingCiYuanChallengeAgent.New()

return KingCiYuanChallengeAgent
