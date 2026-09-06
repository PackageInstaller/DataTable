-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterhopeclg/config/SummonMasterHopeClgConfig.lua

module("logic.extensions.summonmasterhopeclg.config.SummonMasterHopeClgConfig", package.seeall)

local SummonMasterHopeClgConfig = class("SummonMasterHopeClgConfig", BaseConfig)

function SummonMasterHopeClgConfig:onInit()
	SummonMasterHopeClgConfig.super.onInit(self)
end

function SummonMasterHopeClgConfig:getNames()
	return {
		"summon_master_hope_clg",
		"summon_master_hope_clg_stage",
		"summon_master_hope_common",
		"summon_master_hope_clg_creeps_master",
		"summon_master_hope_clg_creeps",
		"summon_master_hope_clg_tag_rule",
		"summon_master_hope_clg_daily_balance"
	}
end

function SummonMasterHopeClgConfig:handleConfig(name, content)
	if name == "summon_master_hope_clg" then
		self.summon_master_hope_clg = content
	elseif name == "summon_master_hope_clg_stage" then
		self.summon_master_hope_clg_stage = content
	elseif name == "summon_master_hope_common" then
		self.summon_master_hope_common = content
	elseif name == "summon_master_hope_clg_creeps_master" then
		self.summon_master_hope_clg_creeps_master = content
	elseif name == "summon_master_hope_clg_creeps" then
		self.summon_master_hope_clg_creeps = content
	elseif name == "summon_master_hope_clg_tag_rule" then
		self.summon_master_hope_clg_tag_rule = content
	elseif name == "summon_master_hope_clg_daily_balance" then
		self.summon_master_hope_clg_daily_balance = content
	end
end

function SummonMasterHopeClgConfig:getSMHClgData(activityId)
	return self.summon_master_hope_clg[activityId]
end

function SummonMasterHopeClgConfig:getSMHClgStageData(activityId, stageId)
	return self.summon_master_hope_clg_stage[activityId][stageId]
end

function SummonMasterHopeClgConfig:getCommonData(activityId)
	local comPlanId = self.summon_master_hope_clg[activityId].comPlanId

	return self.summon_master_hope_common[comPlanId]
end

function SummonMasterHopeClgConfig:getSMHClgCreepsMasterData(creepsMasterId)
	return self.summon_master_hope_clg_creeps_master[creepsMasterId]
end

function SummonMasterHopeClgConfig:getSMHClgCreepsData(creepsMasterId)
	return self.summon_master_hope_clg_creeps[creepsMasterId]
end

function SummonMasterHopeClgConfig:getSMHClgTagRuleData(activityId)
	return self.summon_master_hope_clg_tag_rule[activityId]
end

function SummonMasterHopeClgConfig:getSMHClgTagDailyBalanceData(activityId)
	return self.summon_master_hope_clg_daily_balance[activityId]
end

function SummonMasterHopeClgConfig:getStageNum(activityId)
	return #self.summon_master_hope_clg_stage[activityId]
end

function SummonMasterHopeClgConfig:getCreepsMasterId(activityId, stageId)
	return self.summon_master_hope_clg_stage[activityId][stageId].creepsMasterId
end

function SummonMasterHopeClgConfig:getCommonValue(activityId, key)
	local comPlanId = self.summon_master_hope_clg[activityId].comPlanId

	return self.summon_master_hope_common[comPlanId][key]
end

function SummonMasterHopeClgConfig:getScoresArr(activityId)
	local arr = {
		0,
		0
	}

	arr[1] = self:getCommonValue(activityId, "godRankScore")
	arr[2] = self:getCommonValue(activityId, "dailyRankScore")

	return arr
end

function SummonMasterHopeClgConfig:getDataRange(activityId)
	local dailyBalanceData = self.summon_master_hope_clg_daily_balance[activityId]

	if not dailyBalanceData[1].dateRange then
		return string.split(dailyBalanceData[1].dateRange, "#") or {}
	end
end

SummonMasterHopeClgConfig.instance = SummonMasterHopeClgConfig.New()

return SummonMasterHopeClgConfig
