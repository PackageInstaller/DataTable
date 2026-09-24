-- chunkname: @modules/logic/versionactivity4_0/sonnet/model/SonnetInterchapterTaskListModel.lua

module("modules.logic.versionactivity4_0.sonnet.model.SonnetInterchapterTaskListModel", package.seeall)

local SonnetInterchapterTaskListModel = class("SonnetInterchapterTaskListModel", ListScrollModel)

function SonnetInterchapterTaskListModel:setTaskList()
	local moList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.SonnetInterchapter)

	self._taskMoList = {}
	self._grandPrizeTaskMo = nil

	if moList then
		for _, mo in pairs(moList) do
			if mo.config.isGrandPrize == 0 then
				table.insert(self._taskMoList, mo)
			else
				self._grandPrizeTaskMo = mo
			end
		end
	end

	self:refreshList()
end

function SonnetInterchapterTaskListModel:getGrandPrizeTaskMo()
	return self._grandPrizeTaskMo
end

function SonnetInterchapterTaskListModel.sort(a, b)
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

function SonnetInterchapterTaskListModel:refreshList()
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

function SonnetInterchapterTaskListModel:getFinishTaskCount()
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

function SonnetInterchapterTaskListModel:getFinishTaskActivityCount()
	local count = 0

	for _, taskMo in ipairs(self._taskMoList) do
		if taskMo.hasFinished then
			if taskMo.finishCount < (taskMo.config.maxFinishCount or 1) then
				count = count + (taskMo.config.activity or 0)
			end
		end
	end

	return count
end

function SonnetInterchapterTaskListModel:getGetRewardTaskCount()
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

SonnetInterchapterTaskListModel.instance = SonnetInterchapterTaskListModel.New()

return SonnetInterchapterTaskListModel
