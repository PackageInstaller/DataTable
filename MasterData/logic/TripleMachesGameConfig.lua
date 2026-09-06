-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/config/TripleMachesGameConfig.lua

module("logic.extensions.triplemacthesgame.config.TripleMachesGameConfig", package.seeall)

local TripleMachesGameConfig = class("TripleMachesGameConfig", BaseConfig)

function TripleMachesGameConfig:onInit()
	TripleMachesGameConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function TripleMachesGameConfig:getNames()
	return {
		"three_matches_game",
		"three_matches_game_stage",
		"three_matches_game_blocks",
		"three_matches_game_blocks_replace",
		"three_matches_game_block_layout",
		"three_matches_game_combo",
		"three_matches_game_item_supply",
		"three_matches_game_target",
		"three_matches_game_prize",
		"three_matches_game_progress_prize"
	}
end

function TripleMachesGameConfig:handleConfig(name, content)
	if name == "three_matches_game" then
		self._three_matches_game = content
	elseif name == "three_matches_game_stage" then
		self._three_matches_game_stage = content
	elseif name == "three_matches_game_blocks" then
		self._three_matches_game_blocks = content
	elseif name == "three_matches_game_block_layout" then
		self._three_matches_game_block_layout = content
	elseif name == "three_matches_game_combo" then
		self._three_matches_game_combo = content
	elseif name == "three_matches_game_blocks_replace" then
		self._three_matches_game_blocks_replace = content
	elseif name == "three_matches_game_item_supply" then
		self._three_matches_game_item_supply = content
	elseif name == "three_matches_game_target" then
		self._three_matches_game_target = content
	elseif name == "three_matches_game_prize" then
		self._three_matches_game_prize = content
	elseif name == "three_matches_game_progress_prize" then
		self._three_matches_game_progress_prize = content
	end
end

function TripleMachesGameConfig:getActivityCfgById(activityId)
	return self._three_matches_game[activityId]
end

function TripleMachesGameConfig:getStageCfg(activityId, stageId)
	if self._three_matches_game_stage[activityId] then
		return self._three_matches_game_stage[activityId][stageId]
	else
		return nil
	end
end

function TripleMachesGameConfig:getBlockInfo(blockId)
	return self._three_matches_game_blocks[blockId]
end

function TripleMachesGameConfig:getLayoutInfo(layoutId)
	return self._three_matches_game_block_layout[layoutId]
end

function TripleMachesGameConfig:getComboCfg()
	return self._three_matches_game_combo
end

function TripleMachesGameConfig:getBlockIconReplace(blockIconPlanId)
	return self._three_matches_game_blocks_replace[blockIconPlanId]
end

function TripleMachesGameConfig:getItemSupplyCfg(itemPlanId)
	return self._three_matches_game_item_supply[itemPlanId]
end

function TripleMachesGameConfig:getTargetCfg(targetPlanId)
	return self._three_matches_game_target[targetPlanId]
end

function TripleMachesGameConfig:getPrizeCfgs(activityId)
	return self._three_matches_game_prize[activityId]
end

function TripleMachesGameConfig:getPrizeCfgByScore(activityId, score)
	local cfg = self._three_matches_game_prize[activityId][1]
	local lowLimit = 0

	for i, v in ipairs(self._three_matches_game_prize[activityId]) do
		if lowLimit <= score and score < v.scoreLimit then
			cfg = v
			lowLimit = v.scoreLimit

			break
		else
			lowLimit = v.scoreLimit
		end
	end

	if lowLimit <= score then
		cfg = self._three_matches_game_prize[activityId][#self._three_matches_game_prize[activityId]]
	end

	return cfg
end

function TripleMachesGameConfig:getPrizeCfg(activityId, prizeId)
	return self._three_matches_game_prize[activityId][prizeId]
end

function TripleMachesGameConfig:getProgressPrizeCfgs(activityId)
	return self._three_matches_game_progress_prize[activityId]
end

function TripleMachesGameConfig:getProgressPrizeCfg(activityId, prizeId)
	return self._three_matches_game_progress_prize[activityId][prizeId]
end

TripleMachesGameConfig.instance = TripleMachesGameConfig.New()

return TripleMachesGameConfig
