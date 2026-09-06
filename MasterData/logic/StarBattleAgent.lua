-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/agent/StarBattleAgent.lua

module("logic.extensions.starbattle.agent.StarBattleAgent", package.seeall)

local StarBattleAgent = class("StarBattleAgent", BaseAgent)

function StarBattleAgent:sendPM_StarBattleInfoReq(activityId, periodId)
	local req = StarBattleExtension_pb.PM_StarBattleInfoReq()

	req.activityId = activityId
	req.periodId = periodId

	self:sendMsg(req)
end

function StarBattleAgent:handlePM_StarBattleInfoRes(status, msg)
	if status == 0 then
		StarBattleController.instance:handleGetInfo(msg)
	end
end

function StarBattleAgent:sendPM_StarBattlesetDefenseReq(activityId, form, periodId)
	local req = StarBattleExtension_pb.PM_StarBattlesetDefenseReq()

	req.activityId = activityId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.periodId = periodId

	self:sendMsg(req)
end

function StarBattleAgent:handlePM_StarBattlesetDefenseRes(status, msg)
	if status == 0 then
		StarBattleController.instance:handleSaveDefense(msg)
	end
end

function StarBattleAgent:sendPM_StarBattleStageChallengeReq(activityId, stageId, form, periodId)
	local req = StarBattleExtension_pb.PM_StarBattleStageChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.periodId = periodId

	self:sendMsg(req)
end

function StarBattleAgent:handlePM_StarBattleStageChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function StarBattleAgent:handlePM_StarBattleNotifyStageChallengeRes(status, msg)
	if status == 0 then
		StarBattleController.instance:handleNotifyStageChallenge(msg)
	end
end

function StarBattleAgent:sendPM_StarBattleBossChallengeReq(activityId, form, bossId, periodId)
	local req = StarBattleExtension_pb.PM_StarBattleBossChallengeReq()

	req.activityId = activityId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.bossId = bossId
	req.periodId = periodId

	self:sendMsg(req)
end

function StarBattleAgent:handlePM_StarBattleBossChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function StarBattleAgent:handlePM_StarBattleNotifyBossChallengeRes(status, msg)
	if status == 0 then
		StarBattleController.instance:handleNotifyBossChallenge(msg)
	end
end

function StarBattleAgent:sendPM_StarBattleSignInReq(activityId, periodId)
	local req = StarBattleExtension_pb.PM_StarBattleSignInReq()

	req.activityId = activityId
	req.periodId = periodId

	self:sendMsg(req)
end

function StarBattleAgent:handlePM_StarBattleSignInRes(status, msg)
	if status == 0 then
		StarBattleController.instance:handleSignIn(msg)
	end
end

function StarBattleAgent:sendPM_StarBattleGainProgressPrizeReq(activityId, progressId, periodId)
	local req = StarBattleExtension_pb.PM_StarBattleGainProgressPrizeReq()

	req.activityId = activityId
	req.progressId = progressId
	req.periodId = periodId

	self:sendMsg(req)
end

function StarBattleAgent:handlePM_StarBattleGainProgressPrizeRes(status, msg)
	if status == 0 then
		StarBattleController.instance:handleGainProgressPrize(msg)
	end
end

function StarBattleAgent:sendPM_StarBattleRankViewReq(activityId, rankId, periodId)
	local req = StarBattleExtension_pb.PM_StarBattleRankViewReq()

	req.activityId = activityId
	req.rankId = rankId
	req.periodId = periodId

	self:sendMsg(req)
end

function StarBattleAgent:handlePM_StarBattleRankViewRes(status, msg)
	if status == 0 then
		StarBattleController.instance:handleGetRankView(msg)
	end
end

function StarBattleAgent:sendPM_StarBattleVerifyRaceReq(activityId, raceId, periodId)
	local req = StarBattleExtension_pb.PM_StarBattleVerifyRaceReq()

	req.activityId = activityId

	local raceId = checknumber(raceId)

	if raceId > 0 then
		req.raceId:append(raceId)
	end

	req.periodId = periodId

	self:sendMsg(req)
end

function StarBattleAgent:handlePM_StarBattleVerifyRaceRes(status, msg)
	if status == 0 then
		StarBattleController.instance:handleVerifyRace(msg)
	end
end

function StarBattleAgent:sendPM_StarBattleOneClickGainDefensePrizeReq(activityId, periodId, prizeType, raceId)
	local req = StarBattleExtension_pb.PM_StarBattleOneClickGainDefensePrizeReq()

	req.activityId = activityId
	req.periodId = periodId
	req.prizeType = prizeType

	if raceId ~= nil then
		req.raceId = raceId
	end

	self:sendMsg(req)
end

function StarBattleAgent:handlePM_StarBattleOneClickGainDefensePrizeRes(status, msg)
	if status == 0 then
		StarBattleController.instance:handleOneClickGainDefensePrize(msg)
	end
end

StarBattleAgent.instance = StarBattleAgent.New()

return StarBattleAgent
