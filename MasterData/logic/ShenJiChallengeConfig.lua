-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/config/ShenJiChallengeConfig.lua

module("logic.extensions.shenjichallenge.config.ShenJiChallengeConfig", package.seeall)

local ShenJiChallengeConfig = class("ShenJiChallengeConfig", BaseConfig)

function ShenJiChallengeConfig:onInit()
	ShenJiChallengeConfig.super.onInit(self)

	self.shen_ji_challenge = nil
	self.shen_ji_challenge_select_stage = nil
	self.shen_ji_challenge_buff = nil
	self.shen_ji_challenge_boss = nil
	self.shen_ji_master = nil
	self.shen_ji_creeps = nil
	self.shen_ji_common = nil
	self.shen_ji_rule = nil
end

function ShenJiChallengeConfig:getNames()
	return {
		"shen_ji_challenge",
		"shen_ji_challenge_select_stage",
		"shen_ji_challenge_buff",
		"shen_ji_challenge_boss",
		"shen_ji_master",
		"shen_ji_creeps",
		"shen_ji_common",
		"shen_ji_rule"
	}
end

function ShenJiChallengeConfig:handleConfig(name, content)
	if name == "shen_ji_challenge" then
		self.shen_ji_challenge = content
	elseif name == "shen_ji_challenge_select_stage" then
		self.shen_ji_challenge_select_stage = content
	elseif name == "shen_ji_challenge_buff" then
		self.shen_ji_challenge_buff = content
	elseif name == "shen_ji_challenge_boss" then
		self.shen_ji_challenge_boss = content
	elseif name == "shen_ji_master" then
		self.shen_ji_master = content
	elseif name == "shen_ji_creeps" then
		self.shen_ji_creeps = content
	elseif name == "shen_ji_common" then
		self.shen_ji_common = content
	elseif name == "shen_ji_rule" then
		self.shen_ji_rule = content
	end
end

function ShenJiChallengeConfig:getActivityCfg(id)
	return self.shen_ji_challenge[id]
end

function ShenJiChallengeConfig:getSelectStageList(activityId)
	return self.shen_ji_challenge_select_stage[activityId]
end

function ShenJiChallengeConfig:getSelectStage(activityId, stageId)
	return self.shen_ji_challenge_select_stage[activityId] and self.shen_ji_challenge_select_stage[activityId][stageId]
end

function ShenJiChallengeConfig:getBuffList(activityId)
	return self.shen_ji_challenge_buff[activityId]
end

function ShenJiChallengeConfig:getBuff(activityId, buffId)
	return self.shen_ji_challenge_buff[activityId] and self.shen_ji_challenge_buff[activityId][buffId]
end

function ShenJiChallengeConfig:getBossList(activityId)
	return self.shen_ji_challenge_boss[activityId]
end

function ShenJiChallengeConfig:getBoss(activityId, bossId)
	return self.shen_ji_challenge_boss[activityId] and self.shen_ji_challenge_boss[activityId][bossId]
end

function ShenJiChallengeConfig:getMaster(creepsMasterId)
	return self.shen_ji_master[creepsMasterId]
end

function ShenJiChallengeConfig:getCreeps(creepsMasterId)
	return self.shen_ji_creeps[creepsMasterId]
end

function ShenJiChallengeConfig:getCommonValue(activityId, key)
	if self.shen_ji_challenge[activityId] then
		if self.shen_ji_challenge[activityId] and self.shen_ji_common[self.shen_ji_challenge[activityId]] then
			return self.shen_ji_common[self.shen_ji_challenge[activityId]][key]
		end
	end
end

function ShenJiChallengeConfig:getRuleCfgs(activityId, ruleId)
	return self.shen_ji_rule[activityId] and self.shen_ji_rule[activityId][ruleId]
end

ShenJiChallengeConfig.instance = ShenJiChallengeConfig.New()

return ShenJiChallengeConfig
