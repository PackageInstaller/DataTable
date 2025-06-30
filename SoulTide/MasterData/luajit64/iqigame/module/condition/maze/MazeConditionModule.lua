-- chunkname: @IQIGame\\Module\\Condition\\Maze\\MazeConditionModule.lua

local m = {}

m[Constant.ConditionConstant.TYPE_PLAYER_ATT] = require("IQIGame.Module.Condition.Maze.PlayerAttrConditionChecker")
m[Constant.ConditionConstant.TYPE_ITEM] = require("IQIGame.Module.Condition.Maze.ItemConditionChecker")
m[Constant.ConditionConstant.TYPE_ELEMENT] = require("IQIGame.Module.Condition.Maze.ElementConditionChecker")
m[Constant.ConditionConstant.TYPE_DOLL] = require("IQIGame.Module.Condition.Maze.MazeDollConditionChecker")
m[Constant.ConditionConstant.TYPE_MAZE] = require("IQIGame.Module.Condition.Maze.MazeConditionChecker")

function m.__CheckInner(type, subType, params, comparisonOP, targetValue)
	if m[type] == nil then
		logError("Condition module : type does not exist : {0}.", targetValue)

		return false, nil
	end

	return m[type].Check(type, subType, params, comparisonOP, targetValue)
end

return m
