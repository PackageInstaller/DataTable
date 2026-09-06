-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signindaily/controller/SigninDailyController.lua

module("logic.extensions.signindaily.controller.SigninDailyController", package.seeall)

local SigninDailyController = class("SigninDailyController", BaseController)

function SigninDailyController:ctor()
	return
end

function SigninDailyController:onInit()
	return
end

function SigninDailyController:onReset()
	return
end

function SigninDailyController:getInfo(callback)
	if SigninDailyModel.instance:getHasGetData() and not self:getIfNewDay() then
		GameUtil.callBack(callback)
	else
		MonthSignInAgent.instance:sendPM_MonthSignInGetInfoReq(function(msg)
			SigninDailyModel.instance:setData(msg)
			SigninDailyModel.instance:setLastTimeStamp()
			GameUtil.callBack(callback, msg)
		end)
	end
end

function SigninDailyController:getIfNewDay()
	local lastTimeStamp = SigninDailyModel.instance:getLastTimeStamp()

	if lastTimeStamp then
		local lastTimeObj = GameUtil.time2date(lastTimeStamp)
		local lastWeekDay = lastTimeObj.wday
		local lastHour = lastTimeObj.hour

		if lastHour >= 0 and lastHour < 5 then
			lastWeekDay = lastWeekDay + 6
		end

		lastWeekDay = lastWeekDay % 7

		local curTime = GameUtil.time2date(ServerTime.now())
		local curWeekDay = curTime.wday
		local curHour = curTime.hour

		if curHour >= 0 and curHour < 5 then
			curWeekDay = curWeekDay + 6
		end

		curWeekDay = curWeekDay % 7

		return curWeekDay ~= lastWeekDay
	else
		return false
	end
end

function SigninDailyController:gainPrize(callback)
	MonthSignInAgent.instance:sendPM_GainMonthSignInPrizeReq(function(msg)
		SigninDailyModel.instance:setGasGainPrize(true)
		SigninDailyModel.instance:setPrizeProcess()
		GameUtil.callBack(callback, msg)
	end)
end

SigninDailyController.instance = SigninDailyController.New()

return SigninDailyController
