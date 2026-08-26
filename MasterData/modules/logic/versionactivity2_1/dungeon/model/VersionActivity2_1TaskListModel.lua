-- chunkname: @modules/logic/versionactivity2_1/dungeon/model/VersionActivity2_1TaskListModel.lua

module("modules.logic.versionactivity2_1.dungeon.model.VersionActivity2_1TaskListModel", package.seeall)

local VersionActivity2_1TaskListModel = class("VersionActivity2_1TaskListModel", ListScrollModel)

local function _sortFunc(a, b)
	return a.id < b.id
end

function VersionActivity2_1TaskListModel:onInit()
	return
end

function VersionActivity2_1TaskListModel:reInit()
	return
end

function VersionActivity2_1TaskListModel:initTask()
	self:clear()

	self.taskMoList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityDungeon, VersionActivity2_1Enum.ActivityId.Dungeon)
end

function VersionActivity2_1TaskListModel:sortTaskMoList()
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

	table.sort(finishNotGetRewardMoList, _sortFunc)
	table.sort(notFinishMoList, _sortFunc)
	table.sort(finishAndGetRewardMoList, _sortFunc)

	self.taskMoList = {}

	tabletool.addValues(self.taskMoList, finishNotGetRewardMoList)
	tabletool.addValues(self.taskMoList, notFinishMoList)
	tabletool.addValues(self.taskMoList, finishAndGetRewardMoList)
end

function VersionActivity2_1TaskListModel:refreshList()
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

function VersionActivity2_1TaskListModel:getFinishTaskCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxFinishCount then
			count = count + 1
		end
	end

	return count
end

function VersionActivity2_1TaskListModel:getFinishTaskActivityCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxFinishCount then
			count = count + taskMo.config.activity
		end
	end

	return count
end

function VersionActivity2_1TaskListModel:getGetRewardTaskCount()
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

VersionActivity2_1TaskListModel.instance = VersionActivity2_1TaskListModel.New()

return VersionActivity2_1TaskListModel
