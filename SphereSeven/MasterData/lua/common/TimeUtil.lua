local Time = CS.UnityEngine.Time

local TimeUtil={}
local ServerTimeZone = 3600 * 8
local LocalTimeZone=nil
TimeUtil.LeadTime=0
TimeUtil.difftime=0
TimeUtil.Message = ""

local time = 0
local delay = 1
local osTime = nil

local SERVER_BEGIN_OFFSET = tonumber(Z_Misc["SERVER_BEGIN_OFFSET"].Value[1])

--- 时间戳
TimeUtil.ServerTime = 0
local trueServerTime = nil
--- 相对server的时区偏移(s) 使用时 时间戳+timeOffset
TimeUtil.TimeOffset = 0

TimeUtil.id = 0
TimeUtil.countDownList = {}
if TimeType == nil then
	TimeType = 
	{
		One = 1, -- 剩余xx天 剩余xx时 剩余xx分
		Two = 2,
	}
end

--获取服务器时间
function TimeUtil.CoLoadData()
	osTime = nil
	local sendTime = Time.time
	local rr= coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
				OuterOpcode.Name2Code.ETModel_C2G_ServerDate, {})
	local acceptTime = Time.time
	local deltaTime = math.ceil((acceptTime - sendTime) / 2)
	if rr.Error == ErrorCode.ERR_Success then
		--实际是数据返回是数据返回时间差
		TimeUtil.LeadTime = rr.Timestamp + deltaTime - os.time()
		osTime = os.time()
		--时区差
		TimeUtil.difftime =os.difftime(os.time(), os.time(os.date("!*t", os.time())))/3600
		ServerTimeZone =rr.TimeZoneSeconds
		local date = TimeUtil.ServerDate("*t",rr.Timestamp)
		TimeUtil.Message = date.month.."/"..date.day.."/"..date.year.." ".. date.hour..":"..date.min..":"..date.sec
	end
	return coroutine.yieldbreak(rr)
end

-- 监测时间 并校准
function TimeUtil.Update()
	if not TimeUtil.ServerTime then
		return
	end
	trueServerTime = trueServerTime + Time.unscaledDeltaTime
	if TimeUtil.ServerTime ~= math.floor(trueServerTime) then
		TimeUtil.ServerTime = math.floor(trueServerTime)
	end
end

-- 跟服务器做了插值，玩家不修改系统时间，则就是服务器的时间
function TimeUtil.OSTime()
	return TimeUtil.LeadTime + os.time()
end

----------------------------------2023 新接口 ---------------------------------------------
function TimeUtil.SetServerTime(time)
	if time == nil or time == 0 then
		return
	end
	trueServerTime = time
	TimeUtil.ServerTime = time
end

function TimeUtil.SetTimeOffset(gmsOffset)
	if gmsOffset == nil then gmsOffset = 0 end

	-- 获取当前时间戳
	local currentTimestamp = os.time()
	-- 获取UTC时间戳
	local utcTimestamp = os.time(os.date("!*t", currentTimestamp))
	-- 计算时区偏移量
	local timezoneOffsetSeconds = currentTimestamp - utcTimestamp
	TimeUtil.TimeOffset = gmsOffset - timezoneOffsetSeconds
end

local MonthDayCount = {
	31, 28, 31, 30, 31, 30,
	31, 31, 30, 31, 30, 31
}

---@class time
---@field year number @ 年份
---@field month number @ 月份（1-12）
---@field day number @ 日期（1-31）
---@field hour number @ 小时（0-23）
---@field min number @ 分钟（0-59）
---@field sec number @ 秒（0-59）
---@field wday number @ 星期几（1-7 分别表示周日到周六）
---@field yday number @ 一年中的第几天（1表示1月1日）
---@field isdst boolean @ 是否处于夏令时（通常为一个布尔值）

--- 获取所对应服务器时间 ( 刷新时间前为前一天, 例如4点刷新, 3月2号4点前 为 3月1号, 4点后为3月2号 ).
---@param time number | nil @ 时间戳. 如果为nil就是当前时间
---@return time @ 逻辑上日期
function TimeUtil.GetServerTimeSplitData(time, isServerTime)
	if time == nil then
		if TimeUtil.ServerTime == nil then
			-- 一般只会出现在mock下 ( 没有serverTime )
			time = TimeUtil.OSTime()
		else
			time = TimeUtil.ServerTime
		end
	end

	if isServerTime == nil then isServerTime = true end

	local seconds = time + TimeUtil.TimeOffset -- 时间戳

	local time = os.date("*t", seconds)
	if isServerTime then
		if time.hour < SERVER_BEGIN_OFFSET then
			-- 如果当前时间早于目标小时
			time.day = time.day - 1
			time.wday = time.wday - 1
			time.yday = time.yday - 1
	
			if time.day == 0 then
				time.month = time.month - 1
				time.day = MonthDayCount[time.month]
				if time.month == 0 then
					time.year = time.year - 1
					time.month = 12
				end
			end
			if time.wday == 0 then
				time.wday = 7
			end
			if time.yday == 0 then
				time.yday = 365
			end
		end
	end
	
	return time
end

function TimeUtil.GetServerTime()
	if TimeUtil.ServerTime == nil then
		return TimeUtil.OSTime()
	else
		return TimeUtil.ServerTime
	end
end

--- 获取到下一个周x 4点的秒数  不填就是明天( 这里没默认周一 )
---@return number @ 秒数
---@param weekDay number | nil @ 星期几的4点（1表示周一，2表示周二，以此类推，7表示周日） nil 表示明天的4点
function TimeUtil.GetWeekLastSeconds(weekDay)

	local time = TimeUtil.GetServerTimeSplitData()

    -- 计算距离下一个目标时间的秒数
    local secondsUntilTarget

    if weekDay == nil then
        -- 如果未提供目标周几，则计算距离下一个目标小时的秒数
        if time.hour < SERVER_BEGIN_OFFSET then
            -- 如果当前时间早于目标小时，或者当前时间正好是目标小时但没有到达目标分钟
            secondsUntilTarget = (SERVER_BEGIN_OFFSET - time.hour) * 3600 - time.min * 60 - time.sec
        else
            -- 否则，距离下一个目标小时应该是明天的目标小时
            secondsUntilTarget = (24 - time.hour + SERVER_BEGIN_OFFSET) * 3600 - time.min * 60 - time.sec
        end
    else
        -- 如果提供了目标周几，计算距离下一个目标周几的目标小时的秒数
        local currentWeekDay = time.wday
        local daysUntilTargetWeekDay = (weekDay - currentWeekDay + 7 + 1) % 7 -- 差了几天 0 就是今天
		if daysUntilTargetWeekDay == 0 and time.hour >= SERVER_BEGIN_OFFSET then
			daysUntilTargetWeekDay = 7 -- 今天超了4点 就是7天后了
		end
		if daysUntilTargetWeekDay == 0 and time.hour < SERVER_BEGIN_OFFSET then
			daysUntilTargetWeekDay = 7 -- 今天超了4点 就是7天后了
		end

		if daysUntilTargetWeekDay > 0 and time.hour < SERVER_BEGIN_OFFSET then
			daysUntilTargetWeekDay = daysUntilTargetWeekDay - 1 -- 今天超了4点 就是7天后了
		end
        secondsUntilTarget = daysUntilTargetWeekDay * 24 * 3600 + (SERVER_BEGIN_OFFSET - time.hour) * 3600 - time.min * 60 - time.sec
    end

    return secondsUntilTarget
end

--- 获取到下一个 x号 4点的秒数  不填就是1号
---@return number @ 秒数
---@param weekDay number | nil @ 获取到下一个 x号 4点的秒数  不填就是1号
function TimeUtil.GetMonthLastSeconds(day)
	if day == nil then day = 1 end

	local time = TimeUtil.GetServerTimeSplitData()

	local time1 = os.time(time)
	local time2

	if time.day >= day then
		-- 今天超过了目标天数, 说明是下个月
		local month = time.month + 1
		local year = time.year
		if month > 12 then
			month = 1
			year = year + 1
		end

		time2 = os.time({year = year, month = month, day = day, hour = SERVER_BEGIN_OFFSET, min = 0, sec = 0})
	else
		-- 今天没超过目标天数
		time2 = os.time({year = time.year, month = time.month, day = day, hour = SERVER_BEGIN_OFFSET, min = 0, sec = 0})
	end
	
	local offset = 0
	if time.hour < SERVER_BEGIN_OFFSET then
		offset = - 24 * 3600
	end

	return time2 - time1 + offset
end

---@param second number @ 秒数
---@return {day:number, hour:number, minute:number, second:number} @ 时间信息
function TimeUtil.ConvertTimeForm(second)
    if second < 0 then second = 0 end
    local tb = {}
    tb.day     = math.floor(second/86400)--math.modf(s/(24*60*60))
    tb.hour    = math.fmod(math.floor(second/3600), 24)--math.modf(s/(60*60))
    tb.minute  = math.fmod(math.floor(second/60), 60)--math.modf(s/60%60)
    tb.second  = math.floor(math.fmod(second, 60))-- math.modf(s%60)
    return tb
end

---------------------------------------------------------------------------------------------

-- API:距离下一次零点更新时间戳
-- nextZeroNum : 往后推多少个零点
function TimeUtil.NextZeroTime(nextZeroNum, userTime)
	userTime = userTime or TimeUtil.OSTime() -- 默认是服务器时间
	if nextZeroNum == nil or nextZeroNum < 1 then
		nextZeroNum = 1
	end
	local updateHour = 4
	local tab = os.date("*t", userTime)
	nextZeroNum = tab.hour < updateHour and nextZeroNum - 1 or nextZeroNum
	tab.hour = updateHour
	tab.min  = 0
	tab.sec  = 0
	local t2 = os.time(tab) + nextZeroNum * 24 * 60 * 60
	return t2
end

--- 将秒数转换为day. hour. minute. second
---@return {day:number, hour:number, minute:number, second:number} @ 时间信息
function TimeUtil.ConvertTimeForm(second)
	if second < 0 then second = 0 end
	local tb = {}
	tb.day     = math.floor(second/86400)--math.modf(s/(24*60*60))
	tb.hour    = math.fmod(math.floor(second/3600), 24)--math.modf(s/(60*60))
	tb.minute  = math.fmod(math.floor(second/60), 60)--math.modf(s/60%60)
	tb.second  = math.floor(math.fmod(second, 60))-- math.modf(s%60)
	return tb
end

-- 进入界面：获取计时器id
function TimeUtil.GetCountDownId()
	TimeUtil.id = TimeUtil.id + 1
	TimeUtil.countDownList[TimeUtil.id] = {}
	return TimeUtil.id
end

-- 退出界面：移除计时
function TimeUtil.RemoveCountDown(id)
	TimeUtil.countDownList[id] = nil
	if table.count(TimeUtil.countDownList) <= 0 and TimeUtil.timer ~= nil then
		TimeUtil.timer:Stop()
		TimeUtil.timer = nil
	end
end

-- 绑定更新需要计时text：倒计时id，数据唯一id（避免重复绑定），data = {type(倒计时格式), text(组件), endTime(截止时间戳), callback(更新回调)}
function TimeUtil.BindTime(countDownId, dataId, data)
	if TimeUtil.countDownList[countDownId] == nil then
		TimeUtil.countDownList[countDownId] = {}
	end
	for k, v in pairs(TimeUtil.countDownList[countDownId]) do
		if v.text == data.text then
			TimeUtil.countDownList[countDownId][k] = nil
			break
		end
	end
	TimeUtil.countDownList[countDownId][dataId] = data
	if IsNull(data.text) then
		Logger.LogError("data need text")
	end
	if data.type == nil then
		Logger.LogError("data need type")
	end
	if data.endTime == nil then
		Logger.LogError("data need endTime")
	end
	if TimeUtil.timer == nil then
		TimeUtil.timer = TimerManager:GetInstance():GetTimer(1, TimeUtil.UpdatePerSecond, TimeUtil)
		TimeUtil.timer:Start()
	end
	return TimeUtil.CountDown(data) -- 返回计时内容
end

function TimeUtil.UpdatePerSecond()
	table.walk(TimeUtil.countDownList, function (k, tab)
		table.walk(tab, function (key, data)
			TimeUtil.CountDown(data)
			if data.callback ~= nil then
				data.callback()
			end
		end)
	end)
end

-- 更新时间：倒计时类型  截止时间戳
function TimeUtil.CountDown(data)
	local remainTime = os.difftime(data.endTime, TimeUtil.OSTime())
	local timeTab = TimeUtil.ConvertTimeForm(remainTime)
	if not IsNull(data.text) then
		data.text.text = TimeUtil.CountDownFormat(data.type, timeTab)
		return data.text.text
	end
	return ""
end

-- 倒计时显示格式
function TimeUtil.CountDownFormat(type, timeTab)
	local func1 = function (tab)
		if tab.day >= 1 then
			return LangUtil.GetSysLang(3118).." "..tab.day.." "..LangUtil.GetSysLang(2005)--剩余
		elseif tab.hour >= 1 then
			return LangUtil.GetSysLang(3118).." "..tab.hour.." "..LangUtil.GetSysLang(2007)
		else
			return LangUtil.GetSysLang(3118).." "..tab.minute.." "..LangUtil.GetSysLang(2065)
		end
	end
	local func2 = function (tab)
		if tab.day > 0 then
			local str = string.gsub(LangUtil.GetSysLang(885), "XX", tab.day)--离重置还剩XX天YY小时
			return string.gsub(str, "YY", tab.hour)
		else
			local str = string.gsub(LangUtil.GetSysLang(886), "XX", tab.hour)--离重置还剩XX小时YY分
			return string.gsub(str, "YY", tab.minute)
		end
	end
	if type == TimeType.One then
		return func1(timeTab)
	elseif type == TimeType.Two then
		return func2(timeTab)
	end
	return nil
end

function TimeUtil.getNewDate(srcDateTime,interval ,dateUnit)
	--根据时间单位和偏移量得到具体的偏移数据
	local ofset=0
	if dateUnit =='DAY' then
		ofset = 60 *60 * 24 * interval

	elseif dateUnit == 'HOUR' then
		ofset = 60 *60 * interval

	elseif dateUnit == 'MINUTE' then
		ofset = 60 * interval
	elseif dateUnit == 'SECOND' then
		ofset = interval
	end
	--指定的时间+时间偏移量
	return srcDateTime + tonumber(ofset)
end
--
function TimeUtil.Date(format, timestamp)
	return os.date(format, timestamp)
end
-- 替代os.date函数，忽略本地时区设置，按服务器时区格式化时间
-- @param format: 同os.date第一个参数
-- @param timestamp:服务器时间戳
function TimeUtil.ServerDate(format, timestamp)
	local timeZoneDiff = ServerTimeZone - TimeUtil.GetLocalTimeZone()
	local nt=timestamp + timeZoneDiff
	return os.date(format, nt)
end
-- 替代os.time函数，忽略本地时区设置，返回服务器时区时间戳
-- @param timedata: 服务器时区timedate
function TimeUtil.Time(timedate)
	local timeZoneDiff = ServerTimeZone - TimeUtil.GetLocalTimeZone()
	return os.time(timedate) - timeZoneDiff
end
-- 获取客户端本地时区
--lua里没有直接获取本地时区的api，但通过os.date("!*t", os.time())，可以获取格林尼治的时间table
--再以本地时区解析table获取时间戳，该时间戳与os.time()时间戳相减即为时区秒数差值
function TimeUtil.GetLocalTimeZone()
	if LocalTimeZone ~= nil then
		return LocalTimeZone
	end
	local now = os.time()
	local localTimeZone = os.difftime(now, os.time(os.date("!*t", now)))
	local isdst = os.date("*t", now).isdst
	if isdst then localTimeZone = localTimeZone + 3600 end
	LocalTimeZone=localTimeZone
	return localTimeZone
end
--指定日期的本地区时间戳
function TimeUtil.DateToTime(year,month,day,hour,minute,second)
	return os.time({day=day, month=month, year=year, hour=hour, minute=minute, second=second})
end
--时间格式 yyyyMMddHHmmss-输出 2019-01-30 10:47 53
function TimeUtil.FormatTime(time,year,month,day,hour,minute,second)
	year=year or "-"
	month=month or "-"
	day=day or " "
	hour=hour or ":"
	minute=minute or " "
	second = second  or ""
	return os.date("%Y"..year.."%m"..month.."%d"..day.."%H"..hour.."%M"..minute.."%S"..second, time)
	--[[
    --print(os.date("%m月%d日  %H:%M", os.time())) --输出  01月30日  10:44]]
end
--转成年月日接口
function TimeUtil.FormatUnixTime2Date(unixTime)
	if unixTime and unixTime >= 0 then
		local tb = {}
		tb.year = tonumber(os.date("%Y",unixTime))
		tb.month =tonumber(os.date("%m",unixTime))
		tb.day = tonumber(os.date("%d",unixTime))
		tb.hour = tonumber(os.date("%H",unixTime))
		tb.minute = tonumber(os.date("%M",unixTime))
		tb.second = tonumber(os.date("%S",unixTime))
		return tb
	end
end

function TimeUtil.ParseDateTime(dateTimeStr)
	local pattern = "(%d+)%/(%d+)%/(%d+) (%d+):(%d+):(%d+)"
	local year, month, day, hour, min, sec = dateTimeStr:match(pattern)
	return os.time({year=year, month=month, day=day, hour=hour, min=min, sec=sec})
end

function TimeUtil.convertToTimestamp(day, month, year, hour, min, sec)
    return os.time({day=day, month=month, year=year, hour=hour, minute=min, second=sec})
end

return TimeUtil