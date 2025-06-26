-- chunkname: @IQIGame\\UIExternalApi\\WeatherTimeUIApi.lua

WeatherTimeUIApi = BaseLangApi:Extend()

function WeatherTimeUIApi:Init()
	self:RegisterApi("TextTime", self.GetTextTime)
end

function WeatherTimeUIApi:GetTextTime(str)
	return str
end

WeatherTimeUIApi:Init()
