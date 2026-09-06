-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/config/DragonLordsConfig.lua

module("logic.extensions.dragonlords.config.DragonLordsConfig", package.seeall)

local DragonLordsConfig = class("DragonLordsConfig", BaseConfig)

function DragonLordsConfig:onInit()
	DragonLordsConfig.super.onInit(self)
end

function DragonLordsConfig:getNames()
	return {
		"dragon_respect_challenge_activity",
		"dragon_respect_challenge_universal",
		"dragon_respect_challenge_creeps",
		"dragon_respect_challenge_extreme",
		"dragon_respect_challenge_universal_stage",
		"dragon_respect_challenge_universal_team",
		"dragon_respect_challenge_buff",
		"dragon_respect_challenge_fusion_common",
		"dragon_respect_challenge_monster",
		"dragon_respect_challenge_helper",
		"dragon_respect_challenge_fusion_prize_pool",
		"dragon_respect_challenge_universal_stage_plan"
	}
end

function DragonLordsConfig:handleConfig(name, content)
	if name == "dragon_respect_challenge_activity" then
		self._dragon_respect_challenge_activity = content
	elseif name == "dragon_respect_challenge_universal" then
		self._dragon_respect_challenge_universal = content
	elseif name == "dragon_respect_challenge_creeps" then
		self._dragon_respect_challenge_creeps = content
	elseif name == "dragon_respect_challenge_extreme" then
		self._dragon_respect_challenge_extreme = content
	elseif name == "dragon_respect_challenge_universal_stage" then
		self._dragon_respect_challenge_universal_stage = content
	elseif name == "dragon_respect_challenge_universal_team" then
		self._dragon_respect_challenge_universal_team = content
	elseif name == "dragon_respect_challenge_buff" then
		self._dragon_respect_challenge_buff = content
	elseif name == "dragon_respect_challenge_fusion_common" then
		self._dragon_respect_challenge_fusion_common = content
	elseif name == "dragon_respect_challenge_monster" then
		self._dragon_respect_challenge_monster = content
	elseif name == "dragon_respect_challenge_helper" then
		self._dragon_respect_challenge_helper = content
	elseif name == "dragon_respect_challenge_fusion_prize_pool" then
		self._dragon_respect_challenge_fusion_prize_pool = content
	elseif name == "dragon_respect_challenge_universal_stage_plan" then
		self._dragon_respect_challenge_universal_stage_plan = content
	end
end

function DragonLordsConfig:getCfgById(id)
	return self._dragon_respect_challenge_activity[id]
end

function DragonLordsConfig:getOpenActivityId()
	if self._dragon_respect_challenge_activity == nil then
		return self:actTime(-1)
	end

	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.DragonLords)

	if cfgs == nil then
		return self:actTime(-2)
	end

	for _, item in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.DragonLords, item.activityId) then
			return item.activityId
		end
	end

	return self:actTime(-3)
end

function DragonLordsConfig:actTime(key)
	printError("lbc=======(-1:没有拿到活动表，表可能为空；-2:y运营-活动时间(改)这个表有问题，没有对应的活动类型；-3:没有在活动时间)     活动id:", key)

	return key
end

function DragonLordsConfig:getActivityCfg()
	local actid = self:getOpenActivityId()

	return (self:getCfgById(actid))
end

function DragonLordsConfig:getAllPeopleChallengeInfo()
	local actCfg = self:getActivityCfg()

	if actCfg and self._dragon_respect_challenge_universal[actCfg.universalChallengePlanId] then
		return self._dragon_respect_challenge_universal[actCfg.universalChallengePlanId]
	end

	return {}
end

function DragonLordsConfig:getCreepsMasterById(creepsMasterId)
	return self._dragon_respect_challenge_creeps[creepsMasterId]
end

function DragonLordsConfig:getLimitChallengeCfg(index)
	local actCfg = self:getActivityCfg()

	if actCfg then
		local cfg = self._dragon_respect_challenge_extreme[actCfg.extremeChallengePlanId]

		return cfg[index]
	end

	return {}
end

function DragonLordsConfig:getStagePlanId(index)
	local cfg = self._dragon_respect_challenge_universal_stage_plan[index]

	if self._stagePlanList == nil then
		self._stagePlanList = {}
	end

	if self._stagePlanList[index] == nil then
		self._stagePlanList[index] = {}

		for k, v in pairs(cfg) do
			table.insert(self._stagePlanList[index], v)
		end

		ArraySort.sortOn(self._stagePlanList[index], "index", ArraySort.NUMERIC)
	end

	for k, v in ipairs(self._stagePlanList[index]) do
		local times = string.split(v.openTime, "#")

		if GameUtil.checkIsInTimePeriod(times[1], times[2]) then
			return v.stagePlanId
		end
	end

	printError("没有拿到在有效时间内的关卡方案")

	return nil
end

function DragonLordsConfig:getNormolStageAllInfo(index)
	local id = self:getStagePlanId(index)

	return self._dragon_respect_challenge_universal_stage[id]
end

function DragonLordsConfig:getNormolStageInfo(index, stageId)
	local id = self:getStagePlanId(index)
	local stageCfg = self._dragon_respect_challenge_universal_stage[id]

	return stageCfg[stageId]
end

function DragonLordsConfig:normolStageIsFinal(index, stageId)
	local id = self:getStagePlanId(index)
	local stageCfg = self._dragon_respect_challenge_universal_stage[id]

	print("lbc================", index, stageId)

	for k, v in pairs(stageCfg) do
		if stageId <= v.stageId then
			return false
		end
	end

	return true
end

function DragonLordsConfig:getteamPlanCfg(teamPlanId, teamId)
	local teamCfg = self._dragon_respect_challenge_universal_team[teamPlanId]

	return teamCfg[teamId]
end

function DragonLordsConfig:getBuffsById(buffId)
	local cfg = self._dragon_respect_challenge_buff.dataList

	if cfg[buffId] then
		return cfg[buffId]
	end

	return {}
end

function DragonLordsConfig:getBuffs(planId)
	local list = {}

	if self._dragon_respect_challenge_buff[planId] then
		for k, v in pairs(self._dragon_respect_challenge_buff[planId]) do
			table.insert(list, v)
		end

		return list
	end

	return {}
end

function DragonLordsConfig:getCommonCfg(key)
	if self._dragon_respect_challenge_fusion_common[key] then
		return self._dragon_respect_challenge_fusion_common[key].value
	end

	return ""
end

function DragonLordsConfig:getTeamData(creepsMasterId)
	return self._dragon_respect_challenge_monster[creepsMasterId]
end

function DragonLordsConfig:getSupPet(helpPetPlanId)
	return self._dragon_respect_challenge_helper[helpPetPlanId]
end

function DragonLordsConfig:getPrizeCfg(planId, prizeId)
	if self._dragon_respect_challenge_fusion_prize_pool[planId] then
		return self._dragon_respect_challenge_fusion_prize_pool[planId][prizeId]
	end
end

DragonLordsConfig.instance = DragonLordsConfig.New()

return DragonLordsConfig
