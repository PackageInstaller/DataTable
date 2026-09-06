-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tonglinshiji/config/TongLinShiJiConfig.lua

module("logic.extensions.tonglinshiji.config.TongLinShiJiConfig", package.seeall)

local TongLinShiJiConfig = class("TongLinShiJiConfig", BaseConfig)

function TongLinShiJiConfig:onInit()
	TongLinShiJiConfig.super.onInit(self)
end

function TongLinShiJiConfig:getNames()
	return {
		"ji_clg_activity",
		"ji_clg_normal_stage",
		"ji_clg_support_pet",
		"ji_clg_extreme_stage",
		"ji_clg_score_rule",
		"ji_clg_monster",
		"ji_clg_creeps",
		"ji_clg_buff",
		"ji_clg_common"
	}
end

function TongLinShiJiConfig:handleConfig(name, content)
	if name == "ji_clg_activity" then
		self.ji_clg_activity = content
	elseif name == "ji_clg_normal_stage" then
		self.ji_clg_normal_stage = content
	elseif name == "ji_clg_support_pet" then
		self.ji_clg_support_pet = content
	elseif name == "ji_clg_extreme_stage" then
		self.ji_clg_extreme_stage = content
	elseif name == "ji_clg_score_rule" then
		self.ji_clg_score_rule = content
	elseif name == "ji_clg_monster" then
		self.ji_clg_monster = content
	elseif name == "ji_clg_creeps" then
		self.ji_clg_creeps = content
	elseif name == "ji_clg_buff" then
		self.ji_clg_buff = content
	elseif name == "ji_clg_common" then
		self.ji_clg_common = content
	end
end

function TongLinShiJiConfig:getJiActivityData(activityId)
	return self.ji_clg_activity[activityId]
end

function TongLinShiJiConfig:getJiNormalStageData(activityId)
	return self.ji_clg_normal_stage[activityId]
end

function TongLinShiJiConfig:getJiSupportPetData(creepsId)
	return self.ji_clg_support_pet[creepsId]
end

function TongLinShiJiConfig:getJiExtremeStageData(activityId)
	return self.ji_clg_extreme_stage[activityId]
end

function TongLinShiJiConfig:getJiScoreRuleData(activityId)
	return self.ji_clg_score_rule[activityId]
end

function TongLinShiJiConfig:getJiMonsterData(creepsMasterId)
	return self.ji_clg_monster[creepsMasterId]
end

function TongLinShiJiConfig:getJiCreepsData(creepsMasterId)
	return self.ji_clg_creeps[creepsMasterId]
end

function TongLinShiJiConfig:getJiBuffData()
	return self.ji_clg_buff
end

function TongLinShiJiConfig:getCommonValue(activityId, key)
	local planId = self.ji_clg_activity[activityId].comPlanId

	if self.ji_clg_common[planId] then
		return self.ji_clg_common[planId][key]
	end
end

function TongLinShiJiConfig:GetPrizes(activityId)
	if self.ji_clg_activity[activityId] then
		local normalPassPrize = self.ji_clg_activity[activityId].normalPassPrize
		local exremePassPrize = self.ji_clg_activity[activityId].exremePassPrize

		return normalPassPrize, exremePassPrize
	end
end

function TongLinShiJiConfig:GetNorTimesClg(activityId)
	if self.ji_clg_activity[activityId] then
		local dailyClgNormalStageTimes = self.ji_clg_activity[activityId].dailyClgNormalStageTimes
		local dailyClgNormalBossTimes = self.ji_clg_activity[activityId].dailyClgNormalBossTimes

		return dailyClgNormalStageTimes, dailyClgNormalBossTimes
	end
end

function TongLinShiJiConfig:GetNorCreepsId(activityId, stageId)
	if self.ji_clg_normal_stage[activityId] then
		local data = self.ji_clg_normal_stage[activityId][stageId]

		return data.creepsMasterId
	end

	return 0
end

function TongLinShiJiConfig:GetNorBossCreepsId(activityId)
	if self.ji_clg_activity[activityId] then
		local data = self.ji_clg_activity[activityId]

		return data.normalBossId
	end

	return 0
end

function TongLinShiJiConfig:GetNorSupportCreepsId(activityId, stageId)
	if self.ji_clg_normal_stage[activityId] then
		local data = self.ji_clg_normal_stage[activityId][stageId]

		return data.unlockSupportCreepsId
	end

	return 0
end

function TongLinShiJiConfig:GetExtRaceTypes(activityId)
	local arr = {}
	local stageData = self.ji_clg_extreme_stage[activityId]

	for type, v in pairs(stageData) do
		table.insert(arr, type)
	end

	return arr
end

function TongLinShiJiConfig:GetExtCreepsId(activityId, raceType, stageId)
	return (not ((self.ji_clg_extreme_stage[activityId] and self.ji_clg_extreme_stage[activityId][raceType] or nil) and self.ji_clg_extreme_stage[activityId][raceType][stageId]).creepsMasterId or nil) and 0
end

function TongLinShiJiConfig:GetExtCreepsIds(activityId, raceType)
	local arr = {}

	for i, v in ipairs((self.ji_clg_extreme_stage[activityId] or nil) and self.ji_clg_extreme_stage[activityId][raceType]) do
		table.insert(arr, v.creepsMasterId)
	end

	return arr
end

function TongLinShiJiConfig:GetEtrRuleShort(activityId, raceType, stageId)
	if self.ji_clg_extreme_stage[activityId] and self.ji_clg_extreme_stage[activityId][raceType] then
		local data = self.ji_clg_extreme_stage[activityId][raceType]

		if data[stageId] then
			return data[stageId].shortRule
		end

		return ""
	end
end

function TongLinShiJiConfig:GetEtrRuleDetail(activityId, raceType, stageId)
	if self.ji_clg_extreme_stage[activityId] and self.ji_clg_extreme_stage[activityId][raceType] then
		local data = self.ji_clg_extreme_stage[activityId][raceType]

		return data[stageId] and data[stageId].detailRule
	end
end

function TongLinShiJiConfig:GetDailyNorStageNum(activityId)
	return self.ji_clg_activity[activityId].dailyClgNormalStageTimes or 0
end

function TongLinShiJiConfig:GetDailyNorBossNum(activityId)
	return self.ji_clg_activity[activityId].dailyClgNormalBossTimes or 0
end

function TongLinShiJiConfig:GetCreepsName(activityId, stageId)
	if self.ji_clg_normal_stage[activityId] and self.ji_clg_normal_stage[activityId][stageId] then
		local creepsId = self.ji_clg_normal_stage[activityId][stageId].unlockSupportCreepsId

		return self.ji_clg_support_pet[creepsId].creepsName or ""
	end
end

TongLinShiJiConfig.instance = TongLinShiJiConfig.New()

return TongLinShiJiConfig
