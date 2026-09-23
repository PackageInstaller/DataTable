local this = {};

--处理死亡
function this:Handle(data)
    local fightAction = FightActionMgr:Apply(FightActionType.Dead);
    return fightAction;
end

return this;