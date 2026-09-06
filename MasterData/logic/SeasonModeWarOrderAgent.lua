-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/agent/SeasonModeWarOrderAgent.lua

module("logic.extensions.seasonmodewarorder.agent.SeasonModeWarOrderAgent", package.seeall)

local SeasonModeWarOrderAgent = class("SeasonModeWarOrderAgent", BaseAgent)

function SeasonModeWarOrderAgent:sendPM_SMPVEWarOrderInfoReq()
	local req = SeasonModeWarOrderExtension_pb.PM_SMPVEWarOrderInfoReq()

	self:sendMsg(req)
end

function SeasonModeWarOrderAgent:handlePM_SMPVEWarOrderInfoRes(status, msg)
	SeasonModeWarOrderController.instance:handleSMPVEWarOrderInfoRes(status, msg)
end

function SeasonModeWarOrderAgent:sendPM_SMPVEWarOrderBuyLevelReq(targetLevel)
	local req = SeasonModeWarOrderExtension_pb.PM_SMPVEWarOrderBuyLevelReq()

	req.targetLevel = targetLevel

	self:sendMsg(req)
end

function SeasonModeWarOrderAgent:handlePM_SMPVEWarOrderBuyLevelRes(status, msg)
	SeasonModeWarOrderController.instance:handleSMPVEWarOrderBuyLevelRes(status, msg)
end

function SeasonModeWarOrderAgent:sendPM_SMPVEWarOrderGainPrizeReq(isSuper, prizeId)
	local req = SeasonModeWarOrderExtension_pb.PM_SMPVEWarOrderGainPrizeReq()

	req.isSuper = isSuper
	req.prizeId = prizeId

	self:sendMsg(req)
end

function SeasonModeWarOrderAgent:handlePM_SMPVEWarOrderGainPrizeRes(status, msg)
	SeasonModeWarOrderController.instance:handleSMPVEWarOrderGainPrizeRes(status, msg)
end

function SeasonModeWarOrderAgent:sendPM_SMPVEWarOrderOneKeyGainPrizeReq()
	local req = SeasonModeWarOrderExtension_pb.PM_SMPVEWarOrderOneKeyGainPrizeReq()

	self:sendMsg(req)
end

function SeasonModeWarOrderAgent:handlePM_SMPVEWarOrderOneKeyGainPrizeRes(status, msg)
	SeasonModeWarOrderController.instance:handleSMPVEWarOrderOneKeyGainPrizeRes(status, msg)
end

function SeasonModeWarOrderAgent:sendPM_SMPVEWarOrderRecoverReq()
	local req = SeasonModeWarOrderExtension_pb.PM_SMPVEWarOrderRecoverReq()

	self:sendMsg(req)
end

function SeasonModeWarOrderAgent:handlePM_SMPVEWarOrderRecoverRes(status, msg)
	SeasonModeWarOrderController.instance:handleSMPVEWarOrderRecoverRes(status, msg)
end

function SeasonModeWarOrderAgent:sendPM_SMPVEWarOrderTaskInfoReq()
	local req = SeasonModeWarOrderExtension_pb.PM_SMPVEWarOrderTaskInfoReq()

	self:sendMsg(req)
end

function SeasonModeWarOrderAgent:handlePM_SMPVEWarOrderTaskInfoRes(status, msg)
	SeasonModeWarOrderController.instance:handleSMPVEWarOrderTaskInfoRes(status, msg)
end

function SeasonModeWarOrderAgent:sendPM_SMPVEWarOrderGainTaskPrizeReq(taskId)
	local req = SeasonModeWarOrderExtension_pb.PM_SMPVEWarOrderGainTaskPrizeReq()

	req.taskId = taskId

	self:sendMsg(req)
end

function SeasonModeWarOrderAgent:handlePM_SMPVEWarOrderGainTaskPrizeRes(status, msg)
	SeasonModeWarOrderController.instance:handleSMPVEWarOrderGainTaskPrizeRes(status, msg)
end

function SeasonModeWarOrderAgent:sendPM_SMPVEWarOrderLotteryReq()
	local req = SeasonModeWarOrderExtension_pb.PM_SMPVEWarOrderLotteryReq()

	self:sendMsg(req)
end

function SeasonModeWarOrderAgent:handlePM_SMPVEWarOrderLotteryRes(status, msg)
	SeasonModeWarOrderController.instance:handleSMPVEWarOrderLotteryRes(status, msg)
end

function SeasonModeWarOrderAgent:handlePM_SMPVENotifyBuyWarOrderRes(status, msg)
	SeasonModeWarOrderController.instance:handleSMPVENotifyBuyWarOrderRes(status, msg)
end

function SeasonModeWarOrderAgent:sendPM_SMPVEWarOrderGainFinalPrizeReq()
	local req = SeasonModeWarOrderExtension_pb.PM_SMPVEWarOrderGainFinalPrizeReq()

	self:sendMsg(req)
end

function SeasonModeWarOrderAgent:handlePM_SMPVEWarOrderGainFinalPrizeRes(status, msg)
	SeasonModeWarOrderController.instance:handleSMPVEWarOrderGainFinalPrizeRes(status, msg)
end

SeasonModeWarOrderAgent.instance = SeasonModeWarOrderAgent.New()

return SeasonModeWarOrderAgent
