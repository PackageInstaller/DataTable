local this = {};

--处理解体
function this:Handle(data)
    local fightAction = FightActionMgr:Apply(FightActionType.ComboBreak,data);     
    local boxFightAction = FightActionMgr:Apply(FightActionType.MainQueueBox);  
    boxFightAction:SetFightAction(fightAction);
    return boxFightAction;
end

return this;