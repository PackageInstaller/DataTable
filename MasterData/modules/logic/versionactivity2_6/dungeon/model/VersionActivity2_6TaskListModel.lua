-- chunkname: @modules/logic/versionactivity2_6/dungeon/model/VersionActivity2_6TaskListModel.lua

module("modules.logic.versionactivity2_6.dungeon.model.VersionActivity2_6TaskListModel", package.seeall)

local VersionActivity2_6TaskListModel = class("VersionActivity2_6TaskListModel", ListScrollModel)

function VersionActivity2_6TaskListModel:onInit()
	return
end

function VersionActivity2_6TaskListModel:reInit()
	return
end

function VersionActivity2_6TaskListModel:initTask()
	self.taskMoList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityDungeon, VersionActivity2_6Enum.ActivityId.Dungeon)
end

function VersionActivity2_6TaskListModel:sortTaskMoList()
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

	table.sort(finishNotGetRewardMoList, VersionActivity2_6TaskListModel._sortFunc)
	table.sort(notFinishMoList, VersionActivity2_6TaskListModel._sortFunc)
	table.sort(finishAndGetRewardMoList, VersionActivity2_6TaskListModel._sortFunc)

	self.taskMoList = {}

	tabletool.addValues(self.taskMoList, finishNotGetRewardMoList)
	tabletool.addValues(self.taskMoList, notFinishMoList)
	tabletool.addValues(self.taskMoList, finishAndGetRewardMoList)
end

function VersionActivity2_6TaskListModel._sortFunc(a, b)
	return a.id < b.id
end

function VersionActivity2_6TaskListModel:refreshList()
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

function VersionActivity2_6TaskListModel:getFinishTaskCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxFinishCount then
			count = count + 1
		end
	end

	return count
end

function VersionActivity2_6TaskListModel:getFinishTaskActivityCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxFinishCount then
			count = count + taskMo.config.activity
		end
	end

	return count
end

function VersionActivity2_6TaskListModel:getGetRewardTaskCount()
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

VersionActivity2_6TaskListModel.instance = VersionActivity2_6TaskListModel.New()

return VersionActivity2_6TaskListModel
