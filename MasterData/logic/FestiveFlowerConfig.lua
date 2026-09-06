-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/festiveflower/config/FestiveFlowerConfig.lua

module("logic.extensions.festiveflower.config.FestiveFlowerConfig", package.seeall)

local FestiveFlowerConfig = class("FestiveFlowerConfig", BaseConfig)

function FestiveFlowerConfig:onInit()
	FestiveFlowerConfig.super.onInit(self)

	self._festive_flower_activity = nil
	self._festive_flower_item = nil
	self._festive_flower_progress = nil
	self._festive_flower_rank = nil
	self._festive_flower_word = nil
end

function FestiveFlowerConfig:getNames()
	return {
		"festive_flower_activity",
		"festive_flower_item",
		"festive_flower_progress",
		"festive_flower_rank",
		"festive_flower_word",
		"festive_flower_common"
	}
end

function FestiveFlowerConfig:handleConfig(name, content)
	if name == "festive_flower_activity" then
		self._festive_flower_activity = content
	elseif name == "festive_flower_item" then
		self._festive_flower_item = content
	elseif name == "festive_flower_progress" then
		self._festive_flower_progress = content
	elseif name == "festive_flower_rank" then
		self._festive_flower_rank = content
	elseif name == "festive_flower_word" then
		self._festive_flower_word = content
	elseif name == "festive_flower_common" then
		self._festive_flower_common = content
	end
end

function FestiveFlowerConfig:getCommonConfig(key, isToNumber)
	if self._festive_flower_common[key] then
		if isToNumber then
			return checknumber(self._festive_flower_common[key].value)
		else
			return self._festive_flower_common[key].value
		end
	end

	return ""
end

function FestiveFlowerConfig:getPrizeConfigs(activityId)
	return self._festive_flower_progress[activityId]
end

function FestiveFlowerConfig:getRankPrizeConfigs(activityId)
	return self._festive_flower_rank[activityId]
end

function FestiveFlowerConfig:getFlowerItemConfigs(activityId)
	return self._festive_flower_item[activityId]
end

function FestiveFlowerConfig:randomWord(activityId, planId)
	local configs = self._festive_flower_word[activityId]

	if configs then
		configs = configs[planId]

		if configs then
			local index = math.random(#configs)

			if configs[index] then
				return configs[index].content
			else
				return configs[1].content
			end
		end
	end
end

function FestiveFlowerConfig:getFestiveFlowerActConf(activityId)
	return self._festive_flower_activity[activityId]
end

FestiveFlowerConfig.instance = FestiveFlowerConfig.New()

return FestiveFlowerConfig
