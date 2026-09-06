-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threematchesgame/config/ThreeMatchesGameConfig.lua

module("logic.extensions.threematchesgame.config.ThreeMatchesGameConfig", package.seeall)

local ThreeMatchesGameConfig = class("ThreeMatchesGameConfig", BaseConfig)

function ThreeMatchesGameConfig:onInit()
	ThreeMatchesGameConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function ThreeMatchesGameConfig:getNames()
	return {
		"three_matches_activity",
		"three_matches_stage",
		"three_matches_blocks",
		"three_matches_block_layout",
		"three_matches_combo"
	}
end

function ThreeMatchesGameConfig:handleConfig(name, content)
	if name == "three_matches_activity" then
		self._three_matches_activity = content
	elseif name == "three_matches_stage" then
		self._three_matches_stage = content
	elseif name == "three_matches_blocks" then
		self._three_matches_blocks = content
	elseif name == "three_matches_block_layout" then
		self._three_matches_block_layout = content
	elseif name == "three_matches_combo" then
		self._three_matches_combo = content
	end
end

function ThreeMatchesGameConfig:getActivityCfgById(activityId)
	return self._three_matches_activity[activityId]
end

function ThreeMatchesGameConfig:getStageCfg(activityId, stageId)
	if self._three_matches_stage[activityId] then
		return self._three_matches_stage[activityId][stageId]
	else
		return nil
	end
end

function ThreeMatchesGameConfig:getBlockInfo(blockId)
	return self._three_matches_blocks[blockId]
end

function ThreeMatchesGameConfig:getLayoutInfo(layoutId)
	return self._three_matches_block_layout[layoutId]
end

function ThreeMatchesGameConfig:getComboCfg()
	return self._three_matches_combo
end

ThreeMatchesGameConfig.instance = ThreeMatchesGameConfig.New()

return ThreeMatchesGameConfig
