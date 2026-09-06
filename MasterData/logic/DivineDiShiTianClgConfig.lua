-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedishitianclg/config/DivineDiShiTianClgConfig.lua

module("logic.extensions.divinedishitianclg.config.DivineDiShiTianClgConfig", package.seeall)

local DivineDiShiTianClgConfig = class("DivineDiShiTianClgConfig", BaseConfig)

function DivineDiShiTianClgConfig:onInit()
	DivineDiShiTianClgConfig.super.onInit(self)
end

function DivineDiShiTianClgConfig:getNames()
	return {
		"divine_dishitian_challenge_activity",
		"divine_dishitian_challenge_normal_stage",
		"divine_dishitian_challenge_normal_support_creeps",
		"divine_dishitian_challenge_normal_prize",
		"divine_dishitian_challenge_extreme_step",
		"divine_dishitian_challenge_extreme_stageId",
		"divine_dishitian_challenge_team",
		"divine_dishitian_challenge_creeps",
		"divine_dishitian_challenge_common"
	}
end

function DivineDiShiTianClgConfig:handleConfig(name, content)
	if name == "divine_dishitian_challenge_activity" then
		self.divine_dishitian_challenge_activity = content
	elseif name == "divine_dishitian_challenge_normal_stage" then
		self.divine_dishitian_challenge_normal_stage = content
	elseif name == "divine_dishitian_challenge_normal_support_creeps" then
		self.divine_dishitian_challenge_normal_support_creeps = content
	elseif name == "divine_dishitian_challenge_normal_prize" then
		self.divine_dishitian_challenge_normal_prize = content
	elseif name == "divine_dishitian_challenge_extreme_step" then
		self.divine_dishitian_challenge_extreme_step = content
	elseif name == "divine_dishitian_challenge_extreme_stageId" then
		self.divine_dishitian_challenge_extreme_stageId = content
	elseif name == "divine_dishitian_challenge_team" then
		self.divine_dishitian_challenge_team = content
	elseif name == "divine_dishitian_challenge_creeps" then
		self.divine_dishitian_challenge_creeps = content
	elseif name == "divine_dishitian_challenge_common" then
		self.divine_dishitian_challenge_common = content
	end
end

function DivineDiShiTianClgConfig:getActivityCfg(id)
	return self.divine_dishitian_challenge_activity[id]
end

function DivineDiShiTianClgConfig:getNormalStageCfgByDay(activityId, day)
	if self.divine_dishitian_challenge_normal_stage[activityId] then
		local count = #self.divine_dishitian_challenge_normal_stage[activityId]
		local newDay = (day - 1) % count + 1

		return self.divine_dishitian_challenge_normal_stage[activityId][newDay]
	end

	return self.divine_dishitian_challenge_normal_stage[activityId] and self.divine_dishitian_challenge_normal_stage[activityId][day]
end

function DivineDiShiTianClgConfig:getLastNormalStageCfg(activityId)
	if self.divine_dishitian_challenge_normal_stage[activityId] then
		local count = #self.divine_dishitian_challenge_normal_stage[activityId]

		return self.divine_dishitian_challenge_normal_stage[activityId][count]
	end
end

function DivineDiShiTianClgConfig:getNormalSupportCreeps(creepsId)
	return self.divine_dishitian_challenge_normal_support_creeps[creepsId]
end

function DivineDiShiTianClgConfig:getNormalSupportCreepsList()
	return self.divine_dishitian_challenge_normal_support_creeps.dataList
end

function DivineDiShiTianClgConfig:getNormalPrizeList(activityId)
	return self.divine_dishitian_challenge_normal_prize[activityId] or {}
end

function DivineDiShiTianClgConfig:getExtremeStepList(activityId)
	return self.divine_dishitian_challenge_extreme_step[activityId]
end

function DivineDiShiTianClgConfig:getExtremeStepCfg(activityId, stepId)
	return self.divine_dishitian_challenge_extreme_step[activityId] and self.divine_dishitian_challenge_extreme_step[activityId][stepId]
end

function DivineDiShiTianClgConfig:getExtremeStageList(activityId, stepId)
	return self.divine_dishitian_challenge_extreme_stageId[activityId] and self.divine_dishitian_challenge_extreme_stageId[activityId][stepId]
end

function DivineDiShiTianClgConfig:getExtremeStage(activityId, stepId, stageId)
	return self:getExtremeStepList(activityId, stepId) and self.divine_dishitian_challenge_extreme_stageId[activityId][stepId][stageId]
end

function DivineDiShiTianClgConfig:getMonsterCfg(creepsMasterId)
	return self.divine_dishitian_challenge_team[creepsMasterId]
end

function DivineDiShiTianClgConfig:getCreeps(creepsMasterId)
	return self.divine_dishitian_challenge_creeps[creepsMasterId]
end

function DivineDiShiTianClgConfig:getCommonValue(key)
	if self.divine_dishitian_challenge_common[key] then
		if not string.nilorempty(self.divine_dishitian_challenge_common[key].value2) then
			return self.divine_dishitian_challenge_common[key].value2
		else
			return self.divine_dishitian_challenge_common[key].value
		end
	end
end

DivineDiShiTianClgConfig.instance = DivineDiShiTianClgConfig.New()

return DivineDiShiTianClgConfig
