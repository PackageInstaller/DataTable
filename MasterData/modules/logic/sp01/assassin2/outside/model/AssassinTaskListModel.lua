-- chunkname: @modules/logic/sp01/assassin2/outside/model/AssassinTaskListModel.lua

module("modules.logic.sp01.assassin2.outside.model.AssassinTaskListModel", package.seeall)

local AssassinTaskListModel = class("AssassinTaskListModel", ListScrollModel)

function AssassinTaskListModel:onInit()
	return
end

function AssassinTaskListModel:reInit()
	return
end

function AssassinTaskListModel:initTask()
	self.taskMoList = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.AssassinOutside)
end

function AssassinTaskListModel:sortTaskMoList()
	local finishNotGetRewardMoList = {}
	local notFinishMoList = {}
	local finishAndGetRewardMoList = {}

	for _, taskMo in pairs(self.taskMoList) do
		if taskMo.finishCount >= taskMo.config.maxFinishCount then
			table.insert(finishAndGetRewardMoList, taskMo)
		elseif taskMo.hasFinished then
			table.insert(finishNotGetRewardMoList, taskMo)
		else
			table.insert(notFinishMoList, taskMo)
		end
	end

	table.sort(finishNotGetRewardMoList, AssassinTaskListModel._sortFunc)
	table.sort(notFinishMoList, AssassinTaskListModel._sortFunc)
	table.sort(finishAndGetRewardMoList, AssassinTaskListModel._sortFunc)

	self.taskMoList = {}

	tabletool.addValues(self.taskMoList, finishNotGetRewardMoList)
	tabletool.addValues(self.taskMoList, notFinishMoList)
	tabletool.addValues(self.taskMoList, finishAndGetRewardMoList)
end

function AssassinTaskListModel._sortFunc(a, b)
	return a.id < b.id
end

function AssassinTaskListModel:refreshList()
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

function AssassinTaskListModel:getFinishTaskCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxFinishCount then
			count = count + 1
		end
	end

	return count
end

function AssassinTaskListModel:getFinishTaskActivityCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxFinishCount then
			count = count + taskMo.config.activity
		end
	end

	return count
end

function AssassinTaskListModel:getGetRewardTaskCount()
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

AssassinTaskListModel.instance = AssassinTaskListModel.New()

return AssassinTaskListModel
