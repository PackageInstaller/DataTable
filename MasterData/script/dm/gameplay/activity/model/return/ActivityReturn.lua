-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/return/ActivityReturn.lua

ActivityReturn = class("ActivityReturn", BaseActivity, _M)

ActivityReturn:has("_taskList", {
	is = "r"
})
ActivityReturn:has("_lastBackFlowTime", {
	is = "r"
})
ActivityReturn:has("_lastLogoutTime", {
	is = "r"
})
ActivityReturn:has("_isBackFlow", {
	is = "r"
})
ActivityReturn:has("_subActivities", {
	is = "r"
})

function ActivityReturn:initialize()
	super.initialize(self)

	self._subActivities = {}
	self._lastLogoutTime = 1614589058
end

function ActivityReturn:dispose()
	super.dispose(self)
end

function ActivityReturn:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)

	if data.lastBackFlowTime then
		self._lastBackFlowTime = data.lastBackFlowTime / 1000
	end

	if data.lastLogoutTime then
		self._lastLogoutTime = data.lastLogoutTime / 1000
	end

	if data.isBackFlow ~= nil then
		self._isBackFlow = data.isBackFlow
	end

	if data.subActivities then
		for id, v in pairs(data.subActivities) do
			if self._subActivities[id] then
				self._subActivities[id]:synchronize(v)
			else
				local config = ConfigReader:getRecordById("Activity", id)

				if config and ActivityModel[config.Type] then
					self._subActivities[id] = ActivityModel[config.Type]:new()

					self._subActivities[id]:synchronize(v)
				end
			end
		end
	end

	if self._activitySystem then
		self._activitySystem:dispatch(Event:new(EVT_RETURN_ACTIVITY_REFRESH))
	end
end

function ActivityReturn:getSubActivityByType(type)
	for k, v in pairs(self._subActivities) do
		if v:getType() == type then
			return v
		end
	end

	return nil
end

function ActivityReturn:getSubActivityById(id)
	return self._subActivities[id]
end

function ActivityReturn:hasRedPoint()
	local activityIds = self:getActivityConfig().show

	for i = 1, #activityIds do
		if self:hasRedPointForActivity(activityIds[i]) then
			return true
		end
	end

	return false
end

function ActivityReturn:hasRedPointForActivity(id)
	local activity = self:getSubActivityById(id)

	if activity then
		return activity:hasRedPoint()
	end

	return false
end
