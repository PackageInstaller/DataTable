-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huarongroad/config/HuarongRoadConfig.lua

module("logic.extensions.huarongroad.config.HuarongRoadConfig", package.seeall)

local HuarongRoadConfig = class("HuarongRoadConfig", BaseConfig)

function HuarongRoadConfig:onInit()
	return
end

function HuarongRoadConfig:getNames()
	return {
		"huarongroad_activity",
		"huarongroad_time",
		"huarongroad_stage",
		"huarongroad_game",
		"huarongroad_progress"
	}
end

function HuarongRoadConfig:handleConfig(name, content)
	if name == "huarongroad_activity" then
		self._huarongroad_activity = content
	elseif name == "huarongroad_time" then
		self._huarongroad_time = content
	elseif name == "huarongroad_stage" then
		self._huarongroad_stage = content
	elseif name == "huarongroad_game" then
		self._huarongroad_game = content
	elseif name == "huarongroad_progress" then
		self._huarongroad_progress = content
	end
end

function HuarongRoadConfig:getActivityCfg(activityId)
	return self._huarongroad_activity[activityId]
end

function HuarongRoadConfig:getStage(activityId)
	local challengePlanId = (self:getActivityCfg(activityId) or {}).challengePlanId

	return self._huarongroad_stage[challengePlanId]
end

function HuarongRoadConfig:getChallengePlanId(activityId)
	return self:getActivityCfg(activityId).challengePlanId
end

function HuarongRoadConfig:getGameStageCfg(activityId, stageId)
	local challengePlanId, info

	return (self._huarongroad_activity[activityId] or nil) and self._huarongroad_stage[self._huarongroad_activity[activityId].challengePlanId][stageId]
end

function HuarongRoadConfig:getGameStageList(activityId, stageId)
	local gameInfo = {}
	local info = self:getGameStageCfg(activityId, stageId)

	if info then
		local max = info.rule[1] * info.rule[2]

		for i, v in pairs(self._huarongroad_game[info.levelId]) do
			if v.pos and #v.pos >= 2 then
				local idx = (v.pos[2] - 1) * info.rule[1] + v.pos[1]

				gameInfo[idx] = v.resId
			end
		end

		for i = 1, max do
			if not gameInfo[i] then
				return {}
			end
		end

		gameInfo[max] = gameInfo[max] or max
	end

	return gameInfo
end

function HuarongRoadConfig:getStagePicCfg(levelId)
	local gameInfo = {}

	for i, v in pairs(self._huarongroad_game[levelId]) do
		gameInfo[v.resId] = v.res
	end

	return gameInfo
end

function HuarongRoadConfig:challengeDailyTimes(activityId)
	return self._huarongroad_activity[activityId].challengeDailyTimes
end

function HuarongRoadConfig:getStoryId(activityId, stageId)
	local info = self:getGameStageCfg(activityId, stageId)

	return info.operaId
end

function HuarongRoadConfig:getProgressCfg(activityId, progress)
	if self._huarongroad_progress and self._huarongroad_progress[self:getChallengePlanId(activityId)] then
		return self._huarongroad_progress[self:getChallengePlanId(activityId)][progress]
	else
		return nil
	end
end

function HuarongRoadConfig:getTime(activityId)
	return self._huarongroad_time[self._huarongroad_activity[activityId].timePlanId]
end

HuarongRoadConfig.instance = HuarongRoadConfig.New()

return HuarongRoadConfig
