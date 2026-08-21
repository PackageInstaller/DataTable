-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/SeasonTaskMO.lua

module("logic.extensions.season.model.SeasonTaskMO", package.seeall)

local M = class("SeasonTaskMO")

function M:ctor(id)
	self._id = id
end

function M:updateByAgent(taskNO)
	self._curNum = taskNO.count
	self._finished = taskNO.finish
end

function M:setTaskCfg(taskCfg)
	self._taskCfg = taskCfg
	self._taskDesc, self._totalNum = TaskUtil.parseContent(self._taskCfg.content, self._taskCfg.param)

	if not string.nilorempty(self._taskCfg.text) then
		self._taskDesc = self._taskCfg.text
	end
end

function M:getId()
	return self._id
end

function M:getType()
	return self._taskCfg.label
end

function M:getScore()
	return self._taskCfg.point
end

function M:getDesc()
	return self._taskDesc
end

function M:getJumpId()
	return checknumber(self._taskCfg.jump)
end

function M:getPriority()
	return self._taskCfg.priority
end

function M:getIcon()
	return self._taskCfg.icon
end

function M:getReward()
	local rewardCO = RewardConfig.instance:getRewardCfgByCode(checknumber(self._taskCfg.reward))

	if rewardCO and rewardCO.reward then
		local item = rewardCO.reward[1]

		return item.code, item.num
	end
end

function M:getProgress()
	return self._curNum, self._totalNum
end

function M:isActive()
	return self._curNum >= self._totalNum
end

function M:canGetReward()
	return not self:isFinished() and self:isActive()
end

function M:isFinished()
	return self._finished
end

function M:setFinished()
	self._finished = true
end

function M:isSecretTask()
	return checknumber(self._taskCfg.secretTime) == 2
end

return M
