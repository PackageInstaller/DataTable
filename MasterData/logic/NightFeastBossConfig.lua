-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nightfeastbosschallenge/config/NightFeastBossConfig.lua

module("logic.extensions.nightfeastbosschallenge.config.NightFeastBossConfig", package.seeall)

local NightFeastBossConfig = class("NightFeastBossConfig", BaseConfig)

function NightFeastBossConfig:onInit()
	NightFeastBossConfig.super.onInit(self)

	self.night_feast_boss_clg_activity = nil
	self.night_feast_boss_clg_daily_stage = nil
	self.night_feast_boss_clg_buff = nil
	self.night_feast_boss_clg_progress = nil
	self.night_feast_boss_clg_rank = nil
	self.night_feast_boss_clg_monster = nil
	self.night_feast_boss_clg_creeps = nil
	self.night_feast_boss_common = nil
end

function NightFeastBossConfig:getNames()
	return {
		"night_feast_boss_clg_activity",
		"night_feast_boss_clg_daily_stage",
		"night_feast_boss_clg_buff",
		"night_feast_boss_clg_progress",
		"night_feast_boss_clg_rank",
		"night_feast_boss_clg_monster",
		"night_feast_boss_clg_creeps",
		"night_feast_boss_common",
		"night_feast_boss_clg_boss"
	}
end

function NightFeastBossConfig:handleConfig(name, content)
	if name == "night_feast_boss_clg_activity" then
		self.night_feast_boss_clg_activity = content
	elseif name == "night_feast_boss_clg_daily_stage" then
		self.night_feast_boss_clg_daily_stage = content
	elseif name == "night_feast_boss_clg_buff" then
		self.night_feast_boss_clg_buff = content
	elseif name == "night_feast_boss_clg_progress" then
		self.night_feast_boss_clg_progress = content
	elseif name == "night_feast_boss_clg_rank" then
		self.night_feast_boss_clg_rank = content
	elseif name == "night_feast_boss_clg_monster" then
		self.night_feast_boss_clg_monster = content
	elseif name == "night_feast_boss_clg_creeps" then
		self.night_feast_boss_clg_creeps = content
	elseif name == "night_feast_boss_common" then
		self.night_feast_boss_common = content
	elseif name == "night_feast_boss_clg_boss" then
		self.night_feast_boss_clg_boss = content
	end
end

function NightFeastBossConfig:getActivityCfg(activityId)
	return self.night_feast_boss_clg_activity[activityId]
end

function NightFeastBossConfig:getDailyStageCfg(activityId, stageId)
	return self.night_feast_boss_clg_daily_stage[activityId] and self.night_feast_boss_clg_daily_stage[activityId][stageId]
end

function NightFeastBossConfig:getBuffCfgsList(activityId)
	return self.night_feast_boss_clg_buff[activityId]
end

function NightFeastBossConfig:getBuffCfg(activityId, buffId, buffLvl)
	return self.night_feast_boss_clg_buff[activityId] and self.night_feast_boss_clg_buff[activityId][buffId] and self.night_feast_boss_clg_buff[activityId][buffId][buffLvl]
end

function NightFeastBossConfig:getProgressList(planId)
	return self.night_feast_boss_clg_progress[planId]
end

function NightFeastBossConfig:getRankList(planId)
	return self.night_feast_boss_clg_rank[planId]
end

function NightFeastBossConfig:getMonster(creepsMasterId)
	return self.night_feast_boss_clg_monster[creepsMasterId]
end

function NightFeastBossConfig:getCreeps(creepsMasterId)
	return self.night_feast_boss_clg_creeps[creepsMasterId]
end

function NightFeastBossConfig:getCommonValue(key)
	return self.night_feast_boss_common[key] and self.night_feast_boss_common[key].value
end

function NightFeastBossConfig:getBossCfg(activityId, bossId)
	if self.night_feast_boss_clg_boss[activityId] then
		return self.night_feast_boss_clg_boss[activityId][bossId]
	end
end

function NightFeastBossConfig:getBossCfgsList(activityId)
	return self.night_feast_boss_clg_boss[activityId]
end

NightFeastBossConfig.instance = NightFeastBossConfig.New()

return NightFeastBossConfig
