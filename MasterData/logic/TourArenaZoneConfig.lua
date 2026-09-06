-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/config/TourArenaZoneConfig.lua

module("logic.extensions.tourarena.config.TourArenaZoneConfig", package.seeall)

local TourArenaZoneConfig = class("TourArenaZoneConfig", BaseConfig)

function TourArenaZoneConfig:onInit()
	TourArenaZoneConfig.super.onInit(self)
end

function TourArenaZoneConfig:getNames()
	return {
		"tour_arena_zone",
		"tour_arena_zone_term"
	}
end

function TourArenaZoneConfig:handleConfig(name, content)
	if name == "tour_arena_zone" then
		self._tazCfg = content
	elseif name == "tour_arena_zone_term" then
		self._tazTermCfgs = content
	end
end

function TourArenaZoneConfig:getTazDataList()
	return self._tazCfg.dataList
end

function TourArenaZoneConfig:getTazData(zoneId)
	return self._tazCfg[zoneId]
end

function TourArenaZoneConfig:getTazTermData(termId)
	return self._tazTermCfgs[termId]
end

TourArenaZoneConfig.instance = TourArenaZoneConfig.New()

return TourArenaZoneConfig
