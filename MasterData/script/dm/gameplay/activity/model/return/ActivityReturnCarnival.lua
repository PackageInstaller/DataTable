-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/return/ActivityReturnCarnival.lua

ActivityReturnCarnival = class("ActivityReturnCarnival", BaseActivity, _M)

ActivityReturnCarnival:has("_taskList", {
	is = "r"
})
ActivityReturnCarnival:has("_openTime", {
	is = "r"
})

function ActivityReturnCarnival:initialize()
	super.initialize(self)

	self._taskList = {}
end

function ActivityReturnCarnival:dispose()
	super.dispose(self)
end

function ActivityReturnCarnival:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)

	if data.openTime then
		self._openTime = data.openTime
	end

	if data.tasks then
		for day, tasks in pairs(data.tasks) do
			if self._taskList[day] == nil then
				self._taskList[day] = {}
			end

			for taskId, task in pairs(tasks) do
				if self._taskList[day][taskId] then
					self._taskList[day][taskId]:updateModel(task)
				else
					self._taskList[day][taskId] = ActivityTask:new()

					self._taskList[day][taskId]:synchronizeModel(task)
				end
			end
		end
	end
end

function ActivityReturnCarnival:getOpenDay()
	local dayNum = 0

	for _, v in pairs(self._taskList) do
		dayNum = dayNum + 1
	end

	return dayNum
end

function ActivityReturnCarnival:getSortDayTasks(day)
	local taskDir = self._taskList[tostring(day)]
	local taskArr = {}

	for _, value in pairs(taskDir) do
		table.insert(taskArr, value)
	end

	table.sort(taskArr, function(a, b)
		local aSt = a:getOrderStatusNum()
		local bSt = b:getOrderStatusNum()

		if aSt == bSt then
			return a:getOrderNum() < b:getOrderNum()
		end

		return bSt < aSt
	end)

	return taskArr
end

function ActivityReturnCarnival:hasRedPoint()
	for _, tasks in pairs(self._taskList) do
		for _, task in pairs(tasks) do
			if task:getStatus() == ActivityTaskStatus.kFinishNotGet then
				return true
			end
		end
	end

	return false
end

function ActivityReturnCarnival:hasRedPointDay(day)
	if self._taskList and self._taskList[tostring(day)] then
		for _, task in pairs(self._taskList[tostring(day)]) do
			if task:getStatus() == ActivityTaskStatus.kFinishNotGet then
				return true
			end
		end
	end

	return false
end
