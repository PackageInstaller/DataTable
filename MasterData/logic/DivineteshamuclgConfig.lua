-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineteshamuclg/config/DivineteshamuclgConfig.lua

module("logic.extensions.divineteshamuclg.config.DivineteshamuclgConfig", package.seeall)

local DivineteshamuclgConfig = class("DivineteshamuclgConfig", BaseConfig)

function DivineteshamuclgConfig:onInit()
	return
end

function DivineteshamuclgConfig:getNames()
	return {
		"divine_teshamu_master",
		"divine_teshamu_prize",
		"divine_teshamu_stage",
		"divine_teshamu_support_pet",
		"divine_teshamu_activity",
		"divine_teshamu_buff",
		"divine_teshamu_creeps",
		"divine_teshamu_stage_pos"
	}
end

function DivineteshamuclgConfig:handleConfig(name, content)
	if name == "divine_teshamu_master" then
		self._divine_teshamu_master = content
	elseif name == "divine_teshamu_prize" then
		self._divine_teshamu_prize = content
	elseif name == "divine_teshamu_stage" then
		self._divine_teshamu_stage = content
	elseif name == "divine_teshamu_support_pet" then
		self._divine_teshamu_support_pet = content
	elseif name == "divine_teshamu_activity" then
		self._divine_teshamu_activity = content
	elseif name == "divine_teshamu_buff" then
		self._divine_teshamu_buff = content
	elseif name == "divine_teshamu_creeps" then
		self._divine_teshamu_creeps = content
	elseif name == "divine_teshamu_stage_pos" then
		self._divine_teshamu_stage_pos = content
	end
end

function DivineteshamuclgConfig:getActCfg(activityId)
	return self._divine_teshamu_activity[activityId]
end

function DivineteshamuclgConfig:getSkinId(activityId)
	return self._divine_teshamu_activity[activityId].skinId
end

function DivineteshamuclgConfig:getStageCfgs(activityId)
	return self._divine_teshamu_stage[activityId]
end

function DivineteshamuclgConfig:getStageCfgsByFloorId(activityId, floorId)
	return self._divine_teshamu_stage[activityId][floorId]
end

function DivineteshamuclgConfig:getStageCfg(activityId, floorId, stageId)
	return self._divine_teshamu_stage[activityId][floorId][stageId]
end

function DivineteshamuclgConfig:getPrizeCfgs(activityId)
	return self._divine_teshamu_prize[activityId]
end

function DivineteshamuclgConfig:getPrizeCfg(activityId, floorId)
	return self._divine_teshamu_prize[activityId][floorId]
end

function DivineteshamuclgConfig:getBuffCfgs(activityId)
	return self._divine_teshamu_buff[activityId]
end

function DivineteshamuclgConfig:getBuffCfg(activityId, buffId)
	return self._divine_teshamu_buff[activityId][buffId]
end

function DivineteshamuclgConfig:getBuffCfgByValue(activityId, value)
	local buffCfgs = self:getBuffCfgs(activityId)
	local lastCfg = buffCfgs[#buffCfgs]

	if value >= lastCfg.difference then
		return lastCfg
	end

	for i = 1, #buffCfgs - 1 do
		if value >= buffCfgs[i].difference and value < buffCfgs[i + 1].difference then
			return buffCfgs[i]
		end
	end
end

function DivineteshamuclgConfig:getCreepsCfgs(creepsMasterId)
	return self._divine_teshamu_creeps[creepsMasterId]
end

function DivineteshamuclgConfig:getCreepsMasterCfg(creepsMasterId)
	return self._divine_teshamu_master[creepsMasterId]
end

function DivineteshamuclgConfig:getSupportPetCfgs(activityId)
	return self._divine_teshamu_support_pet[activityId]
end

function DivineteshamuclgConfig:getSupportPetCfg(activityId, creepsId)
	return self._divine_teshamu_support_pet[activityId][creepsId]
end

function DivineteshamuclgConfig:getStageCellPosCfgs(activityId, floorId)
	return self._divine_teshamu_stage_pos[activityId][floorId]
end

function DivineteshamuclgConfig:getStageCellPosCfg(activityId, floorId, cellId)
	return self._divine_teshamu_stage_pos[activityId][floorId][cellId]
end

DivineteshamuclgConfig.instance = DivineteshamuclgConfig.New()

return DivineteshamuclgConfig
