-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldendiamondcard/agent/GoldenDiamondCardAgent.lua

module("logic.extensions.goldendiamondcard.agent.GoldenDiamondCardAgent", package.seeall)

local GoldenDiamondCardAgent = class("GoldenDiamondCardAgent", BaseAgent)

function GoldenDiamondCardAgent:sendPM_GoldenDiamondCardGetInfoReq()
	forcePrint("==========LoginController._enterGame=======GoldenDiamondCardAgent:sendPM_GoldenDiamondCardGetInfoReq====")

	local req = GoldenDiamondCardExtension_pb.PM_GoldenDiamondCardGetInfoReq()

	self:sendMsg(req)
end

function GoldenDiamondCardAgent:handlePM_GoldenDiamondCardGetInfoRes(status, msg)
	forcePrint("==========LoginController._enterGame=======GoldenDiamondCardAgent:sendPM_GoldenDiamondCardGetInfoReq====back")

	if status == 0 then
		GoldenDiamondCardController.instance:handleGetInfo(msg)
	end
end

function GoldenDiamondCardAgent:sendPM_GoldenDiamondCardGainDailyPrizeReq()
	local req = GoldenDiamondCardExtension_pb.PM_GoldenDiamondCardGainDailyPrizeReq()

	self:sendMsg(req)
end

function GoldenDiamondCardAgent:handlePM_GoldenDiamondCardGainDailyPrizeRes(status, msg)
	if status == 0 then
		GoldenDiamondCardController.instance:handleGainDailyPrize(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.DiamondCardGainDailyPrize, status, msg)
end

function GoldenDiamondCardAgent:handlePM_GoldenDiamondCardInfo(status, msg)
	if status == 0 then
		GoldenDiamondCardController.instance:handleonPaySuc(msg)
	end
end

function GoldenDiamondCardAgent:handlePM_NotifyGoldenDiamondPrivilegeChangeRes(status, msg)
	if status == 0 then
		GoldenDiamondCardController.instance:handlePrivilegeInfoChange(msg)
	end
end

GoldenDiamondCardAgent.instance = GoldenDiamondCardAgent.New()

return GoldenDiamondCardAgent
