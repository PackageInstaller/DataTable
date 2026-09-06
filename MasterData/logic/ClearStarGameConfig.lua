-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/clearstargame/config/ClearStarGameConfig.lua

module("logic.extensions.clearstargame.config.ClearStarGameConfig", package.seeall)

local ClearStarGameConfig = class("ClearStarGameConfig", BaseConfig)

function ClearStarGameConfig:getNames()
	return {
		"clear_star_game_score_plan",
		"clear_star_game_map_plan",
		"clear_star_game_item",
		"clear_star_game_activity",
		"clear_star_game_convert",
		"clear_star_game_img_rules"
	}
end

function ClearStarGameConfig:handleConfig(name, content)
	if name == "clear_star_game_score_plan" then
		self._clear_star_game_score_plan = content
	elseif name == "clear_star_game_map_plan" then
		self._clear_star_game_map_plan = content
	elseif name == "clear_star_game_item" then
		self._clear_star_game_item = content
	elseif name == "clear_star_game_activity" then
		self._clear_star_game_activity = content
	elseif name == "clear_star_game_convert" then
		self._clear_star_game_convert = content
	elseif name == "clear_star_game_img_rules" then
		self._clear_star_game_img_rules = content
	end
end

function ClearStarGameConfig:getActivityCfgById(activityId)
	return self._clear_star_game_activity[activityId]
end

function ClearStarGameConfig:getDailyTime(activityId)
	local data = self:getActivityCfgById(activityId)

	return (data or nil) and (data.dailyTime or 0)
end

function ClearStarGameConfig:getItemCfgsById(activityId)
	return self._clear_star_game_item[activityId]
end

function ClearStarGameConfig:getScorePlanCfgsById(planId)
	return self._clear_star_game_score_plan[planId]
end

function ClearStarGameConfig:getMapPlanCfgsById(planId)
	return self._clear_star_game_map_plan[planId]
end

function ClearStarGameConfig:getConvertCfgsById(activityId)
	return self._clear_star_game_convert[activityId]
end

function ClearStarGameConfig:getConvertCfgByType(activityId, scoreType)
	if self._clear_star_game_convert[activityId] then
		return self._clear_star_game_convert[activityId][scoreType]
	end
end

function ClearStarGameConfig:getImgRuleCfgs(actId)
	return self._clear_star_game_img_rules[actId]
end

ClearStarGameConfig.instance = ClearStarGameConfig.New()

return ClearStarGameConfig
