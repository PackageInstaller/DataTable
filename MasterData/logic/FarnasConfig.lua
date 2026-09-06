-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/farnas/config/FarnasConfig.lua

module("logic.extensions.farnas.config.FarnasConfig", package.seeall)

local FarnasConfig = class("FarnasConfig", BaseConfig)

function FarnasConfig:onInit()
	return
end

function FarnasConfig:getNames()
	return {
		"farnas_clg_activity",
		"farnas_extreme_clg_stage",
		"farnas_extreme_clg_buff",
		"farnas_normal_clg_stage_group",
		"farnas_normal_clg_rule",
		"farnas_normal_clg_progress",
		"farnas_clg_creeps_master",
		"farnas_clg_creeps"
	}
end

function FarnasConfig:handleConfig(name, content)
	if name == "farnas_clg_activity" then
		self._farnas_clg_activity = content
	elseif name == "farnas_extreme_clg_stage" then
		self._farnas_extreme_clg_stage = content
	elseif name == "farnas_extreme_clg_buff" then
		self._farnas_extreme_clg_buff = content
	elseif name == "farnas_normal_clg_stage_group" then
		self._farnas_normal_clg_stage_group = content
	elseif name == "farnas_normal_clg_rule" then
		self._farnas_normal_clg_rule = content
	elseif name == "farnas_normal_clg_progress" then
		self._farnas_normal_clg_progress = {}

		for i, v in ipairs(content.dataList) do
			self._farnas_normal_clg_progress[v.activityId] = self._farnas_normal_clg_progress[v.activityId] or {}

			if v.notShowPrize <= 0 then
				self._farnas_normal_clg_progress[v.activityId][v.dataBitId] = v
			end
		end

		self._farnas_normal_clg_progress.dataList = content.dataList
	elseif name == "farnas_clg_creeps_master" then
		self._farnas_clg_creeps_master = content
	elseif name == "farnas_clg_creeps" then
		self._farnas_clg_creeps = content
	end
end

function FarnasConfig:getSkinId(activityId)
	return self._farnas_clg_activity[activityId].skinId
end

function FarnasConfig:getRuleKey(activityId, ruleKey)
	return self._farnas_clg_activity[activityId][ruleKey]
end

function FarnasConfig:getActCfg(activityId)
	return self._farnas_clg_activity[activityId]
end

function FarnasConfig:getExtStageCfgs(activityId)
	return self._farnas_extreme_clg_stage[activityId]
end

function FarnasConfig:getExtStageCfg(activityId, stageId)
	return self._farnas_extreme_clg_stage[activityId][stageId]
end

function FarnasConfig:getNorRuleDesc(activityId)
	return self._farnas_clg_activity[activityId].norRuleDesc
end

function FarnasConfig:getNorProgressCfgs(activityId)
	return self._farnas_normal_clg_progress[activityId]
end

function FarnasConfig:getNorProgressCfg(activityId, dataBitId)
	return self._farnas_normal_clg_progress[activityId][dataBitId]
end

function FarnasConfig:getNorStageGroupCfg(activityId, groupId)
	return self._farnas_normal_clg_stage_group[activityId][groupId]
end

function FarnasConfig:getNorStageGroupCfgByDataBitId(activityId, groupId, dataBitId)
	return self._farnas_normal_clg_stage_group[activityId][groupId][dataBitId]
end

function FarnasConfig:getCreepsCfgs(creepsMasterId)
	return self._farnas_clg_creeps[creepsMasterId]
end

function FarnasConfig:getNorRuleCfgs(activityId)
	return self._farnas_normal_clg_rule[activityId]
end

function FarnasConfig:getCreepsMasterCfg(creepsMasterId)
	return self._farnas_clg_creeps_master[creepsMasterId]
end

function FarnasConfig:getExtBuff(activityId, lockNum)
	local temp = self._farnas_extreme_clg_buff[activityId]
	local buffs = table.values(temp)

	table.sort(buffs, function(a, b)
		return a.lockRaceCount < b.lockRaceCount
	end)

	for i = #buffs, 1, -1 do
		local cfg = buffs[i]

		if lockNum >= cfg.lockRaceCount then
			return cfg
		end
	end

	return nil
end

function FarnasConfig:getExtBuffCfgs(activityId)
	return self._farnas_extreme_clg_buff[activityId]
end

function FarnasConfig:getExtBuffCfgNumList(activityId)
	local cfgs = self._farnas_extreme_clg_buff[activityId]
	local list = table.values(cfgs)

	table.sort(list, function(a, b)
		return a.lockRaceCount < b.lockRaceCount
	end)

	local scores = {}

	for i, v in ipairs(list) do
		table.insert(scores, v.lockRaceCount)
	end

	return scores
end

FarnasConfig.instance = FarnasConfig.New()

return FarnasConfig
