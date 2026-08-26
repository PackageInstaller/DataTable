-- chunkname: @modules/logic/weather/controller/WeatherSwitchComp.lua

module("modules.logic.weather.controller.WeatherSwitchComp", package.seeall)

local WeatherSwitchComp = class("WeatherSwitchComp")
local FAKE_TIME = 6000
local MIN_LIGHT_MODE = 1
local MAX_LIGHT_MODE = 4

function WeatherSwitchComp:ctor()
	return
end

function WeatherSwitchComp:pause()
	TaskDispatcher.cancelTask(self._checkReport, self)
end

function WeatherSwitchComp:continue()
	TaskDispatcher.runRepeat(self._checkReport, self, 1)
end

function WeatherSwitchComp:onSceneHide()
	self._isHide = true

	TaskDispatcher.cancelTask(self._checkReport, self)
end

function WeatherSwitchComp:onSceneShow()
	if not self._isHide then
		return
	end

	self._isHide = false

	TaskDispatcher.runRepeat(self._checkReport, self, 1)
	self:chaneWeatherLightMode(self._initReport.lightMode, self._initReport)
end

function WeatherSwitchComp:getLightMode()
	return self._lightMode
end

function WeatherSwitchComp:getReportIndex()
	return self._reportIndex
end

function WeatherSwitchComp:getReportList()
	return self._reportList
end

function WeatherSwitchComp:switchPrevLightMode()
	if self._lightMode <= MIN_LIGHT_MODE then
		return
	end

	local nextMode = self:_findValidLightMode(MIN_LIGHT_MODE, -1)

	if nextMode then
		self._lightMode = nextMode

		self:chaneWeatherLightMode(self._lightMode)
	else
		logError("switchPrevLightMode no valid light mode", self._lightMode, self._sceneId)
	end
end

function WeatherSwitchComp:switchNextLightMode()
	if self._lightMode >= MAX_LIGHT_MODE then
		return
	end

	local nextMode = self:_findValidLightMode(MAX_LIGHT_MODE, 1)

	if nextMode then
		self._lightMode = nextMode

		self:chaneWeatherLightMode(self._lightMode)
	else
		logError("switchNextLightMode no valid light mode", self._lightMode, self._sceneId)
	end
end

function WeatherSwitchComp:_findValidLightMode(targetMode, step)
	for i = self._lightMode + step, targetMode, step do
		local list = WeatherConfig.instance:getReportList(i, self._sceneId)

		if #list > 0 then
			return i
		end
	end
end

function WeatherSwitchComp:switchNextReport()
	self._reportIndex = self._reportIndex + 1

	if self._reportIndex > #self._reportList then
		self._reportIndex = 1
	end

	self:chaneWeatherLightMode(self._lightMode, self._reportList[self._reportIndex])
end

function WeatherSwitchComp:switchReport(index)
	self._reportIndex = index

	self:chaneWeatherLightMode(self._lightMode, self._reportList[self._reportIndex])
end

function WeatherSwitchComp:onInit(sceneId, weatherComp, reportId)
	self._sceneId = sceneId

	local sceneConfig = lua_scene_switch.configDict[sceneId]

	self._initReportId = reportId or sceneConfig.initReportId
	self._initReport = lua_weather_report.configDict[self._initReportId]
	self._reportList = {}
	self._changeTime = sceneConfig.reportSwitchTime
	self._weatherComp = weatherComp

	TaskDispatcher.runRepeat(self._checkReport, self, 1)
	self:chaneWeatherLightMode(self._initReport.lightMode, self._initReport)
end

function WeatherSwitchComp:chaneWeatherLightMode(mode, report)
	self._lightMode = mode
	self._reportList = WeatherConfig.instance:getReportList(mode, self._sceneId)
	self._reportIndex = report and tabletool.indexOf(self._reportList, report) or 1

	if #self._reportList <= 0 then
		logError(string.format("WeatherSwitchComp:chaneWeatherLightMode reportList is empty mode:%s,sceneId:%s", mode, self._sceneId))
	end

	self:applyReport()
end

function WeatherSwitchComp:applyReport()
	local report = self._reportList[self._reportIndex]

	if not report then
		return
	end

	self._weatherComp:changeReportId(report.id, FAKE_TIME)

	self._endTime = Time.time + self._changeTime

	if self._calback then
		self._calback(self._callbackObj)
	end
end

function WeatherSwitchComp:addReportChangeCallback(callback, callbackObj)
	self._calback = callback
	self._callbackObj = callbackObj
end

function WeatherSwitchComp:removeReportChangeCallback()
	self._calback = nil
	self._callbackObj = nil
end

function WeatherSwitchComp:_checkReport()
	if self._endTime and Time.time >= self._endTime then
		self._reportIndex = self._reportIndex + 1

		if self._reportIndex > #self._reportList then
			self._reportIndex = 1
		end

		self:applyReport()
	end
end

function WeatherSwitchComp:onSceneClose()
	TaskDispatcher.cancelTask(self._checkReport, self)
	self:removeReportChangeCallback()
end

return WeatherSwitchComp
