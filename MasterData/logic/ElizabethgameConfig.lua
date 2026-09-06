-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elizabethgame/config/ElizabethgameConfig.lua

module("logic.extensions.elizabethgame.config.ElizabethgameConfig", package.seeall)

local ElizabethgameConfig = class("ElizabethgameConfig", BaseConfig)

function ElizabethgameConfig:onInit()
	return
end

function ElizabethgameConfig:getNames()
	return {
		"elizabeth_game_activity",
		"elizabeth_game_buy_times",
		"elizabeth_game_scale_prize",
		"elizabeth_game_prize"
	}
end

function ElizabethgameConfig:handleConfig(name, content)
	if name == "elizabeth_game_activity" then
		self._elizabeth_game_activity = content
	elseif name == "elizabeth_game_buy_times" then
		self._elizabeth_game_buy_times = content
	elseif name == "elizabeth_game_scale_prize" then
		self._elizabeth_game_scale_prize = content
	elseif name == "elizabeth_game_prize" then
		self._elizabeth_game_prize = content
	end
end

function ElizabethgameConfig:getActCfg(activityId)
	return self._elizabeth_game_activity[activityId]
end

function ElizabethgameConfig:getScalePrizeCfgs(planId)
	local list = table.values(self._elizabeth_game_scale_prize[planId])

	table.sort(list, function(a, b)
		return a.scale < b.scale
	end)

	return list
end

function ElizabethgameConfig:getBuyTimesCfgs(planId)
	return self._elizabeth_game_buy_times[planId]
end

function ElizabethgameConfig:getBuyTimesCfg(planId, times)
	return self._elizabeth_game_buy_times[planId][times]
end

function ElizabethgameConfig:getGamePrizeCfgs(planId)
	return self._elizabeth_game_prize[planId]
end

function ElizabethgameConfig:getGamePrizeCfg(planId, prizeId)
	return self._elizabeth_game_prize[planId][prizeId]
end

function ElizabethgameConfig:getGamePrizeScores(planId)
	local list = {}

	for i, v in ipairs(self._elizabeth_game_prize[planId]) do
		table.insert(list, v.flowerNum)
	end

	return list
end

ElizabethgameConfig.instance = ElizabethgameConfig.New()

return ElizabethgameConfig
