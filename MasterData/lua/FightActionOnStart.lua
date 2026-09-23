--战斗开始数据

FightActionOnStart = oo.class(FightActionBase);
local this = FightActionOnStart;

function this:OnPlay()    
    --LogError("战斗开始");
    if(FightClient:IsRestoreState())then
        self:Complete();   
    else        
        EventMgr.Dispatch(EventType.Fight_View_Setting,{closeNpValue = 1});
        FuncUtil:Call(self.ApplyComplete,self,100);
    end    
end

function this:ApplyComplete()
    self:Complete();    
end


--结束
function this:OnComplete()  
    EventMgr.Dispatch(EventType.Fight_View_Setting,{});
end


return this;
