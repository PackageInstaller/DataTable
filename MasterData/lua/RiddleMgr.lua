local this = MgrRegister("RiddleMgr")
--猜谜管理
function this:Update(proto)
    if proto and next(proto)~=nil then
        self.datas=self.datas or {}
        local riddle,index=self:GetData(proto.id)
        if riddle~=nil then
            self.datas[index]:SetData(proto)
        else
            local info=RiddleActivityInfo.New();
            info:SetData(proto)
            table.insert(self.datas,info);
        end
        self:CheckReds()
    end
end

--登录完成之后发送，用于获取猜谜数据
function this:InitData()
    local cfg=Cfgs.CfgMenuLBtns:GetByID(13);
    if cfg and cfg.page then
        local cfg2=Cfgs.cfgQuestions:GetByID(cfg.page)
        if cfg2 then
            local curTime=TimeUtil:GetTime();
            local begTime=cfg2.begTime and TimeUtil:GetTimeStampBySplit(cfg2.begTime) or 0;
            local endTime=cfg2.endTime and TimeUtil:GetTimeStampBySplit(cfg2.endTime) or 0;
            if ((begTime~=0 and curTime>=begTime) or begTime==0) and ((endTime~=0 and curTime<endTime) or endTime==0) then
                OperateActiveProto:GetQuestionInfo(cfg.page);
            end
        end
    end
end

--更新回答缓存
function this:UpdataAnswer(proto)
    if proto then
        local _,index=self:GetData(proto.id);
        if index and self.datas[index] and self.datas[index].data then
            local key=nil;
            local tData=table.copy(self.datas[index].data);
            if tData.questionInfos then
                for k,v in ipairs(tData.questionInfos) do
                    if v.drawnQuestions==proto.drawnQuestions then
                        key=k;
                        break;
                    end
                end
                if key==nil or tData.questionInfos[key]==nil then
                    do return end;
                end
                tData.questionInfos[key].isTake=proto.res==true and 1 or 0;
                if proto.res==true then
                    tData.answerCnt=tData.answerCnt or 0;
                    tData.answerCnt=tData.answerCnt+1;
                    tData.timeStamp=TimeUtil:GetTime()+g_CloseQuestions;
                else
                    tData.timeStamp=TimeUtil:GetTime()+g_Questions;
                end
                self:SetTimer(tData.id,tData.timeStamp);
                -- if proto.res~=true then
                    tData.questionInfos[key].answers=tData.questionInfos[key].answers or nil
                    table.insert(tData.questionInfos[key].answers,proto.answerIndex);
                    self.datas[index]:SetData(tData)
                -- end
            end
        end
        self:CheckReds()
    end
end

function this:UpdateRewards(proto)
    if proto then
        local _,index=self:GetData(proto.id);
        if index and self.datas[index] and self.datas[index].data then
            local tData=table.copy(self.datas[index].data);
            tData.reward=proto.reward
            self.datas[index]:SetData(tData)
        end
        self:CheckReds()
    end
end

function this:GetData(id)
    if self.datas and id then
        for k, v in ipairs(self.datas) do
            if v:GetID()==id then
                v.data.timeStamp=self:GetTimer(id);
                return v,k;
            end
        end
    end
end

function this:SetTimer(id,timer)
    self.timers=self.timers or {};
    self.timers[id]=timer;
end

function this:GetTimer(id)
    if self.timers and self.timers[id] then
        return self.timers[id]
    end
end

function this:CheckReds()
    local infos=nil;
    for k, v in pairs(self.datas) do
        local redInfo=self:CheckRed(v:GetID());
        infos=infos or {};
        infos[v:GetID()]=redInfo;
    end
    RedPointMgr:UpdateData(RedPointType.Riddle,infos);
end

function this:CheckRed(id)
    local redInfo=nil;
    if id then
        local data=self:GetData(id)
        if data then
            local hasReward=false;
            local rewardCfg = data:GetRewardCfgs();
            if rewardCfg ~= nil then
                for k, v in ipairs(rewardCfg.item) do
                    if data:IsReivce(v.index)~=true and data:GetAnswerCnt()>=v.count then
                        hasReward=true;
                        break;
                    end
                end
            end
            redInfo=hasReward and true or nil;
        end
    end
    return redInfo;
end

function this:Clear()
    self.datas={}
    self.timers={};
end

function this:MenuLTime(page)
    if(not page)then 
        return 
    end 
    local begTime,endTime
    local activityData = self:GetData(page);
    if activityData then
        begTime = activityData:GetBegTime() and TimeUtil:GetTimeStampBySplit(activityData:GetBegTime()) or nil;
        endTime = activityData:GetEndTime() and TimeUtil:GetTimeStampBySplit(activityData:GetEndTime()) or nil;
    else
        local cfg2 = Cfgs.cfgQuestions:GetByID(page)
        if cfg2 then
            begTime = cfg2.begTime and TimeUtil:GetTimeStampBySplit(cfg2.begTime) or nil;
            endTime = cfg2.endTime and TimeUtil:GetTimeStampBySplit(cfg2.endTime) or nil;
        end
    end
    return begTime,endTime
end

return this