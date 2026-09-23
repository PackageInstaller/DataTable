--主队列封装器

FightActionMainQueueBox = oo.class(FightActionBase);
local this = FightActionMainQueueBox;


function this:SetFightAction(fightAction)
    if(fightAction)then
        fightAction.queueType = QUEUE_TYPE.Curr; 
    end
    self.targetFightAction = fightAction;    
end

function this:OnPlay()        
    if(self.targetFightAction)then
        FightActionMgr:Push(self.targetFightAction);
        if(self.targetFightAction.OnPush)then
            self.targetFightAction:OnPush();            
        end
    end
    self:Complete();
end

function this:OnClean()   
    self.targetFightAction = nil;
end


return this;
