-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/DailyChargeActivity.lua

DailyChargeActivity = class("DailyChargeActivity", BaseActivity, _M)

DailyChargeActivity:has("_todayTask", {
	is = "rw"
})
DailyChargeActivity:has("_finalRewarded", {
	is = "rw"
})
DailyChargeActivity:has("_curTaskIndex", {
	is = "rw"
})
DailyChargeActivity:has("_lastGetFreeGiftTime", {
	is = "rw"
})

function DailyChargeActivity:initialize(id)
	super.initialize(self, id)

	self._todayTask = nil
	self._lastGetFreeGiftTime = 0
	self._finalRewarded = false
	self._curTaskIndex = 0
end

function DailyChargeActivity:dispose()
	super.dispose(self)
end

function DailyChargeActivity:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)

	if data.tasksOnWork then
		self:syncTodayTask(data.tasksOnWork)
	end

	if data.lastGetFreeGiftTime then
		self._lastGetFreeGiftTime = data.lastGetFreeGiftTime
	end

	if data.finalRewarded then
		self._finalRewarded = data.finalRewarded
	end

	if data.taskIndex then
		self._curTaskIndex = data.taskIndex
	end
end

function DailyChargeActivity:syncTodayTask(data)
	for _, value in pairs(data) do
		if self._todayTask then
			self._todayTask:updateModel(value)

			break
		end

		do
			local taskId = value.taskId
			local taskConfig = ConfigReader:getRecordById("ActivityTask", taskId)

			if taskConfig ~= nil and taskConfig.Id ~= nil then
				self._todayTask = ActivityTask:new()

				self._todayTask:synchronizeModel(value)
			end
		end

		break
	end
end

function DailyChargeActivity:reset()
	super.reset(self)

	self._todayTask = nil
	self._dailyFreeRewarded = false
	self._finalRewarded = false
end

function DailyChargeActivity:hasRedPoint()
	local gameServerAgent = DmGame:getInstance()._injector:getInstance("GameServerAgent")
	local nowTime = gameServerAgent:remoteTimestamp()

	if not TimeUtil:isSameDay(self._lastGetFreeGiftTime / 1000, nowTime, {
		sec = 0,
		min = 0,
		hour = 5
	}) then
		return true
	end

	if self._todayTask:getStatus() == ActivityTaskStatus.kFinishNotGet then
		return true
	end

	return false
end

function DailyChargeActivity:getTaskList()
	return self:getActivityConfig() and self:getActivityConfig().task
end

function DailyChargeActivity:getDailyFreeReward()
	return self:getActivityConfig() and self:getActivityConfig().freeReward
end

function DailyChargeActivity:getShowHeroId()
	return self:getActivityConfig() and self:getActivityConfig().showHero
end

function DailyChargeActivity:getPayType()
	return self:getActivityConfig() and self:getActivityConfig().PayType
end
