-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/config/WaterdraktowerConfig.lua

module("logic.extensions.waterdraktower.config.WaterdraktowerConfig", package.seeall)

local WaterdraktowerConfig = class("WaterdraktowerConfig", BaseConfig)

function WaterdraktowerConfig:onInit()
	self._wltBuffCfgs = nil
end

function WaterdraktowerConfig:getNames()
	return {
		"water_dark_tower_common",
		"water_dark_tower_tier_challenge",
		"water_dark_tower_creeps",
		"water_dark_tower_special_prize",
		"water_dark_tower_buy_times",
		"water_dark_tower_cut_down",
		"water_dark_tower_buff"
	}
end

function WaterdraktowerConfig:handleConfig(name, content)
	if name == "water_dark_tower_common" then
		self._water_dark_tower_common = content
	elseif name == "water_dark_tower_tier_challenge" then
		self._water_dark_tower_tier_challenge = content
	elseif name == "water_dark_tower_creeps" then
		self._water_dark_tower_creeps = content
	elseif name == "water_dark_tower_special_prize" then
		self._water_dark_tower_special_prize = content
	elseif name == "water_dark_tower_buy_times" then
		self._water_dark_tower_buy_times = content
	elseif name == "water_dark_tower_cut_down" then
		self._water_dark_tower_cut_down = content
	elseif name == "water_dark_tower_buff" then
		self._wltBuffCfgs = content
	end
end

function WaterdraktowerConfig:getAcfCfg(actId)
	return self._water_dark_tower_common[actId]
end

function WaterdraktowerConfig:getChallengeCfgs(challengePlanId)
	return self._water_dark_tower_tier_challenge[challengePlanId]
end

function WaterdraktowerConfig:getSpecialPrizeCfgs(prizePlanId)
	return self._water_dark_tower_special_prize[prizePlanId]
end

function WaterdraktowerConfig:getCutDownPlanCfgs(cutDownPlanId)
	return self._water_dark_tower_cut_down[cutDownPlanId]
end

function WaterdraktowerConfig:getCreepsCfg(creepsMasterId)
	return self._water_dark_tower_creeps[creepsMasterId]
end

function WaterdraktowerConfig:getBuyTimeCfg(buyTimesPlanId, times)
	return self._water_dark_tower_buy_times[buyTimesPlanId][times]
end

function WaterdraktowerConfig:getBuyTimeCfgs(buyTimesPlanId)
	return self._water_dark_tower_buy_times[buyTimesPlanId]
end

function WaterdraktowerConfig:getTierCommCfg(actId)
	if self._water_dark_tower_common == nil then
		return
	end

	return self._water_dark_tower_common[checknumber(actId)]
end

function WaterdraktowerConfig:getTierChallengeCfgs(planId, tierType)
	planId = checknumber(planId)

	if self._water_dark_tower_tier_challenge == nil or self._water_dark_tower_tier_challenge[planId] == nil then
		return
	end

	local list = self._water_dark_tower_tier_challenge[planId]

	tierType = checknumber(tierType)

	if list[tierType] == nil then
		return list
	end

	return list[tierType]
end

function WaterdraktowerConfig:getTierChallengeCfgByStage(planId, tierType, tier, stage)
	local allCfgs = self:getTierChallengeCfgs(planId, tierType)

	if allCfgs == nil or allCfgs[tier] == nil then
		return nil
	end

	local list = allCfgs[tier]

	if list == nil or list[stage] == nil then
		return nil
	end

	return list[stage]
end

function WaterdraktowerConfig:getTierCreepsCfg(creepsId)
	creepsId = checknumber(creepsId)

	if self._water_dark_tower_creeps == nil or self._water_dark_tower_creeps[creepsId] == nil then
		return nil
	end

	return self._water_dark_tower_creeps[creepsId]
end

function WaterdraktowerConfig:getTierSpecialPrizeCfgs(planId, tierType, tier)
	planId = checknumber(planId)
	tierType = checknumber(tierType)

	if self._water_dark_tower_special_prize == nil or self._water_dark_tower_special_prize[planId] == nil then
		return
	end

	local list = self._water_dark_tower_special_prize[planId]

	if list[tierType] == nil then
		return
	end

	tier = checknumber(tier)

	if list[tierType][tier] == nil then
		return list[tierType]
	end

	return list[tierType][tier]
end

function WaterdraktowerConfig:getBuyTowerChallCount(planId, times)
	planId = checknumber(planId)

	if self._water_dark_tower_buy_times == nil or self._water_dark_tower_buy_times[planId] == nil then
		return
	end

	times = checknumber(times)

	local list = self._water_dark_tower_buy_times[planId]

	if list[times] == nil then
		return list
	end

	return list[times]
end

function WaterdraktowerConfig:getOpenTowerActivityId()
	WaterdraktowerModel.instance.openActId = nil

	if self._water_dark_tower_common == nil then
		return -1
	end

	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(WaterdraktowerModel.instance.openActType)

	if cfgs == nil then
		return -2
	end

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			WaterdraktowerModel.instance.openActId = item.activityId

			return item.activityId
		end
	end

	return -3
end

function WaterdraktowerConfig:getAllBuffsByPlanId(planId)
	if self._wltBuffCfgs == nil or self._wltBuffCfgs[planId] == nil then
		return
	end

	return self._wltBuffCfgs[planId]
end

WaterdraktowerConfig.instance = WaterdraktowerConfig.New()

return WaterdraktowerConfig
