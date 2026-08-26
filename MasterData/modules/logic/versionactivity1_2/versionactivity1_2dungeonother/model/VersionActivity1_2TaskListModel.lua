-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeonother/model/VersionActivity1_2TaskListModel.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeonother.model.VersionActivity1_2TaskListModel", package.seeall)

local VersionActivity1_2TaskListModel = class("VersionActivity1_2TaskListModel", ListScrollModel)

function VersionActivity1_2TaskListModel:onInit()
	return
end

function VersionActivity1_2TaskListModel:reInit()
	return
end

function VersionActivity1_2TaskListModel:initTask()
	self.taskMoList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityDungeon, VersionActivity1_2Enum.ActivityId.Dungeon)
end

function VersionActivity1_2TaskListModel:sortTaskMoList()
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

	table.sort(finishNotGetRewardMoList, VersionActivity1_2TaskListModel._sortFunc)
	table.sort(notFinishMoList, VersionActivity1_2TaskListModel._sortFunc)
	table.sort(finishAndGetRewardMoList, VersionActivity1_2TaskListModel._sortFunc)

	self.taskMoList = {}

	tabletool.addValues(self.taskMoList, finishNotGetRewardMoList)
	tabletool.addValues(self.taskMoList, notFinishMoList)
	tabletool.addValues(self.taskMoList, finishAndGetRewardMoList)
end

function VersionActivity1_2TaskListModel._sortFunc(a, b)
	return a.id < b.id
end

function VersionActivity1_2TaskListModel:refreshList()
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

function VersionActivity1_2TaskListModel:getFinishTaskCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxFinishCount then
			count = count + 1
		end
	end

	return count
end

function VersionActivity1_2TaskListModel:getFinishTaskActivityCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxFinishCount then
			count = count + taskMo.config.activity
		end
	end

	return count
end

function VersionActivity1_2TaskListModel:getGetRewardTaskCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.finishCount >= taskMo.config.maxFinishCount then
			count = count + 1
		end
	end

	return count
end

VersionActivity1_2TaskListModel.instance = VersionActivity1_2TaskListModel.New()

return VersionActivity1_2TaskListModel
