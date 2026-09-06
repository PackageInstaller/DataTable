-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recastglory/config/RecastGloryConfig.lua

module("logic.extensions.recastglory.config.RecastGloryConfig", package.seeall)

local RecastGloryConfig = class("RecastGloryConfig", BaseConfig)

function RecastGloryConfig:onInit()
	RecastGloryConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function RecastGloryConfig:getNames()
	return {
		"restore_glory",
		"restore_glory_pet",
		"restore_glory_progress",
		"restore_glory_tag",
		"restore_glory_game_shield",
		"restore_glory_game_shield_dirty",
		"restore_glory_game_sword",
		"restore_glory_rule"
	}
end

function RecastGloryConfig:handleConfig(name, content)
	if name == "restore_glory" then
		self._restore_glory = content
	elseif name == "restore_glory_pet" then
		self._restore_glory_pet = content
	elseif name == "restore_glory_progress" then
		self._restore_glory_progress = content
	elseif name == "restore_glory_tag" then
		self._restore_glory_tag = content
	elseif name == "restore_glory_game_shield" then
		self._restore_glory_game_shield = content
	elseif name == "restore_glory_game_shield_dirty" then
		self._restore_glory_game_shield_dirty = content
	elseif name == "restore_glory_game_sword" then
		self._restore_glory_game_sword = content
	elseif name == "restore_glory_rule" then
		self._restore_glory_rule = content
	end
end

function RecastGloryConfig:getGloryCfgById(activityId)
	return self._restore_glory[activityId]
end

function RecastGloryConfig:getGloryPetCfg(planId)
	return self._restore_glory_pet[planId]
end

function RecastGloryConfig:getGloryProgressCfg(planId)
	return self._restore_glory_progress[planId]
end

function RecastGloryConfig:getGloryTagCfg(labelPlanId)
	return self._restore_glory_tag[labelPlanId]
end

function RecastGloryConfig:getGloryGameShieldCfg(gameId)
	return self._restore_glory_game_shield[gameId]
end

function RecastGloryConfig:getGloryGameShieldDirtyDataList(gameId)
	local data = self:getGloryGameShieldCfg(gameId)

	return self._restore_glory_game_shield_dirty[data.dirtyPlanId]
end

function RecastGloryConfig:getGloryGameShieldDirtyData(gameId, dirtyId)
	local dataList = self:getGloryGameShieldDataList(gameId)

	return dataList[dirtyId]
end

function RecastGloryConfig:getGloryGameSwordCfg(gameId)
	return self._restore_glory_game_sword[gameId]
end

function RecastGloryConfig:getGloryRuleCfg(ruleId)
	return self._restore_glory_rule[ruleId]
end

RecastGloryConfig.instance = RecastGloryConfig.New()

return RecastGloryConfig
