-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stickcouplet/agent/StickCoupletAgent.lua

module("logic.extensions.stickcouplet.agent.StickCoupletAgent", package.seeall)

local StickCoupletAgent = class("StickCoupletAgent", BaseAgent)

function StickCoupletAgent:sendPM_StickCoupletGetInfoReq(activityId)
	local req = StickCoupletExtension_pb.PM_StickCoupletGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function StickCoupletAgent:handlePM_StickCoupletGetInfoRes(status, msg)
	if status == 0 then
		StickCoupletController.instance:handlePM_StickCoupletGetInfoRes(msg)
	end
end

function StickCoupletAgent:sendPM_StickCoupletStartGameReq(activityId, clientKey)
	local req = StickCoupletExtension_pb.PM_StickCoupletStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function StickCoupletAgent:handlePM_StickCoupletStartGameRes(status, msg)
	if status == 0 then
		StickCoupletController.instance:handlePM_StickCoupletStartGameRes(msg)
	end
end

function StickCoupletAgent:sendPM_StickCoupletEndGameReq(activityId, score, encryptedKey)
	local req = StickCoupletExtension_pb.PM_StickCoupletEndGameReq()

	req.activityId = activityId
	req.score = score
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function StickCoupletAgent:handlePM_StickCoupletEndGameRes(status, msg)
	if status == 0 then
		StickCoupletController.instance:handlePM_StickCoupletEndGameRes(msg)
	end
end

function StickCoupletAgent:sendPM_StickCoupletGainPrizeReq(activityId, prizeId)
	local req = StickCoupletExtension_pb.PM_StickCoupletGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function StickCoupletAgent:handlePM_StickCoupletGainPrizeRes(status, msg)
	if status == 0 then
		StickCoupletController.instance:handlePM_StickCoupletGainPrizeRes(msg)
	end
end

StickCoupletAgent.instance = StickCoupletAgent.New()

return StickCoupletAgent
