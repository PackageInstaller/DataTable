AnniversaryMgr = MgrRegister("AnniversaryMgr")
local this = AnniversaryMgr;
AnniversaryData = require "AnniversaryData"

function this:Init()
    self:Clear()
    self:InitDatas()
    self:CheckRedPointData()
end

function this:Clear()
    self.datas = {}
end

function this:InitDatas()
    local cfgs = Cfgs.CfgAnniversary:GetAll()
    if cfgs then
        for _, cfg in pairs(cfgs) do
            local data = AnniversaryData.New()
            data:Init(cfg)
            self.datas[cfg.id] = data
        end
    end
end

function this:GetData(id)
    return self.datas[id]
end

function this:GetArr(group)
    local datas = {}
    for k, data in pairs(self.datas) do
        if not group or data:GetGroup() == group then
            if data:IsOpen() then
                table.insert(datas,data)
            end
        end
    end
    if #datas > 0 then
        table.sort(datas,function (a,b)
            return a:GetIndex() < b:GetIndex()
        end)
    end
    return datas
end

--获取下次界面刷新时间
function this:GetNextRefreshTime()
    local refreshTime = 0
    local sTime,eTime = 0,0
    for k, v in pairs(self.datas) do
        sTime,eTime = v:GetStartTime(),v:GetEndTime()
        if refreshTime == 0 or (sTime > TimeUtil:GetTime() and refreshTime > sTime) then
            refreshTime = sTime
        end
        if refreshTime == 0 or (eTime > TimeUtil:GetTime() and refreshTime > eTime) then
            refreshTime = eTime
        end
    end
    return refreshTime
end

---------------------------------------------red---------------------------------------------

function this:CheckRedPointData()
    local redData = nil
    if self.datas then
        for k, v in pairs(self.datas) do
            if self:CheckRed(v:GetID()) then
                redData = 1
                break
            end
        end
    end
    RedPointMgr:UpdateData(RedPointType.Anniversary,redData)
end

function this:CheckRed(id)
    if not id then
        return false
    end
    local data = self.datas[id]
    if data then
        if not data:IsOpen() then
            return false
        end
        if data:GetType() == AnniversaryListType.Main then
            local isRed= false
            local info = data:GetMissionInfo()
            if info then
                local datas = MissionMgr:GetActivityDatas(info[1], info[2])
                if datas then
                    for i, v in ipairs(datas) do
                        if v:IsFinish() and not v:IsGet() then
                            isRed = true
                            break
                        end
                    end
                end
            end
            return isRed
        elseif data:GetType() == AnniversaryListType.AccuCharge then
            local redData = RedPointMgr:GetData(RedPointType.AccuCharge3)
            return redData ~= nil and redData ~= 0
        elseif data:GetType() == AnniversaryListType.SignIn then
            local isOpen,id = ActivityMgr:IsOpenByType(ActivityListType.SignInAnniversary)
            if isOpen then
                local key = SignInMgr:GetDataKeyById(id)
                local signInfo = SignInMgr:GetDataByKey(key)
                return signInfo and not signInfo:CheckIsDone()
            end
        end
    end
    return false
end

--上报事件
function this:TrackEvents(_eventName)
    if _eventName == nil or _eventName == "" then
        return
    end
    local data = {
        time = TimeUtil:GetTime(),
        eventName = _eventName     
    }
    BuryingPointMgr:TrackEventsByDay(_eventName,data)
end

return this