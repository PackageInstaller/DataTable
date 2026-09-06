-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/iceqibugame/agent/IceQibuGameAgent.lua

module("logic.extensions.iceqibugame.agent.IceQibuGameAgent", package.seeall)

local IceQibuGameAgent = class("IceQibuGameAgent", BaseAgent)

function IceQibuGameAgent:sendPM_IceQibuGameInfoReq(activityId)
	local req = IceQibuGameExtension_pb.PM_IceQibuGameInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function IceQibuGameAgent:handlePM_IceQibuGameInfoRes(status, msg)
	if status == 0 then
		IceQibuGameController.instance:handlePM_IceQibuGameInfoRes(msg)
	end
end

function IceQibuGameAgent:sendPM_IceQibuGameStartGameReq(activityId, clientKey)
	local req = IceQibuGameExtension_pb.PM_IceQibuGameStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function IceQibuGameAgent:handlePM_IceQibuGameStartGameRes(status, msg)
	IceQibuGameController.instance:handlePM_IceQibuGameStartGameRes(status, msg)
end

function IceQibuGameAgent:sendPM_IceQibuGameEndGameReq(activityId, costTime, encryptedKey, stageId, isPassStage)
	local req = IceQibuGameExtension_pb.PM_IceQibuGameEndGameReq()

	req.activityId = activityId
	req.costTime = costTime
	req.encryptedKey = encryptedKey
	req.stageId = stageId
	req.isPassStage = isPassStage

	self:sendMsg(req)
end

function IceQibuGameAgent:handlePM_IceQibuGameEndGameRes(status, msg)
	if status == 0 then
		IceQibuGameController.instance:handlePM_IceQibuGameEndGameRes(msg)
	end
end

function IceQibuGameAgent:sendPM_IceQibuGameSweepReq(activityId, sweepTimes)
	local req = IceQibuGameExtension_pb.PM_IceQibuGameSweepReq()

	req.activityId = activityId
	req.sweepTimes = sweepTimes

	self:sendMsg(req)
end

function IceQibuGameAgent:handlePM_IceQibuGameSweepRes(status, msg)
	if status == 0 then
		IceQibuGameController.instance:handlePM_IceQibuGameSweepRes(msg)
	end
end

IceQibuGameAgent.instance = IceQibuGameAgent.New()

return IceQibuGameAgent
