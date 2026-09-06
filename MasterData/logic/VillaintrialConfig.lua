-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/villaintrial/config/VillaintrialConfig.lua

module("logic.extensions.villaintrial.config.VillaintrialConfig", package.seeall)

local VillaintrialConfig = class("VillaintrialConfig", BaseConfig)

function VillaintrialConfig:onInit()
	VillaintrialConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function VillaintrialConfig:getNames()
	return {
		"villain_pet_trial_activity",
		"villain_pet_trial_stage",
		"villain_pet_trial_team",
		"villain_pet_trial_creeps",
		"villain_pet_trial_lineups",
		"villain_pet_trial_lineups_pet",
		"villain_pet_trial_spiritLine",
		"villain_pet_trial_prize",
		"villain_pet_trial_pet"
	}
end

function VillaintrialConfig:handleConfig(name, content)
	if name == "villain_pet_trial_activity" then
		self._villain_pet_trial_activity = content
	elseif name == "villain_pet_trial_stage" then
		self._villain_pet_trial_stage = content
	elseif name == "villain_pet_trial_team" then
		self._villain_pet_trial_team = content
	elseif name == "villain_pet_trial_creeps" then
		self._villain_pet_trial_creeps = content
	elseif name == "villain_pet_trial_lineups" then
		self._villain_pet_trial_lineups = content
	elseif name == "villain_pet_trial_lineups_pet" then
		self._villain_pet_trial_lineups_pet = content
	elseif name == "villain_pet_trial_spiritLine" then
		self._villain_pet_trial_spiritLine = content
	elseif name == "villain_pet_trial_prize" then
		self._villain_pet_trial_prize = content
	elseif name == "villain_pet_trial_pet" then
		self._villain_pet_trial_pet = content
	end
end

function VillaintrialConfig:getCfgById(id)
	return self._cofignameCfg[id]
end

function VillaintrialConfig:getPlCreepsCfg(creepsMasterId)
	return self._villain_pet_trial_team[creepsMasterId]
end

function VillaintrialConfig:getVillainPets(teamId)
	return self._villain_pet_trial_lineups_pet[teamId]
end

function VillaintrialConfig:getOpenActivityId(actId)
	return self._villain_pet_trial_activity[actId]
end

function VillaintrialConfig:getProgressCfgById(id)
	return self._villain_pet_trial_prize[id]
end

function VillaintrialConfig:getSpiritLineCfgs(spiritLinePlanId)
	return self._villain_pet_trial_spiritLine[spiritLinePlanId]
end

function VillaintrialConfig:getPetCreeps(creepsMasterId)
	return self._villain_pet_trial_creeps[creepsMasterId]
end

function VillaintrialConfig:getStageCfg(stagePlanId, stageId)
	local cfg = self._villain_pet_trial_stage[stagePlanId]

	if cfg then
		return cfg[stageId]
	end

	return nil
end

function VillaintrialConfig:getSsSupportCfgByCSId(teamId)
	return self._villain_pet_trial_pet[teamId]
end

function VillaintrialConfig:getRandomPets(teamId)
	local cfg = self:getPlanIdInfo()

	if cfg then
		return self._villain_pet_trial_lineups[cfg.lineupsPlanId][teamId].randomPet
	end

	return {}
end

function VillaintrialConfig:getTeamCfg(teamId)
	local cfg = self:getPlanIdInfo()

	if cfg then
		return self._villain_pet_trial_lineups[cfg.lineupsPlanId][teamId]
	end

	return {}
end

function VillaintrialConfig:getProgressPrizeCfgById(plandId, prizeid)
	if self._villain_pet_trial_prize then
		return self._villain_pet_trial_prize[plandId][prizeid].socre
	end

	return nil
end

function VillaintrialConfig:getPrizeMaxScore(plandId)
	local cfg = self._villain_pet_trial_prize[plandId]
	local count = #cfg

	return self._villain_pet_trial_prize[plandId][count].socre
end

function VillaintrialConfig:getOpenActivityId()
	if self._villain_pet_trial_activity == nil then
		return -1
	end

	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.VillainPet)

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

function VillaintrialConfig:getActivityDataById(activityId)
	return self._villain_pet_trial_activity[activityId]
end

function VillaintrialConfig:getPlanIdInfo()
	local activityId = VillaintrialConfig.instance:getOpenActivityId()

	if checknumber(activityId) == -1 then
		activityId = 163001

		printError("-1--没有获取到活动id哦！！！！！！！！临时用163001")
	elseif checknumber(activityId) == -2 then
		activityId = 163001

		printError("-2--没有获取到活动id哦！！！！！！！！临时用163001")
	elseif checknumber(activityId) == -3 then
		activityId = 163001

		printError("-3--没有在活动时间内哦！！！！！！！！临时用163001")
	end

	return VillaintrialConfig.instance:getActivityDataById(activityId)
end

function VillaintrialConfig:getActivityId()
	local activityId = VillaintrialConfig.instance:getOpenActivityId()

	if checknumber(activityId) == -1 then
		activityId = 163001

		printError("-1--没有获取到活动id哦！！！！！！！！临时用163001")
	elseif checknumber(activityId) == -2 then
		activityId = 163001

		printError("-2--没有获取到活动id哦！！！！！！！！临时用163001")
	elseif checknumber(activityId) == -3 then
		activityId = 163001

		printError("-3--没有在活动时间内哦！！！！！！！！临时用163001")
	end

	return activityId
end

VillaintrialConfig.instance = VillaintrialConfig.New()

return VillaintrialConfig
