-- chunkname: @modules/logic/versionactivity/model/VersionActivityTaskListModel.lua

module("modules.logic.versionactivity.model.VersionActivityTaskListModel", package.seeall)

local VersionActivityTaskListModel = class("VersionActivityTaskListModel", ListScrollModel)

function VersionActivityTaskListModel:onInit()
	return
end

function VersionActivityTaskListModel:reInit()
	return
end

function VersionActivityTaskListModel:initTaskList()
	self.taskMoList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityDungeon, VersionActivityEnum.ActivityId.Act113)
end

function VersionActivityTaskListModel:sortTaskMoList()
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

	table.sort(finishNotGetRewardMoList, VersionActivityTaskListModel._sortFunc)
	table.sort(notFinishMoList, VersionActivityTaskListModel._sortFunc)
	table.sort(finishAndGetRewardMoList, VersionActivityTaskListModel._sortFunc)

	self.taskMoList = {}

	tabletool.addValues(self.taskMoList, finishNotGetRewardMoList)
	tabletool.addValues(self.taskMoList, notFinishMoList)
	tabletool.addValues(self.taskMoList, finishAndGetRewardMoList)
end

function VersionActivityTaskListModel._sortFunc(a, b)
	return a.id < b.id
end

function VersionActivityTaskListModel:refreshList()
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

function VersionActivityTaskListModel:getFinishTaskCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxFinishCount then
			count = count + 1
		end
	end

	return count
end

function VersionActivityTaskListModel:getFinishTaskActivityCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxFinishCount then
			count = count + taskMo.config.activity
		end
	end

	return count
end

function VersionActivityTaskListModel:getGetRewardTaskCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.finishCount >= taskMo.config.maxFinishCount then
			count = count + 1
		end
	end

	return count
end

VersionActivityTaskListModel.instance = VersionActivityTaskListModel.New()

return VersionActivityTaskListModel
