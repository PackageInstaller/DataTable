-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crazypartner/config/CrazyPartnerConfig.lua

module("logic.extensions.crazypartner.config.CrazyPartnerConfig", package.seeall)

local CrazyPartnerConfig = class("CrazyPartnerConfig", BaseConfig)

CrazyPartnerConfig.RankTypeDefine = {
	Total = 2,
	Daily = 1
}
CrazyPartnerConfig.SequenceBuffType = 2
CrazyPartnerConfig.TaskType_1 = 1
CrazyPartnerConfig.TaskType_4 = 4
CrazyPartnerConfig.RuleUserSetKey = "20220429.CrazyPartnerRuleView"

function CrazyPartnerConfig:onInit()
	CrazyPartnerConfig.super.onInit(self)

	self._crazy_partner_common = nil
	self._crazy_partner_prize = nil
	self._crazy_partner_layout = nil
	self._crazy_partner_challenge = nil
	self._crazy_partner_damage = nil
	self._crazy_partner_team = nil
	self._crazy_partner_creeps = nil
	self._crazy_partner_support = nil
	self._crazy_partner_buff = nil
	self._crazy_partner_task = nil
	self._crazy_partner_racdids = nil
end

function CrazyPartnerConfig:getNames()
	return {
		"crazy_partner_common",
		"crazy_partner_prize",
		"crazy_partner_layout",
		"crazy_partner_challenge",
		"crazy_partner_damage",
		"crazy_partner_team",
		"crazy_partner_creeps",
		"crazy_partner_support",
		"crazy_partner_buff",
		"crazy_partner_task",
		"crazy_partner_racdids"
	}
end

function CrazyPartnerConfig:handleConfig(name, content)
	if name == "crazy_partner_common" then
		self._crazy_partner_common = content
	elseif name == "crazy_partner_prize" then
		self._crazy_partner_prize = content
	elseif name == "crazy_partner_layout" then
		self._crazy_partner_layout = content
	elseif name == "crazy_partner_challenge" then
		self._crazy_partner_challenge = content
	elseif name == "crazy_partner_damage" then
		self._crazy_partner_damage = content
	elseif name == "crazy_partner_team" then
		self._crazy_partner_team = content
	elseif name == "crazy_partner_creeps" then
		self._crazy_partner_creeps = content
	elseif name == "crazy_partner_support" then
		self._crazy_partner_support = content
	elseif name == "crazy_partner_buff" then
		self._crazy_partner_buff = content
	elseif name == "crazy_partner_task" then
		self._crazy_partner_task = content
	elseif name == "crazy_partner_racdids" then
		self._crazy_partner_racdids = content
	end
end

function CrazyPartnerConfig:getCommonValue(key)
	local conf = self._crazy_partner_common[key]

	if conf then
		return conf.value
	end

	return ""
end

function CrazyPartnerConfig:getActCfg()
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.CRAZY_PARTNER)

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			return item
		end
	end

	return nil
end

function CrazyPartnerConfig:getActId()
	local cfg = self:getActCfg()

	if cfg then
		return cfg.activityId
	end

	return -2
end

function CrazyPartnerConfig:getChallengeId()
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.CRAZY_PARTNER)
	local itemTarget

	for i, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			itemTarget = item

			break
		end
	end

	local startDateTime = GameUtil.string2time(itemTarget.startTime)
	local nowDateTime = ServerTime.now()
	local day = GameUtil.getDaysByTimestamp(startDateTime, nowDateTime)

	if day <= 0 then
		day = 1
	end

	print("day................." .. tostring(day))

	local conf = self._crazy_partner_layout[itemTarget.activityId][day]

	if conf then
		return conf.challengeId
	end

	return -1
end

function CrazyPartnerConfig:getPlanConf(challengeId, difficultyId)
	local confs = self._crazy_partner_challenge[challengeId]

	if confs then
		return confs[difficultyId]
	end

	return nil
end

function CrazyPartnerConfig:getDamageConfs(planId)
	return self._crazy_partner_damage[planId]
end

function CrazyPartnerConfig:getPrizeConfs(activityId)
	return self._crazy_partner_prize[activityId]
end

function CrazyPartnerConfig:getPrizeConfByIndex(activityId, index)
	return self._crazy_partner_prize[activityId][index]
end

function CrazyPartnerConfig:getTeamConfs(creepsMasterId)
	return self._crazy_partner_team[creepsMasterId]
end

function CrazyPartnerConfig:getTeamCreeps(creepsMasterId)
	return self._crazy_partner_creeps[creepsMasterId]
end

function CrazyPartnerConfig:getSupportConfs(systemPetPlanId)
	return self._crazy_partner_support[systemPetPlanId]
end

function CrazyPartnerConfig:getBuffConf(buffId)
	return self._crazy_partner_buff[buffId]
end

function CrazyPartnerConfig:getTaskConfs()
	local challengeId = self:getChallengeId()
	local challengeConfs = self._crazy_partner_challenge[challengeId]
	local tasks = {}

	for _, conf in ipairs(challengeConfs) do
		local taskId = conf.taskId
		local taskConf = self._crazy_partner_task[taskId]

		if taskConf then
			table.insert(tasks, {
				difficulty = conf.difficulty,
				conf = taskConf
			})
		end
	end

	return tasks
end

function CrazyPartnerConfig:getTaskConfMap()
	local tasks = self:getTaskConfs()
	local map = {}

	for _, conf in ipairs(tasks) do
		map[conf.difficulty] = conf
	end

	return map
end

function CrazyPartnerConfig:getLevelRaceIdsConf()
	local challengeId = self:getChallengeId()

	return self._crazy_partner_racdids[challengeId]
end

CrazyPartnerConfig.instance = CrazyPartnerConfig.New()

return CrazyPartnerConfig
