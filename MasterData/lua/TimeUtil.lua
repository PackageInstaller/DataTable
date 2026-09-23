-- https://www.cnblogs.com/msxh/p/8955150.html
-- https://www.cnblogs.com/aimy88/p/6169926.html   
local this = {}

-- 时间戳（秒）
function this:GetTime()
    return CSAPI.GetServerTime()
end

-- 北京时区的时间戳（秒）
function this:GetBJTime(_origin)
    local origin = _origin or CSAPI.GetServerTime()
    local serverTimeZone = g_TimeZone or 8 -- 服务器时区
    local currTimeZone = os.difftime(os.time(), os.time(os.date("!*t", os.time()))) / 3600 -- 本地时区
    local serverTime = origin + (serverTimeZone - currTimeZone) * 60 * 60 -- 不受时区影响的服务器时间
    -- 考虑夏令时的影响
    local isDst = os.date("*t").isdst
    serverTime = serverTime - (isDst and 1 or 0) * 60 * 60
    return serverTime
end

-- 获取时区不同的时间差
function this:GetTZDiffTime()
    return self:GetBJTime() - self:GetTime()
end

-- 日期转时间
function this:GetTime2(_year, _month, _day, _hour, _minute, _second)
    local data = {
        year = _year,
        month = _month,
        day = _day,
        hour = _hour,
        minute = _minute,
        second = _second
    }
    if (data) then
        return os.time(data)
    end
end

-- 匹配获取
-- _time = this:GetTime
-- _typeStr = *t  >  返回table{year,month,day,hour,min,sec}
-- _typeStr = %Y:%m:%d %H:%M%S  >  返回 0000:00:00 00:00:00
function this:GetTimeHMS(_time, _typeStr)
    _typeStr = _typeStr or "*t"
    return os.date(_typeStr, _time)
end

-- -- 将字符串转换的本地时区的时间戳转成服务器时区的时间戳
-- function this:GetTimeStampBySplit(_str)
--     local serverTimeZone = g_TimeZone or 8 -- 服务器时区
--     local timestamp = GCalHelp:GetTimeStampBySplit(_str);
--     if timestamp == nil then
--         LogError("转换的时间不是有效时间！");
--         return 0;
--     end
--     local currTimeZone = os.difftime(os.time(), os.time(os.date("!*t", os.time()))) / 3600
--     -- 本地时区
--     local serverTime = timestamp - (serverTimeZone - currTimeZone) * 3600 -- 不受时区影响的服务器时间
--     local isDst = os.date("*t").isdst
--     serverTime = serverTime - (isDst and 1 or 0) * 60 * 60
--     return serverTime;
-- end

-- 匹配获取  
-- str:  年=year 月=month 。。。。 
function this:GetTime3(str, time)
    -- return os.date(str)
    time = time == nil and TimeUtil:GetTime() or time
    local timeData = TimeUtil:GetTimeHMS(time, "*t")
    return timeData[str]
end

-- 分割字符串 2018-11-12 10:30:18
function this:SplitTime(str)
    if not str then
        return 0
    end

    local rt = {}
    string.gsub(str, "%d+", function(w)
        table.insert(rt, w)
    end)
    return {rt[1], rt[2], rt[3], rt[4], rt[5], rt[6]}
end

-- -- sDate : 以字符分割的数字时间（顺序 年 月 日 时 分 秒）， 如：2018-11-12 10:30:18
-- function this:GetTimeStampBySplit(sDate)
-- 	if not sDate then
-- 		return 0
-- 	end
-- 	local rt = {}
-- 	string.gsub(
-- 	sDate,
-- 	"%d+",
-- 	function(w)
-- 		table.insert(rt, w)
-- 	end
-- 	)
-- 	local parm = {year = rt[1], month = rt[2], day = rt[3], hour = rt[4], min = rt[5], sec = rt[6]}
-- 	local dt = os.time(parm)
-- 	return dt
-- end
-- 秒转时间返回{day,hour,min,sec}
function this:GetTimeTab(_timer)
    if (_timer <= 0) then
        return {0, 0, 0, 0, 0, 0}
    else
        local num = 0 -- 秒
        local d = math.floor(_timer / 86400)
        num = _timer - d * 86400
        local h = math.floor(num / 3600)
        num = num - h * 3600
        local m = math.floor(num / 60)
        num = num - m * 60
        local s = num
        return {d, h, m, s}
    end
end

-- -- 秒数转时间: 00：00：00 (时间不能大于1天)
-- function this:GetTimeTab2(_timer)
--     if (_timer <= 0) then
--         return {"00", "00", "00"}
--     else
--         local num = 0 -- 秒
--         local d = math.floor(_timer / 86400)
--         num = _timer - d * 86400
--         local h = math.floor(num / 3600)
--         num = num - h * 3600
--         local m = math.floor(num / 60)
--         num = num - m * 60
--         local s = num
--         d = d < 10 and "0" .. d or d
--         h = h < 10 and "0" .. h or h
--         m = m < 10 and "0" .. m or m
--         s = s < 10 and "0" .. s or s
--         return {h, m, s}
--     end
-- end

-- 秒数转时间: 00：00：00
function this:GetTimeStr(_timer)
    if (_timer <= 0) then
        return "00:00:00"
    else
        local h = math.floor(_timer / 3600)
        local m = math.floor((_timer % 3600) / 60)
        local s = math.floor((_timer % 3600) % 60)
        h = h < 10 and "0" .. h or h
        m = m < 10 and "0" .. m or m
        s = s < 10 and "0" .. s or s
        return string.format("%s:%s:%s", h, m, s)
    end
end

-- 时间戳转日期:  2018-11-12   more: 2018-11-12 10:30:18
function this:GetTimeStr2(time, more)
    -- more = more == nil and true or more
    -- if(time == 0) then
    -- 	return ""
    -- else
    -- 	local str = self:GetTimeHMS(time)
    -- 	if(more) then
    -- 		local hour = str.hour < 10 and "0" .. str.hour or str.hour
    -- 		local min = str.min < 10 and "0" .. str.min or str.min
    -- 		return string.format("%s.%s.%s %s:%s:%s", str.year, str.month, str.day, hour, min, str.sec)
    -- 	else
    -- 		return string.format("%s.%s.%s", str.year, str.month, str.day)
    -- 	end
    -- end
    -- 优化写法
    more = more == nil and true or more
    if (time == 0) then
        return ""
    else
        if (more) then
            return os.date("%Y.%m.%d %H:%M:%S", time)
        else
            return os.date("%Y.%m.%d", time)
        end
    end
end

-- 秒数转时间:  2天 00：00：00
function this:GetTimeStr3(_timer)
    if (_timer <= 0) then
        return LanguageMgr:GetByID(33019, "0", "00:00:00")
        -- return string.format("%s%s %s", "0", "天", "00:00:00")
    else
        local d = math.floor(_timer / 86400)
        local str = self:GetTimeStr(_timer - d * 86400)
        return LanguageMgr:GetByID(33019, d, str)
        -- return string.format("%s%s %s", d, "天", str)
    end
end

-- 秒数转 时分 00:00
function this:GetTimeStr4(_timer)
    if (_timer and _timer <= 0) then
        return "00:00"
    else
        local h = math.floor(_timer / 3600)
        local m = math.floor((_timer % 3600) / 60)
        local s = math.floor((_timer % 3600) % 60)
        h = h < 10 and "0" .. h or h
        m = m < 10 and "0" .. m or m
        return string.format("%s:%s", h, m)
    end
end

-- 时间戳转日期   2018/11/12 10:30:18 AM
function this:GetTimeStr5(_timer)
    if (time == 0) then
        return "", 0
    else
        return os.date("%Y/%m/%d %H:%M", _timer), os.date("%S", _timer) -- return os.date("%Y/%m/%d %H:%M %p", _timer), os.date("%S", _timer)
    end
end

-- 时间转月  09
function this:GetTimeStr6(_timer)
    if (time == 0) then
        return "", 0
    else
        return os.date("%m", _timer)
    end
end

-- 秒数转时间: 00：00：00
function this:GetTimeStr7(_timer)
    if (_timer <= 0) then
        return "00:  00:  00"
    else
        local h = math.floor(_timer / 3600)
        local m = math.floor((_timer % 3600) / 60)
        local s = math.floor((_timer % 3600) % 60)
        h = h < 10 and "0" .. h or h
        m = m < 10 and "0" .. m or m
        s = s < 10 and "0" .. s or s
        return string.format("%s:  %s:  %s", h, m, s)
    end
end

-- 秒数转时间: 00：00：00
function this:GetTimeStr8(_timer)
    if (_timer <= 0) then
        return "00:00:00"
    else
        local h = math.floor(_timer / 3600)
        local m = math.floor((_timer % 3600) / 60)
        local s = math.floor((_timer % 3600) % 60)
        h = h < 10 and "0" .. h or h
        m = m < 10 and "0" .. m or m
        s = s < 10 and "0" .. s or s
        return string.format("%s:%s:%s", h, m, s)
    end
end

-- 秒数转 分秒 00:00
function this:GetTimeStr9(_timer)
    if (_timer and _timer <= 0) then
        return "00:00"
    else
        local m = math.floor(_timer / 60)
        local s = math.floor((_timer % 60))
        m = m < 10 and "0" .. m or m
        s = s < 10 and "0" .. s or s
        return string.format("%s:%s", m, s)
    end
end

-- 秒转  天:x天 -> 时分:00:00 -> 分秒:00:00
function this:GetTimeStr10(_timer)
    if (_timer <= 0) then
        return "00:00"
    else
        local d = math.floor(_timer / 86400)
        if (d > 0) then
            return d .. LanguageMgr:GetByID(11010)
        elseif (math.floor(_timer / 3600) > 0) then
            return self:GetTimeStr4(_timer)
        else
            return self:GetTimeStr9(_timer)
        end
    end
end

-- 返回简短时间描述，取当前最大单位的值做显示
function this:GetTimeShortStr(_timer)
    local hms = self:GetTimeHMS(_timer);
    local tab = {hms.day, hms.hour, hms.min, hms.sec};
    local str = "";
    local strs = StringUtil:split(LanguageMgr:GetByID(1094), ",") or {}
    for k, v in ipairs(tab) do
        if v > 0 then
            str = string.format("%s %s", v, strs[(k + 2)]);
            break
        end
    end
    return str;
end

-- 返回简短时间描述，取当前最大单位的值做显示
function this:GetTimeShortStr2(_timer)
    local hms = self:GetTimeTab(_timer);
    local tab = {hms[1], hms[2], hms[3], hms[4]};
    local str = "";
    local strs = StringUtil:split(LanguageMgr:GetByID(1094), ",") or {}
    for k, v in ipairs(tab) do
        if v > 0 then
            str = string.format("%s %s", v, strs[(k + 2)]);
            break
        end
    end
    return str;
end

-- 计算指定日期的星期值
function this:GetWeekDay(time)
    local timeData = TimeUtil:GetTimeHMS(time, "*t")
    local y = timeData["year"]
    local m = timeData["month"]
    local d = timeData["day"]
    if (m == 1 or m == 2) then
        m = m + 12
        y = y - 1
    end
    local week = (d + 2 * m + 3 * (m + 1) / 5 + y + y / 4 - y / 100 + y / 400 + 1) % 7
    week = math.floor(week)
    week = week == 0 and 7 or week
    return week, timeData
end

function this:GetWeekDay2(time)
    local week = tonumber(os.date("%w", time))
    week = week == 0 and 7 or week
    return week
end

-- 下一天0时1秒时间戳 curTimeData:当前服务器时间数据
function this:GetNextDay(curTimeData)
    curTimeData = curTimeData == nil and TimeUtil:GetTimeHMS(TimeUtil:GetTime()) or curTimeData
    local _time = TimeUtil:GetTime2(curTimeData.year, curTimeData.month, curTimeData.day, 24, 0, 0)
    _time = _time + 1
    return _time
end

-- 返回两个时间戳的时间差
function this:GetDiffHMS(t1, t2)
    local tab = {
        day = 0,
        hour = 0,
        second = 0
    };
    if t1 and t2 then
        local diff = t1 - t2;
        local d = math.modf(math.floor(diff / 86400));
        local h = math.modf(math.floor((diff % 86400) / 3600));
        local m = math.modf(math.floor((diff % 86400) % 3600 / 60));
        local s = math.modf((diff % 86400) % 3600 % 60);
        tab = {
            day = d,
            hour = h,
            minute = m,
            second = s
        };
    end
    return tab;
end

-- 获取下次重置时间戳 t-重置时长(秒)
function this:GetResetTime(t)
    return GCalHelp:GetCycleResetTime(PeriodType.Day, 1, TimeUtil:GetTime() - t) + t
end

-- 获取整个活动表的最小刷新时间
function this:GetRefreshTime(cfgStr, sTimeStr, eTimeStr)
    local timer = nil
    local cfgs = Cfgs[cfgStr]:GetAll()
    local curTime = TimeUtil:GetTime()
    for k, v in pairs(cfgs) do
        local sTime = v[sTimeStr] and TimeUtil:GetTimeStampBySplit(v[sTimeStr]) or nil
        local eTime = v[eTimeStr] and TimeUtil:GetTimeStampBySplit(v[eTimeStr]) or nil
        if (sTime and curTime < sTime) then
            if (timer == nil or timer > sTime) then
                timer = sTime
            end
        end
        if (eTime and curTime < eTime) then
            if (timer == nil or timer > eTime) then
                timer = eTime
            end
        end
    end
    return timer
end

function this:GetUTCNum()
    -- 获取当前时间的本地日期和时间
    local currentTime = os.time()
    local localTime = os.date("*t", currentTime)

    -- 获取本地时区偏移量
    local utcOffset = os.date("%z", currentTime)

    -- 解析时区偏移量的小时部分
    return tonumber(utcOffset:sub(1, 3))
end

-- 将字符串转换的本地时区的时间戳转成服务器时区的时间戳
function this:GetTimeStampBySplit(_str)
    local originalTime = GCalHelp:GetTimeStampBySplit(_str);

    local num = g_TimeZone - self:GetUTCNum()
    -- 计算时区偏移量（秒）
    local timeZoneOffsetSeconds = num * 3600

    -- 调整时间戳到服务器时区
    local time = originalTime - timeZoneOffsetSeconds
    return time
end

-- 某个月有多少天（下个月的第0天，也就是本月的最后一天）
function this:DaysInMonth(year, month)
    return os.date("*t", os.time({
        year = year,
        month = month + 1,
        day = 0
    })).day
end

-- 是否是同一天
function this:IsSameDay(_timeA, _timeB)
    local timeA = os.date("*t", _timeA)
    local timeB = os.date("*t", _timeB)
    return timeA.day == timeB.day
end

-- 获取两个时间戳的间隔天数（按3点跨天）
function this:GetActivyIntervalDay(startTime, endTime)
    endTime = endTime or self:GetTime()
    if startTime > endTime then
        startTime, endTime = endTime, startTime
    end

    local actZero1 = self:GetActivyDiffDayZero(startTime)
    local actZero2 = self:GetActivyDiffDayZero(endTime)

    -- 计算两个时间点各自距离其所在日期凌晨3点的秒数
    local diff1 = startTime - actZero1
    local diff2 = endTime - actZero2

    local days = math.floor((actZero2 - actZero1) / (86400))

    if diff1 < 0 and diff2 >= 0 then
        -- 判断是否需要加一天（如果startTime在凌晨3点之前，且endTime在凌晨3点之后）
        days = days + 1
    elseif diff1 >= 0 and diff2 < 0 then
        -- 如果startTime在第一天3点之后，endTime在第二天3点之前，需减少一天
        days = days - 1
    end
    return days
end

-- 获取当天活动零点时间(默认凌晨3点游戏刷新时间)
function this:GetActivyDiffDayZero(time, hour)
    local date = os.date("*t", time)
    date.hour = hour or g_ActivityDiffDayTime
    date.min = 0
    date.sec = 0
    return os.time(date)
end

-- 检测时间戳是否过了指定刷新点
function this:CheckRefreshByDay(time, refreshTime)
    if time == nil or time <= 0 then
        return false
    end
    refreshTime = refreshTime or g_ActivityDiffDayTime
    local offsetTab = TimeUtil:GetTimeTab(TimeUtil:GetTime() - time)
    if offsetTab[1] > 0 then -- 超过一天
        return true
    else
        local tab1 = TimeUtil:GetTimeHMS(time)
        local tab2 = TimeUtil:GetTimeHMS(TimeUtil:GetTime())
        if tab1.day == tab2.day then -- 同一天
            if tab1.hour < refreshTime and tab2.hour >= refreshTime then -- 刷新前后
                return true
            end
        elseif tab2.day > tab1.day then -- 前后一天
            if tab1.hour < refreshTime then -- 刷新前
                return true
            elseif tab2.hour >= refreshTime then -- 刷新后
                return true
            end
        end
    end
    return false
end

-- 距离下一次凌晨3点剩余多少小时
function this:HoursUntilNext3AM(time)
    -- 如果未传入 timestamp，默认使用当前时间
    time = time or os.time()

    -- 解析当前时间
    local now = os.date("*t", time)

    -- 构造今天凌晨3点的时间戳
    local today_3am = os.time({
        year = now.year,
        month = now.month,
        day = now.day,
        hour = 3,
        min = 0,
        sec = 0
    })

    -- 构造明天凌晨3点的时间戳
    local tomorrow_3am = today_3am + 24 * 3600

    -- 判断今天凌晨3点是否已经过去
    local next_3am
    if time < today_3am then
        -- 今天凌晨3点还没到
        next_3am = today_3am
    else
        -- 今天凌晨3点已过，等待明天凌晨3点
        next_3am = tomorrow_3am
    end

    -- 计算差值（秒）
    local diff_seconds = next_3am - time

    -- 转换为小时（向上取整）
    local diff_hours = math.ceil(diff_seconds / 3600)

    return diff_hours
end

-- 下一个整点小时的时间戳
function this:NextHourTimestamp(time)
    -- 如果未传入时间戳，默认使用当前时间
    time = time or os.time()

    -- 解析当前时间
    local dt = os.date("*t", time)

    -- 设置为当前小时的 0 分 0 秒
    local current_hour_start = os.time({
        year = dt.year,
        month = dt.month,
        day = dt.day,
        hour = dt.hour,
        min = 0,
        sec = 0
    })

    -- 下一个小时的开始时间
    local next_hour_start = current_hour_start + 3600 -- 加1小时（3600秒）

    return next_hour_start
end

-- 获取周几几点的时间戳
function this:NextWeekIndexTimeStamp(weekIndex, hour, time)
    if not weekIndex or not hour then
        return 0
    end
    time = time or self:GetTime()
    local curIndex = self:GetWeekDay2(time)
    local timeTab = self:GetTimeHMS(time)
    if curIndex == weekIndex and timeTab.hour < hour then -- 同一天
        return self:GetTime2(timeTab.year, timeTab.month, timeTab.day, hour, timeTab.min, timeTab.sec)
    else
        local offsetIndex = weekIndex - curIndex > 0 and weekIndex - curIndex or weekIndex - curIndex + 7
        return self:GetTime2(timeTab.year, timeTab.month, timeTab.day + offsetIndex, hour, timeTab.min, timeTab.sec)
    end
end

return this
