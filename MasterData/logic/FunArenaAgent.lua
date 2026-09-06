-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funarena/agent/FunArenaAgent.lua

module("logic.extensions.funarena.agent.FunArenaAgent", package.seeall)

local FunArenaAgent = class("FunArenaAgent", BaseAgent)

FunArenaAgent.PM_BigCastChallengeGetInfoRes = "FunArenaAgent_PM_BigCastChallengeGetInfoRes"
FunArenaAgent.PM_BigCastChallengeSetFormReq = "FunArenaAgent_PM_BigCastChallengeSetFormReq"
FunArenaAgent.PM_BigCastChallengeChooseBuffReq = "FunArenaAgent_PM_BigCastChallengeChooseBuffReq"
FunArenaAgent.PM_BigCastChallengeLotteryReq = "FunArenaAgent_PM_BigCastChallengeLotteryReq"
FunArenaAgent.PM_BigCastChallengeGainWinStreakPrizeReq = "PM_BigCastChallengeGainWinStreakPrizeReq"
FunArenaAgent.PM_BigCastChallengeViewRankReq = "FunArenaAgent_PM_BigCastChallengeViewRankReq"

function FunArenaAgent:ctor()
	return
end

function FunArenaAgent:setExtId(extId)
	FunArenaAgent.super.setExtId(self, extId)
end

function FunArenaAgent:sendPM_BigCastChallengeGetInfoReq()
	local req = BigCastChallengeExtension_pb.PM_BigCastChallengeGetInfoReq()

	self:sendMsg(req)
end

function FunArenaAgent:handlePM_BigCastChallengeGetInfoRes(status, msg)
	if status == 0 then
		FunArenaController.instance:onHandleGetInfoRes(msg)
	end

	self:dispatch(FunArenaAgent.PM_BigCastChallengeGetInfoRes, status, msg)
end

function FunArenaAgent:sendPM_BigCastChallengeSetFormReq(activityId, form)
	local req = BigCastChallengeExtension_pb.PM_BigCastChallengeSetFormReq()

	req.activityId = activityId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function FunArenaAgent:handlePM_BigCastChallengeSetFormRes(status, msg)
	if status == 0 then
		FunArenaController.instance:onHandleSetFormRes(msg)
		self:dispatch(FunArenaAgent.PM_BigCastChallengeSetFormReq, status, msg)
	end
end

function FunArenaAgent:sendPM_BigCastChallengeFightReq(activityId)
	local req = BigCastChallengeExtension_pb.PM_BigCastChallengeFightReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FunArenaAgent:handlePM_BigCastChallengeFightRes(status, msg)
	if status == 0 then
		FunArenaController.instance:onHandleFightRes(msg)
		BattleFacade.instance:startAceTeamFight(msg.btlResult)

		local commonRuleTxt = lang("FunArena_mission_Tips_1")
		local perfectRuleTxt = lang("FunArena_mission_Tips_2")

		MissionModel.instance:setRuleDesc(commonRuleTxt, perfectRuleTxt)
	else
		UIStateManager.instance:clear(true)
		UIStateManager.instance:push(ViewName.FunArenaView)
	end
end

function FunArenaAgent:sendPM_BigCastChallengeChooseBuffReq(activityId, buffId)
	local req = BigCastChallengeExtension_pb.PM_BigCastChallengeChooseBuffReq()

	req.activityId = activityId
	req.buffId = buffId

	self:sendMsg(req)
end

function FunArenaAgent:handlePM_BigCastChallengeChooseBuffRes(status, msg)
	if status == 0 then
		FunArenaController.instance:onHandleChooseBuffRes(msg)
		self:dispatch(FunArenaAgent.PM_BigCastChallengeChooseBuffReq, status, msg)
	end
end

function FunArenaAgent:sendPM_BigCastChallengeLotteryReq(activityId)
	local req = BigCastChallengeExtension_pb.PM_BigCastChallengeLotteryReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FunArenaAgent:handlePM_BigCastChallengeLotteryRes(status, msg)
	if status == 0 then
		FunArenaController.instance:onHandleLotteryRes(msg)
		self:dispatch(FunArenaAgent.PM_BigCastChallengeLotteryReq, status, msg)
	end
end

function FunArenaAgent:sendPM_BigCastChallengeGainWinStreakPrizeReq(activityId, winStreakTimes, handler, handlerObj, errHandler)
	local req = BigCastChallengeExtension_pb.PM_BigCastChallengeGainWinStreakPrizeReq()

	req.activityId = activityId
	req.winStreakTimes = winStreakTimes

	self:sendMsg(req)
end

function FunArenaAgent:handlePM_BigCastChallengeGainWinStreakPrizeRes(status, msg)
	if status == 0 then
		FunArenaController.instance:onHandleGainWinStreakPrizeRes(msg)
		self:dispatch(FunArenaAgent.PM_BigCastChallengeGainWinStreakPrizeReq, status, msg)
	end
end

function FunArenaAgent:sendPM_BigCastChallengeViewRankReq(activityId)
	local req = BigCastChallengeExtension_pb.PM_BigCastChallengeViewRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FunArenaAgent:handlePM_BigCastChallengeViewRankRes(status, msg)
	if status == 0 then
		FunArenaController.instance:onHandleViewRankRes(msg)
		self:dispatch(FunArenaAgent.PM_BigCastChallengeViewRankReq, status, msg)
	end
end

FunArenaAgent.instance = FunArenaAgent.New()

return FunArenaAgent
