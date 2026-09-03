-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/BentoActivity.lua

BentoActivity = class("BentoActivity", BaseActivity, _M)

BentoActivity:has("_taskList", {
	is = "r"
})

function BentoActivity:initialize()
	super.initialize(self)

	self._taskList = {}
end

function BentoActivity:dispose()
	super.dispose(self)
end

function BentoActivity:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)

	if data.taskList then
		for id, value in pairs(data.taskList) do
			value.taskId = value.taskId or id
			value.activityId = value.activityId or data.activityId

			local task = self:getActivityTaskById(id)

			if task then
				task:updateModel(value)
			else
				local taskConfig = ConfigReader:getRecordById("ActivityTask", id)

				if taskConfig ~= nil and taskConfig.Id ~= nil then
					task = ActivityTask:new()

					task:synchronizeModel(value)

					self._taskList[#self._taskList + 1] = task
				end
			end
		end
	end
end

function BentoActivity:getActivityTaskById(taskId)
	if self._taskList then
		for k, v in pairs(self._taskList) do
			if v:getId() == taskId then
				return v
			end
		end
	end
end

function BentoActivity:getTaskCountByStatus(status)
	local value = 0

	for i, task in pairs(self._taskList) do
		if task ~= nil and task:getStatus() == status then
			value = value + 1
		end
	end

	return value
end

function BentoActivity:hasRewardToGet()
	return self:getTaskCountByStatus(ActivityTaskStatus.kFinishNotGet) > 0
end

function BentoActivity:hasRedPoint()
	return self:hasRewardToGet()
end

function BentoActivity:getSortActivityList()
	local list = {}

	for i, taskData in pairs(self._taskList) do
		list[#list + 1] = taskData
	end

	if self._allAchieveTaskList then
		for i, taskData in pairs(self._allAchieveTaskList) do
			list[#list + 1] = taskData
		end
	end

	table.sort(list, function(a, b)
		if a:getStatus() ~= b:getStatus() then
			return kTaskStatusPriorityMap[a:getStatus()] < kTaskStatusPriorityMap[b:getStatus()]
		else
			return a:getOrderNum() < b:getOrderNum()
		end
	end)

	return list
end

function BentoActivity:getResourcesBanner()
	return self:getActivityConfig().ResourcesBanner
end

function BentoActivity:getRuleDesc()
	return self:getActivityConfig().RuleDesc
end

function BentoActivity:getBmg()
	return self:getActivityConfig().Bmg
end

function BentoActivity:getBgm()
	return self:getActivityConfig().bgm
end

function BentoActivity:getFoodMaterial()
	return self:getActivityConfig().menu
end

function BentoActivity:getShowHero()
	return self:getActivityConfig().ShowHero
end

function BentoActivity:getFoodPos()
	return self:getActivityConfig().FoodPos
end

function BentoActivity:getGuideText()
	dump(self:getActivityConfig(), "self:getActivityConfig()")

	return self:getActivityConfig().GuideText
end
