FightActionBase = oo.class();

local this = FightActionBase;

--获取类型
function this:GetType()
    return self.actionType;
end
--设置类型
function this:SetType(fightActionType)
    self.actionType = fightActionType;
end

--设置数据
function this:SetData(fightActionData)
    self:Clean();
    if(fightActionData == nil)then
        LogError("FightAction数据为空！！！");
        LogError(a.b);
    end
    self.data = fightActionData;
end

--获取数据
function this:GetData()
    return self.data;
end

--清除
function this:Clean()
    self.data = nil;
    self.completeCallBack = nil;
    self.caller = nil;
    self.applyed = nil;
    self.order = nil;
    self.queueType = nil;
    self.faParent = nil;
    self.apiSetting = nil;
    if(self.subs)then
        for _,subFightAction in ipairs(self.subs)do
            FightActionMgr:Recycle(subFightAction);
        end
    end
    self.subs = nil;

    self:OnClean();
       
    --self.runningSubFightAction = nil;
    self.isComplete = nil;    


--    if(self.watchdog)then
--        CSAPI.RemoveGO(self.watchdog);
--        self.watchdog = nil;
--    end
end
function this:OnClean()
    
end

function this:GetAPIName()
    return self.data and self.data.api;
end

--获取API设置
function this:GetAPISetting()
    if(self.apiSetting == nil and self.data)then
        local apiSettingId = self.data.effectID;
        if(apiSettingId)then
            self.apiSetting = Cfgs.APISetting:GetByID(apiSettingId);
        end
    end
    return self.apiSetting;
end


--播放
function this:Play(callBack,caller)
--    -------------------测试代码-------------------
--    local str = FightActionTypeDesc[self:GetType()] or "no name";
--    self.watchdog = CS.FightActionWatchdog.Create(str);
--    ComUtil.GetLuaTable(self.watchdog).Set(self);
    -------------------测试代码-------------------

--    if(self.data)then
--        LogError("FightAction执行=================" .. tostring(self.data.api) .. "\n" .. table.tostring(self.data));
--    end
    self.completeCallBack = callBack;
    self.caller = caller;
    self:OnPlay();  
end

--播放时调用
function this:OnPlay(callBack)    
end

--结束
function this:Complete()
    if(self.isComplete)then
        return;
    end

--    LogError("fight action完成=================" .. FightActionTypeDesc[self.actionType]);
--    LogError(self.data);
    if(self:HandleSubList())then
        return;
    end
    
--    DebugLog("FightAction执行完成，类型：" ..  FightActionTypeDesc[self.actionType]);
--    DebugLog(self.data);

--    if(self.data and self.data.api == APIType.OnBorn)then
--        LogError("执行完成=======================\n" .. table.tostring(self.data));
--    end

    self.isComplete = 1;    
    self:OnComplete();
    self:CompleteCallBack();
end
function this:OnComplete()

end


function this:CompleteCallBack()
    local callBack = self.completeCallBack;
    if(callBack)then        
        if(self.caller)then
            callBack(self.caller,self);
        else
            callBack(self);
        end        
    else
        FightActionMgr:Recycle(self);
    end
end

--设置父FightAction
function this:SetParent(fightAction)
    self.faParent = fightAction;
end

function this:IsDead()
    return self.data and self.data.death;
end

--添加子FightAction
function this:PushSub(fightAction,order)
    if(not fightAction)then
        return;
    end

    self.subs = self.subs or {};
    fightAction.order = order or fightAction.order or 1;
    table.insert(self.subs,fightAction);
end


--执行子FightAction
function this:HandleSubList()   
    local subList = self.subs;
    if(subList == nil or #subList == 0)then
        return false;
    end

    local order = nil;
    local targetFightAction = nil;
    for _,subFightAction in ipairs(subList)do
        if(subFightAction.applyed == nil)then
            if(order == nil or order > subFightAction.order)then
                order = subFightAction.order;
                targetFightAction = subFightAction;
            end
        end
    end
   
    if(targetFightAction)then
--        if(self.data and (self.data.api == APIType.APIs or self.data.api == "OnActionOver"))then
--            LogError("执行子FightAction=======================" .. FightActionTypeDesc[targetFightAction:GetType()] .. "\n" .. table.tostring(targetFightAction:GetData()));
--        end

        --LogError(targetFightAction.data);
        targetFightAction.applyed = 1;
        targetFightAction:Play(self.OnSubCallBack,self);
        --self.runningSubFightAction = targetFightAction;
        return true;
    else
        return false;
    end      
end

function this:OnSubCallBack(subFightAction)   
--    if(subFightAction)then
--        DebugLog("子FightAction执行完成==================" .. FightActionTypeDesc[subFightAction.actionType]);
--        DebugLog(subFightAction);
--    else
--        LogError("空子对象完成？");
--        LogError(self);
--    end
    --self.runningSubFightAction = nil;
    self:Complete();    
end

function this:GetActorID()
    return self.data and self.data.id;
end
--获取行动者
function this:GetActorCharacter()
    local actorId = self:GetActorID();
    if(actorId)then
        return CharacterMgr:Get(actorId);
    end
    return nil;
end

function this:GetTargetID()
    return self.data and self.data.targetID;
end
--获取目标
function this:GetTargetCharacter()
    local targetId = self:GetTargetID();
    if(targetId)then
        return CharacterMgr:Get(targetId);
    end
end

--计算位置
function this:Calculate(posData,targetCharacter)

--    DebugLog("获取位置信息===============================================");
--    DebugLog(posData);
--    DebugLog(self.data);
--    DebugLog(self);

    local actionCharacter = self:GetActorCharacter();
    targetCharacter = targetCharacter or self:GetTargetCharacter();


--    local rowIndex = nil;
--    local colIndex = nil;
--    if(self.data and self.data.grid)then
--        rowIndex = self.data.grid.row;
--        colIndex = self.data.grid.col;
--    end
    

    local x,y,z = FightPosRefUtil:Calculate(posData,actionCharacter,targetCharacter,self);    
   
    return x,y,z;
end

--获取信息
function this:GetInfo()
    local info = self.data and table.tostring(self.data) or table.tostring(self);
    info = info .. "\n" .. self:GetSubInfo();
    return info;
end

function this:GetSubInfo()
    local subList = self.subs;
    local subInfo = "子FightAction列表";
    if (subList == nil) then
        subInfo = "无子FightAction";
    else
        for _,subFightAction in ipairs(subList)do
            local str = "======================================================";
            str = "\n数据：" .. table.tostring(subFightAction:GetData());        
            str = str .. "\n执行状态：" .. (subFightAction.applyed and "是" or "否");
            str = str .. "\n完成状态：" .. (subFightAction.isComplete and "是" or "否");
        
            subInfo = subInfo .. "\n" .. str;
        end
    end


    return subInfo;
end

--获取镜头修正距离
function this:GetCameraAddHeight(posRef)
    local character = self:GetActorCharacter();
    if(character)then       
        return character.GetCameraAddHeight();
    end
    return 0;
end


return this;
