-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/phantomspace/config/PhantomSpaceConfig.lua

module("logic.extensions.phantomspace.config.PhantomSpaceConfig", package.seeall)

local PhantomSpaceConfig = class("PhantomSpaceConfig", BaseConfig)

function PhantomSpaceConfig:getNames()
	return {
		"phantom_space_creeps",
		"phantom_space_activity",
		"phantom_space_monster",
		"phantom_space_rank_prize",
		"phantom_space_buff",
		"phantom_space_stage",
		"phantom_space_endless_buff",
		"phantom_space_endless_rank_prize",
		"phantom_space_common"
	}
end

function PhantomSpaceConfig:handleConfig(name, content)
	if name == "phantom_space_creeps" then
		self._phantom_space_creeps = content
	elseif name == "phantom_space_activity" then
		self._phantom_space_activity = content
	elseif name == "phantom_space_monster" then
		self._phantom_space_monster = content
	elseif name == "phantom_space_rank_prize" then
		self._phantom_space_rank_prize = content
	elseif name == "phantom_space_buff" then
		self._phantom_space_buff = content
	elseif name == "phantom_space_stage" then
		self._phantom_space_stage = content
	elseif name == "phantom_space_endless_buff" then
		self._phantom_space_endless_buff = content
	elseif name == "phantom_space_endless_rank_prize" then
		self._phantom_space_endless_rank_prize = content
	elseif name == "phantom_space_common" then
		self._phantom_space_common = content
	end
end

function PhantomSpaceConfig:getActivityCfgById(id)
	return self._phantom_space_activity[id]
end

function PhantomSpaceConfig:getStageListCfgs(activityId)
	return self._phantom_space_stage[activityId]
end

function PhantomSpaceConfig:getStageListCfgById(activityId, mode)
	if self._phantom_space_stage[activityId] then
		return self._phantom_space_stage[activityId][mode]
	end
end

function PhantomSpaceConfig:getStageCfgById(activityId, mode, stageId)
	if self._phantom_space_stage[activityId] and self._phantom_space_stage[activityId][mode] then
		return self._phantom_space_stage[activityId][mode][stageId]
	end
end

function PhantomSpaceConfig:getCreeps(id)
	return self._phantom_space_creeps[id]
end

function PhantomSpaceConfig:getMonsterCfgById(id)
	return self._phantom_space_monster[id]
end

function PhantomSpaceConfig:getBuffListCfgById(activityId)
	return self._phantom_space_buff[activityId]
end

function PhantomSpaceConfig:getBuffCfgById(activityId, lvl)
	if self._phantom_space_buff[activityId] then
		return self._phantom_space_buff[activityId][lvl]
	end
end

function PhantomSpaceConfig:getRankListCfgById(activityId)
	return self._phantom_space_rank_prize[activityId]
end

function PhantomSpaceConfig:getEndlessBuffCfgs(activityId)
	return self._phantom_space_endless_buff[activityId]
end

function PhantomSpaceConfig:getEndlessBuffCfgById(activityId, stageId)
	return self._phantom_space_endless_buff[activityId] and self._phantom_space_endless_buff[activityId][stageId]
end

function PhantomSpaceConfig:getEndlessRankPrizeCfgs(activityId)
	return self._phantom_space_endless_rank_prize[activityId]
end

function PhantomSpaceConfig:getOpenModeMap(activityId)
	local stageCfgs = self:getStageListCfgs(activityId)
	local modeMap = {}

	for mode, stageCfg in pairs(stageCfgs) do
		modeMap[mode] = mode + 1
	end

	return modeMap
end

function PhantomSpaceConfig:getEndlessCreepsMasterId(activityId)
	local endlessStageCfg = self:getStageCfgById(activityId, PhantomSpaceController.clg_mode.Endless, 1)

	return endlessStageCfg.creepsMasterId
end

function PhantomSpaceConfig:getCommonValue(key)
	return self._phantom_space_common[key] and self._phantom_space_common[key].value
end

PhantomSpaceConfig.instance = PhantomSpaceConfig.New()

return PhantomSpaceConfig
