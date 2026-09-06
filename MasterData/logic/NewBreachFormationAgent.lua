-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbreakformation/agent/NewBreachFormationAgent.lua

module("logic.extensions.newbreachformation.agent.NewBreachFormationAgent", package.seeall)

local NewBreachFormationAgent = class("NewBreachFormationAgent", BaseAgent)

function NewBreachFormationAgent:sendPM_NewBreachFormationInfoReq(seasonId)
	local req = NewBreachFormationExtension_pb.PM_NewBreachFormationInfoReq()

	req.seasonId = seasonId

	self:sendMsg(req)
end

function NewBreachFormationAgent:handlePM_NewBreachFormationInfoRes(status, msg)
	if status == 0 then
		NewBreakFormationController.instance:handlePM_NewBreachFormationInfoRes(msg)
	end
end

function NewBreachFormationAgent:sendPM_NewBreachFormationChallengeReq(seasonId, tabId, periodId, stageId, buffOption, form)
	local req = NewBreachFormationExtension_pb.PM_NewBreachFormationChallengeReq()

	req.seasonId = seasonId
	req.tabId = tabId
	req.periodId = periodId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	if buffOption ~= nil then
		req.buffOption:ParseFromString(buffOption:SerializeToString())
	end

	self:sendMsg(req)
end

function NewBreachFormationAgent:handlePM_NewBreachFormationChallengeRes(status, msg)
	if status == 0 then
		NewBreakFormationController.instance:handlePM_NewBreachFormationChallengeRes(msg)
	end
end

function NewBreachFormationAgent:handlePM_NewBreachFormationNotifyChallengeRes(status, msg)
	if status == 0 then
		NewBreakFormationController.instance:handlePM_NewBreachFormationNotifyChallengeRes(msg)
	end
end

function NewBreachFormationAgent:sendPM_NewBreachFormationGainScorePrizeReq(seasonId, tabId, periodId, prizeId)
	local req = NewBreachFormationExtension_pb.PM_NewBreachFormationGainScorePrizeReq()

	req.seasonId = seasonId
	req.tabId = tabId
	req.periodId = periodId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function NewBreachFormationAgent:handlePM_NewBreachFormationGainScorePrizeRes(status, msg)
	if status == 0 then
		NewBreakFormationController.instance:handlePM_NewBreachFormationGainScorePrizeRes(msg)
	end
end

function NewBreachFormationAgent:sendPM_NewBreachFormationRankViewReq(seasonId)
	local req = NewBreachFormationExtension_pb.PM_NewBreachFormationRankViewReq()

	req.seasonId = seasonId

	self:sendMsg(req)
end

function NewBreachFormationAgent:handlePM_NewBreachFormationRankViewRes(status, msg)
	if status == 0 then
		NewBreakFormationController.instance:handlePM_NewBreachFormationRankViewRes(msg)
	end
end

NewBreachFormationAgent.instance = NewBreachFormationAgent.New()

return NewBreachFormationAgent
