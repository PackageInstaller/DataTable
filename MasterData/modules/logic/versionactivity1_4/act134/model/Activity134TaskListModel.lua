-- chunkname: @modules/logic/versionactivity1_4/act134/model/Activity134TaskListModel.lua

module("modules.logic.versionactivity1_4.act134.model.Activity134TaskListModel", package.seeall)

local Activity134TaskListModel = class("Activity134TaskListModel", ListScrollModel)

function Activity134TaskListModel:onInit()
	return
end

function Activity134TaskListModel:reInit()
	return
end

function Activity134TaskListModel:sortTaskMoList()
	local taskMoList = Activity134Model.instance:getTasksInfo()
	local finishNotGetRewardMoList = {}
	local notFinishMoList = {}
	local finishAndGetRewardMoList = {}

	for _, taskMo in pairs(taskMoList) do
		if taskMo.finishCount > 0 then
			table.insert(finishAndGetRewardMoList, taskMo)
		elseif taskMo.hasFinished then
			table.insert(finishNotGetRewardMoList, taskMo)
		else
			table.insert(notFinishMoList, taskMo)
		end
	end

	table.sort(finishNotGetRewardMoList, Activity134TaskListModel._sortFunc)
	table.sort(notFinishMoList, Activity134TaskListModel._sortFunc)
	table.sort(finishAndGetRewardMoList, Activity134TaskListModel._sortFunc)

	self.serverTaskModel = {}

	tabletool.addValues(self.serverTaskModel, finishNotGetRewardMoList)
	tabletool.addValues(self.serverTaskModel, notFinishMoList)
	tabletool.addValues(self.serverTaskModel, finishAndGetRewardMoList)
	self:refreshList()
end

function Activity134TaskListModel._sortFunc(a, b)
	local aValue = a.finishCount > 0 and 3 or a.progress >= a.config.maxProgress and 1 or 2
	local bValue = b.finishCount > 0 and 3 or b.progress >= b.config.maxProgress and 1 or 2

	if aValue ~= bValue then
		return aValue < bValue
	else
		return a.config.id < b.config.id
	end
end

function Activity134TaskListModel:refreshList()
	local finishTaskCount = self:getFinishTaskCount()

	if finishTaskCount > 1 then
		local moList = tabletool.copy(self.serverTaskModel)

		table.insert(moList, 1, {
			getAll = true
		})
		self:setList(moList)
	else
		self:setList(self.serverTaskModel)
	end
end

function Activity134TaskListModel:getFinishTaskCount()
	local count = 0

	for _, taskMo in ipairs(self.serverTaskModel) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxProgress then
			count = count + 1
		end
	end

	return count
end

function Activity134TaskListModel:getFinishTaskActivityCount()
	local count = 0

	for _, taskMo in ipairs(self.serverTaskModel) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxProgress then
			count = count + taskMo.config.activity
		end
	end

	return count
end

function Activity134TaskListModel:getGetRewardTaskCount()
	local count = 0

	for _, taskMo in ipairs(self.serverTaskModel) do
		if taskMo.finishCount >= taskMo.config.maxProgress then
			count = count + 1
		end
	end

	return count
end

function Activity134TaskListModel:getKeyRewardMo()
	if self.serverTaskModel then
		for i, v in ipairs(self.serverTaskModel) do
			if v.config.isKeyReward == 1 and v.finishCount < v.config.maxProgress then
				return v
			end
		end
	end
end

Activity134TaskListModel.instance = Activity134TaskListModel.New()

return Activity134TaskListModel
