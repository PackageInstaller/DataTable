-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neweranuoya/config/NeweranuoyaConfig.lua

module("logic.extensions.neweranuoya.config.NeweranuoyaConfig", package.seeall)

local NeweranuoyaConfig = class("NeweranuoyaConfig", BaseConfig)

function NeweranuoyaConfig:onInit()
	return
end

function NeweranuoyaConfig:getNames()
	return {
		"new_era_nuo_ya_ext_stage",
		"new_era_nuo_ya_creeps",
		"new_era_nuo_ya_buff",
		"new_era_nuo_ya_master",
		"new_era_nuo_ya_job",
		"new_era_nuo_ya_activity",
		"new_era_nuo_ya_common_stage"
	}
end

function NeweranuoyaConfig:handleConfig(name, content)
	if name == "new_era_nuo_ya_ext_stage" then
		self._new_era_nuo_ya_ext_stage = content
	elseif name == "new_era_nuo_ya_creeps" then
		self._new_era_nuo_ya_creeps = content
	elseif name == "new_era_nuo_ya_buff" then
		self._new_era_nuo_ya_buff = content
	elseif name == "new_era_nuo_ya_master" then
		self._new_era_nuo_ya_master = content
	elseif name == "new_era_nuo_ya_job" then
		self._new_era_nuo_ya_job = content
	elseif name == "new_era_nuo_ya_activity" then
		self._new_era_nuo_ya_activity = content
	elseif name == "new_era_nuo_ya_common_stage" then
		self._new_era_nuo_ya_common_stage = content
	end
end

function NeweranuoyaConfig:getActCfg(activityId)
	return self._new_era_nuo_ya_activity[activityId]
end

function NeweranuoyaConfig:getSkinId(activityId)
	return self._new_era_nuo_ya_activity[activityId].skinId
end

function NeweranuoyaConfig:getExtStageCfgs(activityId, floorId)
	return self._new_era_nuo_ya_ext_stage[activityId][floorId]
end

function NeweranuoyaConfig:getExtStageShowCfgs(activityId, floorId)
	if floorId % 2 == 0 then
		local list = {}

		for i, v in ipairs(self._new_era_nuo_ya_ext_stage[activityId][floorId]) do
			table.insert(list, 1, v)
		end

		return list
	end

	return self._new_era_nuo_ya_ext_stage[activityId][floorId]
end

function NeweranuoyaConfig:getExtStageCfg(activityId, floorId, stageId)
	return self._new_era_nuo_ya_ext_stage[activityId][floorId][stageId]
end

function NeweranuoyaConfig:getNormalTotalStageCfgs(activityId)
	return self._new_era_nuo_ya_common_stage[activityId]
end

function NeweranuoyaConfig:getNormalStageCfgs(activityId, floorId)
	local list = {}

	for i, v in ipairs(self._new_era_nuo_ya_common_stage[activityId]) do
		if v.floorId == floorId then
			table.insert(list, v)
		end
	end

	return list
end

function NeweranuoyaConfig:getNormalStageShowCfgs(activityId, floorId)
	local list = {}

	for i, v in ipairs(self._new_era_nuo_ya_common_stage[activityId]) do
		if v.floorId == floorId then
			table.insert(list, v)
		end
	end

	if floorId % 2 == 0 then
		local listRevert = {}

		for i = #list, 1, -1 do
			table.insert(listRevert, list[i])
		end

		return listRevert
	else
		return list
	end
end

function NeweranuoyaConfig:getNormalStageCfg(activityId, stageId)
	return self._new_era_nuo_ya_common_stage[activityId][stageId]
end

function NeweranuoyaConfig:getCreepsCfgs(creepsMasterId)
	return self._new_era_nuo_ya_creeps[creepsMasterId]
end

function NeweranuoyaConfig:getCreepsMasterCfg(creepsMasterId)
	return self._new_era_nuo_ya_master[creepsMasterId]
end

function NeweranuoyaConfig:getJobCfg(activityId, jobId, num)
	return self._new_era_nuo_ya_job[activityId][jobId][num]
end

function NeweranuoyaConfig:getFloorPrizeCfgs(activityId, floorId, clgType, reverse)
	local prizes = {}

	if clgType == NeweranuoyaController.ClgType.Extreme then
		for i, v in ipairs(self._new_era_nuo_ya_ext_stage[activityId][floorId]) do
			if reverse then
				table.insert(prizes, 1, v)
			else
				table.insert(prizes, v)
			end
		end
	else
		for i, v in ipairs(self._new_era_nuo_ya_common_stage[activityId]) do
			if v.floorId == floorId then
				if reverse then
					table.insert(prizes, 1, v)
				else
					table.insert(prizes, v)
				end
			end
		end
	end

	return prizes
end

NeweranuoyaConfig.instance = NeweranuoyaConfig.New()

return NeweranuoyaConfig
