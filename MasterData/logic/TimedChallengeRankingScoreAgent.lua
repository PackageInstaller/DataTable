-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/agent/TimedChallengeRankingScoreAgent.lua

module("logic.extensions.timedchallengerankingscore.agent.TimedChallengeRankingScoreAgent", package.seeall)

local TimedChallengeRankingScoreAgent = class("TimedChallengeRankingScoreAgent", BaseAgent)

function TimedChallengeRankingScoreAgent:sendPM_TimedChallengeRankingScoreInfoReq(challengeId)
	local req = TimedChallengeRankingScoreExtension_pb.PM_TimedChallengeRankingScoreInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function TimedChallengeRankingScoreAgent:handlePM_TimedChallengeRankingScoreInfoRes(status, msg)
	if status == 0 then
		TimedPointRaceModeController.instance:handleGetInfo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.TimedPointRaceModeError, status)
		printInfo("限时挑战积分模式模式报错：" .. status)
	end
end

function TimedChallengeRankingScoreAgent:sendPM_TimedChallengeRankingScoreFightReq(challengeId)
	local req = TimedChallengeRankingScoreExtension_pb.PM_TimedChallengeRankingScoreFightReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function TimedChallengeRankingScoreAgent:handlePM_TimedChallengeRankingScoreFightRes(status, msg)
	if status == 0 then
		TimedPointRaceModeController.instance:handleBossChallenge(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.TimedPointRaceModeError, status)
		printInfo("限时挑战积分模式模式报错：" .. status)
	end
end

function TimedChallengeRankingScoreAgent:sendPM_TimedChallengeRankingScoreBuyBossTimesReq(challengeId)
	local req = TimedChallengeRankingScoreExtension_pb.PM_TimedChallengeRankingScoreBuyBossTimesReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function TimedChallengeRankingScoreAgent:handlePM_TimedChallengeRankingScoreBuyBossTimesRes(status, msg)
	if status == 0 then
		TimedPointRaceModeController.instance:handleBuyBossChallengeTime(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.TimedPointRaceModeError, status)
		printInfo("限时挑战积分模式模式报错：" .. status)
	end
end

function TimedChallengeRankingScoreAgent:sendPM_TimedChallengeRankingScoreBuffFightReq(challengeId, buffType)
	local req = TimedChallengeRankingScoreExtension_pb.PM_TimedChallengeRankingScoreBuffFightReq()

	req.challengeId = challengeId
	req.buffType = buffType

	self:sendMsg(req)
end

function TimedChallengeRankingScoreAgent:handlePM_TimedChallengeRankingScoreBuffFightRes(status, msg)
	if status == 0 then
		TimedPointRaceModeController.instance:handleBuffChallenge(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.TimedPointRaceModeError, status)
		printInfo("限时挑战积分模式模式报错：" .. status)
	end
end

function TimedChallengeRankingScoreAgent:sendPM_TimedChallengeRankingScoreBuyBuffTimesReq(challengeId)
	local req = TimedChallengeRankingScoreExtension_pb.PM_TimedChallengeRankingScoreBuyBuffTimesReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function TimedChallengeRankingScoreAgent:handlePM_TimedChallengeRankingScoreBuyBuffTimesRes(status, msg)
	if status == 0 then
		TimedPointRaceModeController.instance:handleBuyBuffChallengeTime(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.TimedPointRaceModeError, status)
		printInfo("限时挑战积分模式模式报错：" .. status)
	end
end

function TimedChallengeRankingScoreAgent:sendPM_TimedChallengeRankingScoreGainPrizeReq(challengeId, prizeId)
	local req = TimedChallengeRankingScoreExtension_pb.PM_TimedChallengeRankingScoreGainPrizeReq()

	req.challengeId = challengeId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function TimedChallengeRankingScoreAgent:handlePM_TimedChallengeRankingScoreGainPrizeRes(status, msg)
	if status == 0 then
		TimedPointRaceModeController.instance:handleGainPrize(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.TimedPointRaceModeError, status)
		printInfo("限时挑战积分模式模式报错：" .. status)
	end
end

function TimedChallengeRankingScoreAgent:handlePM_NotifyTimedChallengeRankingScoreFinishRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.TimedPointRaceModeError, status)
		printInfo("限时挑战积分模式模式报错：" .. status)
	end
end

function TimedChallengeRankingScoreAgent:sendPM_TimedChallengeRankingScoreViewTotalRankReq(challengeId)
	local req = TimedChallengeRankingScoreExtension_pb.PM_TimedChallengeRankingScoreViewTotalRankReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function TimedChallengeRankingScoreAgent:handlePM_TimedChallengeRankingScoreViewTotalRankRes(status, msg)
	if status == 0 then
		TimedPointRaceModeController.instance:handleGainTotalRankInfo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.TimedPointRaceModeError, status)
		printInfo("限时挑战积分模式模式报错：" .. status)
	end
end

function TimedChallengeRankingScoreAgent:sendPM_TimedChallengeRankingScoreViewDailyRankReq(challengeId)
	local req = TimedChallengeRankingScoreExtension_pb.PM_TimedChallengeRankingScoreViewDailyRankReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function TimedChallengeRankingScoreAgent:handlePM_TimedChallengeRankingScoreViewDailyRankRes(status, msg)
	if status == 0 then
		TimedPointRaceModeController.instance:handleGainDailyRankInfo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.TimedPointRaceModeError, status)
		printInfo("限时挑战积分模式模式报错：" .. status)
	end
end

function TimedChallengeRankingScoreAgent:handlePM_TimedChallengeRankingScoreNotifyBossFightSucRes(status, msg)
	if status == 0 then
		TimedPointRaceModeController.instance:handleNotifyBossBattleSuc(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.TimedPointRaceModeError, status)
		printInfo("限时挑战积分模式模式报错：" .. status)
	end
end

function TimedChallengeRankingScoreAgent:handlePM_TimedChallengeRankingScoreNotifyBuffFightSucRes(status, msg)
	if status == 0 then
		TimedPointRaceModeController.instance:handleNotifyBuffBattleSuc(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.TimedPointRaceModeError, status)
		printInfo("限时挑战积分模式模式报错：" .. status)
	end
end

TimedChallengeRankingScoreAgent.instance = TimedChallengeRankingScoreAgent.New()

return TimedChallengeRankingScoreAgent
