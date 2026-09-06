-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruilottery/agent/FanRuiLotteryAgent.lua

module("logic.extensions.fanruilottery.agent.FanRuiLotteryAgent", package.seeall)

local FanRuiLotteryAgent = class("FanRuiLotteryAgent", BaseAgent)

FanRuiLotteryAgent.handlePM_FanRuiLotteryGetInfoRes = "FanRuiLotteryAgent.handlePM_FanRuiLotteryGetInfoRes"
FanRuiLotteryAgent.handlePM_FanRuiLotteryLotteryRes = "FanRuiLotteryAgent.handlePM_FanRuiLotteryLotteryRes"
FanRuiLotteryAgent.handlePM_FanRuiLotteryStartGameRes = "FanRuiLotteryAgent.handlePM_FanRuiLotteryStartGameRes"
FanRuiLotteryAgent.handlePM_FanRuiLotteryEndGameRes = "FanRuiLotteryAgent.handlePM_FanRuiLotteryEndGameRes"
FanRuiLotteryAgent.handlePM_FanRuiLotteryExchangeRes = "FanRuiLotteryAgent.handlePM_FanRuiLotteryGetInfoRes"

function FanRuiLotteryAgent:sendPM_FanRuiLotteryGetInfoReq(actId)
	local req = FanRuiLotteryExtension_pb.PM_FanRuiLotteryGetInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function FanRuiLotteryAgent:handlePM_FanRuiLotteryGetInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(FanRuiLotteryAgent.handlePM_FanRuiLotteryGetInfoRes, msg)
	end
end

function FanRuiLotteryAgent:sendPM_FanRuiLotteryLotteryReq(actId)
	local req = FanRuiLotteryExtension_pb.PM_FanRuiLotteryLotteryReq()

	req.actId = actId

	self:sendMsg(req)
end

function FanRuiLotteryAgent:handlePM_FanRuiLotteryLotteryRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(FanRuiLotteryAgent.handlePM_FanRuiLotteryLotteryRes, msg)
	end
end

function FanRuiLotteryAgent:sendPM_FanRuiLotteryStartGameReq(actId, useCheatItem, chipCount, clientKey)
	local req = FanRuiLotteryExtension_pb.PM_FanRuiLotteryStartGameReq()

	req.actId = actId
	req.useCheatItem = useCheatItem
	req.chipCount = chipCount
	req.clientKey = clientKey

	self:sendMsg(req)
end

function FanRuiLotteryAgent:handlePM_FanRuiLotteryStartGameRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(FanRuiLotteryAgent.handlePM_FanRuiLotteryStartGameRes, msg)
	end
end

function FanRuiLotteryAgent:sendPM_FanRuiLotteryEndGameReq(actId, isWin, encryptedKey)
	local req = FanRuiLotteryExtension_pb.PM_FanRuiLotteryEndGameReq()

	req.actId = actId
	req.isWin = isWin
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function FanRuiLotteryAgent:handlePM_FanRuiLotteryEndGameRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(FanRuiLotteryAgent.handlePM_FanRuiLotteryEndGameRes, msg)
	end
end

function FanRuiLotteryAgent:sendPM_FanRuiLotteryExchangeReq(actId)
	local req = FanRuiLotteryExtension_pb.PM_FanRuiLotteryExchangeReq()

	req.actId = actId

	self:sendMsg(req)
end

function FanRuiLotteryAgent:handlePM_FanRuiLotteryExchangeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(FanRuiLotteryAgent.handlePM_FanRuiLotteryExchangeRes, msg)
	end
end

function FanRuiLotteryAgent:sendPM_FanRuiLotteryExitGameReq(actId)
	local req = FanRuiLotteryExtension_pb.PM_FanRuiLotteryExitGameReq()

	req.actId = actId

	self:sendMsg(req)
end

function FanRuiLotteryAgent:handlePM_FanRuiLotteryExitGameRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

FanRuiLotteryAgent.instance = FanRuiLotteryAgent.New()

return FanRuiLotteryAgent
