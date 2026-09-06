-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firedimension/config/FireDimensionConfig.lua

module("logic.extensions.firedimension.config.FireDimensionConfig", package.seeall)

local FireDimensionConfig = class("FireDimensionConfig", BaseConfig)

function FireDimensionConfig:onInit()
	FireDimensionConfig.super.onInit(self)

	self.fire_dimension_challenge_activity = nil
	self.fire_dimension_challenge_stage = nil
	self.fire_dimension_challenge_team = nil
	self.fire_dimension_challenge_stage_prize = nil
	self.fire_dimension_challenge_buff = nil
	self.fire_dimension_challenge_monster = nil
	self.fire_dimension_challenge_creeps = nil
end

function FireDimensionConfig:getNames()
	return {
		"fire_dimension_challenge_activity",
		"fire_dimension_challenge_stage",
		"fire_dimension_challenge_team",
		"fire_dimension_challenge_stage_prize",
		"fire_dimension_challenge_buff",
		"fire_dimension_challenge_monster",
		"fire_dimension_challenge_creeps",
		"fire_dimension_challenge_sign_in_buff"
	}
end

function FireDimensionConfig:handleConfig(name, content)
	if name == "fire_dimension_challenge_activity" then
		self.fire_dimension_challenge_activity = content
	elseif name == "fire_dimension_challenge_stage" then
		self.fire_dimension_challenge_stage = content
	elseif name == "fire_dimension_challenge_team" then
		self.fire_dimension_challenge_team = content
	elseif name == "fire_dimension_challenge_stage_prize" then
		self.fire_dimension_challenge_stage_prize = content
	elseif name == "fire_dimension_challenge_buff" then
		self.fire_dimension_challenge_buff = content
	elseif name == "fire_dimension_challenge_monster" then
		self.fire_dimension_challenge_monster = content
	elseif name == "fire_dimension_challenge_creeps" then
		self.fire_dimension_challenge_creeps = content
	elseif name == "fire_dimension_challenge_sign_in_buff" then
		self.fire_dimension_challenge_sign_in_buff = content
	end
end

function FireDimensionConfig:getActivityCfg(activityId)
	return self.fire_dimension_challenge_activity[activityId]
end

function FireDimensionConfig:getBigStageCfgList(activityId)
	return self.fire_dimension_challenge_stage[activityId]
end

function FireDimensionConfig:getBigStageCfg(activityId, stageId)
	return self.fire_dimension_challenge_stage[activityId] and self.fire_dimension_challenge_stage[activityId][stageId]
end

function FireDimensionConfig:getSmallStageCfgList(activityId, stageId)
	return self.fire_dimension_challenge_team[activityId] and self.fire_dimension_challenge_team[activityId][stageId]
end

function FireDimensionConfig:getSmallStageCfg(activityId, stageId, teamId)
	return self.fire_dimension_challenge_team[activityId] and self.fire_dimension_challenge_team[activityId][stageId] and self.fire_dimension_challenge_team[activityId][stageId][teamId]
end

function FireDimensionConfig:getBigStagePrizeCfgList(activityId, stageId)
	return self.fire_dimension_challenge_stage_prize[activityId] and self.fire_dimension_challenge_stage_prize[activityId][stageId]
end

function FireDimensionConfig:getBigStagePrizeCfg(activityId, stageId, num)
	return self.fire_dimension_challenge_stage_prize[activityId] and self.fire_dimension_challenge_stage_prize[activityId][stageId] and self.fire_dimension_challenge_stage_prize[activityId][stageId][num]
end

function FireDimensionConfig:getBuffCfg(buffId)
	return self.fire_dimension_challenge_buff[buffId]
end

function FireDimensionConfig:getMonsterCfg(creepsMasterId)
	return self.fire_dimension_challenge_monster[creepsMasterId]
end

function FireDimensionConfig:getCreepsCfgList(creepsMasterId)
	return self.fire_dimension_challenge_creeps[creepsMasterId]
end

function FireDimensionConfig:getDailyBuffCfg(activityId, level)
	if self.fire_dimension_challenge_sign_in_buff[activityId] then
		return self.fire_dimension_challenge_sign_in_buff[activityId][level]
	end
end

FireDimensionConfig.instance = FireDimensionConfig.New()

return FireDimensionConfig
