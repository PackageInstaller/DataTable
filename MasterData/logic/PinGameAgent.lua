-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/agent/PinGameAgent.lua

module("logic.extensions.pingame.agent.PinGameAgent", package.seeall)

local PinGameAgent = class("PinGameAgent", BaseAgent)

function PinGameAgent:sendPM_PinGameInfoReq(activityId)
	local req = PinGameExtension_pb.PM_PinGameInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PinGameAgent:handlePM_PinGameInfoRes(status, msg)
	if status == 0 then
		PinGameModel.instance:onPinGameInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.PinGameInfoRes)
	end
end

function PinGameAgent:sendPM_PinGameStartGameReq(activityId, clientKey, mode)
	local req = PinGameExtension_pb.PM_PinGameStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey
	req.mode = mode

	self:sendMsg(req)
end

function PinGameAgent:handlePM_PinGameStartGameRes(status, msg)
	if status == 0 then
		PinGameModel.instance:onPinGameStartGameRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.PinGameStartGameRes)
	end
end

function PinGameAgent:sendPM_PinGameEndGameReq(activityId, mode, stageId, isPass, encryptedKey)
	local req = PinGameExtension_pb.PM_PinGameEndGameReq()

	req.activityId = activityId
	req.mode = mode
	req.stageId = stageId
	req.isPass = isPass
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function PinGameAgent:handlePM_PinGameEndGameRes(status, msg)
	if status == 0 then
		PinGameModel.instance:onPinGameEndGameRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.PinGameEndGameRes)
	end
end

function PinGameAgent:sendPM_PinGameRecoverReq(activityId)
	local req = PinGameExtension_pb.PM_PinGameRecoverReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PinGameAgent:handlePM_PinGameRecoverRes(status, msg)
	if status == 0 then
		PinGameModel.instance:onPinGameRecoverRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.PinGameRecoverRes)
	end
end

function PinGameAgent:sendPM_PinGameGainPrizeReq(activityId, prizeId)
	local req = PinGameExtension_pb.PM_PinGameGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function PinGameAgent:handlePM_PinGameGainPrizeRes(status, msg)
	if status == 0 then
		PinGameModel.instance:onPinGameGainPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.PinGameGainPrizeRes)
	end
end

function PinGameAgent:sendPM_PinGameSweepReq(activityId, mode, times)
	local req = PinGameExtension_pb.PM_PinGameSweepReq()

	req.activityId = activityId
	req.mode = mode
	req.times = times

	self:sendMsg(req)
end

function PinGameAgent:handlePM_PinGameSweepRes(status, msg)
	if status == 0 then
		PinGameModel.instance:handlePM_PinGameSweepRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.PinGameSweepRes, msg)
	end
end

PinGameAgent.instance = PinGameAgent.New()

return PinGameAgent
