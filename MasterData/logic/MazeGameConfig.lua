-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mazegame/config/MazeGameConfig.lua

module("logic.extensions.mazegame.config.MazeGameConfig", package.seeall)

local MazeGameConfig = class("MazeGameConfig", BaseConfig)

function MazeGameConfig:getNames()
	return {
		"maze_game_activity",
		"maze_game_stage",
		"maze_game_stage_map"
	}
end

function MazeGameConfig:handleConfig(name, content)
	if name == "maze_game_activity" then
		self._maze_game_activity = content
	elseif name == "maze_game_stage" then
		self._maze_game_stage = content
	elseif name == "maze_game_stage_map" then
		self._maze_game_stage_map = content
	end
end

function MazeGameConfig:getActCfg(activityId)
	return self._maze_game_activity[activityId]
end

function MazeGameConfig:getStageCfgs(activityId)
	return self._maze_game_stage[activityId]
end

function MazeGameConfig:getStageCfgById(activityId, stageId)
	return self._maze_game_stage[activityId] and self._maze_game_stage[activityId][stageId]
end

function MazeGameConfig:getStageMapCfgById(activityId, stageId)
	return self._maze_game_stage_map[activityId] and self._maze_game_stage_map[activityId][stageId]
end

MazeGameConfig.instance = MazeGameConfig.New()

return MazeGameConfig
