-- chunkname: @modules/logic/weather/controller/WeatherHelper.lua

module("modules.logic.weather.controller.WeatherHelper", package.seeall)

local WeatherHelper = class("WeatherHelper")

function WeatherHelper.getResourcePrefix(prefix)
	return string.gsub(prefix, "_colorchange_day", "")
end

function WeatherHelper.getNightResourcePrefix(prefix)
	return string.gsub(prefix, "_colorchange_night", "")
end

function WeatherHelper.skipLightMap(sceneId, name)
	if MainSceneSwitchEnum.SpSceneMap[sceneId] and string.find(name, "_colorchange_night") then
		return true
	end

	return false
end

return WeatherHelper
