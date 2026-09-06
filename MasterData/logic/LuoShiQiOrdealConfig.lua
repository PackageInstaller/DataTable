-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luoshiqiordeal/config/LuoShiQiOrdealConfig.lua

module("logic.extensions.luoshiqiordeal.config.LuoShiQiOrdealConfig", package.seeall)

local LuoShiQiOrdealConfig = class("LuoShiQiOrdealConfig", BaseConfig)

function LuoShiQiOrdealConfig:onInit()
	LuoShiQiOrdealConfig.super.onInit(self)

	self.xiao_nuo_birthday_activity = nil
	self.xiao_nuo_birthday_normal_game = nil
	self.xiao_nuo_birthday_crazy_game = nil
	self.xiao_nuo_birthday_crazy_score_plan = nil
	self.xiao_nuo_birthday_stage = nil
	self.xiao_nuo_birthday_game_progress = nil
	self.xiao_nuo_birthday_rank_normal = nil
	self.xiao_nuo_birthday_rank_crazy = nil
	self.xiao_nuo_birthday_rank_rule = nil
end

function LuoShiQiOrdealConfig:getNames()
	return {
		"xiao_nuo_birthday_activity",
		"xiao_nuo_birthday_normal_game",
		"xiao_nuo_birthday_crazy_game",
		"xiao_nuo_birthday_crazy_score_plan",
		"xiao_nuo_birthday_stage",
		"xiao_nuo_birthday_game_progress",
		"xiao_nuo_birthday_rank_normal",
		"xiao_nuo_birthday_rank_crazy",
		"xiao_nuo_birthday_rank_rule"
	}
end

function LuoShiQiOrdealConfig:handleConfig(name, content)
	if name == "xiao_nuo_birthday_activity" then
		self.xiao_nuo_birthday_activity = content
	elseif name == "xiao_nuo_birthday_normal_game" then
		self.xiao_nuo_birthday_normal_game = content
	elseif name == "xiao_nuo_birthday_crazy_game" then
		self.xiao_nuo_birthday_crazy_game = content
	elseif name == "xiao_nuo_birthday_crazy_score_plan" then
		self.xiao_nuo_birthday_crazy_score_plan = content
	elseif name == "xiao_nuo_birthday_stage" then
		self.xiao_nuo_birthday_stage = content
	elseif name == "xiao_nuo_birthday_game_progress" then
		self.xiao_nuo_birthday_game_progress = content
	elseif name == "xiao_nuo_birthday_rank_normal" then
		self.xiao_nuo_birthday_rank_normal = content
	elseif name == "xiao_nuo_birthday_rank_crazy" then
		self.xiao_nuo_birthday_rank_crazy = content
	elseif name == "xiao_nuo_birthday_rank_rule" then
		self.xiao_nuo_birthday_rank_rule = content
	end
end

function LuoShiQiOrdealConfig:getActivityCfg(activityId)
	return self.xiao_nuo_birthday_activity[activityId]
end

function LuoShiQiOrdealConfig:getNormalGameCfg(activityId, diffLvId)
	if self.xiao_nuo_birthday_normal_game[activityId] then
		return self.xiao_nuo_birthday_normal_game[activityId][diffLvId]
	end
end

function LuoShiQiOrdealConfig:getCrazyGameCfg(activityId)
	return self.xiao_nuo_birthday_crazy_game[activityId]
end

function LuoShiQiOrdealConfig:getCrazyScorePlanCfgList(crazyScorePlan)
	return self.xiao_nuo_birthday_crazy_score_plan[crazyScorePlan] or {}
end

function LuoShiQiOrdealConfig:getCrazyScorePlan(crazyScorePlan, passStage)
	if self.xiao_nuo_birthday_crazy_score_plan[crazyScorePlan] then
		return self.xiao_nuo_birthday_crazy_score_plan[crazyScorePlan][passStage]
	end
end

function LuoShiQiOrdealConfig:getStageCfgList(stageGroupId)
	return self.xiao_nuo_birthday_stage[stageGroupId] or {}
end

function LuoShiQiOrdealConfig:getStageCfg(stageGroupId, stageId)
	if self.xiao_nuo_birthday_stage[stageGroupId] then
		return self.xiao_nuo_birthday_stage[stageGroupId][stageId]
	end
end

function LuoShiQiOrdealConfig:getGameProgressCfgList(gamePrizePlan)
	return self.xiao_nuo_birthday_game_progress[gamePrizePlan] or {}
end

function LuoShiQiOrdealConfig:getGameProgressCfg(gamePrizePlan, prizeId)
	if self.xiao_nuo_birthday_game_progress[gamePrizePlan] then
		return self.xiao_nuo_birthday_game_progress[gamePrizePlan][prizeId]
	end
end

function LuoShiQiOrdealConfig:getRankNormalCfg(activityId)
	return self.xiao_nuo_birthday_rank_normal[activityId]
end

function LuoShiQiOrdealConfig:getRankCrazyCfg(activityId)
	return self.xiao_nuo_birthday_rank_crazy[activityId]
end

function LuoShiQiOrdealConfig:getRuleCfgList()
	return self.xiao_nuo_birthday_rank_rule.dataList
end

LuoShiQiOrdealConfig.instance = LuoShiQiOrdealConfig.New()

return LuoShiQiOrdealConfig
