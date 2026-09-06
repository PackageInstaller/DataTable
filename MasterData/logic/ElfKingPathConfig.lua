-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elfkingpath/config/ElfKingPathConfig.lua

module("logic.extensions.elfkingpath.config.ElfKingPathConfig", package.seeall)

local ElfKingPathConfig = class("ElfKingPathConfig", BaseConfig)

function ElfKingPathConfig:getNames()
	return {
		"elf_king_path_master",
		"elf_king_path_support_pet",
		"elf_king_path_creeps",
		"elf_king_path_stage",
		"elf_king_path_son_stage",
		"elf_king_path_params"
	}
end

function ElfKingPathConfig:handleConfig(name, content)
	if name == "elf_king_path_master" then
		self._elf_king_path_master = content
	elseif name == "elf_king_path_support_pet" then
		self._elf_king_path_support_pet = content
	elseif name == "elf_king_path_creeps" then
		self._elf_king_path_creeps = content
	elseif name == "elf_king_path_stage" then
		self._elf_king_path_stage = content

		self:_handleStageCfg()
	elseif name == "elf_king_path_son_stage" then
		self._elf_king_path_son_stage = content
	elseif name == "elf_king_path_params" then
		self._elf_king_path_params = content
	end
end

function ElfKingPathConfig:getCreepCfgs(creepsMasterId)
	return self._elf_king_path_creeps[creepsMasterId]
end

function ElfKingPathConfig:getTeamCfg(creepsMasterId)
	return self._elf_king_path_master[creepsMasterId]
end

function ElfKingPathConfig:getSupportPetCfgs(planId)
	return self._elf_king_path_support_pet[planId]
end

function ElfKingPathConfig:getStageCfg(stageId)
	return self._elf_king_path_stage[stageId]
end

function ElfKingPathConfig:_handleStageCfg()
	self._stageCfgsByPhaseId = {}

	for i, v in ipairs(self._elf_king_path_stage.dataList) do
		local phaseId = v.PhaseId

		self._stageCfgsByPhaseId[phaseId] = self._stageCfgsByPhaseId[phaseId] or {}

		table.insert(self._stageCfgsByPhaseId[phaseId], v)
	end
end

function ElfKingPathConfig:getMaxStageId()
	local maxStageId = 0

	for i, v in ipairs(self._elf_king_path_stage.dataList) do
		if maxStageId < v.stageId then
			maxStageId = v.stageId
		end
	end

	return maxStageId
end

function ElfKingPathConfig:getStageCfgsGroups()
	return self._stageCfgsByPhaseId
end

function ElfKingPathConfig:getSonStageCfgsByStageId(stageId)
	return self._elf_king_path_son_stage[stageId] or {}
end

function ElfKingPathConfig:getSonStageCfg(stageId, sonStageId)
	if self._elf_king_path_son_stage[stageId] then
		return self._elf_king_path_son_stage[stageId][sonStageId]
	end
end

function ElfKingPathConfig:getAllSonStageCfgs()
	local allSonStageCfgs = {}

	for i, v in ipairs(self._elf_king_path_son_stage.dataList) do
		table.insert(allSonStageCfgs, v)
	end

	return allSonStageCfgs
end

function ElfKingPathConfig:getCommonValue(key)
	local cfg = self._elf_king_path_params[key]

	if cfg then
		return cfg.value
	end
end

ElfKingPathConfig.instance = ElfKingPathConfig.New()

return ElfKingPathConfig
