-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunwu/config/KunWuConfig.lua

module("logic.extensions.kunwu.config.KunWuConfig", package.seeall)

local KunWuConfig = class("KunWuConfig", BaseConfig)

function KunWuConfig:onInit()
	KunWuConfig.super.onInit(self)
end

function KunWuConfig:getNames()
	return {
		"kun_wu_clg",
		"kun_wu_extreme_clg_phase",
		"kun_wu_extreme_clg_stage",
		"kun_wu_normal_clg_stage_group",
		"kun_wu_normal_clg_buff",
		"kun_wu_normal_clg_progress",
		"kun_wu_clg_creeps_master",
		"kun_wu_clg_creeps"
	}
end

function KunWuConfig:handleConfig(name, content)
	if name == "kun_wu_clg" then
		self._kun_wu_clg = content
	elseif name == "kun_wu_extreme_clg_phase" then
		self._kun_wu_extreme_clg_phase = content
	elseif name == "kun_wu_extreme_clg_stage" then
		self._kun_wu_extreme_clg_stage = content
	elseif name == "kun_wu_normal_clg_stage_group" then
		self._kun_wu_normal_clg_stage_group = content
	elseif name == "kun_wu_normal_clg_buff" then
		self._kun_wu_normal_clg_buff = content
	elseif name == "kun_wu_normal_clg_progress" then
		self._kun_wu_normal_clg_progress = content
	elseif name == "kun_wu_clg_creeps_master" then
		self._kun_wu_clg_creeps_master = content
	elseif name == "kun_wu_clg_creeps" then
		self._kun_wu_clg_creeps = content
	end
end

function KunWuConfig:getKunWuActData(activityId)
	return self._kun_wu_clg[activityId]
end

function KunWuConfig:getKunWuExtPhaseData(activityId)
	return self._kun_wu_extreme_clg_phase[activityId]
end

function KunWuConfig:getKunWuExtStageData(activityId)
	return self._kun_wu_extreme_clg_stage[activityId]
end

function KunWuConfig:getKunWuNorStageData(activityId)
	return self._kun_wu_normal_clg_stage_group[activityId]
end

function KunWuConfig:getKunWuNorBuffData(activityId)
	return self._kun_wu_normal_clg_buff[activityId]
end

function KunWuConfig:getKunWuNorProgressData(activityId)
	return self._kun_wu_normal_clg_progress[activityId]
end

function KunWuConfig:getKunWuNorProgressDataById(activityId, dataBitId)
	if self._kun_wu_normal_clg_progress[activityId] then
		return self._kun_wu_normal_clg_progress[activityId][dataBitId]
	end
end

function KunWuConfig:getKunWuCreepsMasterData(creepsMasterId)
	return self._kun_wu_clg_creeps_master[creepsMasterId]
end

function KunWuConfig:getKunWuCreepsData(creepsMasterId)
	return self._kun_wu_clg_creeps[creepsMasterId]
end

function KunWuConfig:getNorCreepsId(activityId, groupIdx, creepIdx)
	if self._kun_wu_normal_clg_stage_group[activityId] then
		local stageCfg = self._kun_wu_normal_clg_stage_group[activityId][groupIdx]
		local creepsIds = stageCfg.teamIds

		if creepsIds then
			return creepsIds[creepIdx]
		end
	end
end

function KunWuConfig:getExtCreepsId(activityId, phase, stage)
	if self._kun_wu_extreme_clg_stage[activityId] then
		return self._kun_wu_extreme_clg_stage[activityId][stage] and self._kun_wu_extreme_clg_stage[activityId][stage].creepsMasterId
	end
end

function KunWuConfig:getNorTotalProgress(activityId)
	local cfgs = self._kun_wu_normal_clg_progress[activityId]

	if cfgs then
		local lastProgressCfg = cfgs[#cfgs]

		return lastProgressCfg and lastProgressCfg.progress
	end
end

function KunWuConfig:getExtOriginBuffs(activityId, phase)
	if self._kun_wu_extreme_clg_stage[activityId] then
		local curBuffList = {}

		if self._kun_wu_extreme_clg_stage[activityId] then
			for i, data in ipairs(self._kun_wu_extreme_clg_stage[activityId]) do
				table.insert(curBuffList, data.stageOriginBuff)
			end
		end

		return curBuffList
	end
end

function KunWuConfig:getExtStageOriginBuff(activityId, phase, stage)
	if self._kun_wu_extreme_clg_stage[activityId] then
		if self._kun_wu_extreme_clg_stage[activityId] then
			return self._kun_wu_extreme_clg_stage[activityId][stage] and self._kun_wu_extreme_clg_stage[activityId][stage].stageOriginBuff
		end
	end
end

function KunWuConfig:getExtStageBuffDesc(activityId, phase, stage)
	if self._kun_wu_extreme_clg_stage[activityId] then
		if self._kun_wu_extreme_clg_stage[activityId] then
			return self._kun_wu_extreme_clg_stage[activityId][stage] and self._kun_wu_extreme_clg_stage[activityId][stage].stageBuffStr
		end
	end
end

function KunWuConfig:getExtStageBottomWord(activityId, phase)
	if self._kun_wu_extreme_clg_phase[activityId] then
		if self._kun_wu_extreme_clg_phase[activityId] then
			return self._kun_wu_extreme_clg_phase[activityId].stageBottomWord
		end
	end
end

function KunWuConfig:getExtCaculateSymbol(activityId, phase)
	if self._kun_wu_extreme_clg_phase[activityId] then
		if self._kun_wu_extreme_clg_phase[activityId] then
			return self._kun_wu_extreme_clg_phase[activityId].caculateSymbol
		end
	end
end

function KunWuConfig:getExtStageTopRule(activityId, phase)
	if self._kun_wu_extreme_clg_phase[activityId] then
		if self._kun_wu_extreme_clg_phase[activityId] then
			return self._kun_wu_extreme_clg_phase[activityId].topRule
		end
	end
end

function KunWuConfig:getExtStageBottomRule(activityId, phase)
	if self._kun_wu_extreme_clg_phase[activityId] then
		if self._kun_wu_extreme_clg_phase[activityId] then
			return self._kun_wu_extreme_clg_phase[activityId].bottomRule
		end
	end
end

function KunWuConfig:getExtStageTargetSumValue(activityId, phase)
	if self._kun_wu_extreme_clg_phase[activityId] then
		if self._kun_wu_extreme_clg_phase[activityId] then
			return self._kun_wu_extreme_clg_phase[activityId].targetSumValue
		end
	end
end

function KunWuConfig:getSkinId(activityId)
	if self._kun_wu_clg[activityId] then
		return self._kun_wu_clg[activityId].skinId
	end
end

KunWuConfig.instance = KunWuConfig.New()

return KunWuConfig
