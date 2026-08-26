-- chunkname: @modules/logic/abyss/model/AbyssTaskListModel.lua

module("modules.logic.abyss.model.AbyssTaskListModel", package.seeall)

local AbyssTaskListModel = class("AbyssTaskListModel", ListScrollModel)

function AbyssTaskListModel:setTaskRewardList(value)
	self._rewardList = value
end

function AbyssTaskListModel:getTaskRewardList()
	return self._rewardList
end

function AbyssTaskListModel:initList(actId)
	local list = AbyssConfig.instance:getTaskConfigListByActId(actId) or {}
	local finishNotGetRewardMoList = {}
	local notFinishMoList = {}
	local finishAndGetRewardMoList = {}

	self._taskMoDic = {}

	local num = 0

	for _, config in ipairs(list) do
		local taskMo = TaskModel.instance:getTaskById(config.id)

		if taskMo then
			self._taskMoDic[taskMo.id] = taskMo

			if taskMo.finishCount >= taskMo.config.maxFinishCount then
				table.insert(finishAndGetRewardMoList, taskMo.config)
			elseif taskMo.hasFinished then
				table.insert(finishNotGetRewardMoList, taskMo.config)

				num = num + 1
			else
				table.insert(notFinishMoList, taskMo.config)
			end
		else
			table.insert(notFinishMoList, config)
		end
	end

	table.sort(finishNotGetRewardMoList, AbyssTaskListModel._sortFunction)
	table.sort(notFinishMoList, AbyssTaskListModel._sortFunction)
	table.sort(finishAndGetRewardMoList, AbyssTaskListModel._sortFunction)

	local result = {}

	tabletool.addValues(result, finishNotGetRewardMoList)
	tabletool.addValues(result, notFinishMoList)
	tabletool.addValues(result, finishAndGetRewardMoList)

	if num > 1 then
		table.insert(result, 1, {
			id = 0,
			isGetAll = true
		})
	end

	self.haveGetAllItem = num > 1

	local fakeItem = {
		isDirtyData = true
	}

	table.insert(result, fakeItem)
	self:setList(result)
end

function AbyssTaskListModel._sortFunction(a, b)
	return a.id < b.id
end

function AbyssTaskListModel:_canGet(id)
	local taskMo = self._taskMoDic[id]

	if taskMo then
		local isGet = taskMo.finishCount >= taskMo.config.maxFinishCount
		local isFinish = taskMo.hasFinished

		if isFinish and not isGet then
			return true
		end
	end

	return false
end

function AbyssTaskListModel:getCanGetList()
	local list = {}

	for i, v in ipairs(self:getList()) do
		if v.id and self:_canGet(v.id) then
			table.insert(list, v.id)
		end
	end

	return list
end

AbyssTaskListModel.instance = AbyssTaskListModel.New()

return AbyssTaskListModel
