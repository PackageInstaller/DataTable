local this = MgrRegister("ExplorationMgr")

--初始化，根据最新的id获取勘探数据
function this:Init()
    if isRefersh or self.currData==nil then
        local currTime=TimeUtil:GetTime();
        for k,v in pairs(Cfgs.CfgExploration:GetAll()) do 
            if self:TimeIsBetween(v.startTime,v.endTime,currTime) then --同一时间段内只会有一个大月卡
                ExplorationProto:GetInfo(v.id);
                break;
            end
        end
    end
    PermitProto:GetInfo(-1);
end

function this:UpdateExInfo(proto)
    if proto and proto.list then
        self.exInfo=self.exInfo or {}
        for k,v in ipairs(proto.list) do
            local exData=SpecialExplorationData.New();
            exData:SetData(v)
            self.exInfo[v.id]=exData;
        end
        ExplorationMgr:CheckExRedInfo();
    end
end

function this:UpdateExRewardInfo(proto)
    if proto and self.exInfo and self.exInfo[proto.id] then
        self.exInfo[proto.id]:UpdateGets(proto.gets);
        ExplorationMgr:CheckExRedInfo();
    end
end

function this:GetExData(id)
    local exData=nil
    if self.exInfo and id and self.exInfo[id] then
        exData=self.exInfo[id];
    end
    return exData;
end

function this:SetCurrData(proto)
    if proto and proto.id~=nil then
        self.currData=ExplorationData.New();
        self.currData:SetCfg(proto.id);
        self.currData:SetData(proto);
        --LogError(proto.get_infos)
        self:CheckRedInfo()
    else
        self.currData=nil;
    end
    EventMgr.Dispatch(EventType.Exploration_Init_Data)
end

function this:CanOpenExploration()
    if self.currData~=nil and self.currData:GetData()~=nil then
        return true;
    end
    return false;
end

--更新数据
function this:Update(proto)
    if proto then
        if self.currData and proto.id==self.currData:GetCfgID() then
            local data=self.currData:GetData();
            data.lv=proto.lv;
            data.exp=proto.exp
            data.can_get_cnt=proto.can_get_cnt;
            data.ex_can_get_cnt=proto.ex_can_get_cnt;
            self.currData:SetData(data);
        else
            self.currData=ExplorationData.New();
            self.currData:SetCfg(proto.id);
            self.currData:SetData(proto);
        end
        self:CheckRedInfo()
    end
    EventMgr.Dispatch(EventType.Exploration_Update_Data)
end

--返回当前勘探活动数据
function this:GetCurrData()
    return self.currData or nil;
end

--返回当前解锁状态
function this:GetCurrState()
    return self:GetCurrData() and self:GetCurrData():GetState() or false;
end

--领取回调
function this:OnRewardRet(proto)
    if self.currData and proto then
        local data=self.currData:GetData();
        if data.get_infos==nil then
            data.get_infos={};
        end
        if proto.get_infos then
            for k,v in pairs(proto.get_infos) do
                data.get_infos[k]=data.get_infos[k] or {};
                data.get_infos[k].rid=data.get_infos[k].rid or v.rid;
                data.get_infos[k].gets=data.get_infos[k].gets or {};
                for _,val in ipairs(v.gets) do
                    table.insert(data.get_infos[k].gets,val);
                end
            end
        end
        self:GetCurrData():SetData(data);
        self:CheckRedInfo()
    end
    EventMgr.Dispatch(EventType.Exploration_Reveice_Ret,proto)
end

--升级回调
function this:OnUpgradeRet(proto)
    if proto then
        if self.currData and proto.id==self.currData:GetCfgID() then
            local data=self.currData:GetData();
            data.lv=proto.lv;
            self.currData:SetData(data);
        else
            self.currData=ExplorationData.New();
            self.currData:SetCfg(proto.id);
            self.currData:SetData(proto);
        end
        self:CheckRedInfo()
    end
    EventMgr.Dispatch(EventType.Exploration_Upgrade_Ret)
end

function this:OnOpenRet(proto)
    if proto then
        if self.currData and proto.id==self.currData:GetCfgID() then
            local data=self.currData:GetData();
            data.type=proto.type;
            self.currData:SetData(data);
        else
            self.currData=ExplorationData.New();
            self.currData:SetCfg(proto.id);
            self.currData:SetData(proto);
        end
        self:CheckRedInfo()
    end
    EventMgr.Dispatch(EventType.Exploration_Open_Ret)
end

--是否在时间段内
function this:TimeIsBetween(startTime,endTime,currentTime)
    if currentTime==nil then
        currentTime=TimeUtil:GetTime();
    end
    local sTime=startTime==nil and 0 or TimeUtil:GetTimeStampBySplit(startTime);
	local eTime=endTime==nil and 0 or TimeUtil:GetTimeStampBySplit(endTime);
    if (sTime==0 or currentTime >= sTime) and (eTime==0 or currentTime < eTime) then
        return true;
    end
    return false;
end

--是否有返回红点信息,为空没有红点信息 {hasReward=是否有奖励未领取，taskTypes=各分页是否有未领取的奖励}
function this:GetRedInfo()
    local info=nil;
    local curData=self:GetCurrData();
    if curData then
        --奖励判定
        local state=curData:GetState();
        local rewards={};
        table.insert(rewards,curData:GetBaseRewardCfgs());
        if state>=ExplorationState.Ex then
            table.insert(rewards,curData:GetExRewardCfgs());
        end
        for k, v in ipairs(rewards) do
            for _,val in ipairs(v) do
                if val:GetState()==ExplorationRewardState.Available then
                    info=info or {};
                    info.hasReward=true;
                    break;
                end
            end
        end
        if curData:GetInfiniteRewardNum() and curData:GetInfiniteRewardNum()>0 then
            info=info or {};
            info.hasInfiniteReward=true;
        end
        if curData:HasInfiniteLv() or curData:IsMaxLv()~=true then --满级以后且没有无限等级的情况下不显示红点
            --任务判定
            local has1=MissionMgr:HasExplorationGet(eTaskType.DayExplore);
            local has2=MissionMgr:HasExplorationGet(eTaskType.WeekExplore);
            local has3=MissionMgr:HasExplorationGet(eTaskType.Explore);
            if has1 or has2 or has3 then
                info=info or {};
                info.taskTypes={};
                table.insert(info.taskTypes,has1 or false);
                table.insert(info.taskTypes,has2 or false);
                table.insert(info.taskTypes,has3 or false);
            end
        end
    end
    return info;
end

function this:CheckRedInfo()
    RedPointMgr:UpdateData(RedPointType.Exploration, self:GetRedInfo())
end

function this:CheckExRedInfo()
    local redInfo=nil
    if self.exInfo then
        redInfo={};
        for k,v in pairs(self.exInfo) do
            redInfo=redInfo or {}
            redInfo[k]=v:HasRevice() and 1 or nil;
        end
    end
    -- 关卡
    if MenuMgr.isInit then --防止未初始化完成就检测数据
        DungeonMgr:CheckRedPointData()
    end
    RedPointMgr:UpdateData(RedPointType.SpecialExploration, redInfo)
end

function this:Clear()
    self.currData=nil;
end

return this