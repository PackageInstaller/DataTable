-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeon/model/VersionActivity1_3TaskListModel.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.model.VersionActivity1_3TaskListModel", package.seeall)

local VersionActivity1_3TaskListModel = class("VersionActivity1_3TaskListModel", ListScrollModel)

function VersionActivity1_3TaskListModel:onInit()
	return
end

function VersionActivity1_3TaskListModel:reInit()
	return
end

function VersionActivity1_3TaskListModel:initTask()
	self.taskMoList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityDungeon, VersionActivity1_3Enum.ActivityId.Dungeon)
end

function VersionActivity1_3TaskListModel:sortTaskMoList()
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

	table.sort(finishNotGetRewardMoList, VersionActivity1_3TaskListModel._sortFunc)
	table.sort(notFinishMoList, VersionActivity1_3TaskListModel._sortFunc)
	table.sort(finishAndGetRewardMoList, VersionActivity1_3TaskListModel._sortFunc)

	self.taskMoList = {}

	tabletool.addValues(self.taskMoList, finishNotGetRewardMoList)
	tabletool.addValues(self.taskMoList, notFinishMoList)
	tabletool.addValues(self.taskMoList, finishAndGetRewardMoList)
end

function VersionActivity1_3TaskListModel._sortFunc(a, b)
	return a.id < b.id
end

function VersionActivity1_3TaskListModel:refreshList()
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

function VersionActivity1_3TaskListModel:getFinishTaskCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxFinishCount then
			count = count + 1
		end
	end

	return count
end

function VersionActivity1_3TaskListModel:getFinishTaskActivityCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxFinishCount then
			count = count + taskMo.config.activity
		end
	end

	return count
end

function VersionActivity1_3TaskListModel:getGetRewardTaskCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.finishCount >= taskMo.config.maxFinishCount then
			count = count + 1
		end
	end

	return count
end

VersionActivity1_3TaskListModel.instance = VersionActivity1_3TaskListModel.New()

return VersionActivity1_3TaskListModel
