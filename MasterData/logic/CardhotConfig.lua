-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cardhot/config/CardhotConfig.lua

module("logic.extensions.cardhot.config.CardhotConfig", package.seeall)

local CardhotConfig = class("CardhotConfig", BaseConfig)

function CardhotConfig:onInit()
	CardhotConfig.super.onInit(self)
end

function CardhotConfig:getNames()
	return {
		"pool_pre_heat_config",
		"pool_pre_heat_daily_prize",
		"pool_pre_heat_story",
		"dark_dragon_preheat_activity",
		"dark_dragon_preheat_progress",
		"dark_dragon_preheat_task"
	}
end

function CardhotConfig:handleConfig(name, content)
	if name == "pool_pre_heat_config" then
		self._baseCfgs = content
	elseif name == "pool_pre_heat_daily_prize" then
		self._prizeCfgs = content
	elseif name == "pool_pre_heat_story" then
		self._storyCfgs = content
	elseif name == "dark_dragon_preheat_task" then
		self.dark_taskCfgs = content
	elseif name == "dark_dragon_preheat_progress" then
		self.dark_progressCfgs = content
	elseif name == "dark_dragon_preheat_activity" then
		self.dark_activityCfgs = content
	end
end

function CardhotConfig:getTaskActivityCfg(actId)
	return self.dark_activityCfgs[actId] or {}
end

function CardhotConfig:getTaskRewardCfg(actId)
	if not self.dark_activityCfgs[actId] then
		if self.dark_activityCfgs[actId].progressPlanId then
			return self.dark_progressCfgs[self.dark_activityCfgs[actId].progressPlanId] or {}
		end
	end
end

function CardhotConfig:getTaskDetailsCfg(actId)
	if not self.dark_activityCfgs[actId] then
		if self.dark_activityCfgs[actId].taskPlanId then
			return self.dark_taskCfgs[self.dark_activityCfgs[actId].taskPlanId] or {}
		end

		return {}
	end
end

function CardhotConfig:getFriendListById(actId)
	return self._baseCfgs[actId].raceId
end

function CardhotConfig:getSignInDayById(actId)
	return self._baseCfgs[actId].signInDay
end

function CardhotConfig:getStoryCfgsById(actId)
	return self._storyCfgs[self._baseCfgs[actId].storyPlanId]
end

function CardhotConfig:getPrizeCfgsById(actId)
	return self._prizeCfgs[self._baseCfgs[actId].dailyPlanId]
end

CardhotConfig.instance = CardhotConfig.New()

return CardhotConfig
