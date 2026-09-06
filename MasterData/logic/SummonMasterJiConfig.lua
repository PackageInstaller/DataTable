-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterji/config/SummonMasterJiConfig.lua

module("logic.extensions.summonmasterji.config.SummonMasterJiConfig", package.seeall)

local SummonMasterJiConfig = class("SummonMasterJiConfig", BaseConfig)

function SummonMasterJiConfig:onInit()
	SummonMasterJiConfig.super.onInit(self)

	self.summon_master_ji_activity = nil
	self.summon_master_ji_extreme_stage = nil
	self.summon_master_ji_extreme_score_buff = nil
	self.summon_master_ji_extreme_stage_score = nil
	self.summon_master_ji_normal_stage = nil
	self.summon_master_ji_blessing = nil
	self.summon_master_ji_normal_one_key_pass_cost = nil
	self.summon_master_ji_master = nil
	self.summon_master_ji_creeps = nil
	self.summon_master_ji_buff = nil
	self.summon_master_ji_common = nil
end

function SummonMasterJiConfig:getNames()
	return {
		"summon_master_ji_activity",
		"summon_master_ji_extreme_stage",
		"summon_master_ji_extreme_score_buff",
		"summon_master_ji_extreme_stage_score",
		"summon_master_ji_normal_stage",
		"summon_master_ji_blessing",
		"summon_master_ji_normal_one_key_pass_cost",
		"summon_master_ji_master",
		"summon_master_ji_creeps",
		"summon_master_ji_buff",
		"summon_master_ji_common"
	}
end

function SummonMasterJiConfig:handleConfig(name, content)
	if name == "summon_master_ji_activity" then
		self.summon_master_ji_activity = content
	elseif name == "summon_master_ji_extreme_stage" then
		self.summon_master_ji_extreme_stage = content
	elseif name == "summon_master_ji_extreme_score_buff" then
		self.summon_master_ji_extreme_score_buff = content
	elseif name == "summon_master_ji_extreme_stage_score" then
		self.summon_master_ji_extreme_stage_score = content
	elseif name == "summon_master_ji_normal_stage" then
		self.summon_master_ji_normal_stage = content
	elseif name == "summon_master_ji_blessing" then
		self.summon_master_ji_blessing = content
	elseif name == "summon_master_ji_normal_one_key_pass_cost" then
		self.summon_master_ji_normal_one_key_pass_cost = content
	elseif name == "summon_master_ji_master" then
		self.summon_master_ji_master = content
	elseif name == "summon_master_ji_creeps" then
		self.summon_master_ji_creeps = content
	elseif name == "summon_master_ji_buff" then
		self.summon_master_ji_buff = content
	elseif name == "summon_master_ji_common" then
		self.summon_master_ji_common = content
	end
end

function SummonMasterJiConfig:getActivityCfg(activityId)
	return self.summon_master_ji_activity[activityId]
end

function SummonMasterJiConfig:getNormalStageList(activityId)
	return self.summon_master_ji_normal_stage[activityId]
end

function SummonMasterJiConfig:getNormalChapterStageList(activityId, chapterId)
	local cfgs = self.summon_master_ji_normal_stage[activityId]
	local stageList = {}

	for i, v in ipairs(cfgs) do
		if v.chapterId == chapterId then
			table.insert(stageList, v)
		end
	end

	return stageList
end

function SummonMasterJiConfig:getNormalStageCfg(activityId, stageId)
	return self.summon_master_ji_normal_stage[activityId] and self.summon_master_ji_normal_stage[activityId][stageId]
end

function SummonMasterJiConfig:getExtremeStageCfg(activityId, stageId)
	return self.summon_master_ji_extreme_stage[activityId] and self.summon_master_ji_extreme_stage[activityId][stageId]
end

function SummonMasterJiConfig:getCommonValue(key)
	return self.summon_master_ji_common[key] and self.summon_master_ji_common[key].value
end

function SummonMasterJiConfig:getExtremeScoreBuffList(activityId)
	local list = {}

	for i, v in ipairs(self.summon_master_ji_extreme_score_buff.dataList) do
		if v.activityId == activityId then
			table.insert(list, v)
		end
	end

	return list
end

function SummonMasterJiConfig:getMonsterCfg(creepsMasterId)
	return self.summon_master_ji_master[creepsMasterId]
end

function SummonMasterJiConfig:getCreeps(creepsMasterId)
	return self.summon_master_ji_creeps[creepsMasterId]
end

function SummonMasterJiConfig:getExtremeStageScoreList(stageScorePlanId)
	return self.summon_master_ji_extreme_stage_score[stageScorePlanId]
end

function SummonMasterJiConfig:getBuffList()
	return self.summon_master_ji_buff
end

function SummonMasterJiConfig:getBuffCfg(buffId)
	return self.summon_master_ji_buff[buffId]
end

function SummonMasterJiConfig:getBlessingList(activityId)
	return self.summon_master_ji_blessing[activityId]
end

function SummonMasterJiConfig:getBlessingCfg(activityId, blessingId)
	return self.summon_master_ji_blessing[activityId] and self.summon_master_ji_blessing[activityId][blessingId]
end

function SummonMasterJiConfig:getNormalOneKeyCfgList(activityId)
	local list = {}

	for i, v in ipairs(self.summon_master_ji_normal_one_key_pass_cost.dataList) do
		if v.activityId == activityId then
			table.insert(list, v)
		end
	end

	return list
end

function SummonMasterJiConfig:getNormalOneKeyCfg(activityId, leftProgress)
	return self.summon_master_ji_normal_one_key_pass_cost[activityId] and self.summon_master_ji_normal_one_key_pass_cost[activityId][leftProgress]
end

SummonMasterJiConfig.instance = SummonMasterJiConfig.New()

return SummonMasterJiConfig
