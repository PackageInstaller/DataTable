-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/demondescend/config/DemonDescendConfig.lua

module("logic.extensions.demondescend.config.DemonDescendConfig", package.seeall)

local DemonDescendConfig = class("DemonDescendConfig", BaseConfig)

function DemonDescendConfig:getNames()
	return {
		"demon_descend_activity",
		"demon_descend_stage",
		"demon_descend_support_pet",
		"demon_descend_master",
		"demon_descend_creeps",
		"demon_descend_progress_prize",
		"demon_descend_buff",
		"demon_descend_boss_stage",
		"demon_descend_damage_rank_prize"
	}
end

function DemonDescendConfig:handleConfig(name, content)
	if name == "demon_descend_activity" then
		self._demon_descend_activity = content
	elseif name == "demon_descend_stage" then
		self._demon_descend_stage = content
	elseif name == "demon_descend_support_pet" then
		self._demon_descend_support_pet = content
	elseif name == "demon_descend_master" then
		self._demon_descend_master = content
	elseif name == "demon_descend_creeps" then
		self._demon_descend_creeps = content
	elseif name == "demon_descend_progress_prize" then
		self._demon_descend_progress_prize = content
	elseif name == "demon_descend_buff" then
		self._demon_descend_buff = content
	elseif name == "demon_descend_boss_stage" then
		self._demon_descend_boss_stage = content
	elseif name == "demon_descend_damage_rank_prize" then
		self._demon_descend_damage_rank_prize = content
	end
end

function DemonDescendConfig:getActData(activityId)
	return self._demon_descend_activity[activityId]
end

function DemonDescendConfig:getStageCfg(activityId)
	return self._demon_descend_stage[activityId]
end

function DemonDescendConfig:getStageData(activityId, stageId)
	if self._demon_descend_stage[activityId] then
		return self._demon_descend_stage[activityId][stageId]
	end
end

function DemonDescendConfig:getSupportCfg(activityId)
	return self._demon_descend_support_pet[activityId]
end

function DemonDescendConfig:getMasterData(creepsMasterId)
	return self._demon_descend_master[creepsMasterId]
end

function DemonDescendConfig:getCreepsCfg(activityId)
	return self._demon_descend_creeps[activityId]
end

function DemonDescendConfig:getCreepsData(activityId, creepsId)
	if self._demon_descend_creeps[activityId] then
		return self._demon_descend_creeps[activityId][creepsId]
	end
end

function DemonDescendConfig:getProgressPrizeCfg(activityId)
	return self._demon_descend_progress_prize[activityId]
end

function DemonDescendConfig:getProgressPrizeData(activityId, progressId)
	if self._demon_descend_progress_prize[activityId] then
		return self._demon_descend_progress_prize[activityId][progressId]
	end
end

function DemonDescendConfig:getBuffCfgs(activityId)
	return self._demon_descend_buff[activityId]
end

function DemonDescendConfig:getBuffCfg(activityId, buffType)
	if self._demon_descend_buff[activityId] then
		return self._demon_descend_buff[activityId][buffType]
	end
end

function DemonDescendConfig:getBuffDataById(activityId, buffId)
	self._buffDataDiction = self._buffDataDiction or {}

	if self._buffDataDiction[activityId] == nil then
		self._buffDataDiction[activityId] = {}

		local cfgs = self:getBuffCfgs(activityId) or {}

		for _, cfg in pairs(cfgs) do
			for _, data in pairs(cfg) do
				self._buffDataDiction[activityId][data.buffId] = data
			end
		end
	end

	return self._buffDataDiction[activityId][buffId]
end

function DemonDescendConfig:getBossCfg(activityId)
	return self._demon_descend_boss_stage[activityId]
end

function DemonDescendConfig:getBossData(activityId, stageId)
	if self._demon_descend_boss_stage[activityId] then
		return self._demon_descend_boss_stage[activityId][stageId]
	end
end

function DemonDescendConfig:getDamageRankCfg(activityId)
	self._damageRankCfg = self._damageRankCfg or {}

	local cfg = self._damageRankCfg[activityId]

	if cfg == nil then
		local config = self._demon_descend_damage_rank_prize[activityId]

		if config then
			self._damageRankCfg[activityId] = {}
			cfg = self._damageRankCfg[activityId]

			for i, data in pairs(config) do
				cfg[data.id] = data
			end
		end
	end

	return cfg
end

function DemonDescendConfig:getDamageRankData(activityId, rank)
	local cfg = self:getDamageRankCfg(activityId)

	return MmUtil.binarySearchInArrayKey(cfg, "rankRange", rank)
end

DemonDescendConfig.instance = DemonDescendConfig.New()

return DemonDescendConfig
