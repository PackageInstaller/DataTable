local DailyGolasDataMgr = BaseClass("DailyGolasDataMgr", Singleton)
local M = DailyGolasDataMgr


function M:GetActivityData(callback)
    return ActivityDataMgr:GetInstance():GetActivityByTypeAsyn(ActivityType.DAILY_GOALS, callback)
end


function M:GetActivityScoreData(callback)
    return ActivityDataMgr:GetInstance():GetActivityByTypeAsyn(ActivityType.SEVENDAYSCORE, callback)
end


function M:GetTaskByActivityId(id)
    return self._taskCfg[id]
end


function M:GetTaskByDay(id, day)
    return self:GetTaskByActivityId(id)[day]
end


function M:CurDayRedPoint(day, activityId, data)
    local isShow = false
    local cfgData = self:GetTaskByDay(activityId, day)

    for k,kv in pairs(data) do
        local subData = MapUtil.Find(cfgData, function (v) return v.id == kv.SubActivityId end)
        if subData then
            isShow = (isShow or kv.State == 1)
        end
    end
    
    return isShow
end


function M:AllRedPoint(curDay, activityId, data)
    curDay = curDay > 7 and 7 or curDay 
    
    local isShow = false
    local mapFind = MapUtil.Find
    for i=1,curDay do
        local cfg = self:GetTaskByDay(activityId, i)

        for k,kv in ipairs(cfg) do
            local subData = mapFind(data, function (v) return v.SubActivityId == kv.id end) 
            if subData then
                isShow = (isShow or subData.State == 1) and true or false
            end
        end
    end

    return isShow
end


function M:__init()
    self._taskCfg = {}    
    self:_InitConfig()
end


function M:_InitConfig()
    local cfgData = ConfigHelper.GetCfgs("activitySevenDay")

    for k,v in pairs(cfgData) do
        if not self._taskCfg[v.activityId] then
            self._taskCfg[v.activityId] = {}
        end

        if not self._taskCfg[v.activityId][v.day] then
            self._taskCfg[v.activityId][v.day] = {}
        end

        table.insert(self._taskCfg[v.activityId][v.day], v)
    end

    self:_TaskSort()
end


function M:_TaskSort()
    for i,v in ipairs(self._taskCfg) do
        self:_Sort(v)
    end
end


function M:_Sort(data)
    table.sort(data, function (v1, v2)
        local o1 = v1.order
        local o2 = v2.order
        return o1 < o2
    end)
end


return DailyGolasDataMgr