-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpool/config/DragonpoolConfig.lua

module("logic.extensions.dragonpool.config.DragonpoolConfig", package.seeall)

local DragonpoolConfig = class("DragonpoolConfig", BaseConfig)

function DragonpoolConfig:onInit()
	return
end

function DragonpoolConfig:getNames()
	return {
		"dragon_pool_activity",
		"dragon_pool_growth",
		"dragon_pool_chat_text",
		"dragon_pool_egg",
		"dragon_pool_weed",
		"dragon_pool_progress_prize"
	}
end

function DragonpoolConfig:handleConfig(name, content)
	if name == "dragon_pool_activity" then
		self._dragon_pool_activity = content
	elseif name == "dragon_pool_growth" then
		self._dragon_pool_growth = content
	elseif name == "dragon_pool_chat_text" then
		self._dragon_pool_chat_text = content
	elseif name == "dragon_pool_egg" then
		self._dragon_pool_egg = content
	elseif name == "dragon_pool_weed" then
		self._dragon_pool_weed = content
	elseif name == "dragon_pool_progress_prize" then
		self._dragon_pool_progress_prize = content
	end
end

function DragonpoolConfig:getDailyTouchTimes(activityId)
	return self._dragon_pool_activity[activityId].dailyTouchTimes
end

function DragonpoolConfig:getDailyChatTimes(activityId)
	return self._dragon_pool_activity[activityId].dailyChatTimes
end

function DragonpoolConfig:getChatTxt(activityId, textId)
	return self._dragon_pool_chat_text[activityId][textId].content
end

function DragonpoolConfig:getWeedCfgs(activityId)
	return self._dragon_pool_weed[activityId]
end

function DragonpoolConfig:getActivityCfg(activityId)
	return self._dragon_pool_activity[activityId]
end

function DragonpoolConfig:getPrizeCfgs(activityId)
	return self._dragon_pool_progress_prize[activityId]
end

function DragonpoolConfig:getMaxGrowth(activityId, eggId)
	return self._dragon_pool_egg[activityId][eggId].maxGrowth
end

function DragonpoolConfig:getEggCfg(activityId, eggId)
	return self._dragon_pool_egg[activityId][eggId]
end

function DragonpoolConfig:getEggCfgs(activityId)
	return self._dragon_pool_egg[activityId]
end

DragonpoolConfig.instance = DragonpoolConfig.New()

return DragonpoolConfig
