-- chunkname: @modules/logic/weather/config/WeatherConfig.lua

module("modules.logic.weather.config.WeatherConfig", package.seeall)

local WeatherConfig = class("WeatherConfig", BaseConfig)

function WeatherConfig:reqConfigNames()
	return {
		"weather_month",
		"weather_week",
		"weather_report",
		"skin_weather_param",
		"scene_eggs",
		"weather_day_new",
		"scene_mat_report_settings"
	}
end

function WeatherConfig:onInit()
	return
end

function WeatherConfig:onConfigLoaded(configName, configTable)
	if configName == "weather_day_new" then
		self:_initWeatherDayNew()
	elseif configName == "scene_mat_report_settings" then
		self:_initSceneMatReportSettings()
	end
end

function WeatherConfig:_initSceneMatReportSettings()
	self._sceneMatReportSettings = {}

	for i, v in ipairs(lua_scene_mat_report_settings.configList) do
		local lightmap = GameUtil.splitString2(v.lightmap, false, "|", "#")

		self._sceneMatReportSettings[v.sceneId] = self._sceneMatReportSettings[v.sceneId] or {}
		self._sceneMatReportSettings[v.sceneId][v.mat] = self._sceneMatReportSettings[v.sceneId][v.mat] or {}

		for _, param in ipairs(lightmap) do
			local reportId = tonumber(param[1])
			local reportConfig = lua_weather_report.configDict[reportId]

			if reportConfig then
				self._sceneMatReportSettings[v.sceneId][v.mat][reportConfig.lightMode] = param[2]
			else
				print("WeatherConfig:_initSceneMatReportSettings error reportId:", reportId)
			end
		end
	end
end

function WeatherConfig:getMatReportSettings(sceneId)
	return self._sceneMatReportSettings[sceneId]
end

function WeatherConfig:getNowDate()
	return os.date("*t", os.time())
end

function WeatherConfig:getWeek(weekId)
	if not weekId then
		local nowDate = self:getNowDate()
		local month = nowDate.month
		local monthCo = lua_weather_month.configDict[month]
		local weekListStr = monthCo.weekList
		local weekList = string.split(weekListStr, "#")
		local index = math.random(#weekList)

		weekId = tonumber(weekList[index])
	end

	return lua_weather_week.configDict[weekId], weekId
end

function WeatherConfig:getDay(weekId, dayId, sceneId)
	if not dayId then
		local weekConfig, newWeekId = self:getWeek(weekId)

		weekId = newWeekId

		local nowDate = self:getNowDate()
		local wday = nowDate.wday
		local dayListStr = weekConfig["day" .. wday]
		local dayList = string.split(dayListStr, "#")

		dayId = tonumber(dayList[math.random(#dayList)])
	end

	local config = sceneId and lua_weather_day_new.configDict[sceneId]

	if not config then
		logError(string.format("WeatherConfig:getDay error, sceneId:%s", sceneId))

		config = lua_weather_day_new.configDict[MainSceneSwitchEnum.DefaultScene]
	end

	return config[dayId], weekId, dayId
end

function WeatherConfig:_initWeatherDayNew()
	self._sceneReportDict = {}

	for i, v in ipairs(lua_weather_day_new.configList) do
		self._sceneReportDict[v.sceneId] = self._sceneReportDict[v.sceneId] or {}

		local map = self._sceneReportDict[v.sceneId]
		local t = GameUtil.splitString2(v.reportList, false, "|", "#")

		for _, report in ipairs(t) do
			map[tonumber(report[2])] = true
		end
	end
end

function WeatherConfig:sceneContainReport(sceneId, reportId)
	local map = self._sceneReportDict[sceneId]

	return map and map[reportId]
end

function WeatherConfig:getReport(id)
	return lua_weather_report.configDict[id]
end

function WeatherConfig:getReportList(lightMode, sceneId)
	local t = {}

	for i, v in ipairs(lua_weather_report.configList) do
		if v.lightMode == lightMode and self:sceneContainReport(sceneId, v.id) then
			table.insert(t, v)
		end
	end

	return t
end

function WeatherConfig:getRandomReport(lightMode, sceneId)
	local t = self:getReportList(lightMode, sceneId)

	return t[math.random(#t)]
end

function WeatherConfig:getSkinWeatherParam(id)
	return lua_skin_weather_param.configDict[id]
end

WeatherConfig.instance = WeatherConfig.New()

return WeatherConfig
