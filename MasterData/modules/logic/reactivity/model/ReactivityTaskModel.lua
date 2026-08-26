-- chunkname: @modules/logic/reactivity/model/ReactivityTaskModel.lua

module("modules.logic.reactivity.model.ReactivityTaskModel", package.seeall)

local ReactivityTaskModel = class("ReactivityTaskModel", ListScrollModel)

function ReactivityTaskModel:onInit()
	return
end

function ReactivityTaskModel:reInit()
	return
end

function ReactivityTaskModel:sortTaskMoList()
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

	table.sort(finishNotGetRewardMoList, ReactivityTaskModel._sortFunc)
	table.sort(notFinishMoList, ReactivityTaskModel._sortFunc)
	table.sort(finishAndGetRewardMoList, ReactivityTaskModel._sortFunc)

	self.taskMoList = {}

	tabletool.addValues(self.taskMoList, finishNotGetRewardMoList)
	tabletool.addValues(self.taskMoList, notFinishMoList)
	tabletool.addValues(self.taskMoList, finishAndGetRewardMoList)
end

function ReactivityTaskModel._sortFunc(a, b)
	return a.id < b.id
end

function ReactivityTaskModel:refreshList(actId)
	self.taskMoList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityDungeon, actId)

	self:sortTaskMoList()

	local finishTaskCount = self:getFinishTaskCount()

	if finishTaskCount > 1 then
		local moList = tabletool.copy(self.taskMoList)

		table.insert(moList, 1, {
			getAll = true,
			activityId = actId
		})
		self:setList(moList)
	else
		self:setList(self.taskMoList)
	end
end

function ReactivityTaskModel:getFinishTaskCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxFinishCount then
			count = count + 1
		end
	end

	return count
end

function ReactivityTaskModel:getFinishTaskActivityCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxFinishCount then
			count = count + taskMo.config.activity
		end
	end

	return count
end

function ReactivityTaskModel:getGetRewardTaskCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.finishCount >= taskMo.config.maxFinishCount then
			count = count + 1
		end
	end

	return count
end

ReactivityTaskModel.instance = ReactivityTaskModel.New()

return ReactivityTaskModel
