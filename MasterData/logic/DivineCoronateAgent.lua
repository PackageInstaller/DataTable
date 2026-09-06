-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinecoronate/agent/DivineCoronateAgent.lua

module("logic.extensions.divinecoronate.agent.DivineCoronateAgent", package.seeall)

local DivineCoronateAgent = class("DivineCoronateAgent", BaseAgent)

function DivineCoronateAgent:sendPM_DivineCoronateGetInfoReq(activityId)
	local req = DivineCoronateExtension_pb.PM_DivineCoronateGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineCoronateAgent:handlePM_DivineCoronateGetInfoRes(status, msg)
	if status == 0 then
		DivineCoronateModel.instance:onDivineCoronateGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineCoronateGetInfoRes)
	end
end

function DivineCoronateAgent:sendPM_DivineCoronateStartGameReq(activityId, clientKey)
	local req = DivineCoronateExtension_pb.PM_DivineCoronateStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function DivineCoronateAgent:handlePM_DivineCoronateStartGameRes(status, msg)
	if status == 0 then
		DivineCoronateModel.instance:DivineCoronateStartGameRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineCoronateStartGameRes)
	end
end

function DivineCoronateAgent:sendPM_DivineCoronateEndGameReq(activityId, isWin, encryptedKey)
	local req = DivineCoronateExtension_pb.PM_DivineCoronateEndGameReq()

	req.activityId = activityId
	req.isWin = isWin
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function DivineCoronateAgent:handlePM_DivineCoronateEndGameRes(status, msg)
	if status == 0 then
		DivineCoronateModel.instance:onDivineCoronateEndGameRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineCoronateEndGameRes)
	end
end

function DivineCoronateAgent:sendPM_DivineCoronateGainPrizeReq(activityId, tabId)
	local req = DivineCoronateExtension_pb.PM_DivineCoronateGainPrizeReq()

	req.activityId = activityId
	req.tabId = tabId

	self:sendMsg(req)
end

function DivineCoronateAgent:handlePM_DivineCoronateGainPrizeRes(status, msg)
	if status == 0 then
		DivineCoronateModel.instance:onDivineCoronateGainPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineCoronateGainPrizeRes)
	end
end

DivineCoronateAgent.instance = DivineCoronateAgent.New()

return DivineCoronateAgent
