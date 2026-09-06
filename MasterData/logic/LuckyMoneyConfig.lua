-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckymoney/config/LuckyMoneyConfig.lua

module("logic.extensions.luckymoney.config.LuckyMoneyConfig", package.seeall)

local LuckyMoneyConfig = class("LuckyMoneyConfig", BaseConfig)

function LuckyMoneyConfig:onInit()
	LuckyMoneyConfig.super.onInit(self)
end

function LuckyMoneyConfig:getNames()
	return {
		"lucky_money_activity",
		"lucky_money_progress",
		"lucky_money_pet",
		"lucky_money_word"
	}
end

function LuckyMoneyConfig:handleConfig(name, content)
	if name == "lucky_money_activity" then
		self._lucky_money_activity = content
	elseif name == "lucky_money_progress" then
		self._lucky_money_progress = content
	elseif name == "lucky_money_pet" then
		self._lucky_money_pet = content
	elseif name == "lucky_money_word" then
		self._lucky_money_word = content
	end
end

function LuckyMoneyConfig:getLuckyMoneyActData(activityId)
	return self._lucky_money_activity[activityId]
end

function LuckyMoneyConfig:getLuckyMoneProgressData(activityId)
	return self._lucky_money_progress[activityId]
end

function LuckyMoneyConfig:getLuckyMoneyPetData(activityId)
	return self._lucky_money_pet[activityId]
end

function LuckyMoneyConfig:getLuckyMoneyWordData(activityId)
	return self._lucky_money_word[activityId]
end

function LuckyMoneyConfig:getChoosePetIdx(activityId, petId)
	local petCfg = self._lucky_money_pet[activityId]

	for idx, cfg in ipairs(petCfg) do
		if cfg.skinId == petId then
			return idx
		end
	end
end

function LuckyMoneyConfig:getMaxRewardScore(activityId)
	local progressCfg = self._lucky_money_progress[activityId]

	if progressCfg then
		return progressCfg[#progressCfg].progress
	end
end

LuckyMoneyConfig.instance = LuckyMoneyConfig.New()

return LuckyMoneyConfig
