-- chunkname: @modules/logic/weather/rpc/WeatherRpc.lua

module("modules.logic.weather.rpc.WeatherRpc", package.seeall)

local WeatherRpc = class("WeatherRpc", BaseRpc)

WeatherRpc.instance = WeatherRpc.New()

return WeatherRpc
