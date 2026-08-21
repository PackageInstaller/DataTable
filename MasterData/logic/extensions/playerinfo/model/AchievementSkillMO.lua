-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/model/AchievementSkillMO.lua

module("logic.extensions.playerinfo.model.AchievementSkillMO", package.seeall)

local M = class("AchievementSkillMO")

function M:ctor(cfg)
	self._id = cfg.id
	self._cfg = cfg
	self._cfgLabel = AchievementConfig.instance:getAchievementLabelCO(cfg.id)
	self._skillLevel = 0
	self._skillExp = 0
	self._getRewardLevels = false
end

function M:update(data)
	self._skillLevel = data.level
	self._skillExp = data.exp
	self._getRewardLevels = data.gainedRewardLevels
end

function M:getId()
	return self._id
end

function M:getLevel()
	return self._cfg.level
end

function M:getLevelFlag()
	return self._cfg.levelFlag
end

function M:getName()
	return self._cfgLabel.name
end

function M:getIcon()
	return self._cfgLabel.icon
end

function M:getDescOne()
	return self._cfgLabel.effect
end

function M:getDescTwo()
	return self._cfgLabel.describe
end

function M:getSkillLevel()
	return self._skillLevel
end

function M:getSkillExp()
	return self._skillExp
end

function M:getSkillExpNeed()
	return self._cfg.requireExp
end

function M:getEffectValue()
	return self._cfg.effectParams
end

function M:getEffectColor()
	return self._cfg.effectParamsColor
end

function M:canGetLevelReward(level)
	return level <= self._skillLevel
end

function M:isGetLevelReward(level)
	local isGet = false

	for i, v in ipairs(self._getRewardLevels or {}) do
		if v == level then
			isGet = true
		end
	end

	return isGet
end

return M
