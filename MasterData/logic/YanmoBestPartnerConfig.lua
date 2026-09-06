-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yanmobestpartner/config/YanmoBestPartnerConfig.lua

module("logic.extensions.yanmobestpartner.config.YanmoBestPartnerConfig", package.seeall)

local YanmoBestPartnerConfig = class("YanmoBestPartnerConfig", BaseConfig)

function YanmoBestPartnerConfig:onInit()
	YanmoBestPartnerConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function YanmoBestPartnerConfig:getNames()
	return {
		"collect_summoning_pet",
		"collect_summoning",
		"collect_summoning_reward"
	}
end

function YanmoBestPartnerConfig:handleConfig(name, content)
	if name == "collect_summoning_pet" then
		self._collect_summoning_pet = content
	elseif name == "collect_summoning" then
		self._collect_summoning = content
	elseif name == "collect_summoning_reward" then
		self._collect_summoning_reward = content
	end
end

function YanmoBestPartnerConfig:getCfgById(id)
	return self._collect_summoning[id]
end

function YanmoBestPartnerConfig:getPetById(id)
	local cfg = self:getCfgById(id)

	return self._collect_summoning_pet[cfg.petPlanId]
end

function YanmoBestPartnerConfig:getRewardById(id)
	local cfg = self:getCfgById(id)

	return self._collect_summoning_reward[cfg.petPrizePlanId]
end

YanmoBestPartnerConfig.instance = YanmoBestPartnerConfig.New()

return YanmoBestPartnerConfig
