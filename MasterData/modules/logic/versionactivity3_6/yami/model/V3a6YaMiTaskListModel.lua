-- chunkname: @modules/logic/versionactivity3_6/yami/model/V3a6YaMiTaskListModel.lua

module("modules.logic.versionactivity3_6.yami.model.V3a6YaMiTaskListModel", package.seeall)

local V3a6YaMiTaskListModel = class("V3a6YaMiTaskListModel", ListScrollModel)

function V3a6YaMiTaskListModel:setTaskList()
	local actId = V3a6YaMiModel.instance:getActId()
	local moList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Act231, actId)

	self._taskMoList = {}

	if moList then
		for _, mo in pairs(moList) do
			table.insert(self._taskMoList, mo)
		end
	end

	self:refreshList()
end

function V3a6YaMiTaskListModel.sort(a, b)
	if a.getAll then
		return true
	end

	if b.getAll then
		return false
	end

	local aValue = (a.config.maxFinishCount or 1) <= a.finishCount and 3 or a.hasFinished and 1 or 2
	local bValue = ((not b.config.maxFinishCount or nil) and 1) <= b.finishCount and 3 or b.hasFinished and 1 or 2

	if aValue ~= bValue then
		return aValue < bValue
	elseif a.config.sortId ~= b.config.sortId then
		return a.config.sortId < b.config.sortId
	else
		return a.config.id < b.config.id
	end
end

function V3a6YaMiTaskListModel:refreshList()
	local finishTaskCount = self:getFinishTaskCount()

	if finishTaskCount > 1 then
		local moList = tabletool.copy(self._taskMoList)

		table.insert(moList, 1, {
			getAll = true
		})
		table.sort(moList, self.sort)
		self:setList(moList)
	else
		table.sort(self._taskMoList, self.sort)
		self:setList(self._taskMoList)
	end
end

function V3a6YaMiTaskListModel:getFinishTaskCount()
	local count = 0

	for _, taskMo in ipairs(self._taskMoList) do
		if taskMo.hasFinished then
			if taskMo.finishCount < (taskMo.config.maxFinishCount or 1) then
				count = count + 1
			end
		end
	end

	return count
end

function V3a6YaMiTaskListModel:getFinishTaskActivityCount()
	local count = 0

	for _, taskMo in ipairs(self._taskMoList) do
		if taskMo.hasFinished then
			if taskMo.finishCount < (taskMo.config.maxFinishCount or 1) then
				count = count + taskMo.config.activity
			end
		end
	end

	return count
end

function V3a6YaMiTaskListModel:getGetRewardTaskCount()
	local count = 0

	if not self._taskMoList then
		return 0
	end

	for _, taskMo in ipairs(self._taskMoList) do
		if (taskMo.config.maxFinishCount or 1) <= taskMo.finishCount then
			count = count + 1
		end
	end

	return count
end

V3a6YaMiTaskListModel.instance = V3a6YaMiTaskListModel.New()

return V3a6YaMiTaskListModel
