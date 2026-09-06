-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mazegame/agent/MazeGameAgent.lua

module("logic.extensions.mazegame.agent.MazeGameAgent", package.seeall)

local MazeGameAgent = class("MazeGameAgent", BaseAgent)

function MazeGameAgent:sendPM_MazeGameInfoReq(activityId)
	local req = MazeGameExtension_pb.PM_MazeGameInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MazeGameAgent:handlePM_MazeGameInfoRes(status, msg)
	if status == 0 then
		MazeGameController.instance:handlePM_MazeGameInfoRes(status, msg)
	end
end

function MazeGameAgent:sendPM_MazeGameStartGameReq(activityId, clientKey, stageId)
	local req = MazeGameExtension_pb.PM_MazeGameStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey
	req.stageId = stageId

	self:sendMsg(req)
end

function MazeGameAgent:handlePM_MazeGameStartGameRes(status, msg)
	if status == 0 then
		MazeGameController.instance:handlePM_MazeGameStartGameRes(status, msg)
	end
end

function MazeGameAgent:sendPM_MazeGameEndGameReq(activityId, stageId, passOrNot, encryptedKey)
	local req = MazeGameExtension_pb.PM_MazeGameEndGameReq()

	req.activityId = activityId
	req.stageId = stageId
	req.passOrNot = passOrNot
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function MazeGameAgent:handlePM_MazeGameEndGameRes(status, msg)
	if status == 0 then
		MazeGameController.instance:handlePM_MazeGameEndGameRes(status, msg)
	end
end

MazeGameAgent.instance = MazeGameAgent.New()

return MazeGameAgent
