-- chunkname: @modules/logic/weather/controller/WeatherEvent.lua

module("modules.logic.weather.controller.WeatherEvent", package.seeall)

local WeatherEvent = _M

WeatherEvent.PlayVoice = 1
WeatherEvent.LoadPhotoFrameBg = 2
WeatherEvent.OnRoleBlend = 3
WeatherEvent.WeatherChanged = 10
WeatherEvent.MainViewHideTimeUpdate = 11

return WeatherEvent
