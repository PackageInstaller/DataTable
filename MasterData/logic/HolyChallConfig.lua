-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/config/HolyChallConfig.lua

module("logic.extensions.kingway.config.HolyChallConfig", package.seeall)

local HolyChallConfig = class("HolyChallConfig", BaseConfig)

function HolyChallConfig:onInit()
	HolyChallConfig.super.onInit(self)

	self.challGuardCfgs = nil
	self.challTrialCfgs = nil
	self.ChallDamageCfgs = nil
	self.challStageCfgs = nil
	self.commonCfgs = nil
end

function HolyChallConfig:getNames()
	return {
		"holy_challenge_support",
		"holy_challenge_guard",
		"holy_challenge_trial",
		"holy_challenge_trial_prize_plan",
		"holy_challenge_stage",
		"holy_challenge_creeps",
		"holy_challenge_common"
	}
end

function HolyChallConfig:handleConfig(name, content)
	if name == "holy_challenge_support" then
		self.supportCfg = content
	elseif name == "holy_challenge_guard" then
		self.challGuardCfgs = content
	elseif name == "holy_challenge_trial" then
		self.challTrialCfgs = content
	elseif name == "holy_challenge_trial_prize_plan" then
		self:CumulativeDamageList(content)
	elseif name == "holy_challenge_stage" then
		self.challStageCfgs = content
	elseif name == "holy_challenge_creeps" then
		self.creepsCfg = content
	elseif name == "holy_challenge_common" then
		self.commonCfgs = {}

		if content.DAILY_ENERGY then
			self.commonCfgs.dailyEnergy = tonumber(content.DAILY_ENERGY.value)
		end

		if content.FINAL_PRIZE then
			self.commonCfgs.finalPrize = tonumber(content.FINAL_PRIZE.value)
		end

		if content.PRIZE_ENERGY_REQ then
			self.commonCfgs.totalEnergy = tonumber(content.PRIZE_ENERGY_REQ.value)
		end
	end
end

function HolyChallConfig:CumulativeDamageList(data)
	self.ChallDamageCfgs = data.dataList
end

function HolyChallConfig:GetChallGuardCfg(battleId)
	if checknumber(battleId) <= 0 or self.challGuardCfgs == nil then
		return
	end

	return self.challGuardCfgs[battleId]
end

function HolyChallConfig:GetChallTrialCfg(num)
	num = math.max(0, num)

	if self.challTrialCfgs == nil then
		return
	end

	while num >= 0 do
		if self.challTrialCfgs[num] then
			return self.challTrialCfgs[num]
		end

		num = num - 1
	end

	return nil
end

function HolyChallConfig:GetChallStageCfg(battleId, stageId)
	if checknumber(battleId) <= 0 or self.challStageCfgs == nil then
		return
	end

	if checknumber(stageId) <= 0 then
		return self.challStageCfgs[battleId]
	end

	return self.challStageCfgs[battleId][stageId]
end

function HolyChallConfig:GetChallDamageCfgs()
	return self.ChallDamageCfgs
end

function HolyChallConfig:GetCommonCfgs()
	return self.commonCfgs
end

function HolyChallConfig:getCreepsById(creepsMasterId)
	return self.creepsCfg[creepsMasterId]
end

function HolyChallConfig:getSupportCreep(creepsId)
	return self.supportCfg[creepsId]
end

HolyChallConfig.instance = HolyChallConfig.New()

return HolyChallConfig
