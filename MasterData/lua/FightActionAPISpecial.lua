FightActionAPISpecial = oo.class(FightActionAPI);
local this = FightActionAPISpecial;

function this:OnClean()
    FightActionAPI.OnClean(self);
    self.faHelp = nil;
end

--添加子FightAction
function this:PushSub(fightAction,order) 
    if not fightAction then
        return;
    end
    local fightActionType = fightAction:GetType();
    if(fightActionType == FightActionType.Skill)then
        if(fightAction:IsHelp())then
            self.faHelp = fightAction;
        else
            LogError("协战bug，先打个日志！！！")
            LogError(self.data);
            LogError(self.fightAction.data);
        end
        return; 
    end     
    
    FightActionAPI.PushSub(self,fightAction,order);       
end

function this:OnPlay()
    FightActionMgr:Pause();  
    local currFA = FightActionMgr:GetCurr();
    if(currFA and currFA.IsSkillComplete and not currFA:IsSkillComplete())then
    else
        self:PushSub(FightActionMgr:Apply(FightActionType.DeadChecker),4);
    end 
    
    FightActionAPI.OnPlay(self);
end

function this:OnComplete()    
    FightActionMgr:Continue();
    FightActionAPI.OnComplete(self);
end

function this:GetHelp()
    return self.faHelp;
end

return this;
