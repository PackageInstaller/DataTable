-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/geargame/config/GearGameConfig.lua

module("logic.extensions.geargame.config.GearGameConfig", package.seeall)

local GearGameConfig = class("GearGameConfig", BaseConfig)

function GearGameConfig:getNames()
	return {
		"gear_game_activity",
		"gear_game_stage",
		"gear_game_puzzle",
		"gear_game_rule"
	}
end

function GearGameConfig:handleConfig(name, content)
	if name == "gear_game_activity" then
		self._gear_game_activity = content
	elseif name == "gear_game_stage" then
		self._gear_game_stage = content
	elseif name == "gear_game_puzzle" then
		self._gear_game_puzzle = content
	elseif name == "gear_game_rule" then
		self._gear_game_rule = content
	end
end

function GearGameConfig:getActivityCfg(activityId)
	return self._gear_game_activity[activityId]
end

function GearGameConfig:getStageCfgs(activityId)
	return self._gear_game_stage[activityId]
end

function GearGameConfig:getStageCfg(activityId, stageId)
	return self._gear_game_stage[activityId] and self._gear_game_stage[activityId][stageId]
end

function GearGameConfig:getPuzzleCfg(puzzleId)
	return self._gear_game_puzzle[puzzleId]
end

function GearGameConfig:getPuzzleCfgs()
	return self._gear_game_puzzle
end

function GearGameConfig:getGameRuleCfgs(ruleId)
	return self._gear_game_rule[ruleId]
end

GearGameConfig.instance = GearGameConfig.New()

return GearGameConfig
