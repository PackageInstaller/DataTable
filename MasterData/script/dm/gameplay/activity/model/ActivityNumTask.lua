-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/ActivityNumTask.lua

ActivityNumTask = class("NotConfigTask", objectlua.Object, _M)

ActivityNumTask:has("_status", {
	is = "rw"
})
ActivityNumTask:has("_activityId", {
	is = "rw"
})
ActivityNumTask:has("_num", {
	is = "rw"
})
ActivityNumTask:has("_orderNum", {
	is = "rw"
})
ActivityNumTask:has("_taskValueList", {
	is = "rw"
})
ActivityNumTask:has("_id", {
	is = "rw"
})
ActivityNumTask:has("_getStatus", {
	is = "rw"
})
ActivityNumTask:has("_type", {
	is = "rw"
})

function ActivityNumTask:initialize()
	super.initialize(self)

	self._type = "ActivityNumTask"
	self._id = ""
	self._status = ActivityTaskStatus.kUnfinish
	self._activityId = ""
	self._taskValueList = {}
	self._taskValueList[1] = {}
	self._taskValueList[1].targetValue = 0
	self._taskValueList[1].currentValue = 0
	self._descId = ""
	self._rewardId = ""
	self._getStatus = 0
end

function ActivityNumTask:synchronize(data)
	if not data then
		return
	end

	if data.activityId then
		self._activityId = data.activityId
	end

	if data.targetValue then
		self._id = tostring(data.targetValue)
		self._taskValueList[1].targetValue = data.targetValue
	end

	if data.currentValue then
		self._taskValueList[1].currentValue = math.min(data.currentValue, self._taskValueList[1].targetValue)
	end

	if data.orderNum then
		self._orderNum = data.orderNum
	end

	if data.descId then
		self._descId = data.descId
	end

	if data.reward then
		self._rewardId = data.reward
	end

	self:updateStatus()
end

function ActivityNumTask:updateStatus()
	self._status = self._getStatus == 1 and ActivityTaskStatus.kGet or self._taskValueList[1].currentValue >= self._taskValueList[1].targetValue and ActivityTaskStatus.kFinishNotGet or ActivityTaskStatus.kUnfinish
end

function ActivityNumTask:getDesc()
	return Strings:get(self._descId)
end

function ActivityNumTask:getReward()
	return ConfigReader:getRecordById("Reward", tostring(self._rewardId))
end
