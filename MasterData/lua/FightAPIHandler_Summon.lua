local this = {};

--处理召唤
function this:Handle(data)
    local fightAction = FightActionMgr:Apply(FightActionType.Summon,data);     
    return fightAction;
end

return this;