-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/config/FishingGameConfig.lua

module("logic.extensions.fishinggame.config.FishingGameConfig", package.seeall)

local FishingGameConfig = class("FishingGameConfig", BaseConfig)

function FishingGameConfig:getNames()
	return {
		"fishing_game_activity",
		"fishing_game_game",
		"fishing_game_fish",
		"fishing_game_prize"
	}
end

function FishingGameConfig:handleConfig(name, content)
	if name == "fishing_game_activity" then
		self._fishing_game_activity = content
	elseif name == "fishing_game_game" then
		self._fishing_game_game = content
	elseif name == "fishing_game_fish" then
		self._fishing_game_fish = content
	elseif name == "fishing_game_prize" then
		self._fishing_game_prize = content
	end
end

function FishingGameConfig:getActivityCfg(activityId)
	return self._fishing_game_activity and self._fishing_game_activity[activityId]
end

function FishingGameConfig:getGameCfg(gamePlanId)
	return self._fishing_game_game and self._fishing_game_game[gamePlanId]
end

function FishingGameConfig:getFishCfgs(fishPlanId)
	return self._fishing_game_fish and self._fishing_game_fish[fishPlanId]
end

function FishingGameConfig:getFishCfg(fishPlanId, fishId)
	return self._fishing_game_fish and self._fishing_game_fish[fishPlanId] and self._fishing_game_fish[fishPlanId][fishId]
end

function FishingGameConfig:getPrizeCfgs(activityId)
	return self._fishing_game_prize and self._fishing_game_prize[activityId]
end

function FishingGameConfig:getPrizeCfg(activityId, prizeId)
	return self._fishing_game_prize and self._fishing_game_prize[activityId] and self._fishing_game_prize[activityId][prizeId]
end

FishingGameConfig.instance = FishingGameConfig.New()

return FishingGameConfig
