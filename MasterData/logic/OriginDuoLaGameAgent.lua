-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originduolagame/agent/OriginDuoLaGameAgent.lua

module("logic.extensions.originduolagame.agent.OriginDuoLaGameAgent", package.seeall)

local OriginDuoLaGameAgent = class("OriginDuoLaGameAgent", BaseAgent)

function OriginDuoLaGameAgent:sendPM_OriginDuoLaGameGetInfoReq(activityId)
	local req = OriginDuoLaGameExtension_pb.PM_OriginDuoLaGameGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginDuoLaGameAgent:handlePM_OriginDuoLaGameGetInfoRes(status, msg)
	if status == 0 then
		OriginDuoLaGameController.instance:handlePM_OriginDuoLaGameGetInfoRes(msg)
	end
end

function OriginDuoLaGameAgent:sendPM_OriginDuoLaGameStartGameReq(activityId, stageId, clientKey)
	local req = OriginDuoLaGameExtension_pb.PM_OriginDuoLaGameStartGameReq()

	req.activityId = activityId
	req.stageId = stageId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function OriginDuoLaGameAgent:handlePM_OriginDuoLaGameStartGameRes(status, msg)
	if status == 0 then
		OriginDuoLaGameController.instance:handlePM_OriginDuoLaGameStartGameRes(msg)
	end
end

function OriginDuoLaGameAgent:sendPM_OriginDuoLaGameEndGameReq(activityId, stageId, isPass, encryptedKey)
	local req = OriginDuoLaGameExtension_pb.PM_OriginDuoLaGameEndGameReq()

	req.activityId = activityId
	req.stageId = stageId
	req.isPass = isPass
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function OriginDuoLaGameAgent:handlePM_OriginDuoLaGameEndGameRes(status, msg)
	if status == 0 then
		OriginDuoLaGameController.instance:handlePM_OriginDuoLaGameEndGameRes(msg)
	end
end

OriginDuoLaGameAgent.instance = OriginDuoLaGameAgent.New()

return OriginDuoLaGameAgent
