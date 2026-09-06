-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehalogame/agent/DivineHaloGameAgent.lua

module("logic.extensions.divinehalogame.agent.DivineHaloGameAgent", package.seeall)

local DivineHaloGameAgent = class("DivineHaloGameAgent", BaseAgent)

function DivineHaloGameAgent:sendPM_DivineHaloGameInfoReq(activityId)
	local req = DivineHaloGameExtension_pb.PM_DivineHaloGameInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineHaloGameAgent:handlePM_DivineHaloGameInfoRes(status, msg)
	if status == 0 then
		DivineHaloGameController.instance:handlePM_DivineHaloGameInfoRes(msg)
	end
end

function DivineHaloGameAgent:sendPM_DivineHaloGameBuyTimesReq(activityId, times)
	local req = DivineHaloGameExtension_pb.PM_DivineHaloGameBuyTimesReq()

	req.activityId = activityId
	req.times = times

	self:sendMsg(req)
end

function DivineHaloGameAgent:handlePM_DivineHaloGameBuyTimesRes(status, msg)
	if status == 0 then
		DivineHaloGameController.instance:handlePM_DivineHaloGameBuyTimesRes(msg)
	end
end

function DivineHaloGameAgent:sendPM_DivineHaloGameStartGameReq(activityId, clientKey)
	local req = DivineHaloGameExtension_pb.PM_DivineHaloGameStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function DivineHaloGameAgent:handlePM_DivineHaloGameStartGameRes(status, msg)
	if status == 0 then
		DivineHaloGameController.instance:handlePM_DivineHaloGameStartGameRes(msg)
	end
end

function DivineHaloGameAgent:sendPM_DivineHaloGameEndGameReq(activityId, stageId, passOrNot, encryptedKey)
	local req = DivineHaloGameExtension_pb.PM_DivineHaloGameEndGameReq()

	req.activityId = activityId
	req.stageId = stageId
	req.passOrNot = passOrNot
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function DivineHaloGameAgent:handlePM_DivineHaloGameEndGameRes(status, msg)
	if status == 0 then
		DivineHaloGameController.instance:handlePM_DivineHaloGameEndGameRes(msg)
	end
end

DivineHaloGameAgent.instance = DivineHaloGameAgent.New()

return DivineHaloGameAgent
