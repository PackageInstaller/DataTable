-- chunkname: @modules/logic/signin/config/SignInConfig.lua

module("modules.logic.signin.config.SignInConfig", package.seeall)

local SignInConfig = class("SignInConfig", BaseConfig)

function SignInConfig:ctor()
	self._signMonthRewards = nil
	self._signRewards = nil
	self._signDesc = nil
	self._goldRewards = nil
end

function SignInConfig:reqConfigNames()
	return {
		"sign_in_addup_bonus",
		"sign_in_bonus",
		"sign_in_word",
		"activity143_bonus",
		"sign_in_lifetime_bonus"
	}
end

function SignInConfig:onConfigLoaded(configName, configTable)
	if configName == "sign_in_addup_bonus" then
		self._signMonthRewards = configTable
	elseif configName == "sign_in_bonus" then
		self._signRewards = configTable
	elseif configName == "sign_in_word" then
		self._signDesc = configTable
	elseif configName == "activity143_bonus" then
		self._goldRewards = configTable
	end
end

function SignInConfig:getSignMonthReward(id)
	return self._signMonthRewards.configDict[id]
end

function SignInConfig:getSignMonthRewards()
	return self._signMonthRewards.configDict
end

function SignInConfig:getSignRewards(id)
	return self._signRewards.configDict[id]
end

function SignInConfig:getSignRewardBouns(id)
	if not self._singRewardBonusDict then
		self._singRewardBonusDict = {}

		for _, cfg in ipairs(self._signRewards.configList) do
			self._singRewardBonusDict[cfg.id] = string.splitToNumber(cfg.signinBonus, "#")
		end
	end

	return self._singRewardBonusDict[id]
end

function SignInConfig:getSignDesc(id)
	return self._signDesc.configDict[id]
end

function SignInConfig:getGoldReward(day)
	for _, v in pairs(self._goldRewards.configDict[ActivityEnum.Activity.DailyAllowance]) do
		if v.day == day then
			return v.bonus
		end
	end
end

function SignInConfig:getSignDescByDate(time)
	local date = os.date("%Y-%m-%d 00:00:00", time)

	for _, v in pairs(self._signDesc.configDict) do
		if v.signindate == date then
			return v.signinword
		end
	end
end

function SignInConfig:getSignInLifeTimeBonusCO(stageid)
	return lua_sign_in_lifetime_bonus.configList[stageid]
end

function SignInConfig:getSignInLifeTimeBonusCount()
	return #lua_sign_in_lifetime_bonus.configList
end

SignInConfig.instance = SignInConfig.New()

return SignInConfig
