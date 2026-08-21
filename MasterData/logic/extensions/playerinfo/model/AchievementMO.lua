-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/model/AchievementMO.lua

module("logic.extensions.playerinfo.model.AchievementMO", package.seeall)

local AchievementMO = class("AchievementMO")

function AchievementMO:ctor(cfg)
	self._id = cfg.id
	self._skillId = cfg.skillId
	self._name = cfg.name
	self._text = cfg.text
	self._icon = cfg.icon
	self._content = cfg.content
	self._param = cfg.param
	self._rewardId = checknumber(cfg.reward)
	self._isOnline = cfg.isOnline > 0
	self._priority = cfg.priority
	self._jumpId = cfg.jumpId
	self._preTask = cfg.preTask
	self._preTask2 = cfg.preTask2
	self._finishCnt = 0
	self._isFinish = false
end

function AchievementMO:getId()
	return self._id
end

function AchievementMO:getSkillId()
	return self._skillId
end

function AchievementMO:getName()
	return self._name
end

function AchievementMO:getIcon()
	return self._icon
end

function AchievementMO:canJump()
	return self:getJumpId() > 0
end

function AchievementMO:getJumpId()
	return self._jumpId
end

function AchievementMO:getPreTask()
	return self._preTask
end

function AchievementMO:getPreTask2()
	return self._preTask2
end

function AchievementMO:getPriority()
	return self._priority
end

function AchievementMO:getDesc()
	if not self._taskDesc then
		self:_parseTask()
	end

	return self._taskDesc
end

function AchievementMO:setFinishCnt(count)
	self._finishCnt = count
end

function AchievementMO:getMaxCnt()
	if not self._maxCount then
		self:_parseTask()
	end

	if not self._maxCount then
		self._maxCount = 0
	end

	return tonumber(self._maxCount)
end

function AchievementMO:getFinishCnt()
	return self._finishCnt
end

function AchievementMO:setIsFinish(isFinish)
	self._isFinish = isFinish
end

function AchievementMO:getIsFinish()
	return self._isFinish
end

function AchievementMO:getIsOnline()
	return self._isOnline
end

function AchievementMO:setIsOnline(isOnline)
	self._isOnline = isOnline
end

function AchievementMO:canGetReward()
	return self:getFinishCnt() >= self:getMaxCnt()
end

function AchievementMO:getRewardList()
	if not self._rewardList then
		self._rewardList = self:_parseReward()
	end

	return self._rewardList
end

function AchievementMO:_parseReward()
	local rewardId = tonumber(self._rewardId)
	local rewardCO = RewardConfig.instance:getRewardCfgByCode(rewardId)
	local tempList = {}

	if rewardCO then
		for i, v in ipairs(rewardCO.reward and rewardCO.reward or {}) do
			table.insert(tempList, {
				itemId = v.code,
				num = v.num
			})
		end
	end

	return tempList
end

function AchievementMO:_parseTask()
	if not string.nilorempty(self._param) and self._content > 0 then
		self._taskDesc, self._maxCount, self._isTaskGroup = TaskUtil.parseContent(self._content, self._param)
	end

	if not string.nilorempty(self._text) then
		self._taskDesc = self._text
	end
end

return AchievementMO
