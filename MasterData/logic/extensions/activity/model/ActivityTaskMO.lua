-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activity/model/ActivityTaskMO.lua

module("logic.extensions.activity.model.ActivityTaskMO", package.seeall)

local M = class("ActivityTaskMO")

function M:ctor()
	self:_resetField()
end

function M:_resetField()
	self._id = nil
	self._count = nil
	self._finish = nil
	self._label = nil
	self._activityId = nil
	self._text = nil
	self._content = nil
	self._param = nil
	self._rewardId = nil
	self._icon = nil
	self._jump = nil
	self._priority = nil
	self._startTime = nil
	self._endTime = nil
	self._preTask = nil
	self._preTask2 = nil
	self._noShow = nil
	self._isOnline = nil
	self._rewardList = nil
	self._taskDesc = nil
	self._maxCount = nil
end

function M:initByTaskNO(taskNO)
	self:_resetField()

	if taskNO == nil then
		printError("error! TaskNO is nil")

		return
	end

	local taskCO = ActivityTaskConfig.instance:getTaskInfoById(taskNO.id)

	if taskCO == nil then
		printError("error! activity task cfg does not exist, id is ", taskNO.id)

		return
	end

	self._id = taskNO.id
	self._finish = taskNO.finish
	self._count = taskNO.count or 0
	self._label = taskCO.label or 0
	self._activityId = taskCO.activityId or 0
	self._text = taskCO.text or ""
	self._content = taskCO.content or 0
	self._param = taskCO.param or ""
	self._rewardId = checknumber(taskCO.reward) or 0
	self._icon = taskCO.icon or 0
	self._jump = taskCO.jump or 0
	self._priority = taskCO.priority or 0
	self._startTime = taskCO.startTime
	self._endTime = taskCO.endTime
	self._preTask = taskCO.preTask
	self._preTask2 = taskCO.preTask2
	self._noShow = taskCO.noShow
	self._isOnline = taskCO.isOnline
end

function M:getId()
	return self._id
end

function M:getCount()
	return self._count
end

function M:setCount(count)
	self._count = count
end

function M:getIsFinish()
	return self._finish
end

function M:setIsFinish(isFinish)
	self._finish = isFinish
end

function M:getLabel()
	return self._label
end

function M:getConfigId()
	return self._activityId
end

function M:getText()
	return string.nilorempty(self._text) and self:getDesc() or self._text
end

function M:getRewardId()
	return self._rewardId
end

function M:getIcon()
	return self._icon
end

function M:getJumpId()
	return self._jump
end

function M:getPriority()
	return self._priority
end

function M:isExpired()
	return not TimeUtil.isInRange(self._startTime, self._endTime)
end

function M:getPreTask()
	return self._preTask
end

function M:getPreTask2()
	return self._preTask2
end

function M:isLimitTask()
	return not self:isExpired() and not string.nilorempty(self._endTime)
end

function M:canShow()
	return not self._noShow
end

function M:isOnLine()
	return self._isOnline
end

function M:getMaxCount()
	if self._maxCount == nil and not string.nilorempty(self._param) and self._content > 0 then
		local _, count = TaskUtil.parseContent(self._content, self._param)

		self._maxCount = count
	end

	self._maxCount = self._maxCount or 1

	return self._maxCount
end

function M:getDesc()
	if self._taskDesc == nil and string.nilorempty(self._text) and not string.nilorempty(self._param) and self._content > 0 then
		local taskDesc = TaskUtil.parseContent(self._content, self._param)

		if not string.nilorempty(taskDesc) then
			self._taskDesc = taskDesc
		end
	end

	self._taskDesc = self._taskDesc or self._text or ""

	return self._taskDesc
end

function M:canJump()
	return self:getJumpId() and self:getJumpId() > 0 or false
end

function M:canGetReward()
	return not self:getIsFinish() and self:getCount() >= self:getMaxCount()
end

function M:getRewardList()
	if not self._rewardList then
		self._rewardList = {}

		local rewardCO = RewardConfig.instance:getRewardCfgByCode(self._rewardId)

		if rewardCO then
			for _, reward in ipairs(rewardCO.reward or {}) do
				table.insert(self._rewardList, {
					itemId = reward.code,
					num = reward.num
				})
			end
		end
	end

	return self._rewardList
end

function M:getRewardStatus()
	if self:getIsFinish() then
		return TaskEnum.TaskState.Finish
	elseif self:canGetReward() then
		return TaskEnum.TaskState.CanReceive
	end

	return TaskEnum.TaskState.Doing
end

return M
