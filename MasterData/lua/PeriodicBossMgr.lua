PeriodicBossMgr = MgrRegister("PeriodicBossMgr")
local this = PeriodicBossMgr
PeriodicBossData = require "PeriodicBossData"

function this:Init()
    self:Clear()
    self:InitDatas()
    FightProto:GetPeriodicBossInfo()
end

function this:Clear()
    self.datas = nil
    self.refreshTime = 0
end

function this:InitDatas()
    self.datas = {}
    local cfgs = Cfgs.CfgPeriodicBoss:GetAll()
    if cfgs then
        for k, v in pairs(cfgs) do
            local data = PeriodicBossData.New()
            data:Init(v)
            self.datas[v.id] = data
        end
    end
end

function this:UpdateDatas(proto)
    self:UpdateDatasTime()
    if proto and proto.info and self.datas then
        for i, v in ipairs(proto.info) do
            if self.datas[v.id] then
                self.datas[v.id]:SetData(v)
            end
        end
    end
    EventMgr.Dispatch(EventType.PeriodicBoss_Panel_Update)
end

function this:GetArr()
    local infos = {}
    if self.datas then
        for k, v in pairs(self.datas) do
            table.insert(infos, v)
        end
    end
    if #infos > 0 then
        table.sort(infos, function(a, b)
            if a:IsOpen() == b:IsOpen() then
                return a:GetStartTime() < b:GetStartTime()
            else
                return a:IsOpen()
            end
        end)
    end
    return infos
end

function this:GetOpenData()
    if self.datas then
        for k, v in pairs(self.datas) do
            if v:IsOpen() then
                return v
            end
        end
    end
end

function this:UpdateDatasTime()
    local timeInfos = GCalHelp:GetPeriodicBossTimes(TimeUtil:GetTime())
    if timeInfos and #timeInfos > 0 and self.datas then
        for i, v in ipairs(timeInfos) do
            if self.datas[v.idx] then
                self.datas[v.idx]:SetTimeInfo(v)
            end
        end
    end
end

-- 获取最近的刷新时间
function this:GetRefreshTime()
    self:UpdateDatasTime()
    local time = 0
    if self.datas then
        local offset = math.huge
        for k, v in pairs(self.datas) do
            if TimeUtil:GetTime() < v:GetStartTime() and v:GetStartTime() - TimeUtil:GetTime() < offset then
                offset = v:GetStartTime() - TimeUtil:GetTime()
                time = v:GetStartTime()
            end
            if TimeUtil:GetTime() < v:GetDupOverTime() and v:GetDupOverTime() - TimeUtil:GetTime() < offset then
                offset = v:GetDupOverTime() - TimeUtil:GetTime()
                time = v:GetDupOverTime()
            end
            if TimeUtil:GetTime() < v:GetEndTime() and v:GetEndTime() - TimeUtil:GetTime() < offset then
                offset = v:GetEndTime() - TimeUtil:GetTime()
                time = v:GetEndTime()
            end
        end
    end
    return time + 1
end

function this:GetFakeLevel()
    return g_PeriodicBossRoleLevel or 80
end

function this:CheckRed()
    local isRed = false
    local openData = self:GetOpenData()
    if openData and not openData:IsOver() then
        isRed = openData:GetRealDamage() <= 0
    end
    return isRed
end

function this:CheckIsRefresh()
    if TimeUtil:GetTime() - self.refreshTime > 1800 then --超半个小时刷新一次
        self.refreshTime = TimeUtil:GetTime()
        return true
    end
    return false
end

return this
