-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/suppressgame/agent/SuppressGameAgent.lua

module("logic.extensions.suppressgame.agent.SuppressGameAgent", package.seeall)

local SuppressGameAgent = class("SuppressGameAgent", BaseAgent)

function SuppressGameAgent:sendPM_SuppressGameGetInfoReq(activityId)
	local req = SuppressGameExtension_pb.PM_SuppressGameGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SuppressGameAgent:handlePM_SuppressGameGetInfoRes(status, msg)
	if status == 0 then
		SuppressGameController.instance:onHandleSuppressGameGetInfoRes(msg)
	end
end

function SuppressGameAgent:sendPM_SuppressGameStartGameReq(activityId, clientKey)
	local req = SuppressGameExtension_pb.PM_SuppressGameStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function SuppressGameAgent:handlePM_SuppressGameStartGameRes(status, msg)
	if status == 0 then
		SuppressGameController.instance:onHandleSuppressGameStartGameRes(msg)
	end
end

function SuppressGameAgent:sendPM_SuppressGameEndGameReq(progress, encryptedKey)
	local req = SuppressGameExtension_pb.PM_SuppressGameEndGameReq()

	req.progress = progress
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function SuppressGameAgent:handlePM_SuppressGameEndGameRes(status, msg)
	if status == 0 then
		SuppressGameController.instance:onHandleSuppressGameEndGameRes(msg)
	end
end

function SuppressGameAgent:sendPM_SuppressGameGetTaskInfoReq(activityId)
	local req = SuppressGameExtension_pb.PM_SuppressGameGetTaskInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SuppressGameAgent:handlePM_SuppressGameGetTaskInfoRes(status, msg)
	if status == 0 then
		SuppressGameController.instance:onHandleSuppressGameGetTaskInfoRes(msg)
	end
end

function SuppressGameAgent:sendPM_SuppressGameGainPrizeReq(activityId, gameId, taskId)
	local req = SuppressGameExtension_pb.PM_SuppressGameGainPrizeReq()

	req.activityId = activityId
	req.gameId = gameId
	req.taskId = taskId

	self:sendMsg(req)
end

function SuppressGameAgent:handlePM_SuppressGameGainPrizeRes(status, msg)
	if status == 0 then
		SuppressGameController.instance:onHandleSuppressGameGainPrizeRes(msg)
	end
end

SuppressGameAgent.instance = SuppressGameAgent.New()

return SuppressGameAgent
