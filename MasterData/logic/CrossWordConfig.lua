-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crossword/config/CrossWordConfig.lua

module("logic.extensions.crossword.config.CrossWordConfig", package.seeall)

local CrossWordConfig = class("CrossWordConfig", BaseConfig)

function CrossWordConfig:getNames()
	return {
		"guess_puzzle_gird",
		"guess_puzzle_prize",
		"guess_puzzle_activity"
	}
end

function CrossWordConfig:handleConfig(name, content)
	if name == "guess_puzzle_gird" then
		self._guess_puzzle_gird = content
	elseif name == "guess_puzzle_prize" then
		self._guess_puzzle_prize = content
	elseif name == "guess_puzzle_activity" then
		self._guess_puzzle_activity = content
	end
end

function CrossWordConfig:getActCfgById(activityId)
	return self._guess_puzzle_activity[activityId]
end

function CrossWordConfig:getGridCfgListById(activityId)
	return self._guess_puzzle_gird[activityId]
end

function CrossWordConfig:getGridCfgById(activityId, gridId)
	if self._guess_puzzle_gird[activityId] then
		return self._guess_puzzle_gird[activityId][gridId]
	end
end

function CrossWordConfig:getPrizeCfgListById(activityId)
	return self._guess_puzzle_prize[activityId]
end

function CrossWordConfig:getPrizeCfgById(activityId, sentenceId)
	if self._guess_puzzle_prize[activityId] then
		return self._guess_puzzle_prize[activityId][sentenceId]
	end
end

CrossWordConfig.instance = CrossWordConfig.New()

return CrossWordConfig
