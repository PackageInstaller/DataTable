-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternaldragon/agent/EternalDragonAgent.lua

module("logic.extensions.eternaldragon.agent.EternalDragonAgent", package.seeall)

local EternalDragonAgent = class("EternalDragonAgent", BaseAgent)

function EternalDragonAgent:sendPM_EternalDragonInfoReq(activityId)
	local req = EternalDragonExtension_pb.PM_EternalDragonInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function EternalDragonAgent:handlePM_EternalDragonInfoRes(status, msg)
	if status == 0 then
		EternalDragonController.instance:handlePM_EternalDragonInfoRes(msg)
	end
end

function EternalDragonAgent:sendPM_EternalDragonWaterReq(activityId)
	local req = EternalDragonExtension_pb.PM_EternalDragonWaterReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function EternalDragonAgent:handlePM_EternalDragonWaterRes(status, msg)
	if status == 0 then
		EternalDragonController.instance:handlePM_EternalDragonWaterRes(msg)
	end
end

function EternalDragonAgent:sendPM_EternalDragonStartGameReq(activityId, clientKey)
	local req = EternalDragonExtension_pb.PM_EternalDragonStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function EternalDragonAgent:handlePM_EternalDragonStartGameRes(status, msg)
	if status == 0 then
		EternalDragonController.instance:handlePM_EternalDragonStartGameRes(msg)
	end
end

function EternalDragonAgent:sendPM_EternalDragonEndGameReq(activityId, isPass, encryptedKey)
	local req = EternalDragonExtension_pb.PM_EternalDragonEndGameReq()

	req.activityId = activityId
	req.isPass = isPass
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function EternalDragonAgent:handlePM_EternalDragonEndGameRes(status, msg)
	EternalDragonController.instance:handlePM_EternalDragonEndGameRes(status, msg)
end

function EternalDragonAgent:sendPM_EternalDragonCuttingReq(activityId)
	local req = EternalDragonExtension_pb.PM_EternalDragonCuttingReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function EternalDragonAgent:handlePM_EternalDragonCuttingRes(status, msg)
	if status == 0 then
		EternalDragonController.instance:handlePM_EternalDragonCuttingRes(msg)
	end
end

function EternalDragonAgent:sendPM_EternalDragonGainPrizeReq(activityId, prizeId)
	local req = EternalDragonExtension_pb.PM_EternalDragonGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function EternalDragonAgent:handlePM_EternalDragonGainPrizeRes(status, msg)
	if status == 0 then
		EternalDragonController.instance:handlePM_EternalDragonGainPrizeRes(msg)
	end
end

EternalDragonAgent.instance = EternalDragonAgent.New()

return EternalDragonAgent
