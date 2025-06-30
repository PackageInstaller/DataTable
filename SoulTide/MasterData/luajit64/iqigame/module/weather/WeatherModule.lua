-- chunkname: @IQIGame\\Module\\Weather\\WeatherModule.lua

WeatherModule = {
	LATE = 5,
	DUSK = 3,
	NOON = 2,
	EARLY_MORNING = 1,
	NIGHT = 4
}

function WeatherModule.ReloadData(data)
	WeatherModule.currentWeatherCid = data
	WeatherModule.periodOfTime = WeatherModule.TimeInterval()

	LuaCodeInterface.SetWeather(WeatherModule.currentWeatherCid, WeatherModule.periodOfTime)

	if WeatherModule.timer == nil then
		WeatherModule.timer = Timer.New(function()
			WeatherModule.TimerUpdate()
		end, 60, -1)
	end

	WeatherModule.timer:Start()
end

function WeatherModule.TimerUpdate()
	local now = WeatherModule.TimeInterval()

	if now ~= WeatherModule.periodOfTime then
		WeatherModule.periodOfTime = now

		LuaCodeInterface.SetWeather(WeatherModule.currentWeatherCid, WeatherModule.periodOfTime)
		EventDispatcher.Dispatch(EventID.UpdatePeriodOfTime)
	end
end

function WeatherModule.TimeInterval()
	local index
	local cfgInfo = CfgMainCityWeatherTable[WeatherModule.currentWeatherCid]
	local time = getTimeText(PlayerModule.GetServerTime())
	local t = string.split(time, ":")
	local h = tonumber(t[1])

	for i = 1, #cfgInfo.Time do
		local cfgT = cfgInfo.Time[i]
		local startH = tonumber(cfgT[1])
		local endH = tonumber(cfgT[2])

		if startH <= h and h < endH then
			index = i

			break
		end
	end

	return index
end

function WeatherModule.NotifyWeather(weatherCid)
	WeatherModule.currentWeatherCid = weatherCid
	WeatherModule.periodOfTime = WeatherModule.TimeInterval()

	WeatherBGMModule.OnChangeWeather()
	LuaCodeInterface.SetWeather(WeatherModule.currentWeatherCid, WeatherModule.periodOfTime)
	EventDispatcher.Dispatch(EventID.UpdateWeather, WeatherModule.currentWeatherCid, PlayerModule.GetServerTime())
end

function WeatherModule.Shutdown()
	if WeatherModule.timer ~= nil then
		WeatherModule.timer:Stop()

		WeatherModule.timer = nil
	end
end
