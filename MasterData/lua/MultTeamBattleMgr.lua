local this = MgrRegister("MultTeamBattleMgr")

function this:Init()
    -- self.curData=MultTeamBattleInfo.New();
    -- self.curData:SetData(
    --     {
    --         id=1,
    --         round=1,
    --         group=17001,
    --         arrCard={
    --             30490, --赤溟
    --             30480,--乌斯怀亚
    --             50041,--银羽
    --             71010,--总队长
    --             50030,--枪棘
    --             30080,--塔尔伯特
    --         },
    --     }
    -- );
end

function this:Update(proto)
    if self.curData then
        self.curData:SetData(proto);
    else
        local info=MultTeamBattleInfo.New();
        info:SetData(proto);
        self.curData=info;
    end
    self:CheckRedInfo();
    EventMgr.Dispatch(EventType.MTB_Data_Update);
end

function this:GetCurData()
    return self.curData or nil;
end

function this:GetBossInfoByCurData(dupId)
    local curData=self:GetCurData();
    if dupId and curData then
        return curData:GetBossInfo(dupId)
    end
    return nil;
end

function this:CardCanUse(cid)
    local canUse=true;
    local lID=nil;
    if cid and self.curData then
        canUse,lID=self.curData:CardCanUse(cid);
    end
    return canUse,lID;
end

function this:UpdateCurData(proto)
    if proto and self.curData then
        local data=self.curData:GetData();
        data.dupData=proto.dupData;
        data.arrPass=proto.arrPass;
        data.arrCard=proto.arrCard;
        self.curData:SetData(data)
    end
    self:CheckRedInfo();
    EventMgr.Dispatch(EventType.MTB_Data_Update);
end

function this:CheckRedInfo()
    local redInfo=nil;
    if self.curData then    --检测入场券获得任务的状态
        local hasTask=MissionMgr:CheckRed2(eTaskType.MultTeam,self.curData:GetMissionGroup());
        if hasTask then
            redInfo=redInfo or {};
            redInfo.isTask=true
        end
        --检测奖励可领取状态
        if self.curData:GetActivityState()==MultTeamActivityState.Settlement and self.curData:IsSettle()~=true then
            redInfo=redInfo or {};
            redInfo.hasReward=true;
        end
    end
    -- redInfo=redInfo or {};
    -- redInfo.isTask=true
    -- redInfo.hasReward=true;
    RedPointMgr:UpdateData(RedPointType.MultTeamBattle, redInfo)
    return redInfo;
end

function this:IsRed()
    local redInfo=RedPointMgr:GetData(RedPointType.MultTeamBattle)
    return redInfo~=nil;
end

function this:IsCommOpen(val)
    local curData=self:GetCurData();
    if curData and val then
        return curData:GetRound()>=val;
    end
    return false;
end

function this:Clear()
    self.curData=nil;
end

return this