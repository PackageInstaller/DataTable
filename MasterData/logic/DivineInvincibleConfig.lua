-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinvincible/config/DivineInvincibleConfig.lua

module("logic.extensions.divineinvincible.config.DivineInvincibleConfig", package.seeall)

local DivineInvincibleConfig = class("DivineInvincibleConfig", BaseConfig)

function DivineInvincibleConfig:onInit()
	DivineInvincibleConfig.super.onInit(self)
end

function DivineInvincibleConfig:getNames()
	return {
		"divine_invincible_activity",
		"divine_invincible_extreme_pass",
		"divine_invincible_extreme_stage",
		"divine_invincible_extreme_buff",
		"divine_invincible_normal_stage",
		"divine_invincible_normal_prize",
		"divine_invincible_support_pet",
		"divine_invincible_creeps_master",
		"divine_invincible_creeps"
	}
end

function DivineInvincibleConfig:handleConfig(name, content)
	if name == "divine_invincible_activity" then
		self._divine_invincible_activity = content
	elseif name == "divine_invincible_extreme_pass" then
		self._divine_invincible_extreme_pass = content
	elseif name == "divine_invincible_extreme_stage" then
		self._divine_invincible_extreme_stage = content
	elseif name == "divine_invincible_extreme_buff" then
		self._divine_invincible_extreme_buff = content
	elseif name == "divine_invincible_normal_stage" then
		self._divine_invincible_normal_stage = content
	elseif name == "divine_invincible_normal_prize" then
		self._divine_invincible_normal_prize = content
	elseif name == "divine_invincible_support_pet" then
		self._divine_invincible_support_pet = content
	elseif name == "divine_invincible_creeps_master" then
		self._divine_invincible_creeps_master = content
	elseif name == "divine_invincible_creeps" then
		self._divine_invincible_creeps = content
	end
end

function DivineInvincibleConfig:getActData(activityId)
	return self._divine_invincible_activity[activityId]
end

function DivineInvincibleConfig:getExtPassCfg(activityId)
	local data = self:getActData(activityId)

	if data then
		if not data.extremePlanId then
			local extremePlanId = 0

			return self._divine_invincible_extreme_pass[extremePlanId]
		end
	end
end

function DivineInvincibleConfig:getExtPassData(activityId, posId)
	local cfg = self:getExtPassCfg(activityId)

	return cfg and cfg[posId]
end

function DivineInvincibleConfig:getExtStageCfg(activityId)
	local data = self:getActData(activityId)

	if data then
		if not data.extremePlanId then
			local extremePlanId = 0

			return self._divine_invincible_extreme_stage[extremePlanId]
		end
	end
end

function DivineInvincibleConfig:getExtStageData(activityId, stageId)
	local cfg = self:getExtStageCfg(activityId)

	return cfg and cfg[stageId]
end

function DivineInvincibleConfig:getExtBuffCfg(activityId)
	local data = self:getActData(activityId)

	if data then
		if not data.extremePlanId then
			local extremePlanId = 0

			return self._divine_invincible_extreme_buff[extremePlanId]
		end
	end
end

function DivineInvincibleConfig:getExtBuffData(activityId, finishNum)
	local cfg = self:getExtBuffCfg(activityId)

	return MmUtil.binarySearchInSingleKey(cfg, "finishNum", finishNum)
end

function DivineInvincibleConfig:getNorStageCfg(activityId)
	local data = self:getActData(activityId)

	if data then
		if not data.normalPlanId then
			local normalPlanId = 0

			return self._divine_invincible_normal_stage[normalPlanId]
		end
	end
end

function DivineInvincibleConfig:getNorStageData(activityId, day)
	local cfg = self:getNorStageCfg(activityId)

	return cfg and cfg[day]
end

function DivineInvincibleConfig:getNorPrizeCfg(activityId)
	local data = self:getActData(activityId)

	if data then
		if not data.normalPlanId then
			local normalPlanId = 0

			return self._divine_invincible_normal_prize[normalPlanId]
		end
	end
end

function DivineInvincibleConfig:getNorPrizeData(activityId, prizeId)
	local cfg = self:getNorPrizeCfg(activityId)

	return cfg and cfg[prizeId]
end

function DivineInvincibleConfig:getSupportDataList()
	return self._divine_invincible_support_pet.dataList
end

function DivineInvincibleConfig:getMasterData(creepsMasterId)
	return self._divine_invincible_creeps_master[creepsMasterId]
end

function DivineInvincibleConfig:getCreepsCfg(creepsMasterId)
	return self._divine_invincible_creeps[creepsMasterId]
end

DivineInvincibleConfig.instance = DivineInvincibleConfig.New()

return DivineInvincibleConfig
