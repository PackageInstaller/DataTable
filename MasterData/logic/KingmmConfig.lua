-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmengmeng/config/KingmmConfig.lua

module("logic.extensions.kingmengmeng.config.KingmmConfig", package.seeall)

local KingmmConfig = class("KingmmConfig", BaseConfig)

function KingmmConfig:onInit()
	KingmmConfig.super.onInit(self)

	self.king_meng_meng_challenge = nil
	self.king_meng_meng_challenge_score_prize = nil
	self.king_meng_meng_challenge_buff = nil
	self.king_meng_meng_challenge_form_check = nil
	self.king_meng_meng_challenge_pass_condition = nil
	self.king_meng_meng_challenge_form = nil
	self.king_meng_meng_challenge_master = nil
	self.king_meng_meng_challenge_creeps = nil
	self.king_meng_meng_challenge_damage_score = nil
	self.king_meng_meng_challenge_reset_cost = nil
	self.king_meng_meng_challenge_element_stage = nil
	self.king_meng_meng_challenge_guard_stage = nil
end

function KingmmConfig:getNames()
	return {
		"king_meng_meng_challenge",
		"king_meng_meng_challenge_score_prize",
		"king_meng_meng_challenge_buff",
		"king_meng_meng_challenge_form_check",
		"king_meng_meng_challenge_pass_condition",
		"king_meng_meng_challenge_form",
		"king_meng_meng_challenge_master",
		"king_meng_meng_challenge_creeps",
		"king_meng_meng_challenge_damage_score",
		"king_meng_meng_challenge_reset_cost",
		"king_meng_meng_challenge_element_stage",
		"king_meng_meng_challenge_guard_stage"
	}
end

function KingmmConfig:handleConfig(name, content)
	if name == "king_meng_meng_challenge" then
		self.king_meng_meng_challenge = content
	elseif name == "king_meng_meng_challenge_score_prize" then
		self.king_meng_meng_challenge_score_prize = content
	elseif name == "king_meng_meng_challenge_buff" then
		self.king_meng_meng_challenge_buff = content
	elseif name == "king_meng_meng_challenge_form_check" then
		self.king_meng_meng_challenge_form_check = content
	elseif name == "king_meng_meng_challenge_pass_condition" then
		self.king_meng_meng_challenge_pass_condition = content
	elseif name == "king_meng_meng_challenge_form" then
		self.king_meng_meng_challenge_form = content
	elseif name == "king_meng_meng_challenge_master" then
		self.king_meng_meng_challenge_master = content
	elseif name == "king_meng_meng_challenge_creeps" then
		self.king_meng_meng_challenge_creeps = content
	elseif name == "king_meng_meng_challenge_damage_score" then
		self.king_meng_meng_challenge_damage_score = content
	elseif name == "king_meng_meng_challenge_reset_cost" then
		self.king_meng_meng_challenge_reset_cost = content
	elseif name == "king_meng_meng_challenge_element_stage" then
		self.king_meng_meng_challenge_element_stage = content
	elseif name == "king_meng_meng_challenge_guard_stage" then
		self.king_meng_meng_challenge_guard_stage = content
	end
end

function KingmmConfig:getActivityCfg(activityId)
	return self.king_meng_meng_challenge[activityId]
end

function KingmmConfig:getScorePrizeList(activityId)
	return self.king_meng_meng_challenge_score_prize[activityId] or {}
end

function KingmmConfig:getMonsterCfg(creepsMasterId)
	return self.king_meng_meng_challenge_master[creepsMasterId]
end

function KingmmConfig:getCreepsCfgList(creepsMasterId)
	return self.king_meng_meng_challenge_creeps[creepsMasterId]
end

function KingmmConfig:getBuffCfg(activityId, buffId)
	return self.king_meng_meng_challenge_buff[activityId] and self.king_meng_meng_challenge_buff[activityId][buffId]
end

function KingmmConfig:getFormCfg(activityId, formId)
	return self.king_meng_meng_challenge_form[activityId] and self.king_meng_meng_challenge_form[activityId][formId]
end

function KingmmConfig:getConditionCfg(activityId, conditionId)
	return self.king_meng_meng_challenge_pass_condition[activityId] and self.king_meng_meng_challenge_pass_condition[activityId][conditionId]
end

function KingmmConfig:getResetCfgList(activityId)
	return self.king_meng_meng_challenge_reset_cost[activityId] or {}
end

function KingmmConfig:getResetCfg(activityId, times)
	return self.king_meng_meng_challenge_reset_cost[activityId] and self.king_meng_meng_challenge_reset_cost[activityId][times]
end

function KingmmConfig:getElementCfgList(activityId)
	return self.king_meng_meng_challenge_element_stage[activityId] or {}
end

function KingmmConfig:getGuardCfgList(activityId)
	return self.king_meng_meng_challenge_guard_stage[activityId] or {}
end

KingmmConfig.instance = KingmmConfig.New()

return KingmmConfig
