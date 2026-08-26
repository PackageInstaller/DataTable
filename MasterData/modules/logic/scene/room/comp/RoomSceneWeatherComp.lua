-- chunkname: @modules/logic/scene/room/comp/RoomSceneWeatherComp.lua

module("modules.logic.scene.room.comp.RoomSceneWeatherComp", package.seeall)

local RoomSceneWeatherComp = class("RoomSceneWeatherComp", BaseSceneComp)

RoomSceneWeatherComp.WeatherUpdateRate = 60
RoomSceneWeatherComp.WeatherSwitchTime = 30

function RoomSceneWeatherComp:onInit()
	self._lightModeParamList = {
		{
			LightIntensity = 1,
			AmbientColor = Color(0.71, 0.698, 0.647, 1),
			FogColor = Color(0.718, 0.749, 0.722, 1),
			LightColor = Color(0.612, 0.487, 0.396, 1)
		},
		{
			LightIntensity = 1,
			AmbientColor = Color(0.447, 0.561, 0.596, 1),
			FogColor = Color(0.404, 0.514, 0.592, 1),
			LightColor = Color(0.6, 0.592, 0.541, 1)
		},
		{
			LightIntensity = 1,
			AmbientColor = Color(0.655, 0.624, 0.58),
			FogColor = Color(0.702, 0.478, 0.388, 1),
			LightColor = Color(0.706, 0.459, 0.353, 1)
		},
		{
			LightIntensity = 1,
			AmbientColor = Color(0.314, 0.467, 0.655, 1),
			FogColor = Color(0.118, 0.31, 0.486, 1),
			LightColor = Color(0.388, 0.627, 0.757, 1)
		}
	}
end

function RoomSceneWeatherComp:init(sceneId, levelId)
	self._scene = self:getCurScene()
	self._curReportConfig = nil
	self._curReportEndTime = nil
	self._curLightMode = nil

	if not RoomController.instance:isDebugMode() then
		self:_initWeather()
		TaskDispatcher.runRepeat(self._checkReport, self, RoomSceneWeatherComp.WeatherUpdateRate)
	end

	WeatherController.instance:registerCallback(WeatherEvent.WeatherChanged, self._weatherChanged, self)
end

function RoomSceneWeatherComp:tweenLightModeParam(preLightModeParam, curLightModeParam, immediately)
	if self._tweenLightModeParamId then
		self._scene.tween:killById(self._tweenLightModeParamId)

		self._tweenLightModeParamId = nil
	end

	if immediately then
		self:_changeLightModeParam(curLightModeParam)
	else
		self._tweenLightModeParamId = self._scene.tween:tweenFloat(0, 1, RoomSceneWeatherComp.WeatherSwitchTime, self._tweenLightModeFrame, self._tweenLightModeFinish, self, {
			preLightModeParam = preLightModeParam,
			curLightModeParam = curLightModeParam
		})
	end
end

function RoomSceneWeatherComp:_tweenLightModeFrame(value, param)
	local lightModeParam = {
		AmbientColor = param.preLightModeParam.AmbientColor:Lerp(param.curLightModeParam.AmbientColor, value),
		FogColor = param.preLightModeParam.FogColor:Lerp(param.curLightModeParam.FogColor, value),
		LightColor = param.preLightModeParam.LightColor:Lerp(param.curLightModeParam.LightColor, value),
		LightIntensity = param.preLightModeParam.LightIntensity + (param.curLightModeParam.LightIntensity - param.preLightModeParam.LightIntensity) * value
	}

	self:_changeLightModeParam(lightModeParam)
end

function RoomSceneWeatherComp:_tweenLightModeFinish(param)
	self:_changeLightModeParam(param.curLightModeParam)
end

function RoomSceneWeatherComp:_changeLightModeParam(lightModeParam)
	return
end

function RoomSceneWeatherComp:_getLightModeParam()
	local lightModeParam = {}

	lightModeParam.AmbientColor = self._scene.bending:getAmbientColor()
	lightModeParam.FogColor = self._scene.bending:getFogColor()
	lightModeParam.LightColor = self._scene.light:getLightColor()
	lightModeParam.LightIntensity = self._scene.light:getLightIntensity()

	return lightModeParam
end

function RoomSceneWeatherComp:setLightMode(lightMode, immediately)
	if self._curLightMode == lightMode and not immediately then
		return
	end

	self._curLightMode = lightMode

	local preLightModeParam = self:_getLightModeParam()

	if not self._lightModeParamList[lightMode] then
		self:tweenLightModeParam(preLightModeParam, self._lightModeParamList[lightMode], immediately)
	end
end

function RoomSceneWeatherComp:setReport(reportConfig, immediately)
	if self._curReportConfig == reportConfig and not immediately then
		return
	end

	self._curReportConfig = reportConfig

	local lightMode = reportConfig.lightMode

	self:setLightMode(lightMode, immediately)
end

function RoomSceneWeatherComp:_initWeather()
	self:updateReport(true)

	if not self._curLightMode then
		self:setLightMode(1, true)
	end
end

function RoomSceneWeatherComp:_weatherChanged(reportId, deltaTime)
	self:changeReport(reportId, deltaTime)
end

function RoomSceneWeatherComp:changeReport(reportId, deltaTime, immediately)
	if reportId then
		::label_12_0::

		local reportConfig = WeatherConfig.instance:getReport(reportId)

		if not reportConfig or not deltaTime then
			return
		end

		self:setReport(reportConfig, immediately)

		self._curReportEndTime = ServerTime.now() + deltaTime
	end
end

function RoomSceneWeatherComp:updateReport(immediately)
	local reportConfig, deltaTime = self:_getReport()

	self:changeReport(reportConfig.id, deltaTime, immediately)
end

function RoomSceneWeatherComp:_checkReport()
	if self._curReportEndTime and self._curReportEndTime <= ServerTime.now() then
		self:updateReport()
	end
end

function RoomSceneWeatherComp:_getReport()
	local reportConfig, deltaTime = WeatherModel.instance:getReport()

	return reportConfig, deltaTime
end

function RoomSceneWeatherComp:onSceneClose()
	if self._tweenLightModeParamId then
		self._scene.tween:killById(self._tweenLightModeParamId)

		self._tweenLightModeParamId = nil
	end

	WeatherController.instance:unregisterCallback(WeatherEvent.WeatherChanged, self._weatherChanged, self)
	TaskDispatcher.cancelTask(self._checkReport, self)
end

return RoomSceneWeatherComp
