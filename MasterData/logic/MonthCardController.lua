-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/controller/MonthCardController.lua

module("logic.extensions.monthcard.controller.MonthCardController", package.seeall)

local MonthCardController = class("MonthCardController", BaseController)

function MonthCardController:ctor()
	return
end

function MonthCardController:onInit()
	GlobalDispatcher:addListener(MonthCardAgent.PM_MonthCardGainDailyPrizeRes, self._PM_MonthCardGainDailyPrizeRes, self)
	GlobalDispatcher:addListener(MonthCardAgent.PM_NotifyMonthCardBuySucRes, self._PM_NotifyMonthCardBuySucRes, self)
	GlobalDispatcher:addListener(MonthCardAgent.PM_NotifyMonthCardsBuySucRes, self._PM_NotifyMonthCardsBuySucRes, self)
	GlobalDispatcher:addListener(GlobalNotify.RoleInfoPushed, self._calculateRedDot, self)
	GlobalDispatcher:addListener(GlobalNotify.ServerTimeSync, self._calDisabledTime, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._checkRefreshTime, self)
end

function MonthCardController:onReset()
	return
end

function MonthCardController:_checkRefreshTime()
	local infos = RoleModel.instance:getMontchCardStates()
	local nowTime = ServerTime.now()

	if infos then
		for k, v in ipairs(infos) do
			local dtime = RoleModel.instance:getMonthcardDisabledTime(v.cardId)

			if v.restDay > 0 and (dtime <= 0 or nowTime < dtime) then
				v.hasGainPrize = false
			end
		end
	end

	GlobalDispatcher:dispatch(MonthCardModel.CarStatesChange)
	MonthCardModel.instance:calculateRedDot()
end

function MonthCardController:_calculateRedDot()
	MonthCardModel.instance:calculateRedDot()
end

function MonthCardController:_PM_MonthCardGainDailyPrizeRes(status, msg)
	if status == 0 then
		MonthCardModel.instance:GainDailyPrizeRes(msg.cardId)
		MonthCardModel.instance:calculateRedDot()
		GlobalDispatcher:dispatch(MonthCardModel.CarStatesChange)
	end
end

function MonthCardController:_PM_NotifyMonthCardBuySucRes(status, msg)
	if status == 0 then
		MonthCardModel.instance:setBuyCardSuccessed(msg)
		MonthCardModel.instance:calculateRedDot()
		ActivityPopupController.instance:onBuyCheckLuoshiqi()
		GlobalDispatcher:dispatch(MonthCardModel.CarStatesChange)
	end
end

function MonthCardController:_PM_NotifyMonthCardsBuySucRes(status, msg)
	if status == 0 then
		for i, v in ipairs(msg.cardInfos) do
			self:_PM_NotifyMonthCardBuySucRes(status, v)
		end
	end
end

function MonthCardController:_calDisabledTime()
	RoleModel.instance:calMonthcardDisabledTime()
end

MonthCardController.instance = MonthCardController.New()

return MonthCardController
