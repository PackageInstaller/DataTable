-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualdragonchallenge/config/DualdragonchallengeConfig.lua

module("logic.extensions.dualdragonchallenge.config.DualdragonchallengeConfig", package.seeall)

local DualdragonchallengeConfig = class("DualdragonchallengeConfig", BaseConfig)

function DualdragonchallengeConfig:onInit()
	return
end

function DualdragonchallengeConfig:getNames()
	return {
		"dual_dragon_challenge",
		"dual_dragon_universal_boss",
		"dual_dragon_universal_buff",
		"dual_dragon_support_pet",
		"dual_dragon_extreme_stage",
		"dual_dragon_buff",
		"dual_dragon_master",
		"dual_dragon_creeps",
		"dual_dragon_client"
	}
end

function DualdragonchallengeConfig:handleConfig(name, content)
	if name == "dual_dragon_challenge" then
		self._dual_dragon_challenge = content
	elseif name == "dual_dragon_universal_boss" then
		self._dual_dragon_universal_boss = content
	elseif name == "dual_dragon_universal_buff" then
		self._dual_dragon_universal_buff = content
	elseif name == "dual_dragon_support_pet" then
		self._dual_dragon_support_pet = content
	elseif name == "dual_dragon_extreme_stage" then
		self._dual_dragon_extreme_stage = content
	elseif name == "dual_dragon_buff" then
		self._dual_dragon_buff = content
	elseif name == "dual_dragon_master" then
		self._dual_dragon_master = content
	elseif name == "dual_dragon_creeps" then
		self._dual_dragon_creeps = content
	elseif name == "dual_dragon_client" then
		self._dual_dragon_client = content
	end
end

function DualdragonchallengeConfig:getClientValue(key, needNumber)
	local value = self._dual_dragon_client[key].value

	if needNumber then
		return checknumber(value)
	end

	return value
end

function DualdragonchallengeConfig:getShowRaceId(activityId)
	return self._dual_dragon_challenge[activityId].raceId
end

function DualdragonchallengeConfig:getActData(activityId)
	return self._dual_dragon_challenge[activityId]
end

function DualdragonchallengeConfig:getGoldBarStr()
	return self:getClientValue("goldBarStr")
end

function DualdragonchallengeConfig:getBtnShopJumpTo(activityId)
	return self._dual_dragon_challenge[activityId].jump_shop
end

function DualdragonchallengeConfig:getBtnRankJumpTo(activityId)
	return self._dual_dragon_challenge[activityId].jump_rank
end

function DualdragonchallengeConfig:getBtnActShopJumpTo(activityId)
	return self._dual_dragon_challenge[activityId].jump_act_shop
end

function DualdragonchallengeConfig:getBtnLotterJumpTo(activityId)
	return self._dual_dragon_challenge[activityId].jump_lotery
end

function DualdragonchallengeConfig:getUniversalFormationPos()
	return {}
end

function DualdragonchallengeConfig:getCreepCfgs(creepsMasterId)
	return self._dual_dragon_creeps[creepsMasterId]
end

function DualdragonchallengeConfig:getMasterCfg(creepsMasterId)
	return self._dual_dragon_master[creepsMasterId]
end

function DualdragonchallengeConfig:getUniversalTodayPets(activityId, days)
	local cfgs = self._dual_dragon_universal_buff[activityId]
	local maxDays = #cfgs

	days = math.min(maxDays, days)

	local cfg = cfgs[days]

	return (string.split(cfg.raceIds, "#"))
end

function DualdragonchallengeConfig:getUniversalBuffId(activityId, days)
	local cfgs = self._dual_dragon_universal_buff[activityId]
	local maxDays = #cfgs

	days = math.min(maxDays, days)

	return cfgs[days].buffId
end

function DualdragonchallengeConfig:getBuffCfg(buffId)
	return self._dual_dragon_buff[buffId]
end

function DualdragonchallengeConfig:getUniversalRewardList(activityId)
	return string.split(self._dual_dragon_challenge[activityId].universalReward, "#")
end

function DualdragonchallengeConfig:getUniversalBuyTimePrice(activityId)
	return self._dual_dragon_challenge[activityId].universalPrice
end

function DualdragonchallengeConfig:getUniversalSupportPetsCfgs(activityId)
	return self._dual_dragon_support_pet[activityId]
end

function DualdragonchallengeConfig:getstageCfgs(activityId)
	return self._dual_dragon_extreme_stage[activityId]
end

function DualdragonchallengeConfig:getStageCfg(activityId, groupId, stageId)
	return self._dual_dragon_extreme_stage[activityId][groupId][stageId]
end

function DualdragonchallengeConfig:getUniversalRaceId(activityId, creepsMasterId)
	return self._dual_dragon_universal_boss[activityId][creepsMasterId].raceId
end

DualdragonchallengeConfig.instance = DualdragonchallengeConfig.New()

return DualdragonchallengeConfig
