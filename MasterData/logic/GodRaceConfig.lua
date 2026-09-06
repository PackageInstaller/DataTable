-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godrace/config/GodRaceConfig.lua

module("logic.extensions.godrace.config.GodRaceConfig", package.seeall)

local GodRaceConfig = class("GodRaceConfig", BaseConfig)

function GodRaceConfig:onInit()
	GodRaceConfig.super.onInit(self)

	self._godRaceCfg = nil
end

function GodRaceConfig:getNames()
	return {
		"god_race_type"
	}
end

function GodRaceConfig:handleConfig(name, content)
	if name == "god_race_type" then
		self._godRaceCfg = content
	end
end

function GodRaceConfig:getCfgById(id)
	return self._godRaceCfg[id]
end

function GodRaceConfig:isRaceShow(id)
	return self._godRaceCfg[id] ~= nil and self._godRaceCfg[id].isOnline
end

GodRaceConfig.instance = GodRaceConfig.New()

return GodRaceConfig
