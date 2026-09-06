-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/agent/FirePowerContestAgent.lua

module("logic.extensions.firepowercontest.agent.FirePowerContestAgent", package.seeall)

local FirePowerContestAgent = class("FirePowerContestAgent", BaseAgent)

function FirePowerContestAgent:sendPM_GetFirePowerContestInfoReq(actId)
	local req = FirePowerContestExtension_pb.PM_GetFirePowerContestInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function FirePowerContestAgent:handlePM_GetFirePowerContestInfoRes(status, msg)
	FirePowerContestController.instance:handleGetInfo(status, msg)
end

function FirePowerContestAgent:sendPM_FPCGetGameRecordReq(actId)
	local req = FirePowerContestExtension_pb.PM_FPCGetGameRecordReq()

	req.actId = actId

	self:sendMsg(req)
end

function FirePowerContestAgent:handlePM_FPCGetGameRecordRes(status, msg)
	FirePowerContestController.instance:handleRecord(status, msg)
end

function FirePowerContestAgent:sendPM_FPCGainScorePrizeReq(actId, prizeId)
	local req = FirePowerContestExtension_pb.PM_FPCGainScorePrizeReq()

	req.actId = actId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function FirePowerContestAgent:handlePM_FPCGainScorePrizeRes(status, msg)
	FirePowerContestController.instance:handleGainPrize(status, msg)
end

function FirePowerContestAgent:sendPM_FPCBeginMatchReq(actId)
	local req = FirePowerContestExtension_pb.PM_FPCBeginMatchReq()

	req.actId = actId

	self:sendMsg(req)
end

function FirePowerContestAgent:handlePM_FPCBeginMatchRes(status, msg)
	FirePowerContestController.instance:handleMatching(status, msg)
end

function FirePowerContestAgent:sendPM_FPCGameBeginReq()
	local req = FirePowerContestExtension_pb.PM_FPCGameBeginReq()

	self:sendMsg(req)
end

function FirePowerContestAgent:handlePM_FPCGameBeginRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function FirePowerContestAgent:sendPM_FPCCancelMatchReq()
	local req = FirePowerContestExtension_pb.PM_FPCCancelMatchReq()

	self:sendMsg(req)
end

function FirePowerContestAgent:handlePM_FPCCancelMatchRes(status, msg)
	FirePowerContestController.instance:handleCancelMatch(status, msg)
end

function FirePowerContestAgent:sendPM_FPCPreLaunchReq(angle, bulletId, lanuchTimes)
	local req = FirePowerContestExtension_pb.PM_FPCPreLaunchReq()

	req.angle = angle
	req.bulletId = bulletId
	req.lanuchTimes = lanuchTimes

	self:sendMsg(req)
end

function FirePowerContestAgent:handlePM_FPCPreLaunchRes(status, msg)
	return
end

function FirePowerContestAgent:sendPM_FPCLaunchReq(bulletId, posId)
	local req = FirePowerContestExtension_pb.PM_FPCLaunchReq()

	req.bulletId = bulletId
	req.posId = posId

	self:sendMsg(req)
end

function FirePowerContestAgent:handlePM_FPCLaunchRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function FirePowerContestAgent:sendPM_FPCLeaveGameReq()
	local req = FirePowerContestExtension_pb.PM_FPCLeaveGameReq()

	self:sendMsg(req)
end

function FirePowerContestAgent:handlePM_FPCLeaveGameRes(status, msg)
	FirePowerContestController.instance:handleLeaveGame(status, msg)
end

function FirePowerContestAgent:sendPM_FPCSweepReq(actId)
	local req = FirePowerContestExtension_pb.PM_FPCSweepReq()

	req.actId = actId

	self:sendMsg(req)
end

function FirePowerContestAgent:handlePM_FPCSweepRes(status, msg)
	if status == 0 then
		FirePowerContestController.instance:handlePM_FPCSweepRes(msg)
	end
end

function FirePowerContestAgent:handlePM_FPCNotifyMatchSucRes(status, msg)
	FirePowerContestController.instance:handleNotifyMatchFinish(status, msg)
end

function FirePowerContestAgent:handlePM_FPCNotifyGameStartRes(status, msg)
	FirePowerContestController.instance:handleNofityGameStart(status, msg)
end

function FirePowerContestAgent:handlePM_FPCNotifyGamePreLaunchRes(status, msg)
	FirePowerContestController.instance:handleNofityLaunch(status, msg)
end

function FirePowerContestAgent:handlePM_FPCNotifyGameAfterLaunchRes(status, msg)
	FirePowerContestController.instance:handleNofityHit(status, msg)
end

function FirePowerContestAgent:handlePM_FPCNextStageRes(status, msg)
	FirePowerContestController.instance:handleNofityGameNext(status, msg)
end

function FirePowerContestAgent:handlePM_FPCNotifyGameEndRes(status, msg)
	FirePowerContestController.instance:handleNofityGameEnd(status, msg)
end

function FirePowerContestAgent:sendPM_FPCAskNextStageReq(curStageId)
	local req = FirePowerContestExtension_pb.PM_FPCAskNextStageReq()

	req.curStageId = curStageId

	self:sendMsg(req)
end

function FirePowerContestAgent:handlePM_FPCAskNextStageRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function FirePowerContestAgent:handlePM_FPCAbortRes(status, msg)
	FirePowerContestController.instance:handleNofityAbort(status, msg)
end

function FirePowerContestAgent:handlePM_FPCNotifyLeaveGameRes(status, msg)
	FirePowerContestController.instance:handleNotifyLeaveGame(status, msg)
end

FirePowerContestAgent.instance = FirePowerContestAgent.New()

return FirePowerContestAgent
