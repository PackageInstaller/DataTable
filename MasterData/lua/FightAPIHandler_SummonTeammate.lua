local this = {};

--处理召唤
function this:Handle(data)
    local fightAction = FightActionMgr:Apply(FightActionType.SummonTeammate,data);     

    local boxFightAction = FightActionMgr:Apply(FightActionType.MainQueueBox);  
    boxFightAction:SetFightAction(fightAction);
    return boxFightAction;
end

return this;