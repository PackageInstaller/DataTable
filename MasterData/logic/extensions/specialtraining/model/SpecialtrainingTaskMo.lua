-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/specialtraining/model/SpecialtrainingTaskMo.lua

module("logic.extensions.specialtraining.model.SpecialtrainingTaskMo", package.seeall)

local M = class("SpecialtrainingTaskMo", TaskMo)

function M:ctor()
	self.super.ctor(self)

	self._stageId = false
end

function M:initData(taskId, count, isFinish, taskCO)
	self._id = taskId
	self._count = count
	self._isFinish = isFinish
	self._taskCO = taskCO

	if not self._taskCO then
		return
	end

	self._stageId = self._taskCO.stage
	self._content = self._taskCO.content
	self._text = self._taskCO.text
	self._param = self._taskCO.param
	self._rewardId = checknumber(self._taskCO.reward)
	self._icon = self._taskCO.icon
	self._jump = self._taskCO.jump
	self._priority = self._taskCO.priority
	self._preTask = self._taskCO.preTask
	self._preTask2 = self._taskCO.preTask2
	self._preTask3 = self._taskCO.preTask3
	self._noShow = self._taskCO.noShow
	self._isOnline = self._taskCO.isOnline
	self._startTime = ""
	self._endTime = ""
	self._canJump = not string.nilorempty(self._jump)
	self._rewardList = self:_parseReward()

	self:_parseTask()
end

function M:getStageId()
	return self._stageId
end

function M:getPreTask1()
	return self._preTask
end

function M:getPreTask2()
	return self._preTask2
end

function M:getPreTask3()
	return self._preTask3
end

function M:getPreTask()
	local preTask = self._preTask

	if preTask == 0 then
		preTask = self._preTask2
	end

	if preTask == 0 then
		preTask = self._preTask3
	end

	return preTask
end

return M
