-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/agent/TianQiKingDragonAgent.lua

module("logic.extensions.kingdragonchallenge.agent.TianQiKingDragonAgent", package.seeall)

local TianQiKingDragonAgent = class("TianQiKingDragonAgent", BaseAgent)

function TianQiKingDragonAgent:sendPM_TQKingDragonGetInfoReq(challengeId)
	local req = TianQiKingDragonExtension_pb.PM_TQKingDragonGetInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function TianQiKingDragonAgent:handlePM_TQKingDragonGetInfoRes(status, msg)
	if status == 0 then
		KdChallengeController.instance:handlePM_TQKingDragonGetInfoRes(msg)
	end
end

function TianQiKingDragonAgent:sendPM_TQKingDragonBossClgReq(challengeId, simpleForm)
	local req = TianQiKingDragonExtension_pb.PM_TQKingDragonBossClgReq()

	req.challengeId = challengeId

	req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	self:sendMsg(req)
end

function TianQiKingDragonAgent:handlePM_TQKingDragonBossClgRes(status, msg)
	KdChallengeController.instance:handlePM_TQKingDragonBossClgRes(status, msg)
end

function TianQiKingDragonAgent:sendPM_TQKingDragonBossSweepReq(challengeId)
	local req = TianQiKingDragonExtension_pb.PM_TQKingDragonBossSweepReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function TianQiKingDragonAgent:handlePM_TQKingDragonBossSweepRes(status, msg)
	if status == 0 then
		KdChallengeController.instance:handlePM_TQKingDragonBossSweepRes(msg)
	end
end

function TianQiKingDragonAgent:sendPM_TQKingDragonResultConfirmReq(challengeId, type)
	local req = TianQiKingDragonExtension_pb.PM_TQKingDragonResultConfirmReq()

	req.challengeId = challengeId
	req.type = type

	self:sendMsg(req)
end

function TianQiKingDragonAgent:handlePM_TQKingDragonResultConfirmRes(status, msg)
	if status == 0 then
		KdChallengeController.instance:handlePM_TQKingDragonResultConfirmRes(msg)
	end
end

function TianQiKingDragonAgent:sendPM_TQKingDragonBossGetPrizeReq(challengeId, prizeId)
	local req = TianQiKingDragonExtension_pb.PM_TQKingDragonBossGetPrizeReq()

	req.challengeId = challengeId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function TianQiKingDragonAgent:handlePM_TQKingDragonBossGetPrizeRes(status, msg)
	if status == 0 then
		KdChallengeController.instance:handlePM_TQKingDragonBossGetPrizeRes(msg)
	end
end

function TianQiKingDragonAgent:sendPM_TQKingDragonBossBuyReq(challengeId)
	local req = TianQiKingDragonExtension_pb.PM_TQKingDragonBossBuyReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function TianQiKingDragonAgent:handlePM_TQKingDragonBossBuyRes(status, msg)
	if status == 0 then
		KdChallengeController.instance:handlePM_TQKingDragonBossBuyRes(msg)
	end
end

function TianQiKingDragonAgent:sendPM_TQKingDragonUnitClgReq(challengeId, unitId, simpleForm)
	local req = TianQiKingDragonExtension_pb.PM_TQKingDragonUnitClgReq()

	req.challengeId = challengeId
	req.unitId = unitId

	req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	self:sendMsg(req)
end

function TianQiKingDragonAgent:handlePM_TQKingDragonUnitClgRes(status, msg)
	KdChallengeController.instance:handlePM_TQKingDragonUnitClgRes(status, msg)
end

function TianQiKingDragonAgent:handlePM_TQKingDragonUnitBattleEndRes(status, msg)
	if status == 0 then
		KdChallengeController.instance:handlePM_TQKingDragonUnitBattleEndRes(msg)
	end
end

function TianQiKingDragonAgent:sendPM_TQKingDragonUnitResetReq(challengeId)
	local req = TianQiKingDragonExtension_pb.PM_TQKingDragonUnitResetReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function TianQiKingDragonAgent:handlePM_TQKingDragonUnitResetRes(status, msg)
	if status == 0 then
		KdChallengeController.instance:handlePM_TQKingDragonUnitResetRes(msg)
	end
end

function TianQiKingDragonAgent:sendPM_TQKingDragonStageClgReq(challengeId, stageId, simpleForm)
	local req = TianQiKingDragonExtension_pb.PM_TQKingDragonStageClgReq()

	req.challengeId = challengeId
	req.stageId = stageId

	req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	self:sendMsg(req)
end

function TianQiKingDragonAgent:handlePM_TQKingDragonStageClgRes(status, msg)
	KdChallengeController.instance:handlePM_TQKingDragonStageClgRes(status, msg)
end

function TianQiKingDragonAgent:sendPM_TQKingDragonStageResetReq(challengeId)
	local req = TianQiKingDragonExtension_pb.PM_TQKingDragonStageResetReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function TianQiKingDragonAgent:handlePM_TQKingDragonStageResetRes(status, msg)
	if status == 0 then
		KdChallengeController.instance:handlePM_TQKingDragonStageResetRes(msg)
	end
end

function TianQiKingDragonAgent:sendPM_TQKingDragonStageForcePrizeReq(challengeId)
	local req = TianQiKingDragonExtension_pb.PM_TQKingDragonStageForcePrizeReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function TianQiKingDragonAgent:handlePM_TQKingDragonStageForcePrizeRes(status, msg)
	if status == 0 then
		KdChallengeController.instance:handlePM_TQKingDragonStageForcePrizeRes(msg)
	end
end

function TianQiKingDragonAgent:handlePM_TQKingDragonStageBattleWinRes(status, msg)
	if status == 0 then
		KdChallengeController.instance:handlePM_TQKingDragonStageBattleWinRes(msg)
	end
end

function TianQiKingDragonAgent:sendPM_TQKingDragonBossRankReq(challengeId)
	local req = TianQiKingDragonExtension_pb.PM_TQKingDragonBossRankReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function TianQiKingDragonAgent:handlePM_TQKingDragonBossRankRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function TianQiKingDragonAgent:sendPM_TQKingDragonGetLoginTaskPrizeReq(challengeId, days)
	local req = TianQiKingDragonExtension_pb.PM_TQKingDragonGetLoginTaskPrizeReq()

	req.challengeId = challengeId
	req.days = days

	self:sendMsg(req)
end

function TianQiKingDragonAgent:handlePM_TQKingDragonGetLoginTaskPrizeRes(status, msg)
	if status == 0 then
		local days = msg.days

		KdChallengeController.instance:handlePM_TQKingDragonGetLoginTaskPrizeRes(days)
	end
end

TianQiKingDragonAgent.instance = TianQiKingDragonAgent.New()

return TianQiKingDragonAgent
