local this = {};

--处理API组事件
function this:Handle(data)
    --LogError("API数据=========================");
    --LogError(data);
    local fightAction = FightActionMgr:Apply(FightActionType.API,data);
    FightActionUtil:HanderSubFightAction(fightAction,data.datas);
    return fightAction;
end

return this;