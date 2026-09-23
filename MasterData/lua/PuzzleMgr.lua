--拼图管理器
local this = MgrRegister("PuzzleMgr")

function this:Init()
    self:Clear() 
end

function this:SetData(proto)
    if proto then
        self.datas=self.datas or {}
        local info=PuzzleInfo.New();
        info:SetData(proto);
        self.datas[proto.id]=info;
    end
end

function this:GetData(id)
    if id and self.datas and self.datas[id] then
        return self.datas[id]
    end
    return nil;
end

function this:GetDataByType(type)
    if type and self.datas then
        for k,v in pairs(self.datas) do
            if v:GetType()==type then
                return v;
            end
        end
    end
    return nil;
end

function this:UpdateGridsInfo(proto)
    if proto and self.datas and self.datas[proto.id] then
        self.datas[proto.id]:UpdateGridsInfo(proto)
    end
end

function this:UpdateRwdIds(proto)
    if proto and self.datas and self.datas[proto.id] then
        self.datas[proto.id]:UpdateRwdIds(proto)
    end
end

function this:RefreshRedInfo(type)
    RedPointMgr:UpdateData(RedPointType["Puzzle"..type],self:CheckRedInfo(type));
end

function this:CheckRedInfo(type)
    local info=nil;
    if type then
        local d=self:GetDataByType(type)
        if d then
            if d:HasReward() then --存在奖励
                info=info or {}
                info.hasReward=true;
                return info;
            end
            if d:HasOverReward() then --全解锁
                return info
            end
            local isOnce=RedPointMgr:GetDayRedState(RedPointDayOnceType["PuzzleActivity"..d:GetType()])
            if isOnce then
                info=info or {}
                info.isOnce=true;
                return info;
            end
            local list=MissionMgr:GetActivityDatas(eTaskType.Puzzle,d:GetTaskType());
            if list then
                for k, v in pairs(list) do
                    local isGet = v:IsGet()
                    local isFinish = v:IsFinish()
                    if isFinish and not isGet then
                        info=info or {};
                        info.hasMission=true
                        return info;
                    end
                end
            end
        end
    end
    return info;
end

function this:GetNextInfo()
    local curTime = TimeUtil:GetTime();
    if self.nextInfo then
        if curTime <= self.nextInfo.time then
            return self.nextInfo
        end
    end
    local lessTime = nil;
    local tempTime=nil;
    local lessID = nil;
    self.nextInfo=nil;
    for k, v in ipairs(Cfgs.CfgPuzzleBase:GetAll()) do
        if v.begTime then
            local begTime = TimeUtil:GetTimeStampBySplit(v.begTime)
            if curTime < begTime and (lessTime == nil or (begTime - curTime) < lessTime) then
                lessTime = begTime - curTime
                tempTime=begTime
                lessID = v.id;
            end
        end
        if v.endTime then
            local endTime = TimeUtil:GetTimeStampBySplit(v.endTime)
            if curTime < endTime and (lessTime == nil or (endTime - curTime) < lessTime) then
                lessTime = endTime - curTime
                tempTime=endTime
                lessID = v.id;
            end
        end
    end
    if tempTime and lessID then
        self.nextInfo = {
            time = tempTime,
            id = lessID
        }
    end
    return self.nextInfo;
end

--根据类型和当前时间获取活动数据
function this:GetCurrPuzzleByType(type)
    if type and self.datas then
        local time=TimeUtil:GetTime();
        for k,v in pairs(self.datas) do
            local sTime=v:GetBeginTime() and TimeUtil:GetTimeStampBySplit(v:GetBeginTime()) or nil;
            local eTime=v:GetEndTime() and TimeUtil:GetTimeStampBySplit(v:GetEndTime()) or nil;
            if v:GetType()==type and (sTime == nil or time > sTime) then
                if (eTime == nil or time < eTime) then
                    return v;
                end
            end
        end
    end
    return nil;
end

function this:Clear()
    self.nextInfo=nil;
    self.datas=nil;
end

function this:MenuLTime(page)
    local begTime,endTime
    local info = self:GetCurrPuzzleByType(page);
    if info then
        begTime = info:GetBeginTime() and TimeUtil:GetTimeStampBySplit(info:GetBeginTime()) or nil;
        endTime = info:GetEndTime() and TimeUtil:GetTimeStampBySplit(info:GetEndTime()) or nil;
    end
    return begTime,endTime
end

return this 