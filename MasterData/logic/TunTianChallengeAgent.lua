-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianchallenge/agent/TunTianChallengeAgent.lua

module("logic.extensions.tuntianchallenge.agent.TunTianChallengeAgent", package.seeall)

local TunTianChallengeAgent = class("TunTianChallengeAgent", BaseAgent)

function TunTianChallengeAgent:sendPM_TunTianClgGetInfoReq(activityId)
	local req = TunTianChallengeExtension_pb.PM_TunTianClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TunTianChallengeAgent:handlePM_TunTianClgGetInfoRes(status, msg)
	if status == 0 then
		TunTianChallengeController.instance:handlePM_TunTianClgGetInfoRes(msg)
	end
end

function TunTianChallengeAgent:sendPM_TunTianNormalClgFightReq(activityId, slotId, monsterId, form)
	local req = TunTianChallengeExtension_pb.PM_TunTianNormalClgFightReq()

	req.activityId = activityId
	req.slotId = slotId
	req.monsterId = monsterId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function TunTianChallengeAgent:handlePM_TunTianNormalClgFightRes(status, msg)
	TunTianChallengeController.instance:handlePM_TunTianNormalClgFightRes(msg)
end

function TunTianChallengeAgent:sendPM_TunTianRefreshNormalClgMonsterReq(activityId)
	local req = TunTianChallengeExtension_pb.PM_TunTianRefreshNormalClgMonsterReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TunTianChallengeAgent:handlePM_TunTianRefreshNormalClgMonsterRes(status, msg)
	if status == 0 then
		TunTianChallengeController.instance:handlePM_TunTianRefreshNormalClgMonsterRes(msg)
	end
end

function TunTianChallengeAgent:sendPM_TunTianGainNormalClgProgressPrizeReq(activityId, dataBitId)
	local req = TunTianChallengeExtension_pb.PM_TunTianGainNormalClgProgressPrizeReq()

	req.activityId = activityId
	req.dataBitId = dataBitId

	self:sendMsg(req)
end

function TunTianChallengeAgent:handlePM_TunTianGainNormalClgProgressPrizeRes(status, msg)
	if status == 0 then
		TunTianChallengeController.instance:handlePM_TunTianGainNormalClgProgressPrizeRes(msg)
	end
end

function TunTianChallengeAgent:sendPM_TunTianExtremeClgFightReq(activityId, stageType, stageId, form)
	local req = TunTianChallengeExtension_pb.PM_TunTianExtremeClgFightReq()

	req.activityId = activityId
	req.stageType = stageType
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function TunTianChallengeAgent:handlePM_TunTianExtremeClgFightRes(status, msg)
	TunTianChallengeController.instance:handlePM_TunTianExtremeClgFightRes(status, msg)
end

function TunTianChallengeAgent:sendPM_TunTianExtremeClgUseNewStageScoreReq(activityId, stageType, stageId, useNewScore, newScore)
	local req = TunTianChallengeExtension_pb.PM_TunTianExtremeClgUseNewStageScoreReq()

	req.activityId = activityId
	req.stageType = stageType
	req.stageId = stageId
	req.useNewScore = useNewScore
	req.newScore = newScore

	self:sendMsg(req)
end

function TunTianChallengeAgent:handlePM_TunTianExtremeClgUseNewStageScoreRes(status, msg)
	TunTianChallengeController.instance:handlePM_TunTianExtremeClgUseNewStageScoreRes(status, msg)
end

function TunTianChallengeAgent:sendPM_TunTianGainExtremeClgPrizeReq(activityId)
	local req = TunTianChallengeExtension_pb.PM_TunTianGainExtremeClgPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TunTianChallengeAgent:handlePM_TunTianGainExtremeClgPrizeRes(status, msg)
	if status == 0 then
		TunTianChallengeController.instance:handlePM_TunTianGainExtremeClgPrizeRes(msg)
	end
end

function TunTianChallengeAgent:handlePM_TunTianNotifyNormalClgFightResultRes(status, msg)
	if status == 0 then
		TunTianChallengeController.instance:handlePM_TunTianNotifyNormalClgFightResultRes(msg)
	end
end

function TunTianChallengeAgent:handlePM_TunTianNotifyExtremeClgFightResultRes(status, msg)
	if status == 0 then
		TunTianChallengeController.instance:handlePM_TunTianNotifyExtremeClgFightResultRes(msg)
	end
end

TunTianChallengeAgent.instance = TunTianChallengeAgent.New()

return TunTianChallengeAgent
