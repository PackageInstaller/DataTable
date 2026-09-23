--回归绑定管理类
local this = MgrRegister("CollaborationMgr")

function this:Init()
    self:Clear()
    -- self.currActivity=CollaborationInfo.New();
    -- -- self.currActivity:InitCfg(1);
    -- self.currActivity:SetData({activeId=1,code="60028_123456"});
    self.skip=0;
    self.invitePage=0;
    --初始化下一次活动开始的时间
    self:SetNextActivityTime();
end

function this:InitData()
    RegressionProto:PlrBindInfo();
    RegressionProto:PlrBindInviteList(self.invitePage)
end

function this:Clear()
    self.currActivity=nil;
    self.nextBeginInfo=nil;
    self.nextEndInfo=nil;
    self.refreshTime=0;
    self.inviteTips=false;--绑定完成提示框
    self:CleanCache();
end

function this:CleanCache()
    self.skip=0;
    self.bindRecoments=nil;
    self.isBindFull=false;
    self.isIniviteFull=false;
    self.bindInivte=nil;
    self.invitePage=0;
    self.inviteOptions=nil;
    self.inviteList=nil;
    -- self.disOptions=nil;
end

function this:OnBindInfoRet(proto)
    self.currActivity=nil;
    if proto and next(proto)~=nil then
        local tempInfo=CollaborationInfo.New();
        tempInfo:SetData(proto);
        self.currActivity=tempInfo;
    end
    self:CheckRedInfo();
end

function this:OnBindOver(_d)
    if _d and _d.data and _d.data.isOk==true and _d.isMine and self.currActivity then
        self.inviteOptions=self.inviteOptions or{};
        self.inviteOptions[_d.data.beInviter]=1;
        --更新申请次数
        local _d=self.currActivity:GetData();
        if _d==nil then
            LogError("OnGainRewardRet Error 当前活动数据为空！");
            LogError(_d);
            do return end;
        end
        _d.applyCnt=_d.applyCnt+1;
        self.currActivity:SetData(_d)
    end
end

--记录绑定结果，成功才有
function this:RecordInvitRet(isInvitOver)
    self.inviteTips=isInvitOver;
end

function this:GetRecordInvitRet()
    return self.inviteTips or false;
end

--同意/拒绝别人邀请的返回
function this:OnInviteOptionRet(proto)
    if proto and self.currActivity then
        if proto.success and proto.isOk~=true then --拒绝的玩家列表
            if self.bindInivte~=nil then
                local key=nil;
                for k,v in ipairs(self.bindInivte) do
                    if v:GetUid()==proto.inviter then
                        key=k;
                        break;
                    end
                end
                if key~=nil then
                    table.remove(self.bindInivte,key);
                    self:RemoveInviteList(proto.inviter);
                end
            end
            self:CheckRedInfo();
            -- self.disOptions=self.disOptions or {};
            -- self.disOptions[proto.inviter]=1;
        end
    end
end

function this:OnStageTaskInfoRet(proto)
    if proto then
        local _d=self.currActivity:GetData();
        if _d==nil then
            LogError("OnStageTaskInfoRet Error 当前活动数据为空！");
            LogError(_d);
            do return end;
        end
        _d.stage=proto.stage;
        _d.doneTaskNum=proto.doneTaskNum;
        self.currActivity:SetData(_d)
    end
end

function this:IsIniviteMember(uid)
    if uid and self.inviteOptions and self.inviteOptions[uid] then
        return true;
    end
    return false;
end

-- function this:IsDisMember(uid)
--     if uid and self.disOptions and self.disOptions[uid] then
--         return true;
--     end
--     return false;
-- end

function this:OnGainRewardRet(proto)
    if proto and self.currActivity then
        local _d=self.currActivity:GetData();
        if _d==nil then
            LogError("OnGainRewardRet Error 当前活动数据为空！");
            LogError(_d);
            do return end;
        end
        _d.stage=proto.stage;
        _d.doneTaskNum=proto.doneTaskNum;
        self.currActivity:SetData(_d)
    end
    self:CheckRedInfo();
end

--设置下次活动开始的时间
function this:SetNextActivityTime()
    self.nextBeginInfo=nil;
    self.nextEndInfo=nil;
    local nextBeginNum=0;
    local nextEndNum=0
    for k,v in ipairs(Cfgs.CfgBindActive:GetAll()) do
        local tempInfo=CollaborationInfo.New();
        tempInfo:InitCfg(v.id);
        local currTime=TimeUtil:GetTime();
        if currTime<tempInfo:GetStartTimeStamp() then
            local beginNum=tempInfo:GetStartTimeStamp()-currTime;
            if self.nextBeginInfo==nil or nextBeginNum>beginNum then
                nextBeginNum=beginNum;
                self.nextBeginInfo=tempInfo;
            end
        end
        if currTime<tempInfo:GetEndTimeStamp() then
            local endNum=tempInfo:GetEndTimeStamp()-currTime;
            if self.nextEndInfo==nil or nextEndNum>endNum then
                nextEndNum=endNum;
                self.nextEndInfo=tempInfo;
            end
        end
    end
    -- if self.nextBeginInfo then
    --     LogError("NextBegin:"..tostring(self.nextBeginInfo:GetID()))
    -- end
    -- if self.nextEndInfo then
    --     LogError("NextEnd:"..tostring(self.nextEndInfo:GetID()))
    -- end
end

function this:GetNextBeginTime()
    if self.nextBeginInfo then
        return self.nextBeginInfo:GetStartTimeStamp();
    end
    return 0
end

function this:GetNextEndTime()
    if self.nextEndInfo then
        return self.nextEndInfo:GetEndTimeStamp();
    end
    return 0
end

--返回当前开放的活动信息
function this:GetCurrInfo()
    --查找当前开放的活动
    return self.currActivity;
end

function this:GetBindRecomentInfo()
    return self.bindRecoments;
end

function this:GetBindInviteInfo()
    return self.bindInivte;
end

--获取推荐列表返回
function this:BindRecomentUpdate(proto)
    if proto then
        self.bindRecoments=proto.page==0 and {} or self.bindRecoments;
        if  proto.friends  then
            self.skip=proto.page or 0;
            for k, v in ipairs(proto.friends) do
                local data = FriendInfo.New()
			    data:InitData(v)
                table.insert(self.bindRecoments,data);
            end
        end
        self.isBindFull=proto.isEnd;
        -- CollaborationMgr:CheckRedInfo();
    end
end

--获取被邀请列表返回
function this:BindInviteUpdate(proto)
    if proto then
        self.bindInivte=proto.page==0 and {} or self.bindInivte;
        if  proto.friends  then
            self.invitePage=proto.invitePage or 0;
            for k, v in ipairs(proto.friends) do
                local data = FriendInfo.New()
			    data:InitData(v)
                table.insert(self.bindInivte,data);
            end
        end
        CollaborationMgr:CheckRedInfo();
        self.isIniviteFull=proto.isEnd;
    end
end

--更新被邀请列表
function this:UpdateInviteList(proto)
    if proto and proto.inviter then
        -- LogError(proto)
        self.inviteList=self.inviteList or {}
        local has=false;
        for k, v in ipairs(self.inviteList) do
            if v==proto.inviter then
                has=true;
                break;
            end
        end
        if has==false then
            table.insert(self.inviteList,proto.inviter);
            self:CheckRedInfo();
        end
    end
end

function this:RemoveInviteList(id)
    if id and self.inviteList then
        local key=-1;
        for k, v in pairs(self.inviteList) do
            if v==id then
                key=k;
                break;
            end
        end
        if key>0 then
            table.remove(self.inviteList,key);
            self:CheckRedInfo();
        end
    end
end

--获取列表是否已经完整请求完
function this:IsListFull(type)
    if type==eBindInviteOpenType.Invite then
        return self.isBindFull;
    elseif type==eBindInviteOpenType.Request then
        return self.isIniviteFull;
    end
    return false;
end

--获取列表是否已经完整请求完
function this:GetListPageIdx(type)
    if type==eBindInviteOpenType.Invite then
        return self.skip;
    elseif type==eBindInviteOpenType.Request then
        return self.invitePage;
    end
    return 0
end

function this:GetNextInvitList(page)
    if self.isIniviteFull and page~=0  then
        do return end;
    end
    if page then
        self.invitePage=page;
        if page<=0 then
            self.bindInivte=nil
        elseif self.bindInivte then
            local startIdx=g_PlrBindListOnceCnt*page;
            if startIdx<#self.bindInivte then --从指定的页重新开始缓存
                for i=startIdx,#self.bindInivte do
                    table.remove(self.bindInivte,i);
                end
            end
        end
    else
        self.invitePage=self.invitePage+1;
    end
    RegressionProto:PlrBindInviteList(self.invitePage)
end

--检查红点信息
function this:CheckRedInfo()
    local redInfo=nil;
    --检查任务完成情况
    local currActivity=self:GetCurrInfo();
    if currActivity and not currActivity:IsBindOver() and ((self.bindInivte and #self.bindInivte>0) or (self.inviteList and #self.inviteList>0)) then
        redInfo={bind=1};
    end
    if currActivity and currActivity:IsLimitFull()~=true and currActivity:IsBindOver() then
        local taskInfo=MissionMgr:GetCollaborationData(eTaskType.RegressionBind);
        if taskInfo and #taskInfo>0 then
            for k,v in ipairs(taskInfo) do
                if v:IsGet()~=true and v:IsFinish() then
                    redInfo=redInfo or {}
                    redInfo.task=1;
                    break;
                end
            end
        end
        if currActivity:GetStageCanRevice() then
            redInfo=redInfo or {}
            redInfo.revice=1;
        end
    end
    RedPointMgr:UpdateData(RedPointType.Collaboration, redInfo)
end

function this:GetNextRecommentList(page)
    if self.isBindFull and page~=0 then
        do return end;
    end
    if page then
        self.skip=page;
        if page<=0 then
            self.bindRecoments=nil
        elseif self.bindRecoments then
            local startIdx=g_PlrBindListOnceCnt*page;
            if startIdx<#self.bindRecoments then --从指定的页重新开始缓存
                for i=startIdx,#self.bindRecoments do
                    table.remove(self.bindRecoments,i);
                end
            end
        end
    else
        self.skip=self.skip+1;
    end
    RegressionProto:PlrBindRecoment(self.skip)
end

--是否显示入口
function this:GetActivityTime()
    local info = self:GetCurrInfo()
    if(info) then 
        local begTime = info:GetStartTime()
        local endTime = info:GetEndTime()
        begTime = begTime and TimeUtil:GetTimeStampBySplit(begTime) or nil
        endTime = endTime and TimeUtil:GetTimeStampBySplit(endTime) or nil
        return begTime,endTime
    else
        return self:GetNextBeginTime(),self:GetNextEndTime();
    end 
end

function this:SetNextRefreshTime(time)
    self.refreshTime=time;
end

function this:GetNextRefreshTime()
    return self.refreshTime or 0;
end

return this
