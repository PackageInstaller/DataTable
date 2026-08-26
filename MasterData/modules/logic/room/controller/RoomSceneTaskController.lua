-- chunkname: @modules/logic/room/controller/RoomSceneTaskController.lua

module("modules.logic.room.controller.RoomSceneTaskController", package.seeall)

local RoomSceneTaskController = class("RoomSceneTaskController", BaseController)

function RoomSceneTaskController:onInit()
	return
end

function RoomSceneTaskController:reInit()
	self:clear()
end

function RoomSceneTaskController:clear()
	self:release()
end

function RoomSceneTaskController:release()
	TaskController.instance:unregisterCallback(TaskEvent.SetTaskList, self.refreshData, self)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, self.updateData, self)
	RoomTaskModel.instance:clear()

	self._taskList = nil
	self._cfgGroup = nil
	self._allTaskList = nil
	self._taskMOIdSet = nil
	self._needCheckFinish = true
end

function RoomSceneTaskController:init()
	self:release()
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, self.refreshData, self)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self.updateData, self)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Room
	})
	RoomTaskModel.instance:buildDatas()
end

function RoomSceneTaskController:showHideRoomTopTaskUI(isHide)
	self:dispatchEvent(RoomEvent.TaskShowHideAnim, isHide == true)
end

function RoomSceneTaskController:refreshData()
	RoomTaskModel.instance:handleTaskUpdate()
	self:dispatchEvent(RoomEvent.TaskUpdate)
	self:checkTaskFinished()
end

function RoomSceneTaskController:updateData()
	RoomTaskModel.instance:handleTaskUpdate()
	self:dispatchEvent(RoomEvent.TaskUpdate)

	if self._needCheckFinish then
		self:checkTaskFinished()
	end
end

function RoomSceneTaskController:checkTaskFinished()
	local rs, taskIds = self:isFirstTaskFinished()

	if rs then
		self:dispatchEvent(RoomEvent.TaskCanFinish, taskIds)
	end

	return rs
end

function RoomSceneTaskController:setTaskCheckFinishFlag(value)
	self._needCheckFinish = value
end

function RoomSceneTaskController:isFirstTaskFinished()
	local list = RoomTaskModel.instance:getShowList()

	if list ~= nil and #list > 0 then
		local result

		for i, taskCo in ipairs(list) do
			local taskId = taskCo.id
			local taskMO = RoomTaskModel.instance:tryGetTaskMO(taskId)

			if taskMO and taskMO.hasFinished and taskMO.finishCount <= 0 then
				result = result or {}

				table.insert(result, taskId)
			else
				return result ~= nil, result
			end
		end

		return result ~= nil, result
	end

	return false
end

function RoomSceneTaskController.getProgressStatus(taskMO)
	return taskMO.hasFinished, taskMO.progress
end

function RoomSceneTaskController.hasLocalModifyBlock(taskMO)
	if taskMO.hasFinished then
		return false
	end

	if not RoomSceneTaskValidator.canGetByLocal(taskMO) then
		return false
	end

	if RoomMapBlockModel.instance:getTempBlockMO() or RoomMapBuildingModel.instance:getTempBuildingMO() then
		return true
	else
		local backModel = RoomMapBlockModel.instance:getBackBlockModel()

		if backModel then
			return backModel:getCount() > 0
		end
	end

	return false
end

function RoomSceneTaskController.sortTask(taskA, taskB)
	return RoomSceneTaskController.sortTaskConfig(taskA.config, taskB.config)
end

function RoomSceneTaskController.sortTaskConfig(taskA, taskB)
	local orderA = RoomSceneTaskController.getOrder(taskA)
	local orderB = RoomSceneTaskController.getOrder(taskB)

	if orderA ~= orderB then
		return orderA < orderB
	else
		return taskA.id < taskB.id
	end
end

function RoomSceneTaskController.getOrder(taskCo)
	if not string.nilorempty(taskCo.order) then
		local rs = string.match(taskCo.order, "%d+")

		if not string.nilorempty(rs) then
			return tonumber(rs)
		end
	end

	return 0
end

function RoomSceneTaskController.getTaskTypeKey(listenerType, param)
	if listenerType == RoomSceneTaskEnum.ListenerType.EditResTypeReach then
		return tostring(listenerType) .. "_" .. tostring(param)
	else
		return listenerType
	end
end

function RoomSceneTaskController.isTaskOverUnlockLevel(taskCO)
	local curLv = RoomMapModel.instance:getRoomLevel()
	local nextLv = RoomSceneTaskController.getTaskUnlockLevel(taskCO.openLimit)

	return nextLv <= curLv
end

function RoomSceneTaskController.getTaskUnlockLevel(param)
	local paramData = {}

	for k, v in string.gmatch(param, "(%w+)=(%w+)") do
		paramData[k] = v
	end

	return tonumber(paramData.RoomLevel) or 0
end

function RoomSceneTaskController.getRewardConfigAndIcon(taskCO)
	if taskCO then
		local bonusArr = string.split(taskCO.bonus, "|")

		if #bonusArr > 0 then
			bonusArr = string.splitToNumber(bonusArr[1], "#")

			local itemCo, icon = ItemModel.instance:getItemConfigAndIcon(bonusArr[1], bonusArr[2])

			return itemCo, icon, tonumber(bonusArr[3])
		end
	end

	return nil
end

RoomSceneTaskController.instance = RoomSceneTaskController.New()

return RoomSceneTaskController
