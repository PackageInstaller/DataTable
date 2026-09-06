-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetuntian/config/DivineTunTianConfig.lua

module("logic.extensions.divinetuntian.config.DivineTunTianConfig", package.seeall)

local DivineTunTianConfig = class("DivineTunTianConfig", BaseConfig)

function DivineTunTianConfig:getNames()
	return {
		"divine_tun_tian_clg_activity",
		"divine_tun_tian_clg_extreme_stage",
		"divine_tun_tian_clg_normal_stage",
		"divine_tun_tian_clg_normal_support_pet",
		"divine_tun_tian_clg_normal_progress_prize",
		"divine_tun_tian_clg_buff",
		"divine_tun_tian_clg_master",
		"divine_tun_tian_clg_creeps"
	}
end

function DivineTunTianConfig:handleConfig(name, content)
	if name == "divine_tun_tian_clg_activity" then
		self._divine_tun_tian_clg_activity = content
	elseif name == "divine_tun_tian_clg_extreme_stage" then
		self._divine_tun_tian_clg_extreme_stage = content
	elseif name == "divine_tun_tian_clg_normal_stage" then
		self._divine_tun_tian_clg_normal_stage = content
	elseif name == "divine_tun_tian_clg_normal_support_pet" then
		self._divine_tun_tian_clg_normal_support_pet = content
	elseif name == "divine_tun_tian_clg_normal_progress_prize" then
		self._divine_tun_tian_clg_normal_progress_prize = content
	elseif name == "divine_tun_tian_clg_buff" then
		self._divine_tun_tian_clg_buff = content
	elseif name == "divine_tun_tian_clg_master" then
		self._divine_tun_tian_clg_master = content
	elseif name == "divine_tun_tian_clg_creeps" then
		self._divine_tun_tian_clg_creeps = content
	end
end

function DivineTunTianConfig:getActCfg(activityId)
	return self._divine_tun_tian_clg_activity[activityId]
end

function DivineTunTianConfig:getExtStageCfgs(activityId)
	return self._divine_tun_tian_clg_extreme_stage[activityId]
end

function DivineTunTianConfig:getExtStageCfgByStageId(activityId, stageId)
	return self._divine_tun_tian_clg_extreme_stage[activityId] and self._divine_tun_tian_clg_extreme_stage[activityId][stageId]
end

function DivineTunTianConfig:getNorStageCfgs(activityId)
	return self._divine_tun_tian_clg_normal_stage[activityId]
end

function DivineTunTianConfig:getNorStageCfgsByDay(activityId, day)
	return self._divine_tun_tian_clg_normal_stage[activityId] and self._divine_tun_tian_clg_normal_stage[activityId][day]
end

function DivineTunTianConfig:getNorCreepCfgByIndex(activityId, day, index)
	local stageCfgs = self:getNorStageCfgsByDay(activityId, day)
	local stageCfg = stageCfgs[index]

	return (self:getCreepCfg((stageCfg or nil) and stageCfg.creepsMasterId))
end

function DivineTunTianConfig:getNorSupportPetCfgs()
	return self._divine_tun_tian_clg_normal_support_pet.dataList
end

function DivineTunTianConfig:getNorSupportPetCfg(creepsId)
	return self._divine_tun_tian_clg_normal_support_pet[creepsId]
end

function DivineTunTianConfig:getNorPrizeCfgs(activityId)
	return self._divine_tun_tian_clg_normal_progress_prize[activityId]
end

function DivineTunTianConfig:getBuffCfgs(buffPlanId)
	local buffCfgs = {}

	for _, cfg in pairs(self._divine_tun_tian_clg_buff[buffPlanId]) do
		table.insert(buffCfgs, cfg)
	end

	table.sort(buffCfgs, function(a, b)
		return a.progress < b.progress
	end)

	return buffCfgs
end

function DivineTunTianConfig:getNorBuffCfgsByActId(activityId)
	local actCfg = self:getActCfg(activityId)
	local buffPlanId = actCfg.normalBuffPlanId
	local buffCfgs = {}

	for _, cfg in pairs(self._divine_tun_tian_clg_buff[buffPlanId]) do
		table.insert(buffCfgs, cfg)
	end

	table.sort(buffCfgs, function(a, b)
		return a.progress < b.progress
	end)

	return buffCfgs
end

function DivineTunTianConfig:getMasterCfg(creepsMasterId)
	return self._divine_tun_tian_clg_master[creepsMasterId]
end

function DivineTunTianConfig:getCreepCfg(creepsMasterId)
	return self._divine_tun_tian_clg_creeps[creepsMasterId]
end

function DivineTunTianConfig:getExtCreepMasterId(activityId, stageId)
	local stageCfg = self:getExtStageCfgByStageId(activityId, stageId)

	return stageCfg.creepsMasterId
end

function DivineTunTianConfig:getNorCreepMasterId(activityId, day, index)
	local stageCfgs = self:getNorStageCfgsByDay(activityId, day)
	local stageCfg = stageCfgs[index]

	return (stageCfg or nil) and stageCfg.creepsMasterId
end

DivineTunTianConfig.instance = DivineTunTianConfig.New()

return DivineTunTianConfig
