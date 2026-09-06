-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/warriortower/agent/WarriorTowerAgent.lua

module("logic.extensions.warriortower.agent.WarriorTowerAgent", package.seeall)

local WarriorTowerAgent = class("WarriorTowerAgent", BaseAgent)

WarriorTowerAgent.UserTowerInfoRes = "WarriorTowerAgent_UserTowerInfoRes"
WarriorTowerAgent.FightRes = "WarriorTowerAgent_FightRes"
WarriorTowerAgent.GainProgressPrizeRes = "WarriorTowerAgent_GainProgressPrizeRes"
WarriorTowerAgent.AfterFightRes = "WarriorTowerAgent_AfterFightRes"
WarriorTowerAgent.GetWarriorTowerRankInfoRes = "WarriorTowerAgent_GetWarriorTowerRankInfoRes"
WarriorTowerAgent.SetWarriorTowerFormRes = "WarriorTowerAgent_SetWarriorTowerFormRes"
WarriorTowerAgent.GetWarriorTowerFormRes = "WarriorTowerAgent_GetWarriorTowerFormRes"
WarriorTowerAgent.GetWarriorTowerProfitInfoRes = "WarriorTowerAgent_GetWarriorTowerProfitInfoRes"
WarriorTowerAgent.GainWarriorTowerProfitPrizeRes = "WarriorTowerAgent_GainWarriorTowerProfitPrizeRes"
WarriorTowerAgent.TurnTimeWarriorTowerRes = "WarriorTowerAgent_TurnTimeWarriorTowerRes"
WarriorTowerAgent.GetWarriorMainTowerProgressRes = "WarriorTowerAgent_GetWarriorMainTowerProgressRes"
WarriorTowerAgent.WarriorTowerAutoFightRes = "WarriorTowerAgent_WarriorTowerAutoFightRes"

function WarriorTowerAgent:ctor()
	return
end

function WarriorTowerAgent:setExtId(extId)
	WarriorTowerAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function WarriorTowerAgent:sendUserTowerInfoReq(handler, handlerObj, errHandler)
	local req = WarriorTowerExtension_pb.UserTowerInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(WarriorTowerAgent.UserTowerInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function WarriorTowerAgent:handleUserTowerInfoRes(status, msg)
	self:dispatch(WarriorTowerAgent.UserTowerInfoRes, status, msg)
end

function WarriorTowerAgent:sendFightReq(towerId, handler, handlerObj, errHandler)
	local req = WarriorTowerExtension_pb.FightReq()

	req.towerId = towerId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(WarriorTowerAgent.FightRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function WarriorTowerAgent:handleFightRes(status, msg)
	self:dispatch(WarriorTowerAgent.FightRes, status, msg)
end

function WarriorTowerAgent:sendGainProgressPrizeReq(towerId, handler, handlerObj, errHandler)
	local req = WarriorTowerExtension_pb.GainProgressPrizeReq()

	req.towerId = towerId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(WarriorTowerAgent.GainProgressPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function WarriorTowerAgent:handleGainProgressPrizeRes(status, msg)
	self:dispatch(WarriorTowerAgent.GainProgressPrizeRes, status, msg)
end

function WarriorTowerAgent:handleAfterFightRes(status, msg)
	self:dispatch(WarriorTowerAgent.AfterFightRes, status, msg)
end

function WarriorTowerAgent:sendGetWarriorTowerRankInfoReq(towerId, handler, handlerObj, errHandler)
	local req = WarriorTowerExtension_pb.GetWarriorTowerRankInfoReq()

	req.towerId = towerId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(WarriorTowerAgent.GetWarriorTowerRankInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function WarriorTowerAgent:handleGetWarriorTowerRankInfoRes(status, msg)
	self:dispatch(WarriorTowerAgent.GetWarriorTowerRankInfoRes, status, msg)
end

function WarriorTowerAgent:sendSetWarriorTowerFormReq(towerId, simpleForm_pb, handler, handlerObj, errHandler)
	local req = WarriorTowerExtension_pb.SetWarriorTowerFormReq()

	req.towerId = towerId

	if simpleForm_pb ~= nil then
		req.simpleForm:ParseFromString(simpleForm_pb:SerializeToString())
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(WarriorTowerAgent.SetWarriorTowerFormRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function WarriorTowerAgent:handleSetWarriorTowerFormRes(status, msg)
	self:dispatch(WarriorTowerAgent.SetWarriorTowerFormRes, status, msg)
end

function WarriorTowerAgent:sendGetWarriorTowerFormReq(towerId, handler, handlerObj, errHandler)
	local req = WarriorTowerExtension_pb.GetWarriorTowerFormReq()

	req.towerId = towerId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(WarriorTowerAgent.GetWarriorTowerFormRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function WarriorTowerAgent:handleGetWarriorTowerFormRes(status, msg)
	self:dispatch(WarriorTowerAgent.GetWarriorTowerFormRes, status, msg)
end

function WarriorTowerAgent:sendGetWarriorTowerProfitInfoReq(handler, handlerObj, errHandler)
	local req = WarriorTowerExtension_pb.GetWarriorTowerProfitInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(WarriorTowerAgent.GetWarriorTowerProfitInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function WarriorTowerAgent:handleGetWarriorTowerProfitInfoRes(status, msg)
	self:dispatch(WarriorTowerAgent.GetWarriorTowerProfitInfoRes, status, msg)
end

function WarriorTowerAgent:sendGainWarriorTowerProfitPrizeReq(handler, handlerObj, errHandler)
	local req = WarriorTowerExtension_pb.GainWarriorTowerProfitPrizeReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(WarriorTowerAgent.GainWarriorTowerProfitPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function WarriorTowerAgent:handleGainWarriorTowerProfitPrizeRes(status, msg)
	self:dispatch(WarriorTowerAgent.GainWarriorTowerProfitPrizeRes, status, msg)
end

function WarriorTowerAgent:sendTurnTimeWarriorTowerReq(useFreeTimes, handler, handlerObj, errHandler)
	local req = WarriorTowerExtension_pb.TurnTimeWarriorTowerReq()

	req.useFreeTimes = useFreeTimes

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(WarriorTowerAgent.TurnTimeWarriorTowerRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function WarriorTowerAgent:handleTurnTimeWarriorTowerRes(status, msg)
	self:dispatch(WarriorTowerAgent.TurnTimeWarriorTowerRes, status, msg)
end

function WarriorTowerAgent:sendGetWarriorMainTowerProgressReq(handler, handlerObj, errHandler)
	local req = WarriorTowerExtension_pb.GetWarriorMainTowerProgressReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(WarriorTowerAgent.GetWarriorMainTowerProgressRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function WarriorTowerAgent:handleGetWarriorMainTowerProgressRes(status, msg)
	self:dispatch(WarriorTowerAgent.GetWarriorMainTowerProgressRes, status, msg)
end

function WarriorTowerAgent:sendWarriorTowerAutoFightReq(towerId, handler, handlerObj, errHandler)
	local req = WarriorTowerExtension_pb.WarriorTowerAutoFightReq()

	req.towerId = towerId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(WarriorTowerAgent.WarriorTowerAutoFightRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function WarriorTowerAgent:handleWarriorTowerAutoFightRes(status, msg)
	self:dispatch(WarriorTowerAgent.WarriorTowerAutoFightRes, status, msg)
end

WarriorTowerAgent.instance = WarriorTowerAgent.New()

return WarriorTowerAgent
