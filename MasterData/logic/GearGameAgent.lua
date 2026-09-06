-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/geargame/agent/GearGameAgent.lua

module("logic.extensions.geargame.agent.GearGameAgent", package.seeall)

local GearGameAgent = class("GearGameAgent", BaseAgent)

function GearGameAgent:sendPM_GearGameInfoReq(activityId)
	local req = GearGameExtension_pb.PM_GearGameInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GearGameAgent:handlePM_GearGameInfoRes(status, msg)
	if status == 0 then
		GearGameController.instance:handlePM_GearGameInfoRes(status, msg)
	end
end

function GearGameAgent:sendPM_GearGameStartGameReq(activityId, clientKey)
	local req = GearGameExtension_pb.PM_GearGameStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function GearGameAgent:handlePM_GearGameStartGameRes(status, msg)
	if status == 0 then
		GearGameController.instance:handlePM_GearGameStartGameRes(status, msg)
	end
end

function GearGameAgent:sendPM_GearGameEndGameReq(activityId, stageId, passOrNot, encryptedKey)
	local req = GearGameExtension_pb.PM_GearGameEndGameReq()

	req.activityId = activityId
	req.stageId = stageId
	req.passOrNot = passOrNot
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function GearGameAgent:handlePM_GearGameEndGameRes(status, msg)
	if status == 0 then
		GearGameController.instance:handlePM_GearGameEndGameRes(status, msg)
	end
end

GearGameAgent.instance = GearGameAgent.New()

return GearGameAgent
