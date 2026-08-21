-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/model/claw_doll/ClawDollTaskMo.lua

module("logic.extensions.welfare.model.claw_doll.ClawDollTaskMo", package.seeall)

local M = class("ClawDollTaskMo")

function M:ctor()
	self._id = nil
	self._finish = nil
	self._curCount = nil
	self._label = nil
	self._activityId = nil
	self._text = nil
	self._content = nil
	self._param = nil
	self._rewardId = nil
	self._icon = nil
	self._jump = nil
	self._priority = nil
	self._taskDesc = nil
	self._maxCount = nil
	self._rewardItemData = nil
end

function M:setClawTaskMo(taskNo)
	if taskNo ~= nil and ActivityTaskConfig.instance:getTaskInfoById(taskNo.id) then
		local msg = ActivityTaskConfig.instance:getTaskInfoById(taskNo.id)

		self._id = taskNo.id
		self._finish = taskNo.finish
		self._curCount = taskNo.count
		self._label = msg and msg.label or 0
		self._activityId = msg and msg.activityId or 0
		self._text = msg and msg.text or ""
		self._content = msg and msg.content or 0
		self._param = msg and msg.param or ""
		self._rewardId = msg and checknumber(msg.reward) or 0
		self._icon = msg and msg.icon or 0
		self._jump = msg and msg.jump or ""
		self._jump = string.nilorempty(self._jump) and 0 or tonumber(self._jump)
		self._priority = msg and msg.priority or 0

		if not string.nilorempty(self._param) and self._content > 0 then
			local taskDesc, maxCount = TaskUtil.parseContent(self._content, self._param)

			if not string.nilorempty(taskDesc) then
				self._taskDesc = taskDesc
			end

			self._maxCount = maxCount
		end

		if not string.nilorempty(self._text) then
			self._taskDesc = self._text
		end
	elseif taskNo == nil then
		printError("夹娃娃任务传入参数错误")
	elseif ActivityTaskConfig.instance:getTaskInfoById(taskNo.id) == nil then
		printError("活动任务配置表里没有该任务" .. taskNo.id)
	end
end

function M:getId()
	return self._id
end

function M:getCount()
	return self._curCount
end

function M:setCount(count)
	self._curCount = count
end

function M:getPriority()
	return self._priority
end

function M:setIsFinish(isFinish)
	self._finish = isFinish
end

function M:getIsFinish()
	if self._finish then
		return 1
	else
		return 0
	end
end

function M:getMaxCnt()
	return self._maxCount or 1
end

function M:getDesc()
	return self._taskDesc
end

function M:getConfigId()
	return self._activityId
end

function M:getJumpId()
	return self._jump
end

function M:canJump()
	return not string.nilorempty(self:getJumpId())
end

function M:canGetReward()
	if self:getCount() >= self:getMaxCnt() then
		return 1
	else
		return 0
	end
end

function M:getRewardItemData()
	if not self._rewardItemData then
		local rewardInfo = RewardConfig.instance:getRewardCfgByCode(self._rewardId)
		local itemId = rewardInfo.reward[1].code
		local count = rewardInfo.reward[1].num

		self._rewardItemData = ItemUtil.createItemData({
			itemId = itemId
		})

		self._rewardItemData:setCount(count)
	end

	return self._rewardItemData
end

function M:getRewardStatus()
	if self:getIsFinish() > 0 then
		return ClawDollConfig.TaskState.IsReceived
	elseif self:canGetReward() > 0 then
		return ClawDollConfig.TaskState.CanReceive
	end

	return ClawDollConfig.TaskState.Doing
end

return M
