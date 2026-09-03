-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/monthSignIn/controller/MonthSignInSystem.lua

EVT_MONTHSIGNIN_RESET_DONE = "EVT_MONTHSIGNIN_RESET_DONE"

require("dm.gameplay.monthSignIn.model.MonthSignIn")
require("dm.gameplay.monthSignIn.controller.ResetUtils")

MonthSignInSystem = class("MonthSignInSystem", legs.Actor)

MonthSignInSystem:has("_monthSignInService", {
	is = "r"
}):injectWith("MonthSignInService")
MonthSignInSystem:has("_monthSignModel", {
	is = "r"
})

function MonthSignInSystem:initialize()
	super.initialize(self)

	self._monthSignModel = MonthSignIn:new()
	self._totalRewardTab = {}

	local _rawTab = ConfigReader:getDataByNameIdAndKey("ConfigValue", "CheckInRewardTotal", "content")

	for k, v in pairs(_rawTab) do
		local makePair = {}

		makePair.day = tonumber(k)
		makePair.rewardId = v
		self._totalRewardTab[#self._totalRewardTab + 1] = makePair
	end

	table.sort(self._totalRewardTab, function(a, b)
		local aCompFactor = a.day
		local bCompFactor = b.day

		return aCompFactor < bCompFactor
	end)
end

function MonthSignInSystem:syncTodayReward()
	local customDataSystem = self:getInjector():getInstance(CustomDataSystem)
	local cjson = require("cjson.safe")
	local rewardStr = customDataSystem:getValue(PrefixType.kGlobal, "todayReward")

	if not rewardStr then
		local playerId = self:getInjector():getInstance("DevelopSystem"):getPlayer():getRid()

		rewardStr = cc.UserDefault:getInstance():getStringForKey(tostring(playerId) .. "todayReward")
	end

	self._monthSignModel:setTodayReward(cjson.decode(rewardStr))
end

function MonthSignInSystem:tryEnter(succcallback, failcallback)
	self:openView()
end

function MonthSignInSystem:getTodayLuck()
	return self._monthSignModel:getTodayLuck()
end

function MonthSignInSystem:getCheckinSum()
	return self._monthSignModel:getCheckinSum()
end

function MonthSignInSystem:getGotRewards()
	return self._monthSignModel:getGotRewards()
end

function MonthSignInSystem:getTodaySignTime()
	local dailyReset = self._monthSignModel:getDailyReset()

	return dailyReset.updateTime
end

function MonthSignInSystem:isTodaySign()
	local curUpdateTime = self:getTodaySignTime()
	local curDayTime = TimeUtil:getTimeByDateForTargetTimeInToday({
		sec = 0,
		min = 0,
		hour = 5
	})
	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local curTime = gameServerAgent:remoteTimestamp()

	if curTime < curDayTime then
		return curUpdateTime >= curDayTime - 86400
	else
		return curDayTime <= curUpdateTime
	end
end

function MonthSignInSystem:showSignView(callback)
	if not self:isTodaySign() then
		self:openView(callback)
	end
end

function MonthSignInSystem:openView(callback)
	local viewName = "MonthSignInView"
	local isActivity, actUI = self:checkActivity()

	if isActivity then
		if actUI == ActivityType_UI.kActivityBlockWsj then
			viewName = "MonthSignInWsjView"
		elseif actUI == ActivityType_UI.KActivityBlockHoliday then
			viewName = "MonthSignInHolidayView"
		end
	end

	local view = self:getInjector():getInstance(viewName)

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, nil, callback))
end

function MonthSignInSystem:checkActivity()
	local activitySystem = self:getInjector():getInstance(ActivitySystem)
	local activity = activitySystem:getActivityByComplexUI(ActivityType_UI.kActivityBlockWsj)

	if activity then
		return true, ActivityType_UI.kActivityBlockWsj
	end

	local activity = activitySystem:getActivityByComplexUI(ActivityType_UI.KActivityBlockHoliday)

	if activity then
		return true, ActivityType_UI.KActivityBlockHoliday
	end

	return false
end

function MonthSignInSystem:doReset(resetId, value)
	if resetId == ResetId.kMonthSignIn then
		-- block empty
	end
end

function MonthSignInSystem:getTodayReward()
	return self._monthSignModel:getTodayReward()
end

function MonthSignInSystem:setTodayReward(reward)
	local cjson = require("cjson.safe")
	local rewardStr = cjson.encode(reward)
	local customDataSystem = self:getInjector():getInstance(CustomDataSystem)

	customDataSystem:setValue(PrefixType.kGlobal, "todayReward", rewardStr)
end

function MonthSignInSystem:setTodayRandomNum()
	local playerId = self:getInjector():getInstance("DevelopSystem"):getPlayer():getRid()
	local todayLuck = self:getTodayLuck()
	local content = ConfigReader:getDataByNameIdAndKey("ConfigValue", "CheckInDesc", "content")
	local tab = content[tostring(todayLuck)]
	local randomNum = math.random(1, #tab)

	cc.UserDefault:getInstance():setIntegerForKey(tostring(playerId) .. "todayRandomNum", randomNum)
end

function MonthSignInSystem:getTodayRandomNum()
	local playerId = self:getInjector():getInstance("DevelopSystem"):getPlayer():getRid()

	return (cc.UserDefault:getInstance():getIntegerForKey(tostring(playerId) .. "todayRandomNum", 1))
end

function MonthSignInSystem:getTodayLuckDesc()
	local todayLuck = self:getTodayLuck()
	local content = ConfigReader:getDataByNameIdAndKey("ConfigValue", "CheckInDesc", "content")
	local tab = content[tostring(todayLuck)]
	local todayNum = self:getTodayRandomNum()

	return tab[todayNum]
end

function MonthSignInSystem:requestGetDailyReward(callback, failCallback)
	local params = {}

	self._monthSignInService:requestGetDailyReward(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			if response.data.reward then
				self._monthSignModel:setTodayReward(response.data.reward)
				self:setTodayReward(response.data.reward)
			end

			self:setTodayRandomNum()

			if callback then
				callback(response)
			end
		elseif failCallback then
			failCallback(response)
		end
	end)
end
