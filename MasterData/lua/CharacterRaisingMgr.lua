local this = MgrRegister("CharacterRaisingMgr")

function this:Init()
    self:Clear()
    --初始化数据
    self.datas=self.datas or {};
    for k, v in ipairs(Cfgs.CfgRoleTrainGuide:GetAll()) do
        local data = CharacterRaisingInfo.New();
        data:InitCfg(v.id);
        self.datas[v.id] = data;
    end
    self.redRecordInfo=FileUtil.LoadByPath("CRActivityDailyTips.txt") or {};
    self.newInfo=FileUtil.LoadByPath("CRActivityNewInfo.txt") or {};
    self:CheckRed();
    TaskProto:GetRoleGuideBaseInfo();
end

function this:Update(proto)
    if proto and proto.infos then
        self.datas=self.datas or {};
        for k, v in ipairs(proto.infos) do
            if  self.datas[v.id]~=nil then
                self.datas[v.id]:SetData(v);
            else
                local data = CharacterRaisingInfo.New();
                data:SetData(v);
                self.datas[v.id] = data;
            end
        end
        self:CheckRed();
    end
end

function this:UpdateReward(proto)
    if proto then
        local data=self:GetData(proto.id);
        if data then
            local _d=data:GetData();
            if #_d.data==2 then
                _d.data[2]=proto.ix;
            elseif #_d.data==1 then
                table.insert(_d.data,proto.ix);
            end
            data:SetData(_d);
            self:CheckRed();
        end
    end
end

function this:GetFirstOpenInfo()
    local openTime,endTime=nil,nil;
    local _d=self:GetDatas(true);
    if _d and #_d>0 then
        local currTime=TimeUtil:GetTime();
        local tempOpen,tempEnd=nil,nil;
        for k, v in ipairs(_d) do
            local t1=v:GetStartTimeStamp();
            local t2=v:GetEndTimeStamp();
            if t1 and ((tempOpen~=nil and t1-currTime<tempOpen-currTime or tempOpen==nil)) then
                tempOpen=t1;
            end
            if t2 and tempEnd==nil then
                tempEnd=t2;
            elseif v:IsOpen() and t2 and ((tempEnd~=nil and t2-currTime>tempEnd-currTime)) then
                tempEnd=t2;
            end
        end
        openTime=tempOpen;
        endTime=tempEnd;
    end
    return openTime,endTime;
end

function this:CheckRed()
    local redList=nil;
    local info=self:GetDatas();
    if info then
        for k, v in ipairs(info) do
            local isRed=self:CheckDayRedInfoState(v);
            if v:HasTaskReward() then
                redList=redList or {};
                redList[v:GetID()]=redList[v:GetID()] or {};
                redList[v:GetID()].taskReward=true;
            end
            if isRed then
                redList=redList or {};
                redList[v:GetID()]=redList[v:GetID()] or {};
                redList[v:GetID()].commBuy=true;
            end
        end
    end
    RedPointMgr:UpdateData(RedPointType.CharacterRaising,redList)
end

--检查当前显示的列表中是否存在新活动
function this:CheckNewInfo()
    local infos=nil;
    local info=self:GetDatas();
    if info then
        local time=TimeUtil:GetTime();
        for k, v in ipairs(info) do
            if self.newInfo==nil or (self.newInfo~=nil and ((self.newInfo[v:GetID()] and time>=self.newInfo[v:GetID()]) or (self.newInfo[v:GetID()]==nil))) then
                infos=infos or {};
                infos[v:GetID()]=true;
            end
        end
    end
    return infos~=nil,infos;
end

function this:CheckDayRedInfoState(_d)
    local isRed=false;
    if _d~=nil then
        local reward,isLock=_d:GetCurrStageReward();
        local diff=false;
        if self.redRecordInfo==nil then
            diff=true;
        elseif self.redRecordInfo and ((self.redRecordInfo[_d:GetID()] and self.redRecordInfo.resetTime and TimeUtil:GetTime() >= self.redRecordInfo.resetTime) or self.redRecordInfo[_d:GetID()]==nil) then
            diff=true;
        end
        if reward and not _d:IsRevice(reward.id) and isLock~=true and diff then
            isRed=true;
        end
    end
    return isRed;
end

--记录红点状态，记录解锁礼包且未点击时的状态，每日只做一次判定,结构体：{resetTime=重置红点显示的时间，活动id1=true,活动id2={...}}
function this:RecordRedInfo(_redInfo,id)
    self.redRecordInfo=self.redRecordInfo or {};
    local hasChange=false;
    local now = os.date("*t", TimeUtil:GetTime())
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
    local resetTime=tomorrow_3am;
    if (self.redRecordInfo.resetTime~=nil and self.redRecordInfo.resetTime~=resetTime) or self.redRecordInfo.resetTime==nil then
        self.redRecordInfo={};
        self.redRecordInfo.resetTime=resetTime;
        hasChange=true;
    end
    --开始记录
    if _redInfo then
        for k, v in pairs(_redInfo) do
            if v.commBuy and (k==id or id==nil) then
                self.redRecordInfo[k] = true;
                hasChange=true;
            end
        end
    end
    if hasChange then
        FileUtil.SaveToFile("CRActivityDailyTips.txt", self.redRecordInfo)
    end
end

--记录new信息，当有新活动开启时，记录状态，每期做一次判定,结构体：{活动ID=当期活动结束时间戳，活动ID2={...}}
function this:RecordNewInfo()
    self.newInfo=self.newInfo or {};
    local _,newInfo = self:CheckNewInfo();
    if newInfo then
        for k, v in pairs(newInfo) do
            local _d=self:GetData(k);
            if _d then
                self.newInfo[k]=self.newInfo[k] or {};
                self.newInfo[k] = _d:GetEndTimeStamp();
            end
        end
    end
    FileUtil.SaveToFile("CRActivityNewInfo.txt", self.newInfo)
end

function this:GetData(id)
    if self.datas and self.datas[id] then
        return self.datas[id];
    end
end

function this:GetDatas(disFilter)
    local list={};
    if self.datas then
        for k,v in pairs(self.datas) do
            if v:IsOpen() or disFilter==true then
                table.insert(list,v);
            end
        end
    end
    return list;
end

function this:Clear()
    self.datas=nil;
    self.redRecordInfo=nil;
    self.newInfo=nil;
end

return this