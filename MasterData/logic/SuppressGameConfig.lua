-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/suppressgame/config/SuppressGameConfig.lua

module("logic.extensions.suppressgame.config.SuppressGameConfig", package.seeall)

local SuppressGameConfig = class("SuppressGameConfig", BaseConfig)

function SuppressGameConfig:onInit()
	SuppressGameConfig.super.onInit(self)
end

function SuppressGameConfig:getNames()
	return {
		"suppress_game_activity",
		"suppress_game_tab",
		"suppress_game_progress",
		"suppress_task_activity"
	}
end

function SuppressGameConfig:handleConfig(name, content)
	if name == "suppress_game_activity" then
		self._sgActCfg = content
	elseif name == "suppress_game_tab" then
		self._sgTabCfgs = content
	elseif name == "suppress_game_progress" then
		self._sgProgressCfgs = content
	elseif name == "suppress_task_activity" then
		self._sgTaskCfgs = content
	end
end

function SuppressGameConfig:getSgActCfg()
	return self._sgActCfg
end

function SuppressGameConfig:getSgActData(activityId)
	return self:getSgActCfg()[activityId]
end

function SuppressGameConfig:getSgDailyGameTime(activityId)
	return self:getSgActCfg()[activityId].dailyGameTime
end

function SuppressGameConfig:getSgTabCfg(activityId)
	return self._sgTabCfgs[activityId]
end

function SuppressGameConfig:getSgTabData(activityId, gameId)
	return self:getSgTabCfg(activityId)[gameId]
end

function SuppressGameConfig:getSgProgressCfg(progressPlanId)
	return self._sgProgressCfgs[progressPlanId]
end

function SuppressGameConfig:getSgProgressData(progressPlanId, progressIdx)
	return self:getSgProgressCfg(progressPlanId)[progressIdx]
end

function SuppressGameConfig:getSgTaskCfg(taskPlanId)
	return self._sgTaskCfgs[taskPlanId]
end

function SuppressGameConfig:getSgTaskData(taskPlanId, taskId)
	return self:getSgTaskCfg(taskPlanId)[taskId]
end

SuppressGameConfig.instance = SuppressGameConfig.New()

return SuppressGameConfig
