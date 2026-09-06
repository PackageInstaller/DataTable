-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/agent/PerfectRuleFightAgent.lua

module("logic.extensions.perfectrulefight.agent.PerfectRuleFightAgent", package.seeall)

local PerfectRuleFightAgent = class("PerfectRuleFightAgent", BaseAgent)

function PerfectRuleFightAgent:sendPM_PerfectRuleFightGetInfoReq(challengeId)
	local req = PerfectRuleFightExtension_pb.PM_PerfectRuleFightGetInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function PerfectRuleFightAgent:handlePM_PerfectRuleFightGetInfoRes(status, msg)
	if status == 0 then
		PerfectRuleModeController.instance:handleGetInfo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PerfectRuleModeError, status)
		printInfo("限时挑战完美通关模式报错：" .. status)
	end
end

function PerfectRuleFightAgent:sendPM_PerfectRuleFightGainDailyPrizeReq(challengeId)
	local req = PerfectRuleFightExtension_pb.PM_PerfectRuleFightGainDailyPrizeReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function PerfectRuleFightAgent:handlePM_PerfectRuleFightGainDailyPrizeRes(status, msg)
	if status == 0 then
		PerfectRuleModeController.instance:handleGainDailyPrize(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PerfectRuleModeError, status)
		printInfo("限时挑战完美通关模式报错：" .. status)
	end
end

function PerfectRuleFightAgent:sendPM_PerfectRuleFightBuyTimesReq(challengeId)
	local req = PerfectRuleFightExtension_pb.PM_PerfectRuleFightBuyTimesReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function PerfectRuleFightAgent:handlePM_PerfectRuleFightBuyTimesRes(status, msg)
	if status == 0 then
		PerfectRuleModeController.instance:handleBuyTime(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PerfectRuleModeError, status)
		printInfo("限时挑战完美通关模式报错：" .. status)
	end
end

function PerfectRuleFightAgent:sendPM_PerfectRuleFightChooseModeReq(challengeId, modeId)
	local req = PerfectRuleFightExtension_pb.PM_PerfectRuleFightChooseModeReq()

	req.challengeId = challengeId
	req.modeId = modeId

	self:sendMsg(req)
end

function PerfectRuleFightAgent:handlePM_PerfectRuleFightChooseModeRes(status, msg)
	if status == 0 then
		PerfectRuleModeController.instance:handleChooseMode(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PerfectRuleModeError, status)
		printInfo("限时挑战完美通关模式报错：" .. status)
	end
end

function PerfectRuleFightAgent:sendPM_PerfectRuleFightReChooseRuleReq(challengeId)
	local req = PerfectRuleFightExtension_pb.PM_PerfectRuleFightReChooseRuleReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function PerfectRuleFightAgent:handlePM_PerfectRuleFightReChooseRuleRes(status, msg)
	if status == 0 then
		PerfectRuleModeController.instance:handleReChooseMode(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PerfectRuleModeError, status)
		printInfo("限时挑战完美通关模式报错：" .. status)
	end
end

function PerfectRuleFightAgent:sendPM_PerfectRuleFightChallengeReq(challengeId)
	local req = PerfectRuleFightExtension_pb.PM_PerfectRuleFightChallengeReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function PerfectRuleFightAgent:handlePM_PerfectRuleFightChallengeRes(status, msg)
	if status == 0 then
		PerfectRuleModeController.instance:handleStartFight(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PerfectRuleModeError, status)
		printInfo("限时挑战完美通关模式报错：" .. status)
	end
end

function PerfectRuleFightAgent:sendPM_PerfectRuleFightConfirmResultReq(challengeId)
	local req = PerfectRuleFightExtension_pb.PM_PerfectRuleFightConfirmResultReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function PerfectRuleFightAgent:handlePM_PerfectRuleFightConfirmResultRes(status, msg)
	if status == 0 then
		PerfectRuleModeController.instance:handleConfirmResult(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PerfectRuleModeError, status)
		printInfo("限时挑战完美通关模式报错：" .. status)
	end
end

function PerfectRuleFightAgent:sendPM_PerfectRuleFightGiveUpReq(challengeId)
	local req = PerfectRuleFightExtension_pb.PM_PerfectRuleFightGiveUpReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function PerfectRuleFightAgent:handlePM_PerfectRuleFightGiveUpRes(status, msg)
	if status == 0 then
		PerfectRuleModeController.instance:handleGiveUpFight(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PerfectRuleModeError, status)
		printInfo("限时挑战完美通关模式报错：" .. status)
	end
end

function PerfectRuleFightAgent:handlePM_PerfectRuleFightChallengeEndRes(status, msg)
	if status == 0 then
		PerfectRuleModeController.instance:handleChallengeEnd(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PerfectRuleModeError, status)
		printInfo("限时挑战完美通关模式报错：" .. status)
	end
end

function PerfectRuleFightAgent:sendPM_PerfectRuleFightGainProgressPrizeReq(challengeId, progressPrizeId)
	local req = PerfectRuleFightExtension_pb.PM_PerfectRuleFightGainProgressPrizeReq()

	req.challengeId = challengeId
	req.progressPrizeId = progressPrizeId

	self:sendMsg(req)
end

function PerfectRuleFightAgent:handlePM_PerfectRuleFightGainProgressPrizeRes(status, msg)
	if status == 0 then
		PerfectRuleModeController.instance:handleProgressUpdate()
	else
		GlobalDispatcher:dispatch(GlobalNotify.PerfectRuleModeError, status)
		printInfo("限时挑战完美通关模式报错：" .. status)
	end
end

PerfectRuleFightAgent.instance = PerfectRuleFightAgent.New()

return PerfectRuleFightAgent
