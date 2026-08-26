-- chunkname: @modules/logic/versionactivity1_4/act133/model/Activity133TaskListModel.lua

module("modules.logic.versionactivity1_4.act133.model.Activity133TaskListModel", package.seeall)

local Activity133TaskListModel = class("Activity133TaskListModel", ListScrollModel)

function Activity133TaskListModel:onInit()
	return
end

function Activity133TaskListModel:reInit()
	return
end

function Activity133TaskListModel:sortTaskMoList()
	local taskMoList = Activity133Model.instance:getTasksInfo()
	local finishNotGetRewardMoList = {}
	local notFinishMoList = {}
	local finishAndGetRewardMoList = {}

	for _, taskMo in pairs(taskMoList) do
		if taskMo.finishCount >= taskMo.config.maxProgress then
			table.insert(finishAndGetRewardMoList, taskMo)
		elseif taskMo.hasFinished then
			table.insert(finishNotGetRewardMoList, taskMo)
		else
			table.insert(notFinishMoList, taskMo)
		end
	end

	table.sort(finishNotGetRewardMoList, Activity133TaskListModel._sortFunc)
	table.sort(notFinishMoList, Activity133TaskListModel._sortFunc)
	table.sort(finishAndGetRewardMoList, Activity133TaskListModel._sortFunc)

	self.taskMoList = {}

	tabletool.addValues(self.taskMoList, finishNotGetRewardMoList)
	tabletool.addValues(self.taskMoList, notFinishMoList)
	tabletool.addValues(self.taskMoList, finishAndGetRewardMoList)
	self:refreshList()
end

function Activity133TaskListModel._sortFunc(a, b)
	local aValue = a.finishCount > 0 and 3 or a.progress >= a.config.maxProgress and 1 or 2
	local bValue = b.finishCount > 0 and 3 or b.progress >= b.config.maxProgress and 1 or 2

	if aValue ~= bValue then
		return aValue < bValue
	else
		return a.config.id < b.config.id
	end
end

function Activity133TaskListModel:refreshList()
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

function Activity133TaskListModel:getFinishTaskCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxProgress then
			count = count + 1
		end
	end

	return count
end

function Activity133TaskListModel:getFinishTaskActivityCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxProgress then
			count = count + taskMo.config.activity
		end
	end

	return count
end

function Activity133TaskListModel:getGetRewardTaskCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.finishCount >= taskMo.config.maxProgress then
			count = count + 1
		end
	end

	return count
end

function Activity133TaskListModel:getKeyRewardMo()
	if self.taskMoList then
		for i, v in ipairs(self.taskMoList) do
			if v.config.isKeyReward == 1 and v.finishCount < v.config.maxProgress then
				return v
			end
		end
	end
end

Activity133TaskListModel.instance = Activity133TaskListModel.New()

return Activity133TaskListModel
