-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lingshenconvene/agent/LingShenConveneAgent.lua

module("logic.extensions.lingshenconvene.agent.LingShenConveneAgent", package.seeall)

local LingShenConveneAgent = class("LingShenConveneAgent", BaseAgent)

function LingShenConveneAgent:sendPM_LingShenConveneGetInfoReq(activityId)
	local req = LingShenConveneExtension_pb.PM_LingShenConveneGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LingShenConveneAgent:handlePM_LingShenConveneGetInfoRes(status, msg)
	if status == 0 then
		LingShenConveneController.instance:handlePM_LingShenConveneGetInfoRes(msg)
	end
end

function LingShenConveneAgent:sendPM_LingShenConveneUnlockReq(activityId, tabId, iconId)
	local req = LingShenConveneExtension_pb.PM_LingShenConveneUnlockReq()

	req.activityId = activityId
	req.tabId = tabId
	req.iconId = iconId

	self:sendMsg(req)
end

function LingShenConveneAgent:handlePM_LingShenConveneUnlockRes(status, msg)
	if status == 0 then
		LingShenConveneController.instance:handlePM_LingShenConveneUnlockRes(msg)
	end
end

function LingShenConveneAgent:sendPM_LingShenConveneGainProgressPrizeReq(activityId, prizeId)
	local req = LingShenConveneExtension_pb.PM_LingShenConveneGainProgressPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function LingShenConveneAgent:handlePM_LingShenConveneGainProgressPrizeRes(status, msg)
	if status == 0 then
		LingShenConveneController.instance:handlePM_LingShenConveneGainProgressPrizeRes(msg)
	end
end

function LingShenConveneAgent:sendPM_LingShenConveneGainPrizeReq(activityId, prizeId)
	local req = LingShenConveneExtension_pb.PM_LingShenConveneGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function LingShenConveneAgent:handlePM_LingShenConveneGainPrizeRes(status, msg)
	if status == 0 then
		LingShenConveneController.instance:handlePM_LingShenConveneGainPrizeRes(msg)
	end
end

LingShenConveneAgent.instance = LingShenConveneAgent.New()

return LingShenConveneAgent
