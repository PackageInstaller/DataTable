-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/config/HerotrialConfig.lua

module("logic.extensions.warriortower.config.HerotrialConfig", package.seeall)

local HerotrialConfig = class("HerotrialConfig", BaseConfig)

function HerotrialConfig:onInit()
	HerotrialConfig.super.onInit(self)

	self._wtCfg = nil
	self._wtAnalysisCfg = nil
	self._dicCfg = nil
	self._crpCfg = nil
end

function HerotrialConfig:getNames()
	return {
		"hero_trial_activity",
		"hero_trial_support",
		"hero_trial_verify_plan",
		"hero_trial_boss",
		"hero_trial_boss_creeps"
	}
end

function HerotrialConfig:handleConfig(name, content)
	print("hadndasda  = " .. name)

	if name == "hero_trial_activity" then
		self._heroTrialCfg = content
	elseif name == "hero_trial_support" then
		self._heroSupportCfg = content
	elseif name == "hero_trial_verify_plan" then
		self._verifyCfg = content
	elseif name == "hero_trial_boss" then
		self._bossCfg = content
	elseif name == "hero_trial_boss_creeps" then
		self._bossCreepCfg = content
	end
end

function HerotrialConfig:getHeroTrialActivity(activityId)
	return self._heroTrialCfg[activityId]
end

function HerotrialConfig:getAllActivity()
	return self._heroTrialCfg.dataList
end

function HerotrialConfig:getHeroSupport(creepsId)
	return self._heroSupportCfg[creepsId]
end

function HerotrialConfig:getBossCfgById(bossId)
	return self._bossCfg[bossId]
end

function HerotrialConfig:getBossCreepsById(id)
	return self._bossCreepCfg[id]
end

function HerotrialConfig:getVerifyPlans(activityId)
	local data = self._verifyCfg[self._heroTrialCfg[activityId].verifyPlanId]
	local ret = {}

	for k, v in pairs(data) do
		if v and checknumber(v.planId) > 0 then
			table.insert(ret, v)
		end
	end

	if ret and #ret > 1 then
		table.sort(ret, function(a, b)
			return a.leftZdl < b.leftZdl
		end)
	end

	return ret
end

HerotrialConfig.instance = HerotrialConfig.New()

return HerotrialConfig
