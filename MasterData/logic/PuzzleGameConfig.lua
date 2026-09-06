-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/puzzlegame/config/PuzzleGameConfig.lua

module("logic.extensions.puzzlegame.config.PuzzleGameConfig", package.seeall)

local PuzzleGameConfig = class("PuzzleGameConfig", BaseConfig)

function PuzzleGameConfig:onInit()
	PuzzleGameConfig.super.onInit(self)
end

function PuzzleGameConfig:getNames()
	return {
		"puzzle_game_activity",
		"puzzle_game_jigsaw_piece_plan",
		"puzzle_game_jigsaw",
		"puzzle_game_progress"
	}
end

function PuzzleGameConfig:handleConfig(name, content)
	if name == "puzzle_game_activity" then
		self._actCfg = content
	elseif name == "puzzle_game_jigsaw_piece_plan" then
		self._pieceCfg = content
	elseif name == "puzzle_game_jigsaw" then
		self._puzzleCfg = content
	elseif name == "puzzle_game_progress" then
		self._progressCfg = content
	end
end

function PuzzleGameConfig:getGamePieceCfgs(planId)
	return self._pieceCfg[planId]
end

function PuzzleGameConfig:getProgressCfgs(actId)
	local actCfg = self._actCfg[actId]

	return actCfg and self._progressCfg[actCfg.progressPlanId]
end

function PuzzleGameConfig:getPuzzleCfgs(actId)
	local actCfg = self._actCfg[actId]

	return actCfg and self._puzzleCfg[actCfg.jigsawPlanId]
end

PuzzleGameConfig.instance = PuzzleGameConfig.New()

return PuzzleGameConfig
