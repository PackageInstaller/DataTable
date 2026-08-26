-- chunkname: @modules/logic/versionactivity1_9/dungeon/model/VersionActivity1_9TaskListModel.lua

module("modules.logic.versionactivity1_9.dungeon.model.VersionActivity1_9TaskListModel", package.seeall)

local VersionActivity1_9TaskListModel = class("VersionActivity1_9TaskListModel", ListScrollModel)

function VersionActivity1_9TaskListModel:onInit()
	return
end

function VersionActivity1_9TaskListModel:reInit()
	return
end

function VersionActivity1_9TaskListModel:initTask()
	self.taskMoList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityDungeon, VersionActivity1_9Enum.ActivityId.Dungeon)
end

function VersionActivity1_9TaskListModel:sortTaskMoList()
	local finishNotGetRewardMoList = {}
	local notFinishMoList = {}
	local finishAndGetRewardMoList = {}

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.finishCount >= taskMo.config.maxFinishCount then
			table.insert(finishAndGetRewardMoList, taskMo)
		elseif taskMo.hasFinished then
			table.insert(finishNotGetRewardMoList, taskMo)
		else
			table.insert(notFinishMoList, taskMo)
		end
	end

	table.sort(finishNotGetRewardMoList, VersionActivity1_9TaskListModel._sortFunc)
	table.sort(notFinishMoList, VersionActivity1_9TaskListModel._sortFunc)
	table.sort(finishAndGetRewardMoList, VersionActivity1_9TaskListModel._sortFunc)

	self.taskMoList = {}

	tabletool.addValues(self.taskMoList, finishNotGetRewardMoList)
	tabletool.addValues(self.taskMoList, notFinishMoList)
	tabletool.addValues(self.taskMoList, finishAndGetRewardMoList)
end

function VersionActivity1_9TaskListModel._sortFunc(a, b)
	return a.id < b.id
end

function VersionActivity1_9TaskListModel:refreshList()
	local finishTaskCount = self:getFinishTaskCount()

	if finishTaskCount > 1 then
		local moList = tabletool.copy(self.taskMoList)

		table.insert(moList, 1, {
			getAll = true
		})
		self:setList(moList)
	else
		self:setList(self.taskMoList)
	end
end

function VersionActivity1_9TaskListModel:getFinishTaskCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxFinishCount then
			count = count + 1
		end
	end

	return count
end

function VersionActivity1_9TaskListModel:getFinishTaskActivityCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxFinishCount then
			count = count + taskMo.config.activity
		end
	end

	return count
end

function VersionActivity1_9TaskListModel:getGetRewardTaskCount()
	local count = 0

	if not self.taskMoList then
		return 0
	end

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.finishCount >= taskMo.config.maxFinishCount then
			count = count + 1
		end
	end

	return count
end

VersionActivity1_9TaskListModel.instance = VersionActivity1_9TaskListModel.New()

return VersionActivity1_9TaskListModel
