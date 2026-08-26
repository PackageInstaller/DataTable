-- chunkname: @modules/logic/weather/controller/behaviour/WeatherBaseBehaviour.lua

module("modules.logic.weather.controller.behaviour.WeatherBaseBehaviour", package.seeall)

local WeatherBaseBehaviour = class("WeatherBaseBehaviour", LuaCompBase)

function WeatherBaseBehaviour:setSceneConfig(sceneConfig)
	self._sceneConfig = sceneConfig

	self:_onSetSceneConfig()
end

function WeatherBaseBehaviour:_onSetSceneConfig()
	return
end

function WeatherBaseBehaviour:setLightMats(lightMats)
	return
end

function WeatherBaseBehaviour:setReport(prevReport, curReport)
	self._prevReport = prevReport
	self._curReport = curReport

	self:_onReportChange()
end

function WeatherBaseBehaviour:_onReportChange()
	return
end

function WeatherBaseBehaviour:changeBlendValue(value, isEnd, revert)
	return
end

return WeatherBaseBehaviour
