-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/parallelkingdragon/config/ParallelkingdragonConfig.lua

module("logic.extensions.parallelkingdragon.config.ParallelkingdragonConfig", package.seeall)

local ParallelkingdragonConfig = class("ParallelkingdragonConfig", BaseConfig)

function ParallelkingdragonConfig:onInit()
	return
end

function ParallelkingdragonConfig:getNames()
	return {
		"parallel_king_dragon_stage",
		"parallel_king_dragon_treasure",
		"parallel_king_dragon_master",
		"parallel_king_dragon_activity",
		"parallel_king_dragon_creeps"
	}
end

function ParallelkingdragonConfig:handleConfig(name, content)
	if name == "parallel_king_dragon_stage" then
		self._parallel_king_dragon_stage = content
	elseif name == "parallel_king_dragon_treasure" then
		self._parallel_king_dragon_treasure = content
	elseif name == "parallel_king_dragon_master" then
		self._parallel_king_dragon_master = content
	elseif name == "parallel_king_dragon_activity" then
		self._parallel_king_dragon_activity = content
	elseif name == "parallel_king_dragon_creeps" then
		self._parallel_king_dragon_creeps = content
	end
end

function ParallelkingdragonConfig:getActCfg(activityId)
	return self._parallel_king_dragon_activity[activityId]
end

function ParallelkingdragonConfig:getSkinId(activityId)
	return self._parallel_king_dragon_activity[activityId].skinId
end

function ParallelkingdragonConfig:getStageCfgs(activityId)
	return self._parallel_king_dragon_stage[activityId]
end

function ParallelkingdragonConfig:getStageCfg(activityId, stageId)
	return self._parallel_king_dragon_stage[activityId][stageId]
end

function ParallelkingdragonConfig:getPrizeCfgs(activityId)
	local list = {}

	for i, v in ipairs(self._parallel_king_dragon_stage[activityId]) do
		if not string.nilorempty(v.prize) then
			table.insert(list, v)
		end
	end

	return list
end

function ParallelkingdragonConfig:getCreepsCfgs(creepsMasterId)
	return self._parallel_king_dragon_creeps[creepsMasterId]
end

function ParallelkingdragonConfig:getCreepsMasterCfg(creepsMasterId)
	return self._parallel_king_dragon_master[creepsMasterId]
end

function ParallelkingdragonConfig:getTreasureCfg(activityId, treasureId)
	return self._parallel_king_dragon_treasure[activityId][treasureId]
end

function ParallelkingdragonConfig:getFirstPosCreepsCfg(activityId, stageId)
	local stageCfg = self:getStageCfg(activityId, stageId)
	local cfgs = self:getCreepsCfgs(stageCfg.creepsMasterId)
	local pos = 99
	local cfg

	for i, v in ipairs(cfgs) do
		if pos > v.posId then
			pos = v.posId
			cfg = v
		end
	end

	return cfg
end

ParallelkingdragonConfig.instance = ParallelkingdragonConfig.New()

return ParallelkingdragonConfig
