-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/agent/MonthCardAgent.lua

module("logic.extensions.monthcard.agent.MonthCardAgent", package.seeall)

local MonthCardAgent = class("MonthCardAgent", BaseAgent)

MonthCardAgent.PM_MonthCardGainDailyPrizeRes = "MonthCardAgent_PM_MonthCardGainDailyPrizeRes"
MonthCardAgent.PM_NotifyMonthCardBuySucRes = "MonthCardAgent_PM_NotifyMonthCardBuySucRes"
MonthCardAgent.PM_NotifyMonthCardsBuySucRes = "MonthCardAgent.PM_NotifyMonthCardsBuySucRes"

function MonthCardAgent:ctor()
	return
end

function MonthCardAgent:setExtId(extId)
	MonthCardAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function MonthCardAgent:sendPM_MonthCardGainDailyPrizeReq(cardId, handler, handlerObj, errHandler)
	local req = MonthCardExtension_pb.PM_MonthCardGainDailyPrizeReq()

	req.cardId = cardId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MonthCardAgent.PM_MonthCardGainDailyPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MonthCardAgent:handlePM_MonthCardGainDailyPrizeRes(status, msg)
	self:dispatch(MonthCardAgent.PM_MonthCardGainDailyPrizeRes, status, msg)
end

function MonthCardAgent:handlePM_NotifyMonthCardBuySucRes(status, msg)
	self:dispatch(MonthCardAgent.PM_NotifyMonthCardBuySucRes, status, msg)
end

function MonthCardAgent:handlePM_NotifyMonthCardsBuySucRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(MonthCardAgent.PM_NotifyMonthCardsBuySucRes, status, msg)
end

MonthCardAgent.instance = MonthCardAgent.New()

return MonthCardAgent
