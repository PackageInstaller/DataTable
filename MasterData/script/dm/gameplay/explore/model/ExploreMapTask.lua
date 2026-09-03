-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/model/ExploreMapTask.lua

ExploreMapTask = class("ExploreMapTask", objectlua.Object)

ExploreMapTask:has("_id", {
	is = "r"
})
ExploreMapTask:has("_status", {
	is = "rw"
})
ExploreMapTask:has("_taskValueList", {
	is = "rw"
})

function ExploreMapTask:initialize(id)
	super.initialize(self)

	self._id = id
	self._config = ConfigReader:getRecordById("MapTask", id)
	self._status = 0
	self._taskValueList = {}
end

function ExploreMapTask:synchronize(data)
	if data.taskStatus then
		self._status = data.taskStatus
	end

	if data.taskValues then
		self:updateTaskValue(data.taskValues)
	end
end

function ExploreMapTask:updateTaskValue(data)
	if data then
		for k, value in pairs(data) do
			self._taskValueList[tonumber(k) + 1] = self._taskValueList[tonumber(k) + 1] or value

			if value.currentValue then
				self._taskValueList[tonumber(k) + 1].currentValue = value.currentValue
			end

			if value.targetValue then
				self._taskValueList[tonumber(k) + 1].targetValue = value.targetValue
			end
		end
	end
end

function ExploreMapTask:getName()
	return Strings:get(self._config.Name)
end

function ExploreMapTask:getDesc()
	return Strings:get(self._config.Desc)
end

function ExploreMapTask:getDp()
	return self._config.DP
end

function ExploreMapTask:getIsComplete()
	return self._status ~= 0
end

function ExploreMapTask:getCondition()
	return self._config.Condition
end

function ExploreMapTask:getNeedDP()
	return self._config.NeedDP
end

function ExploreMapTask:getTargetMapName()
	return self._config.MapName
end

function ExploreMapTask:getShowTypeName()
	return self._config.ShowType
end
