--战斗受击结果延迟结算

FightActionHitResult = oo.class(FightActionBase);
local this = FightActionHitResult;

function this:OnPlay()    
--    if(self:GetActorID())then      
--        CameraMgr:ApplyCommonAction(self,CameraActionMgr.round_event);        
--    end
    
    FuncUtil:Call(self.ApplyStart,self,1500);
end

function this:ApplyStart()
    self:Complete();
end

return this;
