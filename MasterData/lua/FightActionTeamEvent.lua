--战斗队伍事件结算

FightActionTeamEvent = oo.class(FightActionBase);
local this = FightActionTeamEvent;

function this:OnPlay()    
    if(self:GetActorID())then      
        --CameraMgr:ApplyCommonAction(self,CameraActionMgr.round_event);
        FuncUtil:Call(self.ApplyStart,self,500);
        return;
    end
    
    self:ApplyStart();
end

function this:ApplyStart()
    self:Complete();
end


--结束
function this:Complete()
    if(self:HandleSubList())then
        return;
    end
    
--    DebugLog("FightAction执行完成，类型：" ..  FightActionTypeDesc[self.actionType]);
--    DebugLog(self.data);    

    FuncUtil:Call(self.OnComplete,self,500);   
end

function this:OnComplete()
    self.isComplete = 1;    
    self:CompleteCallBack();
end

--执行子FightAction(不同目标可以同时执行)
function this:HandleSubList()   
    local subList = self.subs;
    if(subList == nil or #subList == 0)then
        return false;
    end

    self.runningSubs = self.runningSubs or {};

    for _,subFightAction in ipairs(subList)do
        if(subFightAction.applyed == nil)then
            local targetID = subFightAction:GetTargetID();
            if(targetID == nil or self.runningSubs[targetID] == nil)then
                if(targetID)then
                    self.runningSubs[targetID] = subFightAction;
                end

                subFightAction.applyed = 1;
                subFightAction:Play(self.OnSubCallBack,self);                
            end
        end
    end
   
    for _,v in pairs(self.runningSubs)do
        if(v)then
            return true;
        end
    end

    return false;
end

function this:OnSubCallBack(subFightAction)   
    local targetID = subFightAction:GetTargetID();
    if(targetID)then
        self.runningSubs[targetID] = nil;
    end

    FightActionBase.OnSubCallBack(self,subFightAction);
end

return this;
