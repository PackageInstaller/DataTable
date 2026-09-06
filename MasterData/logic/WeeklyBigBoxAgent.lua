-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weeklybigbox/agent/WeeklyBigBoxAgent.lua

module("logic.extensions.weeklybigbox.agent.WeeklyBigBoxAgent", package.seeall)

local WeeklyBigBoxAgent = class("WeeklyBigBoxAgent", BaseAgent)

function WeeklyBigBoxAgent:sendPM_WeeklyBigBoxGetInfoReq()
	local req = WeeklyBigBoxExtension_pb.PM_WeeklyBigBoxGetInfoReq()

	self:sendMsg(req)
end

function WeeklyBigBoxAgent:handlePM_WeeklyBigBoxGetInfoRes(status, msg)
	WeeklyBigBoxController.instance:handleGetInfoRes(status, msg)
end

function WeeklyBigBoxAgent:sendPM_WeeklyBigBoxStartGameReq(clientKey)
	local req = WeeklyBigBoxExtension_pb.PM_WeeklyBigBoxStartGameReq()

	req.clientKey = clientKey

	self:sendMsg(req)
end

function WeeklyBigBoxAgent:handlePM_WeeklyBigBoxStartGameRes(status, msg)
	WeeklyBigBoxController.instance:handleStartGameRes(status, msg)
end

function WeeklyBigBoxAgent:sendPM_WeeklyBigBoxEndGameReq(redPackgeNum, encryptedKey)
	local req = WeeklyBigBoxExtension_pb.PM_WeeklyBigBoxEndGameReq()

	req.redPackgeNum = redPackgeNum
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function WeeklyBigBoxAgent:handlePM_WeeklyBigBoxEndGameRes(status, msg)
	WeeklyBigBoxController.instance:handleEndGameRes(status, msg)
end

function WeeklyBigBoxAgent:sendPM_WeeklyBigBoxOpenRedPackageReq()
	local req = WeeklyBigBoxExtension_pb.PM_WeeklyBigBoxOpenRedPackageReq()

	self:sendMsg(req)
end

function WeeklyBigBoxAgent:handlePM_WeeklyBigBoxOpenRedPackageRes(status, msg)
	WeeklyBigBoxController.instance:handleOpenRedPackageRes(status, msg)
end

WeeklyBigBoxAgent.instance = WeeklyBigBoxAgent.New()

return WeeklyBigBoxAgent
