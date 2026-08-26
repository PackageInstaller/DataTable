-- chunkname: @modules/logic/weather/model/WeatherModel.lua

module("modules.logic.weather.model.WeatherModel", package.seeall)

local WeatherModel = class("WeatherModel", BaseModel)

function WeatherModel:onInit()
	return
end

function WeatherModel:reInit()
	self._curDayCo = nil
end

function WeatherModel:getZeroTime()
	local nowDate = self:getNowDate()

	nowDate.hour = 0
	nowDate.min = 0
	nowDate.sec = 0

	return (os.time(nowDate))
end

function WeatherModel:getWeekYday(nowDate)
	local wday = TimeUtil.convertWday(nowDate.wday)

	return nowDate.yday - wday
end

function WeatherModel:_initDay(sceneId)
	local zeroTime = self:getZeroTime()
	local weekId, dayId
	local weatherId = PlayerEnum.SimpleProperty.Weather
	local property = PlayerModel.instance:getSimpleProperty(weatherId)

	if LuaUtil.isEmptyStr(property) == false then
		local param = string.split(property, "#")
		local saveTime = tonumber(param[1])

		weekId = tonumber(param[2])
		dayId = tonumber(param[3])

		if zeroTime ~= saveTime then
			local nowDate = self:getNowDate()
			local saveDate = os.date("*t", saveTime)

			if self:getWeekYday(nowDate) ~= self:getWeekYday(saveDate) then
				weekId = nil
			end

			dayId = nil
		end
	end

	self._curDayCo, self._newWeekId, self._newDayId = WeatherConfig.instance:getDay(weekId, dayId, sceneId)

	if self._curDayCo.sceneId ~= sceneId then
		logError(string.format("WeatherModel:_initDay sceneId error result:%s param:%s", self._curDayCo.sceneId, sceneId))
	end

	if self._newDayId ~= dayId then
		local weatherStr = string.format("%s#%s#%s", zeroTime, self._newWeekId, self._newDayId)

		PlayerRpc.instance:sendSetSimplePropertyRequest(weatherId, weatherStr)
	end
end

function WeatherModel:debug(reportId, sceneId)
	return string.format("WeatherModel weekId:%s,dayId:%s,reportId:%s,sceneId:%s", self._newWeekId, self._newDayId, reportId, sceneId)
end

function WeatherModel:initDay(sceneId)
	if not sceneId then
		logError("WeatherModel:initDay sceneId nil")

		sceneId = MainSceneSwitchEnum.DefaultScene
	end

	if self._curDayCo and self._curDayCo.sceneId == sceneId then
		return
	end

	self:_initDay(sceneId)

	local reportListStr = self._curDayCo.reportList
	local reportList = string.split(reportListStr, "|")
	local reportCount = #reportList

	self._reportList = {}

	local zeroTime = self:getZeroTime()

	for i, v in ipairs(reportList) do
		local param = string.split(v, "#")
		local timeList = string.split(param[1], ":")
		local h = tonumber(timeList[1])
		local m = tonumber(timeList[2])

		if h and m then
			local endTime = zeroTime + (h * 60 + m) * 60

			if i == reportCount then
				endTime = endTime + math.random(21600)
			end

			local reportId = tonumber(param[2])
			local reportCo = WeatherConfig.instance:getReport(reportId)

			if reportCo then
				table.insert(self._reportList, {
					endTime,
					reportCo
				})
			end
		end
	end
end

function WeatherModel:getReport()
	local curReport, deltaTime = self:_getReport()

	if not curReport then
		if self._curDayCo then
			if not self._curDayCo.sceneId then
				do
					local sceneId = MainSceneSwitchEnum.DefaultScene

					self._curDayCo = nil

					self:initDay(sceneId)

					curReport, deltaTime = WeatherModel.instance:getReport()
				end

				if not curReport then
					logError("WeatherModel:getReport error no report")

					return lua_weather_report.configDict[1], 3600
				end
			end
		end
	end

	return curReport, deltaTime
end

function WeatherModel:_getReport()
	local curTime = os.time()

	for i, v in ipairs(self._reportList) do
		local endTime = v[1]

		if curTime < endTime then
			return v[2], endTime - curTime
		end
	end
end

function WeatherModel:getNowDate()
	return WeatherConfig.instance:getNowDate()
end

WeatherModel.instance = WeatherModel.New()

return WeatherModel
