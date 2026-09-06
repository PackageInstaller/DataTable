-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/config/FamilyCallOrderConfig.lua

module("logic.extensions.newfamily.config.FamilyCallOrderConfig", package.seeall)

local FamilyCallOrderConfig = class("FamilyCallOrderConfig", BaseConfig)

function FamilyCallOrderConfig:onInit()
	FamilyCallOrderConfig.super.onInit(self)
end

function FamilyCallOrderConfig:getNames()
	return {
		"family_summon_command",
		"family_summon_command_rank_prize",
		"family_summon_command_progress_prize"
	}
end

function FamilyCallOrderConfig:handleConfig(name, content)
	if name == "family_summon_command" then
		self._family_summon_command = content
	elseif name == "family_summon_command_rank_prize" then
		self._family_summon_command_rank_prize = content
	elseif name == "family_summon_command_progress_prize" then
		self._family_summon_command_progress_prize = content
	end
end

function FamilyCallOrderConfig:getActivityDataById(activityId)
	if self._family_summon_command then
		return self._family_summon_command[activityId]
	end

	return {}
end

function FamilyCallOrderConfig:getRewardCfgById(plandId)
	if self._family_summon_command_rank_prize then
		return self._family_summon_command_rank_prize[plandId]
	end

	return nil
end

function FamilyCallOrderConfig:getProgressCfgById(plandId)
	if self._family_summon_command_progress_prize then
		return self._family_summon_command_progress_prize[plandId]
	end

	return nil
end

function FamilyCallOrderConfig:getProgressPrizeCfgById(plandId, prizeid)
	if self._family_summon_command_progress_prize then
		return self._family_summon_command_progress_prize[plandId][prizeid].score
	end

	return nil
end

function FamilyCallOrderConfig:getPrizeCfgById(plandId)
	for k, v in ipairs(self:getRewardCfgById(plandId)) do
		print(v.prize)
	end
end

function FamilyCallOrderConfig:getPrizeMaxScore(plandId)
	local cfg = self._family_summon_command_progress_prize[plandId]
	local maxScore

	if cfg then
		for i, v in ipairs(cfg) do
			maxScore = v.score
		end
	end

	return maxScore
end

function FamilyCallOrderConfig:getOpenActivityId()
	if self._family_summon_command == nil then
		return -1
	end

	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.CallOrder)

	if cfgs == nil then
		return -2
	end

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			return item.activityId
		end
	end

	return -3
end

function FamilyCallOrderConfig:getPlanIdInfo()
	local activityId = FamilyCallOrderConfig.instance:getOpenActivityId()

	if checknumber(activityId) <= 0 then
		activityId = 149001

		printError("没有获取到活动id哦！！！！！！！！")
	end

	return FamilyCallOrderConfig.instance:getActivityDataById(activityId)
end

FamilyCallOrderConfig.instance = FamilyCallOrderConfig.New()

return FamilyCallOrderConfig
