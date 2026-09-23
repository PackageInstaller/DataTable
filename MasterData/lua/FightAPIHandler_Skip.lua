local this = {};

--处理Skip事件
function this:Handle(data)
    --LogError("API数据=========================");
    --LogError(data);
    local fightAction = FightActionMgr:Apply(FightActionType.Skip,data);   
    return fightAction;
end

return this;