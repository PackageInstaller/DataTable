-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tongbattle/agent/PupilChallengeAgent.lua

module("logic.extensions.tongbattle.agent.PupilChallengeAgent", package.seeall)

local PupilChallengeAgent = class("PupilChallengeAgent", BaseAgent)

function PupilChallengeAgent:sendPM_PCGetMainBoardInfoReq(challengeId)
	local req = PupilChallengeExtension_pb.PM_PCGetMainBoardInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function PupilChallengeAgent:handlePM_PCGetMainBoardInfoRes(status, msg)
	if status == 0 then
		TongBattleController.instance:scSendTongBaseInfo(msg)
	end
end

function PupilChallengeAgent:sendPM_PCGetChallengeBoardInfoReq(challengeId)
	local req = PupilChallengeExtension_pb.PM_PCGetChallengeBoardInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function PupilChallengeAgent:handlePM_PCGetChallengeBoardInfoRes(status, msg)
	if status == 0 then
		TongBattleController.instance:scSendTongBattleInfo(msg)
	end
end

function PupilChallengeAgent:sendPM_PCGetChallengeBossInfoReq(challengeId, type)
	local req = PupilChallengeExtension_pb.PM_PCGetChallengeBossInfoReq()

	req.challengeId = challengeId
	req.type = type

	self:sendMsg(req)
end

function PupilChallengeAgent:handlePM_PCGetChallengeBossInfoRes(status, msg)
	if status == 0 then
		TongBattleController.instance:scSendTongBossInfo(msg)
	end
end

function PupilChallengeAgent:sendPM_PCChallengeStageReq(challengeId, challengeType, stage)
	local req = PupilChallengeExtension_pb.PM_PCChallengeStageReq()

	req.challengeId = challengeId
	req.challengeType = challengeType
	req.stage = stage

	self:sendMsg(req)
end

function PupilChallengeAgent:handlePM_PCChallengeStageRes(status, msg)
	if status ~= 0 then
		if ViewMgr.instance:isOpen(ViewName.TongMission) then
			UIStateManager.instance:clear(true)
		end
	else
		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.TongBattle, nil)
	end
end

function PupilChallengeAgent:sendPM_PCSetNewTurnsReq(challengeId, isReset, turns)
	local req = PupilChallengeExtension_pb.PM_PCSetNewTurnsReq()

	req.challengeId = challengeId
	req.isReset = isReset
	req.turns = turns

	self:sendMsg(req)
end

function PupilChallengeAgent:handlePM_PCSetNewTurnsRes(status, msg)
	if status == 0 then
		TongBattleController.instance:scSendTongStageRounds()
	else
		UIStateManager.instance:clear(true)
	end
end

function PupilChallengeAgent:sendPM_PCBuyChallengeTimesReq(challengeId)
	local req = PupilChallengeExtension_pb.PM_PCBuyChallengeTimesReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function PupilChallengeAgent:handlePM_PCBuyChallengeTimesRes(status, msg)
	if status == 0 then
		TongBattleController.instance:scSendTongBuyTimes(msg)
	end
end

function PupilChallengeAgent:sendPM_PCGetHellRankInfoReq(challengeId)
	local req = PupilChallengeExtension_pb.PM_PCGetHellRankInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function PupilChallengeAgent:handlePM_PCGetHellRankInfoRes(status, msg)
	if status == 0 then
		TongBattleController.instance:scSendTongRankInfoSuc(msg, false)
	end
end

function PupilChallengeAgent:handlePM_PCChallengeEndRes(status, msg)
	if status == 0 then
		TongBattleController.instance:scSendTongNotifyBattleEnd(msg)
	end
end

PupilChallengeAgent.instance = PupilChallengeAgent.New()

return PupilChallengeAgent
