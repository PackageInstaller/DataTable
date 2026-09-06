-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/givepet/config/GivePetConfig.lua

module("logic.extensions.givepet.config.GivePetConfig", package.seeall)

local GivePetConfig = class("GivePetConfig", BaseConfig)

function GivePetConfig:onInit()
	GivePetConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function GivePetConfig:getNames()
	return {
		"ares_activity"
	}
end

function GivePetConfig:handleConfig(name, content)
	if name == "ares_activity" then
		self._activity = content
	end
end

function GivePetConfig:getActivityById(id)
	return self._activity[id]
end

function GivePetConfig:getActivity()
	return self._activity
end

GivePetConfig.instance = GivePetConfig.New()

return GivePetConfig
