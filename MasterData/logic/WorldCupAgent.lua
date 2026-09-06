-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldcup/agent/WorldCupAgent.lua

module("logic.extensions.worldcup.agent.WorldCupAgent", package.seeall)

local WorldCupAgent = class("WorldCupAgent", BaseAgent)

function WorldCupAgent:sendPM_WorldCupGetInfoReq(activityId)
	local req = WorldCupExtension_pb.PM_WorldCupGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WorldCupAgent:handlePM_WorldCupGetInfoRes(status, msg)
	if status == 0 then
		WorldCupController.instance:handlePM_WorldCupGetInfoRes(msg)
	end
end

function WorldCupAgent:sendPM_WorldCupGainDailyPrizeReq(activityId)
	local req = WorldCupExtension_pb.PM_WorldCupGainDailyPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WorldCupAgent:handlePM_WorldCupGainDailyPrizeRes(status, msg)
	if status == 0 then
		WorldCupController.instance:handlePM_WorldCupGainDailyPrizeRes(msg)
	end
end

function WorldCupAgent:sendPM_WorldCupBetReq(activityId, matchId, stageId, homeTeamId, defineId, odds, addScore)
	local req = WorldCupExtension_pb.PM_WorldCupBetReq()

	req.activityId = activityId
	req.matchId = matchId
	req.stageId = stageId
	req.homeTeamId = homeTeamId
	req.defineId = defineId
	req.odds = odds
	req.addScore = addScore

	self:sendMsg(req)
end

function WorldCupAgent:handlePM_WorldCupBetRes(status, msg)
	if status == 0 then
		WorldCupController.instance:handlePM_WorldCupBetRes(msg)
	else
		FloatWordMgr.instance:show(lang("应援信息发生变更，请稍后再试"))
	end
end

function WorldCupAgent:sendPM_WorldCupOneKeyGainPrizeReq(activityId)
	local req = WorldCupExtension_pb.PM_WorldCupOneKeyGainPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WorldCupAgent:handlePM_WorldCupOneKeyGainPrizeRes(status, msg)
	if status == 0 then
		WorldCupController.instance:handlePM_WorldCupOneKeyGainPrizeRes(msg)
	end
end

function WorldCupAgent:sendPM_WorldCupRankInfoReq(activityId)
	local req = WorldCupExtension_pb.PM_WorldCupRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WorldCupAgent:handlePM_WorldCupRankInfoRes(status, msg)
	if status == 0 then
		WorldCupController.instance:handlePM_WorldCupRankInfoRes(msg)
	end
end

function WorldCupAgent:sendPM_WorldCupGuessTopThreeReq(activityId, championTeamId, runnerUpTeamId, thirdPlaceTeamId)
	local req = WorldCupExtension_pb.PM_WorldCupGuessTopThreeReq()

	req.activityId = activityId
	req.championTeamId = championTeamId
	req.runnerUpTeamId = runnerUpTeamId
	req.thirdPlaceTeamId = thirdPlaceTeamId

	self:sendMsg(req)
end

function WorldCupAgent:handlePM_WorldCupGuessTopThreeRes(status, msg)
	if status == 0 then
		WorldCupController.instance:handlePM_WorldCupGuessTopThreeReq(msg)
	end
end

function WorldCupAgent:sendPM_WorldCupGainTopThreePrizeReq(activityId)
	local req = WorldCupExtension_pb.PM_WorldCupGainTopThreePrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WorldCupAgent:handlePM_WorldCupGainTopThreePrizeRes(status, msg)
	if status == 0 then
		WorldCupController.instance:handlePM_WorldCupGainTopThreePrizeReq(msg)
	end
end

WorldCupAgent.instance = WorldCupAgent.New()

return WorldCupAgent
