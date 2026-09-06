-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/config/ExploreUnderConfig.lua

module("logic.extensions.exploreunder.config.ExploreUnderConfig", package.seeall)

local ExploreUnderConfig = class("ExploreUnderConfig", BaseConfig)

function ExploreUnderConfig:onInit()
	ExploreUnderConfig.super.onInit(self)
end

function ExploreUnderConfig:getNames()
	return {
		"explore_under_activity",
		"explore_under_creep_master",
		"explore_under_creeps",
		"explore_under_fight_event",
		"explore_under_dialogue_event",
		"explore_under_game",
		"explore_under_level_plan",
		"explore_under_map",
		"explore_under_move_event",
		"explore_under_prize_event",
		"explore_under_shop_event",
		"explore_under_shop_item"
	}
end

function ExploreUnderConfig:handleConfig(name, content)
	if name == "explore_under_activity" then
		self._actCfgs = content
	elseif name == "explore_under_creep_master" then
		self._creepsCfgs = content
	elseif name == "explore_under_creeps" then
		self._creepsMasterCfgs = content
	elseif name == "explore_under_fight_event" then
		self._fightEventCfgs = content
	elseif name == "explore_under_dialogue_event" then
		self._explore_under_dialogue_event = content
	elseif name == "explore_under_game" then
		self._gameEventCfgs = content
	elseif name == "explore_under_level_plan" then
		self._levelCfgs = content
	elseif name == "explore_under_map" then
		self._mapCfgs = content
	elseif name == "explore_under_move_event" then
		self._moveEventCfgs = content
	elseif name == "explore_under_prize_event" then
		self._prizeEventCfgs = content
	elseif name == "explore_under_shop_event" then
		self._shopEventCfgs = content
	elseif name == "explore_under_shop_item" then
		self._shopItemCfgs = content
	end
end

function ExploreUnderConfig:getActfg(actId)
	return self._actCfgs[actId]
end

function ExploreUnderConfig:getCreepsCfg(creepId)
	return self._creepsCfgs[creepId]
end

function ExploreUnderConfig:getCreepsMasterCfgs(creepId)
	return self._creepsMasterCfgs[creepId]
end

function ExploreUnderConfig:getDialogueCfgs(dialoguePlanId)
	return self._explore_under_dialogue_event[dialoguePlanId]
end

function ExploreUnderConfig:getDialogueCfg(dialoguePlanId, dialogueId)
	if self._explore_under_dialogue_event[dialoguePlanId] then
		return self._explore_under_dialogue_event[dialoguePlanId][dialogueId]
	end
end

function ExploreUnderConfig:getDialogueData(dialoguePlanId, dialogueId, chatId)
	if self._explore_under_dialogue_event[dialoguePlanId] and self._explore_under_dialogue_event[dialoguePlanId][dialogueId] then
		return self._explore_under_dialogue_event[dialoguePlanId][dialogueId][chatId]
	end
end

function ExploreUnderConfig:getFightEventCfgs(planId)
	return self._fightEventCfgs[planId]
end

function ExploreUnderConfig:getGameEventCfg(planId, subId)
	return self._gameEventCfgs[planId] and self._gameEventCfgs[planId][subId]
end

function ExploreUnderConfig:getLevelCfgs(planId)
	return self._levelCfgs[planId]
end

function ExploreUnderConfig:getLevelCfg(planId, level)
	return self._levelCfgs[planId] and self._levelCfgs[planId][level]
end

function ExploreUnderConfig:getMapCfgs(mapId)
	return self._mapCfgs[mapId]
end

function ExploreUnderConfig:getMoveEventCfg(planId, subId)
	return self._moveEventCfgs[planId] and self._moveEventCfgs[planId][subId]
end

function ExploreUnderConfig:getPrizeEventCfg(planId, subId)
	return self._prizeEventCfgs[planId] and self._prizeEventCfgs[planId][subId]
end

function ExploreUnderConfig:getItemCfgs(planId)
	return self._shopItemCfgs[planId]
end

ExploreUnderConfig.instance = ExploreUnderConfig.New()

return ExploreUnderConfig
