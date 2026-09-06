-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/agent/FishingGameAgent.lua

module("logic.extensions.fishinggame.agent.FishingGameAgent", package.seeall)

local FishingGameAgent = class("FishingGameAgent", BaseAgent)

function FishingGameAgent:sendPM_FishingGameGetInfoReq(activityId)
	local req = FishingGameExtension_pb.PM_FishingGameGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FishingGameAgent:handlePM_FishingGameGetInfoRes(status, msg)
	if status == 0 then
		FishingGameController.instance:handlePM_FishingGameGetInfoRes(status, msg)
	end
end

function FishingGameAgent:sendPM_FishingGameStartGameReq(activityId, clientKey)
	local req = FishingGameExtension_pb.PM_FishingGameStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function FishingGameAgent:handlePM_FishingGameStartGameRes(status, msg)
	if status == 0 then
		FishingGameController.instance:handlePM_FishingGameStartGameRes(status, msg)
	end
end

function FishingGameAgent:sendPM_FishingGameEndGameReq(activityId, score, clientEncryptedKey)
	local req = FishingGameExtension_pb.PM_FishingGameEndGameReq()

	req.activityId = activityId
	req.score = score
	req.clientEncryptedKey = clientEncryptedKey

	self:sendMsg(req)
end

function FishingGameAgent:handlePM_FishingGameEndGameRes(status, msg)
	if status == 0 then
		FishingGameController.instance:handlePM_FishingGameEndGameRes(status, msg)
	end
end

function FishingGameAgent:sendPM_FishingGameGainPrizeReq(activityId)
	local req = FishingGameExtension_pb.PM_FishingGameGainPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FishingGameAgent:handlePM_FishingGameGainPrizeRes(status, msg)
	if status == 0 then
		FishingGameController.instance:handlePM_FishingGameGainPrizeRes(status, msg)
	end
end

function FishingGameAgent:sendPM_FishingGameAnnuitySweepReq(activityId, sweepTimes)
	local req = FishingGameExtension_pb.PM_FishingGameAnnuitySweepReq()

	req.activityId = activityId
	req.sweepTimes = sweepTimes

	self:sendMsg(req)
end

function FishingGameAgent:handlePM_FishingGameAnnuitySweepRes(status, msg)
	if status == 0 then
		FishingGameController.instance:handlePM_FishingGameAnnuitySweepRes(status, msg)
	end
end

FishingGameAgent.instance = FishingGameAgent.New()

return FishingGameAgent
