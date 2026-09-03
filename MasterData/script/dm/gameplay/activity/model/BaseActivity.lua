-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/BaseActivity.lua

require("dm.gameplay.activity.model.ActivityTask")
require("dm.gameplay.activity.model.ActivityNumTask")

BaseActivity = class("BaseActivity", objectlua.Object, _M)

BaseActivity:has("_id", {
	is = "r"
})
BaseActivity:has("_startTime", {
	is = "r"
})
BaseActivity:has("_endTime", {
	is = "r"
})
BaseActivity:has("_config", {
	is = "r"
})
BaseActivity:has("_isTodayOpen", {
	is = "r"
})
BaseActivity:has("_dailyReset", {
	is = "r"
})
BaseActivity:has("_activitySystem", {
	is = "rw"
}):injectWith("ActivitySystem")
BaseActivity:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
BaseActivity:has("_foreverGot", {
	is = "rw"
})
BaseActivity:has("_extraGot", {
	is = "rw"
})

function BaseActivity:initialize(id)
	super.initialize(self)

	self._id = nil
	self._config = nil
	self._startTime = -1
	self._endTime = -1
	self._isTodayOpen = false
	self._dailyReset = false
	self._foreverGot = {}
	self._extraGot = {}

	if id then
		self._id = id
		self._config = ConfigReader:getRecordById("Activity", self._id)
	end
end

function BaseActivity:dispose()
	super.dispose(self)
end

function BaseActivity:synchronize(data)
	if not data then
		return
	end

	if data.activityId then
		self._id = data.activityId
		self._config = ConfigReader:getRecordById("Activity", self._id)
	end

	if data.timeStamp then
		if data.timeStamp.openTs then
			self._startTime = data.timeStamp.openTs
		end

		if data.timeStamp.finishTs then
			self._endTime = data.timeStamp.finishTs
		end

		if data.timeStamp.dailyReset then
			self._dailyReset = data.timeStamp.dailyReset
		end
	end

	if data.todayOpen ~= nil then
		self._isTodayOpen = data.todayOpen
	end

	if data.foreverGot then
		self._foreverGot = data.foreverGot
	end

	if data.extraGot then
		for key, value in pairs(data.extraGot) do
			self._extraGot[key] = value
		end
	end
end

function BaseActivity:reset()
	self._id = nil
	self._config = nil
	self._startTime = -1
	self._endTime = -1
	self._isTodayOpen = false
	self._dailyReset = false
	self._foreverGot = {}
	self._extraGot = {}
end

function BaseActivity:hasRewardToGet()
	return false
end

function BaseActivity:hasRedPoint()
	return false
end

function BaseActivity:getClientCondition()
	return self._config.ClientCondition
end

function BaseActivity:getType()
	return self._config.Type
end

function BaseActivity:getUI()
	return self._config.UI
end

function BaseActivity:getTitle()
	return self._config.Title
end

function BaseActivity:getDesc()
	return self._config.Desc
end

function BaseActivity:getActivityConfig()
	return self._config.ActivityConfig
end

function BaseActivity:getShowTab()
	return self._config.ShowTab
end

function BaseActivity:getShowIndex()
	return self._config.ShowIndex or 0
end

function BaseActivity:getIcon()
	return self._config.Icon
end

function BaseActivity:getTag()
	return self._config.Tag
end

function BaseActivity:getLeftBanner()
	return self._config.LeftBanner
end

function BaseActivity:getTimeFactor()
	if self._config.Time == "MERGE_CONTINUE" or self._config.Time == "MERGE_RESTART" then
		local timeInfo = {}

		timeInfo.start = {}
		timeInfo.start[1] = TimeUtil:remoteDate("%Y-%m-%d %H:%M:%S", self._startTime / 1000)
		timeInfo.start[2] = TimeUtil:remoteDate("%Y-%m-%d %H:%M:%S", self._endTime / 1000)
		timeInfo["end"] = TimeUtil:remoteDate("%Y-%m-%d %H:%M:%S", self._endTime / 1000)

		return timeInfo
	end

	return self._config.TimeFactor
end

function BaseActivity:getLocalTimeFactor()
	if self._config.Time == "MERGE_CONTINUE" or self._config.Time == "MERGE_RESTART" then
		local timeInfo = {}

		timeInfo.start = {}
		timeInfo.start[1] = TimeUtil:localDate("%Y-%m-%d %H:%M:%S", self._startTime / 1000)
		timeInfo.start[2] = TimeUtil:localDate("%Y-%m-%d %H:%M:%S", self._endTime / 1000)
		timeInfo["end"] = TimeUtil:localDate("%Y-%m-%d %H:%M:%S", self._endTime / 1000)

		return timeInfo
	else
		local timeInfo = clone(self._config.TimeFactor)

		for k, v in pairs(timeInfo.start or {}) do
			local remoteTime = TimeUtil:formatStrToRemoteTImestamp(v)

			timeInfo.start[k] = TimeUtil:localDate("%Y-%m-%d %H:%M:%S", remoteTime)
		end

		if timeInfo["end"] then
			local remoteTime = TimeUtil:formatStrToRemoteTImestamp(timeInfo["end"])

			timeInfo["end"] = TimeUtil:localDate("%Y-%m-%d %H:%M:%S", remoteTime)
		end

		return timeInfo
	end
end

function BaseActivity:getLocalTimeFactor1()
	if self._config.Time == "MERGE_CONTINUE" or self._config.Time == "MERGE_RESTART" then
		local timeInfo = {}

		timeInfo.start = {}
		timeInfo.start[1] = TimeUtil:localDate("%Y.%m.%d %H:%M", self._startTime / 1000)
		timeInfo.start[2] = TimeUtil:localDate("%Y.%m.%d %H:%M", self._endTime / 1000)
		timeInfo["end"] = TimeUtil:localDate("%Y.%m.%d %H:%M", self._endTime / 1000)

		return timeInfo
	else
		local timeInfo = clone(self._config.TimeFactor)

		for k, v in pairs(timeInfo.start or {}) do
			local remoteTime = TimeUtil:formatStrToRemoteTImestamp(v)

			timeInfo.start[k] = TimeUtil:localDate("%Y.%m.%d %H:%M", remoteTime)
		end

		if timeInfo["end"] then
			local remoteTime = TimeUtil:formatStrToRemoteTImestamp(timeInfo["end"])

			timeInfo["end"] = TimeUtil:localDate("%Y.%m.%d %H:%M", remoteTime)
		end

		return timeInfo
	end
end

function BaseActivity:getTimeStr1()
	local timeInfo = self:getLocalTimeFactor1()

	return timeInfo.start[1] .. "~" .. timeInfo["end"]
end

function BaseActivity:getTimeStr2()
	local timeInfo = self:getLocalTimeFactor1()

	return timeInfo.start[1] .. "\n" .. timeInfo["end"]
end

function BaseActivity:getBubleDesc()
	return self._config.ActivityConfig.BubleDesc
end

function BaseActivity:getBgm()
	return self._config.ActivityConfig.bgm or "Mus_Story_Festival"
end

function BaseActivity:getBgm1()
	return self._config.ActivityConfig.bgm
end

function BaseActivity:getActivityComplexUI()
	return self._config.UI
end
