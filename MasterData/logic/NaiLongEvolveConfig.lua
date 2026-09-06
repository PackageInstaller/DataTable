-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailongevolve/config/NaiLongEvolveConfig.lua

module("logic.extensions.nailongevolve.config.NaiLongEvolveConfig", package.seeall)

local NaiLongEvolveConfig = class("NaiLongEvolveConfig", BaseConfig)

function NaiLongEvolveConfig:onInit()
	NaiLongEvolveConfig.super.onInit(self)
end

function NaiLongEvolveConfig:getNames()
	return {
		"milk_dragon_clg",
		"milk_dragon_clg_stage",
		"milk_dragon_clg_support_pet",
		"milk_dragon_clg_pos_buff",
		"milk_dragon_clg_accu_buff",
		"milk_dragon_clg_creeps_master",
		"milk_dragon_clg_creeps"
	}
end

function NaiLongEvolveConfig:handleConfig(name, content)
	if name == "milk_dragon_clg" then
		self._milk_dragon_clg = content
	elseif name == "milk_dragon_clg_stage" then
		self._milk_dragon_clg_stage = content
	elseif name == "milk_dragon_clg_support_pet" then
		self._milk_dragon_clg_support_pet = content
	elseif name == "milk_dragon_clg_pos_buff" then
		self._milk_dragon_clg_pos_buff = content
	elseif name == "milk_dragon_clg_accu_buff" then
		self._milk_dragon_clg_accu_buff = content
	elseif name == "milk_dragon_clg_creeps_master" then
		self._milk_dragon_clg_creeps_master = content
	elseif name == "milk_dragon_clg_creeps" then
		self._milk_dragon_clg_creeps = content
	end
end

function NaiLongEvolveConfig:getActData(activityId)
	return self._milk_dragon_clg[activityId]
end

function NaiLongEvolveConfig:getStageData(activityId)
	return self._milk_dragon_clg_stage[activityId]
end

function NaiLongEvolveConfig:getStageDataByStageId(activityId, stageId)
	return self._milk_dragon_clg_stage[activityId] and self._milk_dragon_clg_stage[activityId][stageId]
end

function NaiLongEvolveConfig:getSupportData(activityId)
	return self._milk_dragon_clg_support_pet[activityId]
end

function NaiLongEvolveConfig:getPosData(activityId)
	return self._milk_dragon_clg_pos_buff[activityId]
end

function NaiLongEvolveConfig:getAccuBuffSortList(activityId)
	local dataList = {}

	if self._milk_dragon_clg_accu_buff[activityId] then
		local accuBuffCfgs = self._milk_dragon_clg_accu_buff[activityId]

		for idx, cfg in pairs(accuBuffCfgs) do
			table.insert(dataList, cfg)
		end

		table.sort(dataList, function(a, b)
			return a.accScore < b.accScore
		end)
	end

	return dataList
end

function NaiLongEvolveConfig:getCreepMasterData(masterId)
	return self._milk_dragon_clg_creeps_master[masterId]
end

function NaiLongEvolveConfig:getCreepsData(creepMasterId)
	return self._milk_dragon_clg_creeps[creepMasterId]
end

function NaiLongEvolveConfig:getPosNames(activityId)
	local posNames = {}

	if self._milk_dragon_clg_pos_buff[activityId] then
		for i, cfgs in ipairs(self._milk_dragon_clg_pos_buff[activityId]) do
			table.insert(posNames, cfgs[1].name)
		end
	end

	return posNames
end

function NaiLongEvolveConfig:getCreepMasterId(activityId, stageId)
	local data = self:getStageDataByStageId(activityId, stageId)

	return data and data.creepsMasterId
end

function NaiLongEvolveConfig:getPosLastLvl(activityId, posType)
	local posBuffCfgs = self._milk_dragon_clg_pos_buff[activityId]

	if posBuffCfgs then
		local posBuffCfg = posBuffCfgs[posType]

		if posBuffCfg then
			local lastPosLvl = 0

			for idx, cfg in pairs(posBuffCfg) do
				if lastPosLvl <= cfg.posLvl then
					lastPosLvl = cfg.posLvl
				end
			end

			return lastPosLvl
		end
	end
end

function NaiLongEvolveConfig:getWinId(activityId, stageId)
	local creepMasterId = self:getCreepMasterId(activityId, stageId)
	local creepMasterCfg = self._milk_dragon_clg_creeps_master[creepMasterId]

	return creepMasterCfg and creepMasterCfg.winId
end

function NaiLongEvolveConfig:getPetName(activityId)
	if self._milk_dragon_clg[activityId] then
		local raceId = self._milk_dragon_clg[activityId].skinId
		local petData = CharacterConfig.instance:getPetCo(raceId)

		if petData then
			if not petData.name then
				return ""
			end
		end
	end
end

function NaiLongEvolveConfig:getCreepSkinId(activityId, stageId)
	local creepMasterId = NaiLongEvolveConfig.instance:getCreepMasterId(activityId, stageId)
	local creepMasterCfg = self:getCreepsData(creepMasterId)

	if creepMasterCfg then
		return creepMasterCfg[1].raceId
	end
end

function NaiLongEvolveConfig:getEnemyNum(activityId, stageId)
	local creepMasterId = NaiLongEvolveConfig.instance:getCreepMasterId(activityId, stageId)
	local creepMasterCfg = self:getCreepsData(creepMasterId)
	local num = 0

	if creepMasterCfg then
		for k, cfg in pairs(creepMasterCfg) do
			if cfg.posId > 0 then
				num = num + 1
			end
		end
	end

	return num
end

NaiLongEvolveConfig.instance = NaiLongEvolveConfig.New()

return NaiLongEvolveConfig
