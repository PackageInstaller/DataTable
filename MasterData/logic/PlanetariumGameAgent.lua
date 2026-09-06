-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/planetarium/agent/PlanetariumGameAgent.lua

module("logic.extensions.planetarium.agent.PlanetariumGameAgent", package.seeall)

local PlanetariumGameAgent = class("PlanetariumGameAgent", BaseAgent)

function PlanetariumGameAgent:sendPM_PlanetariumGameInfoReq(activityId)
	local req = PlanetariumGameExtension_pb.PM_PlanetariumGameInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PlanetariumGameAgent:handlePM_PlanetariumGameInfoRes(status, msg)
	if status == 0 then
		PlanetariumController.instance:handlePM_PlanetariumGameInfoRes(status, msg)
	end
end

function PlanetariumGameAgent:sendPM_PlanetariumGameStartGameReq(activityId, clientKey)
	local req = PlanetariumGameExtension_pb.PM_PlanetariumGameStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function PlanetariumGameAgent:handlePM_PlanetariumGameStartGameRes(status, msg)
	if status == 0 then
		PlanetariumController.instance:handlePM_PlanetariumGameStartGameRes(status, msg)
	end
end

function PlanetariumGameAgent:sendPM_PlanetariumGameEndGameReq(activityId, isPass, encryptedKey)
	local req = PlanetariumGameExtension_pb.PM_PlanetariumGameEndGameReq()

	req.activityId = activityId
	req.isPass = isPass
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function PlanetariumGameAgent:handlePM_PlanetariumGameEndGameRes(status, msg)
	if status == 0 then
		PlanetariumController.instance:handlePM_PlanetariumGameEndGameRes(status, msg)
	end
end

function PlanetariumGameAgent:sendPM_PlanetariumGameGainPrizeReq(activityId, prizeId)
	local req = PlanetariumGameExtension_pb.PM_PlanetariumGameGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function PlanetariumGameAgent:handlePM_PlanetariumGameGainPrizeRes(status, msg)
	if status == 0 then
		PlanetariumController.instance:handlePM_PlanetariumGameGainPrizeRes(status, msg)
	end
end

PlanetariumGameAgent.instance = PlanetariumGameAgent.New()

return PlanetariumGameAgent
