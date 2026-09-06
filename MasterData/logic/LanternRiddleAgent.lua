-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lanternriddle/agent/LanternRiddleAgent.lua

module("logic.extensions.lanternriddle.agent.LanternRiddleAgent", package.seeall)

local LanternRiddleAgent = class("LanternRiddleAgent", BaseAgent)

function LanternRiddleAgent:sendPM_LanternRiddleGetInfoReq(activityId)
	local req = LanternRiddleExtension_pb.PM_LanternRiddleGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LanternRiddleAgent:handlePM_LanternRiddleGetInfoRes(status, msg)
	if status == 0 then
		LanternRiddleController.instance:handlePM_LanternRiddleGetInfoRes(msg)
	end
end

function LanternRiddleAgent:sendPM_LanternRiddleStartGameReq(activityId, stageId, clientKey)
	local req = LanternRiddleExtension_pb.PM_LanternRiddleStartGameReq()

	req.activityId = activityId
	req.stageId = stageId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function LanternRiddleAgent:handlePM_LanternRiddleStartGameRes(status, msg)
	if status == 0 then
		LanternRiddleController.instance:handlePM_LanternRiddleStartGameRes(msg)
	end
end

function LanternRiddleAgent:sendPM_LanternRiddleEndGameReq(activityId, stageId, pass, clientEncryptedKey, problemId)
	local req = LanternRiddleExtension_pb.PM_LanternRiddleEndGameReq()

	req.activityId = activityId
	req.stageId = stageId
	req.pass = pass
	req.problemId = problemId
	req.clientEncryptedKey = clientEncryptedKey

	self:sendMsg(req)
end

function LanternRiddleAgent:handlePM_LanternRiddleEndGameRes(status, msg)
	if status == 0 then
		LanternRiddleController.instance:handlePM_LanternRiddleEndGameRes(msg)
	end
end

function LanternRiddleAgent:sendPM_LanternRiddleGainPrizeReq(activityId, prizeId)
	local req = LanternRiddleExtension_pb.PM_LanternRiddleGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function LanternRiddleAgent:handlePM_LanternRiddleGainPrizeRes(status, msg)
	if status == 0 then
		LanternRiddleController.instance:handlePM_LanternRiddleGainPrizeRes(msg)
	end
end

LanternRiddleAgent.instance = LanternRiddleAgent.New()

return LanternRiddleAgent
