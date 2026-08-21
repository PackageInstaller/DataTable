local EncounterHelper = {}

local function _FormatTimeWith5Am(createTick)
    --凌晨5点才跨天
    if createTick == nil  then 
        Logger.LogError("creatTick is nil")
        return 0
    end
    if createTick == 0 then 
        return 0 
    end
    createTick = createTick - 5 * 3600 
    local t = os.date("*t",createTick)
    t = os.time({year=t.year,month=t.month,day=t.day,hour=5})
    return t
end

--本周一凌晨5点
local function _FormatToMonday5am(tick)
    local t = os.date("*t",tick)
    local wday = t.wday  --星期几  星期天是1  
    local offsetFromMonday = wday - 1 
    if offsetFromMonday == 0 then 
        offsetFromMonday = 7
    end
    offsetFromMonday = offsetFromMonday - 1
    --周一是几号
    local createDay5am = os.time({year=t.year,month=t.month,day=t.day,hour=5})
    local createWeekMonday5am = createDay5am - offsetFromMonday * 24 *3600
    return createWeekMonday5am
end

--获得周期中，某个选区的剩余开放时间  (diffcuty从0开始 )，idx(从1开始)
local function GetZoneOpenTime( zoneCreateTick , diffculty,idx )
    zoneCreateTick = _FormatTimeWith5Am(zoneCreateTick)
    local arr = ConfigHelper.GetSystemParams(356)
    local day = 24 * 3600 
    if arr and arr.Length >= 3 and diffculty < arr.Length then 
        local intervel = arr[diffculty]
        return zoneCreateTick + ( idx - 1 ) *  intervel * day
    end
    return 0
end

-- 获得周期结束时间
local function GetZoneTimeRange( zoneCreateTick , diffculty )
    zoneCreateTick = _FormatTimeWith5Am(zoneCreateTick)
    local monday5pm = _FormatToMonday5am(zoneCreateTick)
    local arr = ConfigHelper.GetSystemParams(356)
    local day = 24 * 3600 
    if arr and arr.Length >= 3 and diffculty < arr.Length then 
        --下下周一结束
        return zoneCreateTick, monday5pm + 14 * 24 *3600 
    end
    return 0,0
end

--获得当前第几个周期，以及当前赛季最大周期 
local function GetCycleOrder(zoneCreateTick)
    --开服时间
    local startServer = IPlayerData.ServerLanuchTime
    --当前时间戳
    local startMondy5am = _FormatToMonday5am(startServer)
    
    --当前时间
    local curTime =  TimeUtil.GetNowTimeStamp() --_FormatTimeWith5Am(zoneCreateTick)
    --14天1个周期
    local cycle = ( curTime - startMondy5am ) / ( 14 * 24 * 3600 )
    cycle = math.ceil(cycle)
    cycle = (cycle - 1 )% 6 + 1
    return cycle , 6
end


EncounterHelper.GetZoneOpenTime = GetZoneOpenTime
EncounterHelper.GetZoneTimeRange = GetZoneTimeRange
EncounterHelper.GetCycleOrder = GetCycleOrder

return EncounterHelper