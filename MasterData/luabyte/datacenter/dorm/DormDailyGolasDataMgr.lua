local DormDailyGolasDataMgr = BaseClass("DormDailyGolasDataMgr", Singleton)
local M = DormDailyGolasDataMgr


function M:GetActivityData(callback)
    return ActivityDataMgr:GetInstance():GetActivitysByTypeAsyn(ActivityType.DORM_DAILY_GOALS, callback)
end

function M:GetTaskByActivityId(id)
    return self._taskCfg[id]
end


function M:GetTaskByDay(id, day)
    return self:GetTaskByActivityId(id)[day]
end


function M:CurRedPoint(id, data)
    local isShow = false

    for k,kv in pairs(data) do
        if kv.SubActivityId == id then
            return kv.State == 1
        end
    end
    
    return isShow
end

function M:AllRedPoint(data)
    local isShow = false

    for k,kv in pairs(data) do
        isShow = (isShow or kv.State == 1)
    end

    return isShow
end


function M:__init()
    self._taskCfg = {}
    self.activityIds = {}    
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
    
    local roleRoomCfgs = ConfigHelper.GetCfgsByLua("roleRoom")
    for key, value in pairs(roleRoomCfgs) do
        if value.activityId > 0 then
            table.insert(self.activityIds, value.activityId)
        end
    end
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


return DormDailyGolasDataMgr