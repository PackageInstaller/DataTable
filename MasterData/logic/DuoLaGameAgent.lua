-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolalight/agent/DuoLaGameAgent.lua

module("logic.extensions.duolagame.agent.DuoLaGameAgent", package.seeall)

local DuoLaGameAgent = class("DuoLaGameAgent", BaseAgent)

function DuoLaGameAgent:sendPM_DuoLaGameInfoReq(activityId)
	local req = DuoLaGameExtension_pb.PM_DuoLaGameInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DuoLaGameAgent:handlePM_DuoLaGameInfoRes(status, msg)
	if status == 0 then
		DuoLaLightController.instance:handlePM_DuoLaGameInfoRes(msg)
	end
end

function DuoLaGameAgent:sendPM_DuoLaGameStartGameReq(activityId, difficultyId, clientKey)
	local req = DuoLaGameExtension_pb.PM_DuoLaGameStartGameReq()

	req.activityId = activityId
	req.difficultyId = difficultyId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function DuoLaGameAgent:handlePM_DuoLaGameStartGameRes(status, msg)
	DuoLaLightController.instance:handlePM_DuoLaGameStartGameRes(status, msg)
end

function DuoLaGameAgent:sendPM_DuoLaGameEndGameReq(activityId, difficultyId, isPass, buyTimes, encryptedKey)
	local req = DuoLaGameExtension_pb.PM_DuoLaGameEndGameReq()

	req.activityId = activityId
	req.difficultyId = difficultyId
	req.isPass = isPass
	req.buyTimes = buyTimes
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function DuoLaGameAgent:handlePM_DuoLaGameEndGameRes(status, msg)
	DuoLaLightController.instance:handlePM_DuoLaGameEndGameRes(status, msg)
end

function DuoLaGameAgent:sendPM_DuoLaGameSweepReq(activityId, difficultyId)
	local req = DuoLaGameExtension_pb.PM_DuoLaGameSweepReq()

	req.activityId = activityId
	req.difficultyId = difficultyId

	self:sendMsg(req)
end

function DuoLaGameAgent:handlePM_DuoLaGameSweepRes(status, msg)
	if status == 0 then
		DuoLaLightController.instance:handlePM_DuoLaGameSweepRes(msg)
	end
end

DuoLaGameAgent.instance = DuoLaGameAgent.New()

return DuoLaGameAgent
