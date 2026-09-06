-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/userdata/controller/LocalUserDataController.lua

module("logic.extensions.userdata.controller.LocalUserDataController", package.seeall)

local LocalUserDataController = class("LocalUserDataController", BaseController)
local json = require("cjson")
local KEY_GLOBAL_PRE = "Local_Global_"
local KEY_DAY_PRE = "Local_Day_"
local KEY_WEEK_PRE = "Local_Week_"
local KEY_MONTH_PRE = "Local_Month_"

function LocalUserDataController:ctor()
	self.callBackList = {}
	self.temGetGlobalList = {}
	self.temGetDayList = {}
	self.temGetWeekList = {}
	self.temGetMonthList = {}
	self.temSetGlobalList = {}
	self.temSetDayList = {}
	self.temSetWeekList = {}
	self.temSetMonthList = {}
end

function LocalUserDataController:onInit()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.init, self)
	self:onReset()
end

function LocalUserDataController:onReset()
	self.isStart = false
	self.userGlobalData = nil
	self.userDayData = nil
	self.userWeekData = nil
	self.userMonthData = nil
end

function LocalUserDataController:start()
	self.isStart = true

	self:init()
	self:doAllTemp()

	for k, callBack in pairs(self.callBackList) do
		GameUtil.callBack(callBack)
	end
end

function LocalUserDataController:whenLocalDataInited(callBack)
	table.insert(self.callBackList, callBack)
end

function LocalUserDataController:doAllTemp()
	for key, arr in pairs(self.temGetGlobalList) do
		for _, callBack in pairs(arr) do
			self:getUserData(key, callBack)
		end
	end

	self.temGetGlobalList = {}

	for key, arr in pairs(self.temGetDayList) do
		for _, callBack in pairs(arr) do
			self:getUserDayData(key, callBack)
		end
	end

	self.temGetDayList = {}

	for key, arr in pairs(self.temGetWeekList) do
		for _, callBack in pairs(arr) do
			self:getUserWeekData(key, callBack)
		end
	end

	self.temGetWeekList = {}

	for key, arr in pairs(self.temGetMonthList) do
		for _, callBack in pairs(arr) do
			self:getUserMonthData(key, callBack)
		end
	end

	self.temGetMonthList = {}

	for key, value in pairs(self.temSetGlobalList) do
		self:saveUserData(key, value)
	end

	self.temSetGlobalList = {}

	for key, value in pairs(self.temSetDayList) do
		self:saveUserDayData(key, value)
	end

	self.temSetDayList = {}

	for key, value in pairs(self.temSetWeekList) do
		self:saveUserWeekData(key, value)
	end

	self.temSetWeekList = {}

	for key, value in pairs(self.temSetMonthList) do
		self:saveUserMonthData(key, value)
	end

	self.temSetMonthList = {}
end

function LocalUserDataController:init()
	local serverTime = ServerTime.now()

	serverTime = serverTime - 18000

	local dayVer = GameUtil.formatTimeStamp("%Y%m%d", serverTime)
	local weekVer = GameUtil.formatTimeStamp("%Y%W", serverTime + 259200)
	local monthVer = GameUtil.formatTimeStamp("%Y%m", serverTime)
	local dayStr = GameUtil.getLocalString(KEY_DAY_PRE .. self:getUserId(), "")
	local weekStr = GameUtil.getLocalString(KEY_WEEK_PRE .. self:getUserId(), "")
	local monthStr = GameUtil.getLocalString(KEY_MONTH_PRE .. self:getUserId(), "")
	local globalStr = GameUtil.getLocalString(KEY_GLOBAL_PRE .. self:getUserId(), "")

	print(">>>初始本地存储数据 day:", dayVer, "week:", weekVer)

	self.userGlobalData = globalStr ~= nil and globalStr ~= "" and json.decode(globalStr) or {}
	self.userDayData = dayStr ~= nil and dayStr ~= "" and json.decode(dayStr) or {}

	if self.userDayData.ver ~= dayVer then
		self.userDayData.ver = dayVer
		self.userDayData.data = {}

		self:writeUserDayData()
	end

	self.userWeekData = weekStr ~= nil and weekStr ~= "" and json.decode(weekStr) or {}

	if self.userWeekData.ver ~= weekVer then
		self.userWeekData.ver = weekVer
		self.userWeekData.data = {}

		self:writeUserWeekData()
	end

	self.userMonthData = monthStr ~= nil and monthStr ~= "" and json.decode(monthStr) or {}

	if self.userMonthData.ver ~= monthVer then
		self.userMonthData.ver = monthVer
		self.userMonthData.data = {}

		self:writeUserMonthData()
	end
end

function LocalUserDataController:getUserMonthData(key, callBack)
	if self.isStart then
		local data = self.userMonthData.data

		GameUtil.callBack(callBack, data[key])

		return data[key]
	else
		self.temGetMonthList[key] = self.temGetMonthList[key] or {}

		table.insert(self.temGetMonthList[key], callBack)
	end

	return nil
end

function LocalUserDataController:saveUserMonthData(key, value)
	if self.isStart then
		self.userMonthData.data[key] = value

		self:writeUserMonthData()
	else
		self.temSetMonthList[key] = value
	end
end

function LocalUserDataController:getUserWeekData(key, callBack)
	if self.isStart then
		local data = self.userWeekData.data

		GameUtil.callBack(callBack, data[key])

		return data[key]
	else
		self.temGetWeekList[key] = self.temGetWeekList[key] or {}

		table.insert(self.temGetWeekList[key], callBack)
	end

	return nil
end

function LocalUserDataController:saveUserWeekData(key, value)
	if self.isStart then
		self.userWeekData.data[key] = value

		self:writeUserWeekData()
	else
		self.temSetWeekList[key] = value
	end
end

function LocalUserDataController:getUserDayData(key, callBack)
	if self.isStart then
		local data = self.userDayData.data

		GameUtil.callBack(callBack, data[key])

		return data[key]
	else
		self.temGetDayList[key] = self.temGetDayList[key] or {}

		table.insert(self.temGetDayList[key], callBack)
	end

	return nil
end

function LocalUserDataController:saveUserDayData(key, value)
	if self.isStart then
		self.userDayData.data[key] = value

		self:writeUserDayData()
	else
		self.temSetDayList[key] = value
	end
end

function LocalUserDataController:getUserId()
	if LoginModel.instance.userId and checknumber(LoginModel.instance.userId) > 0 then
		return LoginModel.instance.userId
	else
		error(" >>>>>>>>>>>>>>   LocalUserDataController getUserId Error 用这个方法 GameUtil.whenLocalDataInited() 或者使用回调 ")
	end

	return 0
end

function LocalUserDataController:writeUserDayData()
	local str = json.encode(self.userDayData or {})

	GameUtil.setLocalString(KEY_DAY_PRE .. self:getUserId(), str)
end

function LocalUserDataController:writeUserWeekData()
	local str = json.encode(self.userWeekData or {})

	GameUtil.setLocalString(KEY_WEEK_PRE .. self:getUserId(), str)
end

function LocalUserDataController:writeUserMonthData()
	local str = json.encode(self.userMonthData or {})

	GameUtil.setLocalString(KEY_MONTH_PRE .. self:getUserId(), str)
end

function LocalUserDataController:getUserData(key, callBack)
	if self.isStart then
		local data = self.userGlobalData

		GameUtil.callBack(callBack, data[key])

		return data[key]
	else
		self.temGetGlobalList[key] = self.temGetGlobalList[key] or {}

		table.insert(self.temGetGlobalList[key], callBack)
	end

	return nil
end

function LocalUserDataController:saveUserData(key, value)
	if self.isStart then
		self.userGlobalData[key] = value

		local str = json.encode(self.userGlobalData or {})

		GameUtil.setLocalString(KEY_GLOBAL_PRE .. self:getUserId(), str)
	else
		self.temSetGlobalList[key] = value
	end
end

function LocalUserDataController:doCallbackWhenFirst(key, callback, nextCallback)
	return self:getUserData(key, function(value)
		local isFirst = checknumber(value) == 0

		if isFirst then
			self:saveUserData(key, 1)
			GameUtil.callBack(callback)
		else
			GameUtil.callBack(nextCallback)
		end
	end)
end

function LocalUserDataController:doCallbackWhenDayFirst(key, callback, nextCallback)
	return self:getUserDayData(key, function(value)
		local isFirst = checknumber(value) == 0

		if isFirst then
			self:saveUserDayData(key, 1)
			GameUtil.callBack(callback)
		else
			GameUtil.callBack(nextCallback)
		end
	end)
end

function LocalUserDataController:doCallbackWhenWeekFirst(key, callback, nextCallback)
	return self:getUserWeekData(key, function(value)
		local isFirst = checknumber(value) == 0

		if isFirst then
			self:saveUserWeekData(key, 1)
			GameUtil.callBack(callback)
		else
			GameUtil.callBack(nextCallback)
		end
	end)
end

LocalUserDataController.instance = LocalUserDataController.New()

return LocalUserDataController
