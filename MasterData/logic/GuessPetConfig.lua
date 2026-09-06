-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesspets/config/GuessPetConfig.lua

module("logic.extensions.guesspets.config.GuessPetConfig", package.seeall)

local GuessPetConfig = class("GuessPetConfig", BaseConfig)

function GuessPetConfig:getNames()
	return {
		"guess_game_activity",
		"guess_game_person_prize",
		"guess_game_global_prize",
		"guess_game_race",
		"guessgame_gametips"
	}
end

function GuessPetConfig:handleConfig(name, content)
	if name == "guess_game_activity" then
		self._activities = content
	elseif name == "guess_game_person_prize" then
		self._personPrizes = content
	elseif name == "guess_game_global_prize" then
		self._globalPrizes = content
	elseif name == "guess_game_race" then
		self._gameQuestions = content
	elseif name == "guessgame_gametips" then
		self._bubbleConfig = content
	end
end

function GuessPetConfig:getActivities()
	return self._activities.dataList
end

function GuessPetConfig:getActivityCo(activityId)
	return self._activities[activityId]
end

function GuessPetConfig:getPersonPrizes(personPrizePlanId)
	return self._personPrizes[personPrizePlanId]
end

function GuessPetConfig:getGlobalPrizes(prizePlanId)
	return self._globalPrizes[prizePlanId]
end

function GuessPetConfig:getQuestionCo(raceId)
	return self._gameQuestions[raceId]
end

function GuessPetConfig:getAllQuestionCos()
	return self._gameQuestions.dataList
end

function GuessPetConfig:getBubbles(planId)
	return self._bubbleConfig[planId]
end

GuessPetConfig.instance = GuessPetConfig.New()

return GuessPetConfig
