local this = {};

--OverLoad
function this:Handle(data)   
    local fightAction = FightActionMgr:Apply(FightActionType.OverLoad,data);   
    return fightAction;
end

return this;