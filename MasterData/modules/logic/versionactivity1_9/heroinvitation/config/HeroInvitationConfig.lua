-- chunkname: @modules/logic/versionactivity1_9/heroinvitation/config/HeroInvitationConfig.lua

module("modules.logic.versionactivity1_9.heroinvitation.config.HeroInvitationConfig", package.seeall)

local HeroInvitationConfig = class("HeroInvitationConfig", BaseConfig)

function HeroInvitationConfig:ctor()
	return
end

function HeroInvitationConfig:reqConfigNames()
	return {
		"hero_invitation"
	}
end

function HeroInvitationConfig:onConfigLoaded(configName, configTable)
	if configName == "hero_invitation" then
		self._roleStoryConfig = configTable

		self:initHeroInvitation()
	end
end

function HeroInvitationConfig:initHeroInvitation()
	self._elementDict = {}

	for i, v in ipairs(self._roleStoryConfig.configList) do
		self._elementDict[v.elementId] = v
	end
end

function HeroInvitationConfig:getInvitationConfig(id)
	return self._roleStoryConfig.configDict[id]
end

function HeroInvitationConfig:getInvitationList()
	return self._roleStoryConfig.configList
end

function HeroInvitationConfig:getInvitationConfigByElementId(elementId)
	return self._elementDict[elementId]
end

HeroInvitationConfig.instance = HeroInvitationConfig.New()

return HeroInvitationConfig
