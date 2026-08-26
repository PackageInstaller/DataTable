-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/EliminateTaskListModel.lua

module("modules.logic.versionactivity2_2.eliminate.model.EliminateTaskListModel", package.seeall)

local EliminateTaskListModel = class("EliminateTaskListModel", ListScrollModel)

function EliminateTaskListModel:onInit()
	return
end

function EliminateTaskListModel:reInit()
	self._allTaskMoList = {}
end

function EliminateTaskListModel:initTask()
	local totalStar = EliminateOutsideModel.instance:getTotalStar()

	self._allTaskMoList = {}

	for i, config in ipairs(lua_eliminate_reward.configList) do
		local mo = self._allTaskMoList[i]

		if not mo then
			mo = TaskMo.New()
			mo.id = config.id
			mo.progress = totalStar
			mo.config = {
				maxFinishCount = 1,
				id = config.id,
				desc = config.desc,
				bonus = config.bonus,
				maxProgress = config.star
			}
			self._allTaskMoList[i] = mo
		end

		mo.hasFinished = totalStar >= config.star
		mo.finishCount = EliminateOutsideModel.instance:gainedTask(config.id) and 1 or 0
	end
end

function EliminateTaskListModel:sortTaskMoList()
	local finishNotGetRewardMoList = {}
	local notFinishMoList = {}
	local finishAndGetRewardMoList = {}

	for _, taskMo in ipairs(self._allTaskMoList) do
		if taskMo.finishCount >= taskMo.config.maxFinishCount then
			table.insert(finishAndGetRewardMoList, taskMo)
		elseif taskMo.hasFinished then
			table.insert(finishNotGetRewardMoList, taskMo)
		else
			table.insert(notFinishMoList, taskMo)
		end
	end

	table.sort(finishNotGetRewardMoList, EliminateTaskListModel._sortFunc)
	table.sort(notFinishMoList, EliminateTaskListModel._sortFunc)
	table.sort(finishAndGetRewardMoList, EliminateTaskListModel._sortFunc)

	self.taskMoList = {}

	tabletool.addValues(self.taskMoList, finishNotGetRewardMoList)
	tabletool.addValues(self.taskMoList, notFinishMoList)
	tabletool.addValues(self.taskMoList, finishAndGetRewardMoList)
end

function EliminateTaskListModel._sortFunc(a, b)
	return a.id < b.id
end

function EliminateTaskListModel:refreshList()
	local finishTaskCount = self:getFinishTaskCount()

	if finishTaskCount > 1 then
		local moList = tabletool.copy(self.taskMoList)

		table.insert(moList, 1, {
			id = 0,
			getAll = true
		})
		self:setList(moList)
	else
		self:setList(self.taskMoList)
	end
end

function EliminateTaskListModel:getFinishTaskCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxFinishCount then
			count = count + 1
		end
	end

	return count
end

function EliminateTaskListModel:getFinishTaskActivityCount()
	local count = 0

	for _, taskMo in ipairs(self.taskMoList) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxFinishCount then
			count = count + taskMo.config.activity
		end
	end

	return count
end

function EliminateTaskListModel:getGetRewardTaskCount()
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

EliminateTaskListModel.instance = EliminateTaskListModel.New()

return EliminateTaskListModel
