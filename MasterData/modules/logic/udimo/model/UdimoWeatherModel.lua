-- chunkname: @modules/logic/udimo/model/UdimoWeatherModel.lua

module("modules.logic.udimo.model.UdimoWeatherModel", package.seeall)

local UdimoWeatherModel = class("UdimoWeatherModel", BaseModel)

function UdimoWeatherModel:onInit()
	return
end

function UdimoWeatherModel:reInit()
	return
end

function UdimoWeatherModel:setWeatherInfo(info)
	if not info then
		return
	end

	self.temp = info.temp
	self.weatherId = info.weatherId
	self.windLevel = info.windLevel
end

function UdimoWeatherModel:setOverseasNextChangeWeatherTime(time)
	self._overseasNextChangeWeatherTime = time
end

function UdimoWeatherModel:getWeatherId()
	return self.weatherId
end

function UdimoWeatherModel:getWindLevel()
	return self.windLevel
end

function UdimoWeatherModel:getTemperature()
	return self.temp
end

function UdimoWeatherModel:getOverseasNextChangeWeatherTime()
	return self._overseasNextChangeWeatherTime
end

UdimoWeatherModel.instance = UdimoWeatherModel.New()

return UdimoWeatherModel
