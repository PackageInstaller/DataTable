-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pinball/agent/PinBallAgent.lua

module("logic.extensions.pinball.agent.PinBallAgent", package.seeall)

local PinBallAgent = class("PinBallAgent", BaseAgent)

function PinBallAgent:sendPM_PinBallGetInfoReq(activityId)
	local req = PinBallExtension_pb.PM_PinBallGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PinBallAgent:handlePM_PinBallGetInfoRes(status, msg)
	if status == 0 then
		PinBallController.instance:handlePM_PinBallGetInfoRes(status, msg)
	end
end

function PinBallAgent:sendPM_PinBallStartGameReq(activityId, stageId, clientKey)
	local req = PinBallExtension_pb.PM_PinBallStartGameReq()

	req.activityId = activityId
	req.stageId = stageId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function PinBallAgent:handlePM_PinBallStartGameRes(status, msg)
	if status == 0 then
		PinBallController.instance:handlePM_PinBallStartGameRes(status, msg)
	end
end

function PinBallAgent:sendPM_PinBallEndGameReq(activityId, stageId, score, encryptedKey, extPrizeCount)
	local req = PinBallExtension_pb.PM_PinBallEndGameReq()

	req.activityId = activityId
	req.stageId = stageId
	req.score = score
	req.encryptedKey = encryptedKey

	for i, v1 in ipairs(extPrizeCount) do
		req.extPrizeCount:append(v1)
	end

	self:sendMsg(req)
end

function PinBallAgent:handlePM_PinBallEndGameRes(status, msg)
	if status == 0 then
		PinBallController.instance:handlePM_PinBallEndGameRes(status, msg)
	end
end

function PinBallAgent:sendPM_PinBallGainPrizeReq(activityId, prizeIds)
	local req = PinBallExtension_pb.PM_PinBallGainPrizeReq()

	req.activityId = activityId

	for i, v1 in ipairs(prizeIds) do
		req.prizeIds:append(v1)
	end

	self:sendMsg(req)
end

function PinBallAgent:handlePM_PinBallGainPrizeRes(status, msg)
	if status == 0 then
		PinBallController.instance:handlePM_PinBallGainPrizeRes(status, msg)
	end
end

function PinBallAgent:sendPM_PinBallSweepReq(activityId, sweepTimes)
	local req = PinBallExtension_pb.PM_PinBallSweepReq()

	req.activityId = activityId
	req.sweepTimes = sweepTimes

	self:sendMsg(req)
end

function PinBallAgent:handlePM_PinBallSweepRes(status, msg)
	if status == 0 then
		PinBallController.instance:onSweepRes(msg)
	end
end

PinBallAgent.instance = PinBallAgent.New()

return PinBallAgent
