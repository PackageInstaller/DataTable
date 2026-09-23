local this = {};

--处理API事件
function this:Handle(data)
    --LogError("API数据=========================");
    --LogError(data);
    local fightAction = FightActionMgr:Apply(FightActionType.API,data);   
    return fightAction;
end

return this;