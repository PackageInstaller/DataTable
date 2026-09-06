-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/judgmentdragonclg/config/JudgmentDragonClgConfig.lua

module("logic.extensions.judgmentdragonclg.config.JudgmentDragonClgConfig", package.seeall)

local JudgmentDragonClgConfig = class("JudgmentDragonClgConfig", BaseConfig)

function JudgmentDragonClgConfig:onInit()
	JudgmentDragonClgConfig.super.onInit(self)
end

function JudgmentDragonClgConfig:getNames()
	return {
		"judgment_dragon_clg_activity",
		"judgment_dragon_clg_phase",
		"judgment_dragon_clg_stage",
		"judgment_dragon_clg_monster",
		"judgment_dragon_clg_creeps",
		"judgment_dragon_clg_terrain",
		"judgment_dragon_clg_position"
	}
end

function JudgmentDragonClgConfig:handleConfig(name, content)
	if name == "judgment_dragon_clg_activity" then
		self._judgment_dragon_clg_activity = content
	elseif name == "judgment_dragon_clg_phase" then
		self._judgment_dragon_clg_phase = content
	elseif name == "judgment_dragon_clg_stage" then
		self._judgment_dragon_clg_stage = content
	elseif name == "judgment_dragon_clg_monster" then
		self._judgment_dragon_clg_monster = content
	elseif name == "judgment_dragon_clg_creeps" then
		self._judgment_dragon_clg_creeps = content
	elseif name == "judgment_dragon_clg_terrain" then
		self._judgment_dragon_clg_terrain = content
	elseif name == "judgment_dragon_clg_position" then
		self._judgment_dragon_clg_position = content
	end
end

function JudgmentDragonClgConfig:getActData(activityId)
	return self._judgment_dragon_clg_activity[activityId]
end

function JudgmentDragonClgConfig:getPhaseCfg(activityId)
	return self._judgment_dragon_clg_phase[activityId]
end

function JudgmentDragonClgConfig:getPhaseData(activityId, phaseId)
	if self._judgment_dragon_clg_phase[activityId] then
		return self._judgment_dragon_clg_phase[activityId][phaseId]
	end
end

function JudgmentDragonClgConfig:getStageCfg(activityId, phaseId)
	local data = self:getPhaseData(activityId, phaseId)

	if data then
		if not data.stagePlanId then
			local stagePlanId = 0

			return self._judgment_dragon_clg_stage[stagePlanId]
		end
	end
end

function JudgmentDragonClgConfig:getStageData(activityId, phaseId, stageId)
	local cfg = self:getStageCfg(activityId, phaseId)

	return cfg and cfg[stageId]
end

function JudgmentDragonClgConfig:getMonsterData(creepsMasterId)
	return self._judgment_dragon_clg_monster[creepsMasterId]
end

function JudgmentDragonClgConfig:getCreepsCfg(creepsMasterId)
	return self._judgment_dragon_clg_creeps[creepsMasterId]
end

function JudgmentDragonClgConfig:getTerrainCfg(activityId, phaseId)
	local data = self:getPhaseData(activityId, phaseId)

	if data then
		if not data.terrainPlanId then
			local terrainPlanId = 0

			return self._judgment_dragon_clg_terrain[terrainPlanId]
		end
	end
end

function JudgmentDragonClgConfig:getTerrainData(activityId, phaseId, terrainId)
	local cfg = self:getTerrainCfg(activityId, phaseId)

	return cfg and cfg[terrainId]
end

function JudgmentDragonClgConfig:getPositionCfg(positionPlanId)
	return self._judgment_dragon_clg_position[positionPlanId]
end

function JudgmentDragonClgConfig:getPositionData(positionPlanId, posId)
	if self._judgment_dragon_clg_position[positionPlanId] then
		return self._judgment_dragon_clg_position[positionPlanId][posId]
	end
end

JudgmentDragonClgConfig.instance = JudgmentDragonClgConfig.New()

return JudgmentDragonClgConfig
