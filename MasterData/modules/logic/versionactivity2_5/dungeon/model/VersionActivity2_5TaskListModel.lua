-- chunkname: @modules/logic/versionactivity2_5/dungeon/model/VersionActivity2_5TaskListModel.lua

module("modules.logic.versionactivity2_5.dungeon.model.VersionActivity2_5TaskListModel", package.seeall)

local VersionActivity2_5TaskListModel = class("VersionActivity2_5TaskListModel", ListScrollModel)

function VersionActivity2_5TaskListModel:onInit()
	return
end

function VersionActivity2_5TaskListModel:reInit()
	return
end

function VersionActivity2_5TaskListModel:initTask()
	self.taskMoList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityDungeon, VersionActivity2_5Enum.ActivityId.Dungeon)
end

function VersionActivity2_5TaskListModel:sortTaskMoList()
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

	table.sort(finishNotGetRewardMoList, VersionActivity2_5TaskListModel._sortFunc)
	table.sort(notFinishMoList, VersionActivity2_5TaskListModel._sortFunc)
	table.sort(finishAndGetRewardMoList, VersionActivity2_5TaskListModel._sortFunc)

	self.taskMoList = {}

	tabletool.addValues(self.taskMoList, finishNotGetRewardMoList)
	tabletool.addValues(self.taskMoList, notFinishMoList)
	tabletool.addValues(self.taskMoList, finishAndGetRewardMoList)
end

function VersionActivity2_5TaskListModel._sortFunc(a, b)
	return a.id < b.id
end

function VersionActivity2_5TaskListModel:refreshList()
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

function VersionActivity2_5TaskListModel:getFinishTaskCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxFinishCount then
			count = count + 1
		end
	end

	return count
end

function VersionActivity2_5TaskListModel:getFinishTaskActivityCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxFinishCount then
			count = count + taskMo.config.activity
		end
	end

	return count
end

function VersionActivity2_5TaskListModel:getGetRewardTaskCount()
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

VersionActivity2_5TaskListModel.instance = VersionActivity2_5TaskListModel.New()

return VersionActivity2_5TaskListModel
