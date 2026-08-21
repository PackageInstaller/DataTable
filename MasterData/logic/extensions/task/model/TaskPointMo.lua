-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/TaskPointMo.lua

module("logic.extensions.task.model.TaskPointMo", package.seeall)

local M = class("TaskPointMo")

function M:ctor()
	self._tabId = false
	self._curPoint = false
	self._isFinish = false
	self._canGetReward = false
	self._pointId = false
	self._taskPointCO = false
	self._rewardId = false
end

function M:initAgentData(tabId, curPoint, isFinish, pointId)
	self._tabId = tabId
	self._curPoint = curPoint
	self._pointId = pointId
	self._isFinish = isFinish
	self._taskPointCO = TaskConfig.instance:getTaskPointCO(pointId)

	if not self._taskPointCO then
		return
	end

	self._needPoint = self._taskPointCO.point
	self._canGetReward = self._curPoint > self._needPoint
	self._rewardId = self._taskPointCO.rewardId
end

function M:updateData(curPoint, isFinish)
	self._curPoint = curPoint
	self._isFinish = isFinish
	self._canGetReward = self._curPoint >= self._taskPointCO.point
end

function M:getPointId()
	return self._pointId
end

function M:getFinish()
	return self._isFinish
end

function M:canGetReward()
	return self._canGetReward
end

function M:getTabId()
	return self._tabId
end

function M:getRewardId()
	return self._rewardId
end

function M:getNeedPoint()
	return self._needPoint
end

return M
