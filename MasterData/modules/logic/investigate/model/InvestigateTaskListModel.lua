-- chunkname: @modules/logic/investigate/model/InvestigateTaskListModel.lua

module("modules.logic.investigate.model.InvestigateTaskListModel", package.seeall)

local InvestigateTaskListModel = class("InvestigateTaskListModel", ListScrollModel)

function InvestigateTaskListModel:onInit()
	return
end

function InvestigateTaskListModel:reInit()
	return
end

function InvestigateTaskListModel:initTask()
	self.taskMoList = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Investigate)
end

function InvestigateTaskListModel:sortTaskMoList()
	if not self.taskMoList then
		return
	end

	local finishNotGetRewardMoList = {}
	local notFinishMoList = {}
	local finishAndGetRewardMoList = {}

	for _, taskMo in pairs(self.taskMoList) do
		if taskMo.config then
			if not taskMo.config.maxFinishCount then
				local maxFinishCount = 1

				if maxFinishCount <= taskMo.finishCount then
					table.insert(finishAndGetRewardMoList, taskMo)
				elseif taskMo.hasFinished then
					table.insert(finishNotGetRewardMoList, taskMo)
				else
					table.insert(notFinishMoList, taskMo)
				end
			end
		end
	end

	table.sort(finishNotGetRewardMoList, InvestigateTaskListModel._sortFunc)
	table.sort(notFinishMoList, InvestigateTaskListModel._sortFunc)
	table.sort(finishAndGetRewardMoList, InvestigateTaskListModel._sortFunc)

	self.taskMoList = {}

	tabletool.addValues(self.taskMoList, finishNotGetRewardMoList)
	tabletool.addValues(self.taskMoList, notFinishMoList)
	tabletool.addValues(self.taskMoList, finishAndGetRewardMoList)
end

function InvestigateTaskListModel._sortFunc(a, b)
	return a.id < b.id
end

function InvestigateTaskListModel:refreshList()
	if not self.taskMoList then
		return
	end

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

function InvestigateTaskListModel:getFinishTaskCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.config then
			if not taskMo.config.maxFinishCount then
				local maxFinishCount = 1

				if taskMo.hasFinished and maxFinishCount > taskMo.finishCount then
					count = count + 1
				end
			end
		end
	end

	return count
end

function InvestigateTaskListModel:getFinishTaskActivityCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.config then
			if not taskMo.config.maxFinishCount then
				local maxFinishCount = 1

				if taskMo.hasFinished and maxFinishCount > taskMo.finishCount then
					count = count + taskMo.config.activity
				end
			end
		end
	end

	return count
end

function InvestigateTaskListModel:getGetRewardTaskCount()
	local count = 0

	if not self.taskMoList then
		return 0
	end

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.config then
			if not taskMo.config.maxFinishCount then
				local maxFinishCount = 1

				if maxFinishCount <= taskMo.finishCount then
					count = count + 1
				end
			end
		end
	end

	return count
end

InvestigateTaskListModel.instance = InvestigateTaskListModel.New()

return InvestigateTaskListModel
