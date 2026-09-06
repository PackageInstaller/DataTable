-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/disorderpower/config/DisOrderPowerConfig.lua

module("logic.extensions.disorderpower.config.DisOrderPowerConfig", package.seeall)

local DisOrderPowerConfig = class("DisOrderPowerConfig", BaseConfig)

function DisOrderPowerConfig:getNames()
	return {
		"disorder_power_activity",
		"disorder_power_card",
		"disorder_power_progress_prize",
		"disorder_power_monster",
		"disorder_power_creeps",
		"disorder_power_support"
	}
end

function DisOrderPowerConfig:handleConfig(name, content)
	if name == "disorder_power_activity" then
		self.disorder_power_activity = content
	elseif name == "disorder_power_card" then
		self.disorder_power_card = content
	elseif name == "disorder_power_progress_prize" then
		self.disorder_power_progress_prize = content
	elseif name == "disorder_power_monster" then
		self.disorder_power_monster = content
	elseif name == "disorder_power_creeps" then
		self.disorder_power_creeps = content
	elseif name == "disorder_power_support" then
		self.disorder_power_support = content
	end
end

function DisOrderPowerConfig:getActivityCfgById(activityId)
	return self.disorder_power_activity[activityId]
end

function DisOrderPowerConfig:getCardCfg(activityId)
	return self.disorder_power_card[activityId]
end

function DisOrderPowerConfig:getProgressCfg(activityId)
	return self.disorder_power_progress_prize[activityId]
end

function DisOrderPowerConfig:getMonsterData(masterId)
	return self.disorder_power_monster[masterId]
end

function DisOrderPowerConfig:getCreepsData(masterId)
	return self.disorder_power_creeps[masterId]
end

function DisOrderPowerConfig:getSupportData(activityId)
	return self.disorder_power_support[activityId]
end

function DisOrderPowerConfig:GetCreepsId(activityId, cardId)
	if self.disorder_power_card[activityId] and self.disorder_power_card[activityId][cardId] then
		return self.disorder_power_card[activityId][cardId].creepsMasterId
	end
end

function DisOrderPowerConfig:GetCardRewardName(activityId, cardId)
	if self.disorder_power_card[activityId] and self.disorder_power_card[activityId][cardId] then
		return self.disorder_power_card[activityId][cardId].rewardPath
	end
end

function DisOrderPowerConfig:GetItemStr(activityId, cardId)
	if self.disorder_power_card[activityId] and self.disorder_power_card[activityId][cardId] then
		return self.disorder_power_card[activityId][cardId].item
	end
end

DisOrderPowerConfig.instance = DisOrderPowerConfig.New()

return DisOrderPowerConfig
