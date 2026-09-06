-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/honourtower/agent/HonorTowerAgent.lua

module("logic.extensions.honortower.agent.HonorTowerAgent", package.seeall)

local HonorTowerAgent = class("HonorTowerAgent", BaseAgent)

HonorTowerAgent.HonorTowerInfoRes = "HonorTowerAgent.HonorTowerInfoRes"
HonorTowerAgent.HonorTowerChallengeRes = "HonorTowerAgent.HonorTowerChallengeRes"
HonorTowerAgent.HonorTowerSelectRecallChallengeRes = "HonorTowerAgent.HonorTowerSelectRecallChallengeRes"
HonorTowerAgent.HonorTowerRankViewRes = "HonorTowerAgent.HonorTowerRankViewRes"
HonorTowerAgent.NotifyHonorTowerChallengeFinishRes = "HonorTowerAgent.NotifyHonorTowerChallengeFinishRes"

function HonorTowerAgent:sendPM_HonorTowerInfoReq(periodId)
	local req = HonorTowerExtension_pb.PM_HonorTowerInfoReq()

	req.periodId = periodId

	self:sendMsg(req)
end

function HonorTowerAgent:handlePM_HonorTowerInfoRes(status, msg)
	if status == 0 then
		HonourTowerModel.instance:setInfo(msg)
		HonourTowerController.instance:calRedPoint()
		GlobalDispatcher:dispatch(HonorTowerAgent.HonorTowerInfoRes)
	end
end

function HonorTowerAgent:sendPM_HonorTowerChallengeReq(periodId, challengeId, stageId, form)
	local req = HonorTowerExtension_pb.PM_HonorTowerChallengeReq()

	req.periodId = periodId
	req.challengeId = challengeId
	req.stageId = stageId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function HonorTowerAgent:handlePM_HonorTowerChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HonorTowerAgent.HonorTowerChallengeRes)
	elseif SceneMgr.instance.isGogingToEnterBattleScene then
		BattleFacade.instance:endBattle()
	end
end

function HonorTowerAgent:sendPM_HonorTowerSelectRecallChallengeReq(periodId, challengeId)
	local req = HonorTowerExtension_pb.PM_HonorTowerSelectRecallChallengeReq()

	req.periodId = periodId
	req.challengeId = challengeId

	self:sendMsg(req)
end

function HonorTowerAgent:handlePM_HonorTowerSelectRecallChallengeRes(status, msg)
	if status == 0 then
		HonourTowerModel.instance:setRegressChallengeId(msg.periodId, msg.challengeId)
		self:sendPM_HonorTowerInfoReq(msg.periodId)
		GlobalDispatcher:dispatch(HonorTowerAgent.HonorTowerSelectRecallChallengeRes)
	end
end

function HonorTowerAgent:sendPM_HonorTowerRankViewReq(challengeId)
	local req = HonorTowerExtension_pb.PM_HonorTowerRankViewReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function HonorTowerAgent:handlePM_HonorTowerRankViewRes(status, msg)
	if status == 0 then
		HonourTowerController.instance:handlePM_GloryTowerGetRankViewRes(msg)
		GlobalDispatcher:dispatch(HonorTowerAgent.HonorTowerRankViewRes)
	end
end

function HonorTowerAgent:handlePM_NotifyHonorTowerChallengeFinishRes(status, msg)
	if status == 0 then
		HonourTowerController.instance:notifyHonorTowerChallengeFinishRes(msg)
		GlobalDispatcher:dispatch(HonorTowerAgent.NotifyHonorTowerChallengeFinishRes)
	end
end

HonorTowerAgent.instance = HonorTowerAgent.New()

return HonorTowerAgent
