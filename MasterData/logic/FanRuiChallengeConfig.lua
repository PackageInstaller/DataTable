-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruichallenge/config/FanRuiChallengeConfig.lua

module("logic.extensions.fanruichallenge.config.FanRuiChallengeConfig", package.seeall)

local FanRuiChallengeConfig = class("FanRuiChallengeConfig", BaseConfig)

function FanRuiChallengeConfig:onInit()
	FanRuiChallengeConfig.super.onInit(self)

	self.fan_rui_challenge_activity = nil
	self.fan_rui_life_clg_stage = nil
	self.fan_rui_destiny_clg_stage = nil
	self.fan_rui_projected_plan = nil
	self.fan_rui_control_clg_stage = nil
	self.fan_rui_clg_monster = nil
	self.fan_rui_clg_creeps = nil
	self.fan_rui_clg_common = nil
end

function FanRuiChallengeConfig:getNames()
	return {
		"fan_rui_challenge_activity",
		"fan_rui_life_clg_stage",
		"fan_rui_destiny_clg_stage",
		"fan_rui_projected_plan",
		"fan_rui_control_clg_stage",
		"fan_rui_clg_monster",
		"fan_rui_clg_creeps",
		"fan_rui_clg_common"
	}
end

function FanRuiChallengeConfig:handleConfig(name, content)
	if name == "fan_rui_challenge_activity" then
		self.fan_rui_challenge_activity = content
	elseif name == "fan_rui_life_clg_stage" then
		self.fan_rui_life_clg_stage = content
	elseif name == "fan_rui_destiny_clg_stage" then
		self.fan_rui_destiny_clg_stage = content
	elseif name == "fan_rui_projected_plan" then
		self.fan_rui_projected_plan = content
	elseif name == "fan_rui_control_clg_stage" then
		self.fan_rui_control_clg_stage = content
	elseif name == "fan_rui_clg_monster" then
		self.fan_rui_clg_monster = content
	elseif name == "fan_rui_clg_creeps" then
		self.fan_rui_clg_creeps = content
	elseif name == "fan_rui_clg_common" then
		self.fan_rui_clg_common = content
	end
end

function FanRuiChallengeConfig:getActivityCfg(activityId)
	return self.fan_rui_challenge_activity[activityId]
end

function FanRuiChallengeConfig:getLifeClgStageCfgList(activityId)
	return self.fan_rui_life_clg_stage[activityId] or {}
end

function FanRuiChallengeConfig:getLifeClgStageCfg(activityId, stageId)
	return self.fan_rui_life_clg_stage[activityId] and self.fan_rui_life_clg_stage[activityId][stageId]
end

function FanRuiChallengeConfig:getDestinyClgStageCfgList(activityId)
	return self.fan_rui_destiny_clg_stage[activityId] or {}
end

function FanRuiChallengeConfig:getDestinyClgStageCfg(activityId, stageId)
	return self.fan_rui_destiny_clg_stage[activityId] and self.fan_rui_destiny_clg_stage[activityId][stageId]
end

function FanRuiChallengeConfig:getProjectedPlanCfgList(planId, planType)
	return self.fan_rui_projected_plan[planId] and self.fan_rui_projected_plan[planId][planType]
end

function FanRuiChallengeConfig:getProjectedPlanCfg(planId, planType, choiceId)
	return self.fan_rui_projected_plan[planId] and self.fan_rui_projected_plan[planId][planType] and self.fan_rui_projected_plan[planId][planType][choiceId]
end

function FanRuiChallengeConfig:getProjectedPlanCfgByValue(planId, planType, value)
	if self.fan_rui_projected_plan[planId] then
		if self.fan_rui_projected_plan[planId] then
			for i, v in ipairs(self.fan_rui_projected_plan[planId]) do
				for j, range in ipairs(v.valueRange) do
					local min = range[1]
					local max = range[2]

					if min <= value and value <= max then
						return v
					end
				end
			end
		end
	end
end

function FanRuiChallengeConfig:getControlClgStageCfgList(activityId)
	return self.fan_rui_control_clg_stage[activityId] or {}
end

function FanRuiChallengeConfig:getControlClgStageCfg(activityId, stageId)
	return self.fan_rui_control_clg_stage[activityId] and self.fan_rui_control_clg_stage[activityId][stageId]
end

function FanRuiChallengeConfig:getMonsterCfg(creepsMasterId)
	return self.fan_rui_clg_monster[creepsMasterId]
end

function FanRuiChallengeConfig:getCreepsCfgs(creepsMasterId)
	return self.fan_rui_clg_creeps[creepsMasterId] or {}
end

function FanRuiChallengeConfig:getCommonValue(key)
	if self.fan_rui_clg_common[key] then
		return self.fan_rui_clg_common[key].value
	end
end

FanRuiChallengeConfig.instance = FanRuiChallengeConfig.New()

return FanRuiChallengeConfig
