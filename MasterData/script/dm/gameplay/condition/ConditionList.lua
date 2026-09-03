-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/condition/ConditionList.lua

Condition = class("Condition", objectlua.Object, _M)

Condition:has("_id", {
	is = "r"
})
Condition:has("_status", {
	is = "r"
})
Condition:has("_taskValueList", {
	is = "r"
})
Condition:has("_desc", {
	is = "r"
})

function Condition:initialize(player)
	super.initialize(self)

	self._taskValueList = {}
end

function Condition:synchronize(data)
	if not data then
		return
	end

	if data.taskId then
		self._id = data.taskId
	end

	if data.taskStatus then
		self._status = data.taskStatus
	end

	if data.taskValues then
		for k, value in pairs(data.taskValues) do
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

function Condition:getTaskValueByIndex(index)
	return self._taskValueList[index]
end

ConditionList = class("ConditionList", objectlua.Object, _M)

ConditionList:has("_map", {
	is = "r"
})

function ConditionList:initialize(player)
	super.initialize(self)

	self._map = {}
end

function ConditionList:synchronize(data)
	if not data then
		return
	end

	for k, value in pairs(data) do
		local condition = self._map[k]

		if condition == nil then
			condition = Condition:new()
			self._map[k] = condition
		end

		condition:synchronize(value)
	end
end

function ConditionList:getConditionById(id)
	return self._map[id]
end
