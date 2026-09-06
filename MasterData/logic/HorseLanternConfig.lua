-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/horselantern/config/HorseLanternConfig.lua

module("logic.extensions.horselantern.config.HorseLanternConfig", package.seeall)

local HorseLanternConfig = class("HorseLanternConfig", BaseConfig)

function HorseLanternConfig:onInit()
	HorseLanternConfig.super.onInit(self)

	self._lanternbroadcastCfg = nil
end

function HorseLanternConfig:getNames()
	return {
		"lantern_broadcast"
	}
end

function HorseLanternConfig:handleConfig(name, content)
	if name == "lantern_broadcast" then
		self._lanternbroadcastCfg = content
	end
end

function HorseLanternConfig:getCfgById(id)
	return self._lanternbroadcastCfg[id]
end

HorseLanternConfig.instance = HorseLanternConfig.New()

return HorseLanternConfig
