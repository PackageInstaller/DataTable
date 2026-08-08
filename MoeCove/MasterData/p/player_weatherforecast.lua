-- Desc: 天气预报系统
---@class Player
local Player = require "Player"



local dayLen = 7    --一周天数
local wlen = dayLen * 24 * 60 * 60  --月份
---一天中的阶段 早晨 中午 黄昏
local dayParam = {
    "daylight", "dusk", "night",
}

---获取天气预报数据
function Player:GetWeatherForecastData()
    return self.weatherForecastData
end

---随机天气
function Player:CheckWeatherData(proto)
	local curTime = DLuaUtil.GetGreenwichTime()
    ---@type integer
    local nextRefreshTime = DLuaUtil.GetNextWeekTime(curTime)  --这个时间是减去北京时间
    local nextRefreshWeekTime = nextRefreshTime + DLuaUtil.GetTimeZone() * 60 * 60

    local weatherForecastData = self:GetWeatherForecastData()
    local c = weatherForecastData.nextRefreshTime - curTime

    if c > 0 then
        return
    end
    c = -c
    if c < wlen then
        --userData table 不能直接 等于 要克隆过去
        weatherForecastData.curWeekData = clone(weatherForecastData.nextWeekData)
        weatherForecastData.nextWeekData = {}
        self:RandomWeatherData(nextRefreshWeekTime, self.weatherForecastData.nextWeekData)
    else
        weatherForecastData.curWeekData = {}
        weatherForecastData.nextWeekData = {}
        local lastWeekRefreshTime = nextRefreshWeekTime - wlen
        self:RandomWeatherData(lastWeekRefreshTime, self.weatherForecastData.curWeekData)
        self:RandomWeatherData(nextRefreshWeekTime, self.weatherForecastData.nextWeekData)
    end

    weatherForecastData.nextRefreshTime = nextRefreshTime

    proto = proto or {}
    proto.weatherForecastData = weatherForecastData
end

---随机天气
---@param timeStamp integer
---@param tab DayWeatherData[]
function Player:RandomWeatherData(timeStamp, tab)
    for i = 1, dayLen do
        ---@type std.osdate
        local t = os.date("*t", timeStamp + (i-1) * 24 * 60 *60)
        local m = t.month
        local d = t.day

        tab[i] = {
            dayWeatherData = {}
        }

        local cfg = self:GetHomeWeatherCfgs(m, d)
        if cfg == nil then
           break 
        end
        for j = 1, #dayParam do
            local rv = math.random(1, 100)
            local randomWeather = cfg[dayParam[j] .. "Special"]
            local current  = 0
            local rcfg = nil
            for k = 1, #randomWeather do
                local r = randomWeather[k]
                current = current + r[2] 
                if rv <= current then
                    rcfg = r
                    break
                end
            end

            if rcfg == nil then
                tab[i].dayWeatherData[j] = {}
                goto continue
            end

            local duration = math.random(rcfg[3], rcfg[4])
            local sTime = cfg[dayParam[j]][1]
            local eIndex = j + 1
            local addTime = 0
            if eIndex > #dayParam then
               eIndex = 1
               addTime = 24 * 60 * 60
            end
            local eTime = cfg[dayParam[eIndex]][1] + addTime - 60 * 60    ---1小时隔天容差
            eTime = eTime - duration  --减去天气持续时间
            local beginTimeRange = eTime - sTime


            ---@type WeatherData
            local wd = {
                type = rcfg[5],
                startTime = math.floor(math.random(10 * 60, beginTimeRange)),
                durationTime = math.floor(math.random(rcfg[3] , rcfg[4]))
            }
            tab[i].dayWeatherData[j] = wd
            ::continue::
        end
    end
end

---@type HomeWeatherTable[]?
local weatherCfgs = nil
---初始化当前配置
---@param month integer
---@param day integer
function Player:GetHomeWeatherCfgs(month, day)
    if weatherCfgs == nil then
        weatherCfgs = {}
        local cfgs = Config.GetHomeWeatherTable()
        for k, v in pairs(cfgs) do
            table.insert(weatherCfgs, v)
        end
        table.sort(weatherCfgs, function(a, b)
		    return a.id < b.id
	    end)
    end
	local temp = month * 100 + day
	for i = 1 , #weatherCfgs do
        ---@type HomeWeatherTable
		local v = weatherCfgs[i]
		local s = v.startTime[1] * 100 + v.startTime[2]
		local e = v.endTime[1] * 100 + v.endTime[2]
		if(temp >= s and temp <= e) then
			return v
		end
	end
	return nil
end

---@param dayType integer 一天中的阶段 1-3 早晨 中午 黄昏 Client
---@return WeatherData?
function Player:GetCurrentSpecialWeatherData(dayType)
    local weatherForecastData = self:GetWeatherForecastData()
    if weatherForecastData == nil then
        LuaLogger.ds("weatherForecastData == nil")
        return nil
    end
    local serverTime = EngineUtil.ServerTime_Seconds()
	serverTime = serverTime + (Me:getTimeZone() or 8) * 3600		--转换成格林威治时间  --服务器时间差了8个小时

	serverTime = Mathf.Floor(serverTime)
	serverTime = serverTime + DLuaUtil.GetTimeZone() * 3600

 	---@type std.osdate
    local t = os.date("*t", serverTime)
	---第几周
    local week = t.wday
    week = week - 1
    if week == 0 then
        week = 7
    end

    if weatherForecastData.curWeekData == nil then
        LuaLogger.ds("curWeekData == nil")
        return nil 
    end
    if weatherForecastData.curWeekData[week] == nil then
        LuaLogger.ds("curWeekData[week] == nil")
        return nil 
    end
    if weatherForecastData.curWeekData[week].dayWeatherData == nil then
        LuaLogger.ds("dayWeatherData == nil")
        return nil
    end
    if weatherForecastData.curWeekData[week].dayWeatherData[dayType] == nil then
        LuaLogger.ds("dayWeatherData[dayType] == nil")
        return nil
    end
	local serverCfg = weatherForecastData.curWeekData[week].dayWeatherData[dayType]
    return serverCfg
end


---获得今明两天天气
---@return DayWeatherData[]
function Player:GetTodayAndTomorrowWeatherData()
    local weatherForecastData = self:GetWeatherForecastData()
    if weatherForecastData == nil then
        LuaLogger.ds("weatherForecastData == nil")
        return nil
    end
    local serverTime = EngineUtil.ServerTime_Seconds()
	serverTime = serverTime + (Me:getTimeZone() or 8) * 3600		--转换成格林威治时间  --服务器时间差了8个小时

	serverTime = Mathf.Floor(serverTime)
	serverTime = serverTime + DLuaUtil.GetTimeZone() * 3600

 	---@type std.osdate
    local t = os.date("*t", serverTime)
	---第几周
    local week = t.wday
    week = week - 1
    if week == 0 then
        week = 7
    end

    local tab = {}
    table.insert(tab, weatherForecastData.curWeekData[week])
    if week < 7 then
       table.insert(tab, weatherForecastData.curWeekData[week + 1])
    else
        table.insert(tab, weatherForecastData.nextWeekData[1])
    end

    return tab
end

return Player