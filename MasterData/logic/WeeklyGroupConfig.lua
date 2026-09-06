-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weeklygroup/config/WeeklyGroupConfig.lua

module("logic.extensions.weeklygroup.config.WeeklyGroupConfig", package.seeall)

local WeeklyGroupConfig = class("WeeklyGroupConfig", BaseConfig)

function WeeklyGroupConfig:onInit()
	WeeklyGroupConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function WeeklyGroupConfig:getNames()
	return {
		"weekly_group",
		"weekly_group_prize",
		"weekly_group_team_rank_prize",
		"weekly_group_person_rank_prize",
		"weekly_group_person_prize"
	}
end

function WeeklyGroupConfig:handleConfig(name, content)
	if name == "weekly_group" then
		self._weekly_groupCfg = content
	elseif name == "weekly_group_prize" then
		self._weekly_group_prizeCfg = content
	elseif name == "weekly_group_team_rank_prize" then
		self._weekly_group_teamCfg = content
	elseif name == "weekly_group_person_rank_prize" then
		self._weekly_group_PersonCfg = content
	elseif name == "weekly_group_person_prize" then
		self._weekly_group_person_prizeCfg = content
	end
end

function WeeklyGroupConfig:getWeeklyGroupCfgById(activityId)
	return self._weekly_groupCfg[activityId]
end

function WeeklyGroupConfig:getPrizeCfg(activityId)
	return self._weekly_group_prizeCfg[activityId]
end

function WeeklyGroupConfig:getPrizeCfgById(activityId, prizeId)
	return self._weekly_group_prizeCfg[activityId][prizeId]
end

function WeeklyGroupConfig:getPersonPrizeCfg(activityId)
	return self._weekly_group_person_prizeCfg[activityId]
end

function WeeklyGroupConfig:getPersonPrizeCfgById(activityId, prizeId)
	return self._weekly_group_person_prizeCfg[activityId][prizeId]
end

function WeeklyGroupConfig:getPrizeScoreList(activityId)
	local scoreList = {}

	for _, v in ipairs(self._weekly_group_prizeCfg[activityId]) do
		table.insert(scoreList, v.needItemCount)
	end

	return scoreList
end

function WeeklyGroupConfig:getPersonPrizeScoreList(activityId)
	local scoreList = {}

	for _, v in ipairs(self._weekly_group_person_prizeCfg[activityId]) do
		table.insert(scoreList, v.needItemCount)
	end

	return scoreList
end

function WeeklyGroupConfig:getTeamCfgById(activityId)
	return self._weekly_group_teamCfg[activityId]
end

function WeeklyGroupConfig:getPersonCfgById(activityId)
	return self._weekly_group_PersonCfg[activityId]
end

function WeeklyGroupConfig:getTeamPrizeByRank(actId, rank)
	local cfg = self:getTeamCfgById(actId)

	for _, v in pairs(cfg) do
		local min = v.rankRange[1]
		local max = v.rankRange[#v.rankRange]

		if min <= rank and rank <= max then
			return v.rankPrize
		end
	end

	return cfg[#cfg].rankPrize
end

function WeeklyGroupConfig:getPersonPrizeByRank(actId, rank)
	local cfg = self:getPersonCfgById(actId)

	for _, v in pairs(cfg) do
		local min = v.rankRange[1]
		local max = v.rankRange[#v.rankRange]

		if min <= rank and rank <= max then
			return v.rankPrize
		end
	end

	return cfg[#cfg].rankPrize
end

WeeklyGroupConfig.instance = WeeklyGroupConfig.New()

return WeeklyGroupConfig
